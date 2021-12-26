

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/cubit/user_data/user_data_cubit.dart';
import 'package:samrt_health/pages/user_data/view/widget/height_slider_widget.dart';
import 'package:samrt_health/view/chat_bubble.dart';
import 'package:samrt_health/view/logo_view.dart';
import 'package:samrt_health/view/weight_picker.dart';

class IntroUserDataView extends StatelessWidget {
  IntroUserDataView({Key? key}) : super(key: key);
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            controller: _scrollController,
            children: [
              _getChatItem(text:  "Hi, it is the last action before start!", duration: 500),
              _getChatItem(text:  "Let's fill some information about you ;) ", duration: 1300),
              _getChatItem(text:  "This information will help us create the most appropriate advice for you", duration: 2000),
              _getChatItem(text:  "Please set your height and weight:", duration: 2500),
              _getChatInteractiveWidget(duration: 3000, widget: HeightSliderView()),
              _getChatInteractiveWidget(duration: 4000, widget: _getWeight),
            ],
          )
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

  Widget get _getWeight => BlocBuilder<UserDataCubit, StatelessWidget>(
    builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          WeightPicker(),
          MaterialButton(onPressed: ()=> context.read<UserDataCubit>().setView(UserDataView.SPORT_EVENT), child: Text("Next"))
        ],
      );
    }
  );


  void _scrollToBottom(){
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }


}


