// Flauto mirabilis (Kuhn), possibly similar to Vox Maris
// Instructions: insert values, render, print, test. In case your print fails, use file 0.23 which will five you a similar pipe but you need a screw and it is easier to print.

outerDiameter = 25;
innerDiameter = 22.5;
outerTube = 8;
innerTube = 6;
minWallThickness = 0.8;
minAirway = 2.5;
flueWidth = 0.35;

// proportions, don't touch!
midDiameter = (outerDiameter + innerDiameter)/2;

// lower part
difference(){
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
};

// upper part
translate([0, 0, outerTube + minAirway]) cylinder (outerDiameter/2, outerDiameter/20 +  minWallThickness * 2, minWallThickness * 2, false, $fn = 20);
intersection(){
    for (i = [0, 120, 240])
        rotate([0, 0, i])
            hull(){
                translate([0, innerDiameter/2, outerTube + outerDiameter 
               * 0.6 + innerDiameter/2 + minWallThickness]) sphere (minWallThickness, $fn = 10);
                translate([0, 0, outerTube + minAirway + outerDiameter/2]) sphere (minWallThickness * 2, $fn = 10);
            };  
    translate([0, 0, outerTube + outerDiameter/2]) cylinder(outerDiameter, innerDiameter/2, innerDiameter/2);        
};
intersection(){
    for (i = [30 : 120 : 280])
        rotate([0, 0, i])
    rotate([0, 270, 0])linear_extrude(height=innerDiameter/2, center = false) 
        polygon(points=[
            [outerTube + outerDiameter * 0.6 + innerDiameter/2 + minWallThickness, -minWallThickness],
    [outerTube + outerDiameter * 0.6 + innerDiameter/2 + minWallThickness, minWallThickness],
            [outerTube + outerDiameter * 1.25  + innerDiameter/2 , outerDiameter/2],
            [outerTube + outerDiameter * 1.25 + innerDiameter/2 ,-outerDiameter/2]]);
        rotate_extrude($fn = 50)        
            translate([innerDiameter/2 - minWallThickness, outerTube +  outerDiameter * 0.6 + innerDiameter/2, 0]) square([minWallThickness, innerDiameter], false);   
};    
