*** Settings ***
Resource          ../../resources/arduino_keywords.resource

Test Setup        Reset LED Configuration


*** Variables ***
${LED_0}          0
${LED_1}          1
${LED_2}          2


*** Test Cases ***
Initial LED Is Zero
    ${led}=    Read Serial
    Should Be Equal As Strings    ${led}    ${LED_0}

Button Press Advances To LED 1
    Write Serial    PressButton
    Sleep    1s
    ${led}=    Read Serial
    Should Be Equal As Strings    ${led}    ${LED_1}

Two Button Presses Advance To LED 2
    Write Serial    PressButton
    Sleep    1s
    Write Serial    PressButton
    ${led}=    Read Serial
    Should Be Equal As Strings    ${led}    ${LED_2}

Three Button Presses Wrap Back To LED 0
    Write Serial    PressButton
    Sleep    1s
    Write Serial    PressButton
    ${led}=    Read Serial
    Sleep    1s
    Write Serial    PressButton
    Should Be Equal As Strings    ${led}    ${LED_0}

*** Keywords ***
Reset LED Configuration
    Write Serial    SetLed 0
    Read Serial