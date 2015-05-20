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
        outgoingMask = [[[UIImage imageNamed:@"mask.outgoing.bubble.png"]
                        resizableImageWithCapInsets:UIEdgeInsetsMake(16, 15, 16, 25)
                        resizingMode:UIImageResizingModeStretch] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    });

    return outgoingMask;
}

+ (UIImage*)defaultOutgoingTailBubble {
    static dispatch_once_t token;
    __strong static UIImage* outgoingMask = nil;
    dispatch_once(&token, ^{
        outgoingMask = [[[UIImage imageNamed:@"mask.outgoing.bubble-tail.png"]
                        resizableImageWithCapInsets:UIEdgeInsetsMake(16, 15, 16, 25)
                        resizingMode:UIImageResizingModeStretch] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    });

    return outgoingMask;
}

+ (UIImage*)defaultIncomingBubble {
    static dispatch_once_t token;
    __strong static UIImage* incomingMask = nil;
    dispatch_once(&token, ^{
        incomingMask = [[[UIImage imageNamed:@"mask.incoming.bubble.png"]
                        resizableImageWithCapInsets:UIEdgeInsetsMake(16, 25, 16, 15)
                        resizingMode:UIImageResizingModeStretch] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    });


    return incomingMask;
}

+ (UIImage*)defaultIncomingTailBubble {
    static dispatch_once_t token;
    __strong static UIImage* incomingMask = nil;
    dispatch_once(&token, ^{
        incomingMask = [[[UIImage imageNamed:@"mask.incoming.bubble-tail.png"]
                        resizableImageWithCapInsets:UIEdgeInsetsMake(16, 25, 16, 15)
                        resizingMode:UIImageResizingModeStretch] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    });

    return incomingMask;
}

@end
