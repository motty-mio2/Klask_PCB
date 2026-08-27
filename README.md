# Klask PCB

This repository contains the KiCad project files for **Klask PCB**, a custom Arduino Uno R3 shield designed to control stepper motors and limit switches for manipulating a **Klask** board game.

## Overview

**Klask PCB** is a hardware interface designed to automate or robotize the board game "Klask". It uses stepper motors to move the game magnets under the board. 

The shield drives two stepper motors (X and Y axes) using Pololu-style DRV8825 stepper driver modules and processes signals from homing limit switches to align the axes. Additionally, it integrates a power sense circuit to detect external 12V supply and is powered efficiently via a USB-PD Trigger Module.

---

## Features

- **Dual Axis Control**: Supports two DRV8825 stepper motor driver modules for X and Y axes.
- **Homing Support**: Hardware inputs for X and Y axis limit switches to perform auto-calibration (0-point homing).
- **USB-PD Powered**: Powered via an external 12V supply using a USB-PD Trigger Module.
- **Power Detection (Power Sense)**: Built-in voltage divider and noise-filtering circuit to safely detect whether the 12V motor power supply is active using the Arduino `D10` pin.
- **Visual Indicator**: LED indicator to show the status of the 12V power supply.
- **Minimalist Arduino Shield**: Uses only the Digital headers (10-pin and 8-pin) of the Arduino Uno R3 to minimize interference and pin usage.

---

## Bill of Materials (BOM)

Below is the list of components required to assemble the Klask PCB.

| Component | Designator | Qty | Description / Footprint |
| --- | --- | --- | --- |
| **DRV8825 Stepper Driver Module** | A1, A2 | 2 | Pololu Breakout board style stepper driver |
| **Arduino UNO R3** | A3 | 1 | Microcontroller board (acts as base) |
| **USB-PD Trigger Module** | — | 1 | Set to 12V output mode |
| **10-pin Pin Header** | — | 1 | 2.54mm pitch (for Arduino Digital High header) |
| **8-pin Pin Header** | — | 1 | 2.54mm pitch (for Arduino Digital Low header) |
| **8-pin Pin Socket** | — | 4 | 2.54mm pitch (sockets for DRV8825 modules) |
| **LED** | D1 | 1 | 3mm THT LED (Power/12V Status Indicator) |
| **2.54mm Terminal Block** | J1, J2, J3, J4, J5, SW4, SW5 | 7 | XY308-2.54-2P (For MotXA, MotXB, MotYA, MotYB, 12V, SWX, SWY) |
| **510 Ω Resistor** | R1 | 1 | THT Resistor (LED current limiting) |
| **180 Ω Resistor** | R2 | 1 | THT Resistor (Power sensing voltage divider) |
| **0.1 µF Capacitor** | C1 | 1 | Ceramic Capacitor THT (Power sense noise filter) |
| **100 µF Capacitor** | C3, C4 | 2 | Electrolytic Capacitor THT (Motor power decoupling) |

*Note: SW2 (SW_A) and SW3 (SW_B) are present on the PCB layout for potential UI expansion but are not populated in this build.*

---

## Pin Mapping

The Arduino Uno R3 digital pins are mapped to the stepper drivers, limit switches, and power sense circuit as follows:

### Stepper Motor Drivers (DRV8825)
| Signal Name | Arduino Uno Pin | DRV8825 Pin | Description |
| --- | --- | --- | --- |
| `/MX_STEP` | `D8` | `STEP` (A1) | X-axis step control pulse |
| `/MX_DIR` | `D9` | `DIR` (A1) | X-axis rotation direction |
| `/MY_STEP` | `D4` | `STEP` (A2) | Y-axis step control pulse |
| `/MY_DIR` | `D5` | `DIR` (A2) | Y-axis rotation direction |
| `/nEN` | `D3` | `~{RST}`, `~{SLP}` (A1, A2) | Driver enable (Reset / Sleep control) |
| `/M0` | `D0 / RX` | `M0` (A1, A2) | Microstep configuration bit 0 |
| `/M1` | `D1 / TX` | `M1` (A1, A2) | Microstep configuration bit 1 |
| `/M2` | `D2` | `M2` (A1, A2) | Microstep configuration bit 2 |

### Limit Switches & Sensors
| Signal Name | Arduino Uno Pin | PCB Connector | Description |
| --- | --- | --- | --- |
| `/SW_X` | `A5` (Digital I/O) | `SW4` | X-axis homing limit switch (Active Low) |
| `/SW_Y` | `A4` (Digital I/O) | `SW5` | Y-axis homing limit switch (Active Low) |
| `GND` | `GND` | `SW4`, `SW5` | Common Ground for switches |

### Power Sense & Feedback
| Signal Name | Arduino Uno Pin | Related Parts | Description |
| --- | --- | --- | --- |
| `/A0` | `D10` | `D1`, `R1`, `R2`, `C1` | Input pin to sense if 12V is connected (HIGH = 12V Present) |

---

## Hardware Connection & Assembly

1. **Terminal Blocks Wiring**:
   - **`J5` (12V Input)**: Connect the 12V and GND outputs from the **USB-PD Trigger Module**.
   - **`J1` & `J2`**: Connect to the X-axis stepper motor coils (Phase A to `J1`, Phase B to `J2`).
   - **`J3` & `J4`**: Connect to the Y-axis stepper motor coils (Phase A to `J3`, Phase B to `J4`).
   - **`SW4` & `SW5`**: Connect to the X-axis and Y-axis limit switches.
2. **Arduino Uno Mounting**:
   - Solder the 10-pin and 8-pin male headers to the digital side of the shield.
   - Solder the power sense circuit parts (`D1`, `R1`, `R2`, `C1`) and decoupling capacitors (`C3`, `C4`).
   - Stack the shield onto the Arduino Uno R3.
3. **Stepper Drivers**:
   - Solder the 8x4 female pin sockets onto the shield.
   - Insert the DRV8825 stepper driver modules into the sockets. Make sure the orientation is correct (VMOT/GND pin alignment).

---

## License

This project is licensed under the **CC BY-SA 4.0** (Creative Commons Attribution-ShareAlike 4.0 International) license. Feel free to share, copy, and modify, provided appropriate credit is given and any derivative works are distributed under the same license.
