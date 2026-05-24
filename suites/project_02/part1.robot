*** Settings ***
Library           ../../libraries/ArduinoLib.py

Suite Setup       Connect To Device    ${PORT}
Suite Teardown    Disconnect From Device


*** Variables ***
${LED_0}          0
${LED_1}          1
${LED_2}          2


*** Test Cases ***
Initial LED Is Zero
    ${led}=    Read Serial
    Sleep    1s
    Should Be Equal As Strings    ${led}    ${LED_0}

Button Press Advances To LED 1
    Write Serial    PressButton
    ${led}=    Read Serial
    Sleep    1s
    Should Be Equal As Strings    ${led}    ${LED_1}

Button Press Advances To LED 2
    Write Serial    PressButton
    ${led}=    Read Serial
    Sleep    1s
    Should Be Equal As Strings    ${led}    ${LED_2}

Button Press Wraps Back To LED 0
    Write Serial    PressButton
    ${led}=    Read Serial
    Sleep    1s
    Should Be Equal As Strings    ${led}    ${LED_0}
