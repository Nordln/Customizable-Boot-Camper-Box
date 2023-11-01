/* [Preset Camper Box Dimensions] */

// Plyboard thickness
Wood_thickness = 2.5;

// Height from cabin floor
Camperbox_height = 31;

// From left wheel-arch to right wheel-arch
Camperbox_width = 119;

// Camperbox leg Instep (to clear wheel arches etc)
Camperbox_leg_instep = -4; 

// From boot to folded seat (first top section)
Boot_to_folded_seat = 61;

// From start of folded seat to end of folded seat inc head rest (second top section)
Folded_seat_to_seat_head = 61; 

// From top of folded headrest to seat back (third top section)
Seat_head_to_frontseat = 61; 


/* [Visibility settings] */

// Show component parts
Show_helpers = 0; // [0:"Box", 1:"Cut guide"]

// Show camperbox as folded/unfolded
State = "unfolded"; // [folded, unfolded]
Wood_thicknessop2_a = (State == "unfolded") ? 0 : 180; // angle of top2 (180 = folded, 0 = unfolded)
Wood_thicknessop3_a = (State == "unfolded") ? 0 : -180; // angle of top3 (-180 = folded 0 = unfolded)

/* [Stock wood sizes] */
Stock_wood_length = 244; // long-side length
Stock_wood_thickness = Wood_thickness; // thickness
Stock_wood_width = 122; // short-side width

//module __Customizer_Limit__ () {}
/* [Hidden] */

// Global rescaler (X*1)
rescaler = 1; 

// Min. facet render level 
$fs = 0.1;  // Don't generate smaller facets than 0.1

// Min angles render level (deg)
$fa = 5;    // Don't generate larger angles than 5 degrees

// Horiz. spacing between debug parts
debug_spacing_y = 15;

// Vert. spacing between debug parts
    
debug_spacing_z =0; 


/* [top1 dimensions] */

// Thickness of box
top1_x = Boot_to_folded_seat;
// Width of box
top1_y = Wood_thickness;
// Height of box
top1_z = Camperbox_width; 


/* [top2 dimensions] */

// Thickness of box
top2_x = Folded_seat_to_seat_head;
// Width of box 
top2_y = Wood_thickness;
// Height of box
top2_z = Camperbox_width; 


/* [top3 dimensions] */

// Thickness of box
top3_x = Seat_head_to_frontseat;
// Width of box
top3_y = Wood_thickness;
// Height of box
top3_z = Camperbox_width; 


/* [lside dimensions] */

// Thickness of box
lside_x = Boot_to_folded_seat;
// Width of box
lside_y = Wood_thickness;
// Height of box
lside_z = Camperbox_height; 


/* [rside dimensions] */

// Thickness of box
rside_x = Boot_to_folded_seat;
// Width of box
rside_y = Wood_thickness;
// Height of box
rside_z = Camperbox_height; 

// Main geometry
if (Show_helpers == 0) camperbox();


// Core geometric primitives

module lside(arg = "") {
    color("blue") cube([lside_x,lside_y,lside_z], center=true);
    if (arg == "show_dims") printdims(lside_x,lside_y,lside_z);
}

module rside(arg = "") {
    color("red") cube([rside_x,rside_y,rside_z], center=true);
    if (arg == "show_dims") printdims(rside_x,rside_y,rside_z);
}

module top1(arg = "") {
    color("yellow") cube([top1_x,top1_y,top1_z], center=true);
    if (arg == "show_dims") printdims(top1_x,top1_y,top1_z);
}

module top2(arg = "") {
        color("pink") cube([top2_x,top2_y,top2_z], center=true);
        if (arg == "show_dims") printdims(top2_x,top2_y,top2_z);
}

module top3(arg = "") {
    color("orange") cube([top3_x,top3_y,top3_z], center=true);
    if (arg == "show_dims") printdims(top3_x,top3_y,top3_z);
}


// Intermediate components

module top2_3() {
    rotate([0,0,Wood_thicknessop2_a]) 
        union() {
            translate([0+top2_x/2,0-Wood_thickness/2,0]) top2();
            translate([Folded_seat_to_seat_head,0-Wood_thickness,0]) rotate([0,0,Wood_thicknessop3_a]) translate([0+top3_x/2,Wood_thickness/2,0]) top3();
        }
}

module camperbox() {
    translate ([0+Boot_to_folded_seat/2,0-Camperbox_width/2-Camperbox_leg_instep+Wood_thickness/2,0+Camperbox_height/2]) rotate([0,0,0]) lside();
    translate ([0+Boot_to_folded_seat/2,Camperbox_width/2+Camperbox_leg_instep-Wood_thickness/2,0+Camperbox_height/2]) rotate([0,0,0]) rside();
    translate ([0+Boot_to_folded_seat/2,0,Camperbox_height/2 + top1_y/2 + Camperbox_height/2]) rotate([90,0,0]) top1();
    translate ([0+Boot_to_folded_seat,0,Camperbox_height/2 + top2_y/2 + Camperbox_height/2 + Wood_thickness/2]) rotate([90,0,0]) top2_3(); 
}

// debug display 
//***************

// Helpers
if (Show_helpers == 1) helpers();
    
module printdims (x, y, z) {
    rotate([90,0,0]) translate([0-x/2 + 1,0+z/2 - 1,Wood_thickness/2]) color("black") text(str("X: ", x, ", ", "Y: ", y, ", ", "Z: ", z, ", "), size = 4, valign = "top");
}

module helpers() {
    
    // primitives
/*
    translate([0 + lside_x/2, 0 + debug_spacing_y*2 - lside_y/2, debug_spacing_z  * -1]) lside("show_dims");
    translate([0 + rside_x/2, 0 + debug_spacing_y*4 - rside_y/2, debug_spacing_z * -1]) rside("show_dims");
    translate([0 + top1_x/2, 0 + debug_spacing_y*6 - top1_y/2, debug_spacing_z * -1]) top1("show_dims");
    translate([0 + top2_x/2, 0 + debug_spacing_y*8 - top2_y/2, debug_spacing_z * -1]) top2("show_dims");
    translate([0+ top3_x/2, 0 + debug_spacing_y*10 - top2_y/2, debug_spacing_z * -1]) top3("show_dims");
    
 */
    
    translate([0,0, debug_spacing_z * -3])  cube([Stock_wood_length,Stock_wood_thickness,Stock_wood_width]);  // the shop-brought wood for cutting
    translate([0 + top1_x/2, 0 - top1_y/2, (debug_spacing_z * -3) + top1_z/2]) top1("show_dims");
    translate([0 + top2_x/2 + top1_x, 0 - top2_y/2, (debug_spacing_z * -3) + top2_z/2]) top2("show_dims");
    translate([0 + top3_x/2 + top1_x + top2_x, 0 - top2_y/2, (debug_spacing_z * -3) + top3_z/2]) top3("show_dims");
    translate([0 + lside_z/2 + top1_x + top2_x + top3_x, 0 - lside_y/2, (debug_spacing_z  * -3) + lside_x/2]) rotate([0,90,0]) lside("show_dims");
    translate([0 + rside_z/2 + top1_x + top2_x + top3_x, 0 - rside_y/2, (debug_spacing_z  * -3) + rside_x/2 + rside_x]) rotate([0,90,0]) rside("show_dims");
    translate([0 + lside_z/2 + top1_x + top2_x + top3_x + lside_z, 0 - lside_y/2, (debug_spacing_z  * -3) + lside_x/2]) rotate([0,90,0]) lside("show_dims");
    translate([0 + rside_z/2 + top1_x + top2_x + top3_x + lside_z, 0 - rside_y/2, (debug_spacing_z  * -3) + rside_x/2 + rside_x]) rotate([0,90,0]) rside("show_dims");

}


echo(version=version());
// Written by Ed Watson <mail@edwardwatson.co.uk>
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

              