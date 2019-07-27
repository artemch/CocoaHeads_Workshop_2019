precedencegroup LeftOptionalApplyPrecedence {
    associativity: left
    higherThan: AssignmentPrecedence
    lowerThan: TernaryPrecedence
}

/// Apply parameter to function operator
infix operator ?|> : LeftOptionalApplyPrecedence
