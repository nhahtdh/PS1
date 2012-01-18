//
//  PERectangle.m
//  
//  CS3217 || Assignment 1
//  Name: Hong Dai Thanh
//

#import "PERectangle.h"

#if CGFLOAT_IS_DOUBLE == 1
#define ESP 0.0000000001
#else
#define ESP 0.00001
#endif // #define CGFLOAT_IS_DOUBLE

#define float_equals(A, B) (fabs((A) - (B)) < ESP)


@implementation PERectangle
// OVERVIEW: This class implements a rectangle and the associated
//             operations.

@synthesize origin;
@synthesize width;
@synthesize height;
@synthesize rotation;

- (CGPoint)center {
    // EFFECTS: returns the coordinates of the centre of mass for this
    // rectangle.
    CGPoint center = CGPointMake(origin.x + width / 2.0, origin.y - height / 2.0);
    return center;
}

- (CGPoint)cornerFrom:(CornerType)corner {
    // REQUIRES: corner is a enum constant defined in PEShape.h as follows:
    //           kTopLeftCorner, kTopRightCorner, kBottomLeftCorner,
    //           kBottomRightCorner 
    // EFFECTS: returns the coordinates of the specified rotated rectangle corner after rotating
    
    CGFloat x, y;
    switch (corner) {
        case kTopLeftCorner:
            x = self.origin.x;
            y = self.origin.y;
            break;
        case kTopRightCorner:
            x = self.origin.x + self.width;
            y = self.origin.y;
            break;
        case kBottomLeftCorner:
            x = self.origin.x;
            y = self.origin.y - self.height;
            break;
        case kBottomRightCorner:
            x = self.origin.x + self.width;
            y = self.origin.y - self.height;
            break;
    }
    x -= self.center.x;
    y -= self.center.y;
    
    // Conversion to radian: deg / 180 * PI
    CGFloat rotationInRad = self.rotation / 180. * acos(-1.);
    return CGPointMake(
                       self.center.x + cos(rotationInRad) * x - sin(rotationInRad) * y,
                       self.center.y + sin(rotationInRad) * x + cos(rotationInRad) * y);
}

- (CGPoint*)corners {
    // EFFECTS:  return an array with all the rectangle corners
    
    CGPoint *corners = (CGPoint*) malloc(4*sizeof(CGPoint));
    corners[0] = [self cornerFrom: kTopLeftCorner];
    corners[1] = [self cornerFrom: kTopRightCorner];
    corners[2] = [self cornerFrom: kBottomRightCorner];
    corners[3] = [self cornerFrom: kBottomLeftCorner];
    return corners;
}

- (id)initWithOrigin:(CGPoint)o width:(CGFloat)w height:(CGFloat)h rotation:(CGFloat)r{
    // MODIFIES: self
    // EFFECTS: initializes the state of this rectangle with origin, width,
    //          height, and rotation angle in degrees
    origin = o;
    width = w;
    height = h;
    rotation = r;
    return self;
}

- (id)initWithRect:(CGRect)rect {
    // MODIFIES: self
    // EFFECTS: initializes the state of this rectangle using a CGRect
    origin = rect.origin;
    width = rect.size.width;
    height = rect.size.height;
    rotation = 0.0;
    return self;
}

- (void)rotate:(CGFloat)angle {
    // MODIFIES: self
    // EFFECTS: rotates this shape anti-clockwise by the specified angle
    // around the center of mass
    self.rotation += angle;
    self.rotation = self.rotation - round(self.rotation / 360.) * 360.;
}

- (void)translateX:(CGFloat)dx Y:(CGFloat)dy {
    // MODIFIES: self
    // EFFECTS: translates this shape by the specified dx (along the
    //            X-axis) and dy coordinates (along the Y-axis)
    self.origin = CGPointMake(self.origin.x + dx, self.origin.y + dy);
}

- (BOOL)overlapsWithShape:(id<PEShape>)shape {
    // EFFECTS: returns YES if this shape overlaps with specified shape.
    if ([shape class] == [PERectangle class]) {
        return [self overlapsWithRect:(PERectangle *)shape];
    }
    
    return NO;
}

+ (BOOL)isSegmentIntersect:(CGPoint)seg1pt1 :(CGPoint)seg1pt2 
                          :(CGPoint)seg2pt1 :(CGPoint)seg2pt2 {
    // EFFECTS: return YES if the segments have at least 1 point in common; 
    // return NO otherwise.
    
    // The vector corresponding to the segments
    CGPoint seg1vector = CGPointMake(seg1pt1.x - seg1pt2.x, seg1pt1.y - seg1pt2.y);
    CGPoint seg2vector = CGPointMake(seg2pt1.x - seg2pt2.x, seg2pt1.y - seg2pt2.y);

    // a, b, c are the coefficients in the representation 
    // of a general line: ax + by = c
    CGFloat a1, b1, c1;
    a1 = seg1vector.y;
    b1 = -seg1vector.x;
    c1 = seg1pt1.x * seg1vector.y - seg1vector.x * seg1pt1.y;
    CGFloat a2, b2, c2;
    a2 = seg2vector.y;
    b2 = -seg2vector.x;
    c2 = seg2pt1.x * seg2vector.y - seg2vector.x * seg2pt1.y;
   
    CGFloat D, Dx, Dy;
    D = a2 * b1 - a1 * b2;
    Dx = c2 * b1 - c1 * b2;
    Dy = a2 * c1 - a1 * c2;
    if (float_equals(D, 0)) {
        if (float_equals(Dx, 0) && float_equals(Dy, 0)) { // 2 segments on the same line
            if (seg1pt1.x == seg1pt2.x && seg1pt2.x == seg2pt1.x 
                && seg2pt1.x == seg2pt2.x) { // On the same vertical line
                CGFloat seg1MaxY, seg1MinY, seg2MaxY, seg2MinY;
                seg1MaxY = MAX(seg1pt1.y, seg1pt2.y);
                seg1MinY = MIN(seg1pt1.y, seg1pt2.y);
                seg2MaxY = MAX(seg2pt1.y, seg2pt2.y);
                seg2MinY = MIN(seg2pt1.y, seg2pt2.y);
                if (seg1MaxY < seg2MinY || seg2MaxY < seg1MinY) {
                    return NO;
                } else {
                    return YES;
                }
                
            } else {
                CGFloat seg1MaxX, seg1MinX, seg2MaxX, seg2MinX;
                seg1MaxX = MAX(seg1pt1.x, seg1pt2.x);
                seg1MinX = MIN(seg1pt1.x, seg1pt2.x);
                seg2MaxX = MAX(seg2pt1.x, seg2pt2.x);
                seg2MinX = MIN(seg2pt1.x, seg2pt2.x);
                if (seg1MaxX < seg2MinX || seg2MaxX < seg1MinX) {
                    return NO;
                } else {
                    return YES;
                }
            }
        } else { // 2 segments on parallel lines
            return NO;
        }
    } else {
        CGFloat seg1MaxX, seg1MinX, seg2MaxX, seg2MinX;
        seg1MaxX = MAX(seg1pt1.x, seg1pt2.x);
        seg1MinX = MIN(seg1pt1.x, seg1pt2.x);
        seg2MaxX = MAX(seg2pt1.x, seg2pt2.x);
        seg2MinX = MIN(seg2pt1.x, seg2pt2.x);
        CGFloat intersectX = Dx / D;
        // At this point, at most one of the segment will have inf. tangent.
        if (seg1MinX <= intersectX && intersectX <= seg1MaxX && 
            seg2MinX <= intersectX && intersectX <= seg2MaxX) {
            return YES;
        } else{
            return NO;
        }
    }
}

+ (int)ccwTest:(CGPoint) p : (CGPoint) q: (CGPoint) r {
    // EFFECTS: return YES if p-q-r is a right turn
    return (q.x - p.x) * (r.y - q.y) - (q.y - p.y) * (r.x - q.x) >= 0.;
}

- (BOOL)overlapsWithRect:(PERectangle*)rect {
    // EFFECTS: returns YES if this shape overlaps with specified shape.
    CGPoint *corners1, *corners2;
    corners1 = self.corners;
    corners2 = rect.corners;
    
    int i, j;
    // Test for point inside rectangle
    for (i = 0; i < 4; i++) {
        int sign = [PERectangle ccwTest: corners1[i] :corners2[3] :corners2[0]];
        for (j = 0; j < 3; j++) {
            if ([PERectangle ccwTest: corners1[i] :corners2[j]: corners2[j + 1]] != sign)
                goto UNDECIDED_1;
        }
        return YES;
        UNDECIDED_1:;
    }
    
    for (i = 0; i < 4; i++) {
        int sign = [PERectangle ccwTest: corners2[i] :corners1[3] :corners1[0]];
        for (j = 0; j < 3; j++) {
            if ([PERectangle ccwTest: corners2[i] :corners1[j]: corners1[j + 1]] != sign)
                goto UNDECIDED_2;
        }
        return YES;
        UNDECIDED_2:;
    }
    
    // Test for intersection
    for (i = 0; i < 4; i++)
        for (j = 0; j < 4; j++) {
            if ([PERectangle isSegmentIntersect:corners1[i] :corners1[(i + 1) % 4] : corners2[j]: corners2[(j + 1) % 4]]) {
                return YES;
            }
        }
    
    return NO;
}

- (CGRect)boundingBox {	
    // EFFECTS: returns the bounding box of this shape.
    CGPoint* corners = [self corners];
    
    CGFloat minX, maxX, minY, maxY;
    minX = maxX = corners[0].x;
    minY = maxY = corners[0].y;
    int i = 1;
    for (i = 1; i < 4; i++) {
        minX = MIN(minX, corners[i].x);
        minY = MIN(minY, corners[i].y);
        maxX = MAX(maxX, corners[i].x);
        maxY = MAX(maxY, corners[i].y);
    }
    
    // optional implementation (not graded)
    return CGRectMake(minX, maxY, maxX - minX, maxY - minY);
}

@end

