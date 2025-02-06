---
title: "Data Matcher Specification"
category: Specifications
---
* 
{:toc}

The data matcher provides functionality to compare application data against a predefined set of matching criteria. Each matcher will provide a pass/fail result when compared against application data on quantity and method. The data supplied to the matcher is made available by an application component, such as an email component making email data available for matching.

A data matcher is composed of text, a scope, a method, and an order.
- Matcher text can be one or more strings of text (ex: "bob@example.com" & "alice@example.com").
- Application data can be one or more strings of text (ex: "inquiry@example.com", "sales@example.com").
- Each matcher text is matched against against all application data until a pass/fail result is produced.

## Quantity

The matcher quantity controls how many matcher text must match against application data.
- **All**: Each and every matcher text must find a match in the application data.
- **Minimum**: A minimum number of matcher text must find a match in the application data. 
- **Maximum**: No more than the maximum number of matcher text must find a match in the application data. 
- **None**: No matcher text must find a match in the application data. 

## Method
The matcher method contols how matcher text is compared against application data.  
- **Exact**: The matcher text must find an exact equalivant in the application data. 
- **Starts With**: The matcher text must exactly matches the application data, or is the first portion of the application data. 
- **Ends With**: The matcher text must exactly match the application data, or is the last portion of the application data. 
- **Contains**: The matcher text must be found anywhere in the application data. 
- **Regex**: The matcher is a regular expression which must match against the application data.

## Order

The matcher order controls if matcher text must match against application data in the same order. 

## Specification

```gherkin
{% include feature-files/data-matcher.feature %}
```
