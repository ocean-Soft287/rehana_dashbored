import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../manger/adduser_cubit.dart';
import '../widget/add_account_mangment_mobile.dart';
import '../widget/add_account_mangment_tablet.dart';

class AddAccountMangment extends StatelessWidget {
  const AddAccountMangment({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController address = TextEditingController();
    TextEditingController status = TextEditingController();
    TextEditingController numofvila = TextEditingController();
    TextEditingController date = TextEditingController();

    return BlocProvider(
      create: (context) => GetIt.instance<AdduserCubit>(),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Builder(
              builder: (context) {
                if (constraints.maxWidth < 600) {
                  return AddAccountMangmentMobile(
                    name: name,
                    phone: phone,
                    address: address,
                    status: status,
                    numofvila: numofvila,
                    date: date,
                  );
                } else {
                  return AddAccountMangmentTablet(
                    name: name,
                    phone: phone,
                    address: address,
                    status: status,
                    numofvila: numofvila,
                    date: date,
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
