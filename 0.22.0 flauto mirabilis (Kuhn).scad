// Flauto mirabilis (Kuhn) / Vox Maris (Hey)
// Instructions: insert values, render, print, test. In case your print fails, use file 0.23 which will five you a similar pipe but you need a screw and it is easier to print.

// variables

// tube and pipe
outerDiameter = 25;
innerDiameter = 22.5;
tube = 8;

// pipe specefics
minWallThickness = 0.8;
minAirway = 2.5;
flueWidth = 0.35;

// proportions, don't touch!
midDiameter = (outerDiameter + innerDiameter)/2;
stuckWidth = 3 + outerDiameter/20;  // for labium
stuckIn = tube/2 + outerDiameter/20;
echo(stuckIn=stuckIn);

// lower part
difference(){
    hull(){rotate_extrude($fn = 50)        
        hull(){
            translate([midDiameter/2, minWallThickness + minAirway/2, 0]) circle(minAirway/2 + minWallThickness, $fn = 30);
            translate([midDiameter/2, tube + minAirway, 0]) square([minWallThickness * 2 + flueWidth, minWallThickness * 2], true);  
        };  
    };   
// minus
    union(){
        translate([0, 0, -0.1]) cylinder(tube + 0.2, tube/2 + 0.1, tube/2, false, $fn = 30);
        translate([0, 0, tube])cylinder(minAirway, tube/2, minAirway, false);
        for (i = [0 : 30 : 330])
            rotate([0, 0, i])
                hull(){
                    translate([midDiameter/2, 0, minWallThickness + minAirway/2]) sphere(minAirway/2, $fn = 10);
                    translate([tube/2, 0, tube + minAirway/2]) sphere(minAirway/2, $fn = 10);
                };    
        for (i = [0 : 30 : 150])
            rotate([0, 0, i])
                hull(){
                    translate([-tube/2, 0, tube + minAirway/2]) sphere(minAirway/2, $fn = 10);
                    translate([tube/2, 0, tube + minAirway/2]) sphere(minAirway/2, $fn = 10);
                };
        rotate_extrude($fn = 50)        
            hull(){
                translate([midDiameter/2, minWallThickness + minAirway/2, 0]) circle(minAirway/2, $fn = 10);
                translate([midDiameter/2, tube + minAirway, 0]) square(flueWidth, true);  
            };
        rotate_extrude($fn = 50)        
            translate([midDiameter/2 - flueWidth/2, tube, 0]) square([flueWidth, tube * 2], false);   
    };
};

// upper part
translate([0, 0, tube + minAirway]) cylinder (outerDiameter/2, outerDiameter/20 +  minWallThickness * 2, minWallThickness * 2, false, $fn = 20);
intersection(){
    for (i = [0, 120, 240])
        rotate([0, 0, i])
            hull(){
                translate([0, innerDiameter/2, tube + outerDiameter 
               * 0.6 + innerDiameter/2 + minWallThickness]) sphere (minWallThickness, $fn = 10);
                translate([0, 0, tube + minAirway + outerDiameter/2]) sphere (minWallThickness * 2, $fn = 10);
            };  
    translate([0, 0, tube + outerDiameter/2]) cylinder(outerDiameter, innerDiameter/2, innerDiameter/2);        
};
intersection(){
    for (i = [30 : 120 : 280])
        rotate([0, 0, i])
    rotate([0, 270, 0])linear_extrude(height=innerDiameter/2, center = false) 
        polygon(points=[
            [tube + outerDiameter * 0.6 + innerDiameter/2 + minWallThickness, -minWallThickness],
    [tube + outerDiameter * 0.6 + innerDiameter/2 + minWallThickness, minWallThickness],
            [tube + outerDiameter * 1.25  + innerDiameter/2 , outerDiameter/2],
            [tube + outerDiameter * 1.25 + innerDiameter/2 ,-outerDiameter/2]]);
        rotate_extrude($fn = 50)        
            translate([innerDiameter/2 - minWallThickness, tube +  outerDiameter * 0.6 + innerDiameter/2, 0]) square([minWallThickness, innerDiameter], false);   
};    

// labium
translate([outerDiameter * 0.8, - outerDiameter * 0.8, stuckWidth])
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