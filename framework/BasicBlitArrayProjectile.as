package com.efg.framework
{
	import com.efg.framework.BasicBlitArrayObject;
	import com.efg.framework.BasicBlitArrayProjectile;
	
	public class BasicBlitArrayProjectile extends BasicBlitArrayObject
	{

		public function BasicBlitArrayProjectile(xMin:int, xMax:int, yMin:int, yMax:int) 
		{
			super(xMin, xMax, yMin, yMax);
		}
		
		public function update (xAdjust:Number, yAdjust:Number, step:Number = 1):Boolean
		{
			nextX +=(dx * (speed + Math.abs(xAdjust))) * step;
			nextY +=(dy * (speed + Math.abs(yAdjust))) * step;
			
			if (nextX > xMax || nextX < xMin || nextY > yMax || nextY < yMin)
			{
				return(true);				
			}
			
			else
			{
				return(false);
			}
		}

	}
	
}
