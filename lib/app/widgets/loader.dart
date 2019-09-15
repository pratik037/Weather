import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 50,
                child: Text(
                  "LOADING",
                  style: TextStyle(fontSize: 25, letterSpacing: 3),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.80,
              child: LinearProgressIndicator(),
            ),
          ],
        ),
      );
  }
}