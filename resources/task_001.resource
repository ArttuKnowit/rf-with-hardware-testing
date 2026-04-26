*** Settings ***
Documentation    Reusable keywords for Task 001 — RF basics exercises.


*** Keywords ***
Greet
    [Documentation]    Logs a personalised greeting to the console.
    [Arguments]    ${name}
    Log    Hello, ${name}!    console=True
