<div id="top"></div>
<!--
README to be edited according to the need.
-->
# AutoRef-Project-MSD2023
<!--MSD_2023 Autonomous Referee Project-->

Folders are rearranged.
Code Base folder has all the Codes
Report folder has everything else



## Table of Content

Reports -> PMP, System Architecture, Registers, Meetings,  Techincal report, Executive summary, Final Presentation, Gantt Chart, feasibility study, LinkedInPost

Codes -> 

1. [About The Project](#about-the-project)
<!--2. [Scope of the Project](#scope-of-the-project)-->
2. [System Architecture](#system-architecture)
<!--4. [Feasibility Studies](#feasibility-studies)-->
3. [Method and Procedure](#method-and-procedure)
4. [Implementation and Validation](#implementation-and-validation)
5. [How to get smooth start](#how-to-get-smooth-start)
6. [Suggestion for improvement](#suggestion-for-improvement)
7. [Team](#team)
8. [Contents of the Folders](#contents-of-the-folders)
9. [Reference](#Reference)



<!-- ABOUT THE PROJECT -->
## About The Project

<!--The Autonomous Referee Project started with MSD-2015 with aim of autonomously refereeing a robot soccer match. The Assistant Referee System we developed will be assisting the referee informing which team touched the ball the last time before the ball went out of play. The project will be assisting the referees in officiating the Robocup Middle Size League (MSL) using real-time object tracking technologies and machine learning methodologies. 
-->
The Autonomous Referee Project, initiated during MSD-2015, was conceived with the ambitious goal of autonomously officiating robot soccer matches. Our primary objective was to develop an Assistant Referee System designed to support human referees by providing crucial information regarding which team last made contact with the ball before it exited the field of play.

This system represents a significant advancement in the field of robotics and sports technology. By harnessing real-time object tracking technologies and leveraging sophisticated machine learning methodologies, our project aimed to bridge the gap between traditional human-led officiating and cutting-edge automation.

Specifically tailored for deployment in the Robocup Middle Size League (MSL), our project sought to revolutionize the way matches are officiated within this competitive arena. Through the seamless integration of state-of-the-art technologies, we envisioned a future where referees are empowered with enhanced decision-making capabilities, ensuring fair play and accurate adjudication in every match.


<!-- Scope of the project 
## Scope of the Project 

a
d
d

T
h
i
n
g
s

h
e
r
e

-->

<!-- System Architecture -->
## System Architecture

The system architecture is developed using the ideas of systems thinking. The document is in the folder "System Architecture" in "Reports". The document aims to offer a thorough insight into the design of the system, enabling stakeholders to grasp the system’s functionality, needs and requirements and system context diagram. Starting from the stakeholder’s needs and translating those to requirements and specifications, the document outlines how the project proceeds to solution domain.

<!-- Feasibility Analysis 
## Feasibility Studies

a
d
d

T
h
i
n
g
s

h
e
r
e
-->
<!-- Method and procedure -->
## Method and Procedure
Utilizing OptiTrack technology for ball and robot tracking, our collision detection system   employs three distinctive methodologies: 

- The cameras are used to acquire the position of the ball center and robot position. The data was then filtered to remove noise.  

- A robust machine learning approach is embraced, employing an ensemble of 80 estimators within a random forest classifier. This model utilizes features including vectorized distances between robots and the ball, along with the Euclidean distance. This machine learning method is favored for its resilience and ability to handle intricate interactions. 
a
d
d

T
h
i
n
g
s

h
e
r
e


<!-- Implementation and Validation -->
## Implementation and Validation

a
d
d

T
h
i
n
g
s

h
e
r
e

 <!-- How to get smooth start -->
## How to get smooth start

- It is recommended to not start from the scratch.
- Study the documents regarding the previous groups.
- It is highly recommended to get in touch with the Tech United team and use the Tech United repository in case of using TURTLEs. <br />
  Some of the people that you can get in touch with:<br />
  Tech United Website: https://www.techunited.nl/en/<br />
  Tech United (Techunited@tue.nl)<br />
  René van de Molengraft - Project Sponsor and Technical Consultant (M.J.G.v.d.Molengraft@tue.nl)<br />
  Ruben Beumer (r.m.beumer@tue.nl) <br />


- Ask for permission for using the surveillance cameras at the Robotics Lab.
  You may contact Ömür Arslan (o.arslan@tue.nl) to ask for the permission.
- Get in touch with MSD2023-25.
- Get in touch with Matthias Briegel<br />
  Matthias is the person who has previously worked on developing AutoRef system and he may share some interesting ideas for the development of the AutoRef system. (matthias_briegel@hotmail.com)
   
  <!-- Suggestion for improvement-->
## Suggestion for improvement

a
d
d

T
h
i
n
g
s

h
e
r
e



<!-- Team -->
## Team

This project has been carried out by the Mechatronic Systems Design (MSD) 2023-25 at Eindhoven University of Technology (TU/e) for the 1st in-house project in Block II of the program. The team members are as follow:

Quinten Swan - Design Engineer and Project manager (add email)<br />
Kareem Ghedan - Design Engineer and Team Leader (k.a.a.a.ghedan@tue.nl)<br />
Joseph Tandio - Design Engineer and System Architect (add email)<br />
Mahsa Barghi Mehmandari - Design Engineer and Scrum Master (m.barghi.mehmandari@tue.nl)<br />
Naheed - Design Engineer (n.tabassum@tue.nl)<br />
Arjun Chauhan - Design Engineer (add email)<br />
Deniz Akyasi - Design Engineer (add email)<br />
Anshid Nuhman Pillat - Design Engineer (a.n.pillat@tue.nl)<br />

<!-- Folder Contents -->
## Contents of the Folders

The documents are housed in two distinct folders. Within the "Code Base" folder, you'll find the executed code alongside supplementary materials. Meanwhile, the "Reports" folder encompasses all project-related reports and activities, excluding the code itself.


Also conatcings a small description about what each folder has.........

<!-- Reference -->
## Reference

Github repository cohort 2022-2024 
---------------------------------- 
The 2022-2024 MSD team used the stadium cameras to record the videos. The objective was to check whether the teams follow set piece protocols, that is team positioning. Validated the model for corner kick, since this is a common set piece. The validation was not real-time, rather done on a recorded video.

https://github.com/ElhamHonarvar/Auto-Referee 



Github repository cohort 2021-2023 
---------------------------------- 
The 2021-2023 MSD team used the robot players as “referee” to collect data for the decision-making algorithm. Using Tech United Data, the team designed, implemented, and tested the "ball rolling for a distance greater than 0.5 m" and the “ball IN/OUT of play” tasks. Moreover, the team recorded a real game of two against two robots to validate the algorithm created in Matlab.

https://github.com/Anup8777/AutonomousReferee 



CST-Wiki Overview: Cohort 2015-2017 until 2020-2022
---------------------------------- 
This wiki repository summarizes the work done by MSD Teams from 2015 till 2020.

http://cstwiki.wtb.tue.nl/index.php?title=AutoRef_-_Autonomous_Referee_System 




TU/e Gitlab repository (a.o. 2017-2018 software; files of 2-3 years ago)
------------------------------------------------------------------------- 
This repository include the software files used by Tech United Team. To access this link, you need to request access from Erjen using your tue email address.

https://gitlab.tue.nl/autoref/autoref_system 
 
<p align="right">(<a href="#top">back to top</a>)</p>

