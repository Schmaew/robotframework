*** Settings ***
Library    RequestsLibrary
Suite Setup    Create Session    my_api    http://127.0.0.1:5001
Suite Teardown    Delete All Sessions

*** Variables ***
${IS_PRIME_ENDPOINT}    /is_prime
${HEADERS}    {"Content-Type": "application/json"}
*** Test Cases ***
Test when x is 17
    [Documentation]    Test if 17 is a prime number.
    ${response}=    GET    ${IS_PRIME_ENDPOINT}/17
    Status Should Be    200
    Should Be True   ${response.json()}
    Log    ${\n}Result: ${response.json()}    console=True

Test when x is 36
    [Documentation]    Test if 36 is a prime number.
    ${response}=    GET    ${IS_PRIME_ENDPOINT}/36
    Status Should Be    200
    Should Not Be True    ${response.json()}
    Log    ${\n}Result: ${response.json()}    console=True

Test when x is 13219
    [Documentation]    Test if 13219 is a prime number.
    ${response}=    GET    ${IS_PRIME_ENDPOINT}/13219
    Status Should Be    200
    Should Be True   ${response.json()}
    Log    ${\n}Result: ${response.json()}    console=True

*** Keywords ***
GET
    [Arguments]    ${endpoint}
    ${response}=    GET On Session    my_api    ${endpoint}    expected_status=anything 
    RETURN    ${response}