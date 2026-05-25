*** Settings ***
Library    ArduinoLib.py


*** Keywords ***
Reset LED Configuration
    [Documentation]   Resets the LED configuration to the initial state.
    Write Serial    SetLed 0
    Read Serial

LED Should Be Active
    [Documentation]        Checks if the LED connected to the specified pin index is active based on the voltage threshold.
    [Arguments]    ${pin_index}    ${threshold}
    ${voltage}=    Read Analog Voltage    ${pin_index}
    Should Be True    ${voltage} >= ${threshold}
    ...    LED on A${pin_index} expected to be active but measured ${voltage}V

Press Button
    [Tags]    interaction
    Write Serial    PressButton
    Read Serial
