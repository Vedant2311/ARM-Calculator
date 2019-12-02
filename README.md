# ARM-Calculator

This is an Implementation of evaluating parenthesized expressions in ARM. **ARMSim** was used to debug and run the program. The examples of the expressions on which the program was tested are given in the file **Mydata.txt**. Please go through these examples. The order of evaluating these expressions is from left to right. And in the case of parenthesis, the priority is given to them i.e. 

    3+(4*2) = 3 + 8 = 11
    3+4*2 = (3 + 4) * 2 = 7*2 = 14

The file **Expression_Evaluator.s** has this above functionality implemented in terms of an entire system of recursion. The file **UsefulFunctions.s** has the standard functions useful for the Angel SWI operations. The **main.s** has all the I/O implementations done for the program. So, you can directly plug in the input in the ARMSim and get the output
    
    
