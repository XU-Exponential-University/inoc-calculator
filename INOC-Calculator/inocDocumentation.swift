/*
//This document shows all variables and functions that are used in the project.

/*
general idea of input and output: The user taps onto a number button on the UI. Then the a function is called which picks a string from the inputStrings dictionary
to add the fitting String to the outputLabel. After the user finished his input of numbers and tapped onto an operator button the logic switches to the state "State.secondInput"
and stores the first number that was input by the user. The state is useful to track whether an operation was made before and we can use 
*/

/*
*****
VARIABLES
*****
*/

/*
UI interaction
*/

//The main label at the top of the calculator to show current input as well as the result.
let outputLabel: UILabel



/*
Logic
*/

//default state is set to first input a new number.
//holds the last state of the calculator
var lastState: State = State.firstInput

//holds the current state the calculator is in
var state: State = State.firstInput

//represents all different calculator is in
enum State: Integer{
    case firstInput = "FIRST_INPUT"
    case secondInput = "SECOND_INPUT"
    case result = "RESULT"
    case inputAfterResult = "INPUT_AFTER_RESULT"
}

//maps every number button Tag to a specific input String
//tags reserved for numbers and other input signs: 0...19
let inputStrings: [Int: String] = [
    0 : "0",
    1 : "1",
    2 : "2",
    3 : "3",
    4 : "4",
    5 : "5",
    6 : "6",
    7 : "7",
    8 : "8",
    9 : "9",
    10 : "."
]

//maps every input tag to a specific operator
//tags reserved for operators: 20...INFINITY
let operators: [Int: String] = [
    20 : "RESULT",
    21 : "ADD",
    22 : "SUBTRACT",
    23 : "DIVIDE",
    24 : "MULTIPLY",
    25 : "PERCENT",
    26 : "PLUS_MINUS_SWITCH"
]



/*
Math
*/

//stores the first input number
var firstInput: Double
//stores the second input number
var secondInput: Double
//stores the current operator of calculation
var currentOperator: String
//! all of the above might become obsulete if we use the indirect enum with a recursive function

//stores the result of the last calculation
var lastResult: Double

//to be tested by @Felix. Could be sick tho
indirect enum Operation{
    case value(Int)
    case addition(Expression, Expression)
    case difference(Expression, Expression)
}











/*
*****
FUNCTIONS
*****
*/

/*
Logic
*/

//This function updates the current state as well the lastState variable.
fun updateState(to newState: State){
    /*
    Uses switch statement about newState to decide what to do.
    If state being switched to equlas State.inputAfterResult then save the current value of lastResult to firstNumber.
    If state being switched to equals State.secondNumber then save the currentInput to the firstInput variable.
    Always store currentState to lastState and update currentState with the newState.
    */
}

//This function gets called after the number input is finished and the user wants to see the result
fun getResult(){
    /*
    The function checks which math operation was input (use switch case)by the user and calls a function to get a result. Empties out the first number and second number.
    And stores the result as last result. Then the result is displayed in the outPutLabel, after clearing that. Also the state is being set to State.result and 
    stores the current result also as lastResult.
    */
}


//To be tested by @Felix
//Recursive function to use the Expression enum as input and recursively calculates the result
fun getResultRecursive(_ expression: Expression) -> Double{
    /*
    Uses a switch to check which state the enum has and returns a resulting operation. The recursive anchor would be the Expression.value case.
    */
}



/*
Ui
*/

//This function is called whenever a button of the numpad is pressed. Those are 0-9 as well as the ".".
fun addNumberToInput(){
    /*
    Takes the tag of the button and adds the equivalent number to the output label using the dictionary.
    Also changes the current state to number input, after a calcution operator was pressed.
    */
}

//This function is called whenever a user taps onto an operator button such as "+, -, =, etc."
fun makeOperation(){
    /*
    If the lastState equals to State.result change state State.inputAfterResult, because the user just takes the lastResult as first Input.
    Else switch the current state to State.secondNumber.
    Also looks up the right operator String and stores that into the variable currentOperator.
    */
}

//This function gets called whenever there is need to clear the current content of the output label.
fun clearOutputLabel(){
    /*
    Sets the current text of the outputLabel to "".
    The function prevents code duplications and makes maintainance easier.
    */
}

//This functions adds a Double to the outputLabel
fun displayResult(result: Double){
    /*
    Takes a Double as Input automatically shortens that to 4 decimal points and displays that number as String in the outputLabel
    */
}

//This function is used to switch the sign of the input in the outputLabel.
fun switchSign(){
    /*
    Takes the current input and adds a minus in front if there is none. Otherwise removes the first character of the string.
    */
}

//Used to make the output in the label more readable
fun autoFormatLabel(){
    /*
    Checks length of the number input and adds commas to show 100 blocks.
    */
}



/*
Math operations
*/

//This function returns the sum of two Doubles
fun getSum(add: Double, with:Double) -> Double{
    /*
    Sums up both summands and returns the output.
    */
}

//This function returns the difference of two Doubles.
fun getDifference(subtract: Double, from: Double) -> Double{
    /*
    Subtract one Double from the other and returns the result.
    */
}

//Returns product of two Doubles
fun getProduct(multiply: Double, by: Double) -> Double{
    /*
    Returns the result of multiplying one Double several times.
    */
}

//Returns Fraction of two Doubles
fun getFraction(denominator: Double, numerator: Double) -> Double{
    /*
    Returns a fraction after dividing the numerator by the denominator.
    */
}
*/
