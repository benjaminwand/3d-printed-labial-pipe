// version number
 
module version_number (number)
translate ([outerDiameter*0.5 + minWallThickness, outerDiameter*-0.25, -lengthFlue])
rotate ([90,0,90])
linear_extrude(1) 
text(text=str(number), size=outerDiameter*0.13);

module vertical_version_number (number)
translate ([outerDiameter*0.5 - 0.3 + minWallThickness, outerDiameter*0.05, -lengthFlue])
rotate ([90,-90,90])
linear_extrude(1) 
text(text=str(number), size=outerDiameter*0.15);