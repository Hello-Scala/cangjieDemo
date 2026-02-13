package  demo.demo.game.domain


public class Hero {
    let name: String
    let heroType: HeroType

    public Hero(name: String, heroType: HeroType) {
        this.name = name
        this.heroType = heroType
    }
    public func say() {
        println("I'm ${name}. I'm a ${heroType} Hero!")
    }
}
