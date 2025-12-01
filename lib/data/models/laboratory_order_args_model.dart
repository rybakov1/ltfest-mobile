import 'package:ltfest/data/models/laboratory.dart';
import 'package:ltfest/data/models/laboratory_learning_type.dart';

class LaboratoryOrderArgsModel {
  final Laboratory laboratory;
  final LearningType learningType;

  LaboratoryOrderArgsModel({
    required this.laboratory,
    required this.learningType,
  });
}
