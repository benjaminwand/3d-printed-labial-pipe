// curves flue that is made with polyhedron

module outerCurvedLoft2(){
    union(){
        hull(){
        	translate([0, airSupplyY, ground]) rotate([0, 0, 90/flueSteps])
                cylinder(h=0.1, d=(outerTube + 2 * minWallThickness), center=true, $fn=(2*flueSteps));
        	translate([0, airSupplyY, (ground + tubeInsert)])rotate([0, 0, 90/flueSteps])
                cylinder(h=0.1, d=(outerTube + 2 * minWallThickness), center=true, $fn=(2*flueSteps));
        };
        loft(flueloft_upper_outer_points, flueloft_lower_outer_points, number_of_layers);
    };
};

module innerCurvedLoft2(){
    union(){
        hull(){
        	translate([0, airSupplyY, ground-0.1]) 
                cylinder(h=0.1, d=innerTube, center=true);
        	translate([0, airSupplyY, (ground + tubeInsert + 0.1)])
                cylinder(h=0.1, d=innerTube, center=true);
        };
        loft(flueloft_upper_inner_points, flueloft_lower_inner_points, number_of_layers);
    };
};

