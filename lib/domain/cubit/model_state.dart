part of 'model_cubit.dart';

@immutable
abstract class ModelState {}

class ModelsNotReady extends ModelState {}

class ModelsLoading extends ModelState {}

class ModelsError extends ModelState {
  final String message;

  ModelsError({
    required this.message,
  });
}

class ModelsReady<M extends BaseModel> extends ModelState {
  final List<M> models;

  ModelsReady({
    required this.models,
  });
}
