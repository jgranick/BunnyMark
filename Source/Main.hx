package;


import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.Assets;

#if js
import js.html.DivElement;
import js.Browser;
#end


class Main extends Sprite {
	
	
	private var addBunnies:Bool;
	private var bunnies:Array<Bunny>;
	private var container:Sprite;
	
	#if js
	private var counter:DivElement;
	#end
	
	
	public function new () {
		
		super ();
		
		#if js
		counter = cast Browser.document.createElement ("div");
		counter.className = "counter";
		Browser.document.body.appendChild (counter);
		#end
		
		container = new Sprite ();
		container.mouseChildren = false;
		addChild (container);
		
		bunnies = [];
		
		for (i in 0...10) {
			
			addBunny ();
			
		}
		
		stage.addEventListener (MouseEvent.MOUSE_DOWN, stage_onMouseDown);
		stage.addEventListener (MouseEvent.MOUSE_UP, stage_onMouseUp);
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
		
	}
	
	
	private inline function addBunny () {
		
		var bunny = new Bunny ();
		bunny.speedX = Math.random () * 10;
		bunny.speedY = (Math.random () * 10) - 5;
		bunnies.push (bunny);
		
		container.addChildAt (bunny, Std.int (Math.random () * container.numChildren));
		
		#if js
		counter.innerHTML = bunnies.length + " BUNNIES";
		#else
		trace (bunnies.length + " BUNNIES");
		#end
		
	}
	
	
	
	
	// Event Handlers
	
	
	
	
	private function stage_onMouseDown (event:MouseEvent):Void {
		
		addBunnies = true;
		
	}
	
	
	private function stage_onMouseUp (event:MouseEvent):Void {
		
		addBunnies = false;
		
	}
	
	
	private function this_onEnterFrame (event:Event):Void {
		
		if (addBunnies) {
			
			#if (!html5 || webgl)
			for (i in 0...10) {
			#else
			for (i in 0...5) {
			#end
				
				addBunny ();
				
			}
			
		}
		
		var length = bunnies.length;
		var index;
		var bunny;
		
		for (i in 0...length) {
			
			bunny = bunnies[i];
			
			bunny.x += bunny.speedX;
			bunny.y += bunny.speedY;
			bunny.speedY += 0.75;
			
			if (bunny.x > 800) {
				
				bunny.speedX *= -1;
				bunny.x = 800;
				
			} else if (bunny.x < 0) {
				
				bunny.speedX *= -1;
				bunny.x = 0;
				
			}
			
			if (bunny.y > 600) {
				
				bunny.speedY *= -0.85;
				bunny.y = 600;
				
				if (Math.random () > 0.5) {
					
					bunny.speedY -= Math.random () * 6;
					
				}
				
			} else if (bunny.y < 0) {
				
				bunny.speedY = 0;
				bunny.y = 0;
				
			}
			
		}
		
	}
	
	
}


private class Bunny extends Bitmap {
	
	
	public var speedX = 0.0;
	public var speedY = 0.0;
	
	
	public function new () {
		
		super (Assets.getBitmapData ("images/bunny.png"));
		
	}
	
	
}