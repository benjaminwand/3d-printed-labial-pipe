data = [[30.35, 110]];  // heights and diameters of tubes

for (i = [0 : len(data) - 1])
difference(){
    cylinder(data[i][1], data[i][0]/2 + 1.2, data[i][0]/2 + 1.2);
    translate([0, 0, -1]) cylinder(data[i][1]+2, data[i][0]/2, data[i][0]/2);
}