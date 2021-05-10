//ENSURE MODELS HAVE CONVERTIBLE TO JSON OBJECTS FOR USE IN DIO METHODS
abstract class BaseModel<T> {
  Map<String, dynamic> toJson();

  T fromJson(Map<String, dynamic> json);
}
