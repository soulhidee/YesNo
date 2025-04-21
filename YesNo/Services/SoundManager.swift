import Foundation
import AVFoundation

final class SoundManager {
    private var audioPlayers: [String: AVAudioPlayer] = [:]
    func prepareSounds(named names: [String]) {
            for name in names {
                guard let url = Bundle.main.url(forResource: name, withExtension: "wav") else {
                    print("Файл \(name).wav не найден")
                    continue
                }
                do {
                    let player = try AVAudioPlayer(contentsOf: url)
                    player.prepareToPlay()
                    audioPlayers[name] = player
                } catch {
                    print("Ошибка подготовки звука \(name): \(error)")
                }
            }
        }
    func playSound(named name: String) {
           guard let player = audioPlayers[name] else {
               print("Звук \(name) не найден или не подготовлен")
               return
           }
           player.currentTime = 0
           player.play()
       }
}
