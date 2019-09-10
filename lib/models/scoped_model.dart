import 'package:scoped_model/scoped_model.dart';
import 'package:hackathon_reforged/models/target_model.dart';

class AppModel extends Model{
  List <Target> _targetList = [];
  List <Target> get targets => _targetList;

  void addTarget(Target target){
    _targetList.add(target);
  }
}