using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Application;
//using Toybox.Sensor; //will be used later (can't be used with watch face)
using Toybox.SensorHistory;//better luck with that ?
using Toybox.Time.Gregorian;
using Toybox.ActivityMonitor;

//id: 9ffda0d8-e437-427b-94c0-35a260b4d467
class AnalogEdgeView extends WatchUi.WatchFace {
	var sleeping=false;
	var customFont=null;
	var firstLook=false;
    function initialize() {
        WatchFace.initialize();
    	System.println("initialize()");
    }
	// Create methods to get SensorHistoryIterator objects
	function getHRIterator() {
	    // Check device for SensorHistory compatibility
	    if ((Toybox has :SensorHistory) && (Toybox.SensorHistory has :getHeartRateHistory)) {
	        return Toybox.SensorHistory.getHeartRateHistory({});
	    }
	    return null;
	}
	function getELIterator() {
	    // Check device for SensorHistory compatibility
	    if ((Toybox has :SensorHistory) && (Toybox.SensorHistory has :getElevationHistory)) {
	        return Toybox.SensorHistory.getElevationHistory({});
	    }
	    return null;
	}
	function getPRIterator() {
	    // Check device for SensorHistory compatibility
	    if ((Toybox has :SensorHistory) && (Toybox.SensorHistory has :getPressureHistory)) {
	        return Toybox.SensorHistory.getPressureHistory({});
	    }
	    return null;
	}
	function getTPIterator() {
	    // Check device for SensorHistory compatibility
	    if ((Toybox has :SensorHistory) && (Toybox.SensorHistory has :getTemperatureHistory)) {
	        return Toybox.SensorHistory.getTemperatureHistory({});
	    }
	    return null;
	}

	
    // Load your resources here
    function onLayout(dc) {
    	customFont = WatchUi.loadResource(Rez.Fonts.customFont);
        setLayout(Rez.Layouts.WatchFace(dc));
    	System.println("onLayout()");
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    	System.println("onShow()");
    }

    // Update the view
    function onUpdate(dc) {
        
        
        
    	//get current time
        var clockTime = System.getClockTime();
        var h = clockTime.hour;
		var m = clockTime.min;
		var s = clockTime.sec;
		var c = 120;
		System.println("onupdate() "+clockTime.hour + ":" + clockTime.min + ":" + clockTime.sec);
        
        
        if(s==0 || !firstLook){
			firstLook=true;
			System.println("updated  !");
        
        //System.println("hr: " + Sensor.Info.heartRate);
        
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
		dc.setColor(Application.getApp().getProperty("ForegroundColor"),Graphics.COLOR_BLACK);
		//dc.drawCircle(120,120,119);
		
		
		
		
		
		//Text: https://developer.garmin.com/downloads/connect-iq/monkey-c/doc/Toybox/Graphics.html
		//dc.drawText(120, 60, Graphics.FONT_XTINY, "test", Graphics.TEXT_JUSTIFY_CENTER);
		//dc.drawText(120, 80, Graphics.FONT_SYSTEM_XTINY, "test", Graphics.TEXT_JUSTIFY_CENTER);
		
		/*
		dc.setColor(Graphics.COLOR_DK_GRAY,Graphics.COLOR_BLACK);
		dc.drawText(120,105,Graphics.FONT_XTINY,System.getSystemStats().battery.format("%d")+"%",Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
		
		//https://developer.garmin.com/downloads/connect-iq/monkey-c/doc/Toybox/ActivityMonitor/Info.html
		dc.drawText(120,50,Graphics.FONT_XTINY,ActivityMonitor.getInfo().floorsClimbed+"/"+ActivityMonitor.getInfo().floorsClimbedGoal,Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
		dc.drawText(120,70,Graphics.FONT_XTINY,ActivityMonitor.getInfo().steps+"/"+ActivityMonitor.getInfo().stepGoal,Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
		dc.drawText(120,90,Graphics.FONT_XTINY,ActivityMonitor.getInfo().activeMinutesWeek.total+"/"+ActivityMonitor.getInfo().activeMinutesWeekGoal,Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
		*/
		
		
		//Colors: https://developer.garmin.com/connect-iq/user-experience-guide/page-layout
		if(System.getDeviceSettings().connectionInfo[:bluetooth].state==2){
			dc.setColor(Graphics.COLOR_DK_GREEN,Graphics.COLOR_DK_GREEN);
		}else if(System.getDeviceSettings().connectionInfo[:bluetooth].state==1){
			dc.setColor(Graphics.COLOR_DK_RED,Graphics.COLOR_DK_RED);
		}else{
			dc.setColor(Graphics.COLOR_DK_GRAY,Graphics.COLOR_DK_GRAY);
		}
		dc.fillCircle(120-Application.getApp().getProperty("DotsSize")*2-2,210,Application.getApp().getProperty("DotsSize"));
		
		if(System.getDeviceSettings().alarmCount>0){
			dc.setColor(Graphics.COLOR_DK_GREEN,Graphics.COLOR_DK_GREEN);
		}else{
			dc.setColor(Graphics.COLOR_DK_GRAY,Graphics.COLOR_DK_GRAY);
		}
		dc.fillCircle(120,210,Application.getApp().getProperty("DotsSize"));
		
		if(System.getDeviceSettings().notificationCount>0){
			dc.setColor(Graphics.COLOR_DK_GREEN,Graphics.COLOR_DK_GREEN);
		}else{
			dc.setColor(Graphics.COLOR_DK_GRAY,Graphics.COLOR_DK_GRAY);
		}
		dc.fillCircle(120+Application.getApp().getProperty("DotsSize")*2+2,210,Application.getApp().getProperty("DotsSize"));
		
		dc.setColor(Application.getApp().getProperty("ForegroundColor"),Graphics.COLOR_BLACK);
		
		//sec point
		/*
		if(clockTime.sec%2==1){
			dc.drawPoint(120,120);
		}
		*/
		

		
		//5min ticks
		for(var i=0;i<360;i+=30){
			var r5 = 106;
			var r6 = 119;
			var x5 = c + r5 * Math.sin(Math.toRadians(i));
			var y5 = c + r5 * Math.cos(Math.toRadians(i));
			var x6 = c + r6 * Math.sin(Math.toRadians(i));
			var y6 = c + r6 * Math.cos(Math.toRadians(i));
			dc.drawLine(x5,y5,x6,y6);
		}
		
		//1min ticks
		for(var i=0;i<360;i+=6){
			var r7 = 112;
			var r8 = 119;
			var x7 = c + r7 * Math.sin(Math.toRadians(i));
			var y7 = c + r7 * Math.cos(Math.toRadians(i));
			var x8 = c + r8 * Math.sin(Math.toRadians(i));
			var y8 = c + r8 * Math.cos(Math.toRadians(i));
			dc.drawLine(x7,y7,x8,y8);
		}
		
		dc.setPenWidth(Application.getApp().getProperty("HandsWidth"));
		
		//minutes
		var deg = -(m*360.0/60) - 180 ;
		
		var r1 = 99;
		var r2 = 119;
		var x1 = c + r1 * Math.sin(Math.toRadians(deg));
		var y1 = c + r1 * Math.cos(Math.toRadians(deg));
		var x2 = c + r2 * Math.sin(Math.toRadians(deg));
		var y2 = c + r2 * Math.cos(Math.toRadians(deg));
		dc.drawLine(x1,y1,x2,y2);
		
		//hours
		var deg2 = -(h%12*360.0/12 + 30*m/60) - 180 ;
		
		var r3 = 108;
		var r4 = 119;
		var x3 = c + r3 * Math.sin(Math.toRadians(deg2));
		var y3 = c + r3 * Math.cos(Math.toRadians(deg2));
		var x4 = c + r4 * Math.sin(Math.toRadians(deg2));
		var y4 = c + r4 * Math.cos(Math.toRadians(deg2));
		dc.drawLine(x3,y3,x4,y4);

		dc.setPenWidth(1);
		
		
		
		
		
		
		//test text
        dc.setColor(Graphics.COLOR_WHITE,Graphics.COLOR_TRANSPARENT);
        //dc.drawText(50,100,Graphics.FONT_LARGE,"test",Graphics.TEXT_JUSTIFY_CENTER);
        //dc.drawText(50,50,customFont,"123",Graphics.TEXT_JUSTIFY_CENTER);
		
		
		
			//test sensor history
			var chartHeight = 40;//40
			var chartWidth  = 140;//60
			var chartHRX    = 50;//55
			var chartHRY    = 40;//60
			dc.drawLine(chartHRX,chartHRY,chartHRX,chartHRY+chartHeight);
			dc.drawLine(chartHRX,chartHRY+chartHeight,chartHRX+chartWidth,chartHRY+chartHeight);
			dc.drawLine(chartHRX+chartWidth,chartHRY+chartHeight,chartHRX+chartWidth,chartHRY-1);
			
	        var firstTime = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
	        var lastTime = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
	        var firstVal = 0.0;
			var sensorIter = getHRIterator();
			dc.setColor(Graphics.COLOR_RED,Graphics.COLOR_TRANSPARENT);
			for(var i=chartWidth-1;i>0;i--){
				var item = sensorIter.next();
				if(item == null){
					break;
				}
				if(item.data != null){
					if(i==chartWidth-1 && item.when != null){
						firstTime = item.when;
						firstVal = item.data;
					}
					var value = (item.data-sensorIter.getMin())*chartHeight/(sensorIter.getMax()-sensorIter.getMin());
					dc.drawLine(chartHRX+i,chartHRY+chartHeight-1,chartHRX+i,chartHRY+chartHeight-value);
					lastTime = item.when;
				}
			}
        	dc.setColor(Graphics.COLOR_WHITE,Graphics.COLOR_TRANSPARENT);
			dc.drawText(55,40,customFont,sensorIter.getMax(),Graphics.TEXT_JUSTIFY_LEFT);
	        dc.drawText(55,65,customFont,sensorIter.getMin(),Graphics.TEXT_JUSTIFY_LEFT);
	        dc.drawText(185,52,customFont,firstVal,Graphics.TEXT_JUSTIFY_RIGHT);
	        
	        var delta = firstTime.subtract(lastTime);
			dc.drawText(120,65,customFont,(delta.value()/3600.0).format("%.2f"),Graphics.TEXT_JUSTIFY_CENTER);
			
			
			/*
	        System.println("######### HR HISTORY ########");
	        var sensorIter = getHRIterator();
	        if(sensorIter != null){
	        	dc.drawText(40,60,customFont,sensorIter.getMax(),Graphics.TEXT_JUSTIFY_LEFT);
	        	dc.drawText(40,80,customFont,sensorIter.getMin(),Graphics.TEXT_JUSTIFY_LEFT);
		        System.println("Min:"+sensorIter.getMin()+" Max:"+sensorIter.getMax());
		        System.println("#############################");
		        var item = sensorIter.next();
		        while(item != null){
		        	var date = Gregorian.info(item.when, Time.FORMAT_SHORT);
		        	System.println(item.data + "BPM " + date.day + "."+date.month + "."+date.year + " "+date.hour+":"+date.min+":"+date.sec);
		        	item = sensorIter.next();
		        }
	        }else{
	        	
	        }
	        */
	        
	        chartHeight = 40;//40
			chartWidth  = 140;//60
			chartHRX    = 50;//122
			chartHRY    = 80;//60
			dc.drawLine(chartHRX,chartHRY,chartHRX,chartHRY+chartHeight);
			dc.drawLine(chartHRX,chartHRY+chartHeight,chartHRX+chartWidth,chartHRY+chartHeight);
			dc.drawLine(chartHRX+chartWidth,chartHRY+chartHeight,chartHRX+chartWidth,chartHRY-1);
			
			sensorIter = getTPIterator();
	        firstTime = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
	        lastTime = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
	        firstVal = 0.0;
			dc.setColor(Graphics.COLOR_LT_GRAY,Graphics.COLOR_TRANSPARENT);
			for(var i=chartWidth-1;i>0;i--){
				var item = sensorIter.next();
				if(item == null){
					break;
				}
				if(item.data != null){
					if(i==chartWidth-1 && item.when != null){
						firstTime = item.when;
						firstVal = item.data;
					}
					var value = (item.data-sensorIter.getMin())*chartHeight/(sensorIter.getMax()-sensorIter.getMin());
					dc.drawLine(chartHRX+i,chartHRY+chartHeight-1,chartHRX+i,chartHRY+chartHeight-value);
					lastTime = item.when;
				}
			}
        	dc.setColor(Graphics.COLOR_BLACK,Graphics.COLOR_TRANSPARENT);
	        dc.drawText(55,80,customFont,sensorIter.getMax().format("%.2f"),Graphics.TEXT_JUSTIFY_LEFT);
	        dc.drawText(55,105,customFont,sensorIter.getMin().format("%.2f"),Graphics.TEXT_JUSTIFY_LEFT);
	        dc.drawText(185,92,customFont,firstVal.format("%.2f"),Graphics.TEXT_JUSTIFY_RIGHT);
	        
	        delta = firstTime.subtract(lastTime);
			dc.drawText(120,105,customFont,(delta.value()/3600.0).format("%.2f"),Graphics.TEXT_JUSTIFY_CENTER);
	        
	        /*
	        System.println("######### TP HISTORY ########");
	        sensorIter = getTPIterator();
	        if(sensorIter != null){
	        	dc.drawText(210,60,customFont,sensorIter.getMax().format("%.2f"),Graphics.TEXT_JUSTIFY_RIGHT);
	        	dc.drawText(210,80,customFont,sensorIter.getMin().format("%.2f"),Graphics.TEXT_JUSTIFY_RIGHT);
		        System.println("Min:"+sensorIter.getMin()+" Max:"+sensorIter.getMax());
		        System.println("#############################");
		        var item = sensorIter.next();
		        while(item != null){
		        	var date = Gregorian.info(item.when, Time.FORMAT_SHORT);
		        	System.println(item.data + "deg " + date.day + "."+date.month + "."+date.year + " "+date.hour+":"+date.min+":"+date.sec);
		        	item = sensorIter.next();
		        }
	        }else{
	        	
	        }
	        */
	        
	        chartHeight = 40;//40
			chartWidth  = 140;//60
			chartHRX    = 50;//55
			chartHRY    = 120;//130
			dc.drawLine(chartHRX,chartHRY,chartHRX,chartHRY+chartHeight);
			dc.drawLine(chartHRX,chartHRY+chartHeight,chartHRX+chartWidth,chartHRY+chartHeight);
			dc.drawLine(chartHRX+chartWidth,chartHRY+chartHeight,chartHRX+chartWidth,chartHRY-1);
	        
	        sensorIter = getELIterator();
	        firstTime = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
	        lastTime = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
	        firstVal = 0.0;
	        dc.setColor(Graphics.COLOR_GREEN,Graphics.COLOR_TRANSPARENT);
			for(var i=chartWidth-1;i>0;i--){
				var item = sensorIter.next();
				if(item == null){
					break;
				}
				if(item.data != null){
					if(i==chartWidth-1 && item.when != null){
						firstTime = item.when;
						firstVal = item.data;
					}
					var value = (item.data-sensorIter.getMin())*chartHeight/(sensorIter.getMax()-sensorIter.getMin());
					dc.drawLine(chartHRX+i,chartHRY+chartHeight-1,chartHRX+i,chartHRY+chartHeight-value);
					lastTime = item.when;
				}
			}
        	dc.setColor(Graphics.COLOR_WHITE,Graphics.COLOR_TRANSPARENT);
	        dc.drawText(55,120,customFont,sensorIter.getMax().format("%.1f"),Graphics.TEXT_JUSTIFY_LEFT);
	        dc.drawText(55,145,customFont,sensorIter.getMin().format("%.1f"),Graphics.TEXT_JUSTIFY_LEFT);
	        dc.drawText(185,132,customFont,firstVal.format("%.1f"),Graphics.TEXT_JUSTIFY_RIGHT);
	        
	        delta = firstTime.subtract(lastTime);
			dc.drawText(120,145,customFont,(delta.value()/3600.0).format("%.2f"),Graphics.TEXT_JUSTIFY_CENTER);
	        
	        /*
	        System.println("######### EL HISTORY ########");
	        sensorIter = getELIterator();
	        if(sensorIter != null){
	        	dc.drawText(45,140,customFont,sensorIter.getMax().format("%.1f"),Graphics.TEXT_JUSTIFY_RIGHT);
	        	dc.drawText(45,160,customFont,sensorIter.getMin().format("%.1f"),Graphics.TEXT_JUSTIFY_RIGHT);
		        System.println("Min:"+sensorIter.getMin()+" Max:"+sensorIter.getMax());
		        System.println("#############################");
		        var item = sensorIter.next();
		        while(item != null){
		        	var date = Gregorian.info(item.when, Time.FORMAT_SHORT);
		        	System.println(item.data + "m. " + date.day + "."+date.month + "."+date.year + " "+date.hour+":"+date.min+":"+date.sec);
		        	item = sensorIter.next();
		        }
	        }else{
	        	
	        }
	        */
	        
	        chartHeight = 40;//40
			chartWidth  = 140;//60
			chartHRX    = 50;//122
			chartHRY    = 160;//130
			dc.drawLine(chartHRX,chartHRY,chartHRX,chartHRY+chartHeight);
			dc.drawLine(chartHRX,chartHRY+chartHeight,chartHRX+chartWidth,chartHRY+chartHeight);
			dc.drawLine(chartHRX+chartWidth,chartHRY+chartHeight,chartHRX+chartWidth,chartHRY-1);
	        
	        sensorIter = getPRIterator();
		    
	        dc.setColor(Graphics.COLOR_BLUE,Graphics.COLOR_TRANSPARENT);
	        firstTime = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
	        lastTime = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
	        firstVal = 0.0;
	        System.println(firstTime.day + "."+firstTime.month + "."+firstTime.year + " "+firstTime.hour+":"+firstTime.min+":"+firstTime.sec);
			for(var i=chartWidth-1;i>0;i--){
				var item = sensorIter.next();
				if(item == null){
					break;
				}
				if(item.data != null){
					if(i==chartWidth-1 && item.when != null){
						firstTime = item.when;
						firstVal  = item.data;
					}
					var value = (item.data-sensorIter.getMin())*chartHeight/(sensorIter.getMax()-sensorIter.getMin());
					dc.drawLine(chartHRX+i,chartHRY+chartHeight-1,chartHRX+i,chartHRY+chartHeight-value);
					lastTime = item.when;
				}
			}
        	dc.setColor(Graphics.COLOR_WHITE,Graphics.COLOR_TRANSPARENT);
	        dc.drawText(55,160,customFont,(sensorIter.getMax()/100.0).format("%.2f"),Graphics.TEXT_JUSTIFY_LEFT);
	        dc.drawText(55,185,customFont,(sensorIter.getMin()/100.0).format("%.2f"),Graphics.TEXT_JUSTIFY_LEFT);
	        dc.drawText(185,172,customFont,(firstVal/100.0).format("%.2f"),Graphics.TEXT_JUSTIFY_RIGHT);
	        
	        delta = firstTime.subtract(lastTime);
			dc.drawText(120,185,customFont,(delta.value()/3600.0).format("%.2f"),Graphics.TEXT_JUSTIFY_CENTER);
	        /*
	        System.println("######### PR HISTORY ########");
	        sensorIter = getPRIterator();
	        if(sensorIter != null){
	        	dc.drawText(210,140,customFont,(sensorIter.getMax()/100).format("%.2f"),Graphics.TEXT_JUSTIFY_RIGHT);
	        	dc.drawText(210,160,customFont,(sensorIter.getMin()/100).format("%.2f"),Graphics.TEXT_JUSTIFY_RIGHT);
		        System.println("Min:"+sensorIter.getMin()+" Max:"+sensorIter.getMax());
		        System.println("#############################");
		        var item = sensorIter.next();
		        while(item != null){
		        	var date = Gregorian.info(item.when, Time.FORMAT_SHORT);
		        	System.println(item.data/100 + "hPa. " + date.day + "."+date.month + "."+date.year + " "+date.hour+":"+date.min+":"+date.sec);
		        	item = sensorIter.next();
		        }
	        }else{
	        	
	        }
	        */
        
		}
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    	System.println("onHide()");
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    	sleeping=false;
    	System.println("onExitSleep()");
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    	sleeping=true;
    	System.println("onEnterSleep()");
    }

}
