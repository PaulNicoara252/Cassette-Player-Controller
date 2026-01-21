# FPGA Cassette Player Controller (VHDL)

![Language](https://img.shields.io/badge/Language-VHDL-blue.svg)
![Platform](https://img.shields.io/badge/Platform-Digilent_Basys3-red.svg)
![Status](https://img.shields.io/badge/Status-Synthesized-green.svg)

## 📼 Project Overview

This repository contains the VHDL source code and constraints for a **Digital Cassette Player Controller**. The system is implemented as a **Finite State Machine (FSM)** that manages the mechanical transport logic of a cassette deck.

The design is synthesized for the **Xilinx Artix-7 FPGA** (specifically the Digilent Basys 3 development board), utilizing physical push-buttons for transport control and LEDs for state visualization.

## ⚙️ Architecture & Logic

The core logic is defined in `casetofon_ctrl.vhd`. The system operates based on user inputs and an internal "Music Sensor" signal to transition between transport modes.

### Finite State Machine (FSM)
The controller implements a state machine with the following states ($S$):

STOP, PLAY, REWIND, WAIT_FF, WAIT_REW

**State Descriptions:**
* **STOP:** The idle state. All outputs are inactive.
* **PLAY:** The tape is moving at normal speed. ($P=1$)
* **REWIND / FAST_FORWARD:** High-speed transport modes. ($R=1$ or $F=1$)
* **WAIT STATES:** Intermediate states where the mechanism waits for the "Music Sensor" ($M$) signal to go low (indicating the start of a song) before automatically returning to **PLAY** mode.

### Logic Flow
1.  **Transport:** Pressing `PL`, `RE`, or `FF` transitions the system from *STOP* or *PLAY* into the respective active mode.
2.  **Music Search Feature:** If the system is in *REWIND* or *FAST_FORWARD* and the button is released, it enters a `WAIT` state. It monitors signal `M` (Music Detect). When `M` becomes '0', the system engages **PLAY** automatically.


