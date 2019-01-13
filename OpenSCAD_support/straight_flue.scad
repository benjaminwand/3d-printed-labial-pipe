// straight loft and accesoires 

module straightFlueLoft(upperDiameter, lowerDiameter, loftCeiling, loftFloor){
    union(){
        // tube
        hull($fn=(20+outerTube)){
        	translate([0, airSupplyY, loftFloor]) 
                cylinder(h=0.01, d=lowerDiameter, center=true);
        	translate([0, airSupplyY, (ground + tubeInsert)])
                cylinder(h=0.01, d=lowerDiameter, center=true);
        }
        // straight flue
            hull($fn=(20+outerTube)){
            translate ([labiumWidth*-0.45, airSupplyY, loftCeiling]) 
                cylinder (0.01, d=upperDiameter);
            translate ([labiumWidth*0.45, airSupplyY, loftCeiling]) 
                cylinder (0.01, d=upperDiameter);
            translate ([0, airSupplyY, (loftFloor + tubeInsert)]) 
                cylinder (0.01, d=lowerDiameter);
        };
    };
}

module outer_straight_flue(){
    straightFlueLoft(    
        upperDiameter = (flueWidth + 2 * minWallThickness), 
        lowerDiameter = (outerTube + 2 * minWallThickness),
        loftCeiling = 0,
        loftFloor = ground
    );
}

module inner_straight_flue(){
    straightFlueLoft(
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

module straight_flue_loft_20(upperDiameter, lowerDiameter, loftCeiling, loftFloor){
    union(){
        // tube
        hull($fn=(20+outerTube)){
            translate([0, airSupplyY, loftFloor]) 
                cylinder(h=0.01, d=lowerDiameter, center=true);
            translate([0, airSupplyY, (ground + tubeInsert)])
                cylinder(h=0.01, d=lowerDiameter, center=true);
        }
        // straight flue
            hull($fn=(20+outerTube)){
            translate ([labiumWidth*-0.45, airSupplyY, loftCeiling]) 
                cylinder (0.01, d=upperDiameter);
            translate ([labiumWidth*0.45, airSupplyY, loftCeiling]) 
                cylinder (0.01, d=upperDiameter);
            translate ([0, airSupplyY, (loftFloor + tubeInsert)]) 
                cylinder (0.01, d=lowerDiameter);
        };
    };
}

module outer_straight_flue_20(){
    straight_flue_loft_20(    
        upperDiameter = (flueWidth + 2 * minWallThickness), 
        lowerDiameter = (outerTube + 2 * minWallThickness),
        loftCeiling = -outCut,
        loftFloor = ground
    );
}

module inner_straight_flue_20(){
    straight_flue_loft_20(
        upperDiameter = flueWidth, 
        lowerDiameter = innerTube, 
        loftCeiling = 0.1 - outCut, 
        loftFloor = (ground -0.1)
    ); 
}