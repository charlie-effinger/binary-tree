Overview and Use:
The Fortran program 'Fortran' allows a user to create a binary tree from scratch and probe it for its contents. The user must provide a 
node count that is greater than 0 and smaller than 1001. Then, the user must give 'node count' integers to be placed into their tree. After the tree
has been created, the program will output the tree in preorder, breadth-first order, and postorder. (EXTRA CREDIT) The user will then submit a 
probe count integer which must be greater than -1. The user will then be able to enter 'probe count' integers and the program will determine and inform 
the user if they exist in the tree. The program will then exit. 

Compilation and Running Instructions: 
The Fortran program must be compiled in a unix environment. While in the directory where 'fortran.f' exists, you can use the following command from the
terminal to compile the program. 

f95 -g -Wall fortran.f -o fortran

Once the program has been compiled you can invoke it by using the following command.

./fortran

Input can come from user input in terminal, like above, or can be redirected from a text file. In order to use the data in 'data.txt', you can use the 
following command.

./fortran < data.txt 

Output will be printed to the user's terminal unless otherwise specified. In order to redirect the output of the program to 'output.txt', you can use the 
following command.

./fortran > output.txt 


