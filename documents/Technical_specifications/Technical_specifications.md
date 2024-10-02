
# Technical Specification

| Project | Language | Hardware | School | Year | Team |
|-|-|-|-|-|-|
| Frogger Game | Verilog | - Go Board (**FPGA** technology) <br> - VGA Monitor and Cable | ALGOSUP | 2024-2025 | 7 |

#### *Last Update on September 24th, 2024*
![alt text](<data/fpga circuit illustration.jpeg>)


<details- [Technical Specification](#technical-specification)
      - [*Last Update on September 24th, 2024*](#last-update-on-september-24th-2024)
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
>

<summary>

# Table of Content

</summary>

- Project

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



## The project

#### 1. Project files architecture

#### 2. Naming conventions

#### 3. GitHub rules

## The Hardware

Here is only the description of the harware provided by the project

#### 1. The Go Board

Datasheet and specifications related to the hardware given such as the switches, LEDs, VGA, ...

#### 2. The VGA Screen

## The code

### I. Introduction about Verilog and FPGA

#### 1. Inside

#### 2. Parallelism of execution

#### 3. Modules and Instanciation

#### 4. To go Further...

### II. Algorithm Desccription

Future Algorigram to describe the evolution of the state machine, interaction between the different modules and memory units.

### III. Code files architecture

#### 1. Base files

- Apio.ini
- Frogger_Game.v 
- Go_Board_Constraints.pcf

#### 2. Independant Modules

Theses modules are some universal modules, which can be used in many different types of FPGA projects. They are not containing any code related to the game algorithm.

##### VGA related modules
- VGA_Sync_Porch.v
- VGA_Sync_Pulses.v
- Sync_To_Count.v

##### Switch related modules
- Debounce_Filter.v
- Spam_Signal.v

##### Seven segments display related module
- Seven_Segments_Display.v

##### Pseudo-Random generator module
- LFSR.v

#### 3. Game algorithm's module

These modules are containing all the code directly related to the game logic and handling the game design.

##### Global module
- Constants.v
- Memory.v

##### Game logic module
- State_Machine.v
- Update_Frequency_Settings.v
- Levels.v
- Sprite_Position.v
- Character_Control.v
- Obstacles_Movement.v
- Collisions.v

##### Game design module
- Sprite_Definition.v
- Sprite_Display.v
- Background_Display.v

### IV. Coding conventions


# Glossary

This glossary is here to help to understand the technical vocabulary of this document. 

| Term | Definition |
| ---- | ---------- |
| FPGA | A field-programmable gate array (FPGA) is a type of programmable microcontroller, where you can program only the components you need to create your integrated circuit. FPGAs are often used in custom-made products, and in research and development. Other applications for FPGAs include aerospace or industrial sectors, due to their flexibility, high signal processing speed, and parallel processing abilities. |
| Verilog | Verilog is one of the language used to program FPGAs. |

# 
