//
//  NHBubbleMaskProvider.m
//  Pods
//
//  Created by Naithar on 02.05.15.
//
//

#import "NHBubbleMaskProvider.h"

@implementation NHBubbleMaskProvider

+ (UIImage*)defaultOutgoingBubble {
    static dispatch_once_t token;
    __strong static UIImage* outgoingMask = nil;
    dispatch_once(&token, ^{
        outgoingMask = [[UIImage imageNamed:@"mask.bubble.png"]
                        resizableImageWithCapInsets:UIEdgeInsetsMake(16, 15, 16, 25)
                        resizingMode:UIImageResizingModeStretch];
    });

    return outgoingMask;
}

+ (UIImage*)defaultOutgoingTailBubble {
    static dispatch_once_t token;
    __strong static UIImage* outgoingMask = nil;
    dispatch_once(&token, ^{
        outgoingMask = [[UIImage imageNamed:@"mask.bubble-tail.png"]
                        resizableImageWithCapInsets:UIEdgeInsetsMake(16, 15, 16, 25)
                        resizingMode:UIImageResizingModeStretch];
    });

    return outgoingMask;
}

+ (UIImage*)defaultIncomingBubble {
    static dispatch_once_t token;
    __strong static UIImage* incomingMask = nil;
    dispatch_once(&token, ^{
        UIImage *image = [UIImage imageNamed:@"mask.bubble.png"];
        incomingMask = [[[UIImage alloc] initWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationUpMirrored]
                        resizableImageWithCapInsets:UIEdgeInsetsMake(16, 15, 16, 25)
                        resizingMode:UIImageResizingModeStretch];
    });


    return incomingMask;
}

+ (UIImage*)defaultIncomingTailBubble {
    static dispatch_once_t token;
    __strong static UIImage* incomingMask = nil;
    dispatch_once(&token, ^{
        UIImage *image = [UIImage imageNamed:@"mask.bubble-tail.png"];
        incomingMask = [[[UIImage alloc] initWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationUpMirrored]
                        resizableImageWithCapInsets:UIEdgeInsetsMake(16, 15, 16, 25)
                        resizingMode:UIImageResizingModeStretch];
    });

    return incomingMask;
}

@end
