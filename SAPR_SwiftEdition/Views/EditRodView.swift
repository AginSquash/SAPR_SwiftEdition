//
//  EditRodView.swift
//  SAPR_SwiftEdition
//
//  Created by Vlad Vrublevsky on 18.10.2021.
//

import SwiftUI

struct EditRodView: View {
    
    struct AlertType: Identifiable {
        let id = UUID()
        let isError: Bool
        let text: String
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    let rod: Rod
    var updateRod: ((_ id: Int, _ L: Float, _ A: Float, _ E: Float, _ Sigma: Float) -> Void)?
    
    @State private var L: String = ""
    @State private var A: String = ""
    @State private var E: String = ""
    @State private var Sigma: String = ""
    
    @State private var alert: AlertType? = nil
    
    var body: some View {
        VStack {
            HStack {
                Text("Номер стержня")
                    .frame(width: RodTableView.column_width)
                Text("L стержня")
                    .frame(width: RodTableView.column_width)
                Text("Допускаемое напряжение Е")
                    .frame(width: RodTableView.column_width)
                Text("Площадь сечения A")
                    .frame(width: RodTableView.column_width)
                Text("Предел прочночти")
                    .frame(width: RodTableView.column_width)
            }
            
            HStack {
                Text("\(rod.id)")
                    .frame(width: RodTableView.column_width)
                Group {
                    TextField("", text: $L, onEditingChanged:
                                { _ in NumberOnly(text: $L) })
                        .frame(width: RodTableView.column_width)
                    TextField("", text: $A, onEditingChanged:
                                { _ in NumberOnly(text: $A) })
                        .frame(width: RodTableView.column_width)
                    TextField("", text: $E, onEditingChanged:
                                { _ in NumberOnly(text: $E) })
                        .frame(width: RodTableView.column_width)
                    TextField("", text: $Sigma, onEditingChanged:
                                { _ in NumberOnly(text: $Sigma) })
                        .frame(width: RodTableView.column_width)
                }
                .multilineTextAlignment(.trailing)
            }
            
            HStack {
                Button("Decline") {
                    if areAnyChanges() {
                        alert = AlertType(isError: false, text: "Вы уверены что хотите отменить все изменения?")
                    } else {
                        closeView()
                    }
                }
                Button("Save") {
                    save()
                }
            }
        }
        .padding()
        .alert(item: $alert) { alert in
            if alert.isError {
                return Alert(title: Text("Error"), message: Text(alert.text), dismissButton: .cancel())
            } else {
                return Alert(title: Text("Alert"), message: Text(alert.text), primaryButton: .destructive(Text("Выйти без сохранения"), action: { closeView() }), secondaryButton: .cancel() )
            }
        }
    }
    
    init(rod: Rod, updateRod: ((_ id: Int, _ L: Float, _ A: Float, _ E: Float, _ Sigma: Float) -> Void)? = nil) {
        self.rod = rod
        self.updateRod = updateRod
        
        _L = State(wrappedValue: String(rod.L))
        _A = State(wrappedValue: String(rod.A))
        _E = State(wrappedValue: String(rod.E))
        _Sigma = State(wrappedValue: String(rod.Sigma))
    }
    
    func save() {
        guard let updateRod = updateRod else {
            fatalError("updateRod is nil!")
        }
        
        guard let L = Float(self.L) else {
            alert = AlertType(isError: true, text: "L должен быть числом")
            return
        }
        guard let A = Float(self.A) else {
            alert = AlertType(isError: true, text: "A должен быть числом")
            return
        }
        guard let E = Float(self.E) else {
            alert = AlertType(isError: true, text: "E должен быть числом")
            return
        }
        guard let Sigma = Float(self.Sigma) else {
            alert = AlertType(isError: true, text: "Sigma должен быть числом")
            return
        }
        
        withAnimation { /// Check  on updated macOS 
            updateRod(rod.id, L, A, E, Sigma)
            
            closeView()
        }
    }
    
    func areAnyChanges() -> Bool {
        let L = String(rod.L)
        let A = String(rod.A)
        let E = String(rod.E)
        let Sigma = String(rod.Sigma)
        
        if (L == self.L) && (A == self.A) && (E == self.E) && (Sigma == self.Sigma) {
            return false
        } else {
            return true
        }
    }
    
    func NumberOnly(text: Binding<String>) {
        let text_wrapped = text.wrappedValue
        let filtered = text_wrapped.filter { ".0123456789".contains($0) }
        if filtered != text_wrapped {
            text.wrappedValue = filtered
            
            alert = AlertType(isError: true, text: "Вводить можно только цифры")
        }
    }
    
    func closeView() {
        withAnimation {
            presentationMode.wrappedValue.dismiss()
            ///  Use isPresented or dismiss instead.
            /// https://developer.apple.com/documentation/swiftui/environmentvalues/presentationmode
        }
    }
}

struct EditRodView_Previews: PreviewProvider {
    static var previews: some View {
        EditRodView(rod: Rod(id: 1, L: 0, A: 0, E: 0, Sigma: 0))
    }
}
