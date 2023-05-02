include <BOSL2/std.scad>
include <./lib/convert.scad>

height = inches(13.5);
width = inches(3);
wall_thickness = 0.4;

led_strip_width = 10;
led_strip_height = 2.5;
led_strip_segment_length = 100;

module cover() {
  color("#ffffffaa")
  cube([width, width, height], anchor = CENTER + BOTTOM);
}

module internal() {
  color_this("black")
  cube([
    width - (wall_thickness * 2),
    width - (wall_thickness * 2),
    inches(1)
  ], anchor = CENTER + BOTTOM) {
    attach(TOP, BOTTOM)
    color_this("black")
    prismoid(
      size1=[width - inches(0.5), width - inches(0.5)],
      size2=[width - inches(1), width - inches(1)],
      h=height - inches(1.5),
      anchor = CENTER+BOTTOM
    ) {
      left(15) attach(FRONT, BACK) led_strip(300);
      attach(FRONT, BACK) led_strip(300);
      right(15) attach(FRONT, BACK) led_strip(300);

      left(15) attach(BACK, BACK) led_strip(300);
      attach(BACK, BACK) led_strip(300);
      right(15) attach(BACK, BACK) led_strip(300);

      fwd(15) attach(LEFT, BACK) led_strip(300);
      attach(LEFT, BACK) led_strip(300);
      back(15) attach(LEFT, BACK) led_strip(300);

      fwd(15) attach(RIGHT, BACK) led_strip(300);
      attach(RIGHT, BACK) led_strip(300);
      back(15) attach(RIGHT, BACK) led_strip(300);
    }
  }
}

module led_strip(length = 0, anchor = CENTER, spin = 0, orient = UP) {
  assert(length % led_strip_segment_length == 0, "led strip length must be in increments of 100mm");

  color_this("white")
  cube([led_strip_width, led_strip_height, length], anchor = anchor, spin = spin, orient = orient);
}

internal();
cover();
