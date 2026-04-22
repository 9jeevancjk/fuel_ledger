import 'package:flutter/material.dart';
import 'package:fuel_ledger/pages/onboarding/app_stepper.dart';
import 'package:go_router/go_router.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int step = 0;

  // Form Data
  String ownerName = '';
  String phone = '';
  String pumpName = '';

  List<String> fuelTypes = [];
  int tanks = 1;
  int nozzles = 1;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Container(
          width: width > 600 ? 500 : double.infinity,
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(80.0),
                child: AppStepper(
                  currentStep: step,
                  totalSteps: 4,
                  titles: const ["Basic", "Config", "Setup", "Plan"],
                ),
              ),
              const SizedBox(height: 30),
              Expanded(child: _buildStep()),
              _buildNavigation(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep() {
    switch (step) {
      case 0:
        return _basicInfo();
      case 1:
        return _configuration();
      case 2:
        return _businessSetup();
      case 3:
        return _planSelection();
      default:
        return const SizedBox();
    }
  }

  // STEP 1
  Widget _basicInfo() {
    return Column(
      children: [
        _input("Owner Name", (v) => ownerName = v),
        _input("Mobile Number", (v) => phone = v, isNumber: true),
        _input("Pump Name", (v) => pumpName = v),
      ],
    );
  }

  // STEP 2
  Widget _configuration() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Select Fuel Types"),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: ["Petrol", "Diesel", "Power"].map((fuel) {
            return ChoiceChip(
              label: Text(fuel),
              selected: fuelTypes.contains(fuel),
              onSelected: (val) {
                setState(() {
                  val ? fuelTypes.add(fuel) : fuelTypes.remove(fuel);
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        _input(
          "No. of Tanks",
          (v) => tanks = int.tryParse(v) ?? 1,
          isNumber: true,
        ),
        _input(
          "No. of Nozzles",
          (v) => nozzles = int.tryParse(v) ?? 1,
          isNumber: true,
        ),
      ],
    );
  }

  // STEP 3
  Widget _businessSetup() {
    return Column(
      children: const [
        Text("Business Setup (Optional)", style: TextStyle(fontSize: 18)),
        SizedBox(height: 10),
        Text("You can skip and configure later."),
      ],
    );
  }

  // STEP 4
  Widget _planSelection() {
    return Column(
      children: [
        _planCard("Free Demo", "7 Days", false),
        _planCard("Basic", "₹999/month", false),
        _planCard("Premium", "₹1999/month", true),
      ],
    );
  }

  Widget _planCard(String title, String price, bool popular) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: popular ? Colors.orange : Colors.grey.shade300,
          width: 1.2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(price),
            ],
          ),
          ElevatedButton(onPressed: () {}, child: const Text("Select")),
        ],
      ),
    );
  }

  Widget _input(
    String label,
    Function(String) onChanged, {
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onChanged: onChanged,
      ),
    );
  }

  // NAVIGATION
  Widget _buildNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (step > 0)
          TextButton(
            onPressed: () => setState(() => step--),
            child: const Text("Back"),
          ),
        ElevatedButton(
          onPressed: () {
            if (step < 3) {
              setState(() => step++);
            } else {
              _finish();
            }
          },
          child: Text(step == 3 ? "Finish" : "Next"),
        ),
      ],
    );
  }

  void _finish() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Success"),
        content: const Text("Your FuelLedger is ready!"),
        actions: [
          TextButton(
            onPressed: () {
              context.push('/dashboard');
            },
            child: const Text("Go to Dashboard"),
          ),
        ],
      ),
    );
  }
}

// class AppStepper extends StatelessWidget {
//   final int currentStep;
//   final int totalSteps;
//   final List<String> titles;

//   const AppStepper({
//     super.key,
//     required this.currentStep,
//     required this.totalSteps,
//     required this.titles,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: List.generate(totalSteps, (index) {
//             bool isActive = index == currentStep;
//             bool isCompleted = index < currentStep;

//             return Expanded(
//               child: Row(
//                 children: [
//                   _circle(index, isActive, isCompleted),
//                   if (index != totalSteps - 1)
//                     Expanded(
//                       child: Container(
//                         height: 3,
//                         color: isCompleted
//                             ? Colors.green
//                             : Colors.grey.shade300,
//                       ),
//                     ),
//                 ],
//               ),
//             );
//           }),
//         ),
//         const SizedBox(height: 10),
//         Row(
//           children: List.generate(totalSteps, (index) {
//             return Expanded(
//               child: Text(
//                 titles[index],
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: index == currentStep
//                       ? FontWeight.bold
//                       : FontWeight.normal,
//                 ),
//               ),
//             );
//           }),
//         ),
//       ],
//     );
//   }

//   Widget _circle(int index, bool isActive, bool isCompleted) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       width: 28,
//       height: 28,
//       decoration: BoxDecoration(
//         color: isCompleted
//             ? Colors.green
//             : isActive
//             ? Colors.blue
//             : Colors.grey.shade300,
//         shape: BoxShape.circle,
//       ),
//       child: Center(
//         child: isCompleted
//             ? const Icon(Icons.check, size: 16, color: Colors.white)
//             : Text(
//                 "${index + 1}",
//                 style: TextStyle(
//                   color: isActive ? Colors.white : Colors.black,
//                   fontSize: 12,
//                 ),
//               ),
//       ),
//     );
//   }
// }
