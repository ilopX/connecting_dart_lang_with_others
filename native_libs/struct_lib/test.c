#include "struct.h"
#include <stdio.h>

int main() {
	printf("getName() return %s\n", getName());

	printf("reverse('ilopX', 5) return %s\n", reverse("ilopX", 5));

	struct Coordinate* coordinate = create_coordinate(11, 11);
	printf("coordinate(latitude: %.2f, longitude: %0.2f)\n", coordinate->latitude, coordinate->longitude);
	
	struct Place* place = create_place("Osolo", 11, 11);
	printf("place(name: %s, latitude: %.2f, longitude: %0.2f)\n", 
		place->name, 
		place->coordinate->latitude, 
		place->coordinate->longitude);
	return 1;
}