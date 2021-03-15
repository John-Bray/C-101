var nav_display = {
  new: func()
  {
    var m = { parents: [nav_display] };
    # create a new canvas...
    m.canvas = canvas.new({
      "name": "NAV1_f",
      "size": [1024, 1024],
      "view": [1024, 256],
      "mipmapping": 1
    });
    # ... and place it on the object called canvas_NAV1_frequency
    m.canvas.addPlacement({"node": "canvas_NAV1_frequency"});
    m.canvas.setColorBackground(0.1,0,0, 1);
    m.navf  = props.globals.getNode("instrumentation/nav/frequencies/selected-mhz-fmt");
    var g = m.canvas.createGroup();
    m.Nav1_Freq =
      g.createChild("text", "line-title")
       .setDrawMode(canvas.Text.TEXT + canvas.Text.FILLEDBOUNDINGBOX)
       .setColor(1,0,0,1)
       .setColorFill(0.1,0,0,1)
       .setAlignment("center-top")
       .setFont("7-Segment.ttf")
       .setFontSize(24, 1.0)
       .setTranslation(512, 104);
    return m;
  },
  update: func()
  {
    me.Nav1_Freq.setText(me.navf.getValue());
    settimer(func me.update(), 0);
  },
};
setlistener("/nasal/canvas/loaded", func {
  var nav_f = nav_display.new();
  nav_f.update();
}, 1);
