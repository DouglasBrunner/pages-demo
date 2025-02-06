Feature: Matcher Functionality Testing
  As a developer, I want to validate that the matcher functionality correctly compares matcher criteria 
  against application data using various matching methods and quantity requirements.

  #--------------------------------------------------------------------------
  # Exact Matching Scenarios
  #--------------------------------------------------------------------------

  Scenario Outline: Exact matching with <quantityRequirement> requirement
    Given the matcher criteria are:
      | value        |
      | <criterion1> |
      | <criterion2> |
      | <criterion3> |
    And the application data are:
      | value   |
      | <data1> |
      | <data2> |
      | <data3> |
      | <data4> |
    And the matcher method is "Exact"
    And the quantity requirement is "<quantityRequirement>"<quantityThreshold>
    When the matcher is executed
    Then the matcher result should be <expectedResult> and the reason should be "<reason>"

    Examples:
      | criterion1 | criterion2 | criterion3 | data1 | data2 | data3 | data4 | quantityRequirement | quantityThreshold                          | expectedResult | reason                                                                    |
      | dog        | cat        |            | dog   | cat   | bird  |       | All                 |                                            | true           | Both criteria are found exactly in the application data.                  |
      | dog        | cat        |            | bird  | fish  |       |       | None                |                                            | true           | No matcher criterion is found in the application data.                    |
      | dog        | cat        | fish       | dog   | bird  | fish  |       | Minimum             | with a minimum match count of 2            | true           | Two criteria (dog, fish) match exactly, meeting the minimum threshold.    |
      | dog        | cat        | fish       | dog   | cat   | fish  | bird  | Maximum             | with a maximum match count of 2            | false          | Three criteria match exactly, exceeding the maximum allowed count of 2.   |

  #--------------------------------------------------------------------------
  # Starts With Matching Scenarios
  #--------------------------------------------------------------------------

  Scenario Outline: Starts With matching with <quantityRequirement> requirement
    Given the matcher criteria are:
      | value        |
      | <criterion1> |
      | <criterion2> |
    And the application data are:
      | value  |
      | <data1>|
      | <data2>|
      | <data3>|
    And the matcher method is "Starts With"
    And the quantity requirement is "<quantityRequirement>"<quantityThreshold>
    When the matcher is executed
    Then the matcher result should be <expectedResult> and the reason should be "<reason>"

    Examples:
      | criterion1 | criterion2 | data1  | data2   | data3   | quantityRequirement | quantityThreshold                    | expectedResult | reason                                                                       |
      | do         | ca         | dog    | cat     | dolphin | All                 |                                      | true           | Both criteria match as valid prefixes in the application data.               |
      | do         | ca         | dog    | bird    | fish    | None                |                                      | true           | No matcher criterion is found as a prefix in the application data.           |
      | do         | ca         | dog    | catfish | bird    | Minimum             | with a minimum match count of 1      | true           | At least one criterion matches as a prefix, meeting the minimum threshold.   |
      | do         | ca         | doggy  | cat     | fish    | Maximum             | with a maximum match count of 1      | false          | Two criteria match as prefixes, exceeding the maximum allowed count.         |

  #--------------------------------------------------------------------------
  # Ends With Matching Scenarios
  #--------------------------------------------------------------------------

  Scenario Outline: Ends With matching with <quantityRequirement> requirement
    Given the matcher criteria are:
      | value        |
      | <criterion1> |
      | <criterion2> |
    And the application data are:
      | value  |
      | <data1>|
      | <data2>|
      | <data3>|
    And the matcher method is "Ends With"
    And the quantity requirement is "<quantityRequirement>"<quantityThreshold>
    When the matcher is executed
    Then the matcher result should be <expectedResult> and the reason should be "<reason>"

    Examples:
      | criterion1 | criterion2 | data1  | data2  | data3  | quantityRequirement | quantityThreshold                       | expectedResult | reason                                                                         |
      | og         | at         | dog    | cat    | frog   | All                 |                                         | true           | Both criteria match as valid suffixes in the application data.                 |
      | og         | at         | dog    | bat    | fish   | None                |                                         | true           | No matcher criterion is found as a suffix in the application data.             |
      | og         | at         | dog    | catnap | bird   | Minimum             | with a minimum match count of 1         | true           | At least one criterion matches as a suffix, meeting the minimum threshold.     |
      | og         | at         | doggy  | cat    | fish   | Maximum             | with a maximum match count of 1         | false          | Two criteria match as suffixes, exceeding the maximum allowed count.           |

  #--------------------------------------------------------------------------
  # Contains Matching Scenarios
  #--------------------------------------------------------------------------

  Scenario Outline: Contains matching with <quantityRequirement> requirement
    Given the matcher criteria are:
      | value        |
      | <criterion1> |
      | <criterion2> |
    And the application data are:
      | value  |
      | <data1>|
      | <data2>|
      | <data3>|
    And the matcher method is "Contains"
    And the quantity requirement is "<quantityRequirement>"<quantityThreshold>
    When the matcher is executed
    Then the matcher result should be <expectedResult> and the reason should be "<reason>"

    Examples:
      | criterion1 | criterion2 | data1  | data2   | data3  | quantityRequirement | quantityThreshold                   | expectedResult | reason                                                                                           |
      | og         | at         | dog    | cat     | foggy  | All                 |                                     | true           | Both criteria are found within the application data values.                                      |
      | og         | at         | dog    | bird    | fish   | None                |                                     | true           | No matcher criterion is contained within the application data values.                            |
      | og         | at         | dog    | catfish | bird   | Minimum             | with a minimum match count of 1     | true           | At least one criterion is contained within an application data value, meeting the threshold.     |
      | og         | at         | doggy  | cat     | fish   | Maximum             | with a maximum match count of 1     | false          | Two criteria are contained within the application data values, exceeding the maximum allowed.    |

  #--------------------------------------------------------------------------
  # Regex Matching Scenarios
  #--------------------------------------------------------------------------

  Scenario Outline: Regex matching with <quantityRequirement> requirement
    Given the matcher criteria are:
      | value        |
      | <criterion1> |
      | <criterion2> |
    And the application data are:
      | value  |
      | <data1>|
      | <data2>|
      | <data3>|
    And the matcher method is "Regex"
    And the quantity requirement is "<quantityRequirement>"<quantityThreshold>
    When the matcher is executed
    Then the matcher result should be <expectedResult> and the reason should be "<reason>"

    Examples:
      | criterion1 | criterion2 | data1  | data2   | data3  | quantityRequirement | quantityThreshold                          | expectedResult | reason                                                                                     |
      | ^d.*g$     | ^c.*t$     | dog    | cat     | dig    | All                 |                                           | true            | All criteria match the given regex patterns.                                               |
      | ^d.*g$     | ^c.*t$     | bird   | fish    | frog   | None                |                                           | true            | No matcher criterion matches the regex patterns.                                           |
      | ^d.*g$     | ^c.*t$     | dog    | catfish | bird   | Minimum             | with a minimum match count of 1            | true           | At least one criterion matches the regex pattern, meeting the minimum threshold.           |
      | ^d.*g$     | ^c.*t$     | doggy  | cat     | fish   | Maximum             | with a maximum match count of 1            | false          | More than one criterion matches the regex patterns, exceeding the maximum allowed count.   |
