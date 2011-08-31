﻿package cn.bdconsulting.www.config  
{
	/**
	 * ...
	 * @author DFdou
	 */
	public class MapData
	{
		public static const WALL:uint = 1;//墙壁
		public static const ROAD:uint = 2;//路
		public static const BOX:uint = 3;//箱子
		public static const TARGET:uint = 4;//目的地
		public static const SPECIAL:uint = 5;//箱子直接在目的地
		public static const ROLE:uint = 6;//角色
		
		public static const MAP:Array = [
			[
				[1,1,1,1,1,1,1],
				[1,2,2,2,1,1,1],
				[1,4,2,3,1,1,1],
				[1,4,2,6,2,2,1],
				[1,1,3,2,1,2,1],
				[1,1,2,2,2,2,1],
				[1,1,1,1,1,1,1]
			],
			[
				[0,1,1,1,1,1,1,1],
				[0,1,2,2,2,2,2,1],
				[0,1,2,4,4,4,2,1],
				[0,1,2,4,4,4,2,1],
				[1,1,2,3,2,3,2,1],
				[1,1,1,2,2,2,1,1],
				[1,2,3,3,3,3,2,1],
				[1,2,2,2,2,2,2,1],
				[1,2,6,1,1,2,2,1],
				[1,2,2,1,1,2,2,1],
				[1,1,1,1,1,1,1,1]
			],
			[
				[1,1,1,1,1,0,0,0,0],
				[1,2,2,2,1,0,0,0,0],
				[1,2,3,6,1,0,1,1,1],
				[1,2,3,2,1,0,1,4,1],
				[1,1,1,2,1,1,1,4,1],
				[0,1,1,2,2,2,2,4,1],
				[0,1,2,3,2,1,2,2,1],
				[0,1,2,2,2,1,1,1,1],
				[0,1,1,1,1,1,0,0,0]
			],
			//////////////////////////////
			[
				[1,1,1,1,1,1,1,1],
				[1,1,1,4,1,1,1,1],
				[1,1,1,2,1,1,1,1],
				[1,1,1,3,2,3,4,1],
				[1,4,2,3,6,1,1,1],
				[1,1,1,1,3,1,1,1],
				[1,1,1,1,4,1,1,1],
				[1,1,1,1,1,1,1,1]
			],
			
			[
				[1,1,1,1,1,1,1,1,1],
				[1,2,2,2,1,1,1,1,1],
				[1,2,3,3,1,1,2,2,1],
				[1,6,3,2,2,2,2,2,1],
				[1,1,1,1,1,2,2,2,1],
				[0,0,1,1,1,2,1,1,1],
				[0,0,1,1,1,2,2,1,1],
				[0,0,1,4,4,4,2,1,1],
				[0,0,1,1,1,1,1,1,1]
			],
			
			[
				[1,1,1,1,1,1,1,1],
				[1,1,6,2,1,1,1,1],
				[1,1,2,3,2,2,1,1],
				[1,1,1,2,1,2,1,1],
				[1,4,1,2,1,2,2,1],
				[1,4,3,2,2,1,2,1],
				[1,4,2,2,2,3,2,1],
				[1,1,1,1,1,1,1,1]
			],
			
			[
				[1,1,1,1,1,1,1],
				[1,1,1,4,4,1,1],
				[1,1,4,4,4,1,1],
				[1,1,2,3,2,1,1],
				[1,2,3,2,3,1,1],
				[1,2,1,3,2,1,1],
				[1,2,1,2,3,2,1],
				[1,2,2,6,2,2,1],
				[1,1,1,1,1,1,1]
			],
			
			[
				[1,1,1,1,1,1,1],
				[1,1,1,6,2,1,1],
				[1,1,1,2,3,1,1],
				[1,2,3,3,4,1,1],
				[1,2,3,4,4,2,1],
				[1,2,3,4,4,2,1],
				[1,2,2,2,1,1,1],
				[1,1,1,1,1,1,1]
			],
			
			[
				[1,1,1,1,1,1,1],
				[1,1,2,2,1,1,1],
				[1,1,2,2,1,1,1],
				[1,2,3,4,2,2,1],
				[1,2,4,3,5,2,1],
				[1,6,2,4,3,2,1],
				[1,1,1,2,2,1,1],
				[1,1,1,1,1,1,1]
			],
			
			[
				[1,1,1,1,1,1,1,1],
				[1,1,1,4,4,1,1,1],
				[1,1,1,2,4,1,1,1],
				[1,1,2,2,3,4,1,1],
				[1,1,2,3,2,2,1,1],
				[1,2,2,1,3,3,2,1],
				[1,2,2,6,2,2,2,1],
				[1,1,1,1,1,1,1,1]
			],
			
			[
				[1,1,1,1,1,1,1],
				[1,2,2,6,2,2,1],
				[1,2,3,3,3,2,1],
				[1,1,4,4,4,1,1],
				[1,2,4,5,4,2,1],
				[1,2,3,2,3,2,1],
				[1,2,2,1,2,2,1],
				[1,1,1,1,1,1,1]
			],
			
			[
				[1,1,1,1,1,1,1],
				[1,2,2,2,1,1,1],
				[1,2,3,2,2,2,1],
				[1,2,3,1,2,6,1],
				[1,2,3,4,4,2,1],
				[1,1,1,4,4,2,1],
				[1,1,1,1,3,2,1],
				[1,1,1,1,2,2,1],
				[1,1,1,1,1,1,1]
			],
			
			[
				[1,1,1,1,1,1,1,1],
				[1,4,4,3,4,4,1,1],
				[1,4,4,1,4,4,1,1],
				[1,2,3,3,3,2,1,1],
				[1,2,2,3,2,2,1,1],
				[1,2,3,3,3,2,1,1],
				[1,2,2,1,6,2,1,1],
				[1,1,1,1,1,1,1,1]
			],
			
			[
				[1,1,1,1,1,1,1,1],
				[1,2,2,6,2,2,1,1],
				[1,2,3,2,3,2,2,1],
				[1,2,2,3,2,3,2,1],
				[1,1,1,3,1,1,1,1],
				[1,2,4,2,4,4,1,1],
				[1,2,2,2,2,2,1,1],
				[1,2,2,1,2,4,1,1],
				[1,2,2,4,2,2,1,1],
				[1,1,1,1,1,1,1,1]
			],
			
			[
				[1,1,1,1,1,1,1,1],
				[1,1,2,6,2,1,1,1],
				[1,1,2,1,3,2,2,1],
				[1,2,5,4,2,4,2,1],
				[1,2,2,3,3,2,1,1],
				[1,1,1,2,1,4,1,1],
				[1,1,1,2,2,2,1,1],
				[1,1,1,1,1,1,1,1]
			],
			
			[
				[1,1,1,1,1,1],
				[1,2,2,2,2,1],
				[1,2,3,2,6,1],
				[1,1,5,2,2,1],
				[1,2,5,2,1,1],
				[1,2,5,2,1,1],
				[1,2,5,2,1,1],
				[1,2,5,2,1,1],
				[1,2,4,2,1,1],
				[1,1,1,1,1,1]
			],
			
			[
				[1,1,1,1,1,1,1],
				[1,1,1,2,2,1,1],
				[1,1,1,3,2,1,1],
				[1,2,2,5,2,6,1],
				[1,2,2,5,2,2,1],
				[1,2,2,5,2,1,1],
				[1,1,1,5,2,1,1],
				[1,1,1,4,1,1,1],
				[1,1,1,1,1,1,1]
			],
			
			[
				[1,1,1,1,1,1,1,1],
				[1,2,2,2,4,4,4,1],
				[1,2,1,3,4,6,4,1],
				[1,2,2,2,1,3,2,1],
				[1,1,1,2,3,2,2,1],
				[1,1,2,2,1,2,1,1],
				[1,1,2,3,3,2,1,1],
				[1,1,2,2,1,1,1,1],
				[1,1,1,1,1,1,1,1]
			],
			
			[
				[1,1,1,1,1,1,1],
				[1,1,1,2,2,2,1],
				[1,2,4,4,2,2,1],
				[1,2,1,4,1,6,1],
				[1,2,1,3,3,2,1],
				[1,2,3,2,2,1,1],
				[1,1,2,2,2,1,1],
				[1,1,1,1,1,1,1]
			],
			
			[
				[1,1,1,1,1,1],
				[1,2,2,4,2,1],
				[1,6,1,2,5,1],
				[1,2,2,3,2,1],
				[1,2,1,5,2,1],
				[1,2,2,2,2,1],
				[1,1,1,1,1,1]
			],
			
			[
				[1,1,1,1,1,1,1,1],
				[1,1,1,2,2,1,1,1],
				[1,1,2,2,2,2,1,1],
				[1,2,4,2,4,3,1,1],
				[1,2,2,3,6,2,2,1],
				[1,1,1,1,5,1,2,1],
				[1,1,1,1,2,2,2,1],
				[1,1,1,1,1,1,1,1]
			],
			
			[
				[1,1,1,1,1,1,1],
				[1,2,4,2,5,2,1],
				[1,2,2,1,2,2,1],
				[1,6,3,5,2,2,1],
				[1,1,2,2,2,1,1],
				[1,1,2,2,2,1,1],
				[1,1,1,1,1,1,1]
			],
			
			[
				[1,1,1,1,1,1,1,1],
				[1,2,2,2,1,2,2,1],
				[1,2,6,2,2,3,2,1],
				[1,1,3,1,1,4,4,1],
				[1,1,2,4,1,2,2,1],
				[1,1,3,2,2,2,2,1],
				[1,1,2,2,1,1,1,1],
				[1,1,1,1,1,1,1,1]
			],
			
			/////////////////////////////////
			[
				[1,1,1,1,1,1,1],
				[1,1,1,2,1,1,1],
				[1,1,4,3,2,1,1],
				[1,4,4,4,2,1,1],
				[1,3,4,3,2,2,1],
				[1,2,3,2,2,1,1],
				[1,6,3,1,1,1,1],
				[1,2,2,1,1,1,1],
				[1,1,1,1,1,1,1]
			],
			[
				[1,1,1,1,1,1,1,1],
				[1,2,2,2,2,2,2,1],
				[1,2,3,3,1,3,2,1],
				[1,2,3,4,5,2,2,1],
				[1,1,2,4,4,4,1,1],
				[1,1,1,4,3,1,1,1],
				[1,1,4,4,5,2,1,1],
				[1,2,2,5,5,6,2,1],
				[1,2,3,1,2,3,2,1],
				[1,2,2,2,2,2,2,1],
				[1,1,1,1,1,1,1,1]
			]
		];
		
	}

}