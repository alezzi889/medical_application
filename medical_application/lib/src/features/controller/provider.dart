import 'package:flutter/foundation.dart';
import 'package:medical_application/src/src.dart';

class MedicalProvider with ChangeNotifier {
  late Doctor currentDoctor;
  late User currentUser;

  List<Doctor> _doctors = [];
  List<User> _users = [];
  List<Task> _tasks = [];
  List<Task> _orders = [];
  List<Advice> _advices = [];

  List<Doctor> get doctors => _doctors;
  List<User> get users => _users;
  List<Task> get tasks => _tasks;
  List<Task> get orders => _orders;
  List<Advice> get advices => _advices;
  int currentIndex = 0;

  List patientScreens = const [
    UserHomeLayout(),
    UserAdviceLayout(),
    UserOrderLayout(),
  ];

  void changeIndex(int index) {
    currentIndex = index;

    getData();
    notifyListeners();
  }

  void getData() async {
    await fetchUsers();
    await fetchDoctors();
    await fetchAdvices();
    await fetchTasks();
    await fetchOrders();


    notifyListeners();
  }

  Future<void> addAdvice(Advice advice) async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.addAdvice(advice);

    getData();
  }

  Future<void> fetchAdvices() async {
    final dbHelper = DatabaseHelper.instance;
    _advices = await dbHelper.getAdvices();

    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.addTask(task);

    getData();
  }

  Future<void> fetchTasks() async {
    final dbHelper = DatabaseHelper.instance;
    _tasks = await dbHelper.getTasks();

  }

  Future<void> updateTask(Task task) async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.updateTask(task);

    getData();
  }

  Future<void> deleteTask(Task task) async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.deleteTask(task);

    getData();
  }

  Future<void> fetchOrders() async {
    final dbHelper = DatabaseHelper.instance;
    _orders = await dbHelper.getOrders();

    notifyListeners();
  }

  Future<void> register(user, {isDoctor = false}) async {
    final dbHelper = DatabaseHelper.instance;
    if (isDoctor) {
      currentDoctor = (await dbHelper.addDoctor(user))!;
    } else {
      currentUser = (await dbHelper.addUser(user))!;
    }

    notifyListeners();
  }

  Future<bool> login(String email, String password,
      {bool isDoctor = false}
      ) async {
    if (isDoctor) {
      Doctor? data = await DatabaseHelper.instance.loginDoctor(email, password);
      if (data != null) {
        currentDoctor = data;
        notifyListeners();
        return true;
      }
      return false;
    } else {
      User? data = await DatabaseHelper.instance.loginUser(email, password);
      if (data != null) {
        currentUser = data;
        notifyListeners();
        return true;
      }
      return false;
    }
  }

  Future<void> fetchDoctors() async {
    final dbHelper = DatabaseHelper.instance;
    _doctors = await dbHelper.getDoctors();

    notifyListeners();
  }

  Future<void> fetchUsers() async {
    final dbHelper = DatabaseHelper.instance;
    _users = await dbHelper.getUsers();

    notifyListeners();
  }

  Future<void> editDoctorProfile(Doctor doctor) async {
    final dbHelper = DatabaseHelper.instance;
    Doctor newDoctor = await dbHelper
        .updateDoctor(doctor); // تأكد من وجود هذه الدالة في DatabaseHelper
    currentDoctor = newDoctor;

    notifyListeners();
  }

  Future<void> editUserProfile(User user) async {
    final dbHelper = DatabaseHelper.instance;
    currentUser = await dbHelper.updateUser(user);

    notifyListeners();
  }
}
