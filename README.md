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


🎮 Controls & Pinout (Basys 3)The project maps the FPGA's physical buttons (BTN) to the transport controls and LEDs to the status indicators defined in constraints.xdc.Button / LEDFPGA PinSignal NameFunctionBTN UT18PLPlay CommandBTN LW19RERewind CommandBTN RT17FFFast Forward CommandBTN DU17STStop CommandBTN CU18MMusic/Gap Sensor InputLED 0U16P_intPlay Status IndicatorLED 1E19R_intRewind Status IndicatorLED 2U19F_intFast Forward Status IndicatorCLKW5clk100MHz System Clock🚀 Simulation & SynthesisPrerequisitesXilinx Vivado (2020.2 or newer recommended)Digilent Basys 3 Board (or equivalent Artix-7 FPGA)How to RunCreate Project: Open Vivado and create a new RTL project.Add Sources: Import casetofon_top.vhd and casetofon_ctrl.vhd.Add Constraints: Import constraints.xdc.Set Top Module: Ensure casetofon_top is set as the top-level entity.Generate Bitstream: Run Synthesis, Implementation, and Generate Bitstream.Program: Connect the Basys 3 board via USB and program the device.📊 State Diagram(Optional: Insert an image of the FSM diagram here)STOP is the reset state.PL -> PLAY.RE -> REWIND -> (Release Button) -> WAIT_REWIND -> (M='0') -> PLAY.FF -> FAST_FORWARD -> (Release Button) -> WAIT_FF -> (M='0') -> PLAY.ST -> Returns to STOP from any state.👨‍💻 Author Paul-Nicolae Nicoara📄 LicenseThis project is open-source.
