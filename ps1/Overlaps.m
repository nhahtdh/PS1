//
//  Overlaps.m
//  
//  CS3217 || Assignment 1
//  Name: Hong Dai Thanh
//

#import <Foundation/Foundation.h>

// Import PERectangle here
#import "PERectangle.h"

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

#if CGFLOAT_IS_DOUBLE == 1
#define ESP 0.0000000001
#else
#define ESP 0.00001
#endif // #define CGFLOAT_IS_DOUBLE

#define float_equals(A, B) (fabs((A) - (B)) < ESP)

int test();

int main (int argc, const char * argv[]) {
    /*
    if (test()) {
        printf("Testing completed succesfully\n");
    } else {
        printf("Failed\n");
    }
    */
    
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
    if (overlaps(rectangle1, rectangle2)) {
        printf("The two rectangle objects are overlapping!\n");
    }
    else {
        printf("The two rectangles are not overlapping!\n");
    }
    
	/* Problem 2 code (Objective-C) */
	@autoreleasepool {
        // declare rectangle 1 and rectangle 2 objects
        PERectangle *peRect1, *peRect2;
        peRect1 = [[PERectangle alloc] initWithOrigin:CGPointMake(rectangle1.x, rectangle1.y) width: rectangle1.width height: rectangle1.height rotation: 0.0];
        peRect2 = [[PERectangle alloc] initWithOrigin:CGPointMake(rectangle2.x, rectangle2.y) width: rectangle2.width height: rectangle2.height rotation: 0.0];
        CGFloat rotateAngle1, rotateAngle2;
        // input rotation for rectangle 1
        printf("Input rotation angle for the first rectangle: ");
        scanf("%lf", &rotateAngle1);
        // input rotation for rectangle 2
        printf("Input rotation angle for the second rectangle: ");
        scanf("%lf", &rotateAngle2);
        
        // rotate rectangle objects
        [peRect1 rotate:rotateAngle1];
        [peRect2 rotate:rotateAngle2];
        
        // check if rectangle objects overlap and write message
        if ([peRect1 overlapsWithRect:peRect2]) {
            printf("The two rectangle objects are overlapping!\n");
        } else {
            printf("The two rectangles are not overlapping!\n");
        }
	}
         
    // exit program
    return 0;
}

// This is where you should put your test cases to test that your implementation is correct. 
int test() {
    // EFFECTS: returns 1 if all test cases are successfully passed and 0 otherwise
    {
        // Problem 1
        // Test 1
        struct Rectangle rect1, rect2;
        
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
    }
    
    
    @autoreleasepool {
        // Problem 2
        PERectangle *rect1, *rect2, *rect3;
        CGPoint* corners;
        int i;
        
        // Test 1
        // Test initWithOrigin
        rect1 = [[PERectangle alloc] initWithOrigin: CGPointMake(-20, 10) width: 40 height: 20 rotation: 0];
        if (!float_equals(rect1.origin.x, -20) || !float_equals(rect1.origin.y, 10) ||
            !float_equals(rect1.width, 40) || !float_equals(rect1.height, 20) ||
            !float_equals(rect1.rotation, 0) ||
            !float_equals(rect1.center.x, 0) || !float_equals(rect1.center.y, 0))
            return 0;
        
        // Test corners (0 rotation)
        corners = [rect1 corners];
        if (!float_equals(corners[0].x, -20) || !float_equals(corners[0].y, 10) ||
            !float_equals(corners[1].x, 20) || !float_equals(corners[1].y, 10) ||
            !float_equals(corners[2].x, 20) || !float_equals(corners[2].y, -10) ||
            !float_equals(corners[3].x, -20) || !float_equals(corners[3].y, -10))
            return 0;
        
        // Test initWithRect
        CGRect cgRect = CGRectMake(30, 20, 35, 10);
        rect2 = [[PERectangle alloc] initWithRect: cgRect];
        if (!float_equals(rect2.origin.x, 30) || !float_equals(rect2.origin.y, 20) ||
            !float_equals(rect2.width, 35) || !float_equals(rect2.height, 10) ||
            !float_equals(rect2.rotation, 0) ||
            !float_equals(rect2.center.x, 47.5) || !float_equals(rect2.center.y, 15))
            return 0;
        
        // Test overlapsWithRect (non-overlapping)
        if ([rect1 overlapsWithRect:rect2] || [rect2 overlapsWithRect:rect1]) {
            return 0;
        }
                
        // Test translate
        [rect1 translateX:15 Y: 5];
        if (!float_equals(rect1.origin.x, -5) || !float_equals(rect1.origin.y, 15) ||
            !float_equals(rect1.width, 40) || !float_equals(rect1.height, 20) ||
            !float_equals(rect1.rotation, 0) ||
            !float_equals(rect1.center.x, 15) || !float_equals(rect1.center.y, 5))
            return 0;
        
        // Check corners
        corners = [rect1 corners];
        if (!float_equals(corners[0].x, -5) || !float_equals(corners[0].y, 15) ||
            !float_equals(corners[1].x, 35) || !float_equals(corners[1].y, 15) ||
            !float_equals(corners[2].x, 35) || !float_equals(corners[2].y, -5) ||
            !float_equals(corners[3].x, -5) || !float_equals(corners[3].y, -5))
            return 0;
        
        // Test overlapsWithRect (overlapping, translated)
        if (![rect1 overlapsWithRect:rect2]) {
            return 0;
        }
        
        [rect1 translateX:-5 Y: -5];
        corners = [rect1 corners];
        
        // Check one corner
        if (!float_equals(corners[1].x, 30) && !float_equals(corners[1].y, 10)) 
            return 0;

        // Test overlapsWithRect (double corners overlapping)
        if (![rect1 overlapsWithRect:rect2] || ![rect2 overlapsWithRect:rect1])
            return 0;
        
        rect3 = [[PERectangle alloc] initWithOrigin:CGPointMake(3, 3) width:1 height:1 rotation:45];
        
        // Test init rotation angle
        if (!float_equals(rect3.rotation, 45))
            return 0;
        
        corners = [rect3 corners];
        // Test corners (rotated rectangle)
        if (!float_equals(corners[0].x, 3.5 - 0.5 * sqrt(2)) || !float_equals(corners[0].y, 2.5) ||
            !float_equals(corners[1].x, 3.5) || !float_equals(corners[1].y, 2.5 + 0.5 * sqrt(2)) ||
            !float_equals(corners[2].x, 3.5 + 0.5 * sqrt(2)) || !float_equals(corners[2].y, 2.5))
            return 0;
        
        // Test overlapsWithRect (containing rectangle)
        if (![rect3 overlapsWithRect:rect1] || ![rect1 overlapsWithRect:rect3])
            return 0;
        
        [rect1 rotate: 45];
        corners = [rect1 corners];
        
        // Test overlapsWithRect (after rotation)
        if ([rect1 overlapsWithRect:rect2] || [rect2 overlapsWithRect:rect1])
            return 0;
        
        [rect1 rotate: 675];
        // Test rotation over 360 degrees
        corners = [rect1 corners];
        if (!float_equals(corners[1].x, 30) && !float_equals(corners[1].y, 10)) 
            return 0;
        
        /*
        printf("%lf %lf %lf %lf %lf %lf %lf\n", rect1.origin.x, rect1.origin.y, rect1.width, rect1.height, rect1.rotation, rect1.center.x, rect1.center.y);
        
        corners = [rect1 corners];
        for (i = 0; i < 4; i++) {
            printf("%lf %lf\n", corners[i].x, corners[i].y);
        }
        */
        
    }
    
    return 1;
}

/* 
 
 Question 2(h)
 ========
 
 Center, height and width. Not much difference from the current representation. Probably less confusing than having origin coordinate being the top-left corner of the rectangle (since the rectangle can be rotated, one can confuse the origin coordinate being rotated along).
 Another possible representation is center, radius of the circumcircle of the rectangle and the original angle between a) the segment that connects topleft corner and center b) the line going through center and parallel to the width edge. The implementation of the corners method will be more complex and the calculation involves trigonometry functions, which are a source of errors. However, all the data about the rectangle will be consistent when rotate.
 
 
 Question 2(i): Reflection (Bonus Question)
 ==========================
 (a) How many hours did you spend on each problem of this problem set?
 
 Didn't do the first part. For the second part, I spent a 3-4 hours on the first problem (most of the time is used to warm up and getting used to the developing environment). I spent about 10 more hours on the second problem.
 
 (b) In retrospect, what could you have done better to reduce the time you spent solving this problem set?
 
 Getting used to the tools (Xcode) and properly design algorthm and test cases before coding.
 
 (c) What could the CS3217 teaching staff have done better to improve your learning experience in this problem set?
 
 The experience is a bit on the down side due to the logistics, and not being able to run program directly in Xcode. Other than that, the learning experience is good: searching the Internet and messing around with the Xcode let me learn quite a lot of things.
 
 */
