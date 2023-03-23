# M64F.FreeRTOS

FreeRTOS SPI to FPGA Communication Interface @ K64F

# PIN CONTROL

ARM conpiler is required to compile this project

	sudo at install gcc-arm-none-eabi

Example of how to assign GPIO pin as an output connected to Cyclon II FPGA where is Signal Taped

	//
	// K64 Sub-Family Reference Manual ---> Example
	//
	//                                          //                      (page number)
	#define SIM_SCGC5 (*(int *)0x40048038u)     // Clock gate 5                 (314)
	#define SIM_SCGC5_PORTB 10                  // Open gate PORTB              (314)
	#define PORTB_PCR21 (*(int *)0x4004A054u)   // Pin Control Register         (277)
	#define PORTB_PCR21_MUX 8                   // Mux "001"                    (282)
	#define GPIOB_PDDR (*(int *)0x400FF054u)    // Port Data Direction Register (1760)
	#define GPIOB_PDOR (*(int *)0x400FF040u)    // Port Data Output Register    (1759)
	#define PIN_N 21                            // PTB21 --> Blue LED  			(1761)


To do:

	1. Upgrade Makefle to avoid re-compilation of unchanged sources

# ICE
