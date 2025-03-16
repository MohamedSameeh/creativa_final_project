import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim/model/azkar_model.dart';

class AzkarScreen extends StatefulWidget {
  const AzkarScreen({super.key});

  @override
  _AzkarScreenState createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen> {
  List<String> azkarNames = [
    'أذكار الصباح',
    'أذكار المساء',
    'أذكار بعد الصلاة المفروضة',
    'تسبيح',
    'أذكار النوم',
  ];
  @override
  whatAzkaris(String azkarType, BuildContext context) {
    AzkarData azkarData = AzkarData();
    Map<String, dynamic> azkarMap = {
      'أذكار الصباح': azkarData.azkarElsabah,
      'أذكار المساء': azkarData.azkarElmasaa,
      'أذكار بعد الصلاة المفروضة': azkarData.azkarAfterSalah,
      'تسبيح': azkarData.tasbeeh,
      'أذكار النوم': azkarData.azkarAlnoum,
    };
    Navigator.pushNamed(context, 'azkarBody', arguments: azkarMap[azkarType]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade700, Colors.blue.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisExtent: 140,
                  mainAxisSpacing: 10,
                ),
                itemCount: azkarNames.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => whatAzkaris(azkarNames[index], context),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(3, 3),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            Colors.purpleAccent.shade100,
                            Colors.blue.shade500,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          azkarNames[index],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.philosopher(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black45,
                                  blurRadius: 3,
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
