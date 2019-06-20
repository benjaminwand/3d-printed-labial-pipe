// curves flue that is made with polyhedron

module outer_elliptic_loft(){
    union(){
        hull(){
        	translate([airSupplyX, airSupplyY, ground]) rotate([0, 0, 90/flueSteps])
                cylinder(h=0.1, d=(outerTube + 2 * minWallThickness), center=true, $fn=(2*flueSteps));
        	translate([airSupplyX, airSupplyY, (ground + tubeInsert)])rotate([0, 0, 90/flueSteps])
                cylinder(h=0.1, d=(outerTube + 2 * minWallThickness), center=true, $fn=(2*flueSteps));
        };
        loft(flueloft_upper_outer_points, flueloft_lower_outer_points, number_of_layers);
    };
};

module inner_elliptic_loft(){
    union(){
        hull(){
        	translate([airSupplyX, airSupplyY, ground-0.1]) 
                cylinder(h=0.1, d=innerTube, center=true);
        	translate([airSupplyX, airSupplyY, (ground + tubeInsert + 0.1)])
                cylinder(h=0.1, d=innerTube, center=true);
        };
        loft(flueloft_upper_inner_points, flueloft_lower_inner_points, number_of_layers);
    };
};




module elliptic_loft_fill(){
    intersection(){
        loft(fill_upper_points, fill_lower_points, number_of_layers);
        translate([0, 0, ground])
            difference(){
                cylinder(height, d=(2*outerDiameter)); 
                translate([0, 0, -0.1]) cylinder((height + 0.2), d=(outerDiameter)); 
        }
    }    
};



module inner_elliptic_loft_fill(){
    intersection(){
        loft(inner_fill_lower_points, inner_fill_upper_points, number_of_layers);          
        cylinder(height, outerDiameter/2, outerDiameter/2, true); 
    };    
};