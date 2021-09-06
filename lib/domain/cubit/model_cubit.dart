import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/base_model.dart';

part 'model_state.dart';

abstract class ModelCubit<M extends BaseModel> extends Cubit<ModelState> {
  bool lockLoading = false;

  bool get loadingLocked => state is ModelsLoading && lockLoading;

  ModelCubit(ModelState initialState) : super(initialState);

  Future<List<M>> load({bool lockLoading = false, bool emitLoading = true}) async {
    if (loadingLocked) return [];
    this.lockLoading = lockLoading;

    return await loadInternal(emitLoading);
  }

  Future<void> save(M model) async {
    await saveInternal(model);
  }

  Future<List<M>> loadInternal(bool emitLoading);
  Future<void> saveInternal(M model);
}
