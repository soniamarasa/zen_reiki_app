import 'package:just_audio/just_audio.dart';

class AudioService {
  final _musicPlayer = AudioPlayer();
  final _sfxPlayer = AudioPlayer();

  AudioService() {
    _init();
  }

  void _init() async {
    try {
      await _musicPlayer.setVolume(0.5);
      await _sfxPlayer.setVolume(1.0);
    } catch (e) {
      print("Erro no init do áudio: $e");
    }
  }

  // Novo método para carregar o áudio sem tocar
  Future<void> preloadBell(String assetPath) async {
    try {
      await _sfxPlayer.setAsset(assetPath, preload: true);
    } catch (e) {
      print("Erro no preload do sino: $e");
    }
  }

  Future<void> playBackgroundMusic(String assetPath) async {
    try {
      await _musicPlayer.setAsset(assetPath);
      await _musicPlayer.setLoopMode(LoopMode.all);
      _musicPlayer.play();
    } catch (e) {
      print("Erro na música: $e");
    }
  }

  Future<void> playBell(String assetPath) async {
    try {
      // Se por algum motivo o asset mudou, carregamos, senão ele apenas dá o play
      if (_sfxPlayer.audioSource == null) {
        await _sfxPlayer.setAsset(assetPath);
      }
      await _sfxPlayer.seek(Duration.zero);
      _sfxPlayer.play();
    } catch (e) {
      print("Erro ao tocar sino: $e");
    }
  }

  void pauseMusic() => _musicPlayer.pause();
  void resumeMusic() => _musicPlayer.play();

  void stopAll() {
    _musicPlayer.stop();
    _sfxPlayer.stop();
  }
}
