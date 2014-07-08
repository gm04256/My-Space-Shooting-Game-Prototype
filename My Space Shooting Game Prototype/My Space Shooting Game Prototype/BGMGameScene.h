//
//  BGMGameScene.h
//  My Space Shooting Game Prototype
//
//  Created by 馬 岩 on 14-7-7.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "BGMPlayerNode.h"

@interface BGMGameScene : SKScene

// nodes
@property SKLabelNode* scoreLabel;
@property SKLabelNode* lifeLabel;
@property BGMPlayerNode* player;
@property SKNode* enemies;
@property SKNode* bullets;

// status variables
@property NSInteger life;
@property NSInteger score;

// settings
@property float moveSpeed;

// other variables
@property NSTimer* autoShootTimer;

@end
