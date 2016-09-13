//
//  SLinkList.h
//  MyFood
//
//  Created by qunlee on 16/9/1.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#ifndef SLinkList_h
#define SLinkList_h

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc/malloc.h>

#endif /* SLinkList_h */

struct Node {
    char name[10];
    int score;
    struct Node *next;
};

typedef struct Node ListNode;
ListNode *CreateList(int n);
void PrintList(ListNode *h);
void InsertList(ListNode *h,int i,char name[],int e,int n);
void DeleteList(ListNode *h, int i, int n);