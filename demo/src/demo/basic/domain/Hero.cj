package  demo.demo.basic.domain


public class Hero {
    let name: String
    let heroType: HeroType

    public Hero(name: String, heroType: HeroType) {
        this.name = name
        this.heroType = heroType
    }
    public func say(): String {
        return "I'm ${name}. I'm a ${heroType} Hero!"
    }
}
