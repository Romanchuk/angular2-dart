import 'package:angular2/core.dart';
import 'dart_grid/dart_grid.component.dart';
import 'dart:async';
import 'services/users.service.dart';
import 'models/user.model.dart';
import 'dart_grid_filter/dart_grid_filter.component.dart';
import 'dart_grid_filter/dart_grid_filter.decorators.dart';

@Injectable()
@Component(
  selector: 'my-app',
  templateUrl: 'app_component.html',
  directives: const [DartGridComponent, DartGridFilterComponent],
  providers: const [UserService]
)
class AppComponent implements OnInit, OnDestroy {
  final UserService _userService;
  AppComponent(this._userService);
  String errorMessage;
  StreamSubscription _sub;
  List<User> users = new List<User>();
  List<User> originalList = new List<User>();
  Stream<User> _originalStream;
  Stream<User> filteredStream = new Stream.empty();

  Future<Null> ngOnInit() => getUsers();

  Future<Null> getUsers() async {
    try {
      _originalStream = this._userService.get();
      filteredStream = _originalStream;
      _originalStream
        .toList()
        .then((List<User> data) {
          this.originalList = data;
          this.users = new List.from(this.originalList);
        });
    } catch (e) {
      print("Error: " + e);
      throw e;
    }
  }

  applyFilters(DartGridFilter filter) async {
      Stream<User> originalStream = new Stream.fromIterable(this.originalList);
      this.users = await filter.applyTo(originalStream).toList();
  }

  @override
  ngOnDestroy() {
    if(_sub != null) _sub.cancel();//todo: dispose subsciption?
  }
}
