import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/base_model.dart';
import '../../../utils/extensions.dart';
import '../../domain/cubit/model_cubit.dart';
import '../../utils/helpers.dart';

class ModelForm<M extends BaseModel, MC extends ModelCubit<M>> extends StatefulWidget {
  final MC bloc;
  final List<Widget> fields;
  final M item;
  final M Function({required bool deleting}) getCurrentModel;
  final void Function() setSavingState;
  final double fieldPadding;
  final bool shrinkWrap;

  const ModelForm({
    GlobalKey<ModelFormState>? key,
    required this.bloc,
    required this.fields,
    required this.item,
    required this.getCurrentModel,
    required this.setSavingState,
    this.fieldPadding = 16.0,
    this.shrinkWrap = true,
  }) : super(key: key);

  @override
  ModelFormState createState() => ModelFormState(fields);
}

class ModelFormState extends State<ModelForm> {
  final _formKey = GlobalKey<FormState>();

  final List<TextEditingController> _controllers;

  ModelFormState(List<Widget> fields) : _controllers = fields.map((e) => TextEditingController()).toList();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: widget.fieldPadding),
        shrinkWrap: widget.shrinkWrap,
        // primary: !widget.shrinkWrap,
        children: widget.fields
            .asMap()
            .entries
            .map(
              (field) => ListenableProvider.value(
                value: _controllers[field.key],
                builder: (context, child) {
                  return Container(
                    // padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: field.value,
                  );
                },
              ),
            )
            .toList()
            .putInBetween(SizedBox(height: widget.fieldPadding)),
        // .putInBetween(Divider(height: 0), removeLast: false),
      ),
    );
  }

  Future<void> submit({bool deleting = false}) async {
    if (deleting) {
      final response = await showBooleanDialog(context: context, title: "Deleting", message: "Item will be deleted.");
      if (response == null || !response) return;
    }

    final formState = _formKey.currentState;
    if (formState == null) return;
    if (!deleting) {
      if (!formState.validate()) return;
    }
    if (!deleting) formState.save();

    final itemToSave = widget.getCurrentModel(deleting: deleting);

    widget.setSavingState();

    if (itemToSave != widget.item) {
      print("${deleting ? "Deleting" : "Saving"} model...");
      widget.bloc.save(itemToSave);
    } else {
      print("Model is equal.");
      Navigator.of(context).pop();
    }
  }
}
