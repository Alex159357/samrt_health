import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/cubit/user_data/user_data_cubit.dart';

class UserDataPage extends StatefulWidget {
  const UserDataPage({Key? key}) : super(key: key);

  @override
  _UserDataPageState createState() => _UserDataPageState();
}

class _UserDataPageState extends State<UserDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody,
      bottomNavigationBar: _getBottomBar,
    );
  }

  Widget get _getBody => BlocProvider(
        create: (context) => UserDataCubit(),
        child: BlocBuilder<UserDataCubit, StatelessWidget>(
          builder: (context, view) {
            return view;
          },
        ),
      );

  Widget get _getBottomBar => Card(
    child: Container(
          height: 50,
          color: Colors.red,
        ),
  );
}
