//
//  BGMGameScene.m
//  My Space Shooting Game Prototype
//
//  Created by 馬 岩 on 14-7-7.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import "BGMGameScene.h"
#import "BGMPlayerBulletNode.h"

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
		
		/* init status variables */
		self.life = 5;
		self.score = 0;
		
		/* init nodes*/
		// score label
		self.scoreLabel = [SKLabelNode node];
		self.scoreLabel.fontSize = 15;
		[self.scoreLabel setText:[NSString stringWithFormat:@"Score: %d", self.score]];
		
		self.scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
		self.scoreLabel.horizontalAlignmentMode	= SKLabelHorizontalAlignmentModeLeft;
		self.scoreLabel.position = CGPointMake(0, size.height);
		
		[self addChild:self.scoreLabel];
		
		// life label
		self.lifeLabel = [SKLabelNode node];
		self.lifeLabel.fontSize = 15;
		[self.lifeLabel setText:[NSString stringWithFormat:@"Life: %d", self.life]];
		
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
		
		// init bullets
		self.bullets = [SKNode node];
		[self addChild:self.bullets];
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
	
	[self.bullets addChild:bulletLeft];
}

#pragma mark - Update Status
- (void)update:(NSTimeInterval)currentTime
{
	// clear bullets
	[self clearBullets];
}

- (void)clearBullets
{
	NSMutableArray* bulletsWillBeDelete = [NSMutableArray array];
	for (SKNode* bullet in self.bullets.children)
	{
		if (!CGRectContainsPoint(self.frame, bullet.position))
		{
			[bulletsWillBeDelete addObject:bullet];
		}
	}
	
	[self.bullets removeChildrenInArray:bulletsWillBeDelete];
}


@end
