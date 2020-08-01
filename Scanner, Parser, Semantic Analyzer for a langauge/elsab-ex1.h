#ifndef __ELSAB_EX1_H__
#define __ELSAB_EX1_H__

typedef struct myNode {
    char* name;
    struct myNode * next;
} myNode;

myNode * emptyList() {
struct myNode* head = malloc(sizeof(myNode));
  head->name = "Dummy";
  head->next = NULL;
  return head;
}

void push(struct myNode* head, char* name)
{
    struct myNode* ptr = malloc(sizeof(myNode));
    ptr->next = head->next;
    ptr->name = name;
    head->next = ptr;
}

void searchdecl(struct myNode* head, char* searched, int linenumber) {
int check = 0;
    struct myNode* current = head;  
    while (current != NULL)
    {
        if (strcmp(current->name,searched)==0)
        {
            check = 1; 
	}
	current = current -> next;
if (check) {

printf("ERROR: %d Redefinition of variable\n", linenumber);
exit(1);
}
else {
	
}
}	    	
}

int searchundef(struct myNode* head, char* searched, int linenumber) {
int check = 0;
    struct myNode* current = head;  
    while (current != NULL)
    {
        if (strcmp(current->name,searched)==0)
        {
            check = 1; 
	    }
		current = current -> next;
	}
	
if (check) {
	return check;
}
else {
	return check;
printf("ERROR: %d undeclared variable\n", linenumber);
exit(1);	
  }
}

void print(struct myNode* head) {

    struct myNode* current = head -> next ;
	while (current != NULL)
    {
          printf("%s", current->name);   
          current = current -> next;
	}  
      	return;
}

void deleteList(struct myNode* head) 
{ 
   head->next = NULL;
} 
#endif
