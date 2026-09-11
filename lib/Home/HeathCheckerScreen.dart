import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.8),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      alignment: AlignmentGeometry.centerLeft,
                      children: [
                        Container(
                          height: 60,
                          width: 250,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(colors:
                              [
                                Color(0xFF147B72),
                                Color(0xFF0C524C)
                              ]),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(1),
                                  bottomRight: Radius.circular(50),
                                  topLeft: Radius.circular(1),
                                  bottomLeft: Radius.circular(1)
                              )
                          ),
                        ),

                        Padding(padding: EdgeInsets.only(
                            left: 20
                        ),
                          child: Text(
                            "ClimaFits️⚡️",
                            style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Tinos",
                                color: Colors.white
                            ),

                          ),)
                      ],
                    )
                  ],

                ),

                SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child:

                    Column(
                      children: [



                        const SizedBox(height: 20),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularPercentIndicator(
                              radius: 120,
                              lineWidth: 12,
                              percent: 0.75,
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: const Color(0xFF147B72),
                              backgroundColor: const Color(0xffDDEFEA),
                            ),
                            CircularPercentIndicator(
                              radius: 95,
                              lineWidth: 10,
                              percent: 0.65,
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: const Color(0xFF366692),
                              backgroundColor: const Color(0xffDCE1EB),
                            ),
                            Column(
                              children: const [
                                Text(
                                  "20",
                                  style: TextStyle(
                                    fontSize: 60,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff44B08C),
                                  ),
                                ),
                                Text(
                                  "5",
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Color(0xff2F56B0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.favorite_border, color: Color(0xff44B08C)),
                            SizedBox(width: 5),
                            Text(
                              "Heart Pts",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 25),
                            Icon(Icons.directions_walk, color: Color(0xff2F56B0)),
                            SizedBox(width: 5),
                            Text(
                              "Steps",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            _StateWidget("100", "cal"),
                            _StateWidget("12", "miles"),
                            _StateWidget("56", "Move Min"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Your Daily Goals",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                "Last 7 days",
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Column(
                                    children: const [
                                      Text(
                                        "5/7",
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Color(0xff3F72FF),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Achieved",
                                        style: TextStyle(
                                          color: Color(0xff3F72FF),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: List.generate(
                                      7,
                                          (index) => const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 3),
                                        child: CircleAvatar(
                                          radius: 14,
                                          backgroundColor: Color(0xffE6F4EE),
                                          child: CircleAvatar(
                                            radius: 10,
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20,),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Your Weekly Target",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(Icons.chevron_right),
                                ],
                              ),
                              SizedBox(height: 5,),
                              const Text(
                                "Sep 3-9 ",
                                style: TextStyle(color: Colors.grey),
                              ),

                              SizedBox(height: 5,),
                              Text(
                                "0 of 150",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff44B08C)
                                ),
                              ),

                              const SizedBox(height: 5,),

                              LinearProgressIndicator(
                                value: 0.1,
                                minHeight: 8,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              const SizedBox(height: 25,),
                              const Text(
                                "Scoring 150 Heart Points a week can help you live longer, sleep better, and boost your mood",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      )
    );
  }
}

class _StateWidget extends StatelessWidget {
  final String value;
  final String title;

  const _StateWidget(this.value, this.title);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 28,
            color: Color(0xff3F72FF),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(title),
      ],
    );
  }
}