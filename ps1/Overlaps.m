//
//  Overlaps.m
//  
//  CS3217 || Assignment 1
//  Name: Hong Dai Thanh
//

#import <Foundation/Foundation.h>
// Import PERectangle here
// #import "PERectangle.h"

// define structure Rectangle
struct Rectangle {
	int x;
	int y;
	int width;
	int height;
};

int overlaps(struct Rectangle rect1, struct Rectangle rect2) {
    // EFFECTS: returns 1 if rectangles overlap and 0 otherwise
    int rect1RightX = rect1.x + rect1.width;
    int rect2RightX = rect2.x + rect2.width;
    int rect1BottomY = rect1.y - rect1.height;
    int rect2BottomY = rect2.y - rect2.height;
    // TODO: Remove this!!!
    // printf("%d %d %d %d %d %d %d %d\n", rect1.x, rect1RightX, rect1.y, rect1BottomY, rect2.x, rect2RightX, rect2.y, rect2BottomY);
    if (rect1RightX < rect2.x || rect2RightX < rect1.x || rect2.y < rect1BottomY || rect1.y < rect2BottomY)
        return 0;
    else
        return 1;
}

// TODO: Remove this!!!
int test();


int main (int argc, const char * argv[]) {
	
    if (test()) {
        printf("Testing completed succesfully\n");
    } else {
        printf("Failed\n");
    }
    
	/* Problem 1 code (C only!) */
	// declare rectangle 1 and rectangle 2
	struct Rectangle rectangle1, rectangle2;
	// input origin for rectangle 1
	printf("Input <x y> coordinates for the origin of the first rectangle: ");
	scanf("%d%d", &rectangle1.x, &rectangle1.y);
	// input size (width and height) for rectangle 1
	printf("Input width and height of the first rectangle: "); 
	scanf("%d%d", &rectangle1.width, &rectangle1.height);
	// input origin for rectangle 2
	printf("Input <x y> coordinates for the origin of the second rectangle: ");
    scanf("%d%d", &rectangle2.x, &rectangle2.y);
	// input size (width and height) for rectangle 2
    printf("Input width and height of the second rectangle: ");
    scanf("%d%d", &rectangle2.width, &rectangle2.height);
	// check if overlapping and write message
    if (overlaps(rectangle1, rectangle1)) {
        printf("The two rectangle objects are overlapping!");
    }
    else {
        printf("The two rectangles are not overlapping!");
    }
    
	/* Problem 2 code (Objective-C) */
	// declare rectangle 1 and rectangle 2 objects
    
	// input rotation for rectangle 1
    
	// input rotation for rectangle 2
    
	// rotate rectangle objects
	
	// check if rectangle objects overlap and write message
    
	// clean up
    
	// exit program
	return 0;
}

// This is where you should put your test cases to test that your implementation is correct. 
int test() {
    // EFFECTS: returns 1 if all test cases are successfully passed and 0 otherwise
    struct Rectangle rect1, rect2;
    // Problem 1
    // Test 1
    rect1.x = 0; rect1.y = 40;
    rect1.width = 30; rect1.height = 40;
    rect2.x = 30; rect2.y = 20;
    rect2.width  = 10; rect2.height = 10;
    if (!overlaps(rect1, rect2))
        return 0;
    
    // Test 2 (reuse rect1)
    rect2.x = -20; rect2.y = 0;
    rect2.width = 20; rect2.y = 10;
    if (!overlaps(rect1, rect2))
        return 0;
    
    // Test 3 (reuse rect1)
    rect2.x = 10; rect2.y = 50;
    rect2.width = 20; rect2.height = 9;
    if (overlaps(rect1, rect2))
        return 0;
    
    // Test 4 (reuse rect1)
    rect2.x = 10; rect2.y = 50;
    rect2.width = 20; rect2.height = 10;
    if (!overlaps(rect1, rect2))
        return 0;
    
    // Test 5 (reuse rect1)
    rect2.x = 10; rect2.y = 50;
    rect2.width = 20; rect2.height = 15;
    if (!overlaps(rect1, rect2))
        return 0;
    
    // Test 6 (reuse rect1)
    rect2.x = 1; rect2.y = 39;
    rect2.width = 28; rect2.y = 38;
    if (!overlaps(rect1, rect2))
        return 0;

    // Test 7 (reuse rect1)
    rect2.x = -20; rect2.y = 70;
    rect2.width = 10; rect2.height = 10;
    if (overlaps(rect1, rect2))
        return 0;
    
    // Test 8 (reuse rect1)
    rect2.x = -20; rect2.y = 70;
    rect2.width = 100; rect2.height = 10;
    if (overlaps(rect1, rect2))
        return 0;
    
    // Test 9 (reuse rect1)
    rect2.x = -20; rect2.y = 70;
    rect2.width = 10; rect2.height = 100;
    if (overlaps(rect1, rect2))
        return 0;
    
    return 1;
}

/* 
 
 Question 2(h)
 ========
 
 <Your answer here>
 
 
 
 Question 2(i): Reflection (Bonus Question)
 ==========================
 (a) How many hours did you spend on each problem of this problem set?
 
 <Your answer here>
 
 (b) In retrospect, what could you have done better to reduce the time you spent solving this problem set?
 
 <Your answer here>
 
 (c) What could the CS3217 teaching staff have done better to improve your learning experience in this problem set?
 
 <Your answer here>
 
 */
