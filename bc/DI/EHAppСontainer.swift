//
//  EHAppСontainer.swift
//  bc
//
//  Created by Evgeny Hailov on 27.07.2023.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        registerApi()
    }
    
    private static func registerApi() {
        register {
            EHDispacher()
        }.scope(.application)
        
        register {
           EHLogger()
        }.scope(.application)
        
        register {
            EHUserDefaults()
        }.scope(.application)
        
        register {
            DataModel()
        }.scope(.application)
        
        register {
            EHHttpConnection(logger: resolve())
        }.scope(.application)
        
        register {
            EHDataLayer(user: resolve(), model: resolve(), httpConnection: resolve(), logger: resolve(), dispacher: resolve())
        }.scope(.application)
    }

}

//MARK: - Init
class EHDataLayerСontainer {
    
    func get() -> EHDataLayer {
        return Resolver.resolve()
    }
    
}

//MARK: - View Model Сontainer
extension FinanсeViewModel: Resolving {
    
    func getDataLayer() -> EHDataLayer {
        return resolver.resolve()
    }
    
}

extension JornalViewModel: Resolving {
    
    func getDataLayer() -> EHDataLayer {
        return resolver.resolve()
    }
    
}

extension ProfileViewModel: Resolving {
    
    func getDataLayer() -> EHDataLayer {
        return resolver.resolve()
    }
    
}

extension FileViewModel: Resolving {
    
    func getDataLayer() -> EHDataLayer {
        return resolver.resolve()
    }
    
}

extension AddFileViewModel: Resolving {
    
    func getLogger() -> EHLogger {
        return resolver.resolve()
    }
    
}

extension AddJurnalViewModel: Resolving {
    
    func getLogger() -> EHLogger {
        return resolver.resolve()
    }
    
}

extension AddFinanceViewModel: Resolving {
    
    func getLogger() -> EHLogger {
        return resolver.resolve()
    }
    
}

extension CashViewModel: Resolving {
    
    func getDataLayer() -> EHDataLayer {
        return resolver.resolve()
    }
    
    func getLogger() -> EHLogger {
        return resolver.resolve()
    }
    
}

extension LoginViewModel: Resolving {
    
    func getDataLayer() -> EHDataLayer {
        return resolver.resolve()
    }
    
}
