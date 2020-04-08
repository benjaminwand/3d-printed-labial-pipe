// Flauto mirabilis (Kuhn) / Vox Maris (Hey)
// Instructions: 
// * Find pipe and screw, the screw needs to be a bit longer than the diameter of the pipe. The air tube needs to be at least as thick as the head of the screw.
// * Insert values into the config file, safe, render this file, print.
// * The screw needs to be screwed into the lower part from below.

// import config
include <OpenSCAD_config/config_Wasserrohr.scad>  
//include <OpenSCAD_config/config_grauplastik_25mm.scad> 

// proportions, don't touch!
fnBig = round(outerDiameter/2 + tube/15) + 30;
echo(fnBig=fnBig);
fnSmall = round(outerDiameter/15 + tube) + 20;
echo(fnSmall=fnSmall);
midDiameter = (outerDiameter + innerDiameter)/2;
innerPartHeight = 3 + innerDiameter/4;  // where the screw goes in
stuckIn = tube/2 + outerDiameter/25;    // of tube
echo(stuckIn=stuckIn);
labiumEdge = 3 + outerDiameter/25;
echo(labiumEdge=labiumEdge);
labiumSideHeight = outerDiameter/2.25 - labiumEdge;


// lower part
difference(){           // plus
    union(){
        hull(){rotate_extrude($fn = fnBig)        
            hull(){
                translate([midDiameter/2, minWallThickness + minAirway/2, 0]) circle(minAirway/2 + minWallThickness, $fn = 30);
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
        rotate_extrude($fn = fnSmall)  
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


// inner part
translate([outerDiameter + 2*minWallThickness, 0, 0])
difference(){
    union(){
        rotate_extrude($fn = fnBig)        
                    translate([innerDiameter/2 - minWallThickness, 0, 0]) square([minWallThickness, innerPartHeight], false);   
        for (i = [0, 120, 240]) rotate([0, 0, i]) 
            linear_extrude (innerPartHeight) 
                translate([- minWallThickness/2, 0, 0]) 
                    square([minWallThickness, innerDiameter/2], false);
        cylinder(innerPartHeight, screwDiameter/2 + minWallThickness, screwDiameter/2 + minWallThickness, false, $fn = fnSmall);
    };
    translate([0, 0, -1]) cylinder(innerPartHeight + 2, screwDiameter/2, screwDiameter/2, false, $fn = fnSmall);
};
// labium
translate([outerDiameter + 2*minWallThickness, 0, innerPartHeight])
    rotate_extrude($fn = fnBig)  
        polygon(points=[
            [innerDiameter/2 - minWallThickness, 0],
            [innerDiameter/2, labiumSideHeight],
            [midDiameter/2, labiumSideHeight + labiumEdge],
            [outerDiameter/2, labiumSideHeight],
            [outerDiameter/2, 0]
        ]);
