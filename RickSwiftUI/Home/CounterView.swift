//
//  Counter.swift
//  RickSwiftUI
//
//  Created by Nicholas Kaffine on 6/15/21.
//

import SwiftUI

struct Counter: View {
    let date: Date

    private struct Difference {
        let seconds: Int
        let minutes: Int
        let hours: Int
        let days: Int
        let months: Int
        let years: Int
    }

    @State private var diff: Difference = Difference(seconds: 0, minutes: 0, hours: 0, days: 0, months: 0, years: 0)

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(date: Date) {
        self.date = date
        diff = Counter.computeDifference(date: date)
    }

    private static func computeDifference(date: Date) -> Difference {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: Date())
        return Difference(seconds: abs(components.second!),
                          minutes: abs(components.minute!),
                          hours: abs(components.hour!),
                          days: abs(components.day!),
                          months: abs(components.month!),
                          years: abs(components.year!))
    }
    
    var body: some View {
        HStack {
            unitLabel(unit: .year, value: diff.years)
            unitLabel(unit: .month, value: diff.months)
            unitLabel(unit: .day, value: diff.days)
            unitLabel(unit: .hour, value: diff.hours)
            unitLabel(unit: .minute, value: diff.minutes)
            unitLabel(unit: .second, value: diff.seconds)
        }
        .onAppear(perform: {
            self.diff = Counter.computeDifference(date: date)
        })
        .onReceive(timer, perform: { _ in
            self.diff = Counter.computeDifference(date: date)
        })
    }
    
    private enum Unit {
        case second
        case minute
        case hour
        case day
        case month
        case year
        
        var labelValue: String {
            switch self {
                case .second:
                    return "S"
                case .minute:
                    return "M"
                case .hour:
                    return "H"
                case .day:
                    return "D"
                case .month:
                    return "M"
                case .year:
                    return "Y"
            }
        }
    }
    
    private struct Constants {
        static let unitLablePadding: CGFloat = 3
    }
    
    @ViewBuilder
    private func unitLabel(unit: Unit, value: Int) -> some View {
        HStack(spacing: Constants.unitLablePadding) {
            Text(String(value))
            Text(unit.labelValue)
        }
        .padding(0)
    }
}






























struct Counter_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CounterViewModel()
        Counter(date: viewModel.dates.first!.date)
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 12 Pro")
    }
}
