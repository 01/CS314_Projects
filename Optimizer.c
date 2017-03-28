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

static void deleteNonCritical(Instruction * head);
static void findStoreAI(Instruction * instr, int field);
static void findContributingReg(Instruction * instr, int register);


int main()
{
	Instruction *head;

	head = ReadInstructionList(stdin);
	if (!head) {
		WARNING("No instructions\n");
		exit(EXIT_FAILURE);
	}

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
	Instruction *ptr = head;
	while(ptr != NULL){
		if(ptr->opcode == OUTPUTAI) ptr->critical = 1;
	}

	// for outputAI instructions find storeAI instruction that stores in r0
	// storeAI rs -> r0, offset

	// Use recursion, method to find instruction with value, then call same method on that new instructions etc base
	// case front of instruction list

	ptr = head;
	while(ptr != NULL){
		if(ptr->critical ==1){
			findStoreAI(ptr, ptr->field1); //If critical, find a previous instruction with that same field1
			// need to find first storeAI with same field1 and field2 (think field1 is always r0)
		}

		ptr = ptr->next;
	}

	deleteNonCritical(head);
	
	if (head) 
		PrintInstructionList(stdout, head);
	
	return EXIT_SUCCESS;
}

static void deleteNonCritical(Instruction * head){
	// Remove dead code (remove from Double LL classic)
	Instruction *temp, *ptr;
	ptr = head; temp = ptr;
	while (ptr != NULL) {
		temp = ptr;
		if (ptr->critical) {
			ptr = ptr->next;
			continue;
		}
		else{
			// If instruction is not critical, take next instruction and point its previous to non-critical's previous
			if (ptr->next != NULL){
				ptr->next->prev = ptr->prev;
			}
			// If there is a previous instruction point it to the non-critical instructions next instruction
			else if (ptr->prev != NULL){
				ptr->prev->next = ptr->next;
			}
			// if no previous instruction, then the non-critical instruction was the head, update head;
			else{
				head = ptr->next;
			}	
		ptr = ptr->next;
		free(temp);
	 	}
	}
}

static void findStoreAI(Instruction * instr, int field)
{
	Instruction *ptr;
	// work way backwards
	ptr = instr->prev;
	while (ptr != NULL) {
		// Found STOREAI that stores into register that outputInstruction takes
		// find what instruction contribute to that register
		if (ptr->opcode == STOREAI && ptr->field1 == field) {
			findContributingReg(ptr, ptr->field1);
			ptr->critical = 1;
			break;
		}
		ptr = ptr->prev;
	}
}

// From critical instruction, finds previous instructions that loads into that same register 
static void findContributingReg(Instruction * instr, int field){
	Instruction * ptr;

	ptr = instr->prev;

	while (ptr != NULL) {
		
		// LOADAI, load from one register into another 
		// if the instruction is the last instruction to load into register called by findContributing, then its critical
		if (ptr->opcode == LOADAI && ptr->field1 == field) {
			ptr->critical = 1;
			break;
		}
		// LOADI load an actual value into a register
		// if the instruction is the last to load a value into register looking for, its critical.
		if (ptr->opcode == LOADI && ptr->field1 == field) {
			ptr->critical = 1;
			break;
		}
		ptr = ptr->prev;
	}

}

