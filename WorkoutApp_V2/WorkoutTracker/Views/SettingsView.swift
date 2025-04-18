import SwiftUI

struct SettingsView: View {
    @State private var weightUnit: String = "kg"
    @State private var notificationsEnabled: Bool = false
    @State private var reminderTime: Date = Date()
    @State private var darkModeOn: Bool = false
    
    @ObservedObject private var settingsManager = SettingsManager.shared

    let weightUnits = ["kg", "lbs"]
    
    var body: some View {
        NavigationView {
            Form {
                
                    
                
                List {
                    Section(header: Text("Preferences")) {
                        Picker("Weight Unit", selection: $weightUnit) {
                            ForEach(weightUnits, id: \.self) {
                                Text($0)
                            }
                        }
                        .onChange(of: weightUnit) {
                            settingsManager.weightUnit = weightUnit
                        }
                        
                        Toggle("Dark Mode", isOn: $darkModeOn)
                            .onChange(of: darkModeOn) {
                                settingsManager.darkModeEnabled = darkModeOn                            
                            }
                    }
                    
                    Section(header: Text("Reminders")) {
                        Toggle("Enable Notifications", isOn: $notificationsEnabled)
                            .onChange(of: notificationsEnabled) { newValue in
                                settingsManager.notificationsEnabled = newValue
                            }
                        
                        if notificationsEnabled {
                            DatePicker("Reminder Time", selection: $reminderTime, displayedComponents: .hourAndMinute)
                                .onChange(of: reminderTime) {
                                    settingsManager.reminderTime = reminderTime
                                }
                        }
                    }
                    
                    Section(header: Text("About")) {
                        HStack {
                            Text("Version")
                            Spacer()
                            Text("1.0.0")
                                .foregroundColor(.secondary)
                        }
                        
                        NavigationLink(destination: PrivacyPolicyView()) {
                            Text("Privacy Policy")
                        }
                        
                        Button("Rate the App") {
                            // Link to App Store review
                        }
                    }
                
                }
            }
            .navigationTitle("Settings")
            .onAppear {
                    weightUnit = settingsManager.weightUnit
                    notificationsEnabled = settingsManager.notificationsEnabled
                    reminderTime = settingsManager.reminderTime
                    darkModeOn = settingsManager.darkModeEnabled
                }
        }
    }
}

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Privacy Policy")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 10)
                
                Text("This app does not collect any personal data. All workout information is stored locally on your device and is not transmitted to any external servers.")
                
                Text("Workout data is only used within the app to display your progress and workout history.")
                
                Text("The app does not use any analytics services, advertising frameworks, or other tracking mechanisms.")
                
                Text("If you have any questions about our privacy practices, please contact us.")
            }
            .padding()
        }
        .navigationTitle("Privacy Policy")
    }
} 