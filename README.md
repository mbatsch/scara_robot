# Vision based control of small educational double SCARA robot

<b>Brief description</b>

The repository contains some of the code used in the project aiming at develop an easy-to-build and deploy educational robot, which may be used during classes to study machine vision-based control and classification. More details can be found <a href="https://mbatsch.github.io/portfolio/scara.html">here</a>.

<b>List of files</b>

<ul>
  <li><a href="https://github.com/mbatsch/scara_robot/blob/main/parts_handling.m">parts_handling.m</a> - function for controlling the robot to simple pick and place task</li>
  <li><a href="https://github.com/mbatsch/scara_robot/blob/main/getOBJcoords.m">getOBJcoords.m</a> - function for object detection based on image segmentation and blob analysis; returns number of objects and its coordinates</li>
  <li><a href="https://github.com/mbatsch/scara_robot/blob/main/motorSync.m">motorSync.m</a> - function for synchronous stepper motors control in half-step operation</li>
  <li><a href="https://github.com/mbatsch/scara_robot/blob/main/invKin.m">invKin.m</a> - inverse kinematics of 2-DOF double SCARA manipulator</li>
  <li><a href="https://github.com/mbatsch/scara_robot/blob/main/px2xy.m">px2xy.m</a> - function for obtaining coordinates from pixels based on calibration data</li>
  <li><a href="https://github.com/mbatsch/scara_robot/blob/main/image_prep.py">image_prep.py</a> - image capturing and preparation for training the CNN</li>
  <li><a href="https://github.com/mbatsch/scara_robot/blob/main/train_model.py">train_model.py</a> - training the CNN</li>
  <li><a href="https://github.com/mbatsch/scara_robot/blob/main/test_model.py">test_model.py</a> - testing the CNN</li>
  
</ul>

