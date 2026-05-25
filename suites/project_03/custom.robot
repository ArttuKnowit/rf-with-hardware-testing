*** Settings ***
Library    ../../resources/ArduinoLib.py
Library    ../../resources/OperatorLib.py

Suite Setup       Connect To Device    ${PORT}
Suite Teardown    Disconnect From Device

*** Variables ***
${PORT}    /dev/ttyACM0

*** Test Cases ***
Test Medium Temperature
    [Setup]    Sleep    4s
    ${temperature}=    Read Temperature
    Should Be True    ${temperature} >= 15.0
    Should Be True    ${temperature} <= 30.0

Test High Temperature
    [Setup]    Confirm Proceeding
    ${temperature}=    Read Temperature
    Should Be True    ${temperature} >= 25.0

Test Low Temperature
    [Setup]    Confirm Proceeding
    ${temperature}=    Read Temperature
    Should Be True    ${temperature} >= 25.0

*** Keywords ***
Read Temperature
    Write Serial    readTemperature
    ${temperature}=    Read Serial
    RETURN    ${temperature}

Read Analog Voltage
    [Arguments]    ${pin_index}
    Write Serial    readVoltage ${pin_index}
    ${voltage}=    Read Serial
    RETURN    
    