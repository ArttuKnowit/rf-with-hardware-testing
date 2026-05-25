*** Variables ***
${NAME}    Arttu
${VOLTAGE}    ${10}
${STATEMENT}    ${TRUE}
${VAR}    ${NONE}

*** Test Cases ***
Example Test
    Helper Keyword    1    2
    

*** Keywords ***
Helper Keyword
    [Arguments]    ${arg1}    ${arg2}
    Should Be Equal As Integers    ${arg1}    ${arg2}