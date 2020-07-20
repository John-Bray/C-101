var itt_display = {
  new: func()
  {
    var m = { parents: [itt_display] };
    # create a new canvas...
    m.canvas = canvas.new({
      "name": "ITT",
      "size": [1024, 1024],
      "view": [1024, 256],
      "mipmapping": 1
    });
    # ... and place it on the object called canvas_NAV1_frequencyV1
    m.canvas.addPlacement({"node": "canvas_ITT"});
    m.canvas.setColorBackground(0.1,0,0, 1);
    m.degf  = props.globals.getNode("/engines/engine/egt-degf");
    var g = m.canvas.createGroup();
    m.itt_value =
      g.createChild("text", "line-title")
       .setDrawMode(canvas.Text.TEXT + canvas.Text.FILLEDBOUNDINGBOX)
       .setColor(0.4,0.4,1,1)
       .setColorFill(0.0,0.0,0.1,1)
       .setAlignment("center-top")
       .setFont("7-Segment.ttf")
       .setFontSize(24, 1.0)
       .setTranslation(512, 102);
    return m;
  },
  update: func()
  {
  	var itt_calc =  0.555*(me.degf.getValue()-32) ;
	var itt_text = sprintf( "%3d", itt_calc   ) ;
    me.itt_value.setText(itt_text);
    
    settimer(func me.update(), 0);
  },
};
setlistener("/sim/signals/fdm-initialized", func {
	setprop("/engines/engine/egt-degf", 32.0) ;
  var itt_digits = itt_display.new();
  itt_digits.update();
}, 1);
# var foo = getprop("/foo/foo") or 0.00;
# var sum = foo +1;
# should always work ! Even if not yet initialised