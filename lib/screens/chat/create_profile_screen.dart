import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Create profile"),
        titleSpacing: 0,
        centerTitle: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(CupertinoIcons.chevron_back),
        ),
      ),
      body: SafeArea(
          child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          color: Colors.white,
          margin: const EdgeInsets.only(top: 24),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    InkWell(
                      child: Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                                color: Color(0xFFF7F7FC),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: const Icon(
                              Icons.person_outline,
                              size: 50,
                            ),
                          ),
                          const Positioned(
                            right: 8,
                            bottom: 0,
                            child: Icon(Icons.add_circle),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      child: TextFormField(
                        autocorrect: false,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        decoration: const InputDecoration(
                          hintStyle:
                              TextStyle(height: 2, color: Color(0xFFADB5BD)),
                          filled: true,
                          fillColor: Color(0xFFF7F7FC),
                          hintText: 'First Name (required)',
                          isDense: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      child: TextFormField(
                        autocorrect: false,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        decoration: const InputDecoration(
                          hintStyle:
                              TextStyle(height: 2, color: Color(0xFFADB5BD)),
                          filled: true,
                          fillColor: Color(0xFFF7F7FC),
                          hintText: 'Last Name (optional)',
                          isDense: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/chats');
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Color(0xFF002DE3),
                      borderRadius: BorderRadius.all(Radius.circular(32))),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
