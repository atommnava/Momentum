import SpriteKit

final class MomentumPoint: SKShapeNode, TouchableNode {
    
    init(radius: CGFloat = 40, lifeTime: TimeInterval) {
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
        let remove = SKAction.removeFromParent()
        
        run(SKAction.sequence([wait, dissapear, remove]))
    }
    
    func handleTouch() {
        removeAllActions()
        removeFromParent()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
}
