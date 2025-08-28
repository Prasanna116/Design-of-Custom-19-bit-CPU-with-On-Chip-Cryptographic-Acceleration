# Design-of-Custom-19-bit-CPU-with-On-Chip-Cryptographic-Acceleration


## 📌 Overview  
This project implements a **Custom RISC-style Processor** with a **19-bit fixed instruction format**, designed using **Verilog HDL** and verified using extensive testbenches written to meticulously monitor the working of each instruction. The design involves a **5-Stage Pipelined Architecture** with 5 different Instructions along with a in-built cryptographic unit for encryption/decryption operations. The processor supports 20 different types of instruction opertions with additional spaces left for future inclusion. 

The processor supports a modular datapath, multiple instruction formats, and extensibility for specialized operations such as **cryptography** and **FFT**.  

All modules are integrated in a **top module** (`cus19_top_module.sv`) and tested with **Extensive testbenches**. Simulation and waveform verification were performed in **ModelSim** and **EDA Playground (EPWave)**.  

---

## 🚀 Features  

### 🔹 Custom ISA (CUS19)  
- **19-bit fixed instruction width**  
- **Instruction Formats**:  
  - **R-type** → Register-to-register operations  -  Arithemtic and Logical Operations
  - **M-type** → Immediate / memory addressing  -  Load and Store Operations
  - **B-type** → Branching and conditional jumps  -  Branch Operations 
  - **J-type** → Unconditional jumps  -  Jump, Call and Return Operations
  - **S-type** → Special instructions (FFT, Encryption, Decryption)  - Special Application - Cryptographic Operations 
- **Prioritized instruction decode logic** for smooth execution flow  

---

### 🔹 Datapath Components  
- **Program Counter (PC)** with increment and branch update logic  
- **Instruction Memory** with preloaded test instructions  
- **Decoder** for extracting opcode, funct, registers, and immediates  
- **Control Unit** for generating control signals  
- **Register File (16 × 8-bit general purpose registers)**  
- **ALU** supporting:  
  - Arithmetic: ADD, SUB, MUL, DIV  
  - Logical: AND, OR, XOR, XNOR, NOR, NAND  
- **Branch Unit** for conditional execution  
- **Load Unit** (read from memory into registers)  
- **Store Unit** (write from registers into memory)  
- **Data Memory** for program data storage  

---

### 🔹 Specialized Units  
- **Cryptography Unit** → placeholder hooks for **encryption/decryption instructions**   
---


- **Example Instruction Programs** preloaded in instruction memory  

---

## 🏗️ Repository Structure  
