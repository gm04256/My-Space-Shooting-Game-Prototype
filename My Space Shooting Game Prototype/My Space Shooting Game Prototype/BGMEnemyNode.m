//
//  BGMEnemyNode.m
//  My Space Shooting Game Prototype
//
//  Created by 馬 岩 on 14-7-8.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import "BGMEnemyNode.h"
#import "BGMPhysicsCategory.h"

@interface BGMEnemyNode()

@property float enemySize;

@end

@implementation BGMEnemyNode

- (instancetype)init
{
	if (self = [super init])
	{
		self.enemySize = 35;
		self.life = 2;
		
		[self initGraph];
		[self initBody];
	}
	
	return self;
}

- (void)initGraph
{
	SKLabelNode* enemyCharacter = [SKLabelNode labelNodeWithFontNamed:@"System"];
	enemyCharacter.text = @"敵";
	enemyCharacter.name = @"enemyCharacter";
	enemyCharacter.fontSize = self.enemySize;
	enemyCharacter.position = CGPointMake(0, -self.enemySize / 2);

	[self addChild:enemyCharacter];
}

- (void)initBody
{
	SKPhysicsBody* enemyBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.enemySize, self.enemySize)];
	enemyBody.affectedByGravity = NO;
	enemyBody.linearDamping = 0;
	enemyBody.categoryBitMask = EnemyCategory;
	enemyBody.contactTestBitMask = PlayerBulletCategory | PlayerCategory | EnemyCategory;
	enemyBody.collisionBitMask = PlayerBulletCategory | EnemyCategory;
	
	self.physicsBody = enemyBody;
}

- (void)hitten
{
	self.life -= 1;
	if (self.life <= 0)
	{
		[self die];
	}
}

- (void)die
{
	self.life = 0;
	self.deadTime = NSTimeIntervalSince1970;
	
	SKLabelNode* enemyCharacter = (SKLabelNode*)[self childNodeWithName:@"enemyCharacter"];
	enemyCharacter.text = @"死";
	// stop contact test
	self.physicsBody.collisionBitMask = 0;
	self.physicsBody.contactTestBitMask	 = 0;
	self.physicsBody.categoryBitMask = 0;
	// stop movement
	self.physicsBody.angularVelocity = 0;
	self.physicsBody.velocity = CGVectorMake(0, 0);
}

@end
