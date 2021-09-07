import 'package:dwarf_flutter/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/base_model.dart';
import '../../../utils/extensions.dart';
import '../../domain/cubit/model_cubit.dart';
import '../components/form_card.dart';

class ModelForm<M extends BaseModel, MC extends ModelCubit<M>> extends StatefulWidget {
  final MC bloc;
  final List<Widget> fields;
  final M item;
  final M Function({required bool deleting}) getCurrentModel;
  final void Function() setSavingState;

  const ModelForm({
    GlobalKey<ModelFormState>? key,
    required this.bloc,
    required this.fields,
    required this.item,
    required this.getCurrentModel,
    required this.setSavingState,
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
    return FormCard(
      child: Form(
        key: _formKey,
        child: Column(
          children: widget.fields
              .asMap()
              .entries
              .map(
                (field) => ListenableProvider.value(
                  value: _controllers[field.key],
                  builder: (context, child) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: field.value,
                    );
                  },
                ),
              )
              .toList()
              .putInBetween(Divider(height: 0)),
        ),
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
