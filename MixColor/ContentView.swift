//
//  ContentView.swift
//  MixColor
//
//  Created by nikita on 29.10.2023.
//

// ContentView.swift

import SwiftUI


struct ContentView: View {
    @State var color1: String = "Red"
    @State var color2: String = "Red"
    @State var resultColor: String = "Red"
    @State var color3: String = "Red"
    @State var color4: String = "Red"
    @State var numberOfColor = 0
    @State private var isColorPickerVisible1 = false
    @State private var isColorPickerVisible2 = false
    @State private var isColorPickerVisible3 = false
    @State private var isColorPickerVisible4 = false
    @State private var isColorPickerVisible5 = false
    

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {

                Text("Choose how many colors you want to mix")

                Picker("", selection: $numberOfColor) {
                    Text("2").tag(0)
                    Text("3").tag(1)
                    Text("4").tag(2)
                }.pickerStyle(.segmented)

                VStack {

                    ColorMix(selectedColor: color1, nameColor: color1).onTapGesture {
                        
                        isColorPickerVisible1.toggle()
                    }
                    showColorPicker(selection: $color1, isVisible: $isColorPickerVisible1)
                    Image(systemName: "plus")
                    ColorMix(selectedColor: color2, nameColor: color2).onTapGesture {
                        isColorPickerVisible2.toggle()
                    }
                    showColorPicker(selection: $color2, isVisible: $isColorPickerVisible2)
                    if numberOfColor == 1 {
                        VStack {
                            Image(systemName: "plus")
                            ColorMix(selectedColor: color3, nameColor: color3).onTapGesture {
                                isColorPickerVisible4.toggle()
                            }
                            showColorPicker(selection: $color3, isVisible: $isColorPickerVisible4)
                        }
                    }
                    if numberOfColor == 2 {
                        VStack {
                            Image(systemName: "plus")
                            ColorMix(selectedColor: color4, nameColor: color4).onTapGesture {
                                isColorPickerVisible5.toggle()
                            }
                            showColorPicker(selection: $color4, isVisible: $isColorPickerVisible5)
                        }
                    }
                    Image(systemName: "equal")
                    ColorMix(selectedColor: resultColor, nameColor: resultColor)
                    ButtonMix(color1: $color1, color2: $color2, resultColor: $resultColor, color3: $color3, color4: $color4, numberOfColor: $numberOfColor)
                }
            }
        }
    }

    func showColorPicker(selection: Binding<String>, isVisible: Binding<Bool>) -> some View {
        withAnimation{
            Picker("Color", selection: selection) {
                Text("Red").tag("Red")
                Text("Green").tag("Green")
                Text("Blue").tag("Blue")
                Text("Lime").tag("Lime")
            }.pickerStyle(.menu)
                .onChange(of: selection.wrappedValue) { _ in
                    isVisible.wrappedValue = false
                    
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.locale, Locale(identifier: "ru"))
    }
}

struct ColorMix: View {
    let selectedColor: String
    let nameColor: String
    var color: String {
           return self.nameColor
       }
    var body: some View {
        withAnimation(.spring()) {
            VStack {
                
                Text(LocalizedStringKey(nameColor))
                Circle()
                    .foregroundColor(getColorForIndex(selectedColor))
                    .frame(width: 100, height: 100)
                    .padding(20)
            }
        }
      
    }

    func getColorForIndex(_ index: String) -> Color {
        switch index {
            case "Red": return .red
            case "Green": return .green
            case "Purple": return .purple
            case "Brown": return .brown
            case "Lime": return Color.appColor(.lime)!
            case "Purp1": return Color.appColor(.purp1)!
            case "White": return .white
            case "Orange": return .orange
            case "Black": return .black
            case "Blue": return .blue
            case "Gray": return .gray
            case "Pink": return Color.pink
            case "Yellow": return Color.yellow
            case "Light Blue": return Color.blue.opacity(0.5)
            case "Indigo": return Color.indigo
            default: return .gray
        }
    }
}

struct ButtonMix: View {
    @Binding var color1: String
    @Binding var color2: String
    @Binding var resultColor: String
    @Binding var color3: String
    @Binding var color4: String
    @Binding var numberOfColor: Int
    var body: some View {
        Button {
            if numberOfColor == 0{
                resultColor =
                mixColorTwoColor(color1: color1, color2: color2)
            } else if  numberOfColor == 1{
                resultColor =
                mixColorThreeColor(color1: color1, color2: color2, color3: color3)
            }else if  numberOfColor == 2{
                resultColor =
                mixColorFourColor(color1: color1, color2: color2, color3: color3, color4: color4)
            }
            
        } label: {
            Text("Mix")
        }
        .frame(maxWidth: .infinity)
        .frame(height: 45)
        .foregroundColor(.white)
        .background(Color.blue)
        .border(Color.black, width: 1)
        .cornerRadius(10)
        .padding()
    }

    func mixColorTwoColor(color1: String, color2: String ) -> String {
        let colorCombination: [Set<String>: String] = [
            Set(["Green", "Red"]): "Brown",
            Set(["Blue", "Red"]): "Purple",
            Set(["Blue", "White"]): "Ash-blue",
            Set(["Yellow", "Red"]): "Orange",
            Set(["Purple", "Brown"]): "Pink",
            Set(["Blue", "Gray"]): "Indigo",
            Set(["Blue", "Blue"]): "Blue",
            Set(["Red", "Red"]): "Red",
            Set(["Green", "Green"]): "Red",
            Set(["White", "Red"]): "Pink"
        ]

        let colorSet = Set([color1, color2])

        if let result = colorCombination[colorSet] {
            return result
        } else {
            return "Unknown"
        }
    }
    func mixColorFourColor(color1: String, color2: String, color3: String, color4: String) -> String {
        let colorCombination: [Set<String>: String] = [
            Set(["Red", "Lime", "Blue", "Orange"]): "Gray",
            Set(["Red", "Yellow", "Yellow", "Yellow"]): "Orange"
        ]

        let colorSet = Set([color1, color2, color3, color4])

        if let result = colorCombination[colorSet] {
            return result
        } else {
            return "Unknown"
        }
    }
    func mixColorThreeColor(color1: String, color2: String, color3: String) -> String {
        let colorCombination: [Set<String>: String] = [
            Set(["Red", "Lime", "Blue"]): "Gray",
            Set(["Red", "Blue", "Blue"]): "Purple"
        ]

        let colorSet = Set([color1, color2, color3])

        if let result = colorCombination[colorSet] {
            return result
        } else {
            return "Unknown"
        }
    }

}

enum AssetsColor {


    case lime
    case purp1
    case purp
}

extension Color {
    static func appColor(_ name: AssetsColor) -> Color? {
        switch name {
        case .lime:
            return Color("Lime")
        case .purp1:
            return Color("Purp1")
        case .purp:
            return Color("Purp")
        }
    }
}
