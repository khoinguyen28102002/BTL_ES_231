#include <freertos/FreeRTOS.h>
#include <freertos/task.h>
#include <freertos/semphr.h>
#include <driver/gpio.h>
#include <freertos/timers.h>
#include <driver/uart.h>
#include <driver/adc.h>
#include <string.h>
#include "DHT.h"
#include "i2c-lcd.h"
#include "driver/i2c.h"
#include "driver/rtc_io.h"

#define I2C_MASTER_PORT I2C_NUM_0
#define SDA_PIN GPIO_NUM_21 
#define SCL_PIN GPIO_NUM_22
#define DHT_PIN GPIO_NUM_14
#define COM_PORT UART_NUM_2 // Replace with the actual UART port you are using
#define TXD_PIN GPIO_NUM_17 // Replace with the actual TXD pin connected to the gateway
#define RXD_PIN GPIO_NUM_16 // Replace with the actual RXD pin connected to the gateway
#define LIGHT_SENSOR_PIN GPIO_NUM_4
#define FAN_PIN GPIO_NUM_19 // Replace with the actual GPIO pin connected to the fan
#define LED_PIN GPIO_NUM_18
#define PIR_PIN GPIO_NUM_23

SemaphoreHandle_t xSemaphore;
static const int RX_BUF_SIZE = 1024; 

int isLightNow = 0;
int flagLight = 0;
char buffer[100];

static void uart_send(const char *data)
{
    // Function to send data over UART
    uart_write_bytes(COM_PORT, data, strlen(data));
}

#if defined(CONFIG_EXAMPLE_TYPE_DHT11)
#define SENSOR_TYPE DHT_TYPE_DHT11
#endif
static void dht_task(void *pvParameter)
{
   float temperature, humidity;

    #ifdef CONFIG_EXAMPLE_INTERNAL_PULLUP
        gpio_set_pull_mode(dht_gpio, GPIO_PULLUP_ONLY);
    #endif
    while (1)
    {
        if (dht_read_float_data(DHT_TYPE_DHT11, DHT_PIN, &humidity, &temperature) == ESP_OK){
            char dht_data[50];
            snprintf(dht_data, sizeof(dht_data), "!1:T:%.1f#", temperature); // Temperature frame
            uart_send(dht_data);
            snprintf(dht_data, sizeof(dht_data), "!1:H:%.1f#", humidity);    // Humidity frame
            uart_send(dht_data);
            // Display value read from DHT11 to LCD
            sprintf(buffer, "TEMP:%.1f*C ", temperature);
            lcd_put_cur(0, 0); 
            lcd_send_string(buffer);
            sprintf(buffer, "HUMI:%.1f%% ", humidity);
            lcd_put_cur(1, 0); 
            lcd_send_string(buffer);
        }
        else{
            printf("Could not read data from sensor\n");
        }
        vTaskDelay(30000 / portTICK_PERIOD_MS);  // Delay for 30 seconds
    }
}


static void light_sensor_task(void *pvParameter)
{
    while (1)
    {
        xSemaphoreTake(xSemaphore, portMAX_DELAY);
        uint16_t light_value = adc1_get_raw(LIGHT_SENSOR_PIN);

        char light_data[50];
        snprintf(light_data, sizeof(light_data), "!1:L:%u#", light_value);
        uart_send(light_data);

        xSemaphoreGive(xSemaphore);
        vTaskDelay(30000 / portTICK_PERIOD_MS); // Delay for 30 seconds
    }
    vTaskDelete(NULL);
}

static esp_err_t i2c_master_init(void)
{
    i2c_config_t conf = {
        .mode = I2C_MODE_MASTER,
        .sda_io_num = SDA_PIN,
        .scl_io_num = SCL_PIN,
        .sda_pullup_en = GPIO_PULLUP_ENABLE,
        .scl_pullup_en = GPIO_PULLUP_ENABLE,
        .master.clk_speed = 100000,
    };

    i2c_param_config(I2C_MASTER_PORT, &conf);
    return i2c_driver_install(I2C_MASTER_PORT, conf.mode, 0, 0, 0);
}

void ControlLedByPIR(void* parameter)
{
    /************************************************
    CONFIG PIR
    ************************************************/
    /*Enable GPIO function for pin*/
    esp_rom_gpio_pad_select_gpio(PIR_PIN);    
    /*Set pin as input*/       
    gpio_set_direction(PIR_PIN, GPIO_MODE_INPUT);  
    /*Enable pull up resistor for gpio input pin*/
    gpio_set_pull_mode(PIR_PIN, GPIO_PULLDOWN_ONLY);
    int PIR_level = 0;
    while(1)
    {
        PIR_level = gpio_get_level(PIR_PIN);
        if (PIR_level == 1){
            /*PIR is pressed -> turn on the led*/
            gpio_set_level(LED_PIN, 1); /*Turn on the led*/
            flagLight = 1;
            /*send data to gateway*/
            char pir_data[50];
            snprintf(pir_data, sizeof(pir_data), "!1:M:%u#", 1); // Light sensor frame
            // printf(light_data);
            uart_send(pir_data);
            //TODO
            vTaskDelay(5000 / portTICK_PERIOD_MS); 
        }
        else
        {
            /*PIR is not pressed -> turn off the led*/
            gpio_set_level(LED_PIN, 0);
            flagLight = 0;
            /*send data to gateway*/
            char pir_data[50];
            snprintf(pir_data, sizeof(pir_data), "!1:M:%u#", 0); 
            uart_send(pir_data);
            vTaskDelay(5000 / portTICK_PERIOD_MS); 
        }
    }
}

/* Control device task*/
int isLightNow = 0;
int flagLight = 0;
static void control_device_task(void *arg)
{
    char* data = (char*) malloc(RX_BUF_SIZE+1); 
    while (1) {
        const int rxBytes = uart_read_bytes(UART_NUM_2, data, RX_BUF_SIZE, 1000 / portTICK_PERIOD_MS);
        if (rxBytes > 0) {
            data[rxBytes] = 0; /*add the string terminator charater*/
        }
        if(strcmp(data, "1") == 0)
        {
            /*Turn off the light*/
            gpio_set_level(LED_PIN, 0);
            memset(data, 0, RX_BUF_SIZE+1);
            isLightNow = 0;
            flagLight = 0;
        }
        else if(strcmp(data, "2") == 0)
        {
            /*Turn on the light*/
            gpio_set_level(LED_PIN, 1);
            memset(data, 0, RX_BUF_SIZE+1);
            isLightNow = 1;
            flagLight = 1;
        }else if(strcmp(data, "3") == 0)
        {
            /*Turn of the light*/
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

void uart_config(void) {
    const uart_config_t uart_config = {
        .baud_rate = 115200,
        .data_bits = UART_DATA_8_BITS,
        .parity = UART_PARITY_DISABLE,
        .stop_bits = UART_STOP_BITS_1,
        .flow_ctrl = UART_HW_FLOWCTRL_DISABLE,
        .source_clk = UART_SCLK_DEFAULT,
    };
    // We won't use a buffer for sending data.
    uart_driver_install(UART_NUM_2, RX_BUF_SIZE * 2, 0, 0, NULL, 0);
    uart_param_config(UART_NUM_2, &uart_config);
    uart_set_pin(UART_NUM_2, TXD_PIN, RXD_PIN, UART_PIN_NO_CHANGE, UART_PIN_NO_CHANGE);
}

void app_main()
{
    xSemaphore = xSemaphoreCreateMutex();
    ESP_ERROR_CHECK(i2c_master_init());
    lcd_init();
    lcd_clear();
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
    xTaskCreate(control_device_task, "uart_rx_task", 1024*2, NULL, configMAX_PRIORITIES, NULL);
    xTaskCreate(&light_sensor_task, "light_sensor_task", 2048, NULL, 3, NULL);
    xTaskCreate(&dht_task, "dht", 2048, NULL, 3, NULL);
    xTaskCreate(ControlLedByPIR, "ControlLedByPIR", 2048, NULL, configMAX_PRIORITIES - 1, NULL);
}
