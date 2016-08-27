import 'package:angular2/core.dart';
import '../../models/address.model.dart';

@Pipe(name: 'address')
class AddressPipe {
	transform(Address address){
		return "${address.city}, ${address.street}";
	}
}
