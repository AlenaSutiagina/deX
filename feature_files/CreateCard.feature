Feature: Create Card

Scenario: No question entered
    Given Stack was created & user is on create card page
    When User tries to create a new card
    And User did not enter a question
    And User entered an answer
    Then Message appears with the following text: 'Please provide a question' & textarea gets highlighted in pink

Scenario: No answer entered 
    Given Stack was created & user is on create card page
    When User tries to create a new card
    And User did not enter an answer
    And User entered a question
    Then Message appears with the following text: 'Please provide an answer' & textarea gets highlghted in pink

Scenario: No question & no answer entered  
    Given Stack was created & user is on create card page
    When User tries to create a new card
    And User did not enter a question
    And User did not enter an answer
    Then Message appears with the following text: 'Please provide a question and an answer' & textarea gets highlghted in pink

Scenario: Question and answer are entered 
    Given Stack was created & user is on create card page
    When User tries to create a new card
    And User entered a question
    And User entered an answer
    Then Message appears with the following text: 'Card was created' & textareas get cleared

