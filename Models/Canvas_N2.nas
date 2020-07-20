var n2_display = {
  new: func()
  {
    var m = { parents: [n2_display] };
    # create a new canvas...
    m.canvas = canvas.new({
      "name": "N2",
      "size": [1024, 1024],
      "view": [1024, 256],
      "mipmapping": 1
    });
    # ... and place it on the object called canvas_NAV1_frequencyV1
    m.canvas.addPlacement({"node": "canvas_N2"});
    m.canvas.setColorBackground(0.1,0,0, 1);
    #m.n2  = props.globals.getNode("engines/engine/n2");
    var g = m.canvas.createGroup();
    m.n2_value =
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
    var percentN2 = sprintf("%2.1f", getprop("/engines/engine/n2")) ;
    me.n2_value.setText(percentN2);
    settimer(func me.update(), 0);
  },
};
setlistener("/nasal/canvas/loaded", func {
  var n2_percent = n2_display.new();
  n2_percent.update();
}, 1);
