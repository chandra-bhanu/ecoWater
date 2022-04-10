import 'package:flutter/material.dart';

class JarIcons extends StatelessWidget {
  final String iconPath;
  final String iconTitle;
  final double iconWidth;
  final double iconHeight;

  const JarIcons(this.iconTitle,this.iconPath,this.iconWidth,this.iconHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset(
            this.iconPath,
            width: this.iconWidth,
            height: this.iconHeight,
          ),
          Text(
            this.iconTitle,
            style: TextStyle(color: Color(0xff4374ba), fontSize:12,fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class DeliveryJarIcons extends StatelessWidget {
  final String iconPath;
  final double iconWidth;
  final double iconHeight;

  const DeliveryJarIcons(this.iconPath,this.iconWidth,this.iconHeight);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          iconPath,
          width: iconWidth,
          height: iconHeight,
        )
      ],
    );
  }
}