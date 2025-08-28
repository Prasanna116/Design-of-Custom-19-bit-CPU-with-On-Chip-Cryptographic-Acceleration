# Design-of-Custom-19-bit-CPU-with-On-Chip-Cryptographic-Acceleration


## 📌 Overview  
This project implements a **Custom RISC-style Processor** with a **19-bit fixed instruction format**, designed using **Verilog HDL** and verified using extensive testbenches written to meticulously monitor the working of each instruction. The design involves a **5-Stage Pipelined Architecture** with 5 different Instructions along with a in-built cryptographic unit for encryption/decryption operations. The processor supports 20 different types of instruction opertions with additional spaces left for future inclusion. 

The processor supports a modular datapath, multiple instruction formats, and extensibility for specialized operations such as **cryptography** and **FFT**.  

All modules are integrated in a **top module** (`cus19_top_module.sv`) and tested with **Extensive testbenches**. Simulation and waveform verification were performed in **ModelSim** and **EDA Playground (EPWave)**.  

---
<img width="8192" height="2436" alt="CPU19" src="https://github.com/user-attachments/assets/2a4e8cae-917d-4f39-8298-ddaddf3875b0" />

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

### 🔹 Processor Datapath  

- **Program Counter (PC)**  
  - Increments sequentially or updates with branch/jump addresses.  

- **Instruction Memory**  
  - Stores instruction programs in a simple array.  

- **Decoder**  
  - Extracts opcode, funct, registers, and immediates from the 19-bit instruction.  
  - Provides inputs to the control unit and datapath.  

- **Control Unit**  
  - Generates control signals for ALU operations, branching, load/store, and special units.  
  - Prioritizes execution when multiple conditions are triggered.  

- **Register File**  
  - 16 general-purpose registers, each 8-bit wide.  
  - Supports dual read and single write per cycle.  

- **Arithmetic Logic Unit (ALU)**  
  - Performs arithmetic operations (ADD, SUB, MUL, DIV).  
  - Supports bitwise operations (AND, OR, XOR, XNOR, NOR, NAND).  
  - Optimized for single-cycle execution.  

- **Branch Unit**  
  - Evaluates conditions (equal, not equal etc.).  
  - Updates PC for control-flow changes.  

- **Load/Store Units**  
  - Abstract memory access from the datapath.  
  - Enable register-to-memory and memory-to-register transfers.  

- **Data Memory**  
  - Separate from instruction memory (Harvard-style organization).  
  - Supports byte addressing.  

---

### 🔹 Specialized Units  
- **Cryptography Unit**  
  - Placeholder for AES-style encryption/decryption.  
  - Hooked into S-type instructions.   

---

### 🔹 Verification & Testing  
**Example Instruction Programs** preloaded in instruction memory  
A layered test strategy was used:  

1. **Module-level Testing**  
   - Each unit (ALU, Register File, Branch, Memory) tested with standalone SystemVerilog testbenches.  

2. **Integrated Processor Testing**  
   - Top module testbench (`cus19_top_module_tb.v`) executes small programs.  

3. **Waveform Debugging**  
   - EPWave and Modelsim viewer used for cycle-accurate tracing of signals.  
   - Verified control flow, register updates, and memory transactions.  
---

## 📊 Key Learnings  

- **ISA Design**: Balancing opcode space, field sizes, and extensibility.  
- **Modular Datapath**: Clean separation of ALU, control, memory, and special units.  
- **Control Signal Generation**: Handling priority between normal and special instructions.  
- **Verification Flow**: Importance of staged verification (module → integration → waveform).  
- **Extensibility**: Designing an ISA that can scale into **crypto/DSP accelerators**.  

---

## 📌 Future Work  

- Implement **5-stage pipelining** with hazard detection and forwarding.  
- Extend cryptography unit into a working **AES core**.  
- Build a functional **FFT datapath** and integrate with S-type ISA.  
- Synthesize on an **FPGA (Intel/AMD)** and measure performance.  
- Benchmark against existing RISC cores for comparison.  

---

## 👨‍💻 Author  

**Prasanna Venkatesh s**  








