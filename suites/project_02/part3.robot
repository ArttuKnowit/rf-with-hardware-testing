*** Settings ***
Library           ../../libraries/ArduinoLib.py
Library           ../../libraries/OperatorLib.py

Suite Setup       Connect To Device    ${PORT}
Suite Teardown    Disconnect From Device

Test Setup        Reset LED Configuration
Test Tags         interactive


*** Variables ***
${LED_0}          0
${LED_1}          1
${LED_2}          2


*** Test Cases ***
Initial LED Is Zero
    ${led}=    Read Serial
    Should Be Equal As Strings    ${led}    ${LED_0}

Button Press Advances To LED 1
    Confirm User Has Pressed Button
    ${led}=    Read Serial
    Should Be Equal As Strings    ${led}    ${LED_1}

Two Button Presses Advance To LED 2
    Confirm User Has Pressed Button
    Sleep    1s
    Confirm User Has Pressed Button
    ${led}=    Read Serial
    Should Be Equal As Strings    ${led}    ${LED_2}

Three Button Presses Wrap Back To LED 0
    Confirm User Has Pressed Button
    Sleep    1s
    Confirm User Has Pressed Button
    Sleep    1s
    Confirm User Has Pressed Button
    ${led}=    Read Serial
    Should Be Equal As Strings    ${led}    ${LED_0}

*** Keywords ***
Reset LED configuration
    Write Serial    SetLed 0
    Read Serial