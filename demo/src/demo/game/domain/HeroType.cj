package  demo.demo.game.domain

public enum  HeroType {
AD | AP | ADC | APC
}

extend HeroType <: ToString {
    public func toString() {
        match (this) {
            case AD => "AD"
            case AP => "AP"
            case ADC => "ADC"
            case APC => "APC"
        }
    }
}