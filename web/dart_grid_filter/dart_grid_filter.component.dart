import 'package:angular2/core.dart';
import '../models/user.model.dart';
import 'dart_grid_filter.model.dart';
import 'dart:collection';
import 'dart_grid_filter.decorators.dart';

@Component(
  selector: 'dart-grid-filter',
  templateUrl: 'dart_grid_filter.component.html'
)
class DartGridFilterComponent implements  OnChanges {
  @Input() List<User> list = new List<User>();
  @Output() EventEmitter<DartGridFilter<User>> filterUpdated = new EventEmitter();

  HashMap<String, DartGridFilterItem> uniqueGenders = new HashMap<String, DartGridFilterItem>();
  HashMap<String, DartGridFilterItem> uniqueDepartments = new HashMap<String, DartGridFilterItem>();
  HashMap<String, DartGridFilterItem> uniqueCities = new HashMap<String, DartGridFilterItem>();

  toggleFilter(dynamic event, DartGridFilterItem filter){
    filter.active = event.target.checked; //sync active value. BUG?

    var newFilter = new DartGridFilter<User>();

    uniqueGenders.values
      .where((f)=>f.active)
      .forEach((item)=>newFilter = new GenderDartGridFilterDecorator(item.value, newFilter));

    uniqueDepartments.values
      .where((f)=>f.active)
      .forEach((item)=>newFilter = new DepartmentDartGridFilterDecorator(item.value, newFilter));

    uniqueCities.values
      .where((f)=>f.active)
      .forEach((item)=>newFilter = new CityDartGridFilterDecorator(item.value, newFilter));

    filterUpdated.emit(newFilter);
  }

  HashMap<String, DartGridFilterItem> _buildFilter(Iterable<String> collection) {
    HashMap<String, DartGridFilterItem> filterItems = new HashMap<String, DartGridFilterItem>();
    collection.forEach((item) {
      if (!filterItems.containsKey(item))
        filterItems[item] = new DartGridFilterItem(item, 1);
      else
        filterItems[item].count++;
    });
    return filterItems;
  }

  _rebuildFilters() {
    var mappedGenders = this.list.map((User item)=>item.gender);
    HashMap<String, DartGridFilterItem> newUniqGenders = _buildFilter(mappedGenders);
    uniqueGenders.keys.forEach((k) {
      if (newUniqGenders.containsKey(k))
        newUniqGenders[k].active = uniqueGenders[k].active;
    });
    uniqueGenders = newUniqGenders;

    var mappedDepartments = this.list.map((User item)=>item.department);
    HashMap<String, DartGridFilterItem> newUniqDeparts = _buildFilter(mappedDepartments);
    uniqueDepartments.keys.forEach((k) {
      if (newUniqDeparts.containsKey(k))
        newUniqDeparts[k].active = uniqueDepartments[k].active;
    });
    uniqueDepartments = newUniqDeparts;

    var mappedCities = this.list.map((User item)=>item.address?.city);
    HashMap<String, DartGridFilterItem> newUniqCities = _buildFilter(mappedCities);
    uniqueCities.keys.forEach((k) {
      if (newUniqCities.containsKey(k))
        newUniqCities[k].active = uniqueCities[k].active;
    });
    uniqueCities = newUniqCities;
  }

  @override
  ngOnChanges(Map<String, SimpleChange> changes) {
    this.list = changes['list'].currentValue;
    _rebuildFilters();
  }
}
