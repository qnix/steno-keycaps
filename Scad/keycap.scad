$fn = 24;

stem_wid = 5.4;
stem_radius = stem_wid / 2.0;
stem_high = 7.56;

corner_rv = 2.0;

// kepcap dimension
kc_width = 18.36;

// The (cutout) hole size
spoke_wid = 1.30;
spoke_len = 4.40;
spoke_height = 8.2;

module round_box(xv, yv, zv, center, rv) {
  width = xv;
  length = yv;
  height = zv;
  dx = (width - (rv * 2.0)) / 2.0;
  dy = (length - (rv * 2.0)) / 2.0;

  translate([dx, dy, 0]) cylinder(h=height, r1=rv, r2=rv, center=center);
  translate([-dx, dy, 0]) cylinder(h=height, r1=rv, r2=rv, center=center);
  translate([dx, -dy, 0]) cylinder(h=height, r1=rv, r2=rv, center=center);
  translate([-dx, -dy, 0]) cylinder(h=height, r1=rv, r2=rv, center=center);
  cube(size=[width - 2*rv, length, height], center=center);
  cube(size=[width, length-2*rv, height], center=center);
}

module keycap(nu, corner_rv) {
  center = true;
  union () {
    difference() {
      // keycap
      round_box(kc_width, kc_width * nu, stem_high, center, corner_rv);
      translate([0, 0, 2.0]) {
        round_box(kc_width - 4, kc_width * nu - 4, stem_high, center, corner_rv);
      }
    }

    // The stem
    dz = 0.4;
    translate([0, 0, dz / 2])
    difference() {
      round_box(stem_wid, stem_wid * 1.2, stem_high - dz, center, corner_rv / 3);
      union() {
        cube(size=[spoke_wid, spoke_len, spoke_height - dz], center=center);
        cube(size=[spoke_len, spoke_wid, spoke_height - dz], center=center);
      }
    }
  }
}

module letter(c) {
  rotate([180, 0, 90]) {
    translate([0, 0, -0.4])
      linear_extrude(height = 0.4) {
        text(c, size=8, font="Monaco:style=Regular", halign="center", valign="center");
    }};
}

module thumb_letter(c) {
  rotate([180, 0, 0]) {
    translate([0, 0, -0.4])
      linear_extrude(height = 0.4) {
        text(c, size=8, font="Monaco:style=Regular", halign="center", valign="center");
    }};
}

// translate([(kc_width + 4) * 0, 0, 0]) keycap(1.0);
// translate([(kc_width + 4) * 1, 0, 0]) keycap(1.5);
// translate([(kc_width + 4) * 2, 0, 0]) keycap(2.0);


module key(c) {
  difference() {
    translate([0, 0, stem_high / 2]) keycap(1, corner_rv);

    rotate([180, 0, 90]) {
      translate([0, 0, -0.4])
        linear_extrude(height = 0.41) {
          text(c, size=8, font="Monaco:style=Regular", halign="center", valign="center");
      }};
  }
}


module thumb_key(c, nu, corner_rv) {
  difference() {
    translate([0, 0, stem_high / 2]) keycap(nu, corner_rv);

    rotate([180, 0, 0]) {
      translate([0, 0, -0.4])
        linear_extrude(height = 0.41) {
          text(c, size=8, font="Monaco:style=Regular", halign="center", valign="center");
      }};
  }
}

// key("A");
// letter("A");

// thumb_key("U", 1.5, 3.0);
// thumb_letter("U");

// translate([0, 0, stem_high / 2]) keycap(1.5, corner_rv);
