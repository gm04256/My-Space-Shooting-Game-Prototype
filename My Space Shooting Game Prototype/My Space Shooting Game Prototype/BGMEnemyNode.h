//
//  BGMEnemyNode.h
//  My Space Shooting Game Prototype
//
//  Created by 馬 岩 on 14-7-8.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BGMEnemyNode : SKNode

@property NSInteger life;
@property NSTimeInterval deadTime;

- (void)hitten;
- (void)die;

@end
