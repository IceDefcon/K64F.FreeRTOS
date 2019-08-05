MEMORY
{
    ROM_VECTORS (rx)   : ORIGIN = 0x00000000, LENGTH = 0x00000400
    ROM_FLASH_CFG (rx) : ORIGIN = 0x00000400, LENGTH = 0x00000010
    ROM_TEXT (rx)      : ORIGIN = 0x00000410, LENGTH = 512K
    RAM (rw)           : ORIGIN = 0x20000000, LENGTH = 192K
}

SECTIONS
{
    .interrupts :
    {
        . = ALIGN(4);
        *(.isr_vector)
        . = ALIGN(4);
    } > ROM_VECTORS

    .flash_cfg :
    {
        . = ALIGN(4);
        *(.FlashConfig)
        . = ALIGN(4);
    } > ROM_FLASH_CFG

    .text :
    {
        . = ALIGN(4);
        *(.text*)
        *(.init)                            /* Deconstructora in C++ */
        *(.fini)                            /* Need for registering  */
        *(.rodata*)
        *(.eh_frame)                        /* Required for     */
                                            /* Stack unwinding  */
                                            /* In C++ and for   */
                                            /* Debuging         */
                                            
        . = ALIGN(4);
    } > ROM_TEXT                            /* Application in ROM */
    
    .ARM.exidx :                            /* Required for     */
    {                                       /* Stack unwinding  */
        *(.ARM.exidx)                       /* In C++ and for   */
    } > ROM_TEXT                            /* Debuging         */

    _sfdata = LOADADDR(.data);              /* LMA(ROM) --> VMA(RAM)*/
                                            /* 0x000033E8           */
    __etext = .;                            /*      |               */
    .data :                                 /*   LMA|VMA            */
    {                                       /*      |               */
        . = ALIGN(4);                       /*      V               */
        _sdata = .;                         /* 0x20000000           */
        *(.vtable)                          /* Virtual functions    */
                                            /* Defined in C++       */
                                            /* Classes              */
        *(.data*)                           /* Copy LMA(ROM to RAM  */
        *(.init_*)                          /* Constructors in C++   */
        *(.fini_*)                          /* Deconstructora in C++ */
        *(.jcr)                             /* Need for registering  */
                                            /* compiled java class   */
        _edata = .;                         /* 0x20000004            */
        . = ALIGN(4);
    } > RAM AT> ROM_TEXT                    /* Data is loaded to ROM */
                                            /*   And copied to RAM   */

    .bss :
    {
        . = ALIGN(4);
        __bss_start__ = . ;
        *(.bss*)
        *(COMMON)                           /* Dont need */
        __bss_end__ = . ;
        . = ALIGN(4);
    } > RAM

    . = ALIGN(8);
    __heap = .;                             /* Dont need */
    __stack = ORIGIN(RAM) + LENGTH(RAM);
}
