// straight loft and accesoires 

module traverse_flue_loft(upperDiameter, lowerDiameter, loftCeiling, loftFloor){
    union(){
        // tube
        hull($fn=(20+outerTube)){
        	translate([airSupplyX, - outerDiameter/2, loftFloor]) 
                cylinder(h=0.01, d=lowerDiameter, center=true);
        	translate([airSupplyX, - outerDiameter/2, labiumWidth*0.5])
                sphere(d=lowerDiameter);
        }
        // flue
        hull($fn=(20+outerTube)){ 
            translate ([-outCut, - outerDiameter/2, labiumWidth*-0.45]) 
                rotate([0, 90, 0]) cylinder (0.01, d=upperDiameter);
            translate ([-outCut, - outerDiameter/2, labiumWidth*0.45]) 
                rotate([0, 90, 0]) cylinder (0.01, d=upperDiameter);
            translate([airSupplyX, - outerDiameter/2, 0])
                sphere(d=lowerDiameter);
        };
    };
}

module outer_traverse_flue(){
    traverse_flue_loft(    
        upperDiameter = (flueWidth + 2 * minWallThickness), 
        lowerDiameter = (outerTube + 2 * minWallThickness),
        loftCeiling = 0,
        loftFloor = ground
    );
}

module inner_traverse_flue(){
    traverse_flue_loft(
        upperDiameter = flueWidth, 
        lowerDiameter = innerTube, 
        loftCeiling = 0.1, 
        loftFloor = (ground-0.1)
    ); 
}

module high_cut_up_connector(){
    difference(){
        union(){
            hull(){
                translate ([-outCut - minWallThickness, - outerDiameter/2, labiumWidth*0.45]) 
                    rotate([0, 90, 0]) cylinder (minWallThickness, minWallThickness, minWallThickness);
                translate ([-outCut - minWallThickness, - outerDiameter/2, labiumWidth*-0.45]) 
                    rotate([0, 90, 0]) cylinder (minWallThickness, minWallThickness, minWallThickness);
                translate ([-outCut - minWallThickness,  0, ground])
                    cube(minWallThickness);
                translate ([-outCut - minWallThickness, 0, labiumWidth*0.45]) 
                    rotate([0, 90, 0]) cylinder (minWallThickness, minWallThickness, minWallThickness);
            };
            if (connector == 1) 
            hull(){
                translate([airSupplyX, - outerDiameter/2, ground]) 
                    cylinder(h=0.01, d=innerTube, center=true);
                translate([airSupplyX * 0.7 , - outerDiameter/2, 0])
                    cylinder(h=0.01, d=innerTube, center=true); 
                translate ([-outCut - minWallThickness, - outerDiameter/2, labiumWidth*0.45]) 
                    rotate([0, 90, 0]) cylinder (minWallThickness, minWallThickness, minWallThickness);
                translate ([0, 0, ground]) 
                    cylinder (0.01, innerDiameter/2 - minWallThickness);
            };
        };
        cylinder(2 * height, innerDiameter/2 + 0.1, innerDiameter/2 + 0.1, true);
    };
};

module airdome(){
    translate ([airSupplyX, - outerDiameter/2, labiumWidth*0.5])
        sphere (outerTube/2);
};
