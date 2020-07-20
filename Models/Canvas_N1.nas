var n1_display = {
  new: func()
  {
    var m = { parents: [n1_display] };
    # create a new canvas...
    m.canvas = canvas.new({
      "name": "N1",
      "size": [1024, 1024],
      "view": [1024, 256],
      "mipmapping": 1
    });
    # ... and place it on the object called canvas_NAV1_frequencyV1
    m.canvas.addPlacement({"node": "canvas_N1"});
    m.canvas.setColorBackground(0.1,0,0, 1);
    #m.n1  = props.globals.getNode("engines/engine/n1");
    var g = m.canvas.createGroup();
    m.n1_value =
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
    var percentN1 = sprintf("%2.1f", getprop("/engines/engine/n1")) ;
    me.n1_value.setText(percentN1);
    
    
    settimer(func me.update(), 0);
  },
};
setlistener("/nasal/canvas/loaded", func {
  var n1_percent = n1_display.new();
  n1_percent.update();
}, 1);
