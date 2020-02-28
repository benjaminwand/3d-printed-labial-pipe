// flauto mirabilis (Kuhn), possibly similar to Vox Maris ???
outerDiameter = 40;
innerDiameter = 36;
outerTube = 6;
innerTube = 4;
minWallThickness = 0.8;
minAirway = 2.5;
flueWidth = 0.5;

// proportions, don't touch!
midDiameter = (outerDiameter + innerDiameter)/2;

// lower part
difference(){
cylinder(outerTube + minAirway + minWallThickness, midDiameter/2 + minWallThickness + minAirway/2, midDiameter/2 + flueWidth/2 + minWallThickness, $fn = 50);
// minus
    union(){
        translate([0, 0, -0.1]) cylinder(outerTube + 0.2, outerTube/2, outerTube/2, false);
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
                translate([midDiameter/2, outerTube, 0]) square(flueWidth, true);  
            };
        rotate_extrude($fn = 50)        
            translate([midDiameter/2 - flueWidth/2, outerTube, 0]) square([flueWidth, outerTube * 2], false);   
    };
};

// upper part
translate([0, 0, outerTube + minAirway]) cylinder (outerDiameter, outerTube/2, minWallThickness * 2, false);
intersection(){
    for (i = [0 : 60 : 330])
        rotate([0, 0, i])
            hull(){
                translate([0, innerDiameter/2, outerTube + outerDiameter + innerDiameter/2 + minWallThickness]) sphere (minWallThickness, $fn = 10);
                translate([0, 0, outerTube + minAirway + outerDiameter]) sphere (minWallThickness * 2, $fn = 10);
            };  
translate([0, 0, outerTube + outerDiameter]) cylinder(outerDiameter, innerDiameter/2, innerDiameter/2);        
};
intersection(){
    for (i = [30 : 60 : 180])
        rotate([0, 0, i])
    rotate([0, 270, 0])linear_extrude(height=50, center = true) 
        polygon(points=[
            [outerTube + outerDiameter + innerDiameter/2, 0],
            [outerTube + outerDiameter + innerDiameter/2 + outerDiameter/2, outerDiameter/2],
            [outerTube + outerDiameter + innerDiameter/2 + outerDiameter/2,-outerDiameter/2]]);
        rotate_extrude($fn = 50)        
            translate([innerDiameter/2 - minWallThickness, outerTube + outerDiameter + innerDiameter/2 + minWallThickness, 0]) square([minWallThickness, outerDiameter/3], false);   
};    
        