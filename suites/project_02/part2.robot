*** Settings ***
Library           ../../libraries/ArduinoLib.py

Suite Setup       Connect To Device    COM4
Suite Teardown    Disconnect From Device

Test Setup        Reset Device


*** Variables ***
${LED_0}          0
${LED_1}          1
${LED_2}          2


*** Test Cases ***
Initial LED Is Zero
    ${led}=    Read Serial
    Should Be Equal As Strings    ${led}    ${LED_0}

Button Press Advances To LED 1
    Write Serial    P
    ${led}=    Read Serial
    Should Be Equal As Strings    ${led}    ${LED_1}

Two Button Presses Advance To LED 2
    Write Serial    P
    Sleep    1s
    Write Serial    P
    ${led}=    Read Serial
    Should Be Equal As Strings    ${led}    ${LED_2}

Three Button Presses Wrap Back To LED 0
    Write Serial    P
    Sleep    1s
    Write Serial    P
    Sleep    1s
    Write Serial    P
    ${led}=    Read Serial
    Should Be Equal As Strings    ${led}    ${LED_0}
