import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/bloc.dart';
import 'package:samrt_health/const/ui_state.dart';
import 'package:samrt_health/cubit/home/home_ui_cubit.dart';
import 'package:samrt_health/view/bottom_aheet.dart';
import 'package:samrt_health/view/bottom_bar_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (c) => HomeUiCubit(HomeUiState.INITIAL),
      child: BlocBuilder<HomeUiCubit, HomeUiState>(builder: (context, action) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Test"),
            actions: [
              GestureDetector(
                onTap: ()=> context.read<AuthenticationBloc>().add(SignOut()),
                child:  Icon(Icons.six_ft_apart_outlined),
              )
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     // if(action == HomeUiState.BS_SHOW)
          //     // context.read<HomeUiCubit>().action(HomeUiState.BS_HIDE);
          //     // else context.read<HomeUiCubit>().action(HomeUiState.BS_SHOW);
          //     showModalBottomSheet(
          //         context: context,
          //         builder: (context) {
          //           return Container(
          //             color: Colors.red,
          //           );
          //         });
          //   },
          //   tooltip: 'Increment',
          //   child: Icon(Icons.add),
          //   elevation: 2.0,
          // ),

          resizeToAvoidBottomInset: true,
          bottomNavigationBar: BottomBarWithSheet(
            selectedIndex: 0,
            sheetChild:
                const Center(child: Text("Place for your another content")),
            bottomBarTheme: BottomBarTheme(
                mainButtonPosition: MainButtonPosition.middle,
                selectedItemIconColor: Theme.of(context).primaryColor,
                decoration: BoxDecoration()),
            mainActionButtonTheme: MainActionButtonTheme(
              size: 60,
              color: Theme.of(context).primaryColor,
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 35,
              ),
            ),
            onSelectItem: (index) => print('item $index was pressed'),
            items: const [
              BottomBarWithSheetItem(icon: Icons.people),
              BottomBarWithSheetItem(icon: Icons.shopping_cart),
              BottomBarWithSheetItem(icon: Icons.settings),
              BottomBarWithSheetItem(icon: Icons.favorite),
            ],
          ),
          // BottomAppBar(
          //   shape: CircularNotchedRectangle(),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.max,
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: const <Widget>[
          //       BottomBarItem(
          //         icon: Icons.add,
          //         caption: "Test",
          //       ),
          //       BottomBarItem(
          //         icon: Icons.add,
          //         caption: "Test",
          //       ),
          //       BottomBarItem(
          //         icon: Icons.add,
          //         caption: "Test",
          //       ),
          //       BottomBarItem(
          //         icon: Icons.add,
          //         caption: "Test",
          //       ),
          //     ],
          //   ),
          //   // notchedShape: CircularNotchedRectangle(),
          //   color: Colors.blueGrey,
          // ),
          body: Stack(
            children: [
              _getBottomSheet,
              // _getBottomSheet,
              // _getBottomSheet
            ],
          ),
        );
      }),
    );
  }

  Widget get _getBottomSheet => FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return DraggableScrollableSheet(
              maxChildSize: 0.95,
              minChildSize: 0.1,
              initialChildSize: 0.1,
              builder: (context, scrollController) {
                List<Widget> _sliverList(int size, int sliverChildCount) {
                  List<Widget> widgetList = [];
                  for (int index = 0; index < size; index++)
                    widgetList
                      ..add(SliverAppBar(
                        title: Text("Title $index"),
                        pinned: true,
                      ))
                      ..add(SliverFixedExtentList(
                        itemExtent: 50.0,
                        delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              return Container(
                                alignment: Alignment.center,
                                color: Colors.lightBlue[100 * (index % 9)],
                                child: Text('list item $index'),
                              );
                            }, childCount: sliverChildCount),
                      ));

                  return widgetList;
                }

                return CustomScrollView(
                  controller: scrollController,
                  slivers: _sliverList(50, 10),
                );
              });
        },
      );
}
