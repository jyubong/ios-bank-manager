import Foundation

public struct BankManager<BankClerk: CustomerReceivable> {
    private let customerQueue = CustomerQueue<CustomerNumbering>(list: LinkedList<CustomerNumbering>())
    
    public init() { }
    
    public func standBy(customer: CustomerNumbering) {
        customerQueue.enqueue(customer)
    }
    
    public func assignCustomer(depositCounter: OperationQueue, loanCounter: OperationQueue, bankClerks: [Banking: BankClerk]) {
        while let customer = customerQueue.dequeue() as? BankClerk.Customer, let banking = customer.banking {
            let operation = BlockOperation {
                bankClerks[banking]?.receive(customer: customer)
            }
        
            switch banking {
            case .deposit:
                depositCounter.addOperation(operation)
            case .loan:
                loanCounter.addOperation(operation)
            }
        }
    }
}
