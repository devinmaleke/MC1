//
//  MePage.swift
//  MC1
//
//  Created by Daniel Widjaja on 20/04/23.
//

import SwiftUI

struct MePage: View {
    @EnvironmentObject var userVM: UserViewModel
    @StateObject var calendarVM = CalendarViewModel()
    
    @State var pushNotification: Bool = true
    @State var vibrationMode: Bool = true
    
    @State var currentDate = Date.now
    
    @State private var showDateModal = false
    @State private var buttonOpacity = 1.0
    
//    let days = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
    var currentWeek = [Date]()
    let formatter = DateFormatter()
    
    init() {
        currentWeek = calendarVM.getDatesOfCurrentWeek()
        formatter.dateFormat = "EEE"
    }
    
    var body: some View {
        NavigationView {
            VStack (spacing: 20){
                Text("Streak")
                    .font(.system(size: 22))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .foregroundColor(Color(red: 30 / 255, green: 30 / 255, blue: 30 / 255, opacity: 100))
                
                HStack (spacing: 14){
                    ForEach(currentWeek, id: \.self) { day in
                        VStack{
                            Text(formatter.string(from: day))
                                .foregroundColor(.white)
                                .font(.system(size: 12))
                            
                            ZStack{
                                Circle()
                                    .frame(maxWidth: 30)
                                    .foregroundColor(.white)
                                
                                if userVM.getExerciseDaysWithoutTimeStamp().contains(userVM.removeTimeStamp(fromDate: day)){
                                    Image("star")
                                        .resizable()
                                        .frame(maxWidth: 25, maxHeight: 25)
                                }
                            }
                            
                        }
                    }
                    
                }
                .frame(maxWidth: 360, maxHeight: 90)
                .background(Color(red: 17 / 255, green: 118 / 255, blue: 106 / 255, opacity: 100.0))
                .cornerRadius(10)
                
                HStack (spacing: 12){
                    VStack{
                        
                        Text("🔥 \(userVM.getCurrentStreak())")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        
                        Text("Current Streak")
                            .font(.system(size: 16))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                    }
                    .frame(maxWidth: 174, maxHeight: 66)
                    .background(Color(red: 17 / 255, green: 118 / 255, blue: 106 / 255, opacity: 0.17))
                    .cornerRadius(10)
                    
                    VStack{
                        Text("🏆 \(userVM.getHighestStreak())")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        
                        Text("Highest Streak")
                            .font(.system(size: 16))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                    }
                    .frame(maxWidth: 174, maxHeight: 66)
                    .background(Color(red: 17 / 255, green: 118 / 255, blue: 106 / 255, opacity: 0.17))
                    .cornerRadius(10)
                    
                }
                .frame(maxWidth: 360)
                
                Text("Settings")
                    .font(.system(size: 22))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .foregroundColor(Color(red: 85 / 255, green: 85 / 255, blue: 85 / 255, opacity: 100))
                    .padding(.top, 30)
                
                List {
                    Toggle(isOn: $pushNotification) {
                        Text("Push Notification")
                            .font(.system(size: 15))
                            .foregroundColor(Color(red: 85 / 255, green: 85 / 255, blue: 85 / 255, opacity: 100))
                        
                    }
                    
                    //                    HStack{
                    //                        Text("Wake Up Time")
                    //                            .font(.system(size: 15))
                    //                            .foregroundColor(Color(red: 85 / 255, green: 85 / 255, blue: 85 / 255, opacity: 100))
                    //
                    //                        Spacer()
                    //
                    //                        Button("\(Date.now, style: .time)") {
                    //                            showDateModal = true
                    //                            buttonOpacity = 0.0
                    //                        }
                    //                        .buttonStyle(.bordered)
                    //                        .foregroundColor(Color.black)
                    //                        .font(.system(size: 15))
                    //                        .background(Color(red: 239 / 255, green: 239 / 255, blue: 240 / 255, opacity: 100))
                    //                        .cornerRadius(8)
                    //                        .opacity(buttonOpacity)
                    //
                    //                        if showDateModal {
                    //                            DatePicker("Select a Date", selection: $currentDate, in: ...Date.now, displayedComponents: .hourAndMinute)
                    //                                .datePickerStyle(.wheel)
                    //                                .labelsHidden()
                    //                        }
                    //                    }
                    
                    HStack{
                        Text("Wake Up Time")
                            .font(.system(size: 15))
                            .foregroundColor(Color(red: 85 / 255, green: 85 / 255, blue: 85 / 255, opacity: 100))
                        
                        Spacer()
                        
                        DatePicker("Wake Up Time", selection: $currentDate, in: ...Date.now, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .accentColor(Color(red: 17 / 255, green: 118 / 255, blue: 108 / 255, opacity: 100))
                        
                    }
                    
                    Toggle(isOn: $vibrationMode) {
                        Text("Vibration Mode")
                            .font(.system(size: 15))
                            .foregroundColor(Color(red: 85 / 255, green: 85 / 255, blue: 85 / 255, opacity: 100))
                    }
                    
                    
                }
                .listStyle(PlainListStyle())
                .cornerRadius(10)
                
            }
            .padding(.top, 10)
            .navigationTitle("Me")
        }
    }
    
}

struct MePage_Previews: PreviewProvider {
    static var previews: some View {
        MePage()
    }
}
