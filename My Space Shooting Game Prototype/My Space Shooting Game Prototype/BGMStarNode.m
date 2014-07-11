//
//  BGMStarNode.m
//  My Space Shooting Game Prototype
//
//  Created by 馬 岩 on 14-7-10.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import "BGMStarNode.h"

@implementation BGMStarNode

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
	// star node
	SKShapeNode* myNode = [SKShapeNode node];
	
	myNode.strokeColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:0];
	myNode.fillColor = color;
	
	// init path
	float outerRadius = self.radius;
	float innerRadius = outerRadius * 0.4;
	CGMutablePathRef starPath = CGPathCreateMutable();
	
	CGPathMoveToPoint(starPath, &CGAffineTransformIdentity, 0, outerRadius);
	
	CGPathAddLineToPoint(starPath, &CGAffineTransformIdentity, innerRadius * cos(54.0 / 180 * M_PI), innerRadius * sin(54.0 / 180 * M_PI));
	CGPathAddLineToPoint(starPath, &CGAffineTransformIdentity, outerRadius * cos(18.0 / 180 * M_PI), outerRadius * sin(18.0 / 180 * M_PI));
	CGPathAddLineToPoint(starPath, &CGAffineTransformIdentity, innerRadius * cos(18.0 / 180 * M_PI), -innerRadius * sin(18.0 / 180 * M_PI));
	CGPathAddLineToPoint(starPath, &CGAffineTransformIdentity, outerRadius * cos(54.0 / 180 * M_PI), -outerRadius * sin(54.0 / 180 * M_PI));
	CGPathAddLineToPoint(starPath, &CGAffineTransformIdentity, 0, -innerRadius);
	CGPathAddLineToPoint(starPath, &CGAffineTransformIdentity, -outerRadius * cos(54.0 / 180 * M_PI), -outerRadius * sin(54.0 / 180 * M_PI));
	CGPathAddLineToPoint(starPath, &CGAffineTransformIdentity, -innerRadius * cos(18.0 / 180 * M_PI), -innerRadius * sin(18.0 / 180 * M_PI));
	CGPathAddLineToPoint(starPath, &CGAffineTransformIdentity, -outerRadius * cos(18.0 / 180 * M_PI), outerRadius * sin(18.0 / 180 * M_PI));
	CGPathAddLineToPoint(starPath, &CGAffineTransformIdentity, -innerRadius * cos(54.0 / 180 * M_PI), innerRadius * sin(54.0 / 180 * M_PI));
	//	CGPathAddLineToPoint(starPath, &CGAffineTransformIdentity, 0, outerRadius);
	CGPathCloseSubpath(starPath);
	
	myNode.path = starPath;
	
	
	[self addChild:myNode];
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
	circleBody.angularDamping = 0;
	circleBody.angularVelocity = 3;
	
	self.physicsBody = circleBody;
}

@end
