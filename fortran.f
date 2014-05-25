C Charles Effinger - CS 450g Assignment 1
C This Fortran program builds, prints, and probes a binary tree. 
      PROGRAM Fortran
C The function getNodeCount reads in the node count for the tree and 
C calls the necessary subroutines to build and print the tree.
      CALL getNodeCount
C The function getProbeCount reads in the probe count for the tree and 
C calls the subroutine to probe the tree.
      CALL getProbeCount
      END

C This subroutine reads the node count for the tree. Then, it sets up the
C common variables for the building and calls the necessary subroutines
C to build and print the tree.
      SUBROUTINE getNodeCount
      INTEGER nodeCount
1     WRITE(*,*), 'What is the node count?'
      READ(*,*) , nodeCount
C We need to assert that the node count is less than or equal to 1000.
      IF (nodeCount - 1000) 3, 3, 2
2     WRITE(*,*), 'Invalid node count. Please enter an integer <= 1000.'
      GOTO 1
C We need to assert that the node count is greater than 0.
3     IF (nodeCount) 4, 4, 5
4     WRITE(*,*), 'Invalid node count. Please enter an integer > 0.'
      GOTO 1
C The setCommon subroutine will initializes the common area.      
5     CALL setCommon(nodeCount)
C The populateTree subroutine will create a tree with the given input.
      CALL populateTree(nodeCount)
C The printTree subroutine will display the tree in different forms. 
      CALL printTree(nodeCount)
      END 
     
C This subroutine reads in the probe count. The probeTree subroutine is 
C called for the given probeCount, which will handle the tree probing.
      SUBROUTINE getProbeCount
      INTEGER probeCount
9     WRITE(*,*), 'What is the probe count?'
      READ(*,*), probeCount
C We need to assert that the probe count is not a negative number. 
      IF (probeCount) 7,8,8      
7     WRITE(*,*), 'Invalid probe count. Please enter an integer >= 0.' 
      GOTO 9 
8     CALL probeTree(probeCount)
      END

C The common area arrays are set for the tree. 
      SUBROUTINE setCommon(nodeCount)     
      INTEGER node, left, right, nodeCount
      DIMENSION node(1000), left(1000), right(1000) 
C The value 1000 because Dr. Finkel defined it as the maximum nodeCount.
      COMMON node, left, right
C The array node() represents the actual nodes of the tree.
C The array left() represents the left pointer. Its value represents the 
C index of node.
C The array right() represents the right pointer. Its value represents the
C index of the node.      

C This loop initializes the left and right pointer full of zeros. The zeros
C represent null pointers.  
      DO 6, I = 1, nodeCount
          left(I) = 0
          right(I) = 0
6     CONTINUE
      END

C This subroutine populates the binary tree with 'nodeCount' nodes.
      SUBROUTINE populateTree(nodeCount)      
      INTEGER nodeCount, node, left, right, currentNode
      DIMENSION node(1000), left(1000), right(1000)     
C We need to get the common arrays to represent the tree.       
      COMMON node, left, right
      
C The first value is set to the head node.
      READ(*,*), node(1)
C The loop runs 'nodeCount - 1' times in order to read in the rest of the
C nodes and insert them into the tree. 
      DO 30, I = 2, nodeCount
         READ(*,*), node(I) 
C The currentNode variable is initially set the head node. 
C This value should change as the tree searches for the correct place to 
C insert the newest node.          
         currentNode = 1
C The new node is checked with the 'currentNode' 
29       IF(node(I) - node(currentNode)) 21,20,22 
C If the new node is equal to the currentNode, make the new node the
C right pointer of the currentNode. The left pointer of the new node is 
C still null, and the right node becomes its parent's old right pointer.
20       right(I) = right(currentNode)
         left(I) = 0 
         right(currentNode) = I 
         GOTO 30                              
C If the new node is less than the current node, check the left pointer
C of the current node.
21       IF (left(currentNode)) 24,23,24
C If the current node's left pointer is empty, place the new node into 
C this slot.
23       left(currentNode) = I
         GOTO 30           
C If the current node's left pointer is full, use that node as the 
C current node. Then, repeat the check with the new node.
24       currentNode = left(currentNode) 
         GOTO 29
C If the new node is greater than the current node, check the right pointer
C of the current node.
22       IF (right(currentNode)) 26,25,26
C If the right pointer is empty, place the new node into this slot.
25       right(currentNode) = I 
         GOTO 30
C If the right pointer is full, use this node as the current node. Then,
C repeat the check with the new node.
26       currentNode = right(currentNode)
         GOTO 29                
30    CONTINUE

      END

C This subroutine calls the proper subroutines in order to output the tree.    
      SUBROUTINE printTree(nodeCount)
      CALL preOrder(nodeCount)
      CALL breadthFirst(nodeCount)
      CALL postOrder(nodeCount)
      END
      
C This subroutine will print out the tree in preOrder. It uses an array,
C stack(), to simulate a stack in order to accomplish the preOrder
C algorithm. Since preorder goes node-left-right, adding the current top
C of the stack's children to the top of the stack allows for the stack to
C print out in preorder.
      SUBROUTINE preOrder(nodeCount) 
C First, retrieve the common tree arrays. The stack array will be used 
C to simulate a stack.   
      INTEGER node, left, right, stack, stackSize, currentNode
      DIMENSION node(1000), left(1000), right(1000), stack(1000)
      COMMON node, left, right 
C The head node is place on the 'top' of the stack. The stackSize 
C counter is thus initialized as 1. 
      stack(1) = 1
      stackSize = 1

      WRITE(*,*), 'preOrder: '
C The loop will run nodeCount times, as each iteration will print out one
C of the nodes of the tree. 
      DO 50, I = 1, nodeCount
C Print out what is on top of the stack. Then, erase this value.          
         currentNode = stack(stackSize)
         WRITE(*,*), node(currentNode)
         stack(stackSize) = 0 
C Check the right pointer of the recently printed node to see if it
C contains a pointer. 
         IF (right(currentNode)) 51,52,51
C If the right pointer is not null, place this node on top of the stack 
51       stack(stackSize) = right(currentNode)
         stackSize = stackSize + 1
         GOTO 52
C Check the left pointer of the recently printed node to see if it contains
C a pointer.
52       IF (left(currentNode)) 53,54,53
C If the left pointer is not null, place this node on top of the stack 
53       stack(stackSize) = left(currentNode)
         stackSize = stackSize + 1
         GOTO 54
C Decrease the size of the stack by one since the printed node was erased.
54       stackSize = stackSize - 1
         GOTO 50 
50    CONTINUE
      END
      
C This subroutine displays the tree in breadth-first order. The array 
C queue() is used to simulate a queue in order to accomplish the breadth 
C first algorithm. Adding the children of the current head of the queue to 
C end of the queue allows the queue to print out in breadth-first order.
      SUBROUTINE breadthFirst(nodeCount)
C First, retrieve the common tree arrays. The queue array will be used to
C simulate a queue. 
      INTEGER node, left, right, queue, queueSize
      DIMENSION node(1000), left(1000), right(1000), queue(1000) 
      COMMON node, left, right     
C The head node is placed at the front of the queue and the queueSize is 
C updated accordingly.       
      queue(1) = 1
      queueSize = 1

      WRITE(*,*), 'Breadth-first: '
C The loop will run nodeCount times, because a node from the tree will be
C printed every iteration. 
      DO 70, I = 1, nodeCount
C Print out what is in the front of the queue. 
         WRITE(*,*), node(queue(I))
C Check the left pointer of the current node to see if it contains a value.
         IF (left(I)) 71,71,72
C If the left pointer is not null, place this node at the end of the queue
C and update the queueSize accordingly. 
72       queueSize = queueSize + 1
         queue(queueSize) = left(I)
         GOTO 71
C Check the right pointer of the current node to see if it contains a 
C value. 
71       IF (right(I)) 70,70,73
C If the right pointer is not null, place this node at the end of the queue
C and update the queueSize accordingly. 
73       queueSize = queueSize + 1
         queue(queueSize) = right(I) 
70    CONTINUE      
      END    

C This subroutine displays the tree in postorder. The array stack() is 
C used to simulate a stack in order to accomplish the postorder algorithm. 
C Carefully managing the stack by adding the children of the top of the 
C stack allows for the stack to print out in postorder. 
      SUBROUTINE postOrder(nodeCount)
C First, retrieve the common tree arrays. The stack array will be used to
C simulate a stack. 
      
      INTEGER nodeCount, node, left, right, stack, stackSize, lastValue
      DIMENSION node(1000), left(1000), right(1000), stack(1000)  
      COMMON node, left, right

      WRITE(*,*), 'Postorder: '
C The head of the tree is placed on top of the stack and the stackSize is 
C updated accordingly. 
      stack(1) = 1
      stackSize = 1
C The lastValue variable is initialized to a null pointer. This variable
C keeps track of the last printed value. This helps to ensure that a node
C does not get printed twice because it gets visited twice.
      lastValue = 0
C The loop will run nodeCount times, because a node will be printed every 
C iteration. 
      DO 80, I = 1, nodeCount
C The first check sees if we are at the first iteration. If it is not the
C first iteration, we want to check the right pointer first since a node
C has just been printed.
         IF (I-1) 89, 89, 85
C If this is the first iteration, or if the right pointer of the current
C top of the stack had a value, check the left pointer for a value.  
89       IF (left(stack(stackSize))) 81,81,82
C In order to ensure a node is not accidently printed twice, we must check
C current node's right pointer to see if it has just been printed. If that
C is the case, skip the normal check and print out the value. 
85       IF (right(stack(stackSize)) - lastValue) 81,83,81
C If the left pointer of the current top of the stack is empty, or if the 
C right pointer of the top of the stack was not just visited, check to see
C if the right pointer has a value. 
81       IF (right(stack(stackSize))) 83,83,84
C If the right pointer of the current top of the stack is not null, add the
C node to the top of the stack and update the stackSize accordingly. Then, 
C check the left pointer of this new node. 
82       stackSize = stackSize + 1
         stack(stackSize) = left(stack(stackSize - 1))
         GOTO 89
C If the right pointer of the current top of the stack is null, print out 
C the top of the stack and erase it from the stack. The lastValue variable
C gets this node so it is not accidently visited and printed again.
83       WRITE(*,*), node(stack(stackSize))
         lastValue = stack(stackSize)
         stackSize = stackSize - 1
         GOTO 80
C If the right pointer of the current top of the stack is not null, add the
C node to the top of the stack and update the stack accordingly.
84       stackSize = stackSize + 1
         stack(stackSize) = right(stack(stackSize - 1))
         GOTO 89
80    CONTINUE 
      END 

C This subroutine probes our tree to see if it contains the given values.
      SUBROUTINE probeTree(probeCount)
C First, we must retrieve the common arrays of the tree.      
      INTEGER node, left, right, currentNode, probeCount, currentProbe
      DIMENSION node(1000), left(1000), right(1000)
      COMMON node, left, right
C The loop will run probeCount times, as each iteration will discover if
C the probe exists in the tree or not.   
      DO 60, I = 1, probeCount
C We need to read in the current number to be probed.
         READ(*,*), currentProbe
C Initialize the current node to the head node to being the search. 
         currentNode = 1
C We first check to see if the current node is null.
69       IF (currentNode) 62,61,62
C If the current node is null (0), then the probe does not exist in our i
C tree. Print this out for the user and get a new probe.
61       WRITE(*,*), currentProbe, 'no'
         GOTO 60 
C If the current node exists, compare it to our probe, 
62       IF (node(currentNode) - currentProbe) 63, 64, 65
C If the probe is greater than the current node, update the current node
C to be its right pointer and retest.
63       currentNode = right(currentNode)
         GOTO 69
C If the probe is equal to the current node, then we have found the probe
C in the tree. Print this out and get a new probe.
64       WRITE(*,*), currentProbe, 'yes'
         GOTO 60
C If the probe is less than the current node, update the current node to be
C its left pointer and retest. 
65       currentNode = left(currentNode)
         GOTO 69
60    CONTINUE 
      END 
