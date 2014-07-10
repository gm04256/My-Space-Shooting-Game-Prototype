//
//  BGMPlayerNode.m
//  My Space Shooting Game Prototype
//
//  Created by 馬 岩 on 14-7-8.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import "BGMPlayerNode.h"
#import "BGMPhysicsCategory.h"

@interface BGMPlayerNode()

@property float playerSize;

@end

@implementation BGMPlayerNode

- (instancetype)init
{
	if (self = [super init])
	{
		self.playerSize = 30;
		
		[self initGraph];
		[self initBody];
	}
	return self;
}

- (void)initGraph
{
	SKLabelNode* playerCharacter = [SKLabelNode labelNodeWithFontNamed:@"Consolas"];
	playerCharacter.text = @"主";
	playerCharacter.fontSize = self.playerSize;
	playerCharacter.position = CGPointMake(0, -self.playerSize / 2);
	
	[self addChild:playerCharacter];
}

- (void)initBody
{
	SKPhysicsBody* playerBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.playerSize, self.playerSize)];
	playerBody.affectedByGravity = NO;
	playerBody.categoryBitMask = PlayerCategory;
	playerBody.contactTestBitMask = EnemyCategory | EnemyBulletCategory;
	playerBody.collisionBitMask = 0;
	
	self.physicsBody = playerBody;
}

@end
