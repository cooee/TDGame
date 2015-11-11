--
-- Author: Your Name
-- Date: 2015-11-11 10:28:03
--

local mod = {};
mod.enemyMaxNum_ = 30;
mod.enemyKind_ = {};
mod.createNextEnemyDelay_    = 1 -- 等待多少时间创建下一个敌人 单位是秒
mod.createNextEnemyInterval_ = 1 -- 创建下一个敌人前的间隔时间

local MapConfig = {};

MapConfig[1] = clone(mod);

return MapConfig;