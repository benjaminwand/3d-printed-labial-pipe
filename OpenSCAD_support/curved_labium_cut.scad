// curved labium cut

module curved_labium_cut(){
    union(){
        rotate([0, 0, 90-labium_angle/2])
            rotate_extrude(angle=labium_angle, $fn=50) 
                polygon(points = labium_polygon_points);
        intersection(){
            rotate_extrude($fn=50) 
                polygon(points = labium_polygon_points);
            translate([labiumX*-0.25, -outerDiameter, 0]) 
                minkowski(){
                      cube([labiumX/2, outerDiameter, outerDiameter]);
                      cylinder(r=labiumX/4,h=outerDiameter);
                }
        }
    }
}