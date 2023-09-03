//
//  ViewController.swift
//  AstonWeatherApp
//
//  Created by Artem Tkachev on 31.08.23.
//

import UIKit
import Combine

class ViewController: UIViewController{
    
    @IBOutlet weak var cityTextField: UITextField!{
        didSet {
            cityTextField.isEnabled = true
            cityTextField.becomeFirstResponder()
        }
    }
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    private let viewModel = TempViewModel()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTextField.text = viewModel.city
        binding()
    }
    
    func binding() {
        cityTextField.textPublisher
           .assign(to: \.city, on: viewModel)
           .store(in: &cancellable)
       
        viewModel.$currentWeather
           .sink(receiveValue: {[weak self] currentWeather in
            
            self?.temperatureLabel.text =
                currentWeather.main?.temp != nil ?
                "\(Int((currentWeather.main?.temp!)!)) ºC"
                : " "
            self?.maxTemperatureLabel.text =
                currentWeather.main?.tempMax != nil ?
                "\(Int((currentWeather.main?.tempMax!)!)) ºC"
                : " "
            self?.minTemperatureLabel.text =
                currentWeather.main?.tempMin != nil ?
                "\(Int((currentWeather.main?.tempMin!)!)) ºC"
                : " "
            self?.humidityLabel.text =
                currentWeather.main?.humidity != nil ?
                "\((currentWeather.main?.humidity!)!) %"
                : " "
            self?.pressureLabel.text =
                currentWeather.main?.pressure != nil ?
                "\((currentWeather.main?.pressure!)!)"
                : " "
           }
        )
           .store(in: &cancellable)
    }

     private var cancellable = Set<AnyCancellable>()
}

extension Date {
    var dayOfTheWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    var hourAndDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE hh a"
        return dateFormatter.string(from: self)
    }
    
    var hourOfTheDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        return dateFormatter.string(from: self)
    }
    
    var timeOfTheDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
}

extension DateFormatter {
    static var shared: DateFormatter = {
        return DateFormatter()
    }()
}


