*** Settings ***
Documentation    Task 001 — Robot Framework basics.
...
...              Covers:
...                - Logging to console
...                - Defining and calling custom keywords via a resource file
Resource         ../../resources/task_001.resource


*** Test Cases ***
Hello World
    [Documentation]    Logs "Hello World" to the console.
    Log    Hello World    console=True

Greet A Person
    [Documentation]    Calls the Greet keyword defined in task_001.resource.
    Greet    Alice
