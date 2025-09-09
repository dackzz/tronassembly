.include "size.s"
.include "shapes.s"
.equ DELAY, 10
.equ FRAME_COUNT, 2000     // Numero total de frames de la animación
.globl main

main:
    mov x20, x0              // Framebuffer visible
    mov x1, SCREEN_WIDTH
    mov x2, SCREEN_HEIGH
    mov x3, BITS_PER_PIXEL
    mul x4, x1, x2          // WIDTH * HEIGHT
    mul x5, x4, x3          // WIDTH * HEIGHT * BITS_PER_PIXEL
    add x21, x20, x5        // Framebuffer oculto
    mov x22, 0               // Frame counter

AnimLoop:
    mov x0, x21
    bl draw_fondo

    // Calcula offset de animación
    mov x23, x22
    mov x24, 1  // Cantidad de frames que quiero que se mueva la animación
    mul x25, x23, x24
    sub x27, xzr, x25        // x27 = -(frame*10)

    // Elegir frame par/impar
    and x26, x22, 1
    cmp x26, 0
    beq even_frame

odd_frame: 
    bl draw_nave
    bl draw_buildings
    bl draw_floor1
    bl draw_moto
    b after_frame

even_frame:
    bl draw_nave
    bl draw_buildings
    bl draw_floor2
    bl draw_moto

after_frame:
    // Copiar framebuffer oculto (x21) al visible (x20)
    mov x6, SCREEN_WIDTH
    mov x7, SCREEN_HEIGH
    mov x8, BITS_PER_PIXEL
    mul x6, x6, x7
    mul x6, x6, x8          // x6 = tamaño en bytes
    mov x2, x21             // Origen (buffer oculto)
    mov x3, x20             // Destino (visible)
copy_loop:
    ldr w4, [x2], 4      // Lee 4 bytes desde la dirección de origen (x2) y avanza x2
    str w4, [x3], 4      // Escribe esos 4 bytes en la dirección de destino (x3) y avanza x3
    subs x6, x6, 4       // Resta 4 al contador de bytes restantes y actualiza los flags
    b.ne copy_loop       // Si quedan bytes por copiar, repite el bucle

    // Espera para siguiente frame
    mov x1, DELAY
    bl timer

    // Avanzar al siguiente frame
    add x22, x22, #1
    cmp x22, FRAME_COUNT
    blt AnimLoop

    b main
    
