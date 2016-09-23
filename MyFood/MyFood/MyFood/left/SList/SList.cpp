//
//  SList.cpp
//  MyFood
//
//  Created by qunlee on 16/8/18.
//  Copyright © 2016年 qunlee. All rights reserved.
//

#include "SList.hpp"
#ifndef StdLib
#define StdLib
#include <stdlib.h>

#endif
#define N  3
typedef struct Node{
    int data;
    struct Node *nextNode;
}SList;//SList为结构体名称
/*
 *  指针指向谁就把谁的地址赋给指针；
 *  画图配合辅助指针理解；
 *  辅助指针的移动；
 *  基础概念：头结点（pHead）、前驱结点（pPrevious）、后继结点（pNext）、当前结点（pCurrent）；
 */
/*
    链表(Linkedlist）是一种常见的基础数据结构，是一种线性表，是一种物理存储单元上非连续、非顺序的存储结构。数据元素的逻辑顺序是通过链表中的指针链接次序实现的，但是并不会按线性的顺序存储数据，链表通常由一连串节点组成，每个节点包含任意的实例数据（datafields）和一或两个用来指向上一个/或下一个节点的位置的链接（"links"）。在计算机科学中，链表作为一种基础的数据结构可以用来生成其它类型的数据结构。
 链表最基本的结构是在每个节点保存数据和到下一个节点的地址，在最后一个节点保存一个特殊的结束标记。另外在一个固定的位置保存指向第一个节点的指针，有的时候也会同时储存指向最后一个节点的指针。但是也可以提前把一个节点的位置另外保存起来，然后直接访问。当然如果只是访问数据就没必要了，不如在链表上储存指向实际数据的指针。这样一般是为了访问链表中的下一个或者前一个节点。
 优势：可以克服数组链表需要预先知道数据大小的缺点，链表结构可以充分利用计算机内存空间，实现灵活的内存动态管理。链表最明显的好处就是，常规数组排列关联项目的方式可能不同于这些数据项目在记忆体或磁盘上顺序，数据的存取往往要在不同的排列顺序中转换。而链表是一种自我指示数据类型，因为它包含指向另一个相同类型的数据的指针（链接），同时，链表允许插入和移除表上任意位置上的节点。
 劣势：链表由于增加了结点的指针域，空间开销比较大；另外，链表失去了数组随机读取的优点，一般查找一个节点的时候需要从第一个节点开始每次访问下一个节点，一直访问到需要的位置。
 */
/*
 单向链表
 链表中最简单的一种是单向链表，
 一个单向链表的节点被分成两个部分。它包含两个域，一个信息域和一个指针域。第一个部分保存或者显示关于节点的信息，第二个部分存储下一个节点的地址，而最后一个节点则指向一个空值。单向链表只可向一个方向遍历。
 */
Node *exampleLink = NULL;
/** 初始化 */
void initLinkedList(void){
    Node *pNext = NULL;
    //头节点
    exampleLink = (Node *)malloc(sizeof(Node));
    if (NULL == exampleLink) {
        return;
    }
    exampleLink ->nextNode = NULL;
    pNext = exampleLink;
    for (int i; i < N; i++) {
        pNext->nextNode = (Node *)malloc(sizeof(Node));
        if (NULL == pNext ->nextNode) {
            return;
        }
        pNext ->nextNode ->nextNode = NULL;
        pNext = pNext ->nextNode;
    }
    
}
/** 获取某一节点 */
Node * get(Node *linkedList, int i){
    if (NULL == linkedList) {
        return NULL;
    }
    Node *tempLink = linkedList ->nextNode;
    int count = 0;
    while (count < i&&NULL != tempLink) {
        count++;
        tempLink = tempLink ->nextNode;
    }
    return tempLink;
}
/** 在节点i位置，插入节点 */
bool insert(Node *&linkedList, int x, int i){
    Node *newLink = NULL;
    Node *tempLink = NULL;
    
    newLink = (Node *)malloc(sizeof(Node));
    if (NULL == newLink) {
        return false;
    }
    newLink ->data = x;
    newLink ->nextNode = NULL;
    if (i == 0) {
        newLink ->nextNode = linkedList;
        linkedList = newLink;
    }else{
        tempLink = get(linkedList, i - 1);
        if (NULL == tempLink) {
            return false;
        }
        newLink ->nextNode = tempLink ->nextNode;
        tempLink = newLink;
    }
    return true;
}
/** 单向列表逆序 */
Node* reverseLinkedList(Node* head){
    if (head == NULL&&head->nextNode == NULL) {
        return head;
    }
    Node *p1  = head;
    Node *p2  = p1->nextNode;
    Node *p3  = p2->nextNode;
    p3->nextNode = NULL;
    while (p3 != NULL) {
        p2->nextNode = p1;
        p1 = p2;
        p2 = p3;
        p3 = p3->nextNode;
    }
    p2 ->nextNode = p1;
    head = p2;
    return head;
}
/*
 双向链表
 双向链表其实是单链表的改进，当我们对单链表进行操作时，有时你要对某个结点的直接前驱进行操作时，又必须从表头开始查找。这是由单链表结点的结构所限制的。因为单链表每个结点只有一个存储直接后继结点地址的链域，那么能不能定义一个既有存储直接后继结点地址的链域，又有存储直接前驱结点地址的链域的这样一个双链域结点结构呢？这就是双向链表。
 在双向链表中，结点除含有数据域外，还有两个链域，一个存储直接后继结点地址，一般称之为右链域（当此“连接”为最后一个“连接”时，指向空值或者空列表）；一个存储直接前驱结点地址，一般称之为左链域（当此“连接”为第一个“连接”时，指向空值或者空列表）。
 
 循环链表
 循环链表是与单向链表一样，是一种链式的存储结构，所不同的是，循环链表的最后一个结点的指针是指向该循环链表的第一个结点或者表头结点，从而构成一个环形的链。
 循环链表的运算与单链表的运算基本一致。所不同的有以下几点：
 1、在建立一个循环链表时，必须使其最后一个结点的指针指向表头结点，而不是象单链表那样置为NULL。此种情况还使用于在最后一个结点后插入一个新的结点。
 2、在判断是否到表尾时，是判断该结点链域的值是否是表头结点，当链域值等于表头指针时，说明已到表尾。而非象单链表那样判断链域值是否为NULL。
 
 块状链表
 块状链表本身是一个链表，但是链表储存的并不是一般的数据，而是由这些数据组成的顺序表。每一个块状链表的节点，也就是顺序表，可以被叫做一个块。
 块状链表另一个特点是相对于普通链表来说节省内存，因为不用保存指向每一个数据节点的指针。
 
 其他相关
 链表的提出主要在于：顺序存储中的插入和删除的时间复杂度是线性时间的，而链表的操作则可以是常数时间的复杂度。
 链表的插入与删除操作顺序：
 插入操作处理顺序：中间节点的逻辑，后节点逻辑，前节点逻辑。
 删除操作的处理顺序：前节点逻辑，后节点逻辑，中间节点逻辑。
 */