import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/cubit/quraan_cubit/quraan_cubit.dart';
import 'package:muslim/model/quraan_model.dart';

class PrayerTime extends StatelessWidget {
  const PrayerTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade900, Colors.blue.shade600],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: FutureBuilder<List<PrayerTimes>>(
                  future:
                      BlocProvider.of<QuraanCubit>(context).getPrayerTimes(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    }

                    if (snapshot.hasError ||
                        !snapshot.hasData ||
                        snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'Unable to load prayer times',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    List<PrayerTimes> prayerTime = snapshot.data!;
                    return _buildPrayerTimesList(prayerTime);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back button
          // IconButton(
          //   icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          //   onPressed: () => Navigator.pop(context),
          // ),
          // Location and Date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Cairo, Egypt',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _getCurrentDate(),
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerTimesList(List<PrayerTimes> prayerTime) {
    List<String> prayerNames = [
      'Fajr',
      'Sunrise',
      'Dhuhr',
      'Asr',
      'Sunset',
      'Maghrib',
      'Isha',
    ];

    List<IconData> prayerIcons = [
      Icons.wb_twilight,
      Icons.wb_sunny,
      Icons.wb_cloudy,
      Icons.wb_shade,
      Icons.wb_incandescent,
      Icons.nightlight_round,
      Icons.dark_mode,
    ];

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: prayerNames.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(prayerIcons[index], color: Colors.white, size: 30),
            ),
            title: Text(
              prayerNames[index],
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            trailing: Text(
              _getPrayerTime(prayerTime[0], index),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );
  }

  String _getPrayerTime(PrayerTimes times, int index) {
    switch (index) {
      case 0:
        return times.fajr;
      case 1:
        return times.sunrise;
      case 2:
        return times.dhuhr;
      case 3:
        return times.asr;
      case 4:
        return times.sunset;
      case 5:
        return times.maghrib;
      case 6:
        return times.isha;
      default:
        return '';
    }
  }

  String _getCurrentDate() {
    // You can use intl package for more formatted date
    DateTime now = DateTime.now();
    return '${now.day}/${now.month}/${now.year}';
  }
}
