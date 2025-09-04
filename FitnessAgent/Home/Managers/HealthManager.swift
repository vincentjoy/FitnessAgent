//
//  HealthManager.swift
//  FitnessAgent
//
//  Created by Vincent Joy on 28/05/25.
//

import Foundation
import HealthKit

enum HealthKitError: Error {
    case accessDenied
}

class HealthManager {
    static let shared = HealthManager()
    
    let healthStore = HKHealthStore()
    
    private init() {}
    
    func requestHealthKitAccess() async throws {
        let calories = HKQuantityType(.activeEnergyBurned)
        let exercise = HKQuantityType(.appleExerciseTime)
        let stand = HKCategoryType(.appleStandHour)
        let steps = HKQuantityType(.stepCount)
        let workouts = HKSampleType.workoutType()
        
        let healthType: Set<HKObjectType> = [calories, exercise, stand, steps, workouts]
        try await healthStore.requestAuthorization(toShare: [], read: healthType)
    }
    
    func fetchTodayCaloriesBurned(completion: @escaping (Result<Double, Error>) -> Void) {
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, results, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let quantity = results?.sumQuantity() else {
                completion(.failure(HealthKitError.accessDenied))
                return
            }
            
            let caloriesCount = quantity.doubleValue(for: .kilocalorie())
            completion(.success(caloriesCount))
        }
        healthStore.execute(query)
    }
    
    func fetchTodayExerciseTime(completion: @escaping (Result<Double, Error>) -> Void) {
        let exercise = HKQuantityType(.appleExerciseTime)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: exercise, quantitySamplePredicate: predicate) { _, results, error in
            
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let quantity = results?.sumQuantity() else {
                completion(.failure(HealthKitError.accessDenied))
                return
            }
            
            let exerciseTime = quantity.doubleValue(for: .minute())
            completion(.success(exerciseTime))
        }
        healthStore.execute(query)
    }
    
    func fetchTodayStandHours(completion: @escaping (Result<Int, Error>) -> Void) {
        let stand = HKCategoryType(.appleStandHour)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKSampleQuery(sampleType: stand, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, results, error in
            guard let samples = results as? [HKCategorySample], error == nil else {
                completion(.failure(HealthKitError.accessDenied))
                return
            }
            
            let standCount = samples.filter { $0.value == 0 }.count
            completion(.success(standCount))
        }
        healthStore.execute(query)
    }
    
    // MARK: Fitness Activity
    
    func fetchTodaySteps(completion: @escaping (Result<Activity, Error>) -> Void) {
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, results, error in
            
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let quantity = results?.sumQuantity() else {
                completion(.failure(HealthKitError.accessDenied))
                return
            }
            
            let steps = quantity.doubleValue(for: .count())
            let activity = Activity(title: "Today's Steps", subtitle: "Goal: 800", image: "figure.walk", tintColor: .green, amount: steps.formattedNumberString() )
            completion(.success(activity))
        }
        healthStore.execute(query)
    }
    
    func fetchCurrentWeekWorkoutStats(completion: @escaping (Result<[Activity], Error>) -> Void) {
        let workouts = HKSampleType.workoutType()
        let predicate = HKQuery.predicateForSamples(withStart: .startOfWeek, end: Date())
        
        let query = HKSampleQuery(sampleType: workouts, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, results, error in
            guard let workouts = results as? [HKWorkout], error == nil else {
                completion(.failure(NSError()))
                return
            }
            
            var runningCount: Int = 0
            var strengthCount: Int = 0
            var soccerCount: Int = 0
            var basketballCount: Int = 0
            var stairsCount: Int = 0
            var kickBoxingCount: Int = 0
            
            for workout in workouts {
                let duration = Int(workout.duration)/60
                switch workout.workoutActivityType {
                case .running:
                    runningCount += duration
                case .stairClimbing:
                    stairsCount += 1
                case .soccer:
                    soccerCount += 1
                case .basketball:
                    basketballCount += 1
                case .kickboxing:
                    kickBoxingCount += duration
                case .traditionalStrengthTraining:
                    strengthCount += duration
                default:
                    print("Skip Activity")
                }
            }
            
            let activities = [
                Activity(title: "Running", subtitle: "This Week", image: "figure.run", tintColor: .green, amount: "\(runningCount) mins"),
                Activity(title: "Strength Training", subtitle: "This Week", image: "dumbbell", tintColor: .blue, amount: "\(strengthCount) mins"),
                Activity(title: "Soccer", subtitle: "This Week", image: "figure.soccer", tintColor: .indigo, amount: "\(soccerCount) mins"),
                Activity(title: "Basketball", subtitle: "This Week", image: "figure.basketball", tintColor: .green, amount: "\(basketballCount) mins"),
                Activity(title: "Stair Steps", subtitle: "This Week", image: "figure.stairs", tintColor: .red, amount: "\(stairsCount) mins"),
                Activity(title: "Kick Boxing", subtitle: "This Week", image: "figure.kickboxing", tintColor: .yellow, amount: "\(kickBoxingCount) mins")
            ]
            
            completion(.success(activities))
        }
        
        healthStore.execute(query)
    }
}

extension Date {
    static var startOfDay: Date {
        let calendar = Calendar.current
        return calendar.startOfDay(for: Date())
    }
    
    static var startOfWeek: Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        components.weekday = 2
        return calendar.date(from: components) ?? Date()
    }
}

extension Double {
    func formattedNumberString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: self)) ?? "0"
    }
}
