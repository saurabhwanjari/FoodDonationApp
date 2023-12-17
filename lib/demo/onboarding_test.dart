import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingTest extends StatelessWidget {
  const OnboardingTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top:100, bottom: 30),
      color: Color(0XFF1f1710),
      child: IntroductionScreen(
        pages: [p1, p2, p3, p4],
        onDone: () {
          //
        },
        done: Text('Done'),
        showSkipButton: true,
        skip: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Skip'),
          ],
        ),
        onSkip: () {
          //
        },
        next: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            //
            Text(
              'Next ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),

            //
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 22,
            ),
          ],
        ),
        globalBackgroundColor: Color(0XFF1f1710),
        dotsDecorator: DotsDecorator(
          color: Color(0Xffbfbfbf),
          activeColor: Color(0Xffff7037),
          //activeSize: const Size(20.0, 10.0),
        ),
      ),
    );
  }
}

PageViewModel p1 = PageViewModel(
  title: 'Title1',
  body:
      'Some text that describe the on boarding in meaning full and constructive way so that user can understand it.',
  image: Image.asset('images/image1.png'),
);

PageViewModel p2 = PageViewModel(
  title: 'Title2',
  body:
      'Some text that describe the on boarding in meaning full and constructive way so that user can understand it.',
  image: Image.asset('images/image2.png'),
);

PageViewModel p3 = PageViewModel(
  title: 'Title3',
  body:
      'Some text that describe the on boarding in meaning full and constructive way so that user can understand it.',
  image: Image.asset('images/image3.png'),
);

PageViewModel p4 = PageViewModel(
  title: 'Title4',
  body:
      'Some text that describe the on boarding in meaning full and constructive way so that user can understand it.',
  image: Image.asset('images/image4.png'),
);