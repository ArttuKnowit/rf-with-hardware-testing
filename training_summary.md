# Summary

## Things to cover

Main reasons to use Robot Framework:

- Reusability of keywords
- Python underneath
- Out-of-the-box reporting
- community driven tooling at no cost
- Robot Framework Dashboard

These form a core for what we want to achieve:

- Robot Framework keywords: how to structure them, their various levels and origins
- How to hook-up python with Robot Framework
  - Custom libraries
  - Decorators
  - Logging in custom libraries
  - Capabilities of the robot framework libraries within python
- Reporting
  - Explore output.xml, explain what gets marked in and what doesn't
  - Explore the basic output.html
  - Explore the dashboard or other 3rd party reporting tools
- Python ecosystem
  - Explain commonly used 3rd party libraries such as DataDriver

Two execution modes are mentioned:

- Test Cases for validation and verification, where failures are critical
- Tasks for automated processes that operator might trigger, but that are not directly aimed at validating DUT, failures are not critical

This means that difference between RPA and Test Automation is worthwhile explaining

Architecture is described as follows:

- Robot Framework as Procedure Execution Engine. It is mentioned that business logic lives in python
- Pass/fail criteria are defined in external YAML files
  - A method of reading YAML files is required
- ATE Control (Lab Equipment Abstraction) is an abstraction layer between procedures and physical instruments, exposed as RF keywords
  - This is the customers own python library
  - Create something similar during the course
  - Base library class is mentioned - perhaps it is worth having examples of master classes as libraries as well as library class inheritance
- Connector libraries used as semantic keywor wrappers for enterprise systems, such as Jira, Confluence, GitHub, Slack
- SUT libraries to interact with satellites
- Operator Interaction (OperatorLib) is a customl ibrary replacing RF's Dialogs library to have terminal-native prompts that work over SSH and Docker containers without GUI display server
  - We could implement a full simple version of this with input() python method to get all methods in: Ask Value, Ask Choice, Ask Selection, Ask Success, Ask Confirmation, Ask Form

Import resolution & Packaging

- Only directly used things are imported, no "central import everything" resource files
- A system where each resource is added to --pythonpath

Design decisions relevant to training:

- __init__.robot is used for each test directory to define suite level setups and teardowns
- Keyword layering in three tiers: high, mid and low. Imports only downstream, no monolithic resource files
- Duck typing for drivers: no enforces interface hierarchy
- Configuration over code: setup, mapping mock presets and pass/fail criteria all live in YAML
- Tagging strategy:
  - Tags for smoke/sanity
  - attended/unattended
  - ATE-specific
  - Not used for product scoping, that is done by directory
  - Continue on failure as a tag
- Explore teardown failure behaviour
- Testing strategy for RF code
  - Unit tests of Python keyword libraries are written in pytest
    - They test tests!
  - Unit tests of robot resource files are written in Robot Framework
  - I think I will not cover this
- Custom converters!
  - Need to learn this and cover this
- Convention-based variables

Tools

- Robot Framework 7.x
- Python packaging
- RobotCode
- Dual configuration with robot.args and robot.toml
- Robocop and robotidy
- Deployment with Docker