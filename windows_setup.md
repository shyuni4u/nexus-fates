# NEXUS FATES - Windows 개발 환경 설정 가이드

## 필수 설치 항목

### 1. Flutter SDK
```powershell
# Chocolatey로 설치 (권장)
choco install flutter

# 또는 수동 설치
# https://docs.flutter.dev/get-started/install/windows
# Flutter를 C:\flutter에 압축 해제 후 PATH 환경변수에 추가
```

### 2. 개발 도구
```powershell
# Android Studio
choco install androidstudio

# Visual Studio Code (선택사항)
choco install vscode

# Git
choco install git
```

### 3. Android SDK 라이선스 동의
```cmd
flutter doctor --android-licenses
```

## 프로젝트 설정

### 1. 의존성 패키지 설치
```cmd
cd C:\Users\shyuniz\Desktop\Developer\nexus-fates
flutter pub get
```

### 2. 환경 변수 설정
`.env` 파일을 수정하여 실제 API 키와 설정값 입력:
- Supabase URL 및 Anon Key
- Gemini API Key  
- AdMob App ID 및 Ad Unit ID들

### 3. Android 설정
- `android/app/build.gradle.kts`에 AdMob 의존성 추가
- `android/app/src/main/AndroidManifest.xml`에 AdMob App ID 추가

### 4. Supabase 프로젝트 설정
1. https://supabase.com 에서 프로젝트 생성
2. Database 스키마 설정
3. Edge Functions 배포 (Gemini API 호출용)

## 개발 명령어

### 실행
```cmd
# 디버그 모드 실행
flutter run

# 특정 기기에서 실행
flutter run -d chrome  # 웹에서 실행
flutter run -d windows # Windows 앱으로 실행
```

### 빌드
```cmd
# Android APK 빌드
flutter build apk

# Windows 앱 빌드
flutter build windows
```

### 테스트
```cmd
flutter test
```

## 다음 단계

1. **AdMob 계정 설정**: https://admob.google.com 에서 계정 생성 및 앱 등록
2. **Supabase 프로젝트 생성**: 데이터베이스 및 Edge Functions 설정
3. **Gemini API 키 발급**: Google AI Studio에서 API 키 생성
4. **테스트 실행**: `flutter run`으로 앱 실행 확인

## 문제 해결

### Flutter Doctor 이슈
```cmd
flutter doctor -v  # 상세 정보 확인
flutter doctor --android-licenses  # Android 라이선스 동의
```

### 의존성 문제
```cmd
flutter clean
flutter pub get
```

### Android 빌드 문제
```cmd
cd android
./gradlew clean
cd ..
flutter build apk
```