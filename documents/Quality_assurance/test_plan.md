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

The testing will be executed by the Q.A., with the possible assistance of the Software Engineers and the Program Manager. In fact, the test cases will be accomplished in a way the tester is currently playing the game.

### 2.2.Performance Testing
This testing deals about the clock timing, where the game logic follows the clock cycle allowed by the FPGA module. Furthermore, it will allow to measure the latency and the refresh rate of the game.

The Q.A. and the Tech Lead will be the involved testers, where various softwares and tools would be required to measure the performance. In reality, the goal will be to test the game by monitoring the player's actions and the game's responses.

### 2.3.Stress Testing
Stress Testing is particular, because it involves inconsistent conditions such as simulating multiple inputs or slow loading conditions.

The Q.A., possibly accompanied by the Software Engineers and the Tech Lead, will work on that type of testing. For that, they will pretend to play the game in an "agressive manner" and use a software to simulate a slow latency.

### 2.4.Hardware Testing
This one will be required because it's focused on the use of the FPGA module. Indeed, we will have to make sure the module will handle the required program of the game, that its components like switches and lead still work, and potentially display the level number on his LCD screen.

The Q.A. will work on that testing with the assistance of the Tech Lead, where they will test various programs to ensure the hardware performance of the FPGA module.

### 2.5.User Interface Testing
User Interface Testing, as its name implies, deals with the interaction between the user and the game's interface. Indeed, it will test if the games responds well to the player's inputs and if the game's screen displays correctly on a monitor or another device.

Once again, the Q.A. will be in charge of the test, but with the possible assistance of the Software Engineers and the Program Manager. For that, they will execute various inputs with the keyboard and monitor differents screen settings to visualize the game.

### 2.6.Regression Testing
Finally, Regression Testing should be done after one or several others types of testing have been tested. Indeed, bugs will potentially appear, and after fixing them, there is a huge chance we will have to execute the previous test cases again to ensure their functionnality.

Every involved testers from previous testings, led by the Q.A., will be in charge with the previous rules decided for each testing.

## 3.Features to test

### 3.1.Functional Testing

#### Frogger
| Test Name | Description | Number of steps |    Steps list     |    Expected    |       Got       |       Priority       | 
| --------- | ----------------- | -------------------- |    ---------------     |    --------    |       ---       |       ---       | 
| Frog Generation | Ensures to generate the Frog at his strating point on the screen.| 3 |    1. Start the game. <br /> 2.Set a generateFrogger() signal. <br /> 3. Wait for a few clock cycles to allow the frog's generation. <br />  |    Frogger is generated at his starting point.    |     TO BE TESTED.       |     High     |
| Frog Length Movement | We set a movement input signal to make the frog move from 1 tile to another.| 5 |    1. Start the game. <br />  2. Generates the frog.  <br /> 3. Wait for a few clock cycles to allow the frog's generation. <br /> 4.Set a movement input signal. <br /> 5. Wait for a few clock cycles to allow frog's movement. <br />  |    The frog's moves by only 1 tile.    |     TO BE TESTED.       |     High     |
| Right Movement | We set a movement input signal  to make the frog go to the Right.| 5 |    1. Start the game <br />  2. Generates the frog.  <br /> 3. Wait for a few clock cycles to allow the frog's generation. <br /> 4. Set the Right Key input signal.<br /> 5. Wait for a few clock cycles to allow frog's movement.  |    The frog's moves 1 tile on the Right.    |     TO BE TESTED.       |     High     |
| Left Movement | We set a movement input signal to make the frog go to the Left.| 5 |    1. Start the game <br />  2. Generates the frog.  <br /> 3. Wait for a few clock cycles to allow the frog's generation. <br /> 4. Set the Left Key input signal. <br /> 5. Wait for a few clock cycles to allow frog's movement.  |    The frog's moves 1 tile on the Left.    |     TO BE TESTED.       |     High     |
| Up Movement | We set a movement input signal to make the frog go Up.| 5 |    1. Start the game <br />  2. Generates the frog.  <br /> 3. Wait for a few clock cycles to allow the frog's generation. <br /> 4. Set the Up Key input signal. <br /> 5. Wait for a few clock cycles to allow frog's movement. |    The frog's moves 1 tile upwards.    |     TO BE TESTED.       |     High     |
| Down Movement | We set a movement input signal to make the frog go to the Right.| 5 |    1. Start the game <br />  2. Generates the frog.  <br /> 3. Wait for a few clock cycles to allow the frog's generation. <br /> 4. Set the Down Key input signal.  <br /> 5. Wait for a few clock cycles to allow frog's movement.  |    The frog's moves 1 tile downwards.    |     TO BE TESTED.       |     High     |
| Sprite Rotation | We set a movement input signal different from the actual frog's direction to make him turn.| 5 |    1. Start the game <br />  2. Generates the frog.  <br /> 3. Wait for a few clock cycles to allow the frog's generation. <br /> 4. Set a movement input signal different from the frog's actual direction.  <br /> 5. Wait for a few clock cycles to allow frog's movement.  |    The frog's sprite is rotated in the same direction than the last movement input.    |     TO BE TESTED.       |     High     |
| Walking Animation | We set a movement input signal to play the frog's walking animation.| 5 |    1. Start the game <br />  2. Generates the frog.  <br /> 3. Wait for a few clock cycles to allow the frog's generation. <br /> 4. Set any movement input signal.  <br /> 5. Wait for a few clock cycles to allow frog's movement.  |    The frog's moving animation is triggered.    |     TO BE TESTED.       |     Medium     |

#### Cars

| Test Name | Description | Number of steps |    Steps list     |    Expected    |       Got       |       Priority       | 
| --------- | ----------------- | -------------------- |    ---------------     |    --------    |       ---       |       ---       | 
| Single Car | There should be at least on car appearing on the screen.| 3 |    1. Start the game <br /> 2. Set a generateCar() signal.  <br /> 3. Wait for a few clock cycles to allow car generation. |    A car sprite appears on the road, within 1-2 seconds of setting generateCar().   |     TO BE TESTED.       |     High     |
| Left Movement | A car moves to the left throughout a lane.| 5 |    1. Start the game <br /> 2. Set a generateCar() signal.  <br /> 3. Wait for a few clock cycles to allow car generation. 4. Set the moveCarLeft() signal.  5. Wait for a few clock cycles to allow car movement. |    A car sprite appears on the screen, within 1-2 seconds of setting generateCar(), starts moving left, and passes through its lane smoothly.   |     TO BE TESTED.       |     High     |
| Right Movement | A car moves to the right throughout a lane.| 5 |    1. Start the game <br /> 2. Set a generateCar() signal.  <br /> 3. Wait for a few clock cycles to allow car generation. 4. Set the moveCarRight() signal.  5. Wait for a few clock cycles to allow car movement. |    A car sprite appears on the screen, within 1-2 seconds of setting generateCar(), starts moving right, and passes through its lane smoothly.      |     TO BE TESTED.       |     High     |
| Car Rotation | A car's sprite is rotated on the right or left depending on its movement.| 5 |    1. Start the game <br /> 2. Set a generateCar() signal.  <br /> 3. Wait for a few clock cycles to allow car generation. 4. Set a car movement input signal.  5. Wait for a few clock cycles to allow car movement.  |    A car sprite appears on the road, within 1-2 seconds of setting generateCar(), and its sprite is rotated in the same direction than its actual movement.   |     TO BE TESTED.       |     High     |
| Car Right Generation | A car appears from the right side of the road and moves to the left throughout a lane.| 5 |    1. Start the game <br /> 2. Set a generateCarFromRight() signal.  <br /> 3. Wait for a few clock cycles to allow car generation. 4. Set the moveCarLeft() signal.  5. Wait for a few clock cycles to allow car movement. |    A car sprite progressively appears from the right of the screen, within 1-2 seconds of setting generateCarFromRight(), starts moving left, and passes through its lane smoothly.   |     TO BE TESTED.       |     High     |
| Car Left Generation | A car appears from the left side of the road and moves to the right throughout a lane.| 5 |    1. Start the game <br /> 2. Set a generateCarFromLeft() signal.  <br /> 3. Wait for a few clock cycles to allow car generation. 4. Set the moveCarRight() signal.  5. Wait for a few clock cycles to allow car movement. |    A car sprite progressively appears from the left of the screen, within 1-2 seconds of setting generateCarFromLeft(), starts moving right, and passes through its lane smoothly.   |     TO BE TESTED.       |     High     |
| Set Car speed | Permit to set a different speed to a moving car.| 6 |    1. Start the game <br /> 2. Set a generateCar() signal.  <br /> 3. Wait for a few clock cycles to allow car generation. 4. Set the movingCar() signal. 5. Set the sprite speed. 6. Wait for a few clock cycles to allow car movement. |    A car sprite appears on the road, within 1-2 seconds of setting generateCar(), and moves at the set speed.   |     TO BE TESTED.       |     High     |
| Increase Car Speed | Increases the speed of a moving car.| 7 |    1. Start the game <br /> 2. Set a generateCar() signal.  <br /> 3. Wait for a few clock cycles to allow car generation. 4. Set the movingCar() signal. 5. Wait for a few clock cycles to allow car movement. 6. Set the increaseCarSpeed() signal.  7. ait for a few clock cycles to allow speed increase. |    A car sprite appears on the road, within 1-2 seconds of setting generateCar(), and its speed is slightly increased.   |     TO BE TESTED.       |     Medium     |
| Varying Car Widths | Ensure cars can be generated with a different width (small/large).| 4 |    1. Start the game <br /> 2. Set a generateCar() signal.  <br /> 3. Set the car's width.  4. Wait for a few clock cycles to allow car generation. |    A car sprite appears on the road, within 1-2 seconds of setting generateCar(), and its sprite is as large as its set width.   |     TO BE TESTED.       |     Medium     |

#### Collision

| Test Name | Description | Number of steps |    Steps list     |    Expected    |       Got       |       Priority       | 
| --------- | ----------------- | -------------------- |    ---------------     |    --------    |       ---       |       ---       | 
| Car Collision with Frog | Detects a collision between the car and the frog.| 3 |    1. Start the game <br /> 2. Set a generateCar() signal.  <br /> 3. Wait for a few clock cycles to allow car generation. |    A car sprite appears on the road, within 1-2 seconds of setting generateCar().   |     TO BE TESTED.       |     High     |

#### Game Rules

| Test Name | Description | Number of steps |    Steps list     |    Expected    |       Got       |       Priority       | 
| --------- | ----------------- | -------------------- |    ---------------     |    --------    |       ---       |       ---       | 
| One Car per Lane | Ensure only one car can occupy a lane at any time.| 6 |    1. Start the game <br /> 2. Set a generateCar() signal.  <br /> 3. Wait for a few clock cycles to allow car generation. 4. Attempt to generate another car in the same lane.<br /> 5. Wait for a few clock cycles.<br /> 6. Verify the game prevents the second car from appearing in the same lane. |    Only one car appears in the lane, and the game prevents the second car from being generated in that lane.   |     TO BE TESTED.       |     Medium     |
| Several cars in a Lane | Ensure that several moving cars can occupy a lane at any time. Can be tested for a more challenging game.| 6 |    1. Start the game <br /> 2. Set a generateCar() signal.  <br /> 3. Wait for a few clock cycles to allow car generation. 4. Generate another car in the same lane.<br /> 5. Wait for a few clock cycles.<br /> 6. Verify the game allows the second car from appearing in the same lane. |    2 cars are actually moving smoothly through the same lane, in the same direction, one after another.   |     TO BE TESTED.       |     Low     |


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