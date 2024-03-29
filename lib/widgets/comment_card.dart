import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatelessWidget {
  
  final snapshot;
  const CommentCard({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(

              snapshot.data()['ProfilePicture'],
            ),

            radius: 18,
          ),

          Expanded(

            child: Padding(

              padding: const EdgeInsets.only(left: 16),
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  RichText(
                    text: TextSpan(
                      children: [

                        TextSpan(
                            text: snapshot.data()['Name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        TextSpan(
                          text: ' ${snapshot.data()['Text']}',
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(

                      DateFormat.yMMMd().format(
                        snapshot.data()['Date'].toDate(),

                      ),
                      style: const TextStyle(

                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,

                      ),
                      //   fontfamily: 'Roboto',
                      //  fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.favorite,
              size: 16,
            ),
          )

        ],
      ),
    );
  }
}
