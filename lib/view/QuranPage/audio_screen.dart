import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tawbah/constants/colors.dart';
import 'package:rxdart/rxdart.dart';
import 'package:audio_session/audio_session.dart';
import 'package:tawbah/constants/dimensions.dart';
import '../../models/qari.dart';
import '../../models/surah.dart';

class AudioScreen extends StatefulWidget {
  final Qari qari;
  final int index;
  final List<Surah>? list;
  const AudioScreen({Key? key,required this.qari , required this.index ,required this.list}) : super(key: key);

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final _player = AudioPlayer();
  bool isLoopingCurrentItem = false;
  Duration defaultDuration = const Duration(milliseconds: 1);
  String? ind;
  int currentIndex = 0;
  int dataIndex = 0;

  @override
  void initState() {


    setState(() {
      currentIndex = widget.index-1;
      dataIndex = widget.index - 1;
    });

    // Surah is from 1 to 114 so
    // 001 , 002 , 003 ..... 010, 011 , 012 , .....099 , 100 , 101, ...114
    if(widget.index<10){
      ind = "00"+(widget.index.toString());
    }else if(widget.index<100){
      ind  = "0"+(widget.index.toString());
    }else if(widget.index>100){
      ind = (widget.index.toString());
    }


    _initAudioPlayer(ind!,widget.qari);

    print('index ${widget.index}   current Index $currentIndex');
    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }


  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _player.stop();
    }
  }

  void handleLooping() async {
    if (isLoopingCurrentItem) {
      await _player.setLoopMode(LoopMode.one);
    } else {
      await _player.setLoopMode(LoopMode.off);
    }
    setState(() {
      isLoopingCurrentItem = !isLoopingCurrentItem;
    });
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
              (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
        title: const Text('Now Playing',style: TextStyle(fontWeight: FontWeight.w800,color: Colors.black),),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(left: 15,right: 15,top: 25,bottom: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        AppColors.fajar1,
                        AppColors.fajar2,
                      ],
                    ),
                    image: const DecorationImage(image: AssetImage('assets/images/mosque.png'),fit: BoxFit.cover,opacity: .3,alignment: Alignment.topRight)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: double.maxFinite,child: Text(widget.list![currentIndex].name!,style: const TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w500),textAlign: TextAlign.center,)),
                    SizedBox(height: Dimensions.height10,),
                    SizedBox(width: double.maxFinite,child: Text(widget.qari.name!,style: const TextStyle(color: Colors.white,fontSize: 16),textAlign: TextAlign.center,)),
                    SizedBox(height: Dimensions.height10,),
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.height30*1.5,right: Dimensions.height30*1.5),
                      child: const Divider(color: Colors.white,thickness: 1,),
                    ),
                    SizedBox(height: Dimensions.height10,),
                    Text(widget.list![currentIndex].revelationType!+' - '+widget.list![currentIndex].numberOfAyahs.toString()+' Verses',style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),),
                    SizedBox(height: Dimensions.height20,),
                    Image.asset('assets/images/besmallah.png',fit: BoxFit.cover,color: Colors.white,height: Dimensions.height30*2,width: Dimensions.height30*10,)
                  ],
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        if(currentIndex > 0){
                          setState(() {
                            dataIndex = currentIndex;
                            currentIndex--;
                          });
                          if(dataIndex<10){
                            ind = "00"+(dataIndex.toString());
                          }else if(dataIndex<100){
                            ind  = "0"+(dataIndex.toString());
                          }else if(dataIndex>100){
                            ind = (dataIndex.toString());
                          }

                          _initAudioPlayer(ind!, widget.qari);

                        }
                      },
                      icon: Icon(
                        FontAwesomeIcons.stepBackward,
                        size: MediaQuery.of(context).size.width * 0.05,
                      )),
                  StreamBuilder<PlayerState>(
                    stream: _player.playerStateStream,
                    builder: (context, snapshot) {
                      final playerState = snapshot.data;
                      final processingState = playerState?.processingState;
                      final playing = playerState?.playing;
                      if (processingState == ProcessingState.loading ||
                          processingState == ProcessingState.buffering) {
                        return Container(
                          //padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.fajar2,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            // width: _width * 0.24,
                            // height: _width * 0.24,
                            child: const SpinKitRipple(
                              color: Colors.black,
                              duration: Duration(milliseconds: 800),
                              //  size: _width * 0.24,
                            ));
                      } else if (playing != true) {
                        return InkWell(
                          onTap: _player.play,
                          child: Container(
                            //width: _width * 0.24,
                            //height: _width * 0.24,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.fajar2,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(
                              FontAwesomeIcons.play,
                              color: Colors.white,
                              size: MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                        );
                      } else if (processingState != ProcessingState.completed) {
                        return InkWell(
                          onTap: _player.pause,
                          child: Container(
                            //  width: _width * 0.24,
                            //  height: _width * 0.24,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.fajar2,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              FontAwesomeIcons.pause,
                              color: Colors.black,
                              size: MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                        );
                      } else {
                        return InkWell(
                          onTap: () => _player.seek(Duration.zero),
                          child: Container(
                            //  width: _width * 0.24,
                            //  height: _width * 0.24,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.fajar2,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.shuffle,
                              color: Colors.black,
                              size: MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      if(currentIndex >= 0 && currentIndex<113){
                        //currentIndex = (currentIndex + 1);
                        setState(() {
                          currentIndex++;
                          dataIndex = currentIndex + 1;
                        });
                        if(dataIndex<10){
                          ind = "00"+(dataIndex.toString());
                        }else if(dataIndex<100){
                          ind  = "0"+(dataIndex.toString());
                        }else if(dataIndex>100){
                          ind = (dataIndex.toString());
                        }

                        _initAudioPlayer(ind!, widget.qari);

                      }
                    },
                    icon: Icon(
                      FontAwesomeIcons.stepForward,
                      size: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                  // Opens speed slider dialog
                ],
              ),
              SizedBox(height: Dimensions.height15,),
              StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return SeekBar(
                    duration: positionData?.duration ?? defaultDuration,
                    position: positionData?.position ?? Duration.zero,
                    bufferedPosition:
                    positionData?.bufferedPosition ?? Duration.zero,
                    onChanged: _player.seek,
                  );
                },
              ),
              SizedBox(height: Dimensions.height30,),
              currentIndex >= 113 ? Container() :Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('UPCOMING SURAH',style: TextStyle(
                          fontSize: 20,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 12,),
                      Visibility(
                        visible: (currentIndex<=112) ? true : false,
                        child: Row(
                          children: [
                            const Icon(Icons.play_circle_fill,color: AppColors.fajar2,size: 50,),
                            SizedBox(width: Dimensions.height10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.list![currentIndex+1].englishName!,style: const TextStyle(color: AppColors.fajar2,
                                    fontSize: 20,fontWeight: FontWeight.bold),),
                                Text(widget.qari.name!,style: const TextStyle(
                                    fontSize: 14,fontWeight: FontWeight.w500),),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12,),
                      Visibility(
                        visible: ( currentIndex <=111) ? true : false,
                        child: Row(
                          children: [
                            Icon(currentIndex>111 ? null :Icons.play_circle_fill,color: AppColors.fajar2,size: 50,),
                            SizedBox(width: Dimensions.height10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(currentIndex>111 ? '' : widget.list![currentIndex+2].englishName!,style: const TextStyle(color: AppColors.fajar2,
                                    fontSize: 20,fontWeight: FontWeight.bold),),
                                Text(widget.qari.name!,style: const TextStyle(
                                    fontSize: 14,fontWeight: FontWeight.w500),),
                              ],
                            ),
                          ],
                        ),
                      ),
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
  void _initAudioPlayer(String ind, Qari qari,) async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');
        });
    // Try to load audio from a source and catch any errors.
    try {
      var url = "https://download.quranicaudio.com/quran/${qari.path}$ind.mp3";
      print('url $url');
      defaultDuration =  (await _player.setAudioSource(AudioSource.uri(Uri.parse(url))))!;
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;

   SeekBar({
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragValue;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.fajar2,
            inactiveTrackColor: Colors.grey,
            trackHeight: 5.0,
            thumbColor: AppColors.fajar2,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
            overlayColor: Colors.purple.withAlpha(32),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 14.0),
          ),
          child: Slider(
            min: 0.0,
            max: widget.duration.inMilliseconds.toDouble(),
            value: min(_dragValue ?? widget.position.inMilliseconds.toDouble(),
                widget.duration.inMilliseconds.toDouble()),
            onChanged: (value) {
              setState(() {
                _dragValue = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(Duration(milliseconds: value.round()));
              }
              _dragValue = null;
            },
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: _width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.position.toString().substring(0,widget.position.toString().indexOf('.')),                style: const TextStyle(
                    fontSize: 16),
              ),
              Text(
                widget.duration.toString().substring(0,widget.duration.toString().indexOf('.')),
                style: const TextStyle(
                    fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}



void showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  String valueSuffix = '',

  required double value,
  required Stream<double> stream,
  required ValueChanged<double> onChanged,}) {
  showDialog<void>(
    context: context,
    builder: (context) =>
        AlertDialog(
          title: Text(title, textAlign: TextAlign.center),
          content: StreamBuilder<double>(
            stream: stream,
            builder: (context, snapshot) =>
                SizedBox(
                  height: 100.0,
                  child: Column(
                    children: [
                      Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                          style: const TextStyle(
                              fontFamily: 'Fixed',
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0)),
                      Slider(
                        divisions: divisions,
                        min: min,
                        max: max,
                        value: snapshot.data ?? value,
                        onChanged: onChanged,
                      ),
                    ],
                  ),
                ),
          ),
        ),
  );
}