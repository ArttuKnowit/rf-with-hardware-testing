*** Settings ***
Resource          ../../resources/arduino_keywords.resource
Suite Setup       Connect To Device    ${PORT}
Suite Teardown    Disconnect From Device
Variables         ../../resources/variables.py
Test Setup        Common Test Setup Task


*** Keywords ***
Common Test Setup Task
    Log    Test starting