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
fnBig = round(outerDiameter/2 + tube/15) + 30;
echo(fnBig=fnBig);
fnSmall = round(outerDiameter/15 + tube) + 20;
echo(fnSmall=fnSmall);
midDiameter = (outerDiameter + innerDiameter)/2;
stuckWidth = 3 + outerDiameter/20;  // for labium
stuckIn = tube/2 + outerDiameter/20;
echo(stuckIn=stuckIn);

// lower part
difference(){
    hull(){rotate_extrude($fn = fnBig)        
        hull(){
            translate([midDiameter/2, minWallThickness + minAirway/2, 0]) circle(minAirway/2 + minWallThickness, $fn = fnSmall);
            translate([midDiameter/2, stuckIn + minAirway, 0]) square([minWallThickness * 2 + flueWidth, minWallThickness * 2], true);  
        };  
    };   
// minus
    union(){
        rotate_extrude($fn = fnSmall)  
            polygon(points=[
                [0, -1],
                [tube/2, -1],
                [tube/2, stuckIn],
                [abs(tube/2 - minAirway), stuckIn + minAirway],
                [0, stuckIn + minAirway],
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
translate([0, 0, stuckIn + minAirway]) cylinder (outerDiameter/2, outerDiameter/20 +  minWallThickness * 2, minWallThickness * 2, false, $fn = fnSmall);
intersection(){
    for (i = [0, 120, 240])
        rotate([0, 0, i])
            hull(){
                translate([0, innerDiameter/2, stuckIn + outerDiameter 
               * 0.6 + innerDiameter/2 + minWallThickness]) sphere (minWallThickness, $fn = fnSmall);
                translate([0, 0, stuckIn + minAirway + outerDiameter/2]) sphere (minWallThickness * 2, $fn = fnSmall);
            };  
    translate([0, 0, stuckIn + outerDiameter/2]) cylinder(outerDiameter, innerDiameter/2, innerDiameter/2);        
};
intersection(){
    for (i = [30 : 120 : 280])
        rotate([0, 0, i])
    rotate([0, 270, 0])linear_extrude(height=innerDiameter/2, center = false) 
        polygon(points=[
            [stuckIn + outerDiameter * 0.6 + innerDiameter/2 + minWallThickness, -minWallThickness],
            [stuckIn + outerDiameter * 0.6 + innerDiameter/2 + minWallThickness, minWallThickness],
            [stuckIn + outerDiameter * 1.25  + innerDiameter/2 , outerDiameter/2],
            [stuckIn + outerDiameter * 1.25 + innerDiameter/2 ,-outerDiameter/2]]);
    rotate_extrude($fn = fnBig)        
            translate([innerDiameter/2 - minWallThickness, stuckIn + outerDiameter * 0.6 + innerDiameter/2, 0]) square([minWallThickness, innerDiameter], false);  
};    

// labium
translate([outerDiameter * 0.8, - outerDiameter * 0.8, stuckWidth])
    rotate([180, 0, 0])
        rotate_extrude($fn = fnBig)  
polygon(points=[
        [innerDiameter/2, 0],
        [outerDiameter/2, 0],
        [outerDiameter/2, stuckWidth],
        [outerDiameter/2 + minWallThickness, stuckWidth],
        [outerDiameter/2 + minWallThickness, stuckWidth],
        [outerDiameter/2 + minWallThickness, - minWallThickness],
        [midDiameter/2, - stuckWidth]
    ]);