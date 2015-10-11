#pragma once

#include "cocos2d.h"
class SystemHelp :  public cocos2d::Ref
{
public:
	SystemHelp();

	~SystemHelp();
	bool init();
	void cleanLog();
	CREATE_FUNC(SystemHelp);

};