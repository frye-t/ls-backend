# The PEDAC Process

## P: Understanding the Problem

- Establish rules/define boundaries of the problem
  - Assess available information 
  - Restate Explicit requirements
  - Identify Implicit Requirements
- Spend enough time here. Don't rush this step

**General Example**

Given a string, produce a new string with every other word removed.

- Explicit Requirements:
  - Input: string
  - Output: new string
  - Remove every other word from input string

- Questions:
  - What do we mean by every other word? (every even, every odd?)
  - How do we define a word in this context?
    - Words are delimited by spaces

## E: Examples and Test Cases

- Can confirm/refute assumptions
- Help to answer questions about implicit requirements
- Act as assertions which help to codify the rules and boundaries

## D: Data Structures

- Help to reason with data more logically
- Help interact with data at implemenation level
- Thinking in terms of data strucutres is part of problem solving process
- Closely related to algorithms
  - Set of steps from input to output
  - Involves structuring data in a certain way

## A: Algorithms

- A logical sequence of steps for accomplishing a task or objective
  - Closely linked to Data Structures
  - Series of steps to strcuture data to produce required output
- Stay abstract/high level
  - Avoid implementaion details
  - Don't worry about efficiency for now

## C: Implementing a Solution in Code

- Translating solution algorithm to code
- Think about algorithm in context of programming language
  - Language features/constraints
  - Characteristics of Data Structures
  - Built in functions/methods
  - Syntax/coding patterns
- Create test cases as necessary
- Code with intent
  - Think about what each line of code is doing, why we are writing it, and
    how it relates to high level solution


## Sum Even Number Rows 

**Problem**
Imagine a sequence of consecutive even integers beginning with 2. The integers are group in
rows, with the first row containing one integer, the second row two integers, the thrird row three
integers, and so on. Given an integer representing the number of a particular row, return an
integer representing the sum of all integers in that row.

- Sequence of even integeres
- Sequence begins with two
- Integers are consecutive
- Sequence is group into rows
- Each row incrementally larger: 1, 2, 3, ...
- Row 'number' equals number of elements in that row
 - Row 1 has 1 element, Row 2 has 2 elements, ...

- Input: a single integer
  - Identify a 'row', which is a subset of a sequence of integers
- Output: a single integer
  - The sum of all the integers in the row identified by the input integer

- Sequence:
2, 4, 6, 8, 10, 12, 14, 16, 18, 20, ...

2
4, 6
8, 10, 12
14, 16, 18, 20
...

- How do we create the structure?
  - Hardcode? Brute force? Pattern?

**Examples**

row number: 1 => sum of integers in row: 2
row number: 2 => sum of integers in row: 10
row number: 4 => sum of integers in row: 68
2
4, 6
8, 10, 12
14, 16, 18, 20
...

2               => 2
4, 6            => 10
14, 16, 18, 20  => 68

**Data Structure**

2
4, 6
8, 10, 12
14, 16, 18, 20
...


- Overall structure representing a sequence as a whole
- Individual rows within overall structure
- Individual rows in a set order in context of sequence
- Individual rows contain subset of integers
- Can assume that integers are in a set order in the context of the sequence
 - The sequence continues naturally through each row

- Nested arrays
[
  [2],
  [4, 6],
  [8, 10, 12],
  [14, 16, 18, 20],
  ...
]

**Algorithm**

1. Create an empty 'rows' array to contain all of the rows
2. Create a 'row' arry and at it to the overall 'rows' array
3. Repeat Step 2 until all necessary rows have been created
 - All rows have been created when the length of the 'rows' array is equal to the input
4. Sum the final row
5. Return sum of final row

*Problem: Create a Row (Step 2)*

Rules:
- Row is an array
- Array contains integers
- Integers are consecutive even numbers
- Integers in each row form part of an overall sequence
- Rows are of different lengths

- Input: the information needed to create the output
  - Row starting integer
  - Length of the row
- Output: the row itself `[8, 10, 12]`

Examples:
start: 2, length: 1 => [2]
start: 4, length: 2 => [4, 6]
start: 8, length: 3 => [8, 10, 12]

Data structure:
- An array of integers

Algorithm:
1. Create an empty 'row' array to contain the integers
2. Add starting integer 
3. Increment starting integer by 2 to get next integer in sequence
4. Repeat steps 2 and 3 until length has been reached
5. Return the 'row' array

## Final Thoughts

- Not a completely linear process
  - Be prepared to move backwards and forwards between steps
  - Switch between implementation mode and abstract problem solving mode when necessary
  - Don't try to problem solve at the code level