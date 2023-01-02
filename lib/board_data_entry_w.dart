import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'board_class.dart';
import 'app_gs.dart';
import 'g_styles.dart';
import 'package:bigcom_surfboard_poster/main.dart';
import 'package:bigcom_surfboard_poster/bc_api_reqs.dart';

class Board_Data_Entry_W extends StatefulWidget {
  Board_Data_Entry_W({Key? key, this.editItem}) : super(key: key);
  final SurfBoard? editItem;

  _Board_Data_Entry_WState createState() => _Board_Data_Entry_WState();
}

class ItemCardStyle extends TextStyle {
  const ItemCardStyle(
      {double fontSize: 12.0,
      FontWeight? fontWeight,
      Color color: Colors.white,
      double? letterSpacing,
      double? height,
      TextDecoration? decoration})
      : super(
            inherit: false,
            color: color,
            fontFamily: 'Raleway',
            fontSize: fontSize,
            fontWeight: fontWeight,
            textBaseline: TextBaseline.alphabetic,
            letterSpacing: letterSpacing,
            height: height,
            decoration: decoration);
}

class _Board_Data_Entry_WState extends State<Board_Data_Entry_W> {
  Color ider_entryColor = Colors.blueGrey[900]!;
  BoxDecoration ider_boxdec = BoxDecoration(
      color: Colors.blueGrey[900]!,
      border: Border(
          top: BorderSide(color: Colors.tealAccent, width: 1.0),
          bottom: BorderSide(color: Colors.teal, width: 0.5)));
  InputDecoration tfDec = InputDecoration(
      helperStyle: TextStyle(fontSize: 0.0),
      fillColor: Colors.blueGrey[800],
      filled: true,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.0)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightGreenAccent[700]!)));
  BoxDecoration contDec = BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.blueGrey[900]!, width: 1.0));

  // AppState gAppState;

  static setGuipFields() {
    AGS.state_post_item.title = _titleInputController.text;
    AGS.state_post_item.price = _priceInputController.text;
    AGS.state_post_item.description = _descriptionInputController.text;
    AGS.state_post_item.brand = _shaperInputController.text;
    AGS.state_post_item.dimensions!["lengthFeet"] = _dimsInputController1.text;
    AGS.state_post_item.dimensions!["lengthInches"] = _dimsInputController2.text;
    AGS.state_post_item.dimensions!["widthInches"] = _dimsInputController3.text;
    AGS.state_post_item.dimensions!["thicknessInches"] =
        _dimsInputController4.text;
    AGS.state_post_item.dimensions!["volume"] = _volumeInputController.text;
  }

  static final TextEditingController _titleInputController =
      new TextEditingController();
  static final TextEditingController _priceInputController =
      new TextEditingController();
  static final TextEditingController _descriptionInputController =
      new TextEditingController();
  static final TextEditingController _shaperInputController =
      new TextEditingController();
  static final TextEditingController _dimsInputController1 =
      new TextEditingController();
  static final TextEditingController _dimsInputController2 =
      new TextEditingController();
  static final TextEditingController _dimsInputController3 =
      new TextEditingController();
  static final TextEditingController _dimsInputController4 =
      new TextEditingController();
  static final TextEditingController _volumeInputController =
      new TextEditingController();

  static clearFields() {
    _titleInputController.text = " ";
    _priceInputController.text = " ";
    _descriptionInputController.text = " ";
    _shaperInputController.text = " ";
    _dimsInputController1.text = " ";
    _dimsInputController2.text = " ";
    _dimsInputController3.text = " ";
    _dimsInputController4.text = " ";
    _volumeInputController.text = " ";
    AGS.state_post_item.title = " ";
    AGS.state_post_item.description = " ";
    AGS.state_post_item.price = " ";
    AGS.state_post_item.brand = " ";
    AGS.state_post_item.dimensions = {
      "lengthFeet": " ",
      "lengthInches": " ",
      "widthInches": " ",
      "widthFracNumer": " ",
      "widthFracDenom": " ",
      "widthFrac": " ",
      "thicknessInches": " ",
      "thicknessFracNumer": " ",
      "thicknessFracDenom": " ",
      "thicknessFrac": " ",
      "volume": " ",
    };
    AGS.state_post_item.boardType = " ";
    AGS.state_post_item.condition = " ";
    AGS.state_post_item.finBrand = " ";
    AGS.state_post_item.finSetup = " ";
    AGS.state_post_item.localImages = [];
    AGS.state_post_item.itemID = "initItemUUID";
  }

  String? widthFrac;
  String? thickFrac;
  String finSetupVal = AGS.state_post_item.finSetup;
  String finBrandVal = AGS.state_post_item.finBrand;
  String boardTypeVal = AGS.state_post_item.boardType;

  String? conditionText;
  bool? _previewSavePress;

  @override
  void initState() {
    _previewSavePress = false;
    super.initState();
    if (widget.editItem != null) {
      AGS.state_post_item.itemID = widget.editItem!.itemID;
      _titleInputController.text = widget.editItem!.title;
      _priceInputController.text = widget.editItem!.price;
      _descriptionInputController.text = widget.editItem!.description;
      _shaperInputController.text = widget.editItem!.brand;
      _dimsInputController1.text =
          widget.editItem!.dimensions!["lengthFeet"].toString();
      _dimsInputController2.text =
          widget.editItem!.dimensions!["lengthInches"].toString();
      _dimsInputController3.text =
          widget.editItem!.dimensions!["widthInches"].toString();
      _dimsInputController4.text =
          widget.editItem!.dimensions!["thicknessInches"].toString();
      _volumeInputController.text =
          widget.editItem!.dimensions!["volume"].toString();
      finSetupVal = widget.editItem!.finSetup;
      finBrandVal = widget.editItem!.finBrand;
      boardTypeVal = widget.editItem!.boardType;
    }
  }

  Widget build(BuildContext context) {
    print("itemdataentry built");
    Size ss = MediaQuery.of(context).size;
    TextStyle titleStyle = ItemCardStyle(fontSize: 34.0);
    TextStyle descriptionStyle =
        ItemCardStyle(fontSize: 15.0, color: Colors.white, height: 24.0 / 15.0);
    TextStyle headingStyle = ItemCardStyle(
        // color: Color(0xFF4FEDEC),
        color: Colors.white,
        fontSize: ss.width * .04,
        fontWeight: FontWeight.bold,
        height: 24.0 / 15.0);
    TextStyle entryStyle =
        TextStyle(color: Colors.white, fontSize: ss.height * .02);

    TextStyle ddTS = TextStyle(color: Colors.white, fontSize: ss.height * .02);
    BoxDecoration ddContDec = BoxDecoration(
        color: Colors.blueGrey[900]!,
        border: Border.all(color: Colors.white, width: 1.0));
    Widget breakLine = Container(
      width: ss.width,
      // decoration: BoxDecoration(
      // border: Border(top: BorderSide(color: Colors.white, width: 1.0))),
    );
    double entryHeight = ss.height * .08;
    double leftMargin = ss.width * .03;
    double entryWidth = ss.width * .83;
    double dropIconSize = 0.0;
    double paddingHeight = 0.0;

    EdgeInsetsGeometry entryPadding =
        EdgeInsets.fromLTRB(1.0, ss.height * .08, 1.0, ss.height * .08);

    // var asCont = AppStateContainer.of(context);
    // gAppState = asCont.state;
    // _previewSavePress = gAppState.previewRouteSubmitPress;
    double headingBottomPadding = ss.height * .02;
    return Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.blueGrey[800], brightness: Brightness.dark),
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            onPanDown: (DragDownDetails ddDets) {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Material(
                child: new SafeArea(
                    top: true,
                    bottom: true,
                    minimum: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    child: new Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 0.0),
                        child: Column(children: [
                          Table(
//                          columnWidths: <int, TableColumnWidth>{
//                            0: FixedColumnWidth(ss.width * .00)
//                          },
                              children: <TableRow>[
                                TableRow(children: <Widget>[
                                  Container(
                                    height: paddingHeight,
//                         decoration: BoxDecoration(gradient:LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.center,
//                             colors: [
//                           Colors.tealAccent[300],
//                           Colors.teal[700]
//                         ])
//                         )
                                  )
                                ]),
                                TableRow(children: <Widget>[
                                  Container(
                                      child: Column(children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.all(0.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: ider_entryColor,
                                                border: Border(
//                                        top: BorderSide(
//                                            color: Colors.tealAccent,
//                                            width: 1.0),
                                                    bottom: BorderSide(
                                                        color: Colors.teal,
                                                        width: 0.5))),
                                            height: entryHeight,
                                            width: ss.width,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: leftMargin),
                                                      child: Text(
                                                        "ℹ All fields are optional",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                ss.width * .037,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ))
                                                ])))
                                  ]))
                                ]),
                                new TableRow(children: <Widget>[
                                  Container(
                                      child: Column(children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 0.0, bottom: 0.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: ider_entryColor,
                                                border: Border(
                                                    top: BorderSide(
                                                        color:
                                                            Colors.tealAccent,
                                                        width: 1.0),
                                                    bottom: BorderSide(
                                                        color: Colors.teal,
                                                        width: 0.5))),
//                                height: entryHeight * 3,
                                            width: entryWidth / .83,
                                            child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                      height: ss.width * .01),
                                                  Text("Title:",
                                                      style: headingStyle),
                                                  Container(
                                                      width: entryWidth,
                                                      height: entryHeight * 1.8,
                                                      child: new TextField(
                                                        autocorrect: false,
                                                        maxLines: 2,
                                                        maxLength: 64,
                                                        onEditingComplete: () {
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                                  FocusNode());
                                                          setState(() {
                                                            AGS.state_post_item
                                                                    .title =
                                                                _titleInputController
                                                                    .text;
                                                          });
                                                        },
                                                        onChanged: (value) {
                                                          setState(() {
                                                            AGS.state_post_item
                                                                .title = value!;
                                                          });
                                                        },
                                                        controller:
                                                            _titleInputController,
//                                        onSubmitted: _updateTitle(),
                                                        style: entryStyle,
                                                        decoration: tfDec,
                                                      )),
                                                  Container(
                                                      height: ss.width * .015),
                                                ]))),
                                  ]))
                                ]),
                                new TableRow(children: <Widget>[
                                  new Padding(
                                      padding: EdgeInsets.only(
                                          top: paddingHeight, bottom: 4.0),
                                      child: breakLine)
                                ]),
                                new TableRow(children: <Widget>[
                                  Container(
                                      child: Column(children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 0.0, bottom: 0.0),
                                        child: Container(
                                            decoration: ider_boxdec,
                                            height: entryHeight * 2,
                                            width: entryWidth / .83,
                                            child: Column(children: [
                                              Container(height: ss.width * .01),
                                              new Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  new Text("Price: ",
                                                      style: headingStyle),
                                                  Container(width: 5.0),
                                                ],
                                              ),
                                              Row(children: [
                                                Container(
                                                  height: entryHeight,
                                                  child: Text(
                                                    "\$",
                                                    style: TextStyle(
                                                        fontSize:
                                                            entryHeight * .66,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Container(width: leftMargin),
                                                new Container(
                                                    width: entryWidth -
                                                        (2 * leftMargin),
                                                    height: entryHeight,
                                                    child: new TextField(
//                          focusNode: priceFocusNode,
                                                      maxLength: 8,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller:
                                                          _priceInputController,
                                                      onEditingComplete: () {
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                FocusNode());
                                                        setState(() {
                                                          AGS.state_post_item
                                                                  .price =
                                                              _priceInputController
                                                                  .text;
                                                        });
                                                      },
//                                    onChanged: (value) {
//                                      setState(() {
//                                        AGS.state_post_item.price = value!;
//                                      });
//                                    },
                                                      style: entryStyle,
                                                      decoration: tfDec,
                                                    ))
                                              ]),
                                              Container(
                                                  height: ss.width * .015),
                                            ])))
                                  ]))
                                ]),
                                new TableRow(children: <Widget>[
                                  new Padding(
                                      padding: EdgeInsets.only(
                                          top: paddingHeight, bottom: 4.0),
                                      child: breakLine)
                                ]),
                                new TableRow(children: <Widget>[
                                  Container(
                                      decoration: ider_boxdec,
                                      width: entryWidth / .83,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(height: ss.width * .01),
                                            Container(
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                  new Text("Brand/Shaper:",
                                                      style: headingStyle),
                                                ])),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                      width: entryWidth,
                                                      height: entryHeight * 1.5,
                                                      child: new TextField(
                                                        autocorrect: false,
                                                        maxLength: 30,
                                                        maxLines: null,
                                                        onEditingComplete: () {
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                                  FocusNode());
                                                          setState(() {
                                                            AGS.state_post_item
                                                                    .brand =
                                                                _shaperInputController
                                                                    .text;
                                                          });
                                                        },
//                                  onChanged: (value) {
//                                    setState(() {
//                                      AGS.state_post_item.brandShaper = value!;
//                                    });
//                                  },
                                                        controller:
                                                            _shaperInputController,
                                                        style: entryStyle,
                                                        decoration: tfDec,
                                                      ))
                                                ]),
                                            Container(height: ss.width * .02),
                                          ]))
                                ]),
                                new TableRow(children: <Widget>[
                                  new Padding(
                                      padding: EdgeInsets.only(
                                          top: paddingHeight, bottom: 4.0),
                                      child: breakLine)
                                ]),
                                new TableRow(children: <Widget>[
                                  Container(
                                      child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 0.0, bottom: 0.0),
                                            child: Container(
                                                decoration: ider_boxdec,
                                                width: entryWidth / .83,
                                                child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                          height:
                                                              ss.width * .01),
                                                      new Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 0.0,
                                                                  bottom:
                                                                      ss.height *
                                                                          .02),
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                new Text(
                                                                    'Length:',
                                                                    style:
                                                                        headingStyle)
                                                              ])),
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                leftMargin),
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        .2,
                                                                    height:
                                                                        entryHeight,
                                                                    child: TextField(
                                                                        maxLength: 3,
//                                focusNode: dimsFocusNode1,
                                                                        controller: _dimsInputController1,
                                                                        keyboardType: TextInputType.number,
                                                                        onEditingComplete: () {
                                                                          FocusScope.of(context)
                                                                              .requestFocus(FocusNode());
                                                                          setState(
                                                                              () {
                                                                            AGS.state_post_item.dimensions!["lengthFeet"] =
                                                                                _dimsInputController1.text;
                                                                          });
                                                                        },
//                                onChanged: (value) {
//                                  setState(() {
//                                    AGS.state_post_item
//                                        .dimensions!["lengthFeet"] = value!;
//                                  });
//                                },
                                                                        decoration: tfDec,
                                                                        style: entryStyle),
                                                                  ),
                                                                  Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              leftMargin)),
                                                                  Text("Feet",
                                                                      style:
                                                                          headingStyle),
                                                                  Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: leftMargin *
                                                                              2)),
                                                                  Container(
                                                                      height:
                                                                          entryHeight,
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          .2,
                                                                      child:
                                                                          TextField(
                                                                        decoration:
                                                                            tfDec,
                                                                        maxLength:
                                                                            3,
//                                focusNode: dimsFocusNode2,
                                                                        controller:
                                                                            _dimsInputController2,
                                                                        keyboardType:
                                                                            TextInputType.number,
//                                            onChanged: (value) {
//                                              setState(() {
//                                                AGS.state_post_item
//                                                        .dimensions![
//                                                    "lengthInches"] = value!;
//                                              });
//                                            },
                                                                        onEditingComplete:
                                                                            () {
                                                                          FocusScope.of(context)
                                                                              .requestFocus(FocusNode());
                                                                          setState(
                                                                              () {
                                                                            AGS.state_post_item.dimensions!["lengthInches"] =
                                                                                _dimsInputController2.text;
                                                                          });
                                                                        },
                                                                        style:
                                                                            entryStyle,
                                                                      )),
                                                                  Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: leftMargin *
                                                                              2)),
                                                                  Text("Inches",
                                                                      style:
                                                                          headingStyle),
                                                                ])
                                                          ]),
                                                      Container(
                                                          height:
                                                              ss.width * .02),
                                                    ])))
                                      ]))
                                ]),
                                TableRow(children: <Widget>[
                                  new Padding(
                                      padding: EdgeInsets.only(
                                          top: paddingHeight, bottom: 4.0),
                                      child: breakLine)
                                ]),
                                new TableRow(children: <Widget>[
                                  Container(
                                      child: Column(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          // crossAxisAlignment: CrossAxisAlignment.center,
                                          // mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.only(
                                                // top: entryHeight / 2,
                                                bottom: 0.0),
                                            child: Container(
                                                decoration: ider_boxdec,
                                                width: entryWidth / .83,
                                                child: Column(children: [
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 0.0,
                                                          bottom: 0.0),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            new Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            0.0,
                                                                        bottom:
                                                                            headingBottomPadding),
                                                                child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment.center,
                                                                    children: [
                                                                      new Text(
                                                                          'Width:',
                                                                          style:
                                                                              headingStyle)
                                                                    ])),
                                                          ])),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              new Container(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              leftMargin),
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .2,
                                                                  height:
                                                                      entryHeight,
                                                                  child: new TextField(
                                                                      maxLength: 3,
                                                                      keyboardType: TextInputType.number,
                                                                      controller: _dimsInputController3,
                                                                      onEditingComplete: () {
                                                                        FocusScope.of(context)
                                                                            .requestFocus(FocusNode());
                                                                        setState(
                                                                            () {
                                                                          AGS.state_post_item.dimensions!["widthInches"] =
                                                                              _dimsInputController3.text;
                                                                        });
                                                                      },
                                                                      style: entryStyle,
                                                                      decoration: tfDec)),
                                                              Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              leftMargin)),
                                                              Text("and",
                                                                  style:
                                                                      headingStyle),
                                                              Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: leftMargin *
                                                                          2)),
                                                              Container(
                                                                decoration:
                                                                    ddContDec,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    .25,
                                                                height:
                                                                    entryHeight,
                                                                child: Center(
                                                                    child:
                                                                        DropdownButton(
                                                                  isDense:
                                                                      false,
                                                                  iconSize:
                                                                      dropIconSize,
                                                                  value: AGS
                                                                          .state_post_item
                                                                          .dimensions!["widthFrac"] ??
                                                                      " ",
                                                                  onChanged:
                                                                      (value) {
                                                                    FocusScope.of(
                                                                            context)
                                                                        .requestFocus(
                                                                            new FocusNode());
                                                                    setState(
                                                                        () {
                                                                      widthFrac =
                                                                          value!.toString();
                                                                    });
                                                                    AGS.state_post_item
                                                                            .dimensions![
                                                                        "widthFrac"] = value!;
                                                                    setState(
                                                                        () {
                                                                      AGS.state_post_item
                                                                              .dimensions!["widthFrac"] =
                                                                          value!;
                                                                    });
                                                                  },
                                                                  items: <
                                                                      String>[
                                                                    " ",
                                                                    '0',
                                                                    '1/16',
                                                                    '1/8',
                                                                    '3/16',
                                                                    '1/4',
                                                                    '5/16',
                                                                    '3/8',
                                                                    '7/16',
                                                                    '1/2',
                                                                    '9/16',
                                                                    '5/8',
                                                                    '11/16',
                                                                    '3/4',
                                                                    '13/16',
                                                                    '7/8',
                                                                    '15/16',
                                                                  ].map((String
                                                                      value) {
                                                                    return new DropdownMenuItem<
                                                                        String>(
                                                                      value:
                                                                          value,
                                                                      child: new Text(
                                                                          value,
                                                                          style:
                                                                              ddTS),
                                                                    );
                                                                  }).toList(),
                                                                )),
                                                              ),
                                                              Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: leftMargin *
                                                                          2)),
                                                              Text("Inches",
                                                                  style:
                                                                      headingStyle),
                                                            ])
                                                      ]),
                                                  Container(
                                                      height: ss.width * .02),
                                                ])))
                                      ]))
                                ]),
                                new TableRow(children: <Widget>[
                                  new Padding(
                                      padding: EdgeInsets.only(
                                          top: paddingHeight, bottom: 4.0),
                                      child: breakLine)
                                ]),
                                new TableRow(children: <Widget>[
                                  Container(
                                      child: Column(children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 0.0, bottom: 0.0),
                                        child: Container(
                                            decoration: ider_boxdec,
                                            width: entryWidth / .83,
                                            child: Column(children: [
                                              new Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 0.0,
                                                      bottom:
                                                          headingBottomPadding),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        new Text('Thickness:',
                                                            style: headingStyle)
                                                      ])),
                                              new Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          new Container(
                                                              padding:
                                                                  new EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          leftMargin),
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .2,
                                                              height:
                                                                  entryHeight,
                                                              child:
                                                                  new TextField(
//                                    focusNode: dimsFocusNode4,
                                                                maxLength: 3,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                controller:
                                                                    _dimsInputController4,
//                                            onChanged: (value) {
//                                              setState(() {
//                                                AGS.state_post_item
//                                                        .dimensions![
//                                                    "thicknessInches"] = value!;
//                                              });
//                                            },
                                                                onEditingComplete:
                                                                    () {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .requestFocus(
                                                                          FocusNode());
                                                                  setState(() {
                                                                    AGS.state_post_item
                                                                            .dimensions!["thicknessInches"] =
                                                                        _dimsInputController4
                                                                            .text;
                                                                  });
                                                                },
                                                                style:
                                                                    entryStyle,
                                                                decoration:
                                                                    tfDec,
                                                              )),
                                                          Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          leftMargin)),
                                                          Text("and",
                                                              style:
                                                                  headingStyle),
                                                          Padding(
                                                              padding: EdgeInsets.only(
                                                                  left:
                                                                      leftMargin *
                                                                          2)),
                                                          Container(
                                                              decoration:
                                                                  ddContDec,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .25,
                                                              height:
                                                                  entryHeight,
                                                              child: Center(
                                                                  child:
                                                                      DropdownButton(
                                                                isDense: false,
                                                                iconSize:
                                                                    dropIconSize,
                                                                value: AGS.state_post_item
                                                                            .dimensions![
                                                                        "thicknessFrac"] ??
                                                                    " ",
                                                                onChanged:
                                                                    (value) {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .requestFocus(
                                                                          new FocusNode());
                                                                  setState(() {
                                                                    thickFrac =
                                                                        value!.toString();
                                                                    AGS.state_post_item
                                                                            .dimensions![
                                                                        "thicknessFrac"] = value!;
                                                                  });
                                                                  setState(() {
                                                                    AGS.state_post_item
                                                                            .dimensions![
                                                                        "thicknessFrac"] = value!;
                                                                  });
                                                                },
                                                                items: <String>[
                                                                  " ",
                                                                  '0',
                                                                  '1/16',
                                                                  '1/8',
                                                                  '3/16',
                                                                  '1/4',
                                                                  '5/16',
                                                                  '3/8',
                                                                  '7/16',
                                                                  '1/2',
                                                                  '9/16',
                                                                  '5/8',
                                                                  '11/16',
                                                                  '3/4',
                                                                  '13/16',
                                                                  '7/8',
                                                                  '15/16',
                                                                ].map((String
                                                                    value) {
                                                                  return DropdownMenuItem<
                                                                      String>(
                                                                    value:
                                                                        value,
                                                                    child: Text(
                                                                        value,
                                                                        style:
                                                                            ddTS),
                                                                  );
                                                                }).toList(),
                                                              ))),
                                                          Padding(
                                                              padding: EdgeInsets.only(
                                                                  left:
                                                                      leftMargin *
                                                                          2)),
                                                          Text("Inches",
                                                              style:
                                                                  headingStyle),
                                                        ])
                                                  ]),
                                              Container(height: ss.width * .02),
                                            ]))),
                                    Container(height: ss.width * .02),
                                  ]))
                                ]),
                                new TableRow(children: <Widget>[
                                  new Padding(
                                      padding: EdgeInsets.only(
                                          top: paddingHeight, bottom: 4.0),
                                      child: breakLine)
                                ]),
                                new TableRow(children: <Widget>[
                                  Container(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 0.0, bottom: 0.0),
                                            child: Container(
                                                decoration: ider_boxdec,
//                                    height: entryHeight * 5,
                                                width: entryWidth / .83,
                                                child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          new Text(
                                                              "Description:",
                                                              style:
                                                                  headingStyle),
                                                        ],
                                                      ),
                                                      Padding(
                                                          padding:
                                                              new EdgeInsets
                                                                      .fromLTRB(
                                                                  1.0,
                                                                  entryHeight *
                                                                      .1,
                                                                  1.0,
                                                                  5.0),
                                                          child: Container(
                                                              width: entryWidth,
                                                              child:
                                                                  new TextField(
                                                                autocorrect:
                                                                    false,
                                                                decoration:
                                                                    tfDec,
                                                                onEditingComplete:
                                                                    () {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .requestFocus(
                                                                          FocusNode());
                                                                  setState(() {
                                                                    AGS.state_post_item
                                                                            .description =
                                                                        _descriptionInputController
                                                                            .text;
                                                                  });
                                                                },
//                              onChanged: (value) {
//                                setState(() {
//                                  AGS.state_post_item.description = value!;
//                                });
//                              },
                                                                maxLines: 7,
                                                                maxLength: 1024,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .multiline,
//                                    textInputAction: TextInputAction.done,
                                                                controller:
                                                                    _descriptionInputController,
                                                                style:
                                                                    entryStyle,
                                                              )))
                                                    ])))
                                      ]))
                                ]),
                                new TableRow(children: <Widget>[
                                  new Padding(
                                      padding: EdgeInsets.only(
                                          top: paddingHeight, bottom: 4.0),
                                      child: breakLine)
                                ]),
                                new TableRow(children: <Widget>[
                                  Container(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                        Container(
                                            decoration: ider_boxdec,
//                                    height: entryHeight * 2.7,
                                            width: entryWidth / .83,
                                            child: Column(children: [
                                              Container(
                                                  color: ider_entryColor,
                                                  height: ss.height * .01),
                                              Center(
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                    new Text("Volume: ",
                                                        style: headingStyle),
                                                  ])),
                                              new Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Row(children: [
                                                      new Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left:
                                                                    leftMargin,
                                                                top: ss.height *
                                                                    .02),
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .4,
                                                        height: entryHeight,
                                                        child: new TextField(
                                                          controller:
                                                              _volumeInputController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          onEditingComplete:
                                                              () {
                                                            FocusScope.of(
                                                                    context)
                                                                .requestFocus(
                                                                    FocusNode());
                                                            setState(() {
                                                              AGS.state_post_item
                                                                          .dimensions![
                                                                      "volume"] =
                                                                  _volumeInputController
                                                                      .text;
                                                            });
                                                          },
                                                          style: entryStyle,
                                                          decoration: tfDec,
                                                        ),
                                                      ),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left:
                                                                      leftMargin *
                                                                          2)),
                                                      Text("Liters",
                                                          style: headingStyle),
                                                    ]),
                                                  ]),
                                              Container(
                                                  color: ider_entryColor,
                                                  height: ss.height * .015),
                                            ]))
                                      ]))
                                ]),
                                new TableRow(children: <Widget>[
                                  new Padding(
                                      padding: EdgeInsets.only(
                                          top: paddingHeight, bottom: 4.0),
                                      child: breakLine)
                                ]),
                                new TableRow(children: <Widget>[
                                  Container(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 0.0, bottom: 0.0),
                                            child: Container(
                                                decoration: ider_boxdec,
                                                width: entryWidth / .83,
                                                child: Column(children: [
                                                  Container(
                                                      color: ider_entryColor,
                                                      height: ss.height * .01),
                                                  new Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 0.0,
                                                          bottom:
                                                              headingBottomPadding),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            new Text(
                                                                "Board Type: ",
                                                                style:
                                                                    headingStyle),
                                                          ])),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                            left: leftMargin,
                                                            right: leftMargin,
                                                            top:
                                                                headingBottomPadding),
                                                        height: entryHeight,
                                                        decoration: ddContDec,
                                                        child: Center(
                                                            child:
                                                                DropdownButton(
                                                          iconSize:
                                                              dropIconSize,
                                                          value: boardTypeVal ??
                                                              " ",
                                                          onChanged: (value) {
                                                            FocusScope.of(
                                                                    context)
                                                                .requestFocus(
                                                                    new FocusNode());
                                                            setState(() {
                                                              boardTypeVal =
                                                                  value!;
                                                              AGS.state_post_item
                                                                      .boardType =
                                                                  value!;
                                                            });
                                                          },
                                                          items: <String>[
                                                            ' ',
                                                            'Shortboard',
                                                            'Hybrid',
                                                            'Fish',
                                                            'Step-up',
                                                            'Gun',
                                                            'Longboard',
                                                            'Prone Paddle',
                                                            'SUP',
                                                            'other',
                                                          ].map((String value) {
                                                            return new DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child: new Text(
                                                                  value,
                                                                  style: ddTS),
                                                            );
                                                          }).toList(),
                                                        )),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                      color: ider_entryColor,
                                                      height: ss.height * .015),
                                                ])))
                                      ]))
                                ]),
                                new TableRow(children: <Widget>[
                                  new Padding(
                                      padding: EdgeInsets.only(
                                          top: paddingHeight, bottom: 4.0),
                                      child: breakLine)
                                ]),
                                TableRow(children: <Widget>[
                                  Container(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: 0.0, bottom: 0.0),
                                              child: Container(
                                                  decoration: ider_boxdec,
                                                  width: entryWidth / .83,
                                                  child: Column(children: [
                                                    Container(
                                                        color: ider_entryColor,
                                                        height:
                                                            ss.height * .01),
                                                    new Padding(
                                                        padding: EdgeInsets.only(
                                                            top: 0.0,
                                                            bottom:
                                                                headingBottomPadding),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              new Text(
                                                                  "Fin Type: ",
                                                                  style:
                                                                      headingStyle),
                                                            ])),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                        ClipRRect(
                                                            borderRadius:
                                                                new BorderRadius
                                                                    .circular(
                                                              4.0,
                                                            ),
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          leftMargin),
                                                              height:
                                                                  entryHeight,
                                                              decoration:
                                                                  ddContDec,
                                                              child: Center(
                                                                  child:
                                                                      DropdownButton(
                                                                iconSize:
                                                                    dropIconSize,
                                                                value:
                                                                    finSetupVal ??
                                                                        " ",
                                                                onChanged:
                                                                    (value) {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .requestFocus(
                                                                          new FocusNode());
                                                                  setState(() {
                                                                    finSetupVal =
                                                                        value!;
                                                                    AGS.state_post_item
                                                                            .finSetup =
                                                                        value!;
                                                                  });
                                                                },
                                                                items: <String>[
                                                                  ' ',
                                                                  'Finless',
                                                                  'Single',
                                                                  'Twin',
                                                                  'Thruster',
                                                                  'Quad',
                                                                  'Five',
                                                                  '2+1',
                                                                  'Other',
                                                                ].map((String
                                                                    value) {
                                                                  return new DropdownMenuItem<
                                                                      String>(
                                                                    value:
                                                                        value,
                                                                    child: Padding(
                                                                        padding: EdgeInsets.only(left: 1, right: ss.width * .02),
                                                                        child: Text(
                                                                          value,
                                                                          style:
                                                                              ddTS,
                                                                        )),
                                                                  );
                                                                }).toList(),
                                                              )),
                                                            )),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      leftMargin),
                                                          height: entryHeight,
                                                          decoration: ddContDec,
                                                          child: Center(
                                                              child:
                                                                  DropdownButton(
                                                            iconSize:
                                                                dropIconSize,
                                                            value:
                                                                finBrandVal ??
                                                                    " ",
                                                            onChanged: (value) {
                                                              FocusScope.of(
                                                                      context)
                                                                  .requestFocus(
                                                                      new FocusNode());
                                                              setState(() {
                                                                finBrandVal =
                                                                    value!;
                                                                AGS.state_post_item
                                                                        .finBrand =
                                                                    value!;
                                                              });
                                                            },
                                                            items: <String>[
                                                              ' ',
                                                              'FCS',
                                                              'FCS2',
                                                              'Future',
                                                              'Glass',
                                                              'Other',
                                                            ].map(
                                                                (String value) {
                                                              return new DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child: Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: 1,
                                                                        right: ss.width *
                                                                            .02),
                                                                    child: Text(
                                                                      value,
                                                                      style:
                                                                          ddTS,
                                                                    )),
                                                              );
                                                            }).toList(),
                                                          )),
                                                        )
                                                      ],
                                                    ),
                                                    Container(
                                                        color: ider_entryColor,
                                                        height:
                                                            ss.height * .015),
                                                  ])))
                                        ]),
                                  )
                                ]),
                                new TableRow(children: <Widget>[
                                  new Padding(
                                      padding: EdgeInsets.only(
                                          top: paddingHeight, bottom: 4.0),
                                      child: breakLine)
                                ]),
                                new TableRow(children: <Widget>[
                                  Container(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.all(0),
                                            child: Container(
                                                decoration: ider_boxdec,
                                                width: entryWidth / .83,
                                                child: Column(children: [
                                                  Container(
                                                      decoration: ider_boxdec,
                                                      height: ss.height * .01),
                                                  new Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 0.0,
                                                          bottom:
                                                              headingBottomPadding),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            new Text(
                                                                "Condition: ",
                                                                style:
                                                                    headingStyle),
                                                          ])),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                            left: leftMargin,
                                                            right: leftMargin,
                                                            top:
                                                                headingBottomPadding),
                                                        height: entryHeight,
                                                        decoration: ddContDec,
                                                        child: Center(
                                                            child:
                                                                DropdownButton(
                                                          iconSize:
                                                              dropIconSize,
                                                          value:
                                                              conditionText ??
                                                                  " ",
                                                          onChanged: (value) {
                                                            FocusScope.of(
                                                                    context)
                                                                .requestFocus(
                                                                    new FocusNode());
                                                            setState(() {
                                                              conditionText =
                                                                  value!;
                                                              AGS.state_post_item
                                                                      .condition =
                                                                  value!;
                                                            });
                                                          },
                                                          items: <String>[
                                                            ' ',
                                                            'Damaged',
                                                            'Used',
                                                            'Almost New',
                                                            'New',
                                                            'Other',
                                                          ].map((String value) {
                                                            return new DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child: new Text(
                                                                  value,
                                                                  style: ddTS),
                                                            );
                                                          }).toList(),
                                                        )),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    height: ss.width * .04,
                                                  ),
                                                  Container(
                                                    decoration: ider_boxdec,
                                                  )
                                                ])))
                                      ]))
                                ]),
                              ]),
                          Container(
                            height: ss.width * .04,
                          ),
                          _previewSavePress == true
                              ? Container(
                                  width: ss.width,
                                  height: ss.height * .16,
                                  padding: EdgeInsets.only(
                                      bottom: headingBottomPadding,
                                      top: headingBottomPadding),
                                  child: new ElevatedButton(
                                    style:ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(Colors.lightGreenAccent[700]!,
                                    )),
                                      onPressed: () async {},
                                      child: Center(
                                          child: Image(
                                              image: new AssetImage(
                                                  "images/smTptWave.gif")))),
                                )
                              : Container(
                                  width: ss.width * .9,
                                  height: ss.width * .15,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                                      ),
                                      onPressed: () {
                                      setGuipFields();
                                      print(
                                          "Board Data entry Continue pressed,,, building board ::: ");
                                      print(AGS.state_post_item.toJSON());

                                      post_bc_product(AGS.state_post_item.toJSON());
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                        return SB_Poster_Root(AGS.cameras, AGS.bc_data);
                                      }));
                                    },
                                    child: Container(
                                        width: ss.width * .9,
                                        height: ss.width * .13,
                                        child: Center(
                                          child: Text(
                                            "Continue",
                                            style: post_flow_button_style,
                                          ),
                                        )),
                                  )),
                          Container(
                            height: ss.width * .04,
                          ),
                        ]))))));
  }
}
