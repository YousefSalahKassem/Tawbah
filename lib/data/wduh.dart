class Guide{
  String title;
  List<wduhDetails> details;

  Guide(this.title, this.details);
}

class wduhDetails{
  String description;
  String image;

  wduhDetails(this.description, this.image);
}

List<Guide> guide=[
  Guide('Wudu Steps', [
    wduhDetails('Make niyyah (intention) to perform wudu, and say "Bismillah" (in the name of Allah) before starting wudu.', ''),
    wduhDetails('Wash your hands. Use your left hand to wash your right hand. Do this three times. After that, use your right hand to wash your left hand three times. Make sure to wash in between your fingers and all the way up to your wrists.', 'assets/images/wudu-wash-hands.png'),
    wduhDetails('Take water into your mouth. Use your right hand to cup water into your mouth three times. Swish it around in your cheeks. Do this thoroughly.', 'assets/images/wudu-rinse-mouth.png'),
    wduhDetails('Inhale water into your nose. Use your right hand to cup water and inhale it into your nose and blow out three times. Snort sharply and abruptly without taking too much water into your nose and choking yourself. If you cannot inhale water into your nose, you can wet your fingers and put water on the lower part of your nostrils.', 'assets/images/wudu-into-nose.png'),
    wduhDetails('Wash your face. Wash your face three times by spreading your hands from your right ear to the left, and from the hairline to the chin.', 'assets/images/wudu-wash-face.png'),
    wduhDetails('Wash your lower arms from wrists to elbows, leaving no part dry. From your wrist to your elbow, wash your right arm with your left hand three times and then wash your left arm with your right hand three times.', 'assets/images/wudu-wash-arms.png'),
    wduhDetails('Clean your head. This is known as "maseh". Using your wet hands, gently wipe the entire head once, from the forehead to the back of the head, and wipe it again forward from the back of the head to the forehead.', 'assets/images/wudu-wash-hair.png'),
    wduhDetails('Wipe your ears inside and out. Use your thumb to clean behind your ears from the bottom upward. This is also done one time.', 'assets/images/wudu-clean-ears.png'),
    wduhDetails('Wash both of your feet. Clean up to the ankles and be sure water goes between the toes. Use your pinky finger and go through each toe to eliminate anything between. Start with your right foot and scrub each foot three times.', 'assets/images/wudu-wash-feet.png'),
  ]),

];