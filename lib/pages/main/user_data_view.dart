import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:height_slider/height_slider.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:samrt_health/bloc/bloc/auth/authentication_bloc.dart';
import 'package:samrt_health/bloc/bloc/user_data/user_data_bloc.dart';
import 'package:samrt_health/bloc/bloc/user_db/user_db_bloc.dart';
import 'package:samrt_health/bloc/event/auth/authentication_event.dart';
import 'package:samrt_health/bloc/state/auth/authentication_state.dart';
import 'package:samrt_health/bloc/state/form_submission_status.dart';
import 'package:samrt_health/bloc/state/user_data/user_data_state.dart';
import 'package:samrt_health/models/app_user_model.dart';
import 'package:samrt_health/theme/theme_controller.dart';
import 'package:samrt_health/theme/widget_themes.dart';
import 'package:samrt_health/utils/image.dart';
import 'package:samrt_health/view/base_state_less.dart';
import 'package:samrt_health/view/camera/cameraView.dart';
import 'package:samrt_health/view/loading_view.dart';
import 'package:samrt_health/view/test2.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:samrt_health/bloc/event/user_data/user_data_event.dart';
import '../../main.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';

final _formKey = GlobalKey<FormState>();

class UserData extends BaseStateLess {
  final bool dialogEnabled;
  final UserModel? userModel;

  UserData({this.dialogEnabled = true, this.userModel, Key? key}) : super(key: key);

  final border = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
  );

  Future<void> _showMyDialog(BuildContext context) async {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Stack(
        children: [
          Positioned(
              left: 280,
              right: -300,
              bottom: -300,
              child: Opacity(
                opacity: 0.2,
                child: CustomPaint(
                  painter: RPSCustomPainter2(),
                  size: Size(900, (500 * 0.8666666666666666).toDouble()),
                ),
              )),
          SizedBox(
            height: 300.0,
            width: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    tr(
                      "user_data_text",
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 50.0)),
                TextButton(
                    onPressed: () {
                      // prefs.setBool("if_user_data_aller_shown", true);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      tr("ok_button"),
                      style: GoogleFonts.roboto(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w300),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }

  @override
  Widget build(BuildContext context) {
    print("UPDATED");
    // gyroscopeEvents.listen((GyroscopeEvent event) {
    //   // _scrollController.jumpTo(event.y);
    // });
    // WidgetsBinding.instance!.addPostFrameCallback((_) async {
    //   await showCupertinoModalPopup(context: context, builder: (BuildContext context){
    //     return Text("TEST");
    //   });
    // });
    if (dialogEnabled) {
      Future.wait({Future.delayed(Duration(seconds: 1))}).then((value) {
        if (!(prefs.getBool("if_user_data_aller_shown") ?? false)) {
          _showMyDialog(context);
          prefs.setBool("if_user_data_aller_shown", true);
        }
      });
    }
    var authState = context.read<AuthenticationBloc>().state as Authenticated;
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (BuildContext context, state) {},
      child: BlocListener<UserDataBloc, UserDataState>(listener:
          (BuildContext context, state) {
        if (state.formStatus is SubmissionSuccess) {
          context.read<AuthenticationBloc>().add(CheckLogin());
        }
      }, child:
          BlocListener<UserDataBloc, UserDataState>(
            listener: (context, state){
            },
            child: BlocBuilder<UserDataBloc, UserDataState>(builder: (context, state) {
        return GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                FocusScope.of(context).unfocus();
                TextEditingController().clear();
              },
              child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  bottomNavigationBar: (dialogEnabled)
                      ? state.formStatus is InitialFormStatus ||
                              state.formStatus is SubmissionFailed
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 30),
                              child: ElevatedButton(
                                  child: Text("Start using"),
                                  onPressed: () => _uploadData(context)),
                            )
                          : null
                      : null,
                  body: dialogEnabled
                      ? state.formStatus is InitialFormStatus
                          ? _getBody(context: context, state: state)
                          : state.formStatus is FormSubmitting
                              ? _loadingView(context)
                              : state.formStatus is SubmissionSuccess
                                  ? Center(child: Text("SUCCESS"))
                                  : _getBody(context: context, error: "ERROR", state: state)
                      : _getBody(context: context, state: state)));
      }),
          )),
    );
  }

  void _removeFocus(){
    FocusManager.instance.primaryFocus?.unfocus();
  }
  void _uploadData(BuildContext context){
    if (_formKey.currentState!.validate()) {
      context
          .read<UserDataBloc>()
          .add(UploadData());
    }
  }

  Widget _getBody({required BuildContext context, String? error, required UserDataState state }) {
    return Builder(
      builder: (context) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
                iconTheme: Theme.of(context).iconTheme,
                backgroundColor: Theme.of(context).backgroundColor,
                collapsedHeight: 60,
                pinned: !dialogEnabled,
                floating: false,
                expandedHeight: dialogEnabled? MediaQuery.of(context).size.height / 3: MediaQuery.of(context).size.height / 3,
                stretch: true,
                actions: [
                  state.ifDataChanged?
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: GestureDetector(
                      onTap: ()=> _uploadData(context),
                      child: Icon(Icons.check),
                    ),
                  ): Container()
                ],
                flexibleSpace: dialogEnabled
                    ? FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(0.0),
                                bottomRight: Radius.circular(0.0)),
                            image: DecorationImage(
                              image: AssetImage(
                                  Theme.of(context).brightness == Brightness.light
                                      ? "assets/img/day.jpg"
                                      : "assets/img/night.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                            child: _getUserAvatar,
                          ),
                        ),
                        stretchModes: [
                          StretchMode.blurBackground,
                          StretchMode.zoomBackground
                        ],
                      )
                    : FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: Container(
                          color: Theme.of(context).colorScheme.background,
                          padding: EdgeInsets.only(top: 50, left: 30),
                          child: Column(
                            children: [
                              Text(
                                "EDIT USER",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              _getUserAvatar
                            ],
                          ),
                        ),
                      )),
            SliverToBoxAdapter(
              child: error != null ? _errorWidget(error) : Container(),
            ),
            SliverToBoxAdapter(
              child: Form(
                key: _formKey,
                child: ResponsiveGridRow(
                  children: [
                    ResponsiveGridCol(
                      xs: 12,
                      sm: 4,
                      md: 6,
                      lg: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _getEmailField,
                      ),
                    ),
                    ResponsiveGridCol(
                      xs: 12,
                      sm: 4,
                      md: 6,
                      lg: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _getNameField,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate(
                    [_getAlcohol, _getSmoking, _getGender, _getIsVegan])),
            SliverToBoxAdapter(
              child: ResponsiveGridRow(children: [
                ResponsiveGridCol(
                    xs: 7, sm: 8, md: 8, lg: 5, child: _getHeightSlider),
                ResponsiveGridCol(xs: 5, sm: 4, md: 3, lg: 2, child: _getWeight),
                ResponsiveGridCol(
                  xs: 12,
                  sm: 4,
                  md: 5,
                  lg: 5,
                  child: _getStepsPerDay,
                ),
                ResponsiveGridCol(
                    xs: 12, sm: 5, md: 5, lg: 5, child: _geWeekSportTimeSlider),
                ResponsiveGridCol(
                    xs: 12, sm: 12, md: 7, lg: 7, child: _getBirthday),
              ]),
            ),
          ],
        );
      }
    );
  }

  Widget get _getUserAvatar => BlocBuilder<UserDataBloc, UserDataState>(
        builder: (context, state) {
          var avatar = ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: state.imageFile != null
                  ? Image.file(
                      state.imageFile!,
                      height: 100.0,
                      width: 100.0,
                      fit: BoxFit.cover,
                    )
                  : state.avatar.isNotEmpty
                      ? Image.network(
                          state.avatar,
                          fit: BoxFit.cover,
                          height: 100.0,
                          width: 100.0,
                        )
                      : Container(
                          width: 100,
                          height: 100,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                          child: const Icon(
                            Icons.add,
                            size: 50,
                            color: Colors.white,
                          )));
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 26),
                        child: GestureDetector(
                            onTap: () => _showBottomSheet(context),
                            child: avatar)),
                    Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 26),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(state.name,
                                  style: Theme.of(context).textTheme.headline5),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                state.email,
                              ),
                            ),
                          ],
                        )),
                  ],
                )
              ],
            ),
          );
        },
      );

  Widget _getContainer(
      {required BuildContext context,
      required Widget child,
      required String title,
      double? customHeight}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.all(1),
      child: Card(
        borderOnForeground: true,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                    Text(title, style: Theme.of(context).textTheme.headline6),
              ),
              SizedBox(height: customHeight ?? 150, child: child),
            ],
          ),
        ),
      ),
    );
  }

  var t = 0;

  Widget get _getEmailField => BlocBuilder<UserDataBloc, UserDataState>(
          builder: (BuildContext context, state) {
        return TextFormField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(
              FontAwesomeIcons.at,
              color: Theme.of(context).iconTheme.color!,
            ),
            filled: true,
            fillColor: Theme.of(context).cardColor,
            hintText: tr("emailCaption"),
          ),
          onFieldSubmitted: (v) {
            _formKey.currentState!.validate();
          },
          textInputAction: TextInputAction.next,
          initialValue: state.email,
          validator: (value) =>
              state.isEmailValid ? null : tr("emailErrorText"),
          onChanged: (value) =>
              context.read<UserDataBloc>().add(OnEmailChangeEvent(value)),
        );
      });

  Widget get _getNameField => BlocBuilder<UserDataBloc, UserDataState>(
          builder: (BuildContext context, state) {
        return TextFormField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(
              FontAwesomeIcons.user,
              color: Theme.of(context).iconTheme.color!,
            ),
            filled: true,
            fillColor: Theme.of(context).cardColor,
            hintText: tr("name"),
          ),
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (v) {
            _formKey.currentState!.validate();
          },
          initialValue: state.name,
          validator: (value) => state.isNameValid ? null : tr("nameErrorText"),
          onChanged: (value) =>
              context.read<UserDataBloc>().add(OnNameChangeEvent(value)),
        );
      });

  Widget get _getSmoking => BlocBuilder<UserDataBloc, UserDataState>(
        builder: (BuildContext context, state) {
          List<String> list = [tr("no"), tr("electronic"), tr("ordinary")];
          return Card(
            child: Stack(
              children: [
                Positioned(
                    right: -45,
                    top: 0,
                    child: Opacity(
                        opacity: 0.1,
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Theme.of(context).primaryColor,
                                  Theme.of(context).colorScheme.secondary,
                                ],
                              )),
                        ))),
                ListTile(
                  title: Text(tr("smoking")),
                  trailing: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton<String>(
                      value: list[state.smoke],
                      borderRadius: BorderRadius.circular(10),
                      underline: SizedBox(),
                      elevation: 16,
                        onTap: ()=>_removeFocus(),
                      onChanged: (String? newValue) {
                        _removeFocus();
                        context
                            .read<UserDataBloc>()
                            .add(OnSmokeChangeEvent(list.indexOf(newValue!)));
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );

  Widget get _getIsVegan => BlocBuilder<UserDataBloc, UserDataState>(
        builder: (BuildContext context, state) {
          List<String> list = [tr("usual"), tr("vegan")];
          return Card(
            child: Stack(
              children: [
                Positioned(
                    right: -45,
                    top: 0,
                    child: Opacity(
                        opacity: 0.1,
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Theme.of(context).primaryColor,
                                  Theme.of(context).colorScheme.secondary,
                                ],
                              )),
                        ))),
                ListTile(
                  title: Text(tr("food_preferences")),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton<String>(
                      value: state.isVegan ? list[1] : list[0],
                      borderRadius: BorderRadius.circular(10),
                      underline: const SizedBox(),
                      elevation: 16,
                      onTap: ()=>_removeFocus(),
                      onChanged: (String? newValue) {
                        _removeFocus();
                        context
                            .read<UserDataBloc>()
                            .add(OnVeganChangeEvent(newValue == list[1]));
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );

  Widget get _getGender => BlocBuilder<UserDataBloc, UserDataState>(
        builder: (BuildContext context, state) {
          List<String> list = ["female", "male", "others"];
          return Card(
            child: Stack(
              children: [
                Positioned(
                    right: -45,
                    top: 0,
                    child: Opacity(
                        opacity: 0.1,
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Theme.of(context).primaryColor,
                                  Theme.of(context).colorScheme.secondary,
                                ],
                              )),
                        ))),
                ListTile(
                  title: Text(tr("gender")),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton<String>(
                      value:
                          list.contains(state.gender) ? state.gender : list[0],
                      borderRadius: BorderRadius.circular(10),
                      underline: const SizedBox(),
                      elevation: 16,
                      onTap: ()=>_removeFocus(),
                      onChanged: (String? newValue) {
                        _removeFocus();
                        context
                            .read<UserDataBloc>()
                            .add(OnGenderChangeEvent(newValue!));
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(tr(value)),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );

  Widget get _getAlcohol => BlocBuilder<UserDataBloc, UserDataState>(
        builder: (BuildContext context, state) {
          List<String> list = [tr("no"), tr("rarely"), tr("often")];
          return Card(
            child: Stack(
              children: [
                Positioned(
                    right: -45,
                    top: 0,
                    child: Opacity(
                        opacity: 0.1,
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Theme.of(context).primaryColor,
                                  Theme.of(context).colorScheme.secondary,
                                ],
                              )),
                        ))),
                ListTile(
                  title: Text(tr("drink_alcohol")),
                  trailing: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton<String>(
                      value: list[state.alcohol],
                      borderRadius: BorderRadius.circular(10),
                      underline: SizedBox(),
                      elevation: 16,
                      onTap: ()=>_removeFocus(),
                      onChanged: (String? newValue) {
                        _removeFocus();
                        context
                            .read<UserDataBloc>()
                            .add(OnAlcoholChangeEvent(list.indexOf(newValue!)));
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );


  Widget get _getStepsPerDay => BlocBuilder<UserDataBloc, UserDataState>(
        builder: (BuildContext context, state) {
          return _getContainer(
              context: context,
              customHeight: 300,
              child: Column(
                children: [
                  Text(tr("steps_per_day_description")),
                  NumberPicker(
                    value: state.stepsPerDay.toInt(),
                    minValue: 0,
                    maxValue: 50000,
                    step: 500,
                    selectedTextStyle: TextStyle(
                        fontSize: 22,
                        foreground: Paint()
                          ..shader = WidgetThemes.linearGradient(context)),
                    textStyle: Theme.of(context).textTheme.bodyText1,
                    itemHeight: 70,
                    axis: Axis.horizontal,
                    onChanged: (value) => context
                        .read<UserDataBloc>()
                        .add(OnStetsChangeEvent(value.toDouble())),
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //       image: AssetImage("assets/img/blob.png"),
                    //       fit: BoxFit.fitHeight
                    //     ),
                    //   // borderRadius: BorderRadius.circular(1000),
                    //   // border: Border.all(color: Theme.of(context).colorScheme.primary),
                    // ),
                  ),
                ],
              ),
              title: tr("steps_per_day"));
        },
      );

  Widget get _getBirthday => BlocBuilder<UserDataBloc, UserDataState>(
          builder: (BuildContext context, state) {
        return _getContainer(
            context: context,
            customHeight: 200,
            title: tr("birthday"),
            child: Center(
                child: SfDateRangePicker(
                    minDate: DateTime(1950, 1, 1),
                    maxDate: DateTime(2010, 12, 31),
                    selectionTextStyle: TextStyle(fontSize: 12),
                    initialSelectedDate: DateTime.fromMicrosecondsSinceEpoch(state.birthday*1000),
                    initialDisplayDate: DateTime.fromMicrosecondsSinceEpoch(state.birthday*1000),
                    onSelectionChanged: (v) => context.read<UserDataBloc>().add(
                        OnBirthdayChangeEvent(
                            v.value.millisecondsSinceEpoch)))));
      });

  Widget get _getWeight => BlocBuilder<UserDataBloc, UserDataState>(
        builder: (BuildContext context, state) {
          return _getContainer(
              customHeight: 300,
              context: context,
              title: tr("weight"),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                child: Stack(
                  children: [
                    const Positioned(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(FontAwesomeIcons.caretLeft),
                    )),
                    Positioned.fill(
                        child: Material(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(180)),
                      color: Colors.grey.withOpacity(0.1),
                    )),
                    NumberPicker(
                      value: state.weight.toInt(),
                      minValue: 0,
                      maxValue: 150,
                      itemCount: 6,
                      step: 1,
                      itemWidth: 130,
                      selectedTextStyle: TextStyle(
                          fontSize: 22,
                          foreground: Paint()
                            ..shader = WidgetThemes.linearGradient(context)),
                      textStyle: Theme.of(context).textTheme.bodyText1,
                      itemHeight: 60,
                      axis: Axis.vertical,
                      onChanged: (value) => context
                          .read<UserDataBloc>()
                          .add(OnWeightChangeEvent(value.toDouble())),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/img/blob.png"),
                        ),
                        // borderRadius: BorderRadius.circular(1000),
                        // border: Border.all(color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                ),
              ));
        },
      );

  Widget get _getHeightSlider => BlocBuilder<UserDataBloc, UserDataState>(
        builder: (BuildContext context, state) {
          return _getContainer(
            customHeight: 300,
            context: context,
            title: tr("height"),
            child: HeightSlider(
              height: state.height.toInt(),
              onChange: (val) => {
                context
                    .read<UserDataBloc>()
                    .add(OnHeightChangeEvent(val.toDouble()))
              },
              unit: 'cm', // optional
            ),
          );
        },
      );

  Widget get _geWeekSportTimeSlider => BlocBuilder<UserDataBloc, UserDataState>(
        builder: (BuildContext context, state) {
          return _getContainer(
              customHeight: 200,
              context: context,
              title: tr("sports_per_week"),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(tr("sports_per_week_description")),
                  ),
                  SleekCircularSlider(
                    appearance: CircularSliderAppearance(
                        animationEnabled: true,
                        customWidths: CustomSliderWidths(
                          progressBarWidth: 5,
                        ),
                        counterClockwise: false,
                        infoProperties: InfoProperties(
                          mainLabelStyle: const TextStyle(fontSize: 20),
                          // topLabelText: "label",
                          modifier: (v) =>
                              WidgetThemes.percentageModifier(v, ":00"),
                        ),
                        customColors: CustomSliderColors(
                            trackColor: Theme.of(context).primaryColorLight,
                            dotColor: Colors.transparent,
                            progressBarColors: [
                              Theme.of(context).colorScheme.primary,
                              Theme.of(context).colorScheme.secondary
                            ])),
                    min: 0,
                    max: 6,
                    initialValue: 1,
                    onChangeEnd: (double endValue) => context
                        .read<UserDataBloc>()
                        .add(OnHoursSportChangeEvent(
                            endValue.ceil().toDouble())),
                  ),
                ],
              ));
        },
      );

  Widget _loadingView(BuildContext context) => Column(
        children: [
          Center(child: LoadingView().loadingWhiteBg(context)),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text("SOME TEXT"),
          )
        ],
      );

  Widget _errorWidget(String error) => Container(
        color: Colors.red,
        child: Center(
          child: Text(error),
        ),
      );

  Gender getGenderByString(String s) {
    switch (s.toUpperCase()) {
      case "MALE":
        return Gender.Male;
      case "FEEALE":
        return Gender.Female;
      default:
        return Gender.Others;
    }
  }

  String getGenderString(Gender? gender) {
    switch (gender) {
      case Gender.Male:
        return "MALE";
      case Gender.Female:
        return "FEEALE";
      default:
        return "OTHERS";
    }
  }

  void _picFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );
    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      File cropped = await ImageConvertor().resizePhoto(files.first.path);
      _cropImage(files.first, context);
    } else {
      print("ERROR SELECT PHOTO");
    }
  }

  void _cropImage(File file, BuildContext context) async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: file.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Crop',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            hideBottomControls: true,
            lockAspectRatio: true),
        iosUiSettings: const IOSUiSettings());
    if (croppedFile != null) {
      var cf = await ImageConvertor().compressImage(
          file: croppedFile,
          quality: 30,
          percentage: 30,
          targetWidth: 200,
          targetHeight: 200);
      context.read<UserDataBloc>().add(OnPictureSelected(cf));
    } else {
      const snackBar = SnackBar(content: Text("Error"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void _showBottomSheet(BuildContext context) {
    showAdaptiveActionSheet(
      context: context,
      title: Text(tr("profile_photo")),
      actions: <BottomSheetAction>[
        BottomSheetAction(
            title: Text(tr("take_photo")),
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return const CameraApp(
                  title: 'Str',
                );
              })).then((value) {
                if (value is List<File>) {
                  _cropImage(value.first, context);
                }
              });
            }),
        BottomSheetAction(
            title: Text(tr("select_from_device")),
            onPressed: () {
              Navigator.pop(context);
              _picFile(context);
            }),
      ],
      cancelAction: CancelAction(
          title: Text(tr(
              "cancel"))), // onPressed parameter is optional by default will dismiss the ActionSheet
    );
  }
}
