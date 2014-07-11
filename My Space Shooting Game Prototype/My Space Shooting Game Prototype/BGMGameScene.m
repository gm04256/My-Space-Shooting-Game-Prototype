//
//  BGMGameScene.m
//  My Space Shooting Game Prototype
//
//  Created by 馬 岩 on 14-7-7.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import "BGMGameScene.h"
#import "BGMPlayerBulletNode.h"
#import "BGMEnemyNode.h"
#import "BGMPhysicsCategory.h"
#import "BGMBackgroundNode.h"

#define ARC4RANDOM_MAX 0x100000000

@interface BGMGameScene()

@property CGPoint prevTouchedPoint;

@end

@implementation BGMGameScene

- (instancetype)initWithSize:(CGSize)size
{
	if (self = [super initWithSize:size])
	{
		/* init settings */
		self.moveSpeed = 3;
		self.physicsWorld.contactDelegate = self;
		
		/* init status variables */
		self.life = 5;
		self.score = 0;
		
		/* init nodes*/
		// score label
		self.scoreLabel = [SKLabelNode node];
		self.scoreLabel.fontSize = 15;
		[self.scoreLabel setText:[NSString stringWithFormat:@"Score: %ld", (long)self.score]];
		
		self.scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
		self.scoreLabel.horizontalAlignmentMode	= SKLabelHorizontalAlignmentModeLeft;
		self.scoreLabel.position = CGPointMake(0, size.height);
		
		[self addChild:self.scoreLabel];
		
		// life label
		self.lifeLabel = [SKLabelNode node];
		self.lifeLabel.fontSize = 15;
		[self.lifeLabel setText:[NSString stringWithFormat:@"Life: %ld", (long)self.life]];
		
		self.lifeLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
		self.lifeLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
		self.lifeLabel.position = CGPointMake(size.width, size.height);
		
		[self addChild:self.lifeLabel];
		
		// init player
		self.player = [[BGMPlayerNode alloc] init];
		self.player.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetHeight(self.frame) / 4);
		[self addChild:self.player];
		
		// start to shoot bullets
		self.autoShootTimer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(autoShootSchedule) userInfo:Nil repeats:YES];
		
		// init enemies
		self.enemies = [SKNode node];
		[self addChild:self.enemies];
		self.generateEnemyTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(generateEnemySchedule) userInfo:Nil repeats:YES];
		
		// init player's bullets
		self.playerBullets = [SKNode node];
		[self addChild:self.playerBullets];
		
		// init background
		self.background = [[BGMBackgroundNode alloc] initWithMoveSpeed:CGVectorMake(0, -50) andSize:self.frame.size];
		[self addChild:self.background];
	}
	
	return self;
}

#pragma mark - Touch Event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	for (UITouch* touch in touches)
	{
		self.prevTouchedPoint = [touch locationInNode:self];
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	for (UITouch* touch in touches)
	{
		CGPoint touchedPoint = [touch locationInNode:self];
		
		// move player
		CGVector moveVector = CGVectorMake(self.moveSpeed * (touchedPoint.x - self.prevTouchedPoint.x), self.moveSpeed * (touchedPoint.y - self.prevTouchedPoint.y));
		self.player.position = CGPointMake(self.player.position.x + moveVector.dx, self.player.position.y + moveVector.dy);
		if (!CGRectContainsPoint(self.frame, self.player.position))
		{
			if (self.player.position.x < 0)
			{
				self.player.position = CGPointMake(0, self.player.position.y);
			}
			if (self.player.position.y < 0)
			{
				self.player.position = CGPointMake(self.player.position.x, 0);
			}
			if (self.player.position.x > CGRectGetWidth(self.frame))
			{
				self.player.position = CGPointMake(CGRectGetWidth(self.frame), self.player.position.y);
			}
			if (self.player.position.y > CGRectGetHeight(self.frame))
			{
				self.player.position = CGPointMake(self.player.position.x, CGRectGetHeight(self.frame));
			}
		}
		
		// update prevTouchedPoint
		self.prevTouchedPoint = touchedPoint;
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	
}

#pragma mark - Timer Schledules
- (void)autoShootSchedule
{
	BGMPlayerBulletNode* bulletLeft = [[BGMPlayerBulletNode alloc] init];
	bulletLeft.position = CGPointMake(CGRectGetMidX(self.player.frame), CGRectGetMaxY(self.player.frame));
	bulletLeft.physicsBody.velocity = CGVectorMake(0, 1000);
	
	[self.playerBullets addChild:bulletLeft];
}

- (void)generateEnemySchedule
{
	BGMEnemyNode* enemy = [[BGMEnemyNode alloc] init];
	enemy.position = CGPointMake(CGRectGetWidth(self.frame) * arc4random() / ARC4RANDOM_MAX, CGRectGetHeight(self.frame) + 100);
	enemy.physicsBody.velocity = CGVectorMake(0, -100);
	
	[self.enemies addChild:enemy];
}

#pragma mark - Update Status
- (void)update:(NSTimeInterval)currentTime
{
	// clear bullets
	[self clearBullets];
	[self clearEnemies];
	[self.background updateBackground];
}

- (void)clearBullets
{
	NSMutableArray* bulletsWillBeDelete = [NSMutableArray array];
	for (SKNode* bullet in self.playerBullets.children)
	{
		if (!CGRectContainsPoint(self.frame, bullet.position))
		{
			[bulletsWillBeDelete addObject:bullet];
		}
	}
	
	if ([bulletsWillBeDelete count] > 0)
	{
		[self.playerBullets removeChildrenInArray:bulletsWillBeDelete];
	}
}

- (void)clearEnemies
{
	NSMutableArray* enemiesToRemove = [NSMutableArray array];
	for (SKNode* enemy in self.enemies.children)
	{
		if (enemy.position.y < 0 || enemy.position.x < 0 || enemy.position.x > CGRectGetWidth(self.frame))
		{
			[enemiesToRemove addObject:enemy];
		}
		else if(((BGMEnemyNode*)enemy).life == 0)
		{
			[self updateScore:100];
			[enemiesToRemove addObject:enemy];
		}
	}
	
	if([enemiesToRemove count] > 0)
	{
		[self.enemies removeChildrenInArray:enemiesToRemove];
	}
}

#pragma mark - Physics Contact Delegate
- (void)didBeginContact:(SKPhysicsContact *)contact
{
	SKPhysicsBody* bodyA = contact.bodyA;
	SKPhysicsBody* bodyB = contact.bodyB;
	
	// player's bullets hits enemy
	if (bodyA.categoryBitMask == PlayerBulletCategory)
	{
		// enemy hp -1
		[((BGMEnemyNode*)(bodyB.node)) hitten];
		if (bodyA.node != nil)
		{
			[self.playerBullets removeChildrenInArray:@[bodyA.node]];
		}
	}
	if (bodyB.categoryBitMask == PlayerBulletCategory)
	{
		// enemy hp -1
		[((BGMEnemyNode*)(bodyA.node)) hitten];
		if (bodyB.node != nil)
		{
			[self.playerBullets removeChildrenInArray:@[bodyB.node]];
		}
	}
	
	// player hits enemies
	if(bodyA.categoryBitMask == EnemyCategory && bodyB.categoryBitMask == PlayerCategory)
	{
		[(BGMEnemyNode*)(bodyA.node) die];
		[self updateLife:-1];
	}
	if (bodyB.categoryBitMask == EnemyCategory && bodyA.categoryBitMask == PlayerCategory)
	{
		[(BGMEnemyNode*)(bodyB.node) die];
		[self updateLife:-1];
	}
}

- (void)didEndContact:(SKPhysicsContact *)contact
{
	
}

#pragma mark - Update Game Data
- (void)updateScore:(NSInteger)score
{
	self.score += score;
	self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.score];
}

- (void)updateLife:(NSInteger)life
{
	self.life += life;
	self.lifeLabel.text = [NSString stringWithFormat:@"Life: %ld", self.life];
}

@end
