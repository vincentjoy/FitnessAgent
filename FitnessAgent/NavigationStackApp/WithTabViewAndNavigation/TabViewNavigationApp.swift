//
//  TabViewNavigationApp.swift
//  FitnessAgent
//
//  Created by Vincent Joy on 27/05/25.
//

import SwiftUI
import Observation

struct DoctorScreen: View {
    
    @Environment(Router.self) private var router
    
    var body: some View {
        VStack {
            Text("Doctor Screen")
            Button("Go to list") {
                router.push(.doctor(.list))
            }
        }
    }
}

struct DoctorListScreen: View {
    
    @Environment(Router.self) private var router
    
    var body: some View {
        VStack {
            Text("Doctor List Screen")
            Button("Go to Create") {
                router.push(.doctor(.create))
            }
        }
    }
}

struct PatientScreen: View {
    var body: some View {
        Text("Patient Screen")
    }
}

struct Doctor: Hashable {
    let name: String
}

enum DoctorRoutes: Hashable {
    case list
    case create
    case detail(Doctor)
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .list:
            DoctorListScreen()
        case .create:
            Text("Create")
        case .detail(let doctor):
            Text("Detail \(doctor.name)")
        }
    }
}

enum PatientRoutes: Hashable {
    case list
    case create
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .list:
            Text("List")
        case .create:
            Text("Create")
        }
    }
}

enum AppTab: Hashable {
    case doctors
    case patients
}

enum Route: Hashable {
    case doctor(DoctorRoutes)
    case patient(PatientRoutes)
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .doctor(let doctorRoutes):
            doctorRoutes.destination
        case .patient(let patientRoutes):
            patientRoutes.destination
        }
    }
    
    var tab: AppTab {
        switch self {
        case .doctor:
            return .doctors
        case .patient:
            return .patients
        }
    }
}

@Observable
class Router {
    var routes: [AppTab: [Route]] = [:]
    
    func push(_ route: Route) {
        let tab = route.tab
        routes[tab, default: []].append(route)
    }
    
    subscript(tab: AppTab) -> [Route] {
        get { routes[tab] ?? [] }
        set { routes[tab] = newValue }
    }
}

struct TabViewNavigationApp: View {
    
    @Environment(Router.self) private var router
    
    var body: some View {
        
        @Bindable var router = router
        
        TabView {
            NavigationStack(path: $router[.doctors]) {
                DoctorScreen()
                    .navigationDestination(for: Route.self) { route in
                        route.destination
                    }
            }.tabItem {
                Label("Doctors", systemImage: "plus")
            }
            
            NavigationStack(path: $router[.patients]) {
                PatientScreen()
                    .navigationDestination(for: Route.self) { route in
                        route.destination
                    }
            }.tabItem {
                Label("Patient", systemImage: "heart")
            }
        }
    }
}

#Preview {
    TabViewNavigationApp()
        .environment(Router())
}
