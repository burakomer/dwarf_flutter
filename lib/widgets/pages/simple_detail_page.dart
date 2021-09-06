// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../data/models/base_model.dart';
// import '../../domain/cubit/model_cubit.dart';
// import '../components/app_scaffold.dart';
// import '../components/loading_indicator.dart';
// import '../forms/model_form.dart';

// class SimpleDetailPage<M extends BaseModel, MC extends ModelCubit<M>> extends StatelessWidget {
//   final String title;
//   final GlobalKey<ModelFormState> formKey;
//   final MC bloc;
//   final M item;
//   final List<Widget> fields;
//   final Widget actionRow;
//   final M Function() getCurrentModel;
//   final void Function(void Function()) setParentState;

//   bool get isSaving {
//     final formState = formKey.currentState;
//     return formState != null && formState.isSaving;
//   }

//   SimpleDetailPage({
//     required this.title,
//     required this.formKey,
//     required this.bloc,
//     required this.item,
//     required this.fields,
//     required this.actionRow,
//     required this.getCurrentModel,
//     required this.setParentState,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AppScaffold(
//       title: title,
//       body: _buildBody(context),
//       bottomActions: [
//         actionRow,
//       ],
//     );
//   }

//   Widget _buildBody(BuildContext context) {
//     return BlocListener<MC, ModelState>(
//       bloc: bloc,
//       listener: (context, state) {
//         if (state is ModelsReady && isSaving) {
//           Navigator.of(context).pop();
//         } else if (state is ModelsError) {
//           print(state.message);
//         }
//       },
//       child: isSaving
//           ? LoadingIndicator(center: true)
//           : SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   children: [
//                     ModelForm(
//                       bloc: bloc,
//                       key: formKey,
//                       fields: fields,
//                       item: item,
//                       getCurrentModel: getCurrentModel,
//                       setParentState: setParentState,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }
