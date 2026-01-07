//
//  AlgMenuView.swift
//  cubie
//
//  Created by chris on '25.12.28.
//

import SwiftUI

struct AlgMenuView: View {
    @State var header: String = Storage.main.currentAlgSet?.header ?? ""
    @State var options: [any MenuOptionView] = Storage.main.currentAlgSet?.subOptions ?? []
    @State var storage: Storage = Storage.main
    @State var editing: Bool = false
    @State var popupType: PopupType = .none
    @State var selectedItem: Int? = nil
    
    var body: some View {
        ZStack {
            Color.black
            VStack {
                Text(header)
                    .onTapGesture {
                        if editing {
                            editing = false
                            return
                        }
                        header = Storage.main.currentAlgSet?.header ?? ""
                        options = Storage.main.currentAlgSet?.subOptions ?? []
                    }
                Spacer()
                Grid(horizontalSpacing: 100, verticalSpacing: 100) {
                    GridRow {
                        ForEach(0..<4) { i in
                            getGridItem(i)
                        }
                    }
                    GridRow {
                        ForEach(4..<8) { i in
                            getGridItem(i)
                        }
                    }
                }
                Spacer()
            }
            .padding(100)
            .padding()
//            popup
        }
        .onTapGesture {
            editing = false
        }
        .onLongPressGesture(minimumDuration: 1.0) {
            editing = true
        }
    }
    
    func getGridItem(_ i: Int) -> some View {
        VStack {
            if i == 7 && options.isEmpty {
                addMenuOption
            } else if editing && options.count < 8 && options.count == 8 - i - 1 {
                addMenuOption
            } else if options.count >= (8 - i) {
                if let subMenuOption = options[8 - i - 1] as? SubMenuOptionView {
                    subMenuOption
                        .onTapGesture {
                            options = subMenuOption.subOptions
                        }
                } else if let algMenuOption = options[8 - i - 1] as? AlgMenuOptionView {
                    algMenuOption
                        .onTapGesture {
                            print(algMenuOption.title)
                        }
                }
            } else {
                SubMenuOptionView(title: "", header: "", subOptions: [])
            }
        }
    }
    
    var addMenuOption: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color(hue: 1, saturation: 0, brightness: 0.1))
                .aspectRatio(1.0, contentMode: .fit)
                .shadow(color: .green, radius: 5)
            Text("add")
        }
        .frame(width: 200, height: 200)
        .onTapGesture {
//            popup = MenuOptionPopup()
        }
    }
    
    var popup: some View {
        ZStack {
            Color.gray
                .border(.tertiary, width: 3)
            if popupType == .addNewMenu {
                EditMenuOption(menuOption: options[selectedItem ?? 0] as? SubMenuOptionView ?? SubMenuOptionView(title: "", header: "", subOptions: []))
                    .onDisappear {
                        options[selectedItem] = ??
                    }
            } else if popupType == .copyExistingMenu {
                
            } else if popupType == .addNewAlg {
                
            } else if popupType == .useExistingAlg {
                
            } else if popupType == .editMenuOption {
                
            } else if popupType == .editAlg {
                
            }
        }
        .offset(y: popupType == .none ? 500 : 0)
        .padding(.horizontal, 3)
        .padding(.top, 3)
    }
}

enum PopupType {
    case none, addNewMenu, copyExistingMenu, addNewAlg, useExistingAlg, editMenuOption, editAlg
}
