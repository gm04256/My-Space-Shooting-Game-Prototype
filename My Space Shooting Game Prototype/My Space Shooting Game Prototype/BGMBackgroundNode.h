//
//  BGMBackgroundNode.h
//  My Space Shooting Game Prototype
//
//  Created by 馬 岩 on 14-7-10.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BGMBackgroundNode : SKNode

// nodes
@property SKShapeNode* background;// z-index: 1
@property SKNode* circles;// z-inedex: 2
@property SKNode* stars;// z-index: 3

// status
@property CGVector moveSpeed;
@property CGSize size;

- (instancetype)initWithMoveSpeed:(CGVector)moveSpeed andSize:(CGSize)size;
- (void)changeMoveSpeed:(CGVector)moveSpeed;

- (void)updateBackground;

@end
