import 'package:aptusseafood/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationPage extends StatelessWidget {
  final String title;
  NotificationPage({Key? key , required this.title}) : super(key: key);

  final Widget svgIcon = SvgPicture.asset(succesIcon,
      height: 20, semanticsLabel: 'A red up arrow');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEBF5FF),
      appBar: AppBar(
        backgroundColor: Color(0xFF20315C),
        title: Text('Notifications'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.only(
            top: 20,
            left: 5,
            bottom: 20,
          ),
          decoration: BoxDecoration(
            color: Color(0xFF20315C),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //svg image
              Expanded(child: Padding(
                padding: const EdgeInsets.only(top:4.0),
                child: svgIcon,
              )),
              Expanded(
                flex: 5,
                child: Container(
                  child: Text(
                    '$title',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Expanded(
                child:  InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  
                  },
                  child: Icon(
                        Icons.close,
                        color: Colors.grey,
                      ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
