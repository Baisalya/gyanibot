import 'dart:ui';

import 'package:avatar_glow/avatar_glow.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceCommand extends StatefulWidget {
  const VoiceCommand({Key? key}) : super(key: key);

  @override
  State<VoiceCommand> createState() => _VoiceCommandState();
}
var Qry="Hold the mic to ask Questions";

bool ispress=false;
class _VoiceCommandState extends State<VoiceCommand> {

  SpeechToText speechToText=SpeechToText();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton:
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 29,top: 50),
                child: FloatingActionButton(
                  child: Icon(
                      Icons.textsms
                  ),
                  onPressed: () {
                    //...
                  },
                  heroTag: null,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              /*** Voice question button ****/
              AvatarGlow(
                endRadius:70.0 ,
                animate: ispress,
                duration:Duration(milliseconds:2000),
                glowColor:Colors.blueGrey,
                repeatPauseDuration:Duration(microseconds:100),
                showTwoGlows: true,
                  child: FloatingActionButton(
                    child: AvatarGlow(
                      endRadius:20.0 ,
                      animate: ispress,
                      duration:Duration(milliseconds:3000),
                      glowColor:Colors.blueGrey,
                      repeatPauseDuration:Duration(microseconds:100),
                      showTwoGlows: true,
                      child: GestureDetector(
                        onTapDown: (details) async{
                          if(!ispress){
                            var available=await speechToText.initialize();
                            if(available){
                              setState(() {
                                ispress=true;
                                speechToText.listen(
                                  onResult: ((result) {
                                    setState(() {
                                      Qry=result.recognizedWords;
                                    });
                                  })
                                );
                              });
                            }
                          }
                          setState(() {
                            ispress=true;
                          });
                        },
                        onTapUp: (details){
                          setState(() {
                            ispress=false;
                          });
                          speechToText.stop();
                        },
                        child: Icon(ispress ?
                            Icons.mic : Icons.mic_none_rounded
                        ),
                      ),
                    ),
                    onPressed: () => (){},
                    heroTag: null,
                  ),

              )
            ]
        ),
      /** App Bar**/
      appBar: AppBar(
        leading: Icon(Icons.sort),
        centerTitle: true,
        title:const Text("Ask Your Question",style:TextStyle(fontStyle:FontStyle.italic,fontWeight: FontWeight.bold,color:Colors.white ),),
      ),
      body:SingleChildScrollView(
        reverse: true,
        physics:const BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30,horizontal: 26),
          margin: EdgeInsets.only(bottom: 160),
          decoration: BoxDecoration(
            color: const Color(0xff7c94b6),
            image: const DecorationImage(
              opacity: 192,
              image: NetworkImage('https://e7.pngegg.com/pngimages/498/917/png-clipart-computer-icons-desktop-chatbot-icon-blue-angle.png',),
              fit: BoxFit.fill,
            ),

          ),

        ),
      ),

    );
  }
}
