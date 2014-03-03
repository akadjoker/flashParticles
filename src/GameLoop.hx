package ;

import flash.ui.Multitouch;
import flash.ui.MultitouchInputMode;
import flash.utils.ByteArray;

import flash.net.FileFilter;
import flash.net.FileReference;
	
import flash.text.TextField;
import flash.text.TextFormat;

import flash.Lib;
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.events.Event;
import flash.events.MouseEvent;

import openfl.display.Tilesheet;
import openfl.Assets;

import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.controls.Slider;
import haxe.ui.toolkit.controls.HSlider;
import haxe.ui.toolkit.controls.VSlider;
import haxe.ui.toolkit.controls.HScroll;
import haxe.ui.toolkit.controls.VScroll;
import haxe.ui.toolkit.controls.CheckBox;
import haxe.ui.toolkit.controls.Text;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.events.UIEvent;
import haxe.ui.toolkit.core.Macros;

import com.asliceofcrazypie.flash.TilesheetStage3D;
import flash.display3D.Context3DRenderMode;

/**
 * ...
 * @author djoker
 */
class GameLoop extends Sprite
{
	 private  var M_PI:Float   = 3.14159265358979323846;
     private  var M_PI_2:Float = 1.57079632679489661923;
	
	
   var pmanager:ParticleEmitter;
   var uiroot:Root;
   var lifeSlider:HScroll;
   var emissionSlider:HScroll;	
   var angleSlider:HScroll;	
   var spreadSlider:HScroll;	
   
   var siseStartSlider:HScroll;
   var siseEndSlider:HScroll;
   var siseVarSlider:HScroll;
   
   var spinStartSlider:HScroll;
   var spinEndSlider:HScroll;
   var spinVarSlider:HScroll;
   
   var gravityMinSlider:HScroll;
   var gravityMaxSlider:HScroll;
   
   var radialMinSlider:HScroll;
   var radialMaxSlider:HScroll;

   var tanMinSlider:HScroll;
   var tanMaxSlider:HScroll;
   
   var colorVarSlider:HScroll;
   var alphaVarSlider:HScroll;
   
   
   var   SpeedMin:HScroll;
   var   SpeedMax:HScroll;
   
   var   ColorStartR:HScroll;
   var   ColorStartG:HScroll;
   var   ColorStartB:HScroll;
   var   ColorStartA:HScroll;
   
   var   ColorEndR:HScroll;
   var   ColorEndG:HScroll;
   var   ColorEndB:HScroll;
   var   ColorEndA:HScroll;
   
      
   var lifeLoop:CheckBox;
   var continuous:CheckBox;
   
	
	public var deltaTime:Float;
    private var prevFrame:Int;
    private var nextFrame:Int; 
	
	var texwidth:Float;
	var texheight:Float;
	
	var 	screenWidth:Float;
	var  screenHeight:Float;
	   
	var caption :TextField;  
		
	var downloader:FileReference;
	
	
	
   public function addHScrol(x:Float, y:Float, w:Float, h:Float, min:Float, max:Float,def:Float,caption:String="label"):HScroll
   {
	   var sl:HScroll = new HScroll();
	   	     sl.x = x;
			 sl.y = y;
			 sl.width = w;
			 sl.height = h;
			 sl.min = min;
			 sl.max = max;
			 sl.pos = def;
			 
			 
			 var lb:Text = new Text();
			 lb.x = x;
			 lb.y = y+h-1;
			 lb.text = caption;
		     lb.disabled = true;
		
			 lb.inlineStyle.color = 0xffffff;
			 uiroot.addChild(lb);
			 uiroot.addChild(sl);
			 return sl;
	   
   }   
    public function loadDefaults()
   {
	      emissionSlider.pos = pmanager.FInfo.Emission;
		lifeSlider.pos = pmanager.FInfo.Lifetime;
		angleSlider.pos=pmanager.FInfo.Direction;
		spreadSlider.pos=pmanager.FInfo.Spread ;
		
		siseStartSlider.pos=pmanager.FInfo.SizeStart*texwidth;
		siseEndSlider.pos=pmanager.FInfo.SizeEnd*texheight;
		siseVarSlider.pos=pmanager.FInfo.SizeVar*255.0 ;
	
		
		spinStartSlider.pos=pmanager.FInfo.SpinStart;
		spinEndSlider.pos=pmanager.FInfo.SpinEnd;
		spinVarSlider.pos = pmanager.FInfo.SpinVar ;
		
		
		gravityMinSlider.pos=pmanager.FInfo.GravityMin ;
		gravityMaxSlider.pos=pmanager.FInfo.GravityMax ;
		
		radialMinSlider.pos=pmanager.FInfo.RadialAccelMin ;
		radialMaxSlider.pos = pmanager.FInfo.RadialAccelMax ;
		
		tanMinSlider.pos=pmanager.FInfo.TangentialAccelMin ;
		tanMaxSlider.pos = pmanager.FInfo.TangentialAccelMax;
		

		SpeedMin.pos=pmanager.FInfo.SpeedMin ;
		SpeedMax.pos = pmanager.FInfo.SpeedMax ;
		
		colorVarSlider.pos=pmanager.FInfo.ColorVar*255.0 ;
		alphaVarSlider.pos = pmanager.FInfo.AlphaVar*255.0;
		
		 
		ColorStartR.pos = pmanager.FInfo.ColorStart.r * 255.0;
		ColorStartG.pos = pmanager.FInfo.ColorStart.g * 255.0;
		ColorStartB.pos = pmanager.FInfo.ColorStart.b * 255.0;
		ColorStartA.pos = pmanager.FInfo.ColorStart.a * 255.0;
		
		ColorEndR.pos = pmanager.FInfo.ColorEnd.r * 255.0;
		ColorEndG.pos = pmanager.FInfo.ColorEnd.g * 255.0;
		ColorEndB.pos = pmanager.FInfo.ColorEnd.b * 255.0;
		ColorEndA.pos = pmanager.FInfo.ColorEnd.a * 255.0;
   }
   
	public function new() 
	{
		super();
		prevFrame = Lib.getTimer();
	   // addEventListener( Event.ADDED_TO_STAGE, addedToGame );
	   TilesheetStage3D.init(Lib.current.stage, 0, 5, engineReady, Context3DRenderMode.AUTO);
	}
   
	 private function engineReady( result:String = '' ):Void
	{
		gameLoad();
		addEventListener (MouseEvent.MOUSE_DOWN, onMouseDown);
		stage.addEventListener (MouseEvent.MOUSE_UP, onMouseUp);
  	    addEventListener( Event.ENTER_FRAME, enterFrame );
		
		downloader = new FileReference();	
		trace(result);
	}
	public function addedToGame(e:Event):Void
	{
		  
		gameLoad();
		removeEventListener( Event.ADDED_TO_STAGE, addedToGame );
		addEventListener (MouseEvent.MOUSE_DOWN, onMouseDown);
		stage.addEventListener (MouseEvent.MOUSE_UP, onMouseUp);
  	    addEventListener( Event.ENTER_FRAME, enterFrame );
		
		downloader = new FileReference();
		
		
	}
	
	private function onMouseDown (event:MouseEvent):Void 
	{
		
	if (continuous.selected)
	{
	 pmanager.FireAt(event.localX,event.localY);
	} else
	{
    pmanager.FireAt(screenWidth / 2, screenHeight / 2);
	}
		// pmanager.FAge = 0;

		
		
	}
	private function onMouseUp (event:MouseEvent):Void 
	{
	
	}
		
			
	public function enterFrame(e:Event):Void
   {
	 
	   
	nextFrame = Lib.getTimer();
	deltaTime = (nextFrame - prevFrame) * 0.001;
    gameLoop(deltaTime);
    prevFrame = nextFrame;

   }
   
   //*************************************************
   private function gameLoad():Void
   {
	   var bitmap:BitmapData = Assets.getBitmapData("assets/fire_particle.png");
	   
	    texwidth = bitmap.width;
	    texheight = bitmap.height;
	
	   pmanager = new ParticleEmitter(bitmap);
	   pmanager.createFontain();
	   pmanager.FireAt(stage.stageWidth / 2, stage.stageHeight / 2);
	   trace(stage.stageWidth / 2 + '<' + stage.stageHeight / 2);
	   screenWidth = stage.stageWidth;
	   screenHeight = stage.stageHeight;
	   
	   addChild(pmanager);
	   
	   creteGui();
	   loadDefaults();
   }
   private function gameLoop(dt:Float):Void
   {
	   pmanager.FInfo.Emission = Std.int( emissionSlider.pos);
		pmanager.FInfo.Lifetime = lifeSlider.pos;
		pmanager.FInfo.Direction = angleSlider.pos;
		pmanager.FInfo.Spread = spreadSlider.pos;
		
		pmanager.FInfo.SizeStart = siseStartSlider.pos/texwidth;
		pmanager.FInfo.SizeEnd = siseEndSlider.pos/texheight;
		pmanager.FInfo.SizeVar = siseVarSlider.pos/255.0;
		
		pmanager.FInfo.SpinStart = spinStartSlider.pos;
		pmanager.FInfo.SpinEnd = spinEndSlider.pos;
		pmanager.FInfo.SpinVar = spinVarSlider.pos;
		
		
		pmanager.FInfo.GravityMin = gravityMinSlider.pos;
		pmanager.FInfo.GravityMax = gravityMaxSlider.pos;
		
		pmanager.FInfo.RadialAccelMin = radialMinSlider.pos;
		pmanager.FInfo.RadialAccelMax = radialMaxSlider.pos;
		
		pmanager.FInfo.TangentialAccelMin =tanMinSlider.pos/100;
		pmanager.FInfo.TangentialAccelMax= tanMaxSlider.pos/100;

		pmanager.FInfo.SpeedMin = SpeedMin.pos;
		pmanager.FInfo.SpeedMax = SpeedMax.pos;
		
		
		 pmanager.FInfo.ColorVar=colorVarSlider.pos/255.0 ;
		 pmanager.FInfo.AlphaVar = alphaVarSlider.pos / 255.0;
		 
		 pmanager.FInfo.ColorStart.r = ColorStartR.pos / 255.0;
		 pmanager.FInfo.ColorStart.g = ColorStartG.pos / 255.0;
		 pmanager.FInfo.ColorStart.b = ColorStartB.pos / 255.0;
		 pmanager.FInfo.ColorStart.a = ColorStartA.pos / 255.0;
		 
		pmanager.FInfo.ColorEnd.r = ColorEndR.pos / 255.0;
		pmanager.FInfo.ColorEnd.g = ColorEndG.pos / 255.0;
		pmanager.FInfo.ColorEnd.b = ColorEndB.pos / 255.0;
		pmanager.FInfo.ColorEnd.a = ColorEndA.pos / 255.0;
		
		
		

    if (lifeLoop.selected==true) 
	{
		pmanager.FAge = -1;

	} 
		
	   	    pmanager.update(dt);
		    caption.text = "Particles Alive:"+pmanager.nParticlesAlive;
   }
   
   private function creteGui():Void
   {
	   	Macros.addStyleSheet("assets/styles/gradient/gradient.css");
		
        Toolkit.init();
        Toolkit.openFullscreen(function(root:Root) 
		{
         uiroot = root;
        });
		
		var h:Float = 8;
	
//lifetime

var posy:Float = 40;
			lifeSlider    = addHScrol(10, posy, 149, 8, -1, 50, 1, 'Life');
			continuous = new CheckBox();
			continuous.x= screenWidth-150;
			continuous.y= screenHeight-20;
			uiroot.addChild(continuous);
			continuous.selected = false;
			
			 var lb:Text = new Text();
			 lb.x = 0;
			 lb.y = 0;
			 lb.text = 'Move by Mouse';
			 lb.inlineStyle.color = 0xffffff;
			 continuous.addChild(lb);

			 lifeLoop = new CheckBox();
			lifeLoop.x= screenWidth-150;
			lifeLoop.y= screenHeight-50;
			uiroot.addChild(lifeLoop);
			lifeLoop.selected = true;
			
			 var lb:Text = new Text();
			 lb.x = 0;
			 lb.y = 0;
			 lb.text = 'Life Loop';
			 lb.inlineStyle.color = 0xffffff;
			 lifeLoop.addChild(lb);
			   
			   posy += 24;
			   emissionSlider=addHScrol(10, posy, 149, h, 0, 300,100,'Emission');
               posy += 24;			 
			   angleSlider = addHScrol(9, posy, 149, h, 0, 2 * M_PI, M_PI, 'Angle');
			   posy += 24;
			   spreadSlider = addHScrol(9, posy, 149, h, 0, 2 * M_PI, M_PI, 'Spread');
			
			   posy += 30;
	         SpeedMin = addHScrol(9, posy, 149, h, -600, 600, 0,'SpeedMin');
			 posy += 24;
			 SpeedMax = addHScrol(9, posy, 149, h, -600, 600, 0,'SpeedMax');

			   posy += 35;
			 gravityMinSlider = addHScrol(9, posy, 149, h, -1000, 1000, 0,'Gravity Min');
			   posy += 24;
			 gravityMaxSlider = addHScrol(9, posy, 149, h,  -1000, 1000, 0,'Gravity Max');
			 
			 posy += 60;
			 siseStartSlider = addHScrol(9, posy, 149, h, 0, 200, texwidth,'Size Start');
			 posy += 24;
			 siseEndSlider = addHScrol(9, posy, 149, h, 0, 200, texheight,'Size End');
			 posy += 24;
			 siseVarSlider = addHScrol(9, posy, 149, h, 0, 255, 0, 'Size Var');
			 
			 		 posy += 60;
			 spinStartSlider = addHScrol(9, posy, 149, h, -50, 50,0,'Spin Start');
			 posy += 24;
			 spinEndSlider = addHScrol(9, posy, 149, h, -50, 50, 0,'Spin End');
			 posy += 24;
			 spinVarSlider = addHScrol(9, posy, 149, h, 0, 255, 0,'Spin Var');
			
			 posy += 35;
			 radialMinSlider = addHScrol(9, posy, 149, h, -900, 900, 0,'RadialAcc Min');
			 posy += 24;
			 radialMaxSlider = addHScrol(9, posy, 149, h,  -900, 900, 0,'RadialAcc Max');
	
			 posy += 35;
			 tanMinSlider = addHScrol(9, posy, 149, h, -1000, 1000, 0,'TagentAcc Min');
			 posy += 24;
			 tanMaxSlider = addHScrol(9, posy, 149, h,  -1000, 1000, 0, 'TangentAcc Max');
			 
			 //********************
			   posy = 0;
			   posy += 24;
			   colorVarSlider =addHScrol(screenWidth-200, posy, 149, h, 0, 255,  0 ,'ColorVar');
               posy += 24;			 
			   alphaVarSlider = addHScrol(screenWidth-200, posy , 149, h, 0,255, 0, 'AlphaVar');
			  
			   posy += 40;			 
			   ColorStartR = addHScrol(screenWidth-200, posy , 149, h, 0,255, 0, 'ColorStart Red');
			   posy += 24;			 
			   ColorStartG = addHScrol(screenWidth-200, posy , 149, h, 0,255, 0, 'ColorStart Green');
			   posy += 24;			 
			   ColorStartB = addHScrol(screenWidth-200, posy , 149, h, 0,255, 0, 'ColorStart Blue');
			   posy += 24;			 
			   ColorStartA = addHScrol(screenWidth-200, posy , 149, h, 0,255, 0, 'ColorStart Alpha');
			  
			   	   posy += 40;			 
			   ColorEndR = addHScrol(screenWidth-200, posy , 149, h, 0,255, 0, 'ColorEnd Red');
			   posy += 24;			 
			   ColorEndG = addHScrol(screenWidth-200, posy , 149, h, 0,255, 0, 'ColorEnd Green');
			   posy += 24;			 
			   ColorEndB = addHScrol(screenWidth-200, posy , 149, h, 0,255, 0, 'ColorEnd Blue');
			   posy += 24;			 
			   ColorEndA = addHScrol(screenWidth-200, posy , 149, h, 0,255, 0, 'ColorEnd Alpha');
			   
posy += 50;	
var but:Button = new Button();
but.x = screenWidth-180;
but.y = posy;
but.height = 20;
but.width = 140;
but.addEventListener(UIEvent.CLICK, function(e:UIEvent) 
{ 

	ColorStartR.pos = Util.randf(0, 255);
	ColorStartG.pos = Util.randf(0, 255);
	ColorStartB.pos = Util.randf(0, 255);
	ColorStartA.pos = Util.randf(0, 255);
	
	
});
but.text = 'Random Start Color';
uiroot.addChild(but);
//*******

posy += 25;	
var but:Button = new Button();
but.x = screenWidth-180;
but.y = posy;
but.height = 20;
but.width = 140;
but.addEventListener(UIEvent.CLICK, function(e:UIEvent) 
{ 

	ColorEndR.pos = Util.randf(0, 255);
	ColorEndG.pos = Util.randf(0, 255);
	ColorEndB.pos = Util.randf(0, 255);
	ColorEndA.pos = Util.randf(0, 255);
	
	
});
but.text = 'Random End Color';
uiroot.addChild(but);

//*******

posy += 25;	
var but:Button = new Button();
but.x = screenWidth-180;
but.y = posy;
but.height = 20;
but.width = 140;
but.addEventListener(UIEvent.CLICK, function(e:UIEvent) 
{ 

        spinStartSlider.pos=Util.randf(-50, 50);
		spinEndSlider.pos  =Util.randf(-50, 50);
		spinVarSlider.pos  = Util.randf(0, 255);
	
	
});
but.text = 'Random Spin';
uiroot.addChild(but);		


	 	
//*******
posy += 25;	
var but:Button = new Button();
but.x = screenWidth-180;
but.y = posy;
but.height = 20;
but.width = 140;
but.addEventListener(UIEvent.CLICK, function(e:UIEvent) 
{ 

        siseStartSlider.pos=Util.randf(0, 200);
		siseEndSlider.pos  =Util.randf(0, 200);
		siseVarSlider.pos  = Util.randf(0, 255);
	
			 
			 
});
but.text = 'Random Size';
uiroot.addChild(but);		
//**
posy += 25;	
var but:Button = new Button();
but.x = screenWidth-180;
but.y = posy;
but.height = 20;
but.width = 140;
but.addEventListener(UIEvent.CLICK, function(e:UIEvent) 
{ 

        radialMinSlider.pos = Util.randf( -900, 900);
		radialMaxSlider.pos=Util.randf(-900, 900);
		tanMinSlider.pos = Util.randf( -1000, 1000);
		tanMaxSlider.pos=Util.randf(-1000, 1000);
		
	
	
});
but.text = 'Random Acc';
uiroot.addChild(but);		

posy += 25;	
var but:Button = new Button();
but.x = screenWidth-180;
but.y = posy;
but.height = 20;
but.width = 140;
but.addEventListener(UIEvent.CLICK, function(e:UIEvent) 
{ 

        angleSlider.pos = Util.randf( 0, 2 * M_PI);
		spreadSlider.pos=Util.randf(0, 2 * M_PI);
		
		
	
	
});
but.text = 'Random Angle,Spread';
uiroot.addChild(but);	


posy += 25;	
var but:Button = new Button();
but.x = screenWidth-180;
but.y = posy;
but.height = 20;
but.width = 140;
but.addEventListener(UIEvent.CLICK, function(e:UIEvent) 
{ 

        SpeedMin.pos = Util.randf( -600,600);
		SpeedMax.pos=Util.randf(-600, 600);
		
			
	
	
});
but.text = 'Random Speed';
uiroot.addChild(but);	


posy += 25;	
var but:Button = new Button();
but.x = screenWidth-180;
but.y = posy;
but.height = 20;
but.width = 140;
but.addEventListener(UIEvent.CLICK, function(e:UIEvent) 
{ 

        angleSlider.pos = Util.randf( 0, 2 * M_PI);
		spreadSlider.pos=Util.randf(0, 2 * M_PI);
		    angleSlider.pos = Util.randf( 0, 2 * M_PI);
		spreadSlider.pos=Util.randf(0, 2 * M_PI);
		    radialMinSlider.pos = Util.randf( -900, 900);
		radialMaxSlider.pos=Util.randf(-900, 900);
		tanMinSlider.pos = Util.randf( -1000, 1000);
		tanMaxSlider.pos=Util.randf(-1000, 1000);
		
        spinStartSlider.pos=Util.randf(-50, 50);
		spinEndSlider.pos  =Util.randf(-50, 50);
		spinVarSlider.pos  = Util.randf(0, 255);
		
		SpeedMin.pos = Util.randf( -600,600);
		SpeedMax.pos=Util.randf(-600, 600);
		
		
	ColorEndR.pos = Util.randf(0, 255);
	ColorEndG.pos = Util.randf(0, 255);
	ColorEndB.pos = Util.randf(0, 255);
	ColorEndA.pos = Util.randf(0, 255);
	
	ColorStartR.pos = Util.randf(0, 255);
	ColorStartG.pos = Util.randf(0, 255);
	ColorStartB.pos = Util.randf(0, 255);
	ColorStartA.pos = Util.randf(0, 255);
	
});
but.text = 'Random';
uiroot.addChild(but);	

//*****
posy += 25;	
var but:Button = new Button();
but.x = screenWidth-180;
but.y = posy;
but.height = 20;
but.width = 140;
but.addEventListener(UIEvent.CLICK, function(e:UIEvent) 
{ 

pmanager.FInfo = null;
pmanager.FInfo = new ParticleSystemInfo();
   
		loadDefaults();			
	
	
});
but.text = 'Reset';
uiroot.addChild(but);	
        
	
		  caption = new TextField();
		 caption.x =  screenWidth / 2-100;
		 caption.y = 20;
		 caption.width = 200;
		 caption.defaultTextFormat = new TextFormat ("_sans", 12, 0xffff00);
		 caption.text = "Test Particles ";
		 caption.selectable = false;
		 addChild(caption);
		 
	
	 
     
		

//*************
	 var but:Button = new Button();
but.x = screenWidth/2+80;
but.y = screenHeight-30;
but.height = 25;

but.addEventListener(UIEvent.CLICK, function(e:UIEvent) 
{

	downloader.addEventListener(flash.events.Event.SELECT, onLoadXML);
	downloader.browse([new FileFilter("Particle Files (*.xml)", "*.xml")]);
	

});
but.text = 'Load Particle';
uiroot.addChild(but);
//****************************
 var but:Button = new Button();
but.x = screenWidth/2-80;
but.y = screenHeight-30;
but.height = 25;

but.addEventListener(UIEvent.CLICK, function(e:UIEvent) 
{

	downloader.addEventListener(flash.events.Event.SELECT, onLoadPSI);
	downloader.browse([new FileFilter("HGE Particle Files (*.psi)", "*.psi")]);
		

});
but.text = 'Import PSI';
uiroot.addChild(but);
//*****
 var but:Button = new Button();
but.x = screenWidth/2+10;
but.y = screenHeight-30;
but.height = 25;

but.addEventListener(UIEvent.CLICK, function(e:UIEvent) 
{
	
	    	var filedata:ByteArray;
			filedata = new ByteArray();
			filedata.writeUTFBytes(pmanager.FInfo.toXml());
			filedata.position = 0;
			downloader.save(filedata);
	
			

		

});
but.text = '  Save  ';
uiroot.addChild(but);

		 
		


	
   }
   

		
        private function onLoadPSI(e:flash.events.Event):Void
		{
			downloader.removeEventListener(flash.events.Event.SELECT, onLoadPSI);
			downloader.addEventListener(flash.events.Event.COMPLETE, onLoadPSIComplete);
			downloader.load();
			
		}
	private function onLoadPSIComplete(e:flash.events.Event):Void 
		{
		pmanager.Stop();
		pmanager.FInfo = null;
        pmanager.FInfo = new ParticleSystemInfo();
		var b:ByteArray = downloader.data;
		pmanager.FInfo.loadInfoFromBytes(b);
		loadDefaults();
		pmanager.Fire();
		}
		
         private function onLoadXML(e:flash.events.Event):Void
		{
			downloader.removeEventListener(flash.events.Event.SELECT, onLoadXML);
			downloader.addEventListener(flash.events.Event.COMPLETE, onLoadXMLComplete);
			downloader.load();
			
		}
		private function onLoadXMLComplete(e:flash.events.Event):Void 
		{
		pmanager.Stop();
		pmanager.FInfo = null;
        pmanager.FInfo = new ParticleSystemInfo();
		var b:ByteArray = downloader.data;
		pmanager.FInfo.parseInfoFromString(b.toString());
		loadDefaults();
		pmanager.Fire();
		}
		
}