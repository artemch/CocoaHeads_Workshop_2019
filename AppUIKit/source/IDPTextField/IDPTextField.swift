

import UIKit

public class IDPTextField: UITextField {

    // MARK: - Public properties
    
    public var lineColor: UIColor = .gray {
        didSet {
            self.updateLineColor()
        }
    }
    
    public var errorLineColor: UIColor = .red {
        didSet {
            self.updateLineColor()
        }
    }
    
    public var activeLineColor: UIColor = .green {
        didSet {
            self.updateLineColor()
        }
    }
    
    public var errorText: String? = nil {
        didSet {
            self.errorLabel.text = errorText
            self.errorLabel.isHidden = errorText.flatMap { $0.count == 0 } ?? true
            self.updateLineColor()
            self.errorLabel.sizeToFit()
            self.invalidateIntrinsicContentSize()
            self.setNeedsLayout()
        }
    }
    
    public var errorColor: UIColor = .red {
        didSet {
            self.errorLabel.textColor = errorColor
        }
    }
    
    public var padding = UIEdgeInsets() {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    ///Reset error when begin typing in text field.
    public var isResetError: Bool = true
    
    // MARK: - Private properties
    
    private var lineLayer: CALayer = CALayer()
    
    private let errorLabel = UILabel()
    
    private var isError: Bool {
        return self.errorText.flatMap { $0.count > 0 } ?? false
    }
    
    private let minTextFieldHeight: CGFloat = 44
    
    // MARK: - Initializations and Deallocations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    // MARK: - Override methods
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.updateErrorLabelPosition()
        self.updateLinePostiton()
    }
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return self.internalRect(forBounds: bounds)
    }
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return self.internalRect(forBounds: bounds)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.internalRect(forBounds: bounds)
    }
    
    override public var intrinsicContentSize: CGSize {
        let textFieldIntrinsicContentSize = super.intrinsicContentSize
        let height = ceil(max(self.minTextFieldHeight, textFieldIntrinsicContentSize.height + self.lineLayer.bounds.height + self.errorLabelHeight))
        return CGSize(width: textFieldIntrinsicContentSize.width,
                      height: height)
    }
    
    public override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x -= self.padding.right
        rect.origin.y = (bounds.height - rect.height - self.errorLabelHeight) / 2 - self.lineLayer.bounds.height
        return rect
    }
    
    // MARK: - TextFieldDelegate
    
    @objc fileprivate func textFieldDidChanged(){
        if self.isResetError {
            self.errorText = nil
        }
    }
    
    @objc fileprivate func textFieldDidBeginEditing(){
        self.updateLineColor()
    }
    
    @objc fileprivate func textFieldDidEndEditing(){
        self.updateLineColor()
    }
    
    // MARK: - Private methods
    
    private func commonInit() {
        let errorLabel = self.errorLabel
        errorLabel.numberOfLines = 0
        errorLabel.textColor = self.errorColor
        errorLabel.text = self.errorText
        errorLabel.backgroundColor = .clear
        self.addSubview(errorLabel)
        self.settupBottomBorder(color: self.lineColor)
        
        self.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        self.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        self.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
    }
    
    private func settupBottomBorder(color: UIColor) {
        self.borderStyle = .none
        
        let lineLayer = self.lineLayer
        lineLayer.backgroundColor = color.cgColor
        lineLayer.frame = CGRect(x: 0, y: self.bounds.height - 1, width: self.bounds.width, height: 1)
        self.lineLayer = lineLayer
        self.layer.addSublayer(lineLayer)
    }
    
    private func internalRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.paddingInset())
            .inset(by: UIEdgeInsets(top: 0, left: 0, bottom: self.errorLabelHeight, right: 0))
            .inset(by: UIEdgeInsets(top: 0, left: 0, bottom: self.lineLayer.bounds.height, right: 0))
    }
    
    private func paddingInset() -> UIEdgeInsets {
        var padding = self.padding
        let pairs = [(self.leftView, self.leftViewMode, { (rect: CGRect) in padding.left += rect.size.width }),
                     (self.rightView, self.rightViewMode, { (rect: CGRect) in padding.right += rect.size.width })]
        pairs.forEach { (view, viewMode, operation) in
            view.map {
                if viewMode == .always || viewMode == .unlessEditing {
                    operation($0.frame)
                }
            }
        }
        return padding
    }
    
    private func updateLineColor() {
        if self.isError {
            self.setLineColor(color: self.errorColor)
        } else if self.isFirstResponder {
            self.setLineColor(color: self.activeLineColor)
        } else {
            self.setLineColor(color: self.lineColor)
        }
    }
    
    private func setLineColor(color: UIColor) {
        self.lineLayer.backgroundColor = color.cgColor
    }
    
    private var errorLabelHeight: CGFloat {
        return self.isError ? ceil(self.errorLabel.bounds.height) : 0
    }
    
    private func updateLinePostiton() {
        let lineLayer = self.lineLayer
        var frame = lineLayer.frame
        frame.size.width = self.bounds.width
        frame.origin.y = ceil(self.bounds.height - self.errorLabelHeight - frame.height)
        lineLayer.frame = frame
    }
    
    private func updateErrorLabelPosition() {
        let errorLabel = self.errorLabel
        errorLabel.sizeToFit()
        var frame = errorLabel.frame
        frame.origin.y = ceil(self.bounds.height - self.errorLabelHeight)
        errorLabel.frame = frame
    }
}
