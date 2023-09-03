//
//  TempViewModel.swift
//  AstonWeatherApp
//
//  Created by Artem Tkachev on 31.08.23.
//

import Foundation
import Combine

final class TempViewModel {
    
    @Published var city: String = "Madrid"
    @Published var currentWeather = WeatherDetail.placeholder
    
    init() {
        $city
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { (city:String) -> AnyPublisher <WeatherDetail, Never> in
                WeatherAPI.shared.fetchWeather(for: city)
              }
             .assign(to: \.currentWeather , on: self)
            .store(in: &self.cancellableSet)
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
}
