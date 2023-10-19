import UIKit
//Ses için eklenen kütüphane
import AVFoundation

class ViewController: UIViewController {
    //UI nesne tanımlaycıları
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeBar: UIProgressView!
    //Değişken ve Tanımlar
    var player: AVAudioPlayer?
    let eggTimes = ["Soft": 5 * 60, "Medium": 7 * 60 , "Hard": 12 * 60]
    var timer = Timer()
    var totalTime = 0
    var secondPassed = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        //Seçilen butondaki değeri dict içinden alma
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        //Başka butona basıldığında sıfırlama
        timeBar.progress = 0.0
        secondPassed = 0
        titleLabel.text = hardness
        //Zamanlayıcı ve ayarları
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
    }
    //Objective-C den kalan komut çağırma -> @objc
    @objc func updateTimer(){
            //Zamanlayıcıyı 0'dan arttırma
            secondPassed += 1
            if secondPassed < totalTime {
                titleLabel.text = "Wait for \(String(totalTime-secondPassed)) seconds"
                timeBar.progress = Float(secondPassed)/Float(totalTime)
            } else{
                //Zamanlayıcı bittiğinde sıfırlama ve ekrana yazdırma
                timer.invalidate()
                titleLabel.text = "READY!"
                timeBar.progress = 1.0
                //Ses kütüphanesini kullanarak dosyayı çağırma ve ses dosyasını çalma
                let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                player = try! AVAudioPlayer(contentsOf: url!)
                player?.play()
            }
    }

}
