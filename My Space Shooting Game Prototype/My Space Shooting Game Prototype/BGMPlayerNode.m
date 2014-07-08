//
//  BGMPlayerNode.m
//  My Space Shooting Game Prototype
//
//  Created by 馬 岩 on 14-7-8.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import "BGMPlayerNode.h"
#import "BGMPhysicsCategory.h"

@implementation BGMPlayerNode

- (instancetype)init
{
	if (self = [super init])
	{
		[self initGraph];
		[self initBody];
	}
	return self;
}

- (void)initGraph
{
	SKLabelNode* playerCharacter = [SKLabelNode labelNodeWithFontNamed:@"Consolas"];
	playerCharacter.text = @"主";
	playerCharacter.fontSize = 30;
	playerCharacter.position = CGPointMake(0, -15);
	
	[self addChild:playerCharacter];
}

- (void)initBody
{
	SKPhysicsBody* playerBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(30, 30)];
	playerBody.affectedByGravity = NO;
	playerBody.categoryBitMask = PlayerCategory;
	playerBody.contactTestBitMask = EnemyCategory | EnemyBulletCategory;
	playerBody.collisionBitMask = EnemyCategory | EnemyBulletCategory;
	
	self.physicsBody = playerBody;
}

@end
