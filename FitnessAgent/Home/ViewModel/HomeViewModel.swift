//
//  HomeViewModel.swift
//  FitnessAgent
//
//  Created by Vincent Joy on 23/05/25.
//

import Foundation

@Observable class HomeViewModel {
    
    let healthManager = HealthManager.shared
    
    var calories: Int = 100
    var active: Int = 52
    var stand: Int = 8
    
    var mockActivities: [Activity] = [
        Activity(id: 0, title: "Today's Steps", subtitle: "Goal 10,000", image: "figure.walk", tintColor: .green, amount: "9,812"),
        Activity(id: 1, title: "Today's Steps", subtitle: "Goal 10,000", image: "figure.walk", tintColor: .red, amount: "6,131"),
        Activity(id: 2, title: "Today's Steps", subtitle: "Goal 10,000", image: "figure.walk", tintColor: .blue, amount: "4,324"),
        Activity(id: 3, title: "Today's Steps", subtitle: "Goal 10,000", image: "figure.run", tintColor: .purple, amount: "7,893")
    ]
    
    var mockWorkouts: [Workout] = [
        Workout(id: 0, title: "Running", image: "figure.run", tintColor: .cyan, duration: "51 Mins", date: "May 23", calories: "539 kcal "),
        Workout(id: 1, title: "Strength Training", image: "figure.run", tintColor: .red, duration: "51 Mins", date: "June 13", calories: "474 kcal "),
        Workout(id: 2, title: "Walking", image: "figure.walk", tintColor: .purple, duration: "51 Mins", date: "Aug 5", calories: "319 kcal "),
        Workout(id: 3, title: "Running", image: "figure.run", tintColor: .cyan, duration: "51 Mins", date: "Sep 7", calories: "512 kcal ")
    ]
    
    init() {
        
        Task {
            do {
                try await healthManager.requestHealthKitAccess()
                
                healthManager.fetchTodayCaloriesBurned { result in
                    switch result {
                    case .success(let success):
                        print(success)
                    case .failure(let failure):
                        print(failure.localizedDescription)
                    }
                }
                
                healthManager.fetchTodayStandHours { result in
                    switch result {
                    case .success(let success):
                        print(success)
                    case .failure(let failure):
                        print(failure.localizedDescription)
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}
