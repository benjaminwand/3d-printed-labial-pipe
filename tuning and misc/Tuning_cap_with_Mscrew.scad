// pipe
outerDiameter = 24.9;     
innerDiameter = 22.5;

// screw
screwDiameter = 3;

// pipe specifics
minWallThickness = 0.8;

// proportions, don't touch!
innerPartHeight = 5 + innerDiameter/4;
capHeight = innerDiameter;
fnBig = round(outerDiameter/2) + 30;
echo(fnBig=fnBig);
fnSmall = round(outerDiameter/15) + 20;
echo(fnSmall=fnSmall);


// inner part
intersection(){
    union(){
        rotate_extrude($fn = fnBig)        
            translate([innerDiameter/2 - minWallThickness, 0, 0]) 
                square([minWallThickness, innerPartHeight], false); 
        rotate_extrude($fn = fnBig)        
            translate([innerDiameter/2 - minWallThickness, 0, 0])    
                square([minWallThickness + (outerDiameter - innerDiameter)/3, minWallThickness], false);   
        for (i = [0, 120, 240]) rotate([0, 0, i]) 
            linear_extrude (innerPartHeight) 
                translate([- minWallThickness/2, 0, 0]) 
                    square([minWallThickness, innerDiameter/2 - 0.1], false);
        cylinder(innerPartHeight, screwDiameter/2 + minWallThickness, screwDiameter/2 + minWallThickness, false, $fn = fnSmall);
    };
    rotate_extrude($fn = fnBig)  
        polygon(points=[
            [screwDiameter/2, 0],
            [outerDiameter * 0.8, 0],
            [screwDiameter/2 + minWallThickness, innerPartHeight],
            [screwDiameter/2, innerPartHeight],
        ]);
};

// outer part
translate([outerDiameter + 2 * minWallThickness, 0, 0])
    rotate_extrude($fn = fnBig)  
        polygon(points=[
            [screwDiameter/2, 0],
            [outerDiameter * 0.5 + minWallThickness + 0.1, 0],
            [outerDiameter * 0.5 + minWallThickness + 0.1, capHeight],
            [outerDiameter * 0.5 + 0.1, capHeight],
            [outerDiameter * 0.5 + 0.1, minWallThickness],
            [screwDiameter/2 + minWallThickness, minWallThickness],
            [screwDiameter/2 + minWallThickness, 3 * minWallThickness],
            [screwDiameter/2, 3 * minWallThickness],
        ]);