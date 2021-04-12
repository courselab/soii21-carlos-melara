OUTPUT_FORMAT(binary)

SECTIONS {
        . = 0x7C00;
        .text : { *(.text) }
        . = 0x7c00 + 510;
        .signature : {
                BYTE(0x55)
                BYTE(0xAA)
        }
}
