include <BOSL2/std.scad>
include <./lib/convert.scad>

height = inches(12);
width = inches(3);
wall_thickness = 0.4;


module cover() {
  color("#ffffffaa")
  diff()
  cube([width, width, height], anchor = CENTER + BOTTOM) {
    tag("remove")
    down(wall_thickness)
    position(BOTTOM)
    cube([
      width - (wall_thickness * 2),
      width - (wall_thickness * 2),
      height
    ], anchor = CENTER + BOTTOM);
  }
}

module internal() {
  prismoid(
    size1=[width - inches(0.5), width - inches(0.5)],
    size2=[width - inches(1), width - inches(1)],
    h=height - inches(1),
    anchor = CENTER+BOTTOM
  );
  cube([
    width - (wall_thickness * 2),
    width - (wall_thickness * 2),
    inches(1)
  ], anchor = CENTER + BOTTOM);
}

internal();
cover();
