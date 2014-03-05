package ;


import flash.utils.ByteArray;
import flash.utils.Endian;


import openfl.Assets;
import haxe.xml.Fast;
import flash.geom.Point;



/**
 * ...
 * @author djoker
 */
	  class ParticleSystemInfo 
	{
		
	public var Blend:Int;
	public var Frame:Int;
		 
    public var Emission:Int;
    public var Lifetime: Float;

    public var ParticleLifeMin: Float;
    public var ParticleLifeMax: Float;

   public var  Direction: Float;
   public var  Spread: Float;
   public var  Relative: Int;

   public var  SpeedMin: Float;
   public var  SpeedMax: Float;

  public var   GravityMin: Float;
  public var   GravityMax: Float;

  public var   RadialAccelMin: Float;
  public var   RadialAccelMax: Float;

   public var  TangentialAccelMin: Float;
   public var  TangentialAccelMax: Float;

  public var   SizeStart: Float;
   public var  SizeEnd: Float;
   public var  SizeVar: Float;

 public var    SpinStart: Float;
  public var   SpinEnd: Float;
  public var   SpinVar: Float;

  public var   ColorStart: Color4;
  public var   ColorEnd: Color4;
  public var   ColorVar: Float;
  public var   AlphaVar: Float;
		
		public inline function new() 
		{
			ColorStart = new Color4();
			ColorEnd = new Color4();
Frame = 0;
Blend = 0;
Emission=20;
Lifetime=10.000;
ParticleLifeMin=0.437;
ParticleLifeMax=0.992;
Direction=0.000;
//Spread=6.283;
Spread=0;
Relative = 0;
SpeedMin=85.714;
SpeedMax = 104.762;
GravityMin=0.000;
GravityMax = 0.000;
RadialAccelMin=-71.429;
RadialAccelMax=-71.429;
TangentialAccelMin=0.000;
TangentialAccelMax=0.000;
SizeStart=0.989;
SizeEnd=2.301;
SizeVar=0.000;
SpinStart=19.841;
SpinEnd=19.841;
SpinVar=0.524;
ColorVar=0.206;
AlphaVar=0.206;
ColorStart.r=0.095;
ColorStart.g=0.802;
ColorStart.b=0.357;
ColorStart.a=1.000;
ColorEnd.r=0.413;
ColorEnd.g=0.159;
ColorEnd.b=0.889;
ColorEnd.a=0.286;


			
		}
		
		public function toXml():String
		{
			var result:String;
			
			result='<?xml version="1.0"?>\n'+
            '<EmitterConfig>\n'+

'<Emission value="'+Emission+'"/>\n'+
'<Lifetime value="'+Lifetime+'"/>\n'+
'<Direction value="'+Direction+'"/>\n'+
'<Spread value="'+Spread+'"/>\n'+
'<Relative value="'+Relative+'"/>\n'+


'<Life Min="' + ParticleLifeMin + '" Max="' + ParticleLifeMax + '"/>\n' +
'<Speed Min="' + SpeedMin + '" Max="' + SpeedMin + '"/>\n' +
'<RadialAccel Min="' + RadialAccelMin + '" Max="' + RadialAccelMax + '"/>\n' +
'<TangentialAccel Min="' + TangentialAccelMin + '" Max="' + TangentialAccelMax + '"/>\n' +

'<Size Start="' + SizeStart + '" End="' + SizeEnd + '" Var="' + SizeVar + '"/>\n' +
'<Rotation Start="' + SpinStart + '" End="' + SpinEnd + '" Var="' + SpinVar + '"/>\n' +

'<ColorVar value="' + ColorVar + '"/>\n' +
'<AlphaVar value="' + AlphaVar + '"/>\n' +

'<StartColor r="' + ColorStart.r + '" g="' + ColorStart.g + '" b="' + ColorStart.b + '" a="' + ColorStart.a + '"/>\n' +
'<ColorEnd r="' + ColorEnd.r + '" g="' + ColorEnd.g + '" b="' + ColorEnd.b + '" a="'+ColorEnd.a+'"/>\n' +

'</EmitterConfig>\n'+
'<!-- Converter by Luis Santos AKA DJOKER-->' ;
return result;

		}
    public  function parseInfoFromFile(info:String) 
	{
		var xml:Xml = Xml.parse (Assets.getText(info));

		
	
	
	   for (child in xml) 
		{
			if (Util.isValidElement(child)) 
			{
				for (data in child)
				{
					if (Util.isValidElement(data)) 
			        {
						if (data.nodeName == "Emission")
						{
							this.Emission=Std.parseInt(data.get("value"));
						}
						if (data.nodeName == "Lifetime")
						{
							this.Lifetime=Std.parseFloat(data.get("value"));
						}
						if (data.nodeName == "Direction")
						{
							this.Direction=Std.parseFloat(data.get("value"));
						}
						if (data.nodeName == "Spread")
						{
							this.Spread=Std.parseFloat(data.get("value"));
						}			
	                	if (data.nodeName == "Relative")
						{
							this.Relative=Std.parseInt(data.get("value"));
						}	
						if (data.nodeName == "Life")
						{
							this.ParticleLifeMin = Std.parseFloat(data.get("Min"));
							this.ParticleLifeMax=Std.parseFloat(data.get("Max"));
						}						
						if (data.nodeName == "Speed")
						{
							this.SpeedMin = Std.parseFloat(data.get("Min"));
							this.SpeedMax=Std.parseFloat(data.get("Max"));
						}	
						if (data.nodeName == "Gravity")
						{
							this.GravityMin = Std.parseFloat(data.get("Min"));
							this.GravityMax=Std.parseFloat(data.get("Max"));
						}		
						if (data.nodeName == "RadialAccel")
						{
							this.RadialAccelMin = Std.parseFloat(data.get("Min"));
							this.RadialAccelMax=Std.parseFloat(data.get("Max"));
						}			
						if (data.nodeName == "TangentialAccel")
						{
							this.TangentialAccelMin = Std.parseFloat(data.get("Min"));
							this.TangentialAccelMax=Std.parseFloat(data.get("Max"));
						}							
						if (data.nodeName == "Size")
						{
							this.SizeStart = Std.parseFloat(data.get("Start"));
							this.SizeEnd = Std.parseFloat(data.get("End"));
							this.SizeVar=Std.parseFloat(data.get("Var"));
						}	
						if (data.nodeName == "Rotation")
						{
							this.SpinStart = Std.parseFloat(data.get("Start"));
							this.SpinEnd = Std.parseFloat(data.get("End"));
							this.SpinVar=Std.parseFloat(data.get("Var"));
						}			
					   if (data.nodeName == "ColorVar")
						{
							this.ColorVar=Std.parseFloat(data.get("value"));
						}		
					   if (data.nodeName == "AlphaVar")
						{
							this.AlphaVar=Std.parseFloat(data.get("value"));
						}	
					   if (data.nodeName == "StartColor")
						{
							this.ColorStart.r = Std.parseFloat(data.get("r"));
							this.ColorStart.g = Std.parseFloat(data.get("g"));
							this.ColorStart.b = Std.parseFloat(data.get("b"));
							this.ColorStart.a =Std.parseFloat(data.get("a"));
						}			
					   if (data.nodeName == "EndColor")
						{
							this.ColorEnd.r = Std.parseFloat(data.get("r"));
							this.ColorEnd.g = Std.parseFloat(data.get("g"));
							this.ColorEnd.b = Std.parseFloat(data.get("b"));
							this.ColorEnd.a =Std.parseFloat(data.get("a"));
						}							
					}
				}
			}
		}
		/*
			trace("Emission "+Emission );
			trace("Lifetime "+Lifetime  );
			trace("ParticleLifeMin "+ParticleLifeMin  );
			trace("ParticleLifeMax "+ParticleLifeMax  );
			trace("Direction "+Direction );
			trace("Spread "+Spread );
			trace("Relative "+Relative );
			trace("SpeedMin "+SpeedMin  );
			trace("SpeedMax "+SpeedMax  );
			trace("GravityMin "+GravityMin  );
			trace("GravityMax"+GravityMax  );
			trace("radial min "+RadialAccelMin  );
			trace("radial max "+RadialAccelMax  );
			trace("Tangent Min "+TangentialAccelMin  );
			trace("Tangetn Max "+TangentialAccelMax  );
			trace("SizeStart "+SizeStart  );
			trace("SizeEnd "+SizeEnd  );
			trace("SizeVar "+SizeVar  );
			trace("SpinStart "+SpinStart  );
			trace("SpinEnd "+SpinEnd  );
			trace("SpinVar "+SpinVar  );
			trace("ColorVar "+ColorVar  );
			trace("AlphaVar "+AlphaVar  );
			
			trace("start color");
			trace(ColorStart.r );
			trace(ColorStart.g );
			trace(ColorStart.b );
			trace(ColorStart.a);
			
			trace("end color");
			trace(ColorEnd.r  );
			trace(ColorEnd.g );
			trace(ColorEnd.b );
			trace(ColorEnd.a);
			*/
	}
	 public  function parseInfoFromString(info:String) 
	{
		var xml:Xml = Xml.parse (info);

		
	
	
	   for (child in xml) 
		{
			if (Util.isValidElement(child)) 
			{
				for (data in child)
				{
					if (Util.isValidElement(data)) 
			        {
						if (data.nodeName == "Emission")
						{
							this.Emission=Std.parseInt(data.get("value"));
						}
						if (data.nodeName == "Lifetime")
						{
							this.Lifetime=Std.parseFloat(data.get("value"));
						}
						if (data.nodeName == "Direction")
						{
							this.Direction=Std.parseFloat(data.get("value"));
						}
						if (data.nodeName == "Spread")
						{
							this.Spread=Std.parseFloat(data.get("value"));
						}			
	                	if (data.nodeName == "Relative")
						{
							this.Relative=Std.parseInt(data.get("value"));
						}	
						if (data.nodeName == "Life")
						{
							this.ParticleLifeMin = Std.parseFloat(data.get("Min"));
							this.ParticleLifeMax=Std.parseFloat(data.get("Max"));
						}						
						if (data.nodeName == "Speed")
						{
							this.SpeedMin = Std.parseFloat(data.get("Min"));
							this.SpeedMax=Std.parseFloat(data.get("Max"));
						}	
						if (data.nodeName == "Gravity")
						{
							this.GravityMin = Std.parseFloat(data.get("Min"));
							this.GravityMax=Std.parseFloat(data.get("Max"));
						}		
						if (data.nodeName == "RadialAccel")
						{
							this.RadialAccelMin = Std.parseFloat(data.get("Min"));
							this.RadialAccelMax=Std.parseFloat(data.get("Max"));
						}			
						if (data.nodeName == "TangentialAccel")
						{
							this.TangentialAccelMin = Std.parseFloat(data.get("Min"));
							this.TangentialAccelMax=Std.parseFloat(data.get("Max"));
						}							
						if (data.nodeName == "Size")
						{
							this.SizeStart = Std.parseFloat(data.get("Start"));
							this.SizeEnd = Std.parseFloat(data.get("End"));
							this.SizeVar=Std.parseFloat(data.get("Var"));
						}	
						if (data.nodeName == "Rotation")
						{
							this.SpinStart = Std.parseFloat(data.get("Start"));
							this.SpinEnd = Std.parseFloat(data.get("End"));
							this.SpinVar=Std.parseFloat(data.get("Var"));
						}			
					   if (data.nodeName == "ColorVar")
						{
							this.ColorVar=Std.parseFloat(data.get("value"));
						}		
					   if (data.nodeName == "AlphaVar")
						{
							this.AlphaVar=Std.parseFloat(data.get("value"));
						}	
					   if (data.nodeName == "StartColor")
						{
							this.ColorStart.r = Std.parseFloat(data.get("r"));
							this.ColorStart.g = Std.parseFloat(data.get("g"));
							this.ColorStart.b = Std.parseFloat(data.get("b"));
							this.ColorStart.a =Std.parseFloat(data.get("a"));
						}			
					   if (data.nodeName == "EndColor")
						{
							this.ColorEnd.r = Std.parseFloat(data.get("r"));
							this.ColorEnd.g = Std.parseFloat(data.get("g"));
							this.ColorEnd.b = Std.parseFloat(data.get("b"));
							this.ColorEnd.a =Std.parseFloat(data.get("a"));
						}							
					}
				}
			}
		}
		/*
			trace("Emission "+Emission );
			trace("Lifetime "+Lifetime  );
			trace("ParticleLifeMin "+ParticleLifeMin  );
			trace("ParticleLifeMax "+ParticleLifeMax  );
			trace("Direction "+Direction );
			trace("Spread "+Spread );
			trace("Relative "+Relative );
			trace("SpeedMin "+SpeedMin  );
			trace("SpeedMax "+SpeedMax  );
			trace("GravityMin "+GravityMin  );
			trace("GravityMax"+GravityMax  );
			trace("radial min "+RadialAccelMin  );
			trace("radial max "+RadialAccelMax  );
			trace("Tangent Min "+TangentialAccelMin  );
			trace("Tangetn Max "+TangentialAccelMax  );
			trace("SizeStart "+SizeStart  );
			trace("SizeEnd "+SizeEnd  );
			trace("SizeVar "+SizeVar  );
			trace("SpinStart "+SpinStart  );
			trace("SpinEnd "+SpinEnd  );
			trace("SpinVar "+SpinVar  );
			trace("ColorVar "+ColorVar  );
			trace("AlphaVar "+AlphaVar  );
			
			trace("start color");
			trace(ColorStart.r );
			trace(ColorStart.g );
			trace(ColorStart.b );
			trace(ColorStart.a);
			
			trace("end color");
			trace(ColorEnd.r  );
			trace(ColorEnd.g );
			trace(ColorEnd.b );
			trace(ColorEnd.a);
			*/
	}
	public  function loadInfoFromFile(info:String) 
	{
			var bytes:ByteArray =	Assets.getBytes(info);
			bytes.endian = Endian.LITTLE_ENDIAN;
			
			   this.Frame = bytes.readInt() & 0xFFFF;
			   this.Blend = this.Frame >> 16;
			   
			   this.Emission = bytes.readInt();
			   this.Lifetime = bytes.readFloat();
			   this.ParticleLifeMin = bytes.readFloat();
			   this.ParticleLifeMax = bytes.readFloat();
			   this.Direction =  bytes.readFloat();// * 180 / 3.14159265358979323846;
			   this.Spread =  bytes.readFloat();// * 180 / 3.14159265358979323846;
			   this.Relative =  bytes.readInt();
			   
			   this.SpeedMin = bytes.readFloat();
			   this.SpeedMax = bytes.readFloat();
			   this.GravityMin = bytes.readFloat();
			   this.GravityMax = bytes.readFloat();
			   this.RadialAccelMin = bytes.readFloat();
			   this.RadialAccelMax = bytes.readFloat();
			   this.TangentialAccelMin = bytes.readFloat();
			   this.TangentialAccelMax = bytes.readFloat();
			   this.SizeStart = bytes.readFloat();
			   this.SizeEnd = bytes.readFloat();
			   this.SizeVar = bytes.readFloat();
		       this.SpinStart = bytes.readFloat();
			   this.SpinEnd = bytes.readFloat();
			   this.SpinVar = bytes.readFloat();

			   
			   this.ColorStart.r = bytes.readFloat();
			   this.ColorStart.g = bytes.readFloat();
			   this.ColorStart.b = bytes.readFloat();
			   this.ColorStart.a =bytes.readFloat();
		
			   
			   this.ColorEnd.r = bytes.readFloat();
			   this.ColorEnd.g = bytes.readFloat();
			   this.ColorEnd.b = bytes.readFloat();
			   this.ColorEnd.a = bytes.readFloat();
			   
	

			   
			   this.ColorVar = bytes.readFloat();
			   this.AlphaVar = bytes.readFloat();

			//trace(Emission );		
			   bytes = null;
			   /*
			trace(Frame);   
			trace(Blend);  
			
			trace("Emission "+Emission );
			trace("Lifetime "+Lifetime  );
			trace("ParticleLifeMin "+ParticleLifeMin  );
			trace("ParticleLifeMax "+ParticleLifeMax  );
			trace("Direction "+Direction );
			trace("Spread "+Spread );
			trace("Relative "+Relative );
			trace("SpeedMin "+SpeedMin  );
			trace("SpeedMax "+SpeedMax  );
			trace("GravityMin "+GravityMin  );
			trace("GravityMax"+GravityMax  );
			trace("radial min "+RadialAccelMin  );
			trace("radial max "+RadialAccelMax  );
			trace("Tangent Min "+TangentialAccelMin  );
			trace("Tangetn Max "+TangentialAccelMax  );
			trace("SizeStart "+SizeStart  );
			trace("SizeEnd "+SizeEnd  );
			trace("SizeVar "+SizeVar  );
			trace("SpinStart "+SpinStart  );
			trace("SpinEnd "+SpinEnd  );
			trace("SpinVar "+SpinVar  );
			trace("ColorVar "+ColorVar  );
			trace("AlphaVar "+AlphaVar  );
			
			trace("start color");
			trace(ColorStart.r );
			trace(ColorStart.g );
			trace(ColorStart.b );
			trace(ColorStart.a);
			
			trace("end color");
			trace(ColorEnd.r  );
			trace(ColorEnd.g );
			trace(ColorEnd.b );
			trace(ColorEnd.a);
			
*/
			
			   
		
	}
	public  function loadInfoFromBytes(bytes:ByteArray) 
	{
		   	bytes.endian = Endian.LITTLE_ENDIAN;
			
			   this.Frame = bytes.readInt() & 0xFFFF;
			   this.Blend = this.Frame >> 16;
			   
			   this.Emission = bytes.readInt();
			   this.Lifetime = bytes.readFloat();
			   this.ParticleLifeMin = bytes.readFloat();
			   this.ParticleLifeMax = bytes.readFloat();
			   this.Direction =  bytes.readFloat();// * 180 / 3.14159265358979323846;
			   this.Spread =  bytes.readFloat();// * 180 / 3.14159265358979323846;
			   this.Relative =  bytes.readInt();
			   
			   this.SpeedMin = bytes.readFloat();
			   this.SpeedMax = bytes.readFloat();
			   this.GravityMin = bytes.readFloat();
			   this.GravityMax = bytes.readFloat();
			   this.RadialAccelMin = bytes.readFloat();
			   this.RadialAccelMax = bytes.readFloat();
			   this.TangentialAccelMin = bytes.readFloat();
			   this.TangentialAccelMax = bytes.readFloat();
			   this.SizeStart = bytes.readFloat();
			   this.SizeEnd = bytes.readFloat();
			   this.SizeVar = bytes.readFloat();
		       this.SpinStart = bytes.readFloat();
			   this.SpinEnd = bytes.readFloat();
			   this.SpinVar = bytes.readFloat();

			   
			   this.ColorStart.r = bytes.readFloat();
			   this.ColorStart.g = bytes.readFloat();
			   this.ColorStart.b = bytes.readFloat();
			   this.ColorStart.a =bytes.readFloat();
		
			   
			   this.ColorEnd.r = bytes.readFloat();
			   this.ColorEnd.g = bytes.readFloat();
			   this.ColorEnd.b = bytes.readFloat();
			   this.ColorEnd.a = bytes.readFloat();
			   
	

			   
			   this.ColorVar = bytes.readFloat();
			   this.AlphaVar = bytes.readFloat();

			//trace(Emission );		
			   bytes = null;
			   /*
			trace(Frame);   
			trace(Blend);  
			
			trace("Emission "+Emission );
			trace("Lifetime "+Lifetime  );
			trace("ParticleLifeMin "+ParticleLifeMin  );
			trace("ParticleLifeMax "+ParticleLifeMax  );
			trace("Direction "+Direction );
			trace("Spread "+Spread );
			trace("Relative "+Relative );
			trace("SpeedMin "+SpeedMin  );
			trace("SpeedMax "+SpeedMax  );
			trace("GravityMin "+GravityMin  );
			trace("GravityMax"+GravityMax  );
			trace("radial min "+RadialAccelMin  );
			trace("radial max "+RadialAccelMax  );
			trace("Tangent Min "+TangentialAccelMin  );
			trace("Tangetn Max "+TangentialAccelMax  );
			trace("SizeStart "+SizeStart  );
			trace("SizeEnd "+SizeEnd  );
			trace("SizeVar "+SizeVar  );
			trace("SpinStart "+SpinStart  );
			trace("SpinEnd "+SpinEnd  );
			trace("SpinVar "+SpinVar  );
			trace("ColorVar "+ColorVar  );
			trace("AlphaVar "+AlphaVar  );
			
			trace("start color");
			trace(ColorStart.r );
			trace(ColorStart.g );
			trace(ColorStart.b );
			trace(ColorStart.a);
			
			trace("end color");
			trace(ColorEnd.r  );
			trace(ColorEnd.g );
			trace(ColorEnd.b );
			trace(ColorEnd.a);
			
*/
			
			   
		
	}	
		

		public inline function Smoke():Void
		{
Emission=40;
Lifetime=-1.000;
ParticleLifeMin=1.056;
ParticleLifeMax=8.008;

Direction = 0;

Spread=0.4;
Relative = 0;

SpeedMin=25;
SpeedMax=40;


GravityMin=0.000;
GravityMax = 0.000;

RadialAccelMin=0;
RadialAccelMax = 0;

TangentialAccelMin=0;
TangentialAccelMax=0;

SizeStart=0.192;
SizeEnd=4.4;
SizeVar=0.4;

SpinStart=0;
SpinEnd=0;
SpinVar = 0;

ColorVar=0.02;
AlphaVar=0;
ColorStart.r=0.8;
ColorStart.g=0.8;
ColorStart.b = 0.8;
ColorStart.a=0.5;
ColorEnd.r=1;
ColorEnd.g=1;
ColorEnd.b=1;
ColorEnd.a=0;
		
		}
	public inline function Snow():Void
		{
Emission=10;
Lifetime=-1.000;
ParticleLifeMin=3.0;
ParticleLifeMax=5.0;

Direction = 0;

Spread=40;
Relative = 0;

SpeedMin=-25;
SpeedMax=-40;


GravityMin=5.5;
GravityMax=10.000;

RadialAccelMin=0;
RadialAccelMax = 1;

TangentialAccelMin=0;
TangentialAccelMax=1;

SizeStart=1;
SizeEnd=0.5;
SizeVar=0.0;

SpinStart=0;
SpinEnd=0;
SpinVar = 0;

ColorVar=0;
AlphaVar=0;
ColorStart.r=1;
ColorStart.g=1;
ColorStart.b=1;
ColorStart.a=1;

ColorEnd.r=1;
ColorEnd.g=1;
ColorEnd.b=1;
ColorEnd.a=0;
		
		}
		
		public inline function Fontain():Void		
		{
Emission=138;
Lifetime=-1.000;
ParticleLifeMin=0.476;
ParticleLifeMax=1.032;
Direction=0.000;
Spread=0.675;
Relative = 0;
SpeedMin=300.000;
SpeedMax = 300.000;
GravityMin=428.571;
GravityMax = 728.571;
RadialAccelMin=-0.794;
RadialAccelMax=-0.794;
TangentialAccelMin=-0.159;
TangentialAccelMax=-0.159;
SizeStart=1.676;
SizeEnd=0.154;
SizeVar=0.444;
SpinStart=-50.000;
SpinEnd=8.730;
SpinVar=0.063;
ColorVar=0.413;
AlphaVar=0.413;
ColorStart.r=0.944;
ColorStart.g=0.183;
ColorStart.b=0.095;
ColorStart.a=0.611;
ColorEnd.r=1.000;
ColorEnd.g=0.802;
ColorEnd.b=0.071;
ColorEnd.a=0.119;
		}
		public inline function Fire():Void
		{
Emission=67;
Lifetime=-1.000;
ParticleLifeMin=1.071;
ParticleLifeMax=1.944;
Direction=0.000;
Spread=1.181;
Relative = 0;
SpeedMin=114.286;
SpeedMax = 190.476;
GravityMin=0.000;
GravityMax = 0.000;
RadialAccelMin=0.000;
RadialAccelMax=0.000;
TangentialAccelMin=0.000;
TangentialAccelMax=0.000;
SizeStart=1.529;
SizeEnd=2.511;
SizeVar=0.278;
SpinStart=0.000;
SpinEnd=0.000;
SpinVar=0.000;
ColorVar=0.000;
AlphaVar=0.000;
ColorStart.r=1.000;
ColorStart.g=0.738;
ColorStart.b=0.000;
ColorStart.a=0.905;
ColorEnd.r=0.571;
ColorEnd.g=0.000;
ColorEnd.b=0.246;
ColorEnd.a=0.056;
			
		}
		
		
	

}