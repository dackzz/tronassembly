# Proyecto ARMv8 Framebuffer en Raspberry Pi 3 (QEMU)

Este proyecto implementa un programa en **Assembly ARMv8** que utiliza el framebuffer de la Raspberry Pi 3 para dibujar gráficos en pantalla.  
El entorno de desarrollo está pensado tanto para emular en **QEMU** como para ejecutarse en una **Raspberry Pi real**.

---

## Configuración de pantalla

* Resolución: `640x480` píxeles
* Formato: `ARGB` 32 bits
* El registro `X0` contiene la dirección base del FrameBuffer (Pixel 1).
* El código de cada consigna debe ser escrito en el archivo **app.s**.
* El archivo **start.s** contiene la inicialización del FrameBuffer **(NO EDITAR)**; al finalizar llama a **app.s**.
* El código de ejemplo pinta toda la pantalla de un solo color.

---

## Estructura del proyecto

* **[app.s](app.s)** → Contiene la aplicación (el código de usuario). Todo el hardware ya está inicializado previamente.
* **[start.s](start.s)** → Inicialización del hardware y configuración del framebuffer.
* **[Makefile](Makefile)** → Describe cómo construir el software (qué ensamblador utilizar, qué salida generar, etc.).
* **[memmap](memmap)** → Descripción de la distribución de la memoria del programa y dónde colocar cada sección.
* **[shapes.s](shapes.s)** → Rutinas gráficas de bajo nivel (dibujar píxeles, rectángulos, circunferencias, etc.).
* **[drawings.s](drawings.s)** → Funciones de dibujo más complejas (moto, pisos, fondo, etc.).
* **[buildings.s](buildings.s)** → Funciones para dibujar edificios y nave.
* **[size.s](size.s)** → Constantes globales de pantalla.
* **README.md** → Este archivo.

---

## Requisitos

Antes de compilar el proyecto, asegúrate de tener instaladas las siguientes dependencias:

### Toolchain cruzado para ARM64

```bash
sudo apt update
sudo apt install gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu
```

### QEMU (para emulación)

```bash
sudo apt install qemu-system-arm qemu-system-misc
```

Verifica que estén instalados con:

```bash
aarch64-linux-gnu-as --version
qemu-system-aarch64 --version
```

---

## Compilación

Para compilar el proyecto simplemente ejecuta:

```bash
make
```

Esto genera el archivo `kernel8.img` listo para ejecutarse.

---

## Ejecución en QEMU

Ejecuta el siguiente comando:

```bash
make runQEMU
```

Esto construirá el código y lanzará QEMU para la emulación.

⚠️ Si QEMU muestra un error parecido a:

```
qemu-system-aarch64: unsupported machine type
```

prueba cambiar `raspi3` por `raspi3b` en la receta `runQEMU` del **Makefile** (línea 23 si no lo modificaste).

---

## Ejecución en Raspberry Pi real

1. Compila el proyecto en tu PC host:
   ```bash
   make
   ```

2. Copia el archivo `kernel8.img` a la partición de arranque de la tarjeta SD de tu Raspberry Pi:
   ```bash
   cp kernel8.img /media/$USER/boot/
   ```

3. Inserta la tarjeta SD en la Raspberry Pi y enciéndela.

---

## GPIO Manager (opcional)

El Makefile también incluye una regla para ejecutar el GPIO Manager:

```bash
make runGPIOM
```

Debe ejecutarse **después** de haber corrido QEMU.

---
