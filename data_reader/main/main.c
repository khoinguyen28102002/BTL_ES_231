#include <freertos/FreeRTOS.h>
#include <freertos/task.h>
#include <freertos/semphr.h>
#include <driver/gpio.h>
#include <freertos/timers.h>
#include <driver/uart.h>
#include <string.h>
#define DHT_PIN GPIO_NUM_1   // Replace with the actual GPIO pin connected to DHT11
#define COM_PORT UART_NUM_2  // Replace with the actual UART port you are using
#define TXD_PIN GPIO_NUM_17  // Replace with the actual TXD pin connected to the gateway
#define RXD_PIN GPIO_NUM_16  // Replace with the actual RXD pin connected to the gateway

SemaphoreHandle_t xSemaphore;

static int dht_read_data(uint8_t *humidity, uint8_t *temperature) {
    // Function to read data from DHT11 sensor
    // Initialize variables
    uint8_t data[5] = {0};
    uint8_t checksum = 0;

    // Start signal
    gpio_set_direction(DHT_PIN, GPIO_MODE_OUTPUT);
    gpio_set_level(DHT_PIN, 0);
    //ets_delay_us(20 * 1000);  // 20ms
    vTaskDelay(20 / portTICK_PERIOD_MS);
    gpio_set_level(DHT_PIN, 1);
    vTaskDelay(20 / portTICK_PERIOD_MS);
    //ets_delay_us(30);  // Wait for DHT response

    // DHT response
    gpio_set_direction(DHT_PIN, GPIO_MODE_INPUT);

    // Wait for the sensor to pull the line low
    int timeout = 0;
    while (gpio_get_level(DHT_PIN) == 1) {
        vTaskDelay(1 / portTICK_PERIOD_MS);
        timeout++;
        if (timeout > 20) {
            return -1;  // Timeout waiting for response
        }
    }

    // Wait for the sensor to pull the line high
    timeout = 0;
    while (gpio_get_level(DHT_PIN) == 0) {
        vTaskDelay(1 / portTICK_PERIOD_MS);
        timeout++;
        if (timeout > 80) {
            return -1;  // Timeout waiting for response
        }
    }

    // Wait for the sensor to pull the line low again
    timeout = 0;
    while (gpio_get_level(DHT_PIN) == 1) {
        vTaskDelay(1 / portTICK_PERIOD_MS);
        timeout++;
        if (timeout > 80) {
            return -1;  // Timeout waiting for response
        }
    }

    // Read data from the sensor
    for (int i = 0; i < 5; i++) {
        for (int j = 7; j >= 0; j--) {
            timeout = 0;
            while (gpio_get_level(DHT_PIN) == 0) {
                vTaskDelay(1 / portTICK_PERIOD_MS);
                timeout++;
                if (timeout > 80) {
                    return -1;  // Timeout waiting for response
                }
            }

            // Record the length of the high signal
            int duration = 0;
            while (gpio_get_level(DHT_PIN) == 1) {
                vTaskDelay(1 / portTICK_PERIOD_MS);
                duration++;
                if (duration > 100) {
                    return -1;  // Timeout waiting for response
                }
            }

            // Use the length of the high signal to determine the bit value
            if (duration > 50) {
                data[i] |= (1 << j);
            }
        }
    }

    // Verify checksum
    checksum = data[0] + data[1] + data[2] + data[3];
    if (checksum != data[4]) {
        return -1;  // Checksum error
    }

    // Assign data to output variables
    *humidity = data[0];
    *temperature = data[2];

    return 0;  // Success
}

static void uart_send(const char *data) {
    // Function to send data over UART
    uart_write_bytes(COM_PORT, data, strlen(data));
}

static void dht_task(void *pvParameter) {
    while (1) {
        xSemaphoreTake(xSemaphore, portMAX_DELAY);
        
        uint8_t humidity, temperature;
        if (dht_read_data(&humidity, &temperature) == 0) {
            // Format the data as a string
            char dht_data[50];
            snprintf(dht_data, sizeof(dht_data), "DHT Data: Humidity=%u%%, Temperature=%u°C\n", humidity, temperature);

            // Send data to gateway via UART
            uart_send(dht_data);
        } else {
            printf("Failed to read DHT data\n");
        }
        
        xSemaphoreGive(xSemaphore);
        vTaskDelay(2000 / portTICK_PERIOD_MS);  // Delay for 2 seconds
    }
}

void app_main() {
    xSemaphore = xSemaphoreCreateMutex();

    // Configure DHT_PIN as an input initially
    gpio_config_t io_conf = {
        .pin_bit_mask = (1ULL<<DHT_PIN),
        .mode = GPIO_MODE_INPUT,
    };
    gpio_config(&io_conf);

    // Configure UART parameters
    uart_config_t uart_config = {
        .baud_rate = 115200,
        .data_bits = UART_DATA_8_BITS,
        .parity    = UART_PARITY_DISABLE,
        .stop_bits = UART_STOP_BITS_1,
        .flow_ctrl = UART_HW_FLOWCTRL_DISABLE
    };
    uart_param_config(COM_PORT, &uart_config);
    uart_set_pin(COM_PORT, TXD_PIN, RXD_PIN, UART_PIN_NO_CHANGE, UART_PIN_NO_CHANGE);
    uart_driver_install(COM_PORT, 256, 0, 0, NULL, 0);

    // Create task for DHT sensor
    xTaskCreate(&dht_task, "dht_task", 2048, NULL, 5, NULL);
}
