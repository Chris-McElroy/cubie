//
//  AlgMenuView.swift
//  cubie
//
//  Created by chris on '25.12.28.
//

import SwiftUI
import RealityKit

struct TestView: View {
    var body: some View {
        RealityView { content in
            let cube = MeshResource.generateBox(size: 0.5, cornerRadius: 0.02)
            let entity = ModelEntity(mesh: cube, materials: [SimpleMaterial(color: .blue, isMetallic: false)])
            entity.components.set(InputTargetComponent(allowedInputTypes: .all))
                    
            
            entity.transform.rotation = simd_quatf(angle: .pi/4, axis: [0,1,0])
            entity.transform.rotation *= simd_quatf(angle: .pi/4.5, axis: normalize(SIMD3<Float>(1.0, 0.0, 1.0)))
//            entity.transform = Transform(pitch: -Float(Angle.degrees(10).radians))
            let plane1 = ModelEntity(mesh: .generatePlane(width: 0.4, height: 0.4), materials: [SimpleMaterial(color: .red, isMetallic: false)])
            plane1.transform.translation = SIMD3<Float>(x: 0, y: 0, z: 0.26)
            plane1.generateCollisionShapes(recursive: false)
            plane1.name = "red"
            entity.addChild(plane1)
            
            
            let plane2 = ModelEntity(mesh: .generatePlane(width: 0.4, height: 0.4), materials: [SimpleMaterial(color: .green, isMetallic: false)])
            plane2.transform.translation = SIMD3<Float>(x: 0, y: 0.26, z: 0)
            plane2.transform.rotation = simd_quatf(angle: -.pi/2, axis: [1,0,0])
//            let component = GestureComponent(DragGesture())
            plane2.generateCollisionShapes(recursive: false)
            plane2.name = "green"
//            component.canDrag = true
//            plane2.components.set(component)
            entity.addChild(plane2)
            
            let plane3 = ModelEntity(mesh: .generatePlane(width: 0.4, height: 0.4), materials: [SimpleMaterial(color: .yellow, isMetallic: false)])
            plane3.transform.translation = SIMD3<Float>(x: -0.26, y: 0, z: 0)
            plane3.transform.rotation = simd_quatf(angle: -.pi/2, axis: [0,1,0])
            plane3.generateCollisionShapes(recursive: false)
            plane3.name = "yellow"
            
            entity.addChild(plane3)
            
            content.add(entity)
        }
        .gesture(DragGesture().targetedToAnyEntity().onChanged { path in
//            print(path.entity.name)
            print(path.entity(at: path.location, in: .local)?.name ?? "none")
        })
        .gesture(TapGesture().targetedToAnyEntity().onEnded { path in
//            print(path.entity.name)
            print(path.entity.name)
            
        })
    }
}

extension ModelEntity {
    var piece: Int {
        Int(self.transform.translation.x)
    }
}

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
//                    .onDisappear {
//                        options[selectedItem] = ??
//                    }
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
