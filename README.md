# 🛠️ Guía de Instalación de Vivado 2025.2 en Ubuntu 22.04

> ⚠️ **Nota:** Se optó por instalar la versión **2025.2** debido a que las PCs del laboratorio utilizan **Ubuntu 22.04.5**. La versión 2024.2 no era compatible con dicha versión de Ubuntu.

---

## 👥 Autores

| Rol | Nombre | Carrera |
|-----|--------|---------|
| 📘 Autor | Luis David Barahona Valdivieso | Ingeniería Electrónica |
| 🤖 Asistente de IA | Claude (Sonnet 4.6) — Anthropic | Modelo de lenguaje grande (LLM) |

---

## 📋 Tabla de Contenidos

1. [Requerimientos de la PC/Laptop](#1-requerimientos-de-la-pclaptop)
2. [Pasos para instalar](#2-pasos-para-instalar)
   - [2.1 Actualizar librerías](#21-actualizar-librerías)
   - [2.2 Descargar instalador](#22-descargar-instalador)
   - [2.3 Ejecutar instalador](#23-ejecutar-instalador)
   - [2.4 Verificar que Vivado arranque desde la terminal](#24-verificar-que-vivado-arranque-desde-la-terminal)
   - [2.5 Crear acceso directo](#25-crear-acceso-directo)
   - [2.6 Instalar drivers JTAG](#26-instalar-drivers-jtag)
3. [Pruebas de funcionamiento](#3-pruebas-de-funcionamiento)
   - [3.1 Pruebas con Basys 3](#31-pruebas-con-basys-3)
   - [3.2 Pruebas con PYNQ Z1](#32-pruebas-con-pynq-z1)
4. [Anexos](#4-anexos)
5. [Errores detectados](#5-errores-detectados)

---

## 1. Requerimientos de la PC/Laptop

Asegúrate de contar con los siguientes requisitos antes de iniciar la instalación:

- Sistema operativo: **Ubuntu 22.04.5 LTS**
- Espacio en disco: mínimo **100 GB libres** (se recomienda instalar en `/tools/Xilinx`)
- Conexión a internet estable para la descarga del instalador
- Permisos de superusuario (`sudo`)

---

## 2. Pasos para instalar

### 2.1 Actualizar librerías

Antes de instalar, actualiza el sistema para evitar conflictos de dependencias:

```bash
sudo apt update
sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo dist-upgrade -y
```

---

### 2.2 Descargar instalador

Descarga el instalador desde el sitio oficial de AMD/Xilinx:

🔗 [https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/2025-2.html](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/2025-2.html)

![Evidencia de descarga - página principal](evidencia_descarga_01.png)

![Evidencia de descarga - selección de versión](evidencia_descarga_02.png)

![Evidencia de descarga - confirmación de archivo](evidencia_descarga_03.png)

---

### 2.3 Ejecutar instalador

Navega al directorio donde descargaste el instalador y ejecútalo. Sigue los pasos del asistente gráfico:

![Paso 1 - Ejecutar instalador](instalador_paso_01.png)

![Paso 2 - Pantalla de bienvenida](instalador_paso_02.png)

![Paso 3 - Aceptar licencia](instalador_paso_03.png)

![Paso 4 - Selección de producto](instalador_paso_04.png)

![Paso 5 - Selección de componentes](instalador_paso_05.png)

![Paso 6 - Opciones adicionales](instalador_paso_06.png)

![Paso 7 - Resumen de instalación](instalador_paso_07.png)

![Paso 8 - Progreso de instalación](instalador_paso_08.png)

**Crear la ruta de instalación y asignar permisos** antes de indicar el directorio destino en el instalador:

```bash
sudo mkdir -p /tools/Xilinx
sudo chown $USER:$USER /tools/Xilinx
```

![Paso 9 - Configurar ruta /tools/Xilinx](instalador_paso_09.png)

![Paso 10 - Instalación en progreso](instalador_paso_10.png)

![Paso 11 - Finalización](instalador_paso_11.png)

![Paso 12 - Confirmación final](instalador_paso_12.png)

---

### 2.4 Verificar que Vivado arranque desde la terminal

#### Crear variables de entorno

Agrega el script de configuración de Vivado al archivo `.bashrc`:

```bash
# Si instalaste en /tools/Xilinx (RECOMENDADO)
echo 'source /tools/Xilinx/2025.2/Vivado/settings64.sh' >> ~/.bashrc
source ~/.bashrc
```

> ⚠️ **Nota:** Si instalaste en `/opt/`, el comando cambia:
> ```bash
> echo 'source /opt/Xilinx/2025.2/Vivado/settings64.sh' >> ~/.bashrc
> source ~/.bashrc
> ```

![Variables de entorno configuradas](variables_entorno.png)

#### Probar Vivado

```bash
vivado
```

![Vivado abriendo desde la terminal](vivado_terminal.png)

#### Para Vitis (opcional)

```bash
echo 'source /tools/Xilinx/2025.2/Vitis/settings64.sh' >> ~/.bashrc
source ~/.bashrc
```

---

### 2.5 Crear acceso directo

Crea un archivo `.desktop` para acceder a Vivado desde el menú de aplicaciones de Ubuntu.

#### Opción A — Ruta `/tools/Xilinx` (recomendada)

```bash
nano ~/.local/share/applications/vivado.desktop
```

Pega el siguiente contenido:

```ini
[Desktop Entry]
Version=1.0
Type=Application
Name=Vivado 2025.2
Comment=AMD Vivado FPGA Design Suite
Exec=/tools/Xilinx/2025.2/Vivado/bin/vivado
Icon=/tools/Xilinx/2025.2/Vivado/doc/images/vivado_logo.png
Terminal=false
Categories=Development;Engineering;
```

Guarda con `CTRL+O` → `ENTER` → `CTRL+X`, luego:

```bash
chmod +x ~/.local/share/applications/vivado.desktop
update-desktop-database ~/.local/share/applications
```

#### Opción B — Ruta `/opt/Xilinx`

```bash
nano ~/.local/share/applications/vivado.desktop
```

```ini
[Desktop Entry]
Version=1.0
Type=Application
Name=Vivado 2025.2
Comment=AMD Vivado FPGA Design Suite
Exec=/opt/Xilinx/2025.2/Vivado/bin/vivado
Icon=/opt/Xilinx/2025.2/Vivado/doc/images/vivado_logo.png
Terminal=false
Categories=Development;Engineering;
```

```bash
chmod +x ~/.local/share/applications/vivado.desktop
update-desktop-database ~/.local/share/applications
```

Presiona la tecla **Super/Windows**, busca **Vivado** y haz clic para abrirlo.

![Acceso directo de Vivado en el menú](acceso_directo_vivado.png)

#### Acceso directo para Vitis (opcional)

```bash
nano ~/.local/share/applications/vitis.desktop
```

```ini
[Desktop Entry]
Version=1.0
Type=Application
Name=Vitis 2025.2
Comment=AMD Vitis Design Suite
Exec=/tools/Xilinx/2025.2/Vitis/bin/vitis
Icon=/tools/Xilinx/2025.2/Vitis/doc/images/ide_icon.png
Terminal=false
Categories=Development;Engineering;
```

```bash
chmod +x ~/.local/share/applications/vitis.desktop
update-desktop-database ~/.local/share/applications
```

![Acceso directo de Vitis en el menú](acceso_directo_vitis.png)

---

### 2.6 Instalar drivers JTAG

Los drivers JTAG son necesarios para programar FPGAs mediante cable USB.

```bash
cd /tools/Xilinx/2025.2/Vivado/data/xicom/cable_drivers/lin64/install_script/install_drivers
sudo ./install_drivers
```

![Instalación de drivers JTAG](jtag_drivers.png)

#### Instalar librerías adicionales

```bash
cd /tools/Xilinx/2025.2/Vitis/scripts
sudo ./installLibs.sh
```

![Instalación de librerías adicionales - paso 1](libs_adicionales_01.png)

![Instalación de librerías adicionales - paso 2](libs_adicionales_02.png)

---

## 3. Pruebas de funcionamiento

### 3.1 Pruebas con Basys 3

#### Detectar Basys 3

Conecta la tarjeta por USB y verifica que Vivado la reconozca en el Hardware Manager.

![Detección de Basys 3 en Hardware Manager](basys3_detectar.png)

#### Cargar Bitstream

Abre el Hardware Manager, conecta al target y programa el dispositivo con el bitstream.

![Carga de bitstream - paso 1](basys3_bitstream_01.png)

![Carga de bitstream - paso 2](basys3_bitstream_02.png)

---

### 3.2 Pruebas con PYNQ Z1

> 📷 *(Sección pendiente de completar — agrega aquí tus imágenes de evidencia con PYNQ Z1)*

---

## 4. Anexos

### PC1

![Anexo PC1 - vista general](anexo_pc1_01.png)

![Anexo PC1 - detalle](anexo_pc1_02.png)

### PC2

> 📷 *(Agrega aquí las imágenes correspondientes a PC2)*

---

## 5. Errores detectados

### 5.1 PC L414-011 — Vivado instalado en `/opt/Xilinx`

Se detectó un error en esta PC relacionado con la ruta de instalación alternativa.

![Error en PC L414-011](error_pc_L414_011.png)

---

### 5.2 PC L414-012 — Instalación incompleta

No existe el archivo `settings64.sh`, lo que indica que la instalación no se completó correctamente.

> 💡 **Solución sugerida:** Reinstalar Vivado verificando que el proceso de instalación finalice sin interrupciones y que el directorio `/tools/Xilinx/2025.2/Vivado/` contenga el archivo `settings64.sh`.

---

*Documentación generada con asistencia de Claude (Anthropic) — Marzo 2026*
