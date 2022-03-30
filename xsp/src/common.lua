-- common.lua

local _M = {}


_M.Stage = {
	OneTime = 0 ,FiveTimes = 1
}

_M.Cook = {
	OneCook = 0 , TenCook = 1
}

_M.Login = {
	Reload = 1 , Restart = 0
}

_M.config = {
	DishType = 1 , DishPos = 1,
	KEGAREPos = 1 ,
	CountTime = 10 ,
	Explore_Stage = 0 , Explore_Material = 0 ,
	Mission_Award = 0 , Mission_Job = 0 ,
	EnergyEnough = 1 , SweepTime = _M.Stage.OneTime ,  AutoStagePage = 0, AutoStagePos = 0,
	CookNum = _M.Cook.OneCook ,
	Script = _M.Login.Restart ,
	ExploreNum = 0 ,
	DeliveryNum = 0 ,
	Waiter_2 = 0 ,	Waiter_3 = 0 ,	Cooker_R = 0 ,
	Meat = 0 , Saber = 0 , Caster = 0 , Healer = 0,
	StoreSetting = 0 ,
}

_M.Restaurant = {

	LEFT = 1 ,RIGHT = 2,
	WAITER = 1 ,COOKER = 2,
	ALLDISH = 0 ,GREELOW = 1, YAO = 2, SAKURA = 3 ,USHINAWA = 4,
	FRIEND = 1 ,
	ForceRemoveNumber = 0,
	Medicine = 0 , IceField = 1 ,

}



_M.Model = {
	RUBI = 1 ,COOK = 2 ,KEGARE = 3 ,SCHOOLSUPPLY = 4 ,
	EXPLORE = 5 ,ICEFIELD = 6 , Cthulhu = 7 , PVP = 8 ,
	--
		
}


_M.Explore = {
	GREELOW = 1, YAO = 2, NEFIRA = 3 ,SAKURA = 4 ,
	N_care = 0 ,LEFT = 1 , MIDDLE = 2, RIGHT = 3, 
	SCREW = 1 , BRICK = 2, STEEL = 3 , BOARD = 4 , 
	TypePos = 0 ,
}

_M.Mission = {
	--Award
	Daily = 1, GameAssociation = 2 , Energy_50 = 3 , Email = 4 , GoldEgg = 5 ,
	--Job
	GameAssociationBuild = 1 , AirTransport = 2 , Delivery = 3,
	TypePos = 0 ,
	Market = 1 ,Store = 2, AssociationStore_ItalyPiece = 3 , AssociationStore_LeafPiece = 4 , AssociationStore_Underpants = 5 ,
	MarketFood = 0 , MarketLeaf = 0 ,
}

_M.Market = {

	--Store
	UR = 0 ,M = 1, SR = 2,Leaf = 3 ,Energy = 4, Strawberry = 5,
	--Market
	MarketLeaf = 6 ,MarketFood = 7,
	
}

return _M