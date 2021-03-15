var com_display = {
  new: func()
  {
    var m = { parents: [com_display] };
    # create a new canvas...
    m.canvas = canvas.new({
      "name": "COM1_f",
      "size": [1024, 1024],
      "view": [1024, 256],
      "mipmapping": 1
    });
    # ... and place it on the object called canvas_COM1_frequency
    m.canvas.addPlacement({"node": "canvas_COM1_frequency"});
    m.canvas.setColorBackground(0.1,0,0, 1);
    m.comf  = props.globals.getNode("instrumentation/comm/frequencies/selected-mhz-fmt");
    var g = m.canvas.createGroup();
    m.Com1_Freq =
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
    me.Com1_Freq.setText(me.comf.getValue());
    settimer(func me.update(), 0);
  },
};
setlistener("/nasal/canvas/loaded", func {
  var com_f = com_display.new();
  com_f.update();
}, 1);
