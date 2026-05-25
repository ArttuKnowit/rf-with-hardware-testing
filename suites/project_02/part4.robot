*** Settings ***
Resource          ../../resources/arduino_keywords.resource

Test Setup        Reset LED configuration


*** Variables ***
${VOLTAGE_HIGH_THRESHOLD}    2.5
${A_PIN_FOR_LED_0}           2
${A_PIN_FOR_LED_1}           1
${A_PIN_FOR_LED_2}           0


*** Test Cases ***
Initial LED Is Zero
    Read Serial
    LED Should Be Active    ${A_PIN_FOR_LED_0}    ${VOLTAGE_HIGH_THRESHOLD}

Button Press Advances To LED 1
    Read Serial
    Press Button
    Sleep    1s
    LED Should Be Active    ${A_PIN_FOR_LED_1}    ${VOLTAGE_HIGH_THRESHOLD}

Two Button Presses Advance To LED 2
    Read Serial
    Press Button
    Sleep    1s
    Press Button
    Sleep    1s
    LED Should Be Active    ${A_PIN_FOR_LED_2}    ${VOLTAGE_HIGH_THRESHOLD}

Three Button Presses Wrap Back To LED 0
    Read Serial
    Press Button
    Sleep    1s
    Press Button
    Sleep    1s
    Press Button
    Sleep    1s
    LED Should Be Active    ${A_PIN_FOR_LED_0}    ${VOLTAGE_HIGH_THRESHOLD}

