import 'package:flutter_application_1/models/time.dart';
import 'package:flutter_application_1/repository/times_repository.dart';

class HomeController {
  late TimesRepository timesRepository;

  // Getter para a lista de times
  List<Time> get tabela => timesRepository.times;

  // Construtor da classe HomeController
  HomeController() {
    timesRepository = TimesRepository(); // Inicializando timesRepository
  }
}
