//
//  ViewController.swift
//  WetherApp
//
//  Created by Md Hosne Mobarok on 22/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var tempLable: UILabel!
    @IBOutlet weak var wetherDescriptionLable: UILabel!
    @IBOutlet weak var wetherImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=3d2689343c7a0fd86328d7fc33b80198&units=metric&q=Kolkata") else { return }
                
                let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                    if let data = data, error == nil{
                        do{
                            guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                            guard let weatherDetails = json["weather"] as? [[String: Any]], let weatherMain = json["main"] as? [String: Any] else { return }
                            let temp = Int(weatherMain["temp"] as? Double ?? 0)
                            let description = (weatherDetails.first?["description"] as? String)?.capitalized
                            DispatchQueue.main.async {
                                self.setWeather(weather: weatherDetails.first?["main"] as? String, descripthion: description, temp: temp)
                                
                            }
                        } catch {
                            print("We had an error retriving the weather...")
                        }
                    }
                }
        task.resume()
    }
    
    
    func setWeather(weather: String?, descripthion: String?, temp: Int) {
        wetherDescriptionLable.text = description
        tempLable.text = "\(temp)°"
        switch weather {
        case "wetherImage1":
            wetherImageView.image = UIImage(named: "wetherImag2")
            backgroundView.backgroundColor = UIColor(red: 0.97, green: 0.78, blue: 0.35, alpha: 1.0)
            
        default:
            wetherImageView.image = UIImage(named: "wetherImage1")
            backgroundView.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha: 1.0)
            
        }
    }
    
}

