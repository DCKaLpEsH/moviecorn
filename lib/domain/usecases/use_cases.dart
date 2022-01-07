import 'package:dartz/dartz.dart';
import 'package:moviecorn/domain/entities/app_error.dart';

// This usecase class was created so that everytime we create a new usercase,
// we need to use a method call after extending this class to keep uniformity
// in our code and let other developers know from where the call method is called
// for our actual usecases. ex. gettrending, etc.
abstract class UseCase<Type, Params> {
  Future<Either<AppError, Type>> call(Params params);
}
