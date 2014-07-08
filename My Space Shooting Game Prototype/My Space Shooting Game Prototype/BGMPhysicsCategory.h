//
//  BGMPhysicsCategory.h
//  My Space Shooting Game Prototype
//
//  Created by 馬 岩 on 14-7-8.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#ifndef My_Space_Shooting_Game_Prototype_BGMPhysicsCategory_h
#define My_Space_Shooting_Game_Prototype_BGMPhysicsCategory_h

typedef NS_OPTIONS(uint32_t, BGMPhysicsCategory)
{
    PlayerCategory = 1 << 1,
    EnemyCategory = 1 << 2,
    PlayerBulletCategory = 1 << 3,
	EnemyBulletCategory = 1 << 4
};

#endif
