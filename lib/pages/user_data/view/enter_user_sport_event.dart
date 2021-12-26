

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/bloc/bloc/user_data/user_data_bloc.dart';
import 'package:samrt_health/bloc/state/user_data/user_data_state.dart';
import 'package:samrt_health/cubit/user_data/user_data_cubit.dart';
import 'package:samrt_health/view/chat_bubble.dart';
import 'package:samrt_health/view/widgets/sport_per_week_widget.dart';
import 'package:samrt_health/view/widgets/steps_per_day_widget.dart';

class EnterUserSportEvent extends StatelessWidget {
  EnterUserSportEvent({Key? key}) : super(key: key);
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Card(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _scrollController,
                children: [
                  _getChatItem(text:  "Grate!!!", duration: 500),
                  BlocConsumer<UserDataBloc, UserDataState>(
                    listenWhen: (previous, current) {
                      return false;
                    },
                    listener: (context, state) {},
                    buildWhen: (previous, current) {
                      return false;
                    },
                    builder: (context, state){
                      return _getChatItem(text:  "Your height is ${state.height} and your weight is ${state.weight} ", duration: 1300);
                    },
                  ),
                  _getChatItem(text:  "//TODO COUNT WEIGHT AND HEIGHT", duration: 2000),
                  _getChatItem(text:  "Tell me about your sport and walking information", duration: 2500),
                  _getChatInteractiveWidget(duration: 3000, widget: Row(
                    children: [
                      Expanded(child: StepsPerDayWidget())
                    ],
                  )),
                  _getChatInteractiveWidget(duration: 4000, widget: _getSportPerWeek),

                ],
              )
          ),
        ),
      ),
    );
  }

  Widget _getChatItem({required text, required int duration}){
    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: duration)),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChatBubble(text: text,),
          );
        }
        return Container();
      },);
  }

  Widget _getChatInteractiveWidget({required int duration, required Widget widget}){
    Future.delayed(Duration(milliseconds: duration+100)).then((value) => _scrollToBottom());
    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: duration)),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: widget,
          );
        }
        return Container();
      },);
  }

  Widget get _getSportPerWeek => Column(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [SportPerDayWidget(),
      BlocBuilder<UserDataCubit, StatelessWidget>(builder: (BuildContext context, state) {
        return MaterialButton(onPressed: ()=> context.read<UserDataCubit>().setView(UserDataView.SPORT_EVENT), child: Text("Next"));
      },)
    ],
  );


  void _scrollToBottom(){
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

}
