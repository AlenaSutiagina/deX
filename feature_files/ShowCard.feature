Feature: Show Card

    Feature Description

Scenario: User wants to go forward or backwards in stack
    Given Stack was created & stack contains at least one card
    When User tries to go forward or backward in stack
    And There is more than one card in the stack
    Then Next or previous card is displayed

Scenario: User wants to go forward or backwards in stack
    Given Stack was created & stack contains at least one card
    When User tries to go forward or backward in stack
    And There is just one card in the stack
    Then Forward and Backwards arrows are disabled

Scenario: User wants to favorite the card
    Given Stack was created & stack contains at least one card
    When User tries to favorite the current card
    And Card is not a favorite yet
    Then Card gets added to favorites

Scenario: User wants to unfavorite the card
    Given Stack was created & stack contains at least one card
    When User tries to unfavorite the current card
    And Card is favorite
    Then Card gets removed from favorites