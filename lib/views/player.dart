import 'package:beats/consts/colors.dart';
import 'package:beats/consts/text_style.dart';
import 'package:beats/controllers/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {

  final List<SongModel> data;


  const Player({super.key,required this.data});

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<PlayerController>();


    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 134, 46, 236),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          ()=> Column(
            children: [
              Obx(()=> Expanded(
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    height: 350,
                    width: 350,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red
                    ),
                    alignment: Alignment.center,
                    child: QueryArtworkWidget(
                      id: data[controller.playIndex.value].id,
                       type: ArtworkType.AUDIO,
                       artworkHeight: double.infinity,
                       artworkWidth: double.infinity,
                       nullArtworkWidget: const Icon(Icons.music_note_rounded, color: bgDarkColor,),
                       ),
                    )),
              ),
                  const SizedBox(height: 12,),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                      bottom: Radius.circular(20)
                      ),
                      
                    color: Color.fromARGB(240, 7, 226, 135),
                  ),
                  child: Column(
                    children: [
                      Text(
                        data[controller.playIndex.value].displayNameWOExt, 
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      style: ourStyle(
                        color: bgDarkColor,
                        family: bold,
                        size: 24,
                      ),
                      ),
                      const SizedBox(height: 12,),
                      
                       Text(data[controller.playIndex.value].artist.toString()  , 
                       textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                       style: ourStyle(
                        color: bgDarkColor,
                        family: regular,
                        size: 20,
                      ),
                      ),
                      const SizedBox(height: 12,),
        
                      Obx(
                          ()=> Row(
                          
                          children: [
                            Text(
                              controller.position.value,
                             style: ourStyle(
                              color: bgDarkColor),
                              ),
                            Expanded(
                              child: Slider(
                                thumbColor: sliderColor,
                                inactiveColor: bgColor,
                                activeColor: sliderColor,
                                value: controller.value.value,
                                min: const Duration(seconds: 0).inSeconds.toDouble(), 
                                max: controller.max.value,
                                onChanged: (newValue){
                                  controller.changeDurationToSeconds(newValue.toInt());
                                  newValue = newValue;
                                },
                              ),
                            ),
                            Text(
                              controller.duration.value,
                               style: ourStyle(color: bgDarkColor),
                               ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12,),
        
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: (){
                              controller.playSong(data[controller.playIndex.value-1].uri, controller.playIndex.value-1);
                            },
                            icon: const Icon(
                              Icons.skip_previous_rounded,
                              size: 50,
                              color: bgDarkColor,
                              )),
                          Obx(
                              ()=> CircleAvatar( 
                              radius: 35,
                              backgroundColor: bgDarkColor,
                              child: Transform.scale(
                                scale: 3,
                                child: IconButton(
                                  onPressed: (){
                                    if(controller.isPlaying.value)
                                    {
                                      controller.audioPlayer.pause();
                                      controller.isPlaying(false);
                                    }
                                    else{
                                      controller.audioPlayer.play();
                                      controller.isPlaying(true);
                                    }
                                  }, 
                                  icon: controller.isPlaying.value 
                                  ? const Icon(
                                    Icons.pause,
                                     color: Color.fromARGB(255, 29, 236, 174),
                                     ):
                                  const Icon(
                                    Icons.play_arrow_rounded,
                                     color: Color.fromARGB(255, 29, 236, 174),
                                     )
                                  ),
                              ),
                                ),
                          ),
                          IconButton(
                            onPressed: (){
                              controller.playSong(data[controller.playIndex.value+1].uri, controller.playIndex.value+1);
                            },
                            icon: const Icon(
                              Icons.skip_next_rounded,
                               size: 50,
                               color: bgDarkColor,
                               )),
                        ],
                      )
        
                    ],
                  ),
                  ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}