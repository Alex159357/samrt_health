

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/cubit/home/bottom_nav_cubit.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getBottomNav;
  }

  Widget get _getBottomNav => BlocBuilder<BottomNavCubit, int>(builder: (context, it){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: BottomAppBar(
          color:Colors.redAccent,
          shape: const CircularNotchedRectangle(),
          notchMargin: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: () => context.read<BottomNavCubit>().emit(0),),
              IconButton(icon: Icon(Icons.print, color: Colors.white,), onPressed: () => context.read<BottomNavCubit>().emit(1),),
              IconButton(icon: Icon(Icons.people, color: Colors.white,), onPressed: () => context.read<BottomNavCubit>().emit(2),),
              IconButton(icon: Icon(Icons.people, color: Colors.white,), onPressed: () => context.read<BottomNavCubit>().emit(3),),
            ],
          ),
        ),
      ),
    );
  });

}
