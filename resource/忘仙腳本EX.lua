


---很老的脚本,主要看思路！！！主要看思路！！！主要看思路！！！

---脚本包含多点偏移RGB找色,定时执行任务等等.特别对适配多个分辨率有帮助,因为脚本代码从头到尾都是变量,适配其他分辨率只需要修改前面的g_t_这些变量即可快速适配.

---脚本功能：自动挂机、自动整理包裹、自动合成至蓝装、死亡自动回城复活并回到指定挂机点、自动回城修理装备


--=====================自定义参数（可以根据存储路径进行修改）--=====================--=====================--=====================
---图片存储路径
PictureDir = "/mnt/sdcard/ChuMoJingLing/bmp2/%s"
---是否启动合成功能
HeCheng_Enable = 1;
---自动挂机还是自动主线任务
GuaJi_Endable = 1;  --挂机 = 1 ， 主线任务 = 0
---挂机地点
GuaJi_Ceng = 8 -- 这里的数字表示进入王城挂机的第几层
GuaJi_Guai = 4 -- 进入怪物地图后，点击打开小地图，选择怪物后，显示1-4行怪物列表
			   -- 这个数字你填写几，就会自动跑到相应行的刷怪地点挂机
---王城小地图车夫所在的行
CheFu_Hang = 5 --(1~6行，第一行是1）

--=====================多点找图参数（需根据屏幕自行修改）--=====================--=====================--=====================
--结构说明：
--t={ x,y,0,0, pointNumber, //x,y  是找到图后点击的位置坐标或找图前需点击的按钮坐标， pointNumber是本次搜索中有效点的个数, 0未用保留字段
--	x1,y1,r1,g1,b1,  		  //x1,y1是图中点的坐标， r1，g1，b1是参考颜色
--	x2,y2,r2,g2,b2,
--	...
--	xn,yn,rn,gn,bn
--	};
---任务提示第一行中的"可接"两个字的点参数，用于判断是否有可接任务
g_t_KeJie = { 94,189,  0, 0, 8, -- 1，2字段配置为任务提示第一行的坐标
7, 211, 0, 219, 247,    --1
7, 218, 0, 223, 255,    --2
11, 214, 0, 222, 254,    --3
17, 214, 0, 222, 254,    --4
17, 211, 0, 219, 255,    --5
13, 211, 0, 219, 255,    --6
15, 208, 0, 219, 255,    --7
15, 218, 0, 222, 254,    --8
 
			};
---任务提示第一行中的"完"字的点参数， 用于判断任务是否完成		
g_t_Wan	  = { 94,189,  0, 0, 8, -- 1，2字段配置为任务提示第一行的坐标
135, 184, 0, 218, 255,    --1
143, 184, 0, 218, 255,    --2
137, 187, 0, 215, 247,    --3
142, 187, 0, 219, 255,    --4
142, 190, 0, 218, 246,    --5
136, 190, 0, 218, 255,    --6
135, 195, 0, 219, 247,    --7
141, 195, 0, 215, 247,    --8
			};
---任务对话框点参数， 用于判断是否弹出任务对话框			
g_t_RenWu = { 117, 446,  0, 0, 16, -- 1，2字段配置为接受任务按钮的坐标
148, 437, 255, 255, 255,    --1
154, 437, 255, 255, 255,    --2
152, 439, 255, 255, 255,    --3
151, 435, 254, 254, 254,    --4
145, 442, 255, 255, 255,    --5
159, 442, 255, 255, 255,    --6
156, 441, 255, 255, 255,    --7
152, 444, 255, 255, 255,    --8
149, 444, 255, 255, 255,    --9
156, 446, 255, 255, 255,    --10
151, 446, 255, 255, 255,    --11
150, 448, 254, 254, 254,    --12
156, 448, 255, 255, 255,    --13
154, 450, 254, 254, 254,    --14
146, 450, 254, 254, 254,    --15
152, 442, 255, 255, 255,    --16
		};
---怪物血条根部的点参数， 用于判断是否到达挂机地点
g_t_GuaiXieTiao = { 0 ,0 ,  0 , 0, 3, -- 1，2，3，4字段不需配置
492, 29, 255, 32, 66,    --2
491, 29, 247, 32, 66,    --3
490, 29, 255, 32, 66,    --4				
				};
---Npc头像点参数，用于判断是否选中的头像还是npc，此此项用来辅助判断是否到达挂机地点
g_t_NpcTouXiang ={ 0, 0 , 0 , 0 , 3, -- 1，2，3，4字段不需配置
549, 33, 0, 0, 0,    --5
544, 51, 0, 0, 0,    --6
563, 56, 0, 0, 0,    --7
				};
---角色头像点参数，用于打开工具栏
g_t_JueSeTouXiang={ 56, 55, 0, 0, 8,
35, 502, 0, 0, 0,    --1
27, 504, 230, 206, 156,    --2
27, 513, 247, 223, 156,    --3
23, 519, 230, 223, 156,    --4
27, 522, 222, 194, 132,    --5
34, 522, 123, 85, 66,    --6
38, 509, 0, 0, 0,    --7
27, 524, 214, 182, 123,    --8


}


---挂机框中的"点击”的点字的点参数，用来判断是否弹出挂机对话框
g_t_GuaJiBtn = {792, 25, 0, 0, 11,  --1，2字段配置为找图前需点击的挂机按钮坐标

21, 69, 230, 251, 247,    --1
23, 67, 255, 255, 255,    --2
18, 72, 247, 255, 255,    --3
17, 74, 255, 255, 255,    --4
20, 77, 247, 255, 255,    --5
24, 77, 255, 255, 255,    --6
24, 74, 255, 255, 255,    --7
31, 69, 247, 255, 255,    --8
28, 66, 247, 255, 255,    --9
29, 76, 255, 255, 255,    --10
34, 78, 255, 255, 255,    --11
};
---挂机框中的"开始挂机"开始两个字的点参数，用来判断是否需要点击开始挂机按钮
g_t_QiDongGuaJiBtn = {408, 443, 0, 0, 10, --1，2字段配置为开始挂机按钮的坐标
366, 435, 255, 255, 255,    --1
362, 441, 255, 255, 255,    --2
365, 441, 255, 255, 255,    --3
368, 438, 255, 255, 255,    --4
368, 442, 255, 255, 255,    --5
374, 438, 255, 255, 255,    --6
374, 443, 255, 255, 255,    --7
374, 447, 255, 255, 255,    --8
365, 447, 255, 255, 255,    --9
379, 441, 255, 255, 255,    --10
				};
---挂机框中的"自动打怪"选项点参数，用于判断是否需要点击自动打怪选项
g_t_ZiDongDaGuai = {96,159, 0, 0, 1,  -- 1，2字段配置为自动打怪选项按钮的坐标
					91, 168, 255, 255, 255,    --11
					
				};
---背包框上整理两个字的点参数， 用于判断是否打开背包
g_t_ZhengLiBtn = {122,534, 56,446, 16,  --1，2字段是打开背包键的坐标，3，4字段是整理按钮的坐标
62, 444, 255, 255, 255,    --1
62, 450, 255, 255, 255,    --2
60, 443, 255, 251, 255,    --3
60, 448, 245, 249, 253,    --4
60, 453, 253, 254, 254,    --5
64, 452, 254, 254, 254,    --6
63, 448, 255, 255, 255,    --7
70, 441, 254, 254, 254,    --8
74, 441, 254, 254, 254,    --9
71, 445, 255, 255, 255,    --10
71, 453, 255, 255, 255,    --11
68, 444, 255, 251, 255,    --12
76, 444, 255, 255, 255,    --13
76, 455, 254, 254, 254,    --14
69, 455, 254, 254, 254,    --15
66, 455, 246, 250, 246,    --16

				};
---合成装备对话框上的银子前面黄色方括号的点参数， 用于判断合装备对话框是否打开
					 
g_t_HeChengBtn = {609,522,415,451, 8, ----1，2字段是打开合成的键的坐标，3，4字段是装备合成按钮的坐标
176, 396, 255, 255, 0,    --1
174, 396, 255, 255, 0,    --2
174, 398, 255, 255, 0,    --3
174, 402, 255, 255, 0,    --4
174, 406, 255, 255, 0,    --5
174, 408, 255, 255, 0,    --6
175, 408, 255, 255, 0,    --7
175, 409, 255, 255, 0,    --8


				};
---合成装备时背包中第方格上的参数， 用于判断装备的颜色
g_t_HeChengFangGe = {411,332,453,186,0, --1, 2字段存放自动放入按钮的坐标 3,4字段存放绑定装备合成时弹出对话框的确定按钮
					 99, 164, 230,295,0 , -- 行坐标，这里指 y坐标					 
					 587, 653,  719, 785, 851, -- 列坐标，这里指x
			
					}; 
---合成装备时装备绑定的判断点参数， 用于判断装备是否为绑定装备
g_t_HeChengSuo = {	0,0,0,0,3, 
193, 376, 214, 231, 230,   ---17
197, 374, 33, 73, 74,   ---18
184, 383, 189, 210, 222,   ---19					
				};
---回到挂机点 挂机地图右上角的 层字 点参数
g_t_Ceng = {789,145,789,192, 16, --1,2字段 怪物项坐标 3，4字段传送点项坐标
935, 4, 8, 4, 8,    --1
936, 4, 247, 243, 247,    --2
950, 4, 255, 255, 255,    --3
943, 4, 255, 255, 255,    --4
943, 8, 247, 243, 247,    --5
936, 8, 247, 243, 247,    --6
936, 12, 247, 251, 247,    --7
936, 17, 255, 255, 255,    --8
944, 6, 8, 8, 8,    --9
944, 11, 255, 255, 255,    --10 
944, 14, 255, 255, 255,    --11
949, 14, 255, 255, 255,    --12
949, 19, 247, 251, 247,    --13
942, 19, 255, 255, 255,    --14
949, 13, 90, 89, 90,    --15
943, 13, 90, 89, 90,    --16
};
---王城两个字的点参数，用来判断是否回到了王城
g_t_WangCheng = {953, 79, 0,0, 16, --1，2字段，小地图开关按钮坐标
944, 8, 255, 255, 255,    --1
946, 10, 255, 255, 255,    --2
946, 13, 255, 255, 255,    --3
948, 11, 255, 255, 255,    --4
950, 14, 255, 255, 255,    --5
948, 17, 247, 247, 247,    --6
945, 17, 255, 255, 255,    --7
942, 15, 255, 255, 255,    --8
942, 11, 255, 255, 255,    --9
955, 10, 247, 247, 247,    --10
949, 6, 255, 255, 255,    --11
954, 6, 255, 255, 255,    --12
952, 5, 247, 247, 247,    --13
953, 14, 255, 255, 255,    --14
953, 17, 255, 255, 255,    --15
955, 19, 255, 255, 255,    --16
};
--小地图上当前两个字的点参数，用来判断是否打开小地图
g_t_XiaoDiTu = {900,245, 47, 0, 16, --1,2字段是第一行的坐标， 3字段是行间距， 
105, 478, 0, 8, 0,    --1
106, 478, 0, 0, 0,    --2
97, 495, 99, 202, 99,    --3
98, 495, 189, 247, 197,    --4
99, 495, 197, 251, 206,    --5
102, 486, 239, 255, 239,    --6
102, 501, 156, 255, 173,    --7
102, 503, 140, 255, 156,    --8
102, 511, 58, 251, 90,    --9
101, 511, 58, 247, 82,    --10
99, 511, 41, 235, 74,    --11
99, 509, 82, 247, 107,    --12
100, 509, 82, 251, 107,    --13
104, 509, 82, 251, 107,    --14
106, 509, 66, 239, 99,    --15
108, 509, 74, 251, 99,    --16
};
---屏幕周围4点坐标，用来判断是否停止跑动
g_t_TingZhi = {
20, 302, 0, 0, 0,    --1
600, 520, 0, 0, 0,    --2
671, 18, 0, 0, 0,    --3
1004, 233, 0, 0, 0,    --4
};
--点击车夫弹出对话框的标志参数，用来判断是否弹出车夫对话框
g_t_CheFu = {378,91,276,83,16, --1,2字段关闭对话框的按钮坐标， 3，4字段，王城传送员的坐标
22, 105, 255, 215, 148,    --1
24, 110, 41, 0, 0,    --2
24, 115, 255, 215, 148,    --3
26, 119, 148, 53, 16,    --4
26, 123, 132, 45, 25,    --5
30, 123, 123, 57, 25,    --6
30, 121, 255, 251, 197,    --7
30, 117, 239, 158, 99,    --8
36, 117, 255, 215, 140,    --9
35, 111, 239, 182, 156,    --10
37, 111, 33, 0, 0,    --11
36, 104, 255, 247, 173,    --12
36, 99, 255, 194, 140,    --13
40, 106, 255, 170, 115,    --14
40, 113, 255, 227, 164,    --15
40, 119, 173, 101, 58,    --16
};
-- 王城挂机传送对话框的点参数 ， 用来判断是否打开挂机传送框
g_t_GuaJiKuang = {122,191, 122,240, 12, --1,2字段传送到1层， 3，4字段传送到5层
43, 124, 255, 182, 123,    --1
45, 110, 255, 255, 222,    --2
47, 118, 8, 0, 0,    --3
39, 120, 8, 0, 0,    --4
42, 126, 206, 113, 66,    --5
42, 129, 140, 73, 41,    --6
41, 129, 140, 85, 41,    --7
41, 134, 247, 20, 33,    --8
38, 135, 247, 8, 25,    --9
36, 135, 247, 8, 25,    --10
34, 135, 247, 0, 8,    --11
31, 129, 255, 16, 16,    --12
};
---角色是否上马的判断参数
g_t_ShangMa = {650, 60, 0,0,100 ---1，2字段是取色点和点击点的坐标， 5字段是比较的颜色，只需对本RGB中的B色即可
				};
---系统欢迎界面叉叉
g_t_ChaCha001   = {142,227,0,0, 31,
117, 230, 239, 0, 0, --1
117, 232, 239, 4, 0, --2
117, 235, 247, 8, 0, --3
117, 239, 247, 4, 0, --4
117, 241, 239, 8, 0, --5
141, 227, 181, 194, 189, --6
144, 228, 189, 194, 197, --7
147, 231, 189, 194, 197, --8
147, 233, 189, 194, 197, --9
150, 235, 189, 194, 189, --10
152, 236, 206, 206, 206, --11
153, 238, 189, 202, 197, --12
154, 240, 197, 206, 206, ----13
155, 242, 197, 190, 189, --14
156, 244, 206, 194, 197, --5
157, 246, 107, 28, 16, --6
162, 246, 107, 16, 8, --7
151, 215, 214, 223, 214,-- 8
149, 217, 206, 202, 197, --9
147, 219, 189, 198, 189, --20
145, 221, 189, 194, 197, --1
136, 219, 197, 198, 197, --2
124, 215, 197, 8, 8, ----3
123, 216, 214, 4, 0, --4
119, 242, 222, 4, 0, --5
119, 239, 239, 0, 0, ----6
117, 239, 247, 4, 0, --7
117, 237, 247, 4, 0, --8
143, 204, 140, 0, 0, --9
141, 204, 148, 0, 0, --30
139, 204, 156, 0, 0, --31
};

--国王召唤叉叉  ---潘桥镇张良叉叉
g_t_ChaCha002 = {76,306,0,0,6,
54, 306, 247, 8, 8,    --1
54, 308, 239, 4, 0,    --2
54, 311, 239, 0, 0,    --3
54, 314, 239, 0, 0,    --4
54, 317, 230, 0, 0,    --5
54, 320, 230, 0, 0,    --6

};



---死亡提示框特征
g_t_SiWangHuiCheng = {517, 276, 0, 0, 10, --1，2字段为回城复活的坐标
495, 137, 239, 0, 0,    --1
504, 137, 239, 0, 0,    --2
494, 141, 255, 0, 0,    --3
501, 141, 247, 0, 0,    --4
503, 152, 255, 0, 0,    --5
491, 152, 239, 0, 0,    --6
492, 145, 255, 0, 0,    --7
505, 143, 247, 0, 0,    --8
501, 148, 255, 0, 0,    --9
492, 145, 255, 0, 0,    --10
};
--组队提示
g_t_ZuDui = {400,741, 0, 0, 16,
391, 517, 255, 255, 255,    --1
392, 512, 255, 255, 255,    --2
392, 522, 247, 247, 247,    --3
397, 520, 255, 255, 255,    --4
397, 514, 255, 255, 255,    --5
402, 511, 255, 255, 255,    --6
402, 517, 255, 255, 255,    --7
402, 523, 255, 255, 255,    --8
407, 523, 255, 255, 255,    --9
407, 518, 239, 243, 239,    --10
407, 511, 255, 255, 255,    --11
412, 511, 255, 255, 255,    --12
413, 514, 247, 251, 247,    --13
413, 523, 255, 255, 255,    --14
397, 512, 255, 255, 255,    --15
397, 522, 255, 255, 255,    --16
};
--答题拒绝
g_t_DaTiJuJue = {561, 185, 0,0,16,
543, 178, 255, 255, 255,    --1
546, 178, 247, 251, 247,    --2
544, 182, 255, 255, 255,    --3
544, 187, 255, 255, 255,    --4
544, 189, 255, 255, 255,    --5
543, 184, 255, 255, 255,    --6
546, 183, 255, 255, 255,    --7
542, 191, 255, 255, 255,    --8
549, 176, 255, 255, 255,    --9
555, 176, 247, 247, 247,    --10
555, 180, 247, 247, 247,    --11
555, 185, 255, 255, 255,    --12
555, 190, 255, 255, 255,    --13
549, 190, 255, 255, 255,    --14
549, 187, 255, 255, 255,    --15
556, 183, 247, 243, 247,    --16
};
--穿上装备
g_t_ChuanZhuangBei = {582,386, 0,0, 16,
591, 382, 254, 254, 254,    --1
591, 385, 253, 253, 253,    --2
591, 387, 252, 252, 252,    --3
589, 386, 253, 253, 253,    --4
589, 383, 253, 253, 253,    --5
592, 390, 253, 254, 253,    --6
592, 392, 252, 253, 252,    --7
592, 396, 255, 251, 255,    --8
585, 395, 252, 253, 253,    --9
594, 395, 252, 253, 253,    --10
597, 382, 255, 255, 255,    --11
597, 385, 247, 251, 247,    --12
595, 386, 244, 244, 244,    --13
600, 386, 253, 253, 253,    --14
600, 392, 255, 255, 255,    --15
602, 396, 255, 255, 255,    --16
};
---加入快捷
g_t_JiaKuaiJie = {584,374, 0, 0, 16,
611, 364, 252, 252, 252,    --1
609, 366, 255, 255, 255,    --2
612, 366, 255, 255, 255,    --3
611, 368, 252, 252, 252,    --4
609, 371, 255, 255, 255,    --5
610, 377, 253, 253, 253,    --6
613, 377, 255, 255, 255,    --7
615, 375, 255, 255, 255,    --8
619, 375, 254, 254, 254,    --9
619, 371, 255, 255, 255,    --10
619, 364, 255, 255, 255,    --11
617, 364, 255, 255, 255,    --12
621, 364, 255, 255, 255,    --13
623, 368, 255, 255, 255,    --14
625, 369, 244, 249, 245,    --15
625, 378, 255, 255, 255,    --16
};
---组队取消

----
---------------(注意：以下到脚本结束都不要修改)-------------------------------------------------------------------
---------------(注意：以下到脚本结束都不要修改)-------------------------------------------------------------------
---------------(注意：以下到脚本结束都不要修改)-------------------------------------------------------------------
---------------(注意：以下到脚本结束都不要修改)-------------------------------------------------------------------
---------------(注意：以下到脚本结束都不要修改)-------------------------------------------------------------------
function sys_global_init()
	SYS_STEP_Init     = 0;        --系统常量
	SYS_STEP_JieRW    = 1;		--系统常量
	SYS_STEP_ZuoRW    = 2;		--系统常量
	SYS_STEP_ZhengLi  = 3;		--系统常量
	SYS_STEP_HeCheng  = 4;		--系统常量
	SYS_STEP_BackToGuaji= 5;    --系统常量

	BeiBao_step 	    = 0;  	--打开背包函数用到的变量
	BeiBao_Last_t		= 0;

	HeCheng_step 		= 0;	--合成装备函数用到的变量

	XiuLi_step			= 0;    --修理装备函数用到的变量
	Xiuli_HuiCheng_x    = -1;
	Xiuli_HuiCheng_y    = -1;

	BackGuaJi_step		= 0;    --回到挂机点用到的变量
	BackGuaJi_now_ceng  = 1;    --当前层
	GuaJi_Last_t  = 0;
	
	QiDongGuaJi_step    = 0;    --启动挂机用的变量


	JieRenWu_step = 0;
	JieRenWu_last_t = 0;

	ZuoRenWu_step = 0;
	ZuoRenWu_last_t = 0;
	QiDongGuaJi_step = 0;
	
	Radom_Hecheng_last_t = 60;
	Radom_PaoTu_last_t = 900;
end
--=====================基础函数--=====================--=====================--=====================--=====================
--函数： 单击屏幕
function click(x,y,t)
	touchDown(0, x, y);
	mSleep(math.random(150,150+t));
	touchUp(0);
	mSleep(math.random(200,500));
end
--函数： 双击屏幕
function double_click(x,y,t)
	touchDown(0, x, y);
	mSleep(math.random(80,80+t));
	touchUp(0);
	mSleep(math.random(100,100+t));
	touchDown(0, x, y);
	mSleep(math.random(80,80+t));
	touchUp(0);
	mSleep(math.random(200,500));
end

--函数： 单点找色
function compare_color_point(x,y,r,g,b, sim)
	local lr,lg,lb;	
	lr,lg,lb = getColorRGB(x,y);	
	if math.abs(lr-r) > sim then 
		return false;	
	end
	if math.abs(lg-g) > sim then 
		return false;	
	end
	if math.abs(lb-b) > sim then 
		return false;	
	end
	return true;	
end
--函数多点找色

--t={ x,y,0,0, pointNumber, //x,y  是找到图后点击的位置坐标或找图前需点击的按钮坐标， pointNumber是本次搜索中有效点的个数, 0未用保留字段
--	x1,y1,r1,g1,b1,  		  //x1,y1是图中点的坐标， r1，g1，b1是参考颜色
--	x2,y2,r2,g2,b2,
--	...
--	xn,yn,rn,gn,bn
--	};
show = 0;
function compare_color_Multi_point(t,sim)
	local i = 6;
	local lr,lg,lb;	
	
	
	while (i+4) <= (t[5]*5 + 5) do		
		lr,lg,lb = getColorRGB(t[i],t[i+1]);
		if show == 1 then
			notifyMessage(string.format("%d,%d: %d,%d,%d - %d,%d,%d - %d", t[i],t[i+1],lr,lg,lb, t[i+2], t[i+3], t[i+4], i));
			mSleep(1000);			
			mSleep(1000);
		end
		if math.abs(lr-t[i+2]) > sim then 
			show = 0;
			return false;	
		end
		if math.abs(lg-t[i+3]) > sim then 
			show = 0;
			return false;	
		end
		if math.abs(lb-t[i+4]) > sim then 
			show = 0;
			return false;	
		end				
		i = i + 5;
	end;
	show = 0;
	return true;
end
function compare_color_Multi_point_ext(t,sim, offset_x0,offset_x, offset_y0, offset_y)
	local j,h,i;
	local lr,lg,lb;	
	local flag;
	
	h = offset_y0;
	while h <= offset_y do
		j = offset_x0;
		while j<= offset_x do
			flag = true;
			i = 6;
			while (i+4) <= (t[5]*5 + 5) do		
				lr,lg,lb = getColorRGB(t[i] + j,t[i+1] + h);
				if show == 1 then
					logDebug(string.format("%d,%d: %d,%d,%d - %d,%d,%d - %d", t[i]+j,t[i+1],lr,lg,lb, t[i+2], t[i+3], t[i+4], i));
					mSleep(500);				
				end
				if math.abs(lr-t[i+2]) > sim then 
					flag = false;
					break;	
				end
				if math.abs(lg-t[i+3]) > sim then 
					flag = false;
					break;	
				end
				if math.abs(lb-t[i+4]) > sim then 
					flag = false;
					break;	
				end				
				i = i + 5;
			end
			if flag then
				show = 0;
				return true;
			end
			j = j + 1;
		end
		h = h + 1;
	end
	show = 0;
	return false;
end

function compare_color_Multi_point_ext2(t,sim, x , y)
	local i = 6;
	local lr,lg,lb;	
	while (i+4) <= (t[5]*5 + 5) do		
		lr,lg,lb = getColorRGB(t[i] + x,t[i+1] - y);
		if show == 1 then
			notifyMessage(string.format("%d,%d: %d,%d,%d - %d,%d,%d - %d", t[i],t[i+1],lr,lg,lb, t[i+2], t[i+3], t[i+4], i));
			mSleep(1000);			
			mSleep(1000);
		end
		if math.abs(lr-t[i+2]) > sim then
			show = 0;
			return false;	
		end
		if math.abs(lg-t[i+3]) > sim then
			show = 0;
			return false;	
		end
		if math.abs(lb-t[i+4]) > sim then
			show = 0;
			return false;	
		end				
		i = i + 5;
	end;
	show = 0;
	return true;
end
--=====================子函数（功能函数）--=====================--=====================--=====================
--函数： 打开工具栏
function Open_GongJuLan()
	if not compare_color_Multi_point_ext(g_t_JueSeTouXiang, 16, 0,0,0,0) then --若没打开工具栏
		click(g_t_JueSeTouXiang[1], g_t_JueSeTouXiang[2], 100);
		mSleep(500);	
	end
end
--函数： 打开背包,打开返回true 未打开返回false
function OpenBeiBao()
	if BeiBao_step == 0 then
		if not compare_color_Multi_point_ext(g_t_ZhengLiBtn, 30, -5, 5, -5, 5) then --若没打开背包
			BeiBao_step = 1;
			Open_GongJuLan();
			click(g_t_ZhengLiBtn[1], g_t_ZhengLiBtn[2], 100);			
		else
			return true;
		end
	elseif BeiBao_step >= 1 then		
		if compare_color_Multi_point_ext(g_t_ZhengLiBtn,30, -5, 5, -5, 5) then --若已打开背包		
			BeiBao_step = 0;
			return true;
		else
			BeiBao_step = BeiBao_step + 1;
			if BeiBao_step > 30 then
				BeiBao_step = 0;
			end
		end
	end	
	return false;
end
--函数： 检查颜色 ，合成装备用到
function check_color(r,g,b)
	if math.abs(r-222)< 40 and math.abs(g-0  ) < 40 and math.abs(b-132) < 40 then
		return 4,"Purple"; --紫色
	end
	if math.abs(r-0  )< 40 and math.abs(g-150) < 40 and math.abs(b-247) < 40 then
		return 3,"Blue";   --蓝色
	end
	if math.abs(r-45 )< 40 and math.abs(g-198) < 40 and math.abs(b-0  ) < 40 then
		return 2,"Green";  --绿色
	end
	if math.abs(r-239)< 40 and math.abs(g-243) < 40 and math.abs(b-239) < 40 then
		return 1,"White";  --白色
	end	
	return 0,"Black" -- 黑色 代表未知颜色	
end
--函数： 合成装备
function HeChengZhuangBei()
	local ix, iy;
	local count = 0;
	local last_color, this_color;
	local this_color_str;
	local this_r,this_g,this_b;
	if HeCheng_step == 0 then
		if not compare_color_Multi_point_ext(g_t_HeChengBtn, 30, -1, 1, -1, 1) then --若没打开合成界面			
			HeCheng_step = 2;
			Open_GongJuLan();
			click(g_t_HeChengBtn[1],g_t_HeChengBtn[2], 100);
		end
	elseif HeCheng_step >= 2 then
		if compare_color_Multi_point_ext(g_t_HeChengBtn, 30, -1, 1, -1, 1) then --若已打开合成界面				
			HeCheng_step = 1;
		else
			HeCheng_step = HeCheng_step + 1;
			if HeCheng_step >30 then
				HeCheng_step = 0;
			end 
		end
	elseif HeCheng_step == 1 then
		--从第一个背包的格子开始，逐个找出连续的满足条件的5个可合成的装备	
		mSleep(1000);		
		count = 0;
		last_color = -1;
		last_color_str = "";
		for iy = 0, 3 do		
		   for ix = 0, 4 do				
				this_r,this_g,this_b = getColorRGB(g_t_HeChengFangGe[11+ix], 
					                                g_t_HeChengFangGe[6+iy]);
				
				this_color, this_color_str = check_color(this_r,this_g,this_b);
				
				if last_color ~= this_color or this_color == 0 or this_color == 4 then
					count = 0;
				end
				last_color = this_color;				
				count = count + 1;				
				
				if count >= 5 then
					count = 0;
					last_color = -1;
					if compare_color_Multi_point_ext(g_t_HeChengBtn, 30, -1, 1, -1, 1) then --若已打开合成界面	
						--双击该点坐标偏移
						double_click(g_t_HeChengFangGe[11+ix], 
					                   g_t_HeChengFangGe[6+iy]+ 15, 50);
						mSleep(500);
						--单击自动放入按钮
						click(g_t_HeChengFangGe[1], g_t_HeChengFangGe[2], 100);
						mSleep(500);
						--单击装备合成按钮
						click(g_t_HeChengBtn[3], g_t_HeChengBtn[4], 100);
						mSleep(4000);
						--若有取消按钮，点击取消按钮
						click(g_t_HeChengFangGe[3], g_t_HeChengFangGe[4], 100);	
						mSleep(2000);	
						
					end					
				end
			end
		end
		--单击宝匣按钮关闭合成窗口
		click(g_t_HeChengBtn[1],g_t_HeChengBtn[2], 100);
		HeCheng_step = 0;
		return true;
	end
	return false;
end
---函数： 启动挂机------------------------------------------------------------
function QiDongGuaJi()
	
	if QiDongGuaJi_step == 0 then
		if not compare_color_Multi_point_ext(g_t_GuaJiBtn, 30, -1, 1, -15, 32) then --如果没有打开挂机对话框
			click(g_t_GuaJiBtn[1], g_t_GuaJiBtn[2], 100); --打开挂机对话框
			--notifyMessage("3");
			mSleep(500);
		end
		
		--notifyMessage("2");
		QiDongGuaJi_step = 2;
	elseif QiDongGuaJi_step == 1 then
		if compare_color_Multi_point_ext(g_t_GuaJiBtn, 30, -1, 1, -15, 32) then --如果已经打开挂机对话框
			click(g_t_GuaJiBtn[1], g_t_GuaJiBtn[2], 100); --关闭挂机对话框			
		end		
		return true;
	elseif QiDongGuaJi_step >= 2 then
	
		if compare_color_Multi_point_ext(g_t_GuaJiBtn, 30, -1, 1, -15, 32) then	--等待打开挂机对话框			
			
			if compare_color_Multi_point(g_t_QiDongGuaJiBtn, 30) then	
				click(g_t_QiDongGuaJiBtn[1], g_t_QiDongGuaJiBtn[2], 100);
				mSleep(1500);
			end		
			--notifyMessage("2");
			--show = 1;	
			if not compare_color_Multi_point_ext(g_t_ZiDongDaGuai, 0, -1, 1, -15, 32) then
				click(g_t_ZiDongDaGuai[1] , g_t_ZiDongDaGuai[2], 100);
				mSleep(1500);
			--	notifyMessage("2");
			end
			QiDongGuaJi_step = 1;			
		else
			QiDongGuaJi_step = QiDongGuaJi_step +1;
			if QiDongGuaJi_step > 10 then
				if compare_color_Multi_point(g_t_QiDongGuaJiBtn, 30) then	
					click(g_t_QiDongGuaJiBtn[1], g_t_QiDongGuaJiBtn[2], 100);
					mSleep(1500);
				end		
				--notifyMessage("2");
				--show = 1;	
				if not compare_color_Multi_point_ext(g_t_ZiDongDaGuai, 0, -1, 1, -15, 32) then
					click(g_t_ZiDongDaGuai[1] , g_t_ZiDongDaGuai[2], 100);
					mSleep(1500);
				--	notifyMessage("2");
				end
				click(g_t_GuaJiBtn[1], g_t_GuaJiBtn[2], 100); --关闭挂机对话框
				return true;
			end
		end

	end
	return false;
end
---函数： 交接任务------------------------------------------------------------
function JiaoJieRenWu()
	
	if JieRenWu_step == 0 then
		if compare_color_Multi_point_ext(g_t_RenWu, 30, -1, 1, -1, 1) then	
			g_t_NpcTouXiang[8], g_t_NpcTouXiang[9], g_t_NpcTouXiang[10] = getColorRGB(g_t_NpcTouXiang[6], g_t_NpcTouXiang[7]);
			g_t_NpcTouXiang[13],g_t_NpcTouXiang[14],g_t_NpcTouXiang[15] = getColorRGB(g_t_NpcTouXiang[11],g_t_NpcTouXiang[12]);
			g_t_NpcTouXiang[18],g_t_NpcTouXiang[19],g_t_NpcTouXiang[20] = getColorRGB(g_t_NpcTouXiang[16],g_t_NpcTouXiang[17]);
			click(g_t_RenWu[1], g_t_RenWu[2], 100);			
			JieRenWu_step = 1;
		end
		if os.difftime(os.time(), JieRenWu_last_t) > 5 then
			return true
		end
	elseif JieRenWu_step == 1 then
		mSleep(500);
		if compare_color_Multi_point_ext(g_t_RenWu, 30, -1, 1, -1, 1) then	
			click(g_t_RenWu[1], g_t_RenWu[2], 100);
		else	
			return true;
		end
	end
	return false;
end

---函数： 做任务------------------------------------------------------------
function ZuoRenWu()
	
	if ZuoRenWu_step == 0 then
		if GuaJi_Endable == 1 then
			ZuoRenWu_step = 1;
			QiDongGuaJi_step = 0;
		elseif compare_color_Multi_point_ext(g_t_GuaiXieTiao, 30, 0, 0, 0, 0) then			
			if not compare_color_Multi_point_ext(g_t_NpcTouXiang, 30, 0, 0, 0, 0) then
				ZuoRenWu_step = 1;
				QiDongGuaJi_step = 0;
			end		
		end	 	
		
		if os.difftime(os.time(), ZuoRenWu_last_t) > 5 then
			return true;
		end
	elseif ZuoRenWu_step == 1 then
		if QiDongGuaJi() then
			ZuoRenWu_step = 2;
		end
	elseif ZuoRenWu_step == 2 then
		
		if GuaJi_Endable == 1 then
			if os.difftime(os.time(), BeiBao_Last_t) > Radom_Hecheng_last_t then
				Radom_Hecheng_last_t = math.random(150, 250);
				BeiBao_Last_t = os.time();
				ZuoRenWu_step = 3;
				mSleep(200);
			elseif os.difftime(os.time(), ZuoRenWu_last_t) > 120 then
				return true;			
			end 
		elseif compare_color_Multi_point_ext(g_t_Wan, 30, 0,0,0,0) then			
			return true;
		else
			if os.difftime(os.time(), BeiBao_Last_t) > 30 then
				BeiBao_Last_t = os.time();
				ZuoRenWu_step = 3;
				mSleep(200);
			elseif os.difftime(os.time(), ZuoRenWu_last_t) > 60 then
				return true;
			
			end					
		end
	elseif ZuoRenWu_step == 3 then -- 整理背包
		if OpenBeiBao() then								
			click( g_t_ZhengLiBtn[3], g_t_ZhengLiBtn[4],  100 );	
			mSleep(1000);	
			if HeCheng_Enable == 1 then
				ZuoRenWu_step = 4;
			else
				click( g_t_ZhengLiBtn[1], g_t_ZhengLiBtn[2],  100 );
				ZuoRenWu_step = 2;
			end			
				
		--else
			
		--	if os.difftime(os.time(), BeiBao_Last_t) > 5 then	
		--		BeiBao_Last_t = os.time();
		--		ZuoRenWu_step = 2;
		--	end							
		end 
	elseif ZuoRenWu_step == 4 then -- 合成装备
		if HeChengZhuangBei() then
			BeiBao_Last_t = os.time();
			ZuoRenWu_step = 2;
		end
	end
	return false;
end
--函数： 回到挂机地点--------------------------------------------------------------------
function BackToGuaJiDian()
	local r,g,b;
	
	if BackGuaJi_step == 0 then -- 等待回到王城
		if compare_color_Multi_point_ext(g_t_WangCheng, 30, -1,1,-1,1) then	
			mSleep(500);
			click(g_t_WangCheng[1], g_t_WangCheng[2],100);
			BackGuaJi_step = 1;			
		end
	elseif BackGuaJi_step == 1 then -- 等待显示小地图
		
		if compare_color_Multi_point_ext(g_t_XiaoDiTu, 30, -1,1,-1,1) then	
			mSleep(500);
			click(g_t_XiaoDiTu[1] , g_t_XiaoDiTu[2] + (g_t_XiaoDiTu[3] * (CheFu_Hang-1)),100);
			BackGuaJi_step = 2
		end	
	elseif BackGuaJi_step == 2 then -- 等待显示车夫对话框
		if compare_color_Multi_point_ext(g_t_CheFu, 30, -1,1,-10,32) then	
			mSleep(500);
			click(g_t_CheFu[1] , g_t_CheFu[2] ,100); --关闭对话框
			mSleep(500);
			click(g_t_CheFu[3] , g_t_CheFu[4] ,100); --点击王城挂机传送员
			BackGuaJi_step = 3;
		end
	elseif BackGuaJi_step == 3 then -- 等待显示传送对话框 g_t_GuaJiKuang
		if compare_color_Multi_point_ext(g_t_GuaJiKuang, 30, -1,1,-10,32) then						
			mSleep(500);
			if GuaJi_Ceng < 4 then
				-- 选择进入第1层
				click(g_t_GuaJiKuang[1],g_t_GuaJiKuang[2],100);
				BackGuaJi_now_ceng = 1;
			else
				-- 选择进入第5层
				click(g_t_GuaJiKuang[3],g_t_GuaJiKuang[4],100);
				BackGuaJi_now_ceng = 5;
			end			
			BackGuaJi_step = 4;	
		end
	elseif BackGuaJi_step == 4 then --等待传送完毕
		if compare_color_Multi_point_ext(g_t_Ceng, 30, -1,1,-10,32) then			
			BackGuaJi_step = 5;
			mSleep(500);
			click(g_t_WangCheng[1], g_t_WangCheng[2],100);			
		end
	elseif BackGuaJi_step == 5 then --等待打开小地图
		if compare_color_Multi_point_ext(g_t_XiaoDiTu, 30, -1,1,-1,1) then	
			mSleep(500);
			if BackGuaJi_now_ceng == GuaJi_Ceng then
				click(g_t_Ceng[1], g_t_Ceng[2], 100);			
				mSleep(500);
				if GuaJi_Guai>0 and GuaJi_Guai<5 then
					click(g_t_XiaoDiTu[1] , g_t_XiaoDiTu[2]  + g_t_XiaoDiTu[3]*(GuaJi_Guai-1), 100);
				else
					click(g_t_XiaoDiTu[1] , g_t_XiaoDiTu[2] , 100);
				end
				BackGuaJi_step = 7;
			else
				click(g_t_Ceng[3], g_t_Ceng[4], 100);			
				mSleep(500);
				BackGuaJi_step = 6;
				if BackGuaJi_now_ceng == 1 then
					BackGuaJi_now_ceng = 2;
					click(g_t_XiaoDiTu[1], g_t_XiaoDiTu[2], 100);
				elseif BackGuaJi_now_ceng == 5 then
					if GuaJi_Ceng == 4 then
						BackGuaJi_now_ceng = 4;
						click(g_t_XiaoDiTu[1], g_t_XiaoDiTu[2], 100);
					else
						BackGuaJi_now_ceng = 6;
						click(g_t_XiaoDiTu[1] , g_t_XiaoDiTu[2] + g_t_XiaoDiTu[3], 100);
					end
				else
					BackGuaJi_now_ceng = BackGuaJi_now_ceng + 1;
					click(g_t_XiaoDiTu[1] , g_t_XiaoDiTu[2] + g_t_XiaoDiTu[3], 100);					
				end
			end
		end
	elseif BackGuaJi_step == 6 then --等待小地图关闭
		if not compare_color_Multi_point_ext(g_t_XiaoDiTu, 30, -1,1,-1,1) then	
			BackGuaJi_step = 4;
		end
	elseif BackGuaJi_step >= 7 then --等待跑到刷怪点
		i = 1; j = 0;
		while i < 20 do			
			if compare_color_point(g_t_TingZhi[i],g_t_TingZhi[i+1], g_t_TingZhi[i+2],g_t_TingZhi[i+3],g_t_TingZhi[i+4], 0) then		
				j = j+1;
			else 
				g_t_TingZhi[i+2],g_t_TingZhi[i+3],g_t_TingZhi[i+4]= getColorRGB(g_t_TingZhi[i],g_t_TingZhi[i+1]);
			end
			i = i + 5;
		end
		if j >=3 then 
			BackGuaJi_step = BackGuaJi_step + 1;
		else 
			BackGuaJi_step = 7;
		end
		if BackGuaJi_step > 30 then
			return  true;
		end		
	end
	--notifyMessage(string.format("%d: %d,%d",BackGuaJi_step,x,y));
	--mSleep(1000);
	return false;
end
--=====================主函数（入口函数）--=====================--=====================--=====================
function main()	
	local sys_step; 
	local loop_count;
	local lr,lg,lb,count;
	sys_global_init();
	sys_step = SYS_STEP_Init;
	loop_count = 0;
	count = 0;	
	BeiBao_Last_t = 0;
	GuaJi_Last_t  = 0;
	while true do
		if sys_step == SYS_STEP_Init then --判断当前状态			
			if GuaJi_Endable == 1 then
				if compare_color_Multi_point_ext(g_t_WangCheng, 30, -1,1,-1,1) then						
					BackGuaJi_step = 0;	
					GuaJi_Last_t = os.time();
					sys_step = SYS_STEP_BackToGuaji;	
				elseif 	compare_color_Multi_point_ext(g_t_Ceng, 30, -1,1,-1,1) and
					 (os.difftime(os.time(), GuaJi_Last_t) > Radom_PaoTu_last_t ) then
						Radom_PaoTu_last_t = math.random(600, 900);
						click(g_t_WangCheng[1], g_t_WangCheng[2],100);
						BackGuaJi_step = 5;	
						BackGuaJi_now_ceng = GuaJi_Ceng;
						GuaJi_Last_t = os.time();
						sys_step = SYS_STEP_BackToGuaji;
					
				else
					ZuoRenWu_step = 0;			
					ZuoRenWu_last_t = os.time();
					sys_step = SYS_STEP_ZuoRW;	
				end					
			else	
				if compare_color_Multi_point_ext(g_t_KeJie, 30, 0,0,0,0) then --如果发现可接,去交接任务
					click(g_t_KeJie[1], g_t_KeJie[2], 100);		
					JieRenWu_step = 0;	
					JieRenWu_last_t = os.time();			
					sys_step = SYS_STEP_JieRW;	
				elseif compare_color_Multi_point_ext(g_t_Wan, 30, 0,0,0,0) then	--如果发现完，则去交接任务	
					click(g_t_KeJie[1], g_t_KeJie[2], 100);		
					JieRenWu_step = 0;
					JieRenWu_last_t = os.time();
					sys_step = SYS_STEP_JieRW;
				elseif compare_color_Multi_point(g_t_RenWu, 30) then	 --如果发现任务，则去交接任务	
					JieRenWu_step = 0;	
					JieRenWu_last_t = os.time();			
					sys_step = SYS_STEP_JieRW;
				else
					click(g_t_KeJie[1], g_t_KeJie[2], 100);
					ZuoRenWu_step = 0;			
					ZuoRenWu_last_t = os.time();
					sys_step = SYS_STEP_ZuoRW;		
				end				
			end	
		elseif sys_step == SYS_STEP_JieRW then
			if JiaoJieRenWu() then
				sys_step = SYS_STEP_Init;
			end
		elseif sys_step == SYS_STEP_ZuoRW then
			if ZuoRenWu() then
				sys_step = SYS_STEP_Init;
			end
		elseif sys_step == SYS_STEP_BackToGuaji then
			if BackToGuaJiDian() then
				sys_step = SYS_STEP_Init;
			end
		end
		if loop_count == 0 then	
			if sys_step == SYS_STEP_Init then
				if compare_color_Multi_point_ext(g_t_GuaJiBtn, 30, -1,1,-15, 32)  then --如果已经打开挂机对话框
					click(g_t_GuaJiBtn[1], g_t_GuaJiBtn[2], 100); --关闭挂机对话框			
				end	
			end
			loop_count = 1;
		elseif loop_count == 1 then
			if sys_step == SYS_STEP_Init then
				if compare_color_Multi_point_ext(g_t_HeChengBtn, 30, -1,1,-1,1) then --若打开合成界面			
					click(g_t_HeChengBtn[1],g_t_HeChengBtn[2], 100); --关闭合成
				end
			end
			loop_count = 2;
		elseif loop_count == 2 then	
			if sys_step == SYS_STEP_Init then
				if compare_color_Multi_point_ext(g_t_ZhengLiBtn, 30, -5,5,-5,5) then --若已打开背包	
					click(g_t_ZhengLiBtn[1],g_t_ZhengLiBtn[2], 100); --关闭beibao
				end	
			end
			loop_count = 3;
		elseif loop_count == 3 then		
			--判断角色是否死亡	
			if compare_color_Multi_point_ext(g_t_SiWangHuiCheng, 30, -1,1,-1,1) then
				click(g_t_SiWangHuiCheng[1], g_t_SiWangHuiCheng[2], 100); --点击回城复活按钮
				mSleep(5000);
				sys_step = SYS_STEP_Init;
			end	
			loop_count = 4;
		elseif loop_count == 4 then					
			if compare_color_Multi_point_ext(g_t_ChaCha001, 30, -1,1,-1,1) then
				click(g_t_ChaCha001[1], g_t_ChaCha001[2], 100); --点击关闭系统欢迎
				mSleep(200);				
			end	
			loop_count = 5;
		elseif loop_count == 5 then			
			if compare_color_Multi_point_ext(g_t_ChaCha002, 30, -1,1,-1,1) then
				click(g_t_ChaCha002[1], g_t_ChaCha002[2], 100); --点击关闭国王召唤
				sys_step = SYS_STEP_Init;
				mSleep(200);				
			end			
			loop_count = 6;		
		elseif loop_count == 6 then
			if compare_color_Multi_point_ext(g_t_ZuDui, 30, 32, -5,5,-15,15) then
				click(g_t_ZuDui[1], g_t_ZuDui[2], 100); --点击关闭组队提示
				--sys_step = SYS_STEP_Init;
				mSleep(200);				
			end			
			loop_count = 7;
		elseif loop_count == 7 then
			if compare_color_Multi_point_ext(g_t_ChuanZhuangBei, 30, -5,5,-15,15) then
				click(g_t_ChuanZhuangBei[1], g_t_ChuanZhuangBei[2], 100); --点击穿上装备
				--sys_step = SYS_STEP_Init;
				mSleep(200);				
			end				
			loop_count = 8;
		elseif loop_count == 8 then
			if compare_color_Multi_point_ext(g_t_JiaKuaiJie, 30, -5,5,-15,15) then
				click(g_t_JiaKuaiJie[1], g_t_JiaKuaiJie[2], 100); --点击加入快捷键
				--sys_step = SYS_STEP_Init;
				mSleep(200);				
			end				
			loop_count = 9;
		elseif loop_count == 9 then
			
			if compare_color_Multi_point_ext(g_t_DaTiJuJue, 30, -5,5,-15,15) then
				click(g_t_DaTiJuJue[1], g_t_DaTiJuJue[2], 100); --点击答题拒绝
				mSleep(200);				
			end				
			loop_count = 10;
		else
			loop_count = 0 
		end		
		
		mSleep(200);
	end
end
	
