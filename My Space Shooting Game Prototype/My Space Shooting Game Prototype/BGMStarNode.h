//
//  BGMStarNode.h
//  My Space Shooting Game Prototype
//
//  Created by 馬 岩 on 14-7-10.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BGMStarNode : SKNode

@property CGFloat radius;

- (instancetype)initWithColor:(SKColor*)color andRadius:(CGFloat)radius andSpeed:(CGVector)speed;

@end
