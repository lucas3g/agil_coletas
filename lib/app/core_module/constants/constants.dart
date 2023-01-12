// ignore_for_file: public_member_api_docs, sort_constructors_first

const baseUrl = String.fromEnvironment('BASE_URL');
const baseUrlLicense = String.fromEnvironment('BASE_URL_LICENSE');

// class GlobalUser {
//   GlobalUser._();

//   static GlobalUser instance = GlobalUser._();

//   User get user {
//     final shared = Modular.get<ILocalStorage>();

//     final result = shared.getData('user');

//     if (result != null) {
//       final user = UserAdapter.fromMap(jsonDecode(result));
//       return user;
//     }

//     return User(id: const IdVO('1'), name: '', email: '', photoURL: '');
//   }
// }
