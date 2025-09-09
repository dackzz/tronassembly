.ifndef __shapes__
.equ __shapes__,0
.include "size.s"

backgroundColor: 

    sub sp, sp, 24
    stur x1, [sp, 0]
    stur x2, [sp, 8]
    stur x0, [sp, 16]

        mov x2, SCREEN_HEIGH         // Y Size
    loop1:
	    mov x1, SCREEN_WIDTH         // X Size
    loop0:
	    stur w10,[x0]  // Colorear el pixel N
	    add x0,x0,4	   // Siguiente pixel
	    sub x1,x1,1	   // Decrementar contador X
	    cbnz x1,loop0  // Si no terminó la fila, salto
	    sub x2,x2,1	   // Decrementar contador Y
	    cbnz x2,loop1  // Si no es la última fila, salto
    
    ldur x1, [sp, 0]
    ldur x2, [sp, 8]
    ldur x0, [sp, 16]
    add sp, sp, 24
ret

setpixel: 

    sub sp, sp, 24
    stur x1, [sp, 0]
    stur x2, [sp, 8]
    stur x3, [sp, 16]

    coord:
        mov x3, 640
        mul x3, x3, x2
        add x3, x3, x1
        lsl x3, x3, 2
        add x3, x3, x0

    stur w10, [x3]
    ldur x1, [sp, 0]
    ldur x2, [sp, 8]
    ldur x3, [sp, 16]
    add sp, sp, 24
ret

rectangle:

    sub sp, sp, 40
    stur x1, [sp, 0]
    stur x2, [sp, 8]
    stur x3, [sp, 16]
    stur x4, [sp, 24]
    stur lr, [sp, 32]
    
    loopRectangle0:
        bl setpixel
        add x1, x1, 1
        sub x3, x3, 1
        cbnz x3, loopRectangle0
        ldur x3, [sp, 16]
        ldur x1, [sp, 0]
        sub x4, x4, 1
        add x2, x2, 1
        cbz x4, endRectangle
        b loopRectangle0
    
    endRectangle:
        ldur x1, [sp, 0]
        ldur x2, [sp, 8]
        ldur x3, [sp, 16]
        ldur x4, [sp, 24]
        ldur lr, [sp, 32]
        add sp, sp, 40  
ret

circle:
    // Dibuja un círculo completo con color x10
    // PARAMETROS: Centro X:x1, Centro Y:x2, Radio:x3, Color:x10
    sub sp, sp, 40
    stur x1, [sp, 0]
    stur x2, [sp, 8]
    stur x3, [sp, 16]
    stur lr, [sp, 32]

            
        sub x4, xzr, x3     // x4 = -radio (offset en X)
    loop_circ_y:
        sub x5, xzr, x3     // x5 = -radio (offset en Y)
    loop_circ_x:
        // x6 = x4² + x5²
        mul x6, x4, x4
        mul x7, x5, x5
        add x6, x6, x7

        // x7 = radio²
        ldur x7, [sp, 16]
        mul x7, x7, x7

        cmp x6, x7
        b.gt no_pixel       // Si está fuera del radio, no pinta

        // Pinta el pixel: setpixel(x1+x4, x2+x5)
        add x1, x4, x1
        add x2, x5, x2
        bl setpixel
        ldur x1, [sp, 0]
        ldur x2, [sp, 8]

    no_pixel:
        add x5, x5, 1
        cmp x5, x3
        ble loop_circ_x

        add x4, x4, 1
        cmp x4, x3
        ble loop_circ_y

    ldur x1, [sp, 0]
    ldur x2, [sp, 8]
    ldur x3, [sp, 16]
    ldur lr, [sp, 32]
    add sp, sp, 40
ret

circumference:
    // Dibuja solo el borde de un círculo con color x10
    // PARAMETROS: Centro X:x1, Centro Y:x2, Radio:x3, Espesor:x4, Color:x10
    sub sp, sp, 48
    stur x1, [sp, 0]
    stur x2, [sp, 8]
    stur x3, [sp, 16]
    stur x4, [sp, 24]
    stur lr, [sp, 40]

        sub x5, xzr, x3     // x5 = -radio (offset en X)
    loop_circB_y:
        sub x6, xzr, x3     // x6 = -radio (offset en Y)
    loop_circB_x:
        // d2 = x^2 + y^2
        mul x7, x5, x5
        mul x8, x6, x6
        add x7, x7, x8      // x7 = distancia²

        // r^2
        ldur x9, [sp, 16]
        mul x9, x9, x9

        // r_int = r - espesor
        ldur x8, [sp, 16]
        ldur x11, [sp, 24]
        sub x8, x8, x11
        mul x8, x8, x8      // x8 = (r - e)^2

        cmp x7, x9
        b.gt not_this_pixel
        cmp x7, x8
        b.lt not_this_pixel

        // Pinta el pixel: setpixel(x1+x5, x2+x6)
        add x1, x1, x5
        add x2, x2, x6
        bl setpixel
        ldur x1, [sp, 0]
        ldur x2, [sp, 8]

    not_this_pixel:
        add x6, x6, 1
        cmp x6, x3
        ble loop_circB_x

        add x5, x5, 1
        cmp x5, x3
        ble loop_circB_y

    ldur x1, [sp, 0]
    ldur x2, [sp, 8]
    ldur x3, [sp, 16]
    ldur x4, [sp, 24]
    ldur lr, [sp, 40]
    add sp, sp, 48
ret

timer: 
    // Temporizador, 1 seg = mov x1, 100 (aprox)
    sub sp, sp, 8
    stur x1, [sp, 0]

    loopTimer:
        mov x2, 999
    loopTimer1:	
        mov x3, 9999
    loopTimer2:
        sub x3, x3, 1
        cbnz x3, loopTimer2
        sub x2, x2, 1
        cbnz x2, loopTimer1
        sub x1, x1, 1
        cbnz x1, loopTimer

    ldur x1, [sp, 0]
    add sp, sp, 8
ret


.endif
