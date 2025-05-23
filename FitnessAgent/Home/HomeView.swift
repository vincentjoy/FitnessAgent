//
//  HomeView.swift
//  FitnessAgent
//
//  Created by Vincent Joy on 21/05/25.
//

import SwiftUI

struct HomeView: View {
    
    @State var calories: Int = 100
    @State var active: Int = 52
    @State var stand: Int = 8
    
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
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("Welcome")
                        .font(.largeTitle)
                        .padding()
                    
                    HStack {
                        
                        Spacer()
                        
                        VStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Calories")
                                    .font(.callout)
                                    .bold()
                                    .foregroundStyle(Color.red)
                                Text("123 kcal")
                                    .bold()
                            }
                            .padding(.bottom)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Active")
                                    .font(.callout)
                                    .bold()
                                    .foregroundStyle(Color.green)
                                Text("52 mins")
                                    .bold()
                            }
                            .padding(.bottom)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Stand")
                                    .font(.callout)
                                    .bold()
                                    .foregroundStyle(Color.blue)
                                Text("8 hours")
                                    .bold()
                            }
                        }
                        
                        Spacer()
                        
                        ZStack {
                            ProgressCircleView(progress: $calories, goal: 200, color: .red)
                            ProgressCircleView(progress: $active, goal: 60, color: .green)
                                .padding(.all, 20)
                            ProgressCircleView(progress: $stand, goal: 12, color: .blue)
                                .padding(.all, 40)
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    .padding()
                    
                    HStack {
                        Text("Fitness Activity")
                            .font(.title2)
                        
                        Spacer()
                        
                        Button {
                            print("Show more")
                        } label: {
                            Text("Show more")
                                .padding(.all, 10)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(20)
                                .shadow(color: .gray, radius: 3)
                        }
                    }
                    .padding(.horizontal)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                        ForEach(mockActivities, id: \.id) { activity in
                            ActivityCard(activity: activity)
                        }
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Recent Workouts")
                            .font(.title2)
                        
                        Spacer()
                        
                        NavigationLink {
                            EmptyView()
                        } label: {
                            Text("Show more")
                                .padding(.all, 10)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(20)
                                .shadow(color: .gray, radius: 3)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    LazyVStack {
                        ForEach(mockWorkouts, id: \.id) { workout in
                            WorkoutCard(workout: workout)
                        }
                    }
                    .padding(.bottom)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
