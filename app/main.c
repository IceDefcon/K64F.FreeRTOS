#include "FreeRTOS.h"
#include "task.h"
                                            // K64 Sub-Family Reference Manual
                                            // ==================================
                                            //                      (page number)
#define SIM_SCGC5 (*(int *)0x40048038u)     // Clock gate 5                 (314)
#define SIM_SCGC5_PORTB 10                  // Open gate PORTB              (314)

#define PORTB_PCR21 (*(int *)0x4004A054u)   // Pin Control Register         (277)
#define PORTB_PCR21_MUX 8                   // Mux "001"                    (282)

#define GPIOB_PDDR (*(int *)0x400FF054u)    // Port Data Direction Register (1760)
#define GPIOB_PDOR (*(int *)0x400FF040u)    // Port Data Output Register    (1759)
#define PIN_N 21                            // PTB21 --> Blue LED  			(1761)

void init_gpio()
{
    /* Enable clocks. */
    SIM_SCGC5 |= 1 << SIM_SCGC5_PORTB;
    /* Configure pin 21 as GPIO. */
    PORTB_PCR21 |= 1 << PORTB_PCR21_MUX;
    /* Configure GPIO pin 21 as output.
     * It will have a default output value set
     * to 0, so LED will light (negative logic).
     */
    GPIOB_PDDR |= 1 << PIN_N;
}

void blinky_task()
{
    while(1) {
        GPIOB_PDOR ^= 1 << PIN_N;               // Toggle with XOR
        vTaskDelay(500 / portTICK_PERIOD_MS);   // 500/10
    }
}

int main()
{
    init_gpio();

    xTaskCreate(blinky_task, "Blinky", 100, NULL, 1, NULL); 	
    vTaskStartScheduler();
    return 0;
}
