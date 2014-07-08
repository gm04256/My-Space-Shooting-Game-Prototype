//
//  BGMBulletNode.m
//  My Space Shooting Game Prototype
//
//  Created by 馬 岩 on 14-7-8.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import "BGMPlayerBulletNode.h"
#import "BGMPhysicsCategory.h"

@interface BGMPlayerBulletNode()

@property float bulletSize;

@end

@implementation BGMPlayerBulletNode

- (instancetype)init
{
	if (self = [super init])
	{
		self.bulletSize = 10;
		
		[self initGraph];
		[self initBody];
	}
	
	return self;
}

- (void)initGraph
{
	SKLabelNode* bulletCharacter = [SKLabelNode labelNodeWithFontNamed:@"System"];
	bulletCharacter.text = @"弾";
	bulletCharacter.fontSize = self.bulletSize;
	bulletCharacter.position = CGPointMake(0, -self.bulletSize / 2);
	
	[self addChild:bulletCharacter];
}

- (void)initBody
{
	SKPhysicsBody* bulletBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.bulletSize, self.bulletSize)];
	bulletBody.affectedByGravity = NO;
	bulletBody.categoryBitMask = PlayerBulletCategory;
	bulletBody.contactTestBitMask = EnemyCategory;
	bulletBody.collisionBitMask = EnemyCategory | EnemyBulletCategory;
	
	self.physicsBody = bulletBody;
}

@end
