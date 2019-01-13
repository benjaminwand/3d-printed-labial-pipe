// straight labium cut and accesoires

module straight_labium_cut(){
    intersection(){
        translate ([-labiumWidth/2,0,0])
            rotate([90, 0, 90])
                linear_extrude(labiumWidth, $fn=50) 
                    polygon(points = labium_polygon_points);
        translate([labiumWidth*-0.25, 2*airSupplyY - labiumWidth*0.25, 0]) 
            minkowski(){
                cube([labiumWidth/2, -2*airSupplyY, -2*airSupplyY]);
                cylinder(r=labiumWidth/4,h=-2*airSupplyY);
            }
    }
};

module straight_labium_fill(){
    intersection(){
        translate ([-labiumWidth/2,0,0])
            rotate([90, 0, 90])
                linear_extrude(labiumWidth, $fn=50) 
                    polygon(points = labium_plus_points);
        cylinder(outerDiameter, d=outerDiameter);
    }
}

module straight_labium_cut_20(){
    translate ([-labiumWidth/2,0,0])
        rotate([90, 0, 90])
            linear_extrude(labiumWidth, $fn=50) 
                polygon(points = labium_polygon_points);
 };