import 'package:flutter_channel/view/importer.dart';

class StepNo with ChangeNotifier {
  int _currentStep = 0;

  int get getCurrentStep => _currentStep;

  void setCurrentStep(int currentStep) {
    _currentStep = currentStep;
    notifyListeners();
  }

  void stepIncrement() {
    _currentStep++;
    notifyListeners();
  }

  void stepDecrement() {
    _currentStep--;
    notifyListeners();
  }
}
