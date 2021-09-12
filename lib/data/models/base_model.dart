
import '../../utils/extensions.dart';

abstract class BaseModel {
  final int id;
  final int stx;
  
  BaseModel({
    required this.id,
    required this.stx,
  });
  BaseModel.create()
      : this.id = -1,
        this.stx = 1;

  BaseModel.fromMap(Map<String, dynamic> map)
      : this.id = map.getInt("id"),
        this.stx = map.getInt("stx");

  // @mustCallSuper
  // Map<String, dynamic> toMap() {
  //   return {
  //     //"id": id,
  //     "stx": stx,
  //   };
  // }
}
