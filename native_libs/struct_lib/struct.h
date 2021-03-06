char* getName();

char* reverse(char* str, int length);

struct Coordinate {
	double latitude;
	double longitude;
};

struct Place {
	char* name;
	struct Coordinate* coordinate;
};

struct Coordinate* create_coordinate(double latitude, double longitude);
struct Place* create_place(char* name, double latitude, double longitude);