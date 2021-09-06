import 'package:flutter/material.dart';

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
  ModelFormState createState() => ModelFormState();
}

class ModelFormState extends State<ModelForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FormCard(
      child: Form(
        key: _formKey,
        child: Column(
          children: widget.fields
              .map<Widget>((e) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: e,
                  ))
              .toList()
              .putInBetween(Divider(height: 0)),
        ),
      ),
    );
  }

  Future<void> submit({bool deleting = false}) async {
    if (deleting) {
      final response = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text("Deleting"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Item will be deleted."),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Row(
                    children: [
                      ElevatedButton(onPressed: () => Navigator.of(context).pop(false), child: Text("Cancel")),
                      TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text("Okay")),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
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
