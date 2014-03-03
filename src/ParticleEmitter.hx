package ;

import com.asliceofcrazypie.flash.TilesheetStage3D;
import flash.display3D.Context3DRenderMode;


import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.BlendMode;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.utils.ByteArray;
import flash.utils.Endian;
import openfl.display.Tilesheet;
import flash.Lib;
import openfl.Assets;
import haxe.xml.Fast;
import flash.geom.Point;





	/**
	 * ...
	 * @author djoker
	 */
	


   class ParticleEmitter extends Sprite

	{
		
	
     private var MAXP:Float   =300;
	 private var M_PI:Float   = 3.14159265358979323846;
     private var M_PI_2:Float = 1.57079632679489661923;
  
	public var FAge: Float;
    private var FEmissionResidue: Float;
    private var FPrevLocation: Point;
    private var FLocation: Point;
    private var FTX:Float;
	private var FTY: Float;
    private var spaw:Int;
	public var FInfo:ParticleSystemInfo;
	private var usetexture:BitmapData;
	
	private var Accel:Point;
	private var Accel2:Point;
	private var V:Point;
 
	public var nParticlesAlive:Int;


	private var tilesheet:TilesheetStage3D;
	
	private var Time:Int = 0;
	private var LastEmitTime:Int = 0;
	private var bitmap:Bitmap;

	var particleMatrix:Matrix;
	
	   var colors:ColorTransform;
	   var buffer:BitmapData;
	public var FParticles:Array<MParticle>;
 private var _x:Float;
 private var _y:Float;
 private var _width:Float;
 private var _height:Float;
 private var _originX:Float;
 private var _originY:Float;
 private var _scaleX:Float = 1;
 private var _scaleY:Float = 1;
 private var _scale:Float = 1;
 private var _angle:Float = 0;

	
		
		public  function new(texture:BitmapData) 
		{
			super();
			
		var bmp:BitmapData = Assets.getBitmapData( 'assets/fire_particle.png' ).clone();
		var rect:Rectangle = bmp.rect.clone();
		bmp = TilesheetStage3D.fixTextureSize( bmp, true );
		var center:Point = new Point( rect.width * 0.5, rect.height * 0.5 );
		tilesheet = new TilesheetStage3D( bmp );
		tilesheet.addTileRect( rect, center );
		
			FEmissionResidue = 0;
			usetexture = texture;
		
			
			  _width =texture.width;
              _height=texture.height;
 
			FParticles = [];
		
			FPrevLocation = new Point();
			FLocation = new Point(0, 0);
			
			 Accel= new Point();
	         Accel2= new Point();
             V= new Point();
			  FAge = -2;
              spaw=0;
			  nParticlesAlive=0;
			FInfo = new ParticleSystemInfo();
			particleMatrix = new Matrix();
			colors = new ColorTransform(1, 1, 1, 1);

			  _originX = _width / 2;
               _originY = _height / 2;
			   
		    buffer = new BitmapData(800,640);
 			 bitmap = new Bitmap(buffer);
			//  addChild(bitmap);
			
		}
		
	public  function loadInfo(info:ParticleSystemInfo) 
	{
		FInfo = null;
		this.FInfo = info;
	}
	public  function loadInfoFromFile(info:String) 
	{
		FInfo = new ParticleSystemInfo();
		FInfo.loadInfoFromFile(info);
	
	}
	public  function parceInfoFromFile(info:String) 
	{
		FInfo = new ParticleSystemInfo();
		FInfo.parseInfoFromFile(info);
	
	}
		
  
	
public  function createFire() 
	{
		FInfo = null;
		FInfo = new ParticleSystemInfo();
		FInfo.Fire();
	}	
public  function createFontain() 
	{
		FInfo = null;
		FInfo = new ParticleSystemInfo();
		FInfo.Fontain();
	}	
		
		
public  function Fire():Void
    {
         if (FInfo.Lifetime == -1) 
           FAge = -1;
            else
           FAge = 0;
   }
public  function  FireAt( X:Float, Y: Float):Void
{
  Stop();
  MoveTo(X,Y);
  Fire();
}

public  function Stop(KillParticles: Bool=false):Void
{
  FAge = -2;
  if (KillParticles) nParticlesAlive = 0;
}

public inline function removeParticle(entity:MParticle):Void 
{
		FParticles.remove(entity);
		nParticlesAlive--;
}

public inline function MoveTo( X:Float, Y:Float, MoveParticles: Bool=false):Void
{
  var I:Int;
  var DX:Float;
  var DY:Float;

  if (MoveParticles) 
  {
    DX = X - FLocation.x;
    DY = Y - FLocation.y;
    for (I in 0... nParticlesAlive)
	{
      FParticles[I].Location.x = FParticles[I].Location.x + DX;
      FParticles[I].Location.y = FParticles[I].Location.y + DY;
    }
    FPrevLocation.x = FPrevLocation.x + DX;
    FPrevLocation.y = FPrevLocation.y + DY;
  } else 
  {
    if (FAge == -2) 
	{
      FPrevLocation.x = X;
      FPrevLocation.y = Y;
    } else 
	{
      FPrevLocation.x = FLocation.x;
      FPrevLocation.y = FLocation.y;
    }
  }
  FLocation.x = X;
  FLocation.y = Y;
}


 public  function update(dt:Float)
{
		  
	  if (FAge >= 0) 
      {
        FAge = FAge + dt;
        if (FAge >= FInfo.Lifetime) 
        FAge = -2;
	  }
	  
	    move(dt);
	  
	    if (FAge != -2) 
		{
   
  
		 
		    var  ParticlesNeeded:Float  =FInfo.Emission * dt + FEmissionResidue;
            var  ParticlesCreated:Int =Std.int( ParticlesNeeded);	
             FEmissionResidue = ParticlesNeeded - ParticlesCreated;
      	 
			// trace(ParticlesCreated + '<>', ParticlesNeeded + '<>' + FEmissionResidue);

	
			 
		    for (I in 0... ParticlesCreated)
            {
			      if (FParticles.length >= MAXP) break ;
				  var Par: MParticle = new MParticle();
				  reset(Par);
			      FParticles.push(Par);
			      nParticlesAlive++;
			}
			
			
		    }
		FPrevLocation = FLocation;
		}
		
		private  function reset(Par:MParticle):Void
		{
		var Ang:Float;	
	    Par.Age = 0;
        Par.TerminalAge = Util.randf(FInfo.ParticleLifeMin,FInfo.ParticleLifeMax);
        Par.Location.x = FPrevLocation.x + (FLocation.x - FPrevLocation.x)* Util.randf(0.0,1.0);
        Par.Location.y = FPrevLocation.y + (FLocation.y - FPrevLocation.y)*  Util.randf(0.0,1.0);
        Par.Location.x = Par.Location.x +  Util.randf(-2.0,2.0);
        Par.Location.y = Par.Location.y +  Util.randf(-2.0,2.0);
        
		
		
		Ang = FInfo.Direction -M_PI_2 +Util.randf(0, FInfo.Spread) - FInfo.Spread / 2;

		
        if (FInfo.Relative==1) 
        {
           V.x = FPrevLocation.x - FLocation.x;
           V.y = FPrevLocation.y - FLocation.y;
           Ang = Ang + (Util.VectorAnglTan(V) + M_PI_2);
        }
      Par.Velocity.x = Math.cos(Ang);
      Par.Velocity.y = Math.sin(Ang);
      Par.Velocity.x=Par.Velocity.x*Util.randf(FInfo.SpeedMin,FInfo.SpeedMax);
      Par.Velocity.y=Par.Velocity.y*Util.randf(FInfo.SpeedMin,FInfo.SpeedMax);


      Par.Gravity = Util.randf(FInfo.GravityMin,FInfo.GravityMax);
      Par.RadialAccel =Util.randf(FInfo.RadialAccelMin,FInfo.RadialAccelMax);
      Par.TangentialAccel = Util.randf(FInfo.TangentialAccelMin,FInfo.TangentialAccelMax);

      Par.Size = Util.randf(FInfo.SizeStart,FInfo.SizeStart+ (FInfo.SizeEnd - FInfo.SizeStart) * FInfo.SizeVar);
      Par.SizeDelta = (FInfo.SizeEnd - Par.Size) / Par.TerminalAge;

      Par.Spin = Util.randf(FInfo.SpinStart,FInfo.SpinStart+ (FInfo.SpinEnd - FInfo.SpinStart) * FInfo.SpinVar);
      Par.SpinDelta  = (FInfo.SpinEnd - Par.Spin) / Par.TerminalAge;
			

      Par.Color.r = Util.randf(FInfo.ColorStart.r,FInfo.ColorStart.r+ (FInfo.ColorEnd.r - FInfo.ColorStart.r) * FInfo.ColorVar);
      Par.Color.g = Util.randf(FInfo.ColorStart.g,FInfo.ColorStart.g+ (FInfo.ColorEnd.g - FInfo.ColorStart.g) * FInfo.ColorVar);
      Par.Color.b = Util.randf(FInfo.ColorStart.b,FInfo.ColorStart.b+ (FInfo.ColorEnd.b - FInfo.ColorStart.b) * FInfo.ColorVar);
      Par.Color.a = Util.randf(FInfo.ColorStart.a,FInfo.ColorStart.a+ (FInfo.ColorEnd.a - FInfo.ColorStart.a) * FInfo.ColorVar);

      Par.ColorDelta.r = (FInfo.ColorEnd.r - Par.Color.r) / Par.TerminalAge;
      Par.ColorDelta.g = (FInfo.ColorEnd.g - Par.Color.g) / Par.TerminalAge;
      Par.ColorDelta.b = (FInfo.ColorEnd.b - Par.Color.b) / Par.TerminalAge;
      Par.ColorDelta.a = (FInfo.ColorEnd.a - Par.Color.a) / Par.TerminalAge;
	 
	}
		
	
private  function move( dt: Float):Void
{
	// buffer.fillRect(buffer.rect, 0);
	// buffer.lock(); 
	  var data = new Array<Float>();
      var flags:Int = Tilesheet.TILE_SCALE | Tilesheet.TILE_ROTATION | Tilesheet.TILE_RGB | Tilesheet.TILE_ALPHA;

	  
		
	  
	  var Ang:Float;
	  var I:Int=0;
		  
	 if (FParticles.length <= 0) return;
	  
	 while (I<nParticlesAlive)
	 {
	  var Par:MParticle = FParticles[I];
	  Par.Age = Par.Age + dt;
	
         if (Par.Age >= Par.TerminalAge  || Par.Color.a < 0.0 || Par.Size<0.1)  
             {
			  	removeParticle(Par);
			    continue;
	         }			

    Accel.x = Par.Location.x - FLocation.x;
    Accel.y = Par.Location.y - FLocation.y;




    Accel=Util.VectorNormalize(Accel);
    Accel2 = Accel;
    Accel.x=Accel.x*Par.RadialAccel;
    Accel.y=Accel.y*Par.RadialAccel;


    Ang = Accel2.x;
    Accel2.x = -Accel2.y;
    Accel2.y = Ang;




    Accel2.x=Accel2.x*Par.TangentialAccel;
    Accel2.y=Accel2.y*Par.TangentialAccel;

    Par.Velocity.x=Par.Velocity.x+(Accel.x + Accel2.x) * dt;
    Par.Velocity.y=Par.Velocity.y+(Accel.y + Accel2.y) * dt;

    Par.Velocity.y = Par.Velocity.y + (Par.Gravity * dt);

    Par.Location.x=Par.Location.x+(Par.Velocity.x * dt);
    Par.Location.y=Par.Location.y+(Par.Velocity.y * dt);


    Par.Spin = Par.Spin + (Par.SpinDelta * dt);
    Par.Size  = Par.Size + (Par.SizeDelta * dt);
		

    Par.Color.r = Par.Color.r     + (Par.ColorDelta.r * dt);
    Par.Color.g = Par.Color.g + (Par.ColorDelta.g * dt);
    Par.Color.b = Par.Color.b   + (Par.ColorDelta.b * dt);
    Par.Color.a = Par.Color.a + (Par.ColorDelta.a * dt);
	
	  data.push(Par.Location.x);
      data.push(Par.Location.y);
      data.push(0);
	  
      data.push(Par.Size);
      data.push( Par.Spin);
      data.push(Par.Color.r);
      data.push(Par.Color.g);
      data.push(Par.Color.b);
      data.push(Par.Color.a);
	
	
	/*

_angle =Par.Age* Par.Spin;
particleMatrix.b = particleMatrix.c = 0;
particleMatrix.a = _scaleX * Par.Size;
particleMatrix.d = _scaleY * Par.Size;
particleMatrix.tx = -_originX * particleMatrix.a;
particleMatrix.ty = -_originY * particleMatrix.d;
if (_angle != 0) particleMatrix.rotate(_angle);
particleMatrix.tx += _originX * _scaleX * Par.Size + Par.Location.x;
particleMatrix.ty += _originY * _scaleX * Par.Size + Par.Location.y;

		
	 colors.redMultiplier = Par.Color.r;
	 colors.greenMultiplier = Par.Color.g;
	 colors.blueMultiplier = Par.Color.b;
	 colors.alphaMultiplier = Par.Color.a;

	buffer.draw(usetexture, particleMatrix, colors, BlendMode.NORMAL);// , usetexture.rect, true);
		*/
   
	
   I++;
		  
  }
  


//buffer.unlock();

 TilesheetStage3D.clearGraphic(graphics);
 tilesheet.drawTiles( graphics, data, true, flags );
		
}
	
    public var angle(get_angle, set_angle):Float;
	private inline function get_angle():Float
	{return FInfo.Direction;}
	private inline function set_angle(value:Float):Float
	{FInfo.Direction = value; return FInfo.Direction; }	
	
	public var spread(get_spread, set_spread):Float;
	private inline function get_spread():Float
	{return FInfo.Spread;}
	private inline function set_spread(value:Float):Float
	{FInfo.Spread = value; return FInfo.Spread; }	
	
	
	

}