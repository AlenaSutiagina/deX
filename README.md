# deX - Software Requirements Specification 

## Table of contents
- [Table of contents](#table-of-contents)
- [Introduction](#1-introduction)
    - [Purpose](#11-purpose)
    - [Scope](#12-scope)
    - [Definitions, Acronyms and Abbreviations](#13-definitions-acronyms-and-abbreviations)
    - [References](#14-references)
    - [Overview](#15-overview)
- [Overall Description](#2-overall-description)
    - [Vision](#21-vision)
    - [Use Case Diagram](#22-use-case-diagram)
	- [Technology Stack](#23-technology-stack)

## 1. Introduction

### 1.1 Purpose
This Software Requirements Specification (SRS) describes all specifications for the application "deX". It includes an overview about this project and its vision, detailed information about the planned features and boundary conditions of the development process.


### 1.2 Scope

This document will outline the development process of the project. deX allows users to create index cards for more efficient learning. The functionality will be explained in detail in the following points.

### 1.3 Definitions, Acronyms and Abbreviations
| Abbrevation | Explanation                            |
| ----------- | -------------------------------------- |
| SRS         | Software Requirements Specification    |

### 1.4 References

| Title                                                              | Date       | Publishing organization   |
| -------------------------------------------------------------------|:----------:| ------------------------- |
| [deX Blog](https://dexcards.wordpress.com)                         | 07.10.2021 | deX Team                  |


### 1.5 Overview
The following chapter provides an overview of this project with vision and Overall Use Case Diagram. 
    
## 2. Overall Description

### 2.1 Vision
The goal of this project is to create an Android app with the index cards learning concept. 
Inspired by the concepts of efficient learning we’d decided to make an app for preparing shared index cards, where students, who had ever studied the same subject, taught by a same professor, can all the time add, adjust and upgrade cards, so that they can delegate the work and start the exam preparation much earlier.

The functionality we want to provide:

- Creating the stack of cards for each subject and professor;
- Adding new cards to each stack;
- Possibility to study together with your learning group;
- Possibility to save all relevant index cards in your working directory to have faster access.

### 2.2 Use Case Diagram
<img src="SRS_dex.drawio.png" alt="drawing" width="50%" />


### 2.3 Technology Stack
The technologies we use are:

Backend:
- Flutter
- Firebase

Frontend:
- Flutter

IDE:
- Visual Studio Code

Project Management:
- YouTrack
- GitLab
- Discord
- WhatsApp

Deployment:
- PlayStore console

## 3. Specific Requirements

### 3.1 Functionality
This section will explain the different use cases, you could see in the Use Case Diagram, and their functionality.  
Until December we plan to implement:
- 3.1.1 Creating a card
- 3.1.2 Creating a stack of cards
- 3.1.3 Showing a card


#### 3.1.1 Creating a card
This feature is the essential one of our project. The user gets the possibility to create an index card for the current stack. Before creating card they have to create a stack of cards for specific subject.

[Creating a card](./UC1_Create_Card.md)

#### 3.1.2 Creating a stack of cards
This feature provides the possibility to create a stack of index cards for specific subject.

[Creating a stack of cards](./UC2_Create_Stack.md)

#### 3.1.3 Showing a card
This feature provides a basic overview over the current card. All cards of current stack will be visible there here. From this overview you can either show the next or last card, or save current card to favourites.

[Showing a card](./use_cases/UC3_ShowCard.md)


