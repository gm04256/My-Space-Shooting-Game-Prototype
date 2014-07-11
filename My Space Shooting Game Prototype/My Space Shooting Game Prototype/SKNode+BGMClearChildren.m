//
//  SKNode+BGMClearChildren.m
//  My Space Shooting Game Prototype
//
//  Created by 馬 岩 on 14-7-11.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import "SKNode+BGMClearChildren.h"

@implementation SKNode (BGMClearChildren)

- (void)cleanUpChildrenAndRemove
{
    for (SKNode *child in self.children)
	{
        [child cleanUpChildrenAndRemove];
    }
    [self removeFromParent];
}

@end
