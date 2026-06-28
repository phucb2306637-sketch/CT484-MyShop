import 'package:pocketbase/pocketbase.dart';
import '../models/user.dart';
import 'pocketbase_client.dart';

class AuthService {
  Function(User?)? onAuthChange;

  AuthService({this.onAuthChange}) {
    _initAuthListener();
  }

  void _initAuthListener() async {
    final pb = await getPocketbaseInstance();
    pb.authStore.onChange.listen((event) async {
      onAuthChange?.call(await getUserFromStore());
    });
  }

  Future<User?> getUserFromStore() async {
    final pb = await getPocketbaseInstance();
    if (!pb.authStore.isValid || pb.authStore.model == null) {
      return null;
    }
    final model = pb.authStore.model as RecordModel;
    return User(
      id: model.id,
      email: model.getStringValue('email'),
      username: model.getStringValue('username'),
      name: model.getStringValue('name'),
      avatar: model.getStringValue('avatar'),
    );
  }

  Future<User> signup(String email, String password) async {
    final pb = await getPocketbaseInstance();
    await pb.collection('users').create(body: {
      'email': email,
      'password': password,
      'passwordConfirm': password,
    });
    return login(email, password);
  }

  Future<User> login(String email, String password) async {
    final pb = await getPocketbaseInstance();
    final authData = await pb.collection('users').authWithPassword(email, password);
    return User(
      id: authData.record.id,
      email: authData.record.getStringValue('email'),
      username: authData.record.getStringValue('username'),
      name: authData.record.getStringValue('name'),
      avatar: authData.record.getStringValue('avatar'),
    );
  }

  Future<void> logout() async {
    final pb = await getPocketbaseInstance();
    pb.authStore.clear();
  }
}