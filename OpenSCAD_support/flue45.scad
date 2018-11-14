// straight loft and accesoires 

module flueLoft45(upperDiameter, lowerDiameter, loftCeiling, loftFloor){
    union(){
        // tube
        hull($fn=(20+outerTube)){
        	translate([airSupplyX, airSupplyY, loftFloor]) 
                cylinder(h=0.01, d=lowerDiameter, center=true);
        	translate([airSupplyX, airSupplyY, (ground + tubeInsert)])
                cylinder(h=0.01, d=lowerDiameter, center=true);
        }
        // straight flue
        hull($fn=(20+outerTube)){
            translate([-outCut/sqrt(2), 0, -outCut/sqrt(2)]) rotate([0, 45, 0]) hull(){               
                translate ([labiumWidth*-0.45, airSupplyY, loftCeiling]) 
                    cylinder (0.01, d=upperDiameter);
                translate ([labiumWidth*0.45, airSupplyY, loftCeiling]) 
                    cylinder (0.01, d=upperDiameter);
            };       
            translate ([airSupplyX, airSupplyY, (loftFloor + tubeInsert)]) 
                cylinder (0.01, d=lowerDiameter);
        };
    };
}

module outer_45_flue(){
    flueLoft45(    
        upperDiameter = (flueWidth + 2 * minWallThickness), 
        lowerDiameter = (outerTube + 2 * minWallThickness),
        loftCeiling = 0,
        loftFloor = ground
    );
}

module inner_45_flue(){
    flueLoft45(
        upperDiameter = flueWidth, 
        lowerDiameter = innerTube, 
        loftCeiling = 0.1, 
        loftFloor = (ground-0.1)
    ); 
}

module straight_flue_fill(){
translate ([0, 0, ground])
    intersection(){
        cylinder(height, d=(outerDiameter + 2* minWallThickness));
        translate([labiumWidth*-0.5, airSupplyY  - minWallThickness, 0])
            cube([labiumWidth, 2*minWallThickness, floorThickness + lengthFlue]);
    } 
}