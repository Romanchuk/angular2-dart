import 'package:angular2/core.dart';
import 'package:angular2/platform/browser.dart';
import 'package:http/browser_client.dart';
import 'app_component.dart';

void main() {
  bootstrap(AppComponent, const [
    // in-memory web api provider
    const Provider(BrowserClient, deps: const [])
    // TODO: drop `deps` once fix lands for
    // https://github.com/angular/angular/issues/5266
  ]);
}
