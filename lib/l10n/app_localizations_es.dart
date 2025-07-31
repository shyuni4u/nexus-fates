// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Nexus Destinos';

  @override
  String get homeScreenTitle => 'Lectura de Tarot';

  @override
  String get questionInputTitle => 'Haz tu Pregunta';

  @override
  String get questionInputHint => '¿Sobre qué te gustaría recibir orientación?';

  @override
  String get questionInputExample1 =>
      '¿En qué debería enfocarme en mi carrera?';

  @override
  String get questionInputExample2 => '¿Cómo puedo mejorar mis relaciones?';

  @override
  String get questionInputExample3 =>
      '¿De qué obstáculos debería estar consciente?';

  @override
  String get cardSelectionTitle => 'Saca tus Cartas';

  @override
  String get shuffleCards => 'Barajar Cartas';

  @override
  String get drawCards => 'Sacar Cartas';

  @override
  String get watchAdToViewReading => 'Ver Anuncio para Ver Lectura';

  @override
  String get viewReading => 'Ver Lectura';

  @override
  String get readingTitle => 'Tu Lectura de Cruz Celta';

  @override
  String get saveReading => 'Guardar Lectura';

  @override
  String get newReading => 'Nueva Lectura';

  @override
  String get historyTitle => 'Historial de Lecturas';

  @override
  String get noHistory => 'Aún no hay lecturas';

  @override
  String get loading => 'Cargando...';

  @override
  String get error => 'Error';

  @override
  String get retry => 'Reintentar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get ok => 'OK';

  @override
  String get signIn => 'Iniciar Sesión';

  @override
  String get signOut => 'Cerrar Sesión';

  @override
  String get email => 'Correo';

  @override
  String get password => 'Contraseña';

  @override
  String get settings => 'Configuración';

  @override
  String get language => 'Idioma';

  @override
  String get celticCrossPosition1 => 'Situación Presente';

  @override
  String get celticCrossPosition2 => 'Desafío/Cruz';

  @override
  String get celticCrossPosition3 => 'Pasado Lejano/Fundación';

  @override
  String get celticCrossPosition4 => 'Pasado Reciente';

  @override
  String get celticCrossPosition5 => 'Resultado Posible';

  @override
  String get celticCrossPosition6 => 'Futuro Inmediato';

  @override
  String get celticCrossPosition7 => 'Tu Enfoque';

  @override
  String get celticCrossPosition8 => 'Influencias Externas';

  @override
  String get celticCrossPosition9 => 'Esperanzas y Miedos';

  @override
  String get celticCrossPosition10 => 'Resultado Final';

  @override
  String get reversed => 'Invertida';

  @override
  String get adLoadingMessage => 'Cargando anuncio...';

  @override
  String get adNotReady =>
      'El anuncio no está listo, intenta de nuevo más tarde';

  @override
  String characterCount(int count, int limit) {
    return '$count / $limit caracteres';
  }

  @override
  String questionTooLong(int limit) {
    return 'La pregunta es muy larga. Manténla bajo $limit caracteres.';
  }

  @override
  String get questionRequired =>
      'Por favor ingresa una pregunta antes de continuar.';
}
