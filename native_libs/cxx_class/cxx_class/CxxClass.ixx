export module ModuleCxxClass;

#  define EXPORT __declspec(dllexport)

export class EXPORT CxxClass {
	int _val;

public:
	CxxClass(int val) : _val(val) {}

	int getNumber() {
		return 321;
	}
};


extern "C" {
	EXPORT CxxClass* MakeCxxClass(int val) {
		return new CxxClass(val);
	}

	EXPORT int getNumber(CxxClass* obj) {
		return obj->getNumber();
	}
}
