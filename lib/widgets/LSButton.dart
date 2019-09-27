import 'package:flutter/material.dart';

class LSButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String text;
  LSButton({@required this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Theme.of(context).accentColor,
      splashColor: Theme.of(context).splashColor,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.sd_card,
              color: Colors.white,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              text,
              maxLines: 1,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      onPressed: onPressed,
      shape: const StadiumBorder(),
    );
  }
}
