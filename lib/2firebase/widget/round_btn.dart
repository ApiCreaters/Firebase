import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback;
  final bool loading;
  const RoundButton({Key? key,required this.title,required this.VoidCallback,this.loading = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: VoidCallback,
      child: Container(
        height: 50,
        decoration:  BoxDecoration(
          color: const Color(0xff201b23),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: loading ? CircularProgressIndicator(color: Colors.white,strokeWidth: 3) : Text(title,style: TextStyle(color: Colors.white),)
        ),
      ),

    );
  }
}
