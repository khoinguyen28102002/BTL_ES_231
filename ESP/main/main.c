#include <freertos/FreeRTOS.h>
#include <freertos/task.h>
#include <freertos/semphr.h>
#include <driver/gpio.h>
#include <freertos/timers.h>
#include <driver/uart.h>
#include <driver/adc.h>
#include <string.h>

#define DHT_PIN GPIO_NUM_14  // Replace with the actual GPIO pin connected to DHT11
#define COM_PORT UART_NUM_0 // Replace with the actual UART port you are using
#define TXD_PIN GPIO_NUM_17 // Replace with the actual TXD pin connected to the gateway
#define RXD_PIN GPIO_NUM_16 // Replace with the actual RXD pin connected to the gateway
#define LIGHT_SENSOR_PIN GPIO_NUM_4
#define FAN_PIN GPIO_NUM_19 // Replace with the actual GPIO pin connected to the fan
#define LED_PIN GPIO_NUM_18
SemaphoreHandle_t xSemaphore;
static const int RX_BUF_SIZE = 1024; 

static int dht_read_data(uint8_t *humidity, uint8_t *temperature)
{
    // Function to read data from DHT11 sensor
    // Initialize variables
    
    uint8_t data[5] = {0};
    uint8_t checksum = 0;

    // Start signal
    esp_rom_gpio_pad_select_gpio(DHT_PIN);
    // gpio_set_direction(DHT_PIN, GPIO_MODE_OUTPUT);
    // gpio_set_level(DHT_PIN, 0);
    // ets_delay_us(20 * 1000);  // 20ms
    // vTaskDelay(20 / portTICK_PERIOD_MS);
    // gpio_set_level(DHT_PIN, 1);
    // vTaskDelay(20 / portTICK_PERIOD_MS);
    // ets_delay_us(30);  // Wait for DHT response
    
    // DHT response
    gpio_set_direction(DHT_PIN, GPIO_MODE_INPUT);

    // Wait for the sensor to pull the line low
    int timeout = 0;
    while (gpio_get_level(DHT_PIN) == 1)
    {
        vTaskDelay(1 / portTICK_PERIOD_MS);
        timeout++;
        if (timeout > 20)
        {
            return -1; // Timeout waiting for response
        }
    }

    // Wait for the sensor to pull the line high
    timeout = 0;
    while (gpio_get_level(DHT_PIN) == 0)
    {
        vTaskDelay(1 / portTICK_PERIOD_MS);
        timeout++;
        if (timeout > 80)
        {
            return -1; // Timeout waiting for response
        }
    }

    // Wait for the sensor to pull the line low again
    timeout = 0;
    while (gpio_get_level(DHT_PIN) == 1)
    {
        vTaskDelay(1 / portTICK_PERIOD_MS);
        timeout++;
        if (timeout > 80)
        {
            return -1; // Timeout waiting for response
        }
    }

    // Read data from the sensor
    for (int i = 0; i < 5; i++)
    {
        for (int j = 7; j >= 0; j--)
        {
            timeout = 0;
            while (gpio_get_level(DHT_PIN) == 0)
            {
                vTaskDelay(1 / portTICK_PERIOD_MS);
                timeout++;
                if (timeout > 80)
                {
                    return -1; // Timeout waiting for response
                }
            }

            // Record the length of the high signal
            int duration = 0;
            while (gpio_get_level(DHT_PIN) == 1)
            {
                vTaskDelay(1 / portTICK_PERIOD_MS);
                duration++;
                if (duration > 100)
                {
                    return -1; // Timeout waiting for response
                }
            }

            // Use the length of the high signal to determine the bit value
            if (duration > 50)
            {
                data[i] |= (1 << j);
            }
        }
    }

    // Verify checksum
    checksum = data[0] + data[1] + data[2] + data[3];
    if (checksum != data[4])
    {
        return -1; // Checksum error
    }

    // Assign data to output variables
    *humidity = data[0];
    *temperature = data[2];

    return 0; // Success
}

static void uart_send(const char *data)
{
    // Function to send data over UART
    // printf("%s\n", data);
    uart_write_bytes(COM_PORT, data, strlen(data));
}

static void dht_task(void *pvParameter)
{
    while (1)
    {
        xSemaphoreTake(xSemaphore, portMAX_DELAY);

        uint8_t humidity, temperature;
        if (dht_read_data(&humidity, &temperature) == 0)
        {
            // Format the data as a string
            char dht_data[50];
            snprintf(dht_data, sizeof(dht_data), "!1:T:%u#", temperature); // Temperature frame
            snprintf(dht_data, sizeof(dht_data), "!1:H:%u#", humidity);    // Humidity frame
            // Send data to gateway via UART
            uart_send(dht_data);
        }
        else
        {
            printf("Failed to read DHT data\n");
        }

        xSemaphoreGive(xSemaphore);
        vTaskDelay(10000 / portTICK_PERIOD_MS); // Delay for 2 seconds
    }
}

static void light_sensor_task(void *pvParameter)
{
    while (1)
    {
        xSemaphoreTake(xSemaphore, portMAX_DELAY);
        uint16_t light_value = adc1_get_raw(LIGHT_SENSOR_PIN);

        char light_data[50];
        snprintf(light_data, sizeof(light_data), "!1:L:%u#", light_value); // Light sensor frame
        // printf(light)
        uart_send(light_data);

        xSemaphoreGive(xSemaphore);
        vTaskDelay(10000 / portTICK_PERIOD_MS); // Delay for 2 seconds
    }
    vTaskDelete(NULL);
}

// static void fan_task(void *pvParameter)
// {
//     // gpio_set_direction(FAN_PIN, GPIO_MODE_OUTPUT);
//     // gpio_set_level(FAN_PIN, 1);
//     char *data = (char *)malloc(2);

//     while (1)
//     {
//         int len = uart_read_bytes(COM_PORT, data, 1, 100 / portTICK_PERIOD_MS); // Leave space for the null terminator
//         if (len > 0)
//         {
//             if (data == '3')
//             {
//                 gpio_set_level(FAN_PIN, 0);
//             }
//             else if (data == '4')
//             {
//                 gpio_set_level(FAN_PIN, 1);
//             }
//             vTaskDelay(100 / portTICK_PERIOD_MS);
//         }
//     }
// }
/* Control led task*/
static void control_fan_task(void *arg)
{
    // static const char *RX_TASK_TAG = "RX_TASK";
    // esp_log_level_set(RX_TASK_TAG, ESP_LOG_INFO);
    char* data = (char*) malloc(RX_BUF_SIZE+1); 
    while (1) {
        const int rxBytes = uart_read_bytes(COM_PORT, data, RX_BUF_SIZE, 1000 / portTICK_PERIOD_MS);
        if (rxBytes > 0) {
            data[rxBytes] = 0; /*add the string terminator charater*/
            // ESP_LOGI(RX_TASK_TAG, "Read %d bytes: '%s'", rxBytes, data);
            // ESP_LOG_BUFFER_HEXDUMP(RX_TASK_TAG, data, rxBytes, ESP_LOG_INFO);
        }
        printf("value of input: %s\n", data);
        if(strcmp(data, "3") == 0)
        {
            /*Turn off the light*/
            gpio_set_level(FAN_PIN, 0);
        }
        else if(strcmp(data, "4") == 0)
        {
            /*Turn on the light*/
            gpio_set_level(FAN_PIN, 1);
        }
    }
    free(data);
}
static void control_led_task(void *arg)
{
    // static const char *RX_TASK_TAG = "RX_TASK";
    // esp_log_level_set(RX_TASK_TAG, ESP_LOG_INFO);
    char* data = (char*) malloc(RX_BUF_SIZE+1); 
    while (1) {
        const int rxBytes = uart_read_bytes(COM_PORT, data, RX_BUF_SIZE, 1000 / portTICK_PERIOD_MS);
        if (rxBytes > 0) {
            data[rxBytes] = 0; /*add the string terminator charater*/
            // ESP_LOGI(RX_TASK_TAG, "Read %d bytes: '%s'", rxBytes, data);
            // ESP_LOG_BUFFER_HEXDUMP(RX_TASK_TAG, data, rxBytes, ESP_LOG_INFO);
        }
        // printf("value of input: %s\n", data);
        if(strcmp(data, "1") == 0)
        {
            /*Turn off the light*/
            gpio_set_level(LED_PIN, 0);
        }
        else if(strcmp(data, "2") == 0)
        {
            /*Turn on the light*/
            gpio_set_level(LED_PIN, 1);
        }else if(strcmp(data, "3") == 0)
        {
            /*Turn off the light*/
            gpio_set_level(FAN_PIN, 0);
        }
        else if(strcmp(data, "4") == 0)
        {
            /*Turn on the light*/
            gpio_set_level(FAN_PIN, 1);
        }
    }
    free(data);
    vTaskDelete(NULL);
}
void app_main()
{
    xSemaphore = xSemaphoreCreateMutex();

    // Configure DHT_PIN as an input initially
    gpio_config_t io_conf = {
        .pin_bit_mask = (1ULL << DHT_PIN),
        .mode = GPIO_MODE_INPUT,
    };
    gpio_config(&io_conf);
    gpio_set_direction(LED_PIN, GPIO_MODE_OUTPUT);
    gpio_set_level(LED_PIN, 0);
    gpio_set_direction(FAN_PIN, GPIO_MODE_OUTPUT);
    gpio_set_level(FAN_PIN, 0);

    // Configure UART parameters
    uart_config_t uart_config = {
        .baud_rate = 115200,
        .data_bits = UART_DATA_8_BITS,
        .parity = UART_PARITY_DISABLE,
        .stop_bits = UART_STOP_BITS_1,
        .flow_ctrl = UART_HW_FLOWCTRL_DISABLE};
    uart_param_config(COM_PORT, &uart_config);
    uart_set_pin(COM_PORT, TXD_PIN, RXD_PIN, UART_PIN_NO_CHANGE, UART_PIN_NO_CHANGE);
    uart_driver_install(COM_PORT, 256, 0, 0, NULL, 0);

    // // Create task for DHT sensor
    // xTaskCreate(&dht_task, "dht_task", 2048, NULL, 3, NULL);
    
    // xTaskCreate(control_fan_task, "fan_task", 2048, NULL, configMAX_PRIORITIES-2, NULL);
    xTaskCreate(control_led_task, "uart_rx_task", 1024*2, NULL, configMAX_PRIORITIES, NULL);
    vTaskDelay(2000 / portTICK_PERIOD_MS);
    xTaskCreate(&light_sensor_task, "light_sensor_task", 2048, NULL, 3, NULL);
}