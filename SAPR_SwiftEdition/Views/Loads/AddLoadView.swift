//
//  AddLoadView.swift
//  SAPR_SwiftEdition
//
//  Created by Vlad Vrublevsky on 21.10.2021.
//

import SwiftUI

struct AddLoadView: View {
    struct AlertType: Identifiable {
        let id = UUID()
        let isError: Bool
        let text: String
    }
    
    @Environment(\.presentationMode) var presentationMode
    static let column_width: CGFloat? = 125
    
    let id_range: [Int]
    let isLinearLoad: Bool
    @ObservedObject var ConctructionDC: ConstructionDataController
    
    @State private var selectedID: Int = -1
    @State private var enteredLoad: String = ""
    @State private var alert: AlertType? = nil
    
    var body: some View {
        VStack {
            
            HStack {
                Text(isLinearLoad ? "Номер стержня": "Номер узла")
                    .frame(width: AddLoadView.column_width)
                Text(isLinearLoad ? "Распределенная нагрузка" : "Сосредоточенная нагрузка")
                    .frame(width: AddLoadView.column_width)
            }
            
            HStack {
                Picker(selection: $selectedID, label: Text("")) {
                    ForEach(0..<id_range.count) { i in
                        Text("\(id_range[i])").tag(i)
                    }
                }
                .frame(width: AddLoadView.column_width)
                
                TextField("", text: $enteredLoad)
                    .frame(width: AddLoadView.column_width)
            }
            
            HStack {
                Button("Decline") {
                    alert = AlertType(isError: false, text: "Вы уверены что хотите отменить все изменения?")
                }
                Button("Save") {
                    save()
                }
            }
            .padding(.top)
        }
        .multilineTextAlignment(.center)
        .padding()
        .alert(item: $alert) { alert in
            if alert.isError {
                return Alert(title: Text("Error"), message: Text(alert.text), dismissButton: .cancel())
            } else {
                return Alert(title: Text("Alert"), message: Text(alert.text), primaryButton: .destructive(Text("Выйти без сохранения"), action: { closeView() }), secondaryButton: .cancel() )
            }
        }
    }
    
    func save() {
        guard selectedID != -1 else {
            var alertText = ""
            if isLinearLoad { alertText = "Выберите стержень" }
            else { alertText = "Выберите узел" }
            alert = AlertType(isError: true, text: "Выберите стержень")
            return
        }
        
        guard let wrapped_value = Float(enteredLoad) else {
            alert = AlertType(isError: true, text: "Вводить можно только цифры")
            return
        }
        
        if isLinearLoad {
            ConctructionDC.Loads.append(LinearLoad(id: id_range[selectedID], q: wrapped_value))
        } else {
            ConctructionDC.Nodes.append(Node(id: id_range[selectedID], F: wrapped_value))
        }
        closeView()
    }
    
    func closeView() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddLoadView_Previews: PreviewProvider {
    static var previews: some View {
        AddLoadView(id_range: [1, 2, 3], isLinearLoad: true, ConctructionDC: .preview)
    }
}
