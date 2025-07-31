import 'package:logger/logger.dart';

/// 전역적으로 사용하는 로거 인스턴스
/// SimplePrinter를 사용하여 깔끔한 로그 출력
final Logger logger = Logger(printer: SimplePrinter());
