// Flauto mirabilis (Kuhn) / Vox Maris (Hey)
// Instructions: find a screw you want to use, insert values, render, print. The screw needs to be screwed into the lower part from below.

// variables

// import config tube and pipe
include <OpenSCAD_config/config_15pvc.scad>  

// proportions, don't touch!
fnBig = round(outerDiameter/2 + tube/15) + 30;
echo(fnBig=fnBig);
fnSmall = round(outerDiameter/15 + tube) + 20;
echo(fnSmall=fnSmall);
midDiameter = (outerDiameter + innerDiameter)/2;
innerPartHeight = 3 + innerDiameter/4;  // where the screw goes in
labiumEdge = 3 + outerDiameter/20;      
stuckIn = tube/2 + outerDiameter/25;    // of tube
echo(stuckIn=stuckIn);

// lower part
difference(){           // plus
    union(){
        hull(){rotate_extrude($fn = fnBig)        
            hull(){
                translate([midDiameter/2, minWallThickness + minAirway/2, 0]) circle(minAirway/2 + minWallThickness, $fn = fnSmall);
                translate([midDiameter/2, stuckIn + minAirway, 0]) square([minWallThickness * 2 + flueWidth, minWallThickness * 2], true);  
            };  
        };
        rotate_extrude($fn = fnBig)        // curved spacer for screw
            difference(){
                translate([screwDiameter/2, stuckIn + minAirway + minWallThickness]) square(midDiameter/2 - flueWidth/2 - screwDiameter/2);
                translate([midDiameter/2 - flueWidth/2, stuckIn + minAirway + minWallThickness + midDiameter/2 - flueWidth/2 - screwDiameter/2]) circle(midDiameter/2 - flueWidth/2 - screwDiameter/2);
            };    
    };   
// minus
    union(){
        rotate_extrude($fn = fnBig)  
            polygon(points=[
                [0, -1],
                [tube/2, -1],
                [tube/2, stuckIn],
                [screwHeadDiameter/2, stuckIn + minAirway],
                [screwHeadDiameter/2, stuckIn + minAirway + screwHeadHeight],
                [0, stuckIn + minAirway + screwHeadHeight],
            ]);
        for (i = [0 : 30 : 330])
            rotate([0, 0, i])
                hull(){
                    translate([midDiameter/2, 0, minWallThickness + minAirway/2]) sphere(minAirway/2, $fn = fnSmall);
                    translate([tube/2, 0, stuckIn + minAirway/2]) sphere(minAirway/2, $fn = fnSmall);
                };    
        for (i = [0 : 30 : 150])
            rotate([0, 0, i])
                hull(){
                    translate([-tube/2, 0, stuckIn + minAirway/2]) sphere(minAirway/2, $fn = fnSmall);
                    translate([tube/2, 0, stuckIn + minAirway/2]) sphere(minAirway/2, $fn = fnSmall);
                };
        rotate_extrude($fn = fnBig)        
            hull(){
                translate([midDiameter/2, minWallThickness + minAirway/2, 0]) circle(minAirway/2, $fn = fnSmall);
                translate([midDiameter/2, stuckIn + minAirway, 0]) square(flueWidth, true);  
            };
        rotate_extrude($fn = fnBig)        
            translate([midDiameter/2 - flueWidth/2, stuckIn, 0]) square([flueWidth, tube * 2], false);  
    };  
};


// upper part
translate([outerDiameter + 3* minWallThickness, 0, 0])
difference(){
    union(){
        rotate_extrude($fn = fnBig)        
            translate([innerDiameter/2 - minWallThickness, 0, 0]) 
                square([minWallThickness, innerPartHeight], false);   
        for (i = [0, 120, 240]) rotate([0, 0, i]) 
            linear_extrude (innerPartHeight) 
                translate([- minWallThickness/2, -0.1, 0]) 
                    square([minWallThickness, innerDiameter/2], false);
        cylinder(innerPartHeight, screwDiameter/2 + minWallThickness, screwDiameter/2 + minWallThickness, false, $fn = fnSmall);
    };
    translate([0, 0, -1]) cylinder(innerPartHeight + 2, screwDiameter/2, screwDiameter/2, false, $fn = fnSmall);
};
 

// labium
/*
translate([outerDiameter + 3* minWallThickness, 0, innerPartHeight])
    rotate([180, 0, 0])
        rotate_extrude($fn = fnBig)  
polygon(points=[
        [innerDiameter/2, 0],
        [outerDiameter/2, 0],
        [outerDiameter/2, labiumEdge],
        [outerDiameter/2 + minWallThickness, labiumEdge],
        [outerDiameter/2 + minWallThickness, labiumEdge],
        [outerDiameter/2 + minWallThickness, - minWallThickness],
        [midDiameter/2, - labiumEdge]
    ]);*/
