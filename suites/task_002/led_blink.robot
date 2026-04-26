*** Settings ***
Documentation    Task 002 — Verify LED blink behaviour via Arduino serial output.
...
...              Prerequisites:
...                - Arduino Uno connected via USB
...                - firmware/led_blink/led_blink.ino uploaded to the board
...                - Adjust the ``port`` variable below to match your system
...                  (Linux: /dev/ttyUSB0 or /dev/ttyACM0, macOS: /dev/cu.usbmodem*, Windows: COMx)
Library          ../../libraries/ArduinoLib.py    port=${PORT}    baud_rate=${BAUD_RATE}
Suite Setup      Connect To Arduino
Suite Teardown   Disconnect From Arduino


*** Variables ***
${PORT}         /dev/ttyUSB0
${BAUD_RATE}    9600


*** Test Cases ***
LED Turns On
    [Documentation]    The firmware should report "LED ON" within 10 seconds of connecting.
    Wait For Serial Message    LED ON    timeout=10

LED Turns Off
    [Documentation]    After "LED ON", the firmware should report "LED OFF" within 10 seconds.
    Wait For Serial Message    LED OFF    timeout=10

LED Blink Cycle Completes
    [Documentation]    Verifies a full ON → OFF → ON cycle to confirm continuous looping.
    Wait For Serial Message    LED ON     timeout=10
    Wait For Serial Message    LED OFF    timeout=10
    Wait For Serial Message    LED ON     timeout=10
