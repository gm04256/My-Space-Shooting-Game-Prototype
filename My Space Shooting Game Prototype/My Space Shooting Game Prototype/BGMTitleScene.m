//
//  BGMMyScene.m
//  My Space Shooting Game Prototype
//
//  Created by 馬 岩 on 14-7-7.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#import "BGMTitleScene.h"
#import "BGMGameScene.h"

@implementation BGMTitleScene

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
	{
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
		// add title label
        SKLabelNode *titleLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        titleLabel.text = @"My Space Shooting Game Prototype";
        titleLabel.fontSize = 15;
        titleLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       self.frame.size.height * 0.8);
        [self addChild:titleLabel];
		
		// add hint label
		SKLabelNode* hintLabel = [SKLabelNode labelNodeWithFontNamed:@"System"];
		hintLabel.text = @"Press to start";
		hintLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
		[self addChild:hintLabel];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    
	BGMGameScene* gameScene = [[BGMGameScene alloc] initWithSize:self.frame.size];
    [self.view presentScene:gameScene transition:[SKTransition doorsOpenHorizontalWithDuration:1]];
}

-(void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
}

@end
