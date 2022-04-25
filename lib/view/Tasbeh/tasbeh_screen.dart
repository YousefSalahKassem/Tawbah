import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tawbah/data/azakar.dart';
import '../../constants/colors.dart';
import '../../constants/dimensions.dart';

class TasbehScreen extends StatefulWidget {
  const TasbehScreen({Key? key}) : super(key: key);

  @override
  State<TasbehScreen> createState() => _TasbehScreenState();
}

class _TasbehScreenState extends State<TasbehScreen> {
  TextEditingController target=TextEditingController(text: '1');
  String dropdownvalue = azakr[0];
  String value='';
  int counter=0;
  int temp=1;


  @override
  void setState(VoidCallback fn) {
    dropdownvalue;
    super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight:Dimensions.height10*7,
        centerTitle: true,
        backgroundColor: AppColors.isha2,
        title: const Text('Tasbeh',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius:BorderRadius.vertical(
              bottom: Radius.circular(15),) ,
            color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage('assets/images/mosque.png'),
              opacity: .5,
              fit: BoxFit.cover,
            ),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(value,style: GoogleFonts.workSans(textStyle:const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: AppColors.fajar2),),maxLines: 2,textAlign: TextAlign.center),
              SizedBox(height: Dimensions.height30,),
              Text(temp.toString(),style:const TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
              SizedBox(height: Dimensions.height30,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: (){}, icon: const Icon(Icons.remove,size: 30)),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: Dimensions.height30,
                        width: Dimensions.height30*9,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          child: LinearProgressIndicator(
                            color: AppColors.fajar2,
                            value: counter/int.parse(target.text),
                            backgroundColor: Colors.grey.shade400,
                          ),
                        ),
                      ),
                      Align(child: Text(counter.toString(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),), alignment: Alignment.topCenter,),
                    ],
                  ),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.add,size: 30)),
                ],
              ),
              SizedBox(height: Dimensions.height30*3,),
              InkWell(
                onTap: (){
                  setState(() {
                    if(counter>=int.parse(target.text)){}
                    else {counter++;}
                  });
                },
                child: Image.asset('assets/images/auth.png',width: Dimensions.height30*2.5,),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()async{
        await showDialog(context: context, builder: (BuildContext context){
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter dropDownState){
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SizedBox(
                  height: Dimensions.height30*13,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(onPressed: (){
                            Navigator.pop(context);
                          }, icon: const Icon(Icons.close,color: Colors.grey,)),
                        ),
                        SizedBox(height: Dimensions.height20,),
                        Container(
                          height: Dimensions.height30*2,
                          padding: const EdgeInsets.all(10),
                          decoration:BoxDecoration(
                              border: Border.all(
                                color: AppColors.fajar2,width: 2,
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(5))
                          ),
                          child: DropdownButton(
                              value: dropdownvalue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: azakr.map((String items) =>
                                  DropdownMenuItem(
                                      value: items,
                                      child: SizedBox(
                                          width:Dimensions.height30*9,
                                          child: Text(items,maxLines: 1,)))).toList(),
                              onChanged: (String? newValue){
                                dropDownState((){
                                  dropdownvalue=newValue!;
                                });
                              }
                          ),
                        ),
                        SizedBox(height: Dimensions.height20*1.5,),
                        TextFormField(
                          controller: target,
                          decoration: const InputDecoration(
                            labelText: 'Your Target',
                            labelStyle: TextStyle(color: AppColors.fajar2,fontWeight: FontWeight.bold),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.fajar2, width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.fajar2, width: 2.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.fajar2, width: 2.0),
                            ),
                          ),
                        ),
                        SizedBox(height: Dimensions.height30*2,),
                        InkWell(
                          onTap: (){
                            counter=0;
                            setState(() {
                              temp=int.parse(target.text);
                              value=dropdownvalue;
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.only(left:Dimensions.height30*3,right:Dimensions.height30*3,bottom: Dimensions.height15,top: Dimensions.height15),
                            decoration: BoxDecoration(
                              color: AppColors.fajar2,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: const Text('Ok',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
      },backgroundColor: AppColors.fajar2,child: const Icon(Icons.add,color: Colors.white,),),
    );
  }
}
