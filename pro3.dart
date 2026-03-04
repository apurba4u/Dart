// Author: Apurba Talapatra Ovi
// ID: 0182410012101185
// CSE-63(E)

void main() {
  Map<String, dynamic> student = {
    "name": "Apurba Talapatra Ovi",
    "age": 22,
    "department": "CSE"
  };

  student.forEach((key, value) {
    print("$key: $value");
  });

  student["age"] = 23;

  student.forEach((key, value) {
    print("$key: $value");
  });
}