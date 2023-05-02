include <BOSL2/std.scad>
include <./lib/convert.scad>

led_color = "lightblue"; // [tan, lightblue, lightgreen, lightpink, white, black]

/* [Hidden] */

height = inches(13.5);
width = inches(3);
wall_thickness = 0.6;

led_strip_width = 10;
led_strip_height = 2.5;
led_strip_segment_length = 100;

cover_color = "#ffffffaa";
core_color = "darkgray";

module cover() {
  color(cover_color)
  cube([width, width, height - inches(0.5)], anchor = CENTER + BOTTOM);
}

module base(anchor = CENTER, spin = 0, orient = UP) {
  // Base
  diff()
  color_this(core_color)
  cube([width, width, inches(0.5)], anchor = CENTER + BOTTOM) {
    // Upper Base
    attach(TOP, BOTTOM)
    color_this(core_color)
    cube([
      width - (wall_thickness * 2),
      width - (wall_thickness * 2),
      inches(0.5)
    ], anchor = CENTER + BOTTOM) {
      up(inches(0.5) - 2)
      attach(BOTTOM, BOTTOM)
      tag("remove")
      color_this(core_color)
      cube([width - 10, width - 10, inches(1)]);

      children();
    }
  }
}

module internal() {
  base()

  // Core
  attach(TOP, BOTTOM)
  color_this(core_color)
  prismoid(
    size1=[width - inches(0.5), width - inches(0.5)],
    size2=[width - inches(1), width - inches(1)],
    h=height - inches(1.5),
    anchor = CENTER+BOTTOM
  ) {
    down(10)
    position(BOTTOM)
    color_this(core_color)
    tag("remove")
    prismoid(
      size1=[width - inches(0.75), width - inches(0.75)],
      size2=[width - inches(1.25), width - inches(1.25)],
      h=height - inches(1.75),
      anchor = CENTER+BOTTOM
    );

    // LED Strips
    for (side = [FRONT, BACK, LEFT, RIGHT])
      attach(side, BACK)
      xcopies(n = 3, l = 30)
      led_strip(3);

    // Wire Holes
    for (side = [FRONT, BACK])
      position(BOTTOM + side)
      color_this(core_color)
      tag("remove")
      cube([inches(2), 5, 5], anchor = CENTER);

    // Wire Holes
    for (side = [LEFT, RIGHT])
      position(BOTTOM + side)
      color_this(core_color)
      tag("remove")
      cube([inches(2), 5, 5], anchor = CENTER, spin = 90);
  }
}

module led_strip(length = 1) {
  ycopies(n = length, l = (length - 1) * 100)
  color_this("white")
  cube(
    [
      led_strip_width,
      0.5,
      100
    ],
    anchor = CENTER
  ) {
    attach(FRONT, BACK)
    ycopies(n = 3, l = 65)
    color_this(led_color)
    cube([5, 1.5, 5]);

    position(FRONT+TOP)
    xcopies(n = 4, l = 8)
    color_this("gold")
    cube([1.5, 0.5, 2.5], anchor=BACK+TOP);

    position(FRONT+BOTTOM)
    xcopies(n = 4, l = 8)
    color_this("gold")
    cube([1.5, 0.5, 2.5], anchor=BACK+BOTTOM);
  }
}

internal();
up(inches(0.5)) cover();
