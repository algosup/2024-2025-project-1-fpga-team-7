# Test Plan 

| Author        | Paul NOWAK (Q.A.) |
|---------------|------------ |
| Created       | 09/28/2024  |
| Last Modified | 09/29/2024  |
| Document Deadline | 10/21/2024  |

---

<details>

<summary>📖 Table of content</summary>

- [Introduction](##introduction) 
- [1.Objectives](##1.objectives) 
- [2.Testing Strategy](##2.testing-strategy) 
 - [2.1.Functional Testing](###2.1.functional-testing) 
 - [2.2.Performance Testing](###2.2.performance-testing) 
 - [2.3.Stress Testing](###2.3.stress-testing) 
 - [2.4.Hardware Testing](###2.4.hardware-testing) 
 - [2.5.User Interface Testing](###2.5.user-interface-testing) 
 - [2.6.Regression Testing](###2.6.regression-testing) 
- [3.Features to test](##3.features-to-test)
 - [3.1.Functional Testing](###3.1.functional-testing) 
 - [3.2.Performance Testing](###3.2.performance-testing) 
 - [3.3.Stress Testing](###3.3.stress-testing) 
 - [3.4.Hardware Testing](###3.4.hardware-testing) 
 - [3.5.User Interface Testing](###3.5.user-interface-testing) 
 - [3.6.Regression Testing](###3.6.regression-testing) 
- [4.Features to not test](##4.features-to-not-test) 
- [5.Hardware Requirements](##5.hardware-requirements) 
- [6.Environment Requirements](##6.environment-requirements) 
- [7.Test Schedule](##7.test-schedule) 
- [8.Problem Reporting](##8.problem-reporting) 
- [9.Risks & Assumptions](##9.risks-&-assumptions) 
- [10.Approvals](##10.approvals) 

</details>

---

## Introduction

## 1.Objectives 

## 2.Testing Strategy
The test cases will be separated in 6 different domain of testing. Indeed, we want to check each type individually to ensure their performance before testing the cases together.

### 2.1.Functional Testing
Probably the most important, this first type of testing concerns the game logic: its goal is to ensure the game's functions work correctly, such as the player movements, the collisions and the reset conditions.

The testing will be executed by the Q.A., with the possible assistance of the Software Engineer and the Program Manager. In fact, the test cases will be accomplished in a way the tester is currently playing the game.

### 2.2.Performance Testing
This testing deals about the clock timing, where the game logic follows the clock cycle allowed by the FPGA module. Furthermore, it will allow to measure the latency and the refresh rate of the game.

The Q.A. and the Tech Lead will be the involved testers, where various softwares and tools would be required to measure the performance. In reality, the goal will be to test the game by monitoring the player's actions and the game's responses.

### 2.3.Stress Testing
Stress Testing is particular, because it involves inconsistent conditions such as simulating multiple inputs or slow loading conditions.

The Q.A., possibly accompanied by the Software Engineer and the Tech Lead, will work on that type of testing. For that, they will pretend to play the game in an "agressive manner" and use a software to simulate a slow latency.

### 2.4.Hardware Testing
This one will be required because it's focused on the use of the FPGA module. Indeed, we will have to make sure the module will handle the required program of the game, that its components like switches and lead still work, and potentially display the level number on his LCD screen.

The Q.A. will work on that testing with the assistance of the Tech Lead, where they will test various programs to ensure the hardware performance of the FPGA module.

### 2.5.User Interface Testing

### 2.6.Regression Testing

## 3.Features to test

### 3.1.Functional Testing

### 3.2.Performance Testing

### 3.3.Stress Testing

### 3.4.Hardware Testing

### 3.5.User Interface Testing

### 3.6.Regression Testing

## 4.Features to not test

## 5.Hardware Requirements

## 6.Environment Requirements

## 7.Test Schedule

## 8.Problem Reporting

## 9.Risks & Assumptions

## 10.Approvals