
// OpenSCAD loft module, with n layers.

module loft(upper_points, lower_points, number_of_layers)   
polyhedron( 
    points = [
        for (i = [0 : number_of_layers])
            for (j = [0 : len(upper_points) - 1])
                [((upper_points[j][0] * (number_of_layers - i) / number_of_layers)
                + (lower_points[j][0] * i / number_of_layers)),
                ((upper_points[j][1] * (number_of_layers - i) / number_of_layers)
                + (lower_points[j][1] * i / number_of_layers)),
                ((upper_points[j][2] * (number_of_layers - i) / number_of_layers)
                + (lower_points[j][2] * i / number_of_layers))]
    ],
    faces = [
        [for (i= [0 : len(upper_points)-1]) i], // Upper plane.
        for (i = [0 : number_of_layers -1])
            for (j = [0 : len(upper_points) - 1]) // Towards lower points.
                [len(upper_points) * i + (j+1)%len(upper_points), 
                len(upper_points) * i + j, 
                len(upper_points) * (i+1) + j],
        for (i = [1 : number_of_layers])
            for (j = [0 : len(upper_points) - 1]) // Towards upper points.
                [len(upper_points) * i + j, 
                len(upper_points) * i + (j+1) % len(upper_points), 
                len(upper_points) * (i-1) + (j+1) % len(upper_points)],
        [for (i= [len(upper_points) * (number_of_layers+1) -1  : -1 : len(upper_points) * number_of_layers ]) i], // Lower plane.
    ]
);