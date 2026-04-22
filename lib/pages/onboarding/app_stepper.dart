import 'package:flutter/material.dart';

class AppStepper extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<String> titles;

  const AppStepper({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.titles,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(totalSteps, (index) {
            bool isActive = index == currentStep;
            bool isCompleted = index < currentStep;

            return Expanded(
              child: Row(
                children: [
                  _buildStepCircle(index, isActive, isCompleted),
                  if (index != totalSteps - 1)
                    Expanded(
                      child: Container(
                        height: 3,
                        color: isCompleted
                            ? Colors.green
                            : Colors.grey.shade300,
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(totalSteps, (index) {
            return Expanded(
              child: Text(
                titles[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: index == currentStep
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildStepCircle(int index, bool isActive, bool isCompleted) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: isCompleted
            ? Colors.green
            : isActive
                ? Colors.blue
                : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: isCompleted
            ? const Icon(Icons.check, size: 16, color: Colors.white)
            : Text(
                "${index + 1}",
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.black,
                  fontSize: 12,
                ),
              ),
      ),
    );
  }
}