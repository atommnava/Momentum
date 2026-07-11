import SpriteKit

final class MomentumPoint: SKShapeNode, TouchableNode {
    var onExpired: () -> Void?
    
    init(radius: CGFloat = 40, lifeTime: TimeInterval, onExpired: @escaping () -> Void) {
        self.onExpired = onExpired
        super.init()
        
        let circlePath = CGPath(
            ellipseIn: CGRect(x: -radius, y: -radius, width: radius * 2, height: radius * 2),
            transform: nil
        )
        
        self.path = circlePath
        self.fillColor = .white
        self.strokeColor = .white
        self.lineWidth = 0
        self.name = "momentumPoint"
        
        startLifeTime(duration: lifeTime)
    }
    
    private func startLifeTime(duration: TimeInterval)
    {
        let wait = SKAction.wait(forDuration: duration)
        let dissapear = SKAction.fadeOut(withDuration: 0.15)
        let notifyExpiration = SKAction.run { [weak self] in
            self?.onExpired()
        }
        let remove = SKAction.removeFromParent()
        
        run(SKAction.sequence([wait, dissapear, notifyExpiration, remove]))
    }
    
    func handleTouch() {
        removeAllActions()
        removeFromParent()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) no ha sido implementado")
    }
}
