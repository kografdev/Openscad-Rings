inner_diamter = 20;
thickness = 1;
min_height = 5;
max_height = 10;
faceplate_width = 10;

$fn = $preview ? 20: 100;


rounding_radius = thickness/2;
inner_radius = inner_diamter/2;
ring_offset = inner_radius+rounding_radius;

growing_height = max_height-min_height;
max_offset = max_height/2-rounding_radius;
min_offset = min_height/2-rounding_radius;
growing_offset = growing_height/2;

stepsize_default = 360/$fn;

stop_angle = 2*asin((faceplate_width/2)/sqrt(ring_offset^2+(faceplate_width/2)^2));
growing_ratio = (180-stop_angle)/180;
stepsize_growing = (180-stop_angle)/ceil((180-stop_angle)/stepsize_default);
startstep_growing = -180+stop_angle;
laststep_growing = 180-stop_angle-stepsize_growing;

stepsize_faceplate = stop_angle/ceil(stop_angle/stepsize_default);
startstep_faceplate_half_1 = 180-stop_angle;
stopstep_faceplate_half_1 = 180-stepsize_faceplate/2;
startstep_faceplate_half_2 = 180;
stopstep_faceplate_half_2 = 180+stop_angle-stepsize_faceplate/2;

faceplate_position_x = cos(startstep_faceplate_half_2)*ring_offset;
faceplate_position_y = sin(startstep_faceplate_half_2)*ring_offset;

faceplate_offset = faceplate_width/2-rounding_radius;
faceplate_offset_half_1 = faceplate_offset;
faceplate_offset_half_2 = -faceplate_offset;

union(){
    union(){
	for(i=[startstep_growing:stepsize_growing:laststep_growing]){
	    hull(){
		translate([cos(i)*ring_offset, sin(i)*ring_offset, min_offset+(cos((i-startstep_growing)/growing_ratio)+1)/2*growing_offset])
		sphere(r=rounding_radius);
		translate([cos(i)*ring_offset, sin(i)*ring_offset, -min_offset-(cos((i-startstep_growing)/growing_ratio)+1)/2*growing_offset])
		sphere(r=rounding_radius);
		translate([cos(i+stepsize_growing)*ring_offset, sin(i+stepsize_growing)*ring_offset, min_offset+(cos((i+stepsize_growing-startstep_growing)/growing_ratio)+1)/2*growing_offset])
		sphere(r=rounding_radius);
		translate([cos(i+stepsize_growing)*ring_offset, sin(i+stepsize_growing)*ring_offset, -min_offset-(cos((i+stepsize_growing-startstep_growing)/growing_ratio)+1)/2*growing_offset])
		sphere(r=rounding_radius);
	    }
	}
    }
    union(){
	for(i=[startstep_faceplate_half_1:stepsize_faceplate:stopstep_faceplate_half_1]){
	    hull(){
		translate([cos(i)*ring_offset, sin(i)*ring_offset, max_offset])
		sphere(r=rounding_radius);
		translate([cos(i)*ring_offset, sin(i)*ring_offset, -max_offset])
		sphere(r=rounding_radius);
		translate([cos(i+stepsize_faceplate)*ring_offset, sin(i+stepsize_faceplate)*ring_offset, max_offset])
		sphere(r=rounding_radius);
		translate([cos(i+stepsize_faceplate)*ring_offset, sin(i+stepsize_faceplate)*ring_offset, -max_offset])
		sphere(r=rounding_radius);
		translate([faceplate_position_x, faceplate_position_y+faceplate_offset_half_1, max_offset])
		sphere(r=rounding_radius);
		translate([faceplate_position_x, faceplate_position_y+faceplate_offset_half_1, -max_offset])
		sphere(r=rounding_radius);
	    }
	}
    }
    union(){
	for(i=[startstep_faceplate_half_2:stepsize_faceplate:stopstep_faceplate_half_2]){
	    hull(){
		translate([cos(i)*ring_offset, sin(i)*ring_offset, max_offset])
		sphere(r=rounding_radius);
		translate([cos(i)*ring_offset, sin(i)*ring_offset, -max_offset])
		sphere(r=rounding_radius);
		translate([cos(i+stepsize_faceplate)*ring_offset, sin(i+stepsize_faceplate)*ring_offset, max_offset])
		sphere(r=rounding_radius);
		translate([cos(i+stepsize_faceplate)*ring_offset, sin(i+stepsize_faceplate)*ring_offset, -max_offset])
		sphere(r=rounding_radius);
		translate([faceplate_position_x, faceplate_position_y+faceplate_offset_half_2, max_offset])
		sphere(r=rounding_radius);
		translate([faceplate_position_x, faceplate_position_y+faceplate_offset_half_2, -max_offset])
		sphere(r=rounding_radius);
	    }
	}
    }
}

