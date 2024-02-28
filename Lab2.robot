*** Settings ***
Documentation   Lab work2
Library    SeleniumLibrary


*** Variables ***
${url}  http://rental11.infotiv.net/
${email}    beata@gmail.se
${pass}    monkey1
${invalid_email}    greece12@gmail.com
${start_date}    03-11
${end_date}    03-13
${invalid_start_date}    01-05
${card_number}    1111111111111111
${card_holder}    Beata Tar
${cvc}    123
${alert_popup}



*** Test Cases ***
Car booking
    Given User is on homepage
    And User is inlogged    ${email}    ${pass}
    When User chooses dates and car model
    And User pays by credit card
    Then Booked car is visible on My page
    And Cancel car

Log in successfully
    Given User is on homepage
    When User fills in with email and password    ${email}    ${pass}
    Then User can see a message that he is signed in

Unsuccessful login
    Given User is on homepage
    When User fills in with email and password    ${invalid_email}    ${pass}
    Then User gets a warning message

User can't book car without logging in
    Given User is on homepage
    When User chooses dates    ${start_date}    ${end_date}
    Then User gets an alert when trying to book chosen car

Header navigation
    Given User is on homepage
    When User is going to About page
    Then User is going back to Start page

Booking history
    Given User is on homepage
    And User is inlogged    ${email}    ${pass}
    When User goes to My Page
    Then Booking history is visible

*** Keywords ***
User is on homepage
    [Documentation]    Opening of homepage
    [Tags]    VG_test
    Open Browser    browser=Chrome
    Go To    ${url}
    Wait Until Element Is Visible    //h1[@id='questionText']

User fills in with email and password
    [Documentation]    providing credentials
    [Tags]    Login 1
    [Arguments]    ${email}    ${pass}
    Input Text     //input[@id='email']    ${email}
    Input Password    //input[@id='password']    ${pass}
    Element Should Be Visible    //button[@id='createUser']

User can see a message that he is signed in
    [Documentation]    Verification of login
    [Tags]    VG_test Login 2
    Click Button     //button[@id='login']
    Wait Until Element Is Visible    //label[@id='welcomePhrase']

User is inlogged
    [Arguments]    ${email}    ${pass}
    [Documentation]    Signed in to website
    [Tags]    VG_test Login 3
    Input Text     //input[@id='email']    ${email}
    Input Password    //input[@id='password']    ${pass}
    Click Button     //button[@id='login']
    Wait Until Page Contains Element    //label[@id='welcomePhrase']

User gets a warning message
    [Documentation]   Alert message in case of wrong email
    [Tags]     VG_test Login 4
    Click Button     //button[@id='login']
    Wait Until Element Is Visible    //label[@id='signInError']

User chooses dates
    [Documentation]    Giving the start and end date
    [Tags]     VG_test Date
    [Arguments]    ${start_date}    ${end_date}
    Input Text     //input[@id='start']    ${start_date}
    Input Text     //input[@id='end']    ${end_date}
    Click Button     //button[@id='continue']
    Wait Until Page Contains Element    //button[@id='backToDateButton']

User chooses dates and car model
    [Documentation]    Choosing date and car model
    [Tags]     VG_test Date
    Input Text     //input[@id='start']    ${start_date}
    Input Text     //input[@id='end']    ${end_date}
    Click Button     //button[@id='continue']
    Wait Until Page Contains Element    //button[@id='backToDateButton']
    Click Button    //tbody/tr[1]/td[5]/form[1]/input[4]
    Wait Until Page Contains Element    //h1[@id='questionText']

User pays by credit card
    [Documentation]    Paying by card
    [Tags]     VG_test payment
    Input Text    //input[@id='cardNum']    ${card_number}
    Input Text    //input[@id='fullName']    ${card_holder}
    Select From List By Index    //select[@title='Month']    4
    Select From List By Index    //select[@title='Year']    7
    Input Text    //input[@id='cvc']    ${cvc}
    Click Button    //button[@id='confirm']
    Wait Until Element Is Visible    //h1[@id='questionTextSmall']

Booked car is visible on My page
    [Documentation]    Booked car
    [Tags]     VG_test My page
    Click Button    //button[@id='mypage']
    Wait Until Element Is Visible    //button[@id='unBook1']

Cancel car
    [Documentation]    Cancel booked car
    [Tags]     VG_test unbook
    Click button    //button[@id='unBook1']
    Handle Alert
    Wait Until Page Contains    Your car: BBE465 has been Returned


User gets an alert when trying to book chosen car
    [Documentation]    Alert message comes up
    [Tags]     VG_test Booking 5
    Click button    (//input[@id='bookVivaropass9'])[2]
    Alert Should Be Present    You need to be logged in to continue.

User is going to About page
    [Documentation]    Checking About page
    [Tags]    VG_Test Header navigation 1
    Click Element    //a[@id='about']
    Wait Until Element Is Visible    //label[contains(text(),'This project was created at an internship at Infot')]

User is going back to Start page
    [Documentation]    Getting back to Start page
    [Tags]    VG_Test navigation 2
    Click Element    //div[@id='title']
    Wait Until Element Is Visible    //h1[@id='questionText']

User goes to My Page
    [Documentation]   Navigating to my page
    [Tags]    VG_Test MyPage
    Click Button    //button[@id='mypage']
    Wait Until Element Is Visible    //button[@id='hide']

Booking history is visible
    [Documentation]    History
    [Tags]    VG_Test History
    Click Button    //button[@id='show']
    Wait Until Element Is Visible  //td[@id='orderHis1']


























