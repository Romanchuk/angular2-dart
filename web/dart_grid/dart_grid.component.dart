import 'package:angular2/core.dart';
import '../lib/pipes/address.pipe.dart';
import '../models/user.model.dart';
import '../services/users.service.dart';

@Component(
  selector: 'dart-grid',
  templateUrl: 'dart_grid.component.html',
  providers: const [UserService],
  pipes: const [AddressPipe]
)
class DartGridComponent implements OnChanges {

  List<User> _originalList = new List<User>();
  List<User> orderedList = new List<User>();

  String orderBy = "";
  dynamic orderAsc = null;

  @Input() List<User> users;

  @override
  ngOnChanges(Map<String, SimpleChange> changes) {
    _updateList(changes['users'].currentValue);
  }

  triggerOrder(dynamic event, String fieldName) {
    if (fieldName == orderBy)
      orderAsc = _nextOrderAsc(orderAsc);
    else
      orderAsc = true;
    orderBy = fieldName;
    this.orderedList = _sortList(_originalList);
  }

  String getClassName(String fieldName){
    if (orderBy != fieldName)
      return "";
    if (orderAsc == null)
      return "";
    if (orderAsc == true)
      return "glyphicon glyphicon-chevron-down";
    else if (orderAsc == false)
      return "glyphicon glyphicon-chevron-up";
    return "";
  }

  _nextOrderAsc(orderAsc) {
    if (orderAsc == null)
      return true;
    else if (orderAsc)
      return false;
    else
      return null;
  }

  _sortList(List<User> list){
    if (list == null)
      return list;
    if (orderAsc == null || orderBy == "" || orderBy == null)
      return _originalList;
    var newList = new List.from(list);
    newList.sort((User left, User right) {
      var leftVal = left.fields[orderBy];
      if (leftVal == null)
        return -1;
      return left.fields[orderBy].compareTo(right.fields[orderBy]);
    });
    if (orderAsc == false)
      return newList.reversed;
    return newList;
  }

  _updateList(data) {
    _originalList = new List<User>.from(data);
    this.orderedList = _sortList(_originalList);
  }


}
