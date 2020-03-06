// Flauto mirabilis (Kuhn), possibly similar to Vox Maris
// Instructions: find a screw you want to use, insert values, render, print. The screw needs to be screwed into the lower part first.

outerDiameter = 25;
innerDiameter = 22.5;
outerTube = 8;
innerTube = 6;
minWallThickness = 0.8;
minAirway = 2.5;
flueWidth = 0.35;
screwDiameter = 3;
screwHeadDiameter = 5.6; // be a bit generous here / round up
screwHeadHeight = 2.5;

// proportions, don't touch!
midDiameter = (outerDiameter + innerDiameter)/2;
innerPartHeight = 3 + innerDiameter/4;
stuckWidth = 3 + outerDiameter/20;  // for labium

// lower part
rotate_extrude($fn = 50)        // spacer for screw
difference(){
    translate([screwDiameter/2, outerTube + minAirway + minWallThickness]) square(midDiameter/2 - flueWidth/2 - screwDiameter/2);
    translate([midDiameter/2 - flueWidth/2, outerTube + minAirway + minWallThickness + midDiameter/2 - flueWidth/2 - screwDiameter/2]) circle(midDiameter/2 - flueWidth/2 - screwDiameter/2);
};
difference(){           // plus
    hull(){rotate_extrude($fn = 50)        
        hull(){
            translate([midDiameter/2, minWallThickness + minAirway/2, 0]) circle(minAirway/2 + minWallThickness, $fn = 30);
            translate([midDiameter/2, outerTube + minAirway, 0]) square([minWallThickness * 2 + flueWidth, minWallThickness * 2], true);  
        };  
    };   
// minus
    union(){
        translate([0, 0, -0.1]) cylinder(outerTube + 0.2, outerTube/2 + 0.1, outerTube/2, false, $fn = 30);
        translate([0, 0, outerTube])cylinder(minAirway, outerTube/2, minAirway, false);
        for (i = [0 : 30 : 330])
            rotate([0, 0, i])
                hull(){
                    translate([midDiameter/2, 0, minWallThickness + minAirway/2]) sphere(minAirway/2, $fn = 10);
                    translate([outerTube/2, 0, outerTube + minAirway/2]) sphere(minAirway/2, $fn = 10);
                };    
        for (i = [0 : 30 : 150])
            rotate([0, 0, i])
                hull(){
                    translate([-outerTube/2, 0, outerTube + minAirway/2]) sphere(minAirway/2, $fn = 10);
                    translate([outerTube/2, 0, outerTube + minAirway/2]) sphere(minAirway/2, $fn = 10);
                };
        rotate_extrude($fn = 50)        
            hull(){
                translate([midDiameter/2, minWallThickness + minAirway/2, 0]) circle(minAirway/2, $fn = 10);
                translate([midDiameter/2, outerTube + minAirway, 0]) square(flueWidth, true);  
            };
        rotate_extrude($fn = 50)        
            translate([midDiameter/2 - flueWidth/2, outerTube, 0]) square([flueWidth, outerTube * 2], false);   
    };
    translate([0, 0, outerTube]) cylinder (screwHeadHeight + minAirway, screwHeadDiameter/2, screwHeadDiameter/2, false, $fn = 20);
};


// upper part
translate([outerDiameter + minWallThickness, 0, 0])
difference(){
    union(){
        rotate_extrude($fn = 50)        
                    translate([innerDiameter/2 - minWallThickness, 0, 0]) square([minWallThickness, innerPartHeight], false);   
        for (i = [0, 120, 240]) rotate([0, 0, i]) 
            linear_extrude (innerPartHeight) 
                translate([- minWallThickness/2, 0, 0]) 
                    square([minWallThickness, innerDiameter/2], false);
        cylinder(innerPartHeight, screwDiameter/2 + minWallThickness, screwDiameter/2 + minWallThickness, false, $fn = 20);
    };
    translate([0, 0, -1]) cylinder(innerPartHeight + 2, screwDiameter/2, screwDiameter/2, false, $fn = 20);
};
 

// labium
translate([outerDiameter * 0.6, - outerDiameter, stuckWidth])
    rotate([180, 0, 0])
        rotate_extrude($fn = 50)  
polygon(points=[
        [innerDiameter/2, 0],
        [outerDiameter/2, 0],
        [outerDiameter/2, stuckWidth],
        [outerDiameter/2 + minWallThickness, stuckWidth],
        [outerDiameter/2 + minWallThickness, stuckWidth],
        [outerDiameter/2 + minWallThickness, - minWallThickness],
        [midDiameter/2, - stuckWidth]
    ]);