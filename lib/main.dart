import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:bigcom_surfboard_poster/camera_w.dart';
import 'package:bigcom_surfboard_poster/app_gs.dart';
import 'ui_objects.dart';
import 'package:bigcom_surfboard_poster/bc_api_reqs.dart';
import 'g_styles.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    ///Caching just to avoid hitting bigcommerce every hot reload, remove for functionality
    if (bc_prod_resp == null) {
      bc_prod_resp = await get_bc_products();
    }
    AGS.cameras = await availableCameras();
  } on CameraException catch (e) {
    print(e.code + e.description);
  }
  var bc_data = {};
  if (bc_prod_resp != null) {
    bc_data["bc_prod_resp"] = json.decode(bc_prod_resp!);
  } else {
    bc_data = {"data":"nodata"};
  }
  AGS.bc_data = bc_prod_resp;
  runApp(SB_Post_App(AGS.cameras, bc_data));
}

class SB_Post_App extends StatelessWidget {
  SB_Post_App(this.cdata, this.bc_data);
  List<CameraDescription> cdata;
  var bc_data;

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SB_Poster_Root(cdata, bc_data),
    );
  }
}

class SB_Poster_Root extends StatelessWidget {

  SB_Poster_Root(this.cdata, this.bc_data);
  List<CameraDescription> cdata;
  var bc_data;

  List<Widget>? bc_prod_cards;

  List<Widget>? build_bc_products_cards(Size ss, Map bcdata) {
    print("build_bc_products_cards called");
    List<Widget> build_prod_cards = [
      Container(
          color: Colors.black,
          width: ss.width,
          height: ss.width * .18,
          child: Center(
              child: Text(
            "Current Store Items",
            style: content_title_style_dark,
          ))),
      Container(
        height: ss.width * .04,
      )
    ];

    if (bcdata.containsKey("bc_prod_resp")) {
      var dec_prod_resp = bcdata["bc_prod_resp"];
      print("got bc_prod_resp key");
      List dec_prod_items = dec_prod_resp["data"];
      print("got data into dec prod items list");
      if (dec_prod_items != null) {
        dec_prod_items.forEach((item) {
          String pname = "";
          String pimg = "";
          String pdesc = "";

          /// bigcommerce id
          String bc_id = "";
          String bc_sku = "";
          String bc_price = "";
          String bc_date = "";
          //bigcommerce view count
          String bc_vc = "";

          item.forEach((k, v) {
            // print("[prod item] kv parse");

            if (k == "name") {
              // print("k name " + v.toString());
              pname = v.toString();
            }
            if (k == "description") {
              // print("k description" + v.toString());
              pdesc = v.toString();
            }
            if (k == "id") {
              print("k bigcommerce id:: " + v.toString());
              bc_id = v.toString();
            }
            if (k == "sku") {
              print("k bigcommerce sku::" + v.toString());
              bc_sku = v.toString();
            }
            if (k == "price") {
              print("k bigcommerce price");
              bc_price = v.toString();
            }
            if (k == "date_created") {
              print("k bc date created");
              bc_date = v.toString();
            }
            if (k == "view_count") {
              print("k bc view count");
              bc_vc = v.toString();
            }
          });

          build_prod_cards.addAll([
            Container(
                decoration: BoxDecoration(
                  color: Colors.white30,
                ),
                width: ss.width * .97,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // Image.network(src)
                    ui_bubble_display(pname, ss, ss.width * .04, ss.width * .9,
                        Colors.blueGrey[900]!, Colors.white),
                    Container(
                      height: ss.width * .01,
                    ),
                    ui_bubble_display(pdesc, ss, ss.width * .01, ss.width * .96,
                        Colors.white70, Colors.black),

                    Container(
                        width: ss.width * .95,
                        color: Colors.greenAccent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Big Commerce Product Attributes:")
                          ],
                        )),
                    Container(
                      height: ss.width * .01,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        child: Text("Price ---------------- "),
                      ),
                      ui_bubble_display(bc_price, ss, ss.width * .05,
                          ss.width * .24, Colors.greenAccent, Colors.black),
                    ]),
                    Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Text("ID ---------------- "),
                          ui_bubble_display(bc_id, ss, ss.width * .05,
                              ss.width * .24, Colors.greenAccent, Colors.black),
                        ])),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text("View Count ----------------"),
                      ui_bubble_display(bc_vc, ss, ss.width * .05,
                          ss.width * .24, Colors.greenAccent, Colors.black),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text("Posted ----------------"),
                      ui_bubble_display(bc_date, ss, ss.width * .05,
                          ss.width * .24, Colors.greenAccent, Colors.black),
                    ])
                  ],
                )),
            Container(
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Colors.lightBlueAccent, width: 2.0)),
              height: ss.width * .03,
            )
          ]);
        });

        return build_prod_cards;
      }
    }
  }

  Widget build(BuildContext context) {
    Size ss = MediaQuery.of(context).size;
    List<Widget> build_home_widgets = [];

    if (bc_data == null) {
      print("bc data null awaiting async response, continue build ");
      build_home_widgets.add(Center(child: Text("No boardsf")));
    } else {
      print("bc data available ");
      print(bc_data.toString());
      bc_prod_cards = build_bc_products_cards(ss, bc_data);
    }

    _board_post() {
      // Navigator.push(context,MaterialPageRoute(builder: (context) => Camera_W()),);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Camera_W(
                cdata: cdata,
              )));
    }

    _board_search() {
      print("search not implemented");
    }

    if (bc_prod_cards != null) {
      build_home_widgets.addAll(bc_prod_cards!);
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("Surfboard Poster Demo")),
      ),
      body:
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          ListView(children: build_home_widgets),

      floatingActionButton: Container(
          width: ss.width * .95,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            RawMaterialButton(
              onPressed: _board_search,
              elevation: 2.0,
              fillColor: Colors.purple,
              child: Icon(
                Icons.search,
                size: 24.0,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(),
            ),
            FloatingActionButton(
              onPressed: _board_post,
              tooltip: 'Post board',
              child: Icon(Icons.add),
            ),
          ])), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
