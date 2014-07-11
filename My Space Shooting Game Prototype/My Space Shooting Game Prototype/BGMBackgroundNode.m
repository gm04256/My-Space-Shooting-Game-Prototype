//
//  BGMBackgroundNode.m
//  My Space Shooting Game Prototype
//
//  Created by 馬 岩 on 14-7-10.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import "BGMBackgroundNode.h"
#import "BGMCircleNode.h"
#import "BGMStarNode.h"

#import "SKNode+BGMClearChildren.h"

#define ARC4RANDOM_MAX 0x100000000

@implementation BGMBackgroundNode

- (instancetype)initWithMoveSpeed:(CGVector)moveSpeed andSize:(CGSize)size
{
	if (self = [super init])
	{
		self.zPosition = -100;
		self.size = size;
		self.moveSpeed = moveSpeed;
		
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
			BGMCircleNode* circle = [[BGMCircleNode node] initWithColor:[SKColor colorWithRed:((float)arc4random() / ARC4RANDOM_MAX) green:((float)arc4random() / ARC4RANDOM_MAX) blue:((float)arc4random() / ARC4RANDOM_MAX) alpha:0.2] andRadius:(size.width / 4 * arc4random() / ARC4RANDOM_MAX) andSpeed:CGVectorMake(moveSpeed.dx / 2, moveSpeed.dy / 2)];
			circle.position = CGPointMake(size.width * arc4random() / ARC4RANDOM_MAX, size.height * arc4random() / ARC4RANDOM_MAX);
			[self.circles addChild:circle];
		}
		
		self.circles.zPosition = self.zPosition + 2;
		[self addChild:self.circles];
		
		// add stars
		self.stars = [SKNode node];
		
		for (int i = 0; i < 10; i++)
		{
			BGMStarNode* star = [[BGMStarNode node] initWithColor:[SKColor colorWithRed:((float)arc4random() / ARC4RANDOM_MAX) green:((float)arc4random() / ARC4RANDOM_MAX) blue:((float)arc4random() / ARC4RANDOM_MAX) alpha:0.7] andRadius:(size.width / 8 * arc4random() / ARC4RANDOM_MAX) andSpeed:CGVectorMake(moveSpeed.dx / 0.5, moveSpeed.dy / 0.5)];
			star.position = CGPointMake(size.width * arc4random() / ARC4RANDOM_MAX, size.height * arc4random() / ARC4RANDOM_MAX);
			[self.stars addChild:star];
		}
	
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
	NSMutableArray* circlesToRemove = [NSMutableArray array];
	NSMutableArray* circlesToAdd = [NSMutableArray array];
	
	for (BGMCircleNode* circle in self.circles.children)
	{
		CGRect region = CGRectMake(circle.position.x - circle.radius, circle.position.y - circle.radius, circle.radius * 2, circle.radius * 2);
		if(!CGRectIntersectsRect(CGRectMake(0, 0, self.size.width, self.size.height), region))
		{
			[circlesToRemove addObject:circle];
			
			BGMCircleNode* newCircle = [[BGMCircleNode node] initWithColor:[SKColor colorWithRed:((float)arc4random() / ARC4RANDOM_MAX) green:((float)arc4random() / ARC4RANDOM_MAX) blue:((float)arc4random() / ARC4RANDOM_MAX) alpha:0.2] andRadius:(self.size.width / 4 * arc4random() / ARC4RANDOM_MAX) andSpeed:CGVectorMake(self.moveSpeed.dx / 2, self.moveSpeed.dy / 2)];
			newCircle.position = CGPointMake(self.size.width * arc4random() / ARC4RANDOM_MAX, self.size.height + newCircle.radius);
			
			[circlesToAdd addObject:newCircle];
		}
	}
	
	for (BGMCircleNode* circle1 in circlesToAdd)
	{
		[self.circles addChild:circle1];
	}
	if ([circlesToRemove count] > 0)
	{
		for (BGMCircleNode* circle2 in circlesToRemove)
		{
			[circle2 cleanUpChildrenAndRemove];
		}
		[self.circles removeChildrenInArray:circlesToRemove];
	}
	
	// update stars
	NSMutableArray* starsToRemove = [NSMutableArray array];
	NSMutableArray* starsToAdd = [NSMutableArray array];
	
	for (BGMStarNode* star in self.stars.children)
	{
		CGRect region1 = CGRectMake(star.position.x - star.radius, star.position.y - star.radius, star.radius * 2, star.radius * 2);
		if(!CGRectIntersectsRect(CGRectMake(0, 0, self.size.width, self.size.height), region1))
		{
			NSLog(@"a star will be updated");
			[starsToRemove addObject:star];
			
			BGMStarNode* newStar = [[BGMStarNode node] initWithColor:[SKColor colorWithRed:((float)arc4random() / ARC4RANDOM_MAX) green:((float)arc4random() / ARC4RANDOM_MAX) blue:((float)arc4random() / ARC4RANDOM_MAX) alpha:0.7] andRadius:(self.size.width / 8 * arc4random() / ARC4RANDOM_MAX) andSpeed:CGVectorMake(self.moveSpeed.dx / 0.5, self.moveSpeed.dy / 0.5)];
			newStar.position = CGPointMake(self.size.width * arc4random() / ARC4RANDOM_MAX, self.size.height + newStar.radius);
			
			[starsToAdd addObject:newStar];
		}
	}
	
	for (BGMStarNode* star1 in starsToAdd)
	{
		[self.stars addChild:star1];
	}
	if ([starsToRemove count] > 0)
	{
		for (BGMStarNode* star2 in starsToRemove)
		{
			[star2 cleanUpChildrenAndRemove];
		}
		[self.stars removeChildrenInArray:starsToRemove];
	}
}

@end
