*** Settings ***
Library           ../../libraries/ArduinoLib.py

Suite Setup       Connect To Device    ${PORT}
Suite Teardown    Disconnect From Device

Test Setup        Reset LED configuration


*** Variables ***
${VOLTAGE_HIGH_THRESHOLD}    3.0
${A_PIN_FOR_LED_0}           2
${A_PIN_FOR_LED_1}           1
${A_PIN_FOR_LED_2}           0


*** Test Cases ***
Initial LED Is Zero
    Read Serial
    LED Should Be Active    ${A_PIN_FOR_LED_0}

Button Press Advances To LED 1
    Read Serial
    Press Button
    LED Should Be Active    ${A_PIN_FOR_LED_1}

Two Button Presses Advance To LED 2
    Read Serial
    Press Button
    Press Button
    LED Should Be Active    ${A_PIN_FOR_LED_2}

Three Button Presses Wrap Back To LED 0
    Read Serial
    Press Button
    Press Button
    Press Button
    LED Should Be Active    ${A_PIN_FOR_LED_0}

*** Keywords ***
LED Should Be Active
    [Arguments]    ${pin_index}
    ${voltage}=    Read Analog Voltage    ${pin_index}
    Should Be True    ${voltage} >= ${VOLTAGE_HIGH_THRESHOLD}
    ...    LED on A${pin_index} expected to be active but measured ${voltage}V

Press Button
    Write Serial    PressButton
    Read Serial

Reset LED configuration
    Write Serial    SetLed 0
    Read Serial