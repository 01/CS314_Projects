/*
 *********************************************
 *  314 Principles of Programming Languages  *
 *  Spring 2017                              *
 *  Author: Ulrich Kremer                    *
 *  Student Version                          *
 *********************************************
 */

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include "InstrUtils.h"
#include "Utils.h"

int main()
{
	Instruction *head, *ptr;

	head = ReadInstructionList(stdin);
	if (!head) {
		WARNING("No instructions\n");
		exit(EXIT_FAILURE);
	}

	/* YOUR CODE GOES HERE */
		/* YOUR CODE GOES HERE */

	/* Instruction structure is 
	 * OpCode opcode;
	 * int field1;
	 * int field2;
	 * int field3;
	 * Instruction *prev;	//previous instruction 
	 * Instruction *next;   //next instruction 	
	 * 
	 * typedef enum {LOADI, LOADAI, STOREAI, ADD, SUB, MUL, DIV, OUTPUTAI} OpCode; 
	 */
	
/* Initial crucial isntructions are all outputAI
 * First crucuial instruction is a storeAI the references r0.
 * Instructrion that compute a value for r0 also need to be marked critical
 * Algorithm should be performed for all outputAI isntructions. 
 * Instructions that are deleted must be explicitly deallocated
 */
	// Mark initial critical instructions (outputAI) : outputAI rx -> r0, offset
	// opcode = outputAI, field1 = r0, field 2 = offset;
	ptr = head;
	while(p != NULL){
		if(ptr->opcode == outputAI) ptr->critical = 1;
	}



	// for outputAI instructions find storeAI instruction that stores in r0
	// storeAI rs -> r0, offset

	// Classic recursion.... method(start instruction, register)-> go backwards when find it, call same method.

	// Remove dead code (remove from LL classic)
	Instruction *next;
	ptr = head; next = ptr;
	while(ptr != NULL){
		if(ptr->critical){
			ptr->next = next;
			free(ptr);
		}
	}

	if (head) 
		PrintInstructionList(stdout, head);
	
	return EXIT_SUCCESS;

	// Mark initial critical codes 


	if (head) 
		PrintInstructionList(stdout, head);
	
	return EXIT_SUCCESS;
}

