import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 30,
                        offset: const Offset(1, 1),
                      )
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(60)),
                      child: Image.network(
                        'https://cdnimg.vietnamplus.vn/uploaded/bokttj/2023_01_02/avatar_the_way_of_water.jpg',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Avatar: The way of Water',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('avatar.com.vn'),
                          ],
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 30,
                        offset: const Offset(1, 1),
                      )
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                child: Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SvgPicture.asset("assets/svgs/faq.svg"),
                      Container(
                          margin: const EdgeInsets.only(left: 8, top: 4),
                          child: const Text("FAQ"))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 30,
                        offset: const Offset(1, 1),
                      )
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                child: Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SvgPicture.asset("assets/svgs/contact.svg"),
                      Container(
                          margin: const EdgeInsets.only(left: 8, top: 4),
                          child: const Text("Contact"))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 30,
                        offset: const Offset(1, 1),
                      )
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                child: Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SvgPicture.asset("assets/svgs/term.svg"),
                      Container(
                          margin: const EdgeInsets.only(left: 8, top: 4),
                          child: const Text("Term & Conditions"))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
