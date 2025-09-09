.include "shapes.s"
.globl draw_buildings
.globl draw_nave

 // Colores
	.equ FLOORLINES, 0x3E686F
	.equ FLOOR, 0x04263C
	.equ RED,  0xFF0000
	.equ RED2, 0xD80000
	.equ RED3, 0x990000
	.equ BLACK, 0x000000
	.equ LBLACK, 0x1B1B1F
	.equ BORDO, 0x311724
	.equ EDIFICIO, 0x328da4


.macro draw_rectangle_off x, y, w, z, color
	mov x1, \x  // Mueve el valor 
	mov x2, \y  // de x, y, w, z
	mov x3, \w  // que se le pasa al macro
	mov x4, \z  // al registro x1
	add x1, x1, x27 // Offset horizontal
	movz x10, (\color >> 16) & 0xFFFF, lsl 16 // Carga bits mas significativos del color en x10
	movk x10, \color & 0xFFFF, lsl 0 // Carga bits menos significativos del color en x10
	bl rectangle
.endm

.macro draw_rectangle_off_nave x, y, w, z, color
	mov x1, \x  // Mueve el valor 
	mov x2, \y  // de x, y, w, z
	mov x3, \w  // que se le pasa al macro
	mov x4, \z  // al registro x1
	sub x1, x1, x27 // Offset horizontal negativo
	movz x10, (\color >> 16) & 0xFFFF, lsl 16 // Carga bits mas significativos del color en x10
	movk x10, \color & 0xFFFF, lsl 0 // Carga bits menos significativos del color en x10
	bl rectangle
.endm

.macro draw_circumference_off x, y, w, z, color
	mov x1, \x  // Mueve el valor 
	mov x2, \y  // de x, y, w, z
	mov x3, \w  // que se le pasa al macro
	mov x4, \z  // al registro x1
	add x1, x1, x27 // Offset horizontal 
	movz x10, (\color >> 16) & 0xFFFF, lsl 16 // Carga bits mas significativos del color en x10
	movk x10, \color & 0xFFFF, lsl 0 // Carga bits menos significativos del color en x10
	bl circumference
.endm

draw_buildings:
    sub sp, sp, #48
    str x1, [sp]
    str x2, [sp, #8]
    str x3, [sp, #16]
    str x4, [sp, #24]
    str x7, [sp, #32]
    str x30, [sp, #40]
// Detalles del Fondo
		// Main Build	
			// Left Side
				draw_rectangle_off 305, 90, 5, 120, EDIFICIO
				draw_rectangle_off 300, 60, 5, 170, EDIFICIO
				draw_rectangle_off 295, 65, 5, 165, EDIFICIO
				draw_rectangle_off 290, 70, 5, 160, EDIFICIO
				draw_rectangle_off 285, 100, 5, 130, EDIFICIO
				draw_rectangle_off 280, 105, 5, 135, EDIFICIO
				draw_rectangle_off 275, 110, 5, 140, EDIFICIO
				draw_rectangle_off 270, 160, 5, 90, EDIFICIO
				draw_rectangle_off 265, 165, 5, 85, EDIFICIO
				draw_rectangle_off 260, 170, 5, 80, EDIFICIO

			// Right Side
				draw_rectangle_off 325, 90, 5, 120, EDIFICIO
				draw_rectangle_off 330, 60, 5, 170, EDIFICIO
				draw_rectangle_off 335, 65, 5, 165, EDIFICIO
				draw_rectangle_off 340, 70, 5, 160, EDIFICIO
				draw_rectangle_off 345, 100, 5, 130, EDIFICIO
				draw_rectangle_off 350, 105, 5, 135, EDIFICIO
				draw_rectangle_off 355, 110, 5, 140, EDIFICIO
				draw_rectangle_off 360, 160, 5, 90, EDIFICIO
				draw_rectangle_off 365, 165, 5, 85, EDIFICIO
				draw_rectangle_off 370, 170, 5, 80, EDIFICIO
		
		// BuildGroup1 (Left)
			draw_rectangle_off 0, 190, 5, 70, EDIFICIO
			draw_rectangle_off 5, 180, 5, 70, EDIFICIO
			draw_rectangle_off 10, 185, 5, 70, EDIFICIO
			draw_rectangle_off 15, 176, 5, 70, EDIFICIO
			draw_rectangle_off 20, 180, 5, 70, EDIFICIO
			draw_rectangle_off 25, 183, 5, 70, EDIFICIO
			draw_rectangle_off 30, 177, 5, 70, EDIFICIO
			draw_rectangle_off 35, 188, 5, 70, EDIFICIO

		// BuildGroup2 (Left)			
			draw_rectangle_off 70, 188, 5, 70, EDIFICIO
			draw_rectangle_off 75, 177, 5, 70, EDIFICIO
			draw_rectangle_off 80, 183, 5, 70, EDIFICIO
			draw_rectangle_off 85, 180, 5, 70, EDIFICIO
			draw_rectangle_off 90, 176, 5, 70, EDIFICIO
			draw_rectangle_off 95, 185, 5, 70, EDIFICIO
			draw_rectangle_off 100, 180, 5, 70, EDIFICIO
			draw_rectangle_off 105, 190, 5, 70, EDIFICIO

		// BuildGroup3 (Left)			
			draw_rectangle_off 170, 190, 5, 70, EDIFICIO
			draw_rectangle_off 175, 187, 5, 70, EDIFICIO
			draw_rectangle_off 180, 181, 5, 70, EDIFICIO
			draw_rectangle_off 185, 183, 5, 70, EDIFICIO
			draw_rectangle_off 190, 177, 5, 70, EDIFICIO
			draw_rectangle_off 195, 190, 5, 70, EDIFICIO
			draw_rectangle_off 200, 176, 5, 70, EDIFICIO
			draw_rectangle_off 205, 188, 5, 70, EDIFICIO

		// BuildGroup1 (Right)
			draw_rectangle_off 400, 188, 5, 70, EDIFICIO
			draw_rectangle_off 405, 177, 5, 70, EDIFICIO
			draw_rectangle_off 410, 185, 5, 70, EDIFICIO
			draw_rectangle_off 415, 190, 5, 70, EDIFICIO
			draw_rectangle_off 420, 177, 5, 70, EDIFICIO
			draw_rectangle_off 425, 185, 5, 70, EDIFICIO
			draw_rectangle_off 430, 180, 5, 70, EDIFICIO
			draw_rectangle_off 435, 190, 5, 70, EDIFICIO
		
		// BuildGroup2 (Right)
			draw_rectangle_off 500, 187, 5, 70, EDIFICIO
			draw_rectangle_off 505, 180, 5, 70, EDIFICIO
			draw_rectangle_off 510, 185, 5, 70, EDIFICIO
			draw_rectangle_off 515, 176, 5, 70, EDIFICIO
			draw_rectangle_off 520, 180, 5, 70, EDIFICIO
			draw_rectangle_off 525, 183, 5, 70, EDIFICIO
			draw_rectangle_off 530, 177, 5, 70, EDIFICIO
			draw_rectangle_off 535, 190, 5, 70, EDIFICIO

		// BuildGroup2 (Right)
			draw_rectangle_off 570, 188, 5, 70, EDIFICIO
			draw_rectangle_off 575, 177, 5, 70, EDIFICIO
			draw_rectangle_off 580, 183, 5, 70, EDIFICIO
			draw_rectangle_off 585, 180, 5, 70, EDIFICIO
			draw_rectangle_off 590, 176, 5, 70, EDIFICIO
			draw_rectangle_off 595, 185, 5, 70, EDIFICIO
			draw_rectangle_off 600, 180, 5, 70, EDIFICIO
			draw_rectangle_off 605, 190, 5, 70, EDIFICIO
    ldr x30, [sp, #40]
    ldr x7, [sp, #32]
    ldr x4, [sp, #24]
    ldr x3, [sp, #16]
    ldr x2, [sp, #8]
    ldr x1, [sp]
    add sp, sp, #48        
ret

draw_nave:
    sub sp, sp, #48
    str x1, [sp]
    str x2, [sp, #8]
    str x3, [sp, #16]
    str x4, [sp, #24]  
    str x7, [sp, #32]
    str x30, [sp, #40]

    // Nave
	// Parte Superior
		draw_rectangle_off_nave 422, 65, 88, 8, BORDO
		draw_rectangle_off_nave 421, 73, 90, 4, RED3
		draw_rectangle_off_nave 444, 61, 47, 4, BORDO
		draw_rectangle_off_nave 455, 57, 23, 4, BORDO
		draw_rectangle_off_nave 455, 65, 23, 4, RED
	
	// Ala Derecha
		draw_rectangle_off_nave 507, 100, 7, 40, RED
		draw_rectangle_off_nave 506, 85, 7, 40, RED
		draw_rectangle_off_nave 505, 77, 7, 30, RED
		draw_rectangle_off_nave 504, 100, 7, 40, RED3
		draw_rectangle_off_nave 503, 85, 7, 40, RED3
		draw_rectangle_off_nave 502, 77, 7, 30, RED3
		draw_rectangle_off_nave 500, 100, 7, 40, BORDO
		draw_rectangle_off_nave 499, 85, 7, 40, BORDO
		draw_rectangle_off_nave 498, 77, 7, 30, BORDO
		draw_rectangle_off_nave 480, 137, 20, 3, BORDO
		draw_rectangle_off_nave 480, 133, 6, 6, BORDO
		draw_rectangle_off_nave 486, 127, 6, 12, BORDO
		draw_rectangle_off_nave 492, 121, 6, 18, BORDO
		draw_rectangle_off_nave 498, 115, 6, 24, BORDO
	
	// Ala Izquierda
		draw_rectangle_off_nave 418, 100, 7, 40, RED2
		draw_rectangle_off_nave 419, 85, 7, 40, RED2
		draw_rectangle_off_nave 420, 77, 7, 30, RED2
		draw_rectangle_off_nave 420, 100, 7, 40, RED3
		draw_rectangle_off_nave 421, 85, 7, 40, RED3
		draw_rectangle_off_nave 422, 77, 7, 30, RED3
		draw_rectangle_off_nave 423, 100, 7, 40, BORDO
		draw_rectangle_off_nave 424, 85, 7, 40, BORDO
		draw_rectangle_off_nave 425, 77, 7, 30, BORDO
		draw_rectangle_off_nave 430, 137, 20, 3, BORDO
		draw_rectangle_off_nave 444, 133, 6, 6, BORDO
		draw_rectangle_off_nave 438, 127, 6, 12, BORDO
		draw_rectangle_off_nave 432, 121, 6, 18, BORDO
		draw_rectangle_off_nave 426, 115, 6, 24, BORDO
    
    ldr x30, [sp, #40]
    ldr x7, [sp, #32]
    ldr x4, [sp, #24]
    ldr x3, [sp, #16]
    ldr x2, [sp, #8]
    ldr x1, [sp]
    add sp, sp, #48
ret
