using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Application;
//using Toybox.Sensor; //will be used later

class AnalogEdgeView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
        
        //will be used later
        //Sensor.setEnabledSensors([Sensor.SENSOR_TEMPERATURE]);
    	//Sensor.enableSensorEvents(method(:onSensor));
    }
    /*
    function onSensor(sensorInfo) {
    	System.println("Heart Rate: " + sensorInfo);
	}
	*/

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
    	//get curren time
        var clockTime = System.getClockTime();
        
    	//example code not used but good to keep
    	/*
        //format time correctly
        var timeFormat = "$1$:$2$";
        var hours = clockTime.hour;
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {
            if (Application.getApp().getProperty("UseMilitaryFormat")) {
                timeFormat = "$1$$2$";
                hours = hours.format("%02d");
            }
        }
        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);

        // Update the view
        var view = View.findDrawableById("TimeLabel");
        view.setColor(Application.getApp().getProperty("ForegroundColor"));
        view.setText(timeString);
		*/
		
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        
        dc.clear();
		dc.setColor(Graphics.COLOR_WHITE,Graphics.COLOR_WHITE);
		dc.drawCircle(120,120,119);
		//dc.drawLine(120,120,120,240);
		
		var h = clockTime.hour;
		var m = clockTime.min;
		var c = 120;
		
		//minutes
		for(var i=-1.5;i<=1.5;i+=0.1){
			var deg = -(m*360.0/60) - 180 + i;
			
			var r1 = 99;
			var r2 = 119;
			var x1 = c + r1 * Math.sin(Math.toRadians(deg));
			var y1 = c + r1 * Math.cos(Math.toRadians(deg));
			var x2 = c + r2 * Math.sin(Math.toRadians(deg));
			var y2 = c + r2 * Math.cos(Math.toRadians(deg));
			dc.drawLine(x1,y1,x2,y2);
		}
		
		//hours
		for(var i=-1.5;i<=1.5;i+=0.1){
			var deg2 = -(h%12*360.0/12 + 30*m/60) - 180 + i;
			
			var r3 = 108;
			var r4 = 119;
			var x3 = c + r3 * Math.sin(Math.toRadians(deg2));
			var y3 = c + r3 * Math.cos(Math.toRadians(deg2));
			var x4 = c + r4 * Math.sin(Math.toRadians(deg2));
			var y4 = c + r4 * Math.cos(Math.toRadians(deg2));
			dc.drawLine(x3,y3,x4,y4);
		}
		
		
		//5min ticks
		for(var i=0;i<360;i+=30){
			var r5 = 108;
			var r6 = 119;
			var x5 = c + r5 * Math.sin(Math.toRadians(i));
			var y5 = c + r5 * Math.cos(Math.toRadians(i));
			var x6 = c + r6 * Math.sin(Math.toRadians(i));
			var y6 = c + r6 * Math.cos(Math.toRadians(i));
			dc.drawLine(x5,y5,x6,y6);
		}
		
		
		//1min ticks
		for(var i=0;i<360;i+=6){
			var r7 = 114;
			var r8 = 119;
			var x7 = c + r7 * Math.sin(Math.toRadians(i));
			var y7 = c + r7 * Math.cos(Math.toRadians(i));
			var x8 = c + r8 * Math.sin(Math.toRadians(i));
			var y8 = c + r8 * Math.cos(Math.toRadians(i));
			dc.drawLine(x7,y7,x8,y8);
		}
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
