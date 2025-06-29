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
        
        let healthType: Set<HKObjectType> = [calories, exercise, stand]
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
}

extension Date {
    static var startOfDay: Date {
        let calendar = Calendar.current
        return calendar.startOfDay(for: Date())
    }
}
