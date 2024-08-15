# cpu_16bits

16 bits cpu using the vhdl, a hardware language description

![](documentation/processor_schematic.png)

### Table of contents

**[Resources](##Resources)** <br>
**[Instructions](#instructions)** <br>
**[FSM](#fsm)** <br>
**[Observations](#observations)** <br>
**[Tests](#tests)** <br>

## Resources

This cpu contain:

* Memory access 
* Aritmetich operations
* 16 bits instruction (like MIPS)
* Stack Operations
* IO operations
* Control flux operations
* The new version includes a IO module as a RAM and a especific register for the stack operations, the SP (stack pointer)

## Instructions

First version
![Instructions](documentation/Especificação.png)
Second version, with the same as the first and more
![Instructions2](documentation/specification2.png)

* This processor has load, store and mov operations with immediate values and ram values
* Also has 11 operations with ALU
* Control flux of program with jmp operations
* IO Operations
* Stack operations

## FSM

![FSM](documentation/FSM.png) FSM transitions

![FSM_table](documentation/FSM_table.png) 
Values of each fsm state

* This FSM represent each state of cpu instructions

* NOP state represent an state with make nothing
* HALT state represent an state with cpu "die"

## Observations

* The ROM of this repository contain some sequence of instructions pre defined
* For testing your program, is recommended modify the values for varied sequence of instructions
* This processor is testing by the following sequence of instructions
    * MOV R0, 0x02  
    * LDR R1, [R0]
    * MOV R0, 0x04
    * LDR R2, [R0]  
    * ADD R1, R1, R2
    * MOV R0, 0X06  
    * STR [R0], R1 
    *  HALT
* But, also sequence of valid instruction can run since the correct binary(oh hexadecimal) value be provided 
        
## Tests
* All components were tested individually with their respective testbenches and their integrations were tested on the CPU testbench

* Below, some more relevant tests are exemplified

CPU:
![CPU](img/cpu_testbench.png) 
FSM:
![FSM_test](img/fsm_testbench.png)
ALU:
![ULA](img/ula_testbench.png)
