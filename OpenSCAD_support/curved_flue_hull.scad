// curved flue loft that is made with hull

module curvedFlueLoft(upperDiameter, lowerDiameter, loftCeiling, loftFloor){
    union(){
        // tube
        hull(){
        	translate([0, airSupplyY, loftFloor]) 
                cylinder(h=0.01, d=lowerDiameter, center=true);
        	translate([0, airSupplyY, (ground + tubeInsert)])
                cylinder(h=0.01, d=lowerDiameter, center=true);
        }
        // curved flue
       	for (a = [(labium_angle*-0.5) : (labium_angle/flueSteps) : (labium_angle*0.5)])
            hull(){
            rotate ([0, 0, a]) 
                translate ([0, (outerDiameter*-0.5), loftCeiling]) 
                    cube ([flueStepWidth, upperDiameter, 0.01], center=true);
            translate ([0, airSupplyY, (loftFloor + tubeInsert)]) 
                cylinder (0.01, d=lowerDiameter);
        };
    };
}

module outerCurvedLoft(){
    curvedFlueLoft(    
        upperDiameter = flueWidth + 2 * minWallThickness, 
        lowerDiameter = outerTube + 2 * minWallThickness,
        loftCeiling = 0,
        loftFloor = ground
    );
}

module innerCurvedLoft(){
    curvedFlueLoft(
        upperDiameter = flueWidth, 
        lowerDiameter = innerTube, 
        loftCeiling = 0.1, 
        loftFloor = (ground-0.1)
    ); 
}
