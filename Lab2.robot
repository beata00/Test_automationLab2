*** Settings ***
Documentation   Lab work2
Library    SeleniumLibrary
Suite Setup    Setup

*** Variables ***
${url}  http://rental11.infotiv.net/
${email}    beata@gmail.se
${pass}    monkey1
${invalid_email}    greece12@gmail.com
${start_date}    03-11
${end_date}    03-13
${card_number}    1111111111111111
${card_holder}    Beata Tar
${cvc}    123
${alert_popup}

*** Test Cases ***
Sign in successfully with correct email and password
    Given User fills in email and password    ${email}    ${pass}
    When User clicks on button Login
    Then User is logged in and can see that he/she is signed in

Sign in is unsuccessful with invalid email
    Given User fills in email and password    ${invalid_email}    ${pass}
    When User clicks on button Login
    Then User can see a wrong email or password message

User can go to car selection page when date is entered
    Given User is signed in    ${email}    ${pass}
    When User fills in start end date
    Then User should be directed to Car Selection page

Car selection and confirmation of chosen car
    Given User is on Car Selections page    ${email}    ${pass}
    When User can select car by pushing a book button
    Then User can see a confirm message of the selected car

User can not click on book button without being signed in
    Given User is on homepage and clicks on button Continue
    When User can select car by pushing a book button
    Then User sees an alert message

Confirm car booking through payment
    Given User is on the confirmation page    ${email}    ${pass}
    When User fills in card details and presses on Confirm button
    Then User can see a clear message that the selected car is ready for pick up

User can see booked cars when clicks on My page button
    Given User has booked and confirmed car    ${email}    ${pass}
    When User clicks on button My Page
    Then User should be able to see his/hers bookings

Header checking
    Given User is on homepage
    When User clicks on About button
    Then User clicks on Start button and is back on Start page


*** Keywords ***
Setup
    [Documentation]   Opens webpage
    [Tags]     VG_test suite setup
    Open Browser    browser=Chrome
    Go To    ${url}
    Wait Until Element Is Visible    //h1[@id='questionText']

User fills in email and password
    [Documentation]    Filling in the fields for email and password
    [Tags]     VG_test Login1
    [Arguments]    ${email}    ${pass}
    Input Text     //input[@id='email']    ${email}
    Input Password    //input[@id='password']    ${pass}

User clicks on button Login
    [Documentation]    Pressing Login button
    [Tags]     VG_test Login2
    Click Button     //button[@id='login']

User is signed in
    [Documentation]    Signed in with email and password
    [Tags]     VG_test Login3
    [Arguments]    ${email}    ${pass}
    Setup
    Input Text    //input[@id='email']    ${email}
    Input Password    //input[@id='password']    ${pass}
    Click Button    //button[@id='login']
    Wait Until Page Contains Element    //label[@id='welcomePhrase']

User is logged in and can see that he/she is signed in
    [Documentation]    Verification of login
    [Tags]     VG_test Login4
    Wait Until Element Is Visible        //label[@id='welcomePhrase']
    Click Element    //button[@id='logout']

User can see a wrong email or password message
    [Documentation]   Alert message in case of wrong email
    [Tags]     VG_test Login5
    Element Should Be Visible    //label[@id='signInError']
    Close Browser

User fills in start end date
    [Documentation]    Giving the start and end date
    [Tags]     VG_test Choose Date
    Input Text     //input[@id='start']    ${start_date}
    Input Text     //input[@id='end']    ${end_date}

User is on Car Selections page
    [Documentation]    Person logged in and on Car selection page
    [Tags]     VG_test Car selection1
    [Arguments]    ${email}    ${pass}
    Setup
    Input Text     //input[@id='email']    ${email}
    Input Password    //input[@id='password']    ${pass}
    Click Button     //button[@id='login']
    Wait Until Page Contains Element    //label[@id='welcomePhrase']
    Input Text     //input[@id='start']    ${start_date}
    Input Text     //input[@id='end']    ${end_date}
    Click Button     //button[@id='continue']
    Wait Until Page Contains Element    //label[contains(text(),'Selected trip dates: 2024-03-11 – 2024-03-13')]

User should be directed to Car Selection page
    [Documentation]    Verifying that on Car Selection page
    [Tags]     VG_test Car selection2
    Click Button    //button[@id='continue']
    Wait Until Page Contains Element    //label[contains(text(),'Selected trip dates: 2024-03-11 – 2024-03-13')]
    Click Element    //button[@id='logout']

User sees an alert message
    [Documentation]    Alert message comes up
    [Tags]     VG_test Booking1
    Alert Should Be Present    You need to be logged in to continue.
    Close Browser

User is on homepage and clicks on button Continue
     [Documentation]    Booking without login
     [Tags]     VG_test  Booking2
     setup
     Click Button   //button[@id='continue']
     Wait Until Page Contains Element    //h1[@id='questionText']

User can select car by pushing a book button
    [Documentation]    Book button is clickable
    [Tags]     VG_test Car Selection3
    Click Element    //tbody/tr[22]/td[5]/form[1]/input[4]

User can see a confirm message of the selected car
    [Documentation]    verifying the selected car
    [Tags]    VG_test Car Selection3
    Wait Until Element Is Visible    //label[@id='startDate']
    Click Element    //button[@id='logout']

User is on the confirmation page
    [Documentation]    The selected car shown
    [Tags]    VG_Test Booking confirmation 1
    [Arguments]    ${email}    ${pass}
    Setup
    Input Text     //input[@id='email']    ${email}
    Input Password    //input[@id='password']    ${pass}
    Click Button     //button[@id='login']
    Wait Until Page Contains Element    //label[@id='welcomePhrase']
    Input Text     //input[@id='start']    ${start_date}
    Input Text     //input[@id='end']    ${end_date}
    Click Button     //button[@id='continue']
    Wait Until Page Contains Element    //label[contains(text(),'Selected trip dates: 2024-03-11 – 2024-03-13')]
    Click Element    //tbody/tr[22]/td[5]/form[1]/input[4]
    Wait Until Element Is Visible    //h1[@id='questionText']

User fills in card details and presses on Confirm button
    [Documentation]    Card details and confirmation
    [Tags]    VG_Test Booking confirmation 2
    Input Text    //input[@id='cardNum']    ${card_number}
    Input Text    //input[@id='fullName']    ${card_holder}
    Select From List By Index    //select[@title='Month']    4
    Select From List By Index    //select[@title='Year']    7
    Input Text    //input[@id='cvc']    ${cvc}
    Click Button    //button[@id='confirm']

User can see a clear message that the selected car is ready for pick up
    [Documentation]    Car is ready for pick up
    [Tags]    VG_Test Booking confirmation 3
    Page Should Contain Element    //h1[@id='questionTextSmall']
    Close Browser

User has booked and confirmed car
    [Documentation]    Car is ready for pick up
    [Tags]    VG_Test Booking confirmation 4
    [Arguments]    ${email}    ${pass}
    Setup
    Input Text     //input[@id='email']    ${email}
    Input Password    //input[@id='password']    ${pass}
    Click Button     //button[@id='login']
    Wait Until Page Contains Element    //label[@id='welcomePhrase']
    Input Text     //input[@id='start']    ${start_date}
    Input Text     //input[@id='end']    ${end_date}
    Click Button     //button[@id='continue']
    Wait Until Page Contains Element    //label[contains(text(),'Selected trip dates: 2024-03-11 – 2024-03-13')]
    Click Element    //tbody/tr[22]/td[5]/form[1]/input[4]
    Wait Until Element Is Visible    //h1[@id='questionText']
    Input Text    //input[@id='cardNum']    ${card_number}
    Input Text    //input[@id='fullName']    ${card_holder}
    Select From List By Index    //select[@title='Month']    4
    Select From List By Index    //select[@title='Year']    7
    Input Text    //input[@id='cvc']    ${cvc}
    Click Button    //button[@id='confirm']
    Page Should Contain Element    //h1[@id='questionTextSmall']

User clicks on button My Page
    [Documentation]    Accessing My page
    [Tags]    VG_Test View booking1
    Click Button    //div[@id='backToStart']//button[@id='mypage']

User should be able to see his/hers bookings
    [Documentation]    View booking details
    [Tags]    VG_Test View booking2
    Page Should Contain Element    //h1[@id='historyText']
    Click Element    //button[@id='logout']

User is on homepage
    [Documentation]    Opening of homepage
    [Tags]    VG_Test Header checking1
    Open Browser    browser=Chrome
    Go To    ${url}
    Wait Until Element Is Visible    //h1[@id='questionText']

User clicks on About button
    [Documentation]    About button press
    [Tags]    VG_Test Header checking2
    Click Element    //a[@id='about']
    Wait Until Element Is Visible    //label[contains(text(),'This project was created at an internship at Infot')]

User clicks on Start button and is back on Start page
    [Documentation]    Start button press
    [Tags]    VG_Test Header checking3
    Click Element    //div[@id='title']
    Wait Until Element Is Visible    //h1[@id='questionText']








