import 'package:equatable/equatable.dart';

class MovieVideosEntity extends Equatable {
  String name;
  String key;
  String type;

  MovieVideosEntity({
    required this.name,
    required this.key,
    required this.type,
  });

  @override
  List<Object?> get props => [name, key, type];

  @override
  bool? get stringify => true;
}
