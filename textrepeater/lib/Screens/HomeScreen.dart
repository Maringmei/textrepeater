import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mix/mix.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

TextEditingController textController = TextEditingController();

class _HomeScreenState extends State<HomeScreen> {
  String a = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text("Text Repeater"),
          centerTitle: true,
          leading: Icon(Icons.menu),
          actions: [
            Padding(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                    onTap: () async {
                      PackageInfo packageInfo =
                          await PackageInfo.fromPlatform();

                      String appName = packageInfo.appName;
                      String packageName = packageInfo.packageName;
                      String version = packageInfo.version;
                      String buildNumber = packageInfo.buildNumber;

                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Text('App Info'),
                                content: FittedBox(
                                  child: Column(
                                    children: [
                                      Text("App Name : $appName"),
                                      Text("Package Name : $packageName"),
                                      Text("Version : $version"),
                                      Text("BUILD NUMBER : $buildNumber"),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ));
                    },
                    child: Icon(Icons.verified)))
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: textController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          a = '';
                          for (int i = 0; i < 100; i++) {
                            a = a + " " + textController.value.text;
                          }
                          setState(() {});
                        },
                        child: Text("Generate")),
                    ElevatedButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: a));
                        },
                        child: Text("COPY")),
                  ],
                ),
                Text(a.toString()),
                CustomMixWidget(),
              ],
            ),
          ),
        ));
  }
}

class CustomMixWidget extends StatelessWidget {
  const CustomMixWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Mix(
      height(100),
      animated(),
      marginY(10),
      elevation(12),
      rounded(10),
      bgColor($primary),
      textStyle($button),
      textColor($onPrimary),
      hover(
        elevation(2),
        padding(20),
        bgColor($secondary),
        textColor($onSecondary),
      ),
    );
    return Box(
      mix: style,
      child: const TextMix('Custom Widget'),
    );
  }
}
