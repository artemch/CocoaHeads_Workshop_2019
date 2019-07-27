// Generated using Sourcery 0.16.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable variable_name



import Models

infix operator *~: MultiplicationPrecedence
infix operator |>: AdditionPrecedence

struct Lens<Whole, Part> {
    let get: (Whole) -> Part
    let set: (Part, Whole) -> Whole
}

func * <A, B, C> (lhs: Lens<A, B>, rhs: Lens<B, C>) -> Lens<A, C> {
    return Lens<A, C>(
        get: { a in rhs.get(lhs.get(a)) },
        set: { (c, a) in lhs.set(rhs.set(c, lhs.get(a)), a) }
    )
}

func *~ <A, B> (lhs: Lens<A, B>, rhs: B) -> (A) -> A {
    return { a in lhs.set(rhs, a) }
}

func |> <A, B> (x: A, f: (A) -> B) -> B {
    return f(x)
}

func |> <A, B, C> (f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
    return { g(f($0)) }
}

extension AuthenticationStoreDomain.Model {
    static let emailLens = Lens<AuthenticationStoreDomain.Model, String >(
      get: { $0.email },
      set: { part, whole in
        AuthenticationStoreDomain.Model(
         email: part,         password: whole.password,         isAgree: whole.isAgree,         displayName: whole.displayName,         authResult: whole.authResult,         resetPassword: whole.resetPassword        )
      }
    )
    static let passwordLens = Lens<AuthenticationStoreDomain.Model, String >(
      get: { $0.password },
      set: { part, whole in
        AuthenticationStoreDomain.Model(
         email: whole.email,         password: part,         isAgree: whole.isAgree,         displayName: whole.displayName,         authResult: whole.authResult,         resetPassword: whole.resetPassword        )
      }
    )
    static let isAgreeLens = Lens<AuthenticationStoreDomain.Model, Bool >(
      get: { $0.isAgree },
      set: { part, whole in
        AuthenticationStoreDomain.Model(
         email: whole.email,         password: whole.password,         isAgree: part,         displayName: whole.displayName,         authResult: whole.authResult,         resetPassword: whole.resetPassword        )
      }
    )
    static let displayNameLens = Lens<AuthenticationStoreDomain.Model, String? >(
      get: { $0.displayName },
      set: { part, whole in
        AuthenticationStoreDomain.Model(
         email: whole.email,         password: whole.password,         isAgree: whole.isAgree,         displayName: part,         authResult: whole.authResult,         resetPassword: whole.resetPassword        )
      }
    )
    static let authResultLens = Lens<AuthenticationStoreDomain.Model, AuthResult? >(
      get: { $0.authResult },
      set: { part, whole in
        AuthenticationStoreDomain.Model(
         email: whole.email,         password: whole.password,         isAgree: whole.isAgree,         displayName: whole.displayName,         authResult: part,         resetPassword: whole.resetPassword        )
      }
    )
    static let resetPasswordLens = Lens<AuthenticationStoreDomain.Model, AuthenticationStoreDomain.ResetPassword >(
      get: { $0.resetPassword },
      set: { part, whole in
        AuthenticationStoreDomain.Model(
         email: whole.email,         password: whole.password,         isAgree: whole.isAgree,         displayName: whole.displayName,         authResult: whole.authResult,         resetPassword: part        )
      }
    )
}
extension AuthenticationStoreDomain.ResetPassword {
    static let isLinkSentLens = Lens<AuthenticationStoreDomain.ResetPassword, Bool >(
      get: { $0.isLinkSent },
      set: { part, whole in
        AuthenticationStoreDomain.ResetPassword(
         isLinkSent: part,         loading: whole.loading        )
      }
    )
    static let loadingLens = Lens<AuthenticationStoreDomain.ResetPassword, LoadingState >(
      get: { $0.loading },
      set: { part, whole in
        AuthenticationStoreDomain.ResetPassword(
         isLinkSent: whole.isLinkSent,         loading: part        )
      }
    )
}
