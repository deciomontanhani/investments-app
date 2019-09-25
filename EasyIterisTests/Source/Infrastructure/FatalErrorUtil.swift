//
//  EasyIterisTests.swift
//  EasyIterisTests
//
//  Created by Decio Montanhani on 20/09/19.
//

import Foundation

// Sobrescreve função global `fatalError` do Swift para que se possa testar um método que lança um fatalerror
public func fatalError(_ message: @autoclosure () -> String = "",
                       file: StaticString = #file,
                       line: UInt = #line) -> Never {
    FatalErrorUtil.fatalErrorClosure(message(), file, line)
    unreachable()
}

/// função `noreturn` que pausa para sempre
public func unreachable() -> Never {
    repeat {
        RunLoop.current.run()
    } while true
}

/// Funções uteis que podem substituir e restaurar a função global `fatalError`
public struct FatalErrorUtil {
    // Chamado pela implementação customizada do `fatalError`.
    static var fatalErrorClosure: (String, StaticString, UInt) -> Never = defaultFatalErrorClosure

    // Armazena a função `fatalError` original
    private static let defaultFatalErrorClosure = { Swift.fatalError($0, file: $1, line: $2) }

    /// Substitui a função global `fatalError` para motivos de teste.
    public static func replaceFatalError(closure: @escaping (String, StaticString, UInt) -> Never) {
        fatalErrorClosure = closure
    }

    /// Restaura a função `fatalError` para a implementação original do Swift
    public static func restoreFatalError() {
        fatalErrorClosure = defaultFatalErrorClosure
    }
}
