//
//  BGMBackgroundNode.m
//  My Space Shooting Game Prototype
//
//  Created by 馬 岩 on 14-7-10.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import "BGMBackgroundNode.h"
#import "BGMCircleNode.h"

#define ARC4RANDOM_MAX 0x100000000

@implementation BGMBackgroundNode

- (instancetype)initWithMoveSpeed:(CGVector)moveSpeed andSize:(CGSize)size
{
	if (self = [super init])
	{
		self.zPosition = -100;
		self.size = size;
		
		// add background
		self.background = [SKShapeNode node];
		self.background.fillColor = [SKColor colorWithRed:157.0/255 green:207.0/255 blue:225.0/255 alpha:1];
		self.background.strokeColor = [SKColor colorWithRed:157.0/255 green:207.0/255 blue:225.0/255 alpha:1];
		self.background.path = CGPathCreateWithRect(CGRectMake(0, 0, size.width, size.height), &CGAffineTransformIdentity);
		self.background.zPosition = self.zPosition + 1;
		[self addChild:self.background];
		
		// add circles
		self.circles = [SKNode node];
		
		for (int i = 0; i < 10; i++)
		{
			BGMCircleNode* circle = [[BGMCircleNode node] initWithColor:[SKColor colorWithRed:((float)arc4random() / ARC4RANDOM_MAX) green:((float)arc4random() / ARC4RANDOM_MAX) blue:((float)arc4random() / ARC4RANDOM_MAX) alpha:0.3] andRadius:(size.width / 2 * arc4random() / ARC4RANDOM_MAX) andSpeed:CGVectorMake(moveSpeed.dx / 1, moveSpeed.dy / 1)];
			circle.position = CGPointMake(size.width * arc4random() / ARC4RANDOM_MAX, size.height * arc4random() / ARC4RANDOM_MAX);
			[self.circles addChild:circle];
		}
		
		self.circles.zPosition = self.zPosition + 2;
		[self addChild:self.circles];
		
		// add stars
		self.stars = [SKNode node];
	
		self.stars.zPosition = self.zPosition + 3;
		[self addChild:self.stars];
	}
	
	return self;
}

- (void)changeMoveSpeed:(CGVector)moveSpeed
{
	
}

- (void)updateBackground
{
	// update circles
	for (BGMCircleNode* circle in self.circles.children)
	{
		CGRect region = CGRectMake(circle.position.x - circle.radius, circle.position.y - circle.radius, circle.radius * 2, circle.radius * 2);
		if(!CGRectIntersectsRect(CGRectMake(0, 0, self.size.width, self.size.height), region))
		{
			circle.position = CGPointMake(self.size.width * arc4random() / ARC4RANDOM_MAX, self.size.height * 2);
			NSLog(@"a circle is reset.");
			
//			BGMCircleNode* newCircle = [[BGMCircleNode node] initWithColor:[SKColor colorWithRed:((float)arc4random() / ARC4RANDOM_MAX) green:((float)arc4random() / ARC4RANDOM_MAX) blue:((float)arc4random() / ARC4RANDOM_MAX) alpha:0.3] andRadius:(self.size.width / 2 * arc4random() / ARC4RANDOM_MAX) andSpeed:CGVectorMake(self.moveSpeed.dx / 1, self.moveSpeed.dy / 1)];
//			newCircle.position = CGPointMake(self.size.width * arc4random() / ARC4RANDOM_MAX, self.size.height * 2);
//			
//			[self.circles addChild:newCircle];
		}
	}
	
//	[self.circles removeChildrenInArray:circlesToRemove];
	
	// update stars
}

@end
