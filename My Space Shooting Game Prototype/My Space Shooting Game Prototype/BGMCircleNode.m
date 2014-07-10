//
//  BGMCircleNode.m
//  My Space Shooting Game Prototype
//
//  Created by 馬 岩 on 14-7-10.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import "BGMCircleNode.h"

@implementation BGMCircleNode

- (instancetype)initWithColor:(SKColor*)color andRadius:(CGFloat)radius andSpeed:(CGVector)speed
{
	if(self = [super init])
	{
		self.radius = radius;
		
		[self initGraphWithColor:color andRadius: radius];
		
		[self initBodyWithRadius:radius andSpeed: speed];
	}
	
	return self;
}

- (void)initGraphWithColor:(SKColor*)color andRadius:(CGFloat)radius
{
	SKShapeNode* circleShape = [SKShapeNode node];
	circleShape.name = @"circleShape";
	circleShape.fillColor = color;
	circleShape.strokeColor = color;
	circleShape.path = CGPathCreateWithEllipseInRect(CGRectMake(-radius, -radius, radius * 2, radius * 2), &CGAffineTransformIdentity);
	
	[self addChild:circleShape];
}

- (void)initBodyWithRadius:(CGFloat)radius andSpeed:(CGVector)speed
{
	SKPhysicsBody* circleBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
	circleBody.contactTestBitMask = 0;
	circleBody.collisionBitMask = 0;
	circleBody.categoryBitMask = 0;
	circleBody.velocity = speed;
	circleBody.affectedByGravity = NO;
	circleBody.linearDamping = 0;
	
	self.physicsBody = circleBody;
}

@end
