import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  SimpleDialog(
        title: Text('About course'),
        children: [
          SimpleDialogOption(
            child: Text(
              "this course is about Quo animi dicta neque quis dolorum earum. Iure ut quidem voluptatem quo aperiam eaque. Et iste debitis voluptate. Et commodi illo consequuntur dolore natus ut.Deserunt est illo quia suscipit. Nisi ut ea ut eos illo et. Quam quia placeat eligendi. Sit perspiciatis ullam necessitatibus voluptatibus quibusdam quas. Voluptas necessitatibus unde officiis.Delectus similique accusamus cum Quo animi dicta neque quis dolorum earum. Iure ut quidem voluptatem quo aperiam eaque. Et iste debitis voluptate. Et commodi illo consequuntur dolore natus ut.Deserunt est illo quia suscipit. Nisi ut ea ut eos illo et. Quam quia placeat eligendi. Sit perspiciatis ullam necessitatibus voluptatibus quibusdam quas. Voluptas necessitatibus unde officiis.Delectus similique accusamus cum aut eligendi voluptatem nihil. Eum in vel aut sunt. Voluptatem aut vero iste fugiat id culpa vitae. Dolor repellendus tempore aliquam etOdio quibusdam omnis sed comaut eligendi voluptatem nihil. Eum in vel aut sunt. Voluptatem aut vero iste fugiat id culpa vitae. Dolor repellendus tempore aliquam et."
            ),
          )

        ],
      )
    ;
  }
}
