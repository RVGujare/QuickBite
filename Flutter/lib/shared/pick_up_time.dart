import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bite/constants/colors.dart';
import 'package:quick_bite/constants/custom_outlined_button.dart';
import 'package:quick_bite/student/cart/cart_cubit.dart';

// class PickupTimeScreen extends StatefulWidget {
//   const PickupTimeScreen(
//       {super.key,
//       required this.maxPrepTime,
//       required this.screenWidth,
//       required this.screenHeight,
//       required this.currentTime});
//   final double screenWidth;
//   final double screenHeight;
//   final int maxPrepTime;
//   final DateTime currentTime;

//   @override
//   _PickupTimeScreenState createState() => _PickupTimeScreenState();
// }

// class _PickupTimeScreenState extends State<PickupTimeScreen> {
//   late TimeOfDay _selectedTime;

//   TimeOfDay getMinSelectableTime() {
//     Duration maxPrepTime = Duration(minutes: widget.maxPrepTime);
//     debugPrint('max prep time - $maxPrepTime');
//     final minTime = widget.currentTime.add(maxPrepTime);
//     return TimeOfDay(hour: minTime.hour, minute: minTime.minute);
//   }

//   void _updateSelectedTime() {
//     setState(() {
//       _selectedTime = getMinSelectableTime();
//       context.read<CartCubit>().pickUpTime = _selectedTime;
//     });
//   }

//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay minTime = getMinSelectableTime();
//     final TimeOfDay initialTime = minTime;
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: initialTime,
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: ThemeData.dark().copyWith(
//             primaryColor: primaryBrown,
//             buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
//           ),
//           child: child!,
//         );
//       },
//     );

//     if (pickedTime == null) return;

//     int minTimeInMinutes = minTime.hour * 60 + minTime.minute;
//     int pickedTimeInMinutes = pickedTime.hour * 60 + pickedTime.minute;

//     if (pickedTimeInMinutes >= minTimeInMinutes) {
//       setState(() {
//         _selectedTime = pickedTime;
//         context.read<CartCubit>().pickUpTime = _selectedTime;
//       });
//     } else {
//       int minutes = widget.maxPrepTime;

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Minimum waiting time is $minutes minutes',
//           ),
//         ),
//       );
//     }
//   }

//   static void placeOrder() {}

//   @override
//   void initState() {
//     super.initState();
//     _selectedTime = getMinSelectableTime();
//     context.read<CartCubit>().pickUpTime = _selectedTime;
//   }

//   @override
//   Widget build(BuildContext context) {
//     _updateSelectedTime();
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text('Collect order at: '),
//               Text(
//                 _selectedTime.format(context),
//                 style: const TextStyle(fontSize: 24),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           CustomOutlinedButton(widget.screenWidth, widget.screenHeight,
//               'Change Time', () => _selectTime(context)),
//         ],
//       ),
//     );
//   }
// }

class PickupTimeScreen extends StatefulWidget {
  const PickupTimeScreen(
      {super.key,
      required this.maxPrepTime,
      required this.screenWidth,
      required this.screenHeight,
      required this.currentTime});
  final double screenWidth;
  final double screenHeight;
  final int maxPrepTime;
  final DateTime currentTime;

  @override
  _PickupTimeScreenState createState() => _PickupTimeScreenState();
}

class _PickupTimeScreenState extends State<PickupTimeScreen> {
  late TimeOfDay _selectedTime;

  TimeOfDay getMinSelectableTime() {
    Duration maxPrepTime = Duration(minutes: widget.maxPrepTime);
    final minTime = widget.currentTime.add(maxPrepTime);
    return TimeOfDay(hour: minTime.hour, minute: minTime.minute);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay minTime = getMinSelectableTime();
    final TimeOfDay initialTime = _selectedTime; // Use current selected time

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: primaryBrown,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime == null) return;

    // Convert times to minutes for consistent comparison
    int minTimeInMinutes = minTime.hour * 60 + minTime.minute;
    int pickedTimeInMinutes = pickedTime.hour * 60 + pickedTime.minute;

    // Handle time validation, including cross-day times
    debugPrint('min time - $minTimeInMinutes');
    debugPrint('picked time - $pickedTimeInMinutes');
    if (pickedTimeInMinutes >= minTimeInMinutes) {
      setState(() {
        _selectedTime = pickedTime;
        context.read<CartCubit>().pickUpTime = _selectedTime;
      });
    } else {
      // Show a snackbar if the selected time is invalid
      final int minutes = widget.maxPrepTime;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Minimum waiting time is $minutes minutes',
            style: TextStyle(color: red),
          ),
          backgroundColor: white,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedTime = getMinSelectableTime();
    context.read<CartCubit>().pickUpTime = _selectedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Collect order at: '),
              Text(
                _selectedTime.format(context),
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CustomOutlinedButton(widget.screenWidth, widget.screenHeight,
              'Change Time', () => _selectTime(context)),
        ],
      ),
    );
  }
}
