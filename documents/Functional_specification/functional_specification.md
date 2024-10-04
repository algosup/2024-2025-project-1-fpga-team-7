# Functional Specifications

<details>
<summary>

## Table of content </summary>

    - [Functional Specifications](#functional-specifications)
        - [Table of content](#table-of-content)
        -[A) Document Control](#a-document-control)
            - [1) Document information](#1--document-information)
            - [2) Document History](#2-document-history)
            - [3) Document Approval](#3-document-approval)
        - [B) Introduction](#b-introduction)        
            - [1) Glossary](#1-glossary)
            - [2) Project Overview](#2-project-overview)
            - [3) Project Definition](#3-project-definition)
                - [Vision](#vision)
                - [Requirements/Objectives](#requirementsobjectives)
                - [Deliverables](#deliverables)
            - [4) Project Organisation](#4-project-organisation)
                - [Project Representatives](#project-representatives)
                - [StakeHolders](#stakeholders)
                - [Project Roles](#project-roles)
            - [5) Project Plan](#5-project-plan)
                - [Milestones](#milestones)
                - [Dependencies](#dependencies)
                - [Resources/Financial Plan](#resourcesfinancial-plan)
                - [Assumptions/Constraints](#assumptionsconstraints)
        - [C) Functional Requirements](#c-functional-requirements)
            - [1.a) Froggers Overview](#1a-froggers-overview)
                - [Brief History](#brief-history)
                - [Objectives and Loss Condition](#objectives-and-loss-condition)
                - [Player](#player)
                - [Cars](#cars)
                - [Level](#level)
            - [1.b) Froggers Features Breakdown](#1b-froggers-features-breakdown)   
                - [Grid](#grid)
                - [Background](#background)
                - [Frog](#frog)         
                - [Cars](#cars-1)
                - [Flag](#flag)
                - [Speed](#speed)
                - [Colors](#colors)
                - [Restart](#restart)
                - [Controls](#controls)
            - [2) Personas Definition](#2-personas-definition)
            - [3) Use Case Analysis](#3-use-case-analysis)
            - [4) Functional Analysis](#4-functional-analysis)
        - [D) Non Functional Requirements](#d-non-functional-requirements)
        - [Costs](#costs)
            - [Capital Expenditures](#capital-expenditures)
                - [Material](#material)
                - [Software](#software)
                - [Time Spent/Wages](#time-spentwages)
                - [Operational Expenditures](#operational-expenditures)
                - [Energies](#energies)
        - [Reliability](#reliability)
        - [Response/Performance](#responseperformance)
        - [Operability](#operability)
        - [Recovery](#recovery)
        - [Delivery](#delivery)
        - [Maintainability](#maintainability)
        - [Security](#security)


</details>

## A) Document Control

### 1) Document Information

| Document ID | Document # 01 |
|---|---|
| Document Owner | Pavlo PRENDI |
| Issue date | 09/24/2024 |
| Last Issue Date | 09/24/2024 |
| Document Name | Functional-Specification|



### 2) Document History

| Version n° | Edits completed by | Date | Description of edit |
|---|---|---|---|
|01|Pavlo PRENDI| 10/05/2024 | Initial Release (V.01) |


### 3) Document Approval

| Role | Name | Signature | Date |
|---|---|---|---|
| Project Manager | Laurent	BOUQUIN | ✅ | **/**/2024 |
| Tech Lead | Benoit DE KEYN | ✅ | **/**/2024 |
| Software Developer | Tino	GABET | ✅ | **/**/2024 |
| Software Developer | Maxime THIZEAU |✅ | **/**/2024|
| Quality Assurance | Paul NOWAK | ✅ | **/**/2024 |

<!-- Introduction  -->

## B) Introduction 


### 1) Glossary

| Term Used | Definition | 
| --------- | ---------- |
| FPGA (Field Programmable Gate Array )| Type of configurable integrated circuit that can be repeatedly programmed. |
| Frog | A character controlled by the player. |
| Go-Board | An FPGA development board. |
| Player | The person playing the game. | 
| Sprite | a computer graphic depicting a character or environment | 
| Tile | A space located on a grid. | 
| Team | ALGOSUP team 7 (2024-2025 - projec 1) | 
| Verilog | A programming languange used to model electronic systems | 
| VGA (Video Graphics Array)| A video display controller |  

### 2) Project Overview

Our team was tasked with recreating a version of frogger, an old arcade action game using the verilog programming language, and an FPGA board called "Go Board".


### 3) Project Definition 

#### <ins>Vision</ins>

Our vision is developing a game that tries to ressemble frogger as much as possible, since it is going to run on hardware that is limited in it's capabilities.It will have a scoring system and increasing difficulty depending on which stage has been reached.

####  <ins>Requirements/Objectives</ins>

We are using the concept of **requirements** and **objectives** when describing the goals of this project.We will be on a tight deadline to ship the game, so we will need the bare minimum amount of functionality (the requirements) complete in order to satisfy the customers. However, we want the game to be as engaging as possible, and for that we have the objectives.They are not mandatory but it will help the game to be as succesfull as possible. NOTE* The **bonus** will only be added if every one of the requirements and objectives have been completed.

| Requirements |
| ----- | 
| Utilisation of Go-Board. |
| Frog can move at least in one direction. |
| Utilisation of the VGA on the Go-Board. |
| No use of other hardware. |
| Immobile cars (Have at least one on screen). |
| Game will be played on a 20x15 grid(each grid will be 32x32 pixels). |
| Game can be restarted by pressing all 4 buttons(Hold the buttons for at least 2 seconds). |
| There will be at least 1 level |
| The frog should move 1 tile at a time |
| When the frog collides with the car the game will restart. |
| There will be at least 5 rows of roads |
| The buttons will be functional at every click. |

| Objectives |
| -- |
| The frog will be a sprite with full colors. |
| The cars will be moving on the roads from left to right(there will be at least 16 max on screen). |
| The speed of the cars will increase with the difficulty. |

| Bonus | 
| -- | 
| New roads will be added with increasing difficulty. |
| The frog and cars will have slight animation. |
| There will be an end screen when you beat the game. |



####  <ins>Deliverables</ins>

| Name | Type | Deadline | Link |
| -- | -- | -- | -- |
| Functional Specifications Document | Document (markdown) | 10/07/2024 | (./functionalSpecifications.md) |
| Technical Specifications Document | Document (markdown) | 14/07/2024 | (./technicalSpecifications.md) |
| Weekly reports | Document (markdown) | Every friday | (./weeklyReports/) |
| Test Plan | Document (markdown) | 21/10/2024 | (./qualityAssurance/Test-Plan.md) | 

### 4) Project Organisation

#### <ins>Project Representatives</ins>

| Project Owner | Represented by... | 
| --- |
| **Franck JEANNIN** | Represented by himself | 
| Laurent	BOUQUIN | Represented by Pavlo PRENDI(Project Manager) | 

The project sponsors (highlighted in **bold**) are expected to be in charge of: 

- Defining the vision and high-level objectives for the project.
- Approving the requirements, timetable, resources and budget (if necessary).
- Authorising the provision of funds/resources (internal or external) (if necessary).
- Approving the functional and technical specifications written by the team.
- Ensuring that major business risks are identified and managed by the team.
- Approving any major changes in scope.
- Received Project Weekly Reports and take action accordingly to resolve issues escalated by the Project Manager.
- Ensuring business/operational support arrangements are put in place.
- Ensuring the participation of a business resource (if required).
- Providing final acceptance of the solution upon project completion.

#### <ins>Stakeholders</ins>

| Stakeholder | Might have/find an interest in.. | 
|---|---|
| Franck JEANNIN | Having the student learn Verilog |   
| ALGOSUP students | Learning Verilog and getting experience | 

#### <ins>Project Roles</ins>

As defined by the project owner (ALGOSUP), the team is arranged in the following manner:

| Role | Description | Name |
|---|---|---|
| Project Manager | Is in charge of organization, planing and budgeting.<br>Keep the team motivated.  | Laurent	BOUQUIN |
| Program Manager | Makes sure the project meets expectation.<br>Is in charge of design.<br>Is responsible for writing the Functional Specifications | Pavlo PRENDI |
| Tech Lead | Makes the technical decision in the project.<br>Translates the Functional Specification into Technical Specifications.<br> Does code review. | Benoit DE KEYN |
| Software Engineer | Writes the code.<br>Writes documentation<br>Participate in the technical design. | Tino GABET |
| Software Engineer | | Maxime THIZEAU |
| Quality Assurance |  Tests all the functionalities of a product to find bugs and issue.<br>Document bugs and issues.<br>Write the test plan.<br>Check that issues have been fixed.| Paul NOWAK |

### 5) Project Plan

<p align="center"><img src="https://github.com/algosup/2024-2025-project-1-fpga-team-7/blob/Funtionalspecifications/documents/Pictures/Functional_specifications/project_plan.png?raw=true" width="400"/></p>


#### <ins>Milestones</ins>

| Milestone | Deadline | 
|---|---| 
| Functional Specifications V1 | Monday, October 7th 2024 |
| Technical Specifications V1 | Monday, October 14th 2024 | 
| POC (pre MVP) | Tuesday, October 8th 2024 |
| MVP | Wednesday, October 23rd 2024   | 
| Oral Presentation | Friday, October 25th 2024 |  

#### <ins>Dependencies</ins>

The POC requires some prior understanding of the target technologies before being developed, meaning that its development will probably start on week 2.

The MVP requires the POC to be made first to estimate task difficulty and set objectives' viability.

The rest of the project depends on the first version of the functional specifications to be released and approved first.

#### <ins>Resources/Financial plan</ins>

We have estimated 90 man-hours total to complete this project 

=> The team (7 people)

=> Teachers

=> 1 computer per team member 

=> The book "GETTING STARTED WITH FPGAS" by Russel Merrick

#### <ins>Assumptions/Constraints</ins>
| Assumptions |
|---|
| We assume we will have no issue with the copyright of Frogger |
| The go-board is stable enough to not be a concern for reliabiity |

| Constraints |
|---|
| We have to code in Verilog |
| We have to use the go-board for the program and use it as a "controller" |
| We cannot make a commercial use of the project |

<!-- Functional Requirements -->


## C) Functional Requirements 

### 1.a) Froggers Overview

#### <ins>Brief history...</ins>
Frogger is a 1981 arcade action game developed by Konami and published by Sega. You control a small frog, and you need to cross the roads while dodging traffic and climbing on logs to reach the top.

<p align="center"><img src=".https://github.com/algosup/2024-2025-project-1-fpga-team-7/blob/Funtionalspecifications/documents/Pictures/Functional_specifications/old_frogger.png?raw=true"alt="Old frogger" width="400"/></p> 

In this picture, you can see that the frog (player) has 60 seconds to reach the top as many times as possible. The more times the frog reaches the top, the higher the final score will be.


#### <ins>Objectives and loss condition</ins>

The game objectives are twofold: 

- Get to the top of the screen without getting hit. This will earn you a point and increase the game difficulty.

- Get past the last level. Once you get past the last level the game will restart to level one.

There is one loss condition : the player collides with a car. Once that occurs the game will restart to level one.

#### <ins>Player</ins>


The player plays as a frog. 

<p align="center"><img src="https://github.com/algosup/2024-2025-project-1-fpga-team-7/blob/Funtionalspecifications/documents/Pictures/Functional_specifications/frog32x32.png?raw=true"alt="Frog" width="400"/></p> 

He can move in 4 directions: Up, Down, Left, Right. 

The frog will have moved 1 tile for every click of a directional button.

If the corresponding button is being held down the frog will not continue to go in that direction. 

#### <ins>Cars</ins>

<p align="center"><img src="https://github.com/algosup/2024-2025-project-1-fpga-team-7/blob/Funtionalspecifications/documents/Pictures/Functional_specifications/car32x32.png?raw=true"alt="Car" width="400"/></p> 

The cars will be moving on the roads from right to left and vise-versa. 

There will be at least 16 cars on screen at a time.

If the player collides with a car, the game will restart to level one.

At higher levels the cars speed will increase.

#### <ins>Level</ins>

-insert level image-

The level will increase by one every time the player reaches the top of the screen.

Additionaly with every new level the car speed will increase.

### 1.b) Frogger's features Breakdown

#### <ins>Grid</ins>

The background can be subdivided into a grid. In that grid, the Maze is made of 20 by 15 tiles. A single subdivision will be referred to as a 'Tile'. Each tile will contain 32 by 32 pixles.

#### <ins>Background</ins>

We will create a custom background closely ressembling frogger's background, excluding the river and the logs mechanic, since it is not in our objectives or requirements.
 
-instert game background.png-

#### <ins>Frog</ins>

The frog will be 32x32 pixels, positioned on the bottom center of the map. He will be able to move in any direction, not exceeding the background. 

-instert frog position.png-

#### <ins>Cars</ins>
-insert car_position.png-
The cars will be appearing from the sides of the background where the roads are positioned, from left to right and vise-versa. When a car has appeared from left to right, the next car will appear from right to left.**

#### <ins>Flag</ins>
-instert flag.png-

Once the frog has reached this point of the screen you will go to the next level and the frogs position will return to the default position.

#### <ins>Speed</ins>

-figure out different speed increases-

#### <ins>Colors</ins>

The colors used for the sprites of the frog and car will be limited to 8 colors. The reason being is that the go-board has limited memory and reducing the color usage results in better memory optimization and performance. The sprites will be stored in the Block RAM (BRAM) for multiple benefiting reasons (see the [Technical specifications](#https://github.com/algosup/2024-2025-project-1-fpga-team-7/blob/Funtionalspecifications/documents/Technical_specification/technical_specification.md) for a more detailed explanation)
but the drawback is the limitation on the color usage.

Colors utilized for the sprites : 

- Yellow - 🟨

- Green - 🟩

- Black - ⬛

- White - ⬜

- Red - 🟥


#### <ins>Restart</ins>

the game will restart once all four buttons are pressed at the same time and held for 2 seconds, no matter the condition of the game.

#### <ins>Controls</ins>

The controls will be set accordingly: 

<p align="center"><img src="https://github.com/algosup/2024-2025-project-1-fpga-team-7/blob/Funtionalspecifications/documents/Pictures/Functional_specifications/controls.png?raw=true"alt="Controls" width="400"/></p>

The reasoning behind them is we envision the go-board to be held slightly sideways to the left so the player gets a better sense of the direction they want to move.

### 2) Personas Definition

<p align="center"><img src="https://github.com/algosup/2024-2025-project-1-fpga-team-7/blob/Funtionalspecifications/documents/Pictures/Functional_specifications/new_player.png?raw=true"alt="New player" width="400"/></p>

<p align="center"><img src="https://github.com/algosup/2024-2025-project-1-fpga-team-7/blob/Funtionalspecifications/documents/Pictures/Functional_specifications/casual_player.png?raw=true"alt="Casual player" width="400"/></p>

<p align="center"><img src="https://github.com/algosup/2024-2025-project-1-fpga-team-7/blob/Funtionalspecifications/documents/Pictures/Functional_specifications/avid_gamer.png?raw=true"alt="Avid gamer" width="400"/></p>

### 3) Use Case Analysis

| Use Case Number | Name | Description | Actor(s) | Pre-conditions | Flow of events | Post-Conditions | Exit Criteria | Notes & Isssues | 
|---|---|---|---|---|---|---|---|---|
| 1 | Navigating the map | Player | The game is running | The player is able to move in all four directions with no input latency  | The frog follows the inputs of the player | The frog stops its movement on the position it was left |
| 2 | Dying | The frog collides with a car | Player | Game is running, frog is alive | Once the car surpasses the frogs first pixel the game is pauses for a second and it is restarted | The frog returns to his default spot | The game is restarted to level one | 
| 3 | Finishig a level | The frog reaches the top of the screen | Player | The frog avoided all cars and made it to the flag | the game pauses for a split second and the frog returns to his default spot | The level counter goes up by one and the game continues | 
### 4) Functional analysis
<p align="center"><img src="https://github.com/algosup/2024-2025-project-1-fpga-team-7/blob/Funtionalspecifications/documents/Pictures/Functional_specifications/functional_analysis.png?raw=true"alt="Functional analysis" width="400"/></p> 

## D) Non-Functional Requirements

### Costs

#### <ins>Capital Expenditures</ins>

##### <ins>Material</ins>

- Go-board

- Monitor

- VGA cable 

- VGA to HDMI converter

##### <ins>Software</ins>

- Verilog

##### <ins>Time spent/Wages</ins>

- Estimated 90 hours each 

##### <ins>Operational Expenditures</ins>

##### <ins>Energies</ins>
- Cost of electricity for the hardware
### Reliability 

- Has to be bug free

- Should not crash

- Inputs should be fully functional(no latency)

### Response/Performance

- Should run at 30 fps 

- Should respond under 80 ms 

### Operability

- Should run on all OS the go-board is connected to

### Recovery 

- Should reset to default state in case of crash

### Delivery 

- As a free software with no commercial purpose, available to download on Github

### Maintainability 

- Commented and documented code

    ### Security

- No network Connection