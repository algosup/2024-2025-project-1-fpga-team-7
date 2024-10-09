
# Technical Specification

| Project | Language | Hardware | School | Year | Team |
|-|-|-|-|-|-|
| Frogger Game | Verilog | - Go Board (**FPGA** technology) <br> - VGA Monitor and Cable | ALGOSUP | 2024-2025 | 7 |

#### *Last Update on October 4th, 2024*
![alt text](<data/fpga circuit illustration.jpeg>)

<details>

<summary>

# Table of Content  

</summary>

- [Technical Specification](#technical-specification)
      - [*Last Update on September 24th, 2024*](#last-update-on-september-24th-2024)
- [Table of Content](#table-of-content)
  - [Document Purpose](#document-purpose)
  - [Document Audience](#document-audience)
- [The Project](#the-project)
  - [Overview](#overview)
  - [Members](#members)
  - [Description](#description)
- [The Implementation](#the-implementation)
  - [The project](#the-project-1)
      - [1. Project files architecture](#1-project-files-architecture)
      - [2. Naming conventions](#2-naming-conventions)
      - [3. GitHub rules](#3-github-rules)
  - [The Hardware](#the-hardware)
    - [I. The Go Board](#i-the-go-board)
    - [II. The VGA Screen](#ii-the-vga-screen)
  - [The code](#the-code)
    - [I. Introduction about Verilog and FPGA](#i-introduction-about-verilog-and-fpga)
      - [1. Inside](#1-inside)
      - [2. Parallelism of execution](#2-parallelism-of-execution)
      - [3. Modules and Instanciation](#3-modules-and-instanciation)
      - [4. To go Further...](#4-to-go-further)
    - [II. Algorithm Desccription](#ii-algorithm-desccription)
    - [III. Code files architecture](#iii-code-files-architecture)
      - [1. Base files](#1-base-files)
      - [2. Independant Modules](#2-independant-modules)
        - [VGA related modules](#vga-related-modules)
        - [Switch related modules](#switch-related-modules)
        - [Seven segments display related module](#seven-segments-display-related-module)
        - [Pseudo-Random generator module](#pseudo-random-generator-module)
      - [3. Game algorithm's module](#3-game-algorithms-module)
        - [Global module](#global-module)
        - [Game logic module](#game-logic-module)
        - [Game design module](#game-design-module)
    - [IV. Coding conventions](#iv-coding-conventions)
- [Glossary](#glossary)
- [](#)

</details>


## Document Purpose

The content of this document aims to detail and explain all the technical aspects of the project. <br>
The question it answers is "**HOW to implement, technically, the decisions specified in the Functional Specification document ?**"<br>

The **Software Engineers** should find in it, all the implementation processes, conventions, choices and explanations required by the developers in order to deliver a structured, optimized, readable, and sustainable code.

## Document Audience
This document is primarily intended to

- **Software Engineers** - to understand the user and technical requirements, be guided in decision-making and planning. Help them understand risks and challenges, customer requirements, and additional technical requirements based on the made choices.

But also to 

- **Program Manager** - to validate against the functional specification, and the client expectations
- **Quality Assurance** - to aid in preparing the test plan and to use it for validating issues.
- **Project manager** - to help identify risks and dependencies


# The Project
→ [link to the GitHub of the project](https://github.com/algosup/2024-2025-project-1-fpga-team-7)
## Overview

This student project, given by [ALGOSUP](https://github.com/algosup), is about coding the game *Frogger*, using a *Go Board* (based on **FPGA** technology), with the language *Verilog*. All the requirements as well as the game design and logic, are detailed in the [Functional Specification](https://github.com/algosup/2024-2025-project-1-fpga-team-7/blob/main/documents/Functional_specification/functional_specification.md) of the project.


## Members
| Role | Name | Author of |
|---|---|---|
| Project Manager | [Laurent BOUQUIN](https://github.com/laurentbouquin) | Project Planning |
| Program Manager   | [Pavlo PRENDI](https://github.com/PavloPrendi) | [Functional Specification](https://github.com/algosup/2024-2025-project-1-fpga-team-7/blob/main/documents/Functional_specification/functional_specification.md) |
| Technical Leader  | [Benoît DE KEYN](https://github.com/benoitdekeyn) | [Technical Specification](https://github.com/algosup/2024-2025-project-1-fpga-team-7/blob/main/documents/Technical_specification/technical_specification.md) |
| Software Engineer | [Maxime THIZEAU](https://github.com/MaximeTAlgosup) | Source Code |
| Software Engineer | [Tino GABET](https://github.com/Furimizu) | Source Code |
| Quality Assurance | [Paul NOWAK](https://github.com/PaulNowak36) | [Test Plan](https://github.com/algosup/2024-2025-project-1-fpga-team-7/blob/main/documents/Quality_assurance/test_plan.md) |
| Technical Writer  | [Thomas PLANCHARD](https://github.com/thomas-planchard) | User Manual |


## Description

 Will be updated according to the functionnal specification, for each aspect linked to technical choices.

 <br><br>



# The Implementation



## GitHub

#### 1. GitHub files architecture

```  
origin  
│
├── documents
│    │
│    ├── Management
│    │   ├── data
│    │   ├── Weekly_report.md
│    │   └── Project_planning.md
│    │
│    ├── Functional_specifications
│    │   ├── data
│    │   └── Functional_specifications.md
│    │
│    ├── Quality_assurance
│    │   ├── data
│    │   └── Test_plan.md
│    │
│    ├── User_manual
│    │   └── User_manual.pdf
│    │
│    └── Technical_specifications
│        ├── data
│        └── Technical_specifications.md
│
├── src
│    │
│    ├── apio.ini
│    ├── Go_Board_Constraints.pcf
│    ├── Frogger_Games.v
│    └── ... (modules)
│
└── README.md
```

#### 3. GitHub rules

- The main branch is protected from direct push and merge.  
- To update the main branch, the pull request needs 2 external validations from anyone else.  
- A 'dev' branch is here to push all the source code
- A 'documents' branch is here to push all the documents
- Each member have to commit and push changes at least daily, with an explicit tittle and a complete description of the changes.
- branches' names follow ```kebab-case```

## The Hardware

Here is only the description of the harware provided by the project

#### 1. The Go Board

For this project, we have been given a 'Go Board'.
Here is the official website of this board : https://nandland.com/the-go-board/  
THis Go Board hadbeen designed to meet the needs of the game while remaining simple to use. As we can see, there's already, on the board itself a bunch of usefull components for video games.

![The Go Board](data/go_board.png)

The main component of this board is an FPGA chip :   
The [Lattice iCE40 - HX1K](https://www.latticesemi.com/ice40)  

Here is the [Datasheet](data/FPGA_ice40HX1K_datasheet.pdf) of this FPGA

The main information to keep in mind is : 
![HX1K Characteristics](data/HX1K_characteristics.png)

Thus, the FPGA contains 1280 Logic Cells (either LUT or Register) and 16 384 bits of 'BLock RAM' memory.

#### 2. The VGA Screen

## The code

### I. Introduction about Verilog and FPGA

#### 1. Inside

#### 2. Parallelism of execution

#### 3. Modules and Instanciation

#### 4. Steps to upload the code

#### 5. To go Further...

### II. Algorithm Desccription

Future Algorigram to describe the evolution of the state machine, interaction between the different modules and memory units.

### III. Code files architecture

#### 1. Base files

- **apio.ini**  
  Needed by the synthetizer to know wich is the top module to execute.
- **Go_Board_Constraints.pcf**  
  Contains the attribution of each GPIO to a name. This names are used at the beginning of the top module.
- **Frogger_Game.v**   
  Main file containing the top module. It serves to declare, include and link the different pieces of the code.

#### 2. Independant Modules

Theses modules are some universal modules, which can be used in many different types of FPGA projects. They are not containing any code related to the game algorithm.

##### VGA related modules
- **VGA_Sync_Pulses.v**   
  Generates the horizontal and vertical synchronization signals for the VGA output.
- **VGA_Sync_Porch.v**  
  Change a bit the pulses of the previous module to take the VGA porches into account.
- **Sync_To_Count.v**  
  Generates 2 counters, one for the columns, and another for the rows, synchronized with both pulses, to keep track of wich pixel is going to be written on the VGA output.

##### Switch related modules
- **Debounce_Filter.v**  
  Module which takes the switch signal and output a 'debounced' signal of the switch. Basically, it allows the output signal to fit the input signal aafter validating its stability over time.
- **Spam_Signal.v**  
  It reads a signal, and if it remains HIGH for too long time, this module generates a square wave that can be used as a second input.
  Useful for allowing an action to loop if a button is held down for a long time.

##### Seven segments display related module
- **Seven_Segments_Display.v**  
  Takes a binary input and handle the display the coresponding character on the 7 segments display.

##### Pseudo-Random generator module
- **LFSR.v**  
  This module can generate pseudo-random numbers.

#### 3. Game algorithm's module

These modules are containing all the code directly related to the game logic and handling the game design.

##### Global modules
- **Constants.v**  
  In this file, each constant value are stored as a label, usable trough all the files.
- **Memory.v**  
  This file is here to define the memory modules needed to store each sprite

##### Game logic module
- **State_Machine.v**  
  In this file, the variables keeping track of the current state of the game.
  This file handle modules instantiation.
- **Clock_Divider.v**
  This file generates the different clocks used to delay the update frequency of movement or display.
  it take as input the wanted speed for each sprite-related always loop.
- **Levels.v**  
  This module handle all the modifications such as speed, car position, related to the level increase.
- **Sprite_Position.v**
- **Character_Control.v**
- **Obstacles_Movement.v**
- **Collisions.v**

##### Game design module
- **Sprite_Definition.v**
- **Sprite_Display.v**
- **Background_Display.v**

### IV. Coding conventions


# Glossary

This glossary is here to help to understand the technical vocabulary of this document. 

| Term | Definition |
| ---- | ---------- |
| FPGA | A field-programmable gate array (FPGA) is a type of programmable microcontroller, where you can program only the components you need to create your integrated circuit. FPGAs are often used in custom-made products, and in research and development. Other applications for FPGAs include aerospace or industrial sectors, due to their flexibility, high signal processing speed, and parallel processing abilities. |
| Verilog | Verilog is one of the language used to program FPGAs. |

# 
