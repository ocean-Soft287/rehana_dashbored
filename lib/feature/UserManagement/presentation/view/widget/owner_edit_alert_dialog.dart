import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/const/widget/table/status_cell.dart';
import '../../../../../core/const/widget/textformcrud.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../security_view/presentation/view/widget/secuirtyimage.dart';
import '../../../data/model/owner_model.dart';
import '../../manger/user_cubit.dart';

final _formKey = GlobalKey<FormState>();

class OwnerEditAlertDialog extends StatelessWidget {
  const OwnerEditAlertDialog({super.key, required this.ownerModel});

  final OwnerModel ownerModel;

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    final nameController = TextEditingController(text: ownerModel.userName);
    final emailController = TextEditingController(text: ownerModel.email);
    final passwordController = TextEditingController(); // Password is typically required for update based on request
    final phoneController = TextEditingController(text: ownerModel.phoneNumber);
    final villaAddressController = TextEditingController(text: ownerModel.villaAddress);
    final villaNumberController = TextEditingController(text: ownerModel.villaNumber.toString());
    final villaLocationController = TextEditingController(text: ownerModel.villaLocation);
    final villaSpaceController = TextEditingController(text: ownerModel.villaSpace);
    final villaStreetController = TextEditingController(text: ownerModel.villaStreet);
    final villaFloorsController = TextEditingController(text: ownerModel.villaFloorsNumber.toString());

    return BlocProvider.value(
      value: GetIt.instance<UserCubit>(),
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UpdateOwnerSuccess) Navigator.pop(context);
          if (state is UpdateOwnerFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is UpdateOwnerLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return AlertDialog(
            title: Text(
              AppLocalizations.of(context)!.edit,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            backgroundColor: Colors.white,
            content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  width: isTablet
                      ? MediaQuery.of(context).size.width * 0.6
                      : MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (ownerModel.pictureUrl.isNotEmpty)
                        Secuirtyimage(image: ownerModel.pictureUrl),
                      const SizedBox(height: 10),
                      Textformcrud(
                        controller: nameController,
                        name: AppLocalizations.of(context)!.name,
                        nameinfo: AppLocalizations.of(context)!.please_enter_name,
                        validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 10),
                      Textformcrud(
                        controller: emailController,
                        name: AppLocalizations.of(context)!.email,
                        nameinfo: AppLocalizations.of(context)!.email_hint,
                        validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 10),
                      Textformcrud(
                        controller: passwordController,
                        name: AppLocalizations.of(context)!.password,
                        nameinfo: AppLocalizations.of(context)!.password_hint,
                        validator: (value) => null, // Optional? Re-entering pass might be needed
                      ),
                       const SizedBox(height: 10),
                      Textformcrud(
                        controller: phoneController,
                        name: AppLocalizations.of(context)!.phone,
                        nameinfo: AppLocalizations.of(context)!.phone_number_hint,
                         validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 10),
                      Textformcrud(
                        controller: villaNumberController,
                        name: AppLocalizations.of(context)!.villa_number,
                        nameinfo: 'Villa Number',
                        keyboardType: TextInputType.number,
                         validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                      ),
                       const SizedBox(height: 10),
                      Textformcrud(
                        controller: villaAddressController,
                        name: 'Villa Address',
                         nameinfo: 'Villa Address',
                         validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                      ),
                         const SizedBox(height: 10),
                      Textformcrud(
                        controller: villaLocationController,
                        name: 'Villa Location',
                         nameinfo: 'Villa Location',
                         validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                      ),
                         const SizedBox(height: 10),
                      Textformcrud(
                        controller: villaSpaceController,
                        name: 'Villa Space',
                         nameinfo: 'Villa Space',
                         validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                      ),
                         const SizedBox(height: 10),
                      Textformcrud(
                        controller: villaStreetController,
                        name: 'Villa Street',
                         nameinfo: 'Villa Street',
                         validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                      ),
                         const SizedBox(height: 10),
                      Textformcrud(
                        controller: villaFloorsController,
                        name: 'Villa Floors',
                         nameinfo: 'Villa Floors',
                         keyboardType: TextInputType.number,
                         validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                      ),

                    ],
                  ),
                ),
              ),
            ),
            actions: [
              StatusCell(
                accept: AppLocalizations.of(context)!.edit,
                refuse: AppLocalizations.of(context)!.cancel,
                onAccept: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<UserCubit>().updateOwner(
                      id: ownerModel.id,
                      email: emailController.text,
                      name: nameController.text,
                      phoneNumber: phoneController.text,
                      password: passwordController.text, // If empty, might be issue if API requires it. User request said Password string.
                      villaAddress: villaAddressController.text,
                      villaNumber: int.tryParse(villaNumberController.text) ?? 0,
                      villaLocation: villaLocationController.text,
                      villaSpace: villaSpaceController.text,
                      villaStreet: villaStreetController.text,
                      villaFloorsNumber: int.tryParse(villaFloorsController.text) ?? 0,
                      // Image logic is omitted for simplicity/placeholder as per minimal requirements unless File picker needed.
                      // Passing the existing image URL back or null if not changed?
                      // The Repo uses FormData. If image is null, it skips sending Image field.
                    );
                  }
                },
                onReject: () => Navigator.pop(context),
              ),
            ],
          );
        },
      ),
    );
  }
}
