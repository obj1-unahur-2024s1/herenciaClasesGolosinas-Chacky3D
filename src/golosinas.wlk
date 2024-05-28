/*
 * Los sabores
 */
object frutilla { }
object chocolate { }
object vainilla { }
object naranja { }
object limon { }


/*
 * Golosinas
 */
class Bombon {
	var peso = 15
	
	method precio() { return 5 }
	method peso() { return peso }
	method mordisco() { peso = peso * 0.8 - 1 }
	method sabor() { return frutilla }
	method libreGluten() { return true }
}

class BombonDuro inherits Bombon {
	
	override method mordisco() { peso = peso -1 }
	method otraComparacion() { return if(peso >= 8) 2 else 1 }
	method gradoDeDureza() { return if(peso > 12) 3 else self.otraComparacion() }
	
}

/*Indicar en cuál clase se encuentra el método que se ejecuta en cada caso, detallando el recorrido que realiza el method lookup.
 
 * var bombon = new Bombon() 
 * bombon.mordisco() 
 * bombon.peso()

   |Los métodos se ejecutan en la super clase Bombon, ya que la misma no hereda de ninguna otra|

 * bombon = new BombonDuro() 
 * bombon.mordisco() 
 * bombon.peso()

   |El método "mordisco()" se ejecuta en la clase BombonDuro, ya que el mismo fue redefinido|
   ------------------------------------------------------------------------------------------------------------------------
   |El método "peso()" se ejecuta en la super-clase Bombon, al comienzo, el programa intenta buscarlo en la propia clase,
    al no encontralo, revisa en la clase sobre la que se construyó BombonDuro|

*/

class Alfajor {
	var peso = 15
	
	method precio() { return 12 }
	method peso() { return peso }
	method mordisco() { peso = peso * 0.8 }
	method sabor() { return chocolate }
	method libreGluten() { return false }
}

class Caramelo {
	var peso = 5

	method precio() { return 12 }
	method peso() { return peso }
	method mordisco() { peso = peso - 1 }
	method sabor() { return frutilla }
	method libreGluten() { return true }
}

class CarameloDeSabores inherits Caramelo {
	const sabor
	
	override method sabor() { return sabor }
	
}

class CarameloRelleno inherits Caramelo {
	var recibioMordisco = false
	
	override method precio() { return super() + 1 }
	override method mordisco() {
		super()
		recibioMordisco = true
	}
	override method sabor() { return if(!recibioMordisco) super() else chocolate }
}

/*Indicar en cuál clase se encuentra el método que se ejecuta en cada caso, detallando el recorrido que realiza el method lookup.
 
 * var caramelo = new Caramelo()
 * caramelo.mordisco() 
 * caramelo.peso() 
 * caramelo.sabor() 

   |Los métodos se ejecutan en la super clase Caramelo, ya que la misma no hereda de ninguna otra|

 * caramelo = new CarameloRelleno() 
 * caramelo.mordisco() 
 * caramelo.peso() 
 * caramelo.sabor()

   |El método "mordisco()" se ejecuta en la clase CarameloRelleno, ya que el mismo fue redefinido|
   ------------------------------------------------------------------------------------------------------------------------
   |El método "peso()" se ejecuta en la super-clase Caramelo, al comienzo, el programa intenta buscarlo en la propia clase,
    al no encontralo, revisa en la clase sobre la que se construyó CarameloRelleno|
   ------------------------------------------------------------------------------------------------------------------------
   |El método sabor() se ejecuta en la clase CarameloRelleno, ya que el mismo fue redefinido|

*/

class Chupetin {
	var peso = 7
	
	method precio() { return 2 }
	method peso() { return peso }
	method mordisco() { 
		if (peso >= 2) {
			peso = peso * 0.9
		}
	}
	method sabor() { return naranja }
	method libreGluten() { return true }
}

class Oblea {
	var peso = 250
	
	method precio() { return 5 }
	method peso() { return peso }
	method mordisco() {
		if (peso >= 70) {
			// el peso pasa a ser la mitad
			peso = peso * 0.5
		} else { 
			// pierde el 25% del peso
			peso = peso - (peso * 0.25)
		}
	}	
	method sabor() { return vainilla }
	method libreGluten() { return false }
}

class ObleaCrujiente inherits Oblea {
	var mordiscosRecibidos = 0
	
	override method mordisco() {
		super()
		peso = if(mordiscosRecibidos < 3) peso - 3 else peso
		mordiscosRecibidos = mordiscosRecibidos + 1
	}
	method estaDebil() { return mordiscosRecibidos > 3 }
}

/*Indicar en cuál clase se encuentra el método que se ejecuta en cada caso, detallando el recorrido que realiza el method lookup.
 
 * var oblea = new Oblea() 
 * oblea.mordisco() 
 * oblea.peso()

   |Los métodos se ejecutan en la super clase Oblea, ya que la misma no hereda de ninguna otra|

 * oblea = new ObleaCrujiente() 
 * oblea.mordisco() 
 * oblea.peso() 

   |El método "mordisco()" se ejecuta en la clase ObleaCrujiente, ya que el mismo fue redefinido|
   ------------------------------------------------------------------------------------------------------------------------
   |El método "peso()" se ejecuta en la super-clase Oblea, al comienzo, el programa intenta buscarlo en la propia clase,
    al no encontralo, revisa en la clase sobre la que se construyó ObleaCrujiente|

*/

object heladeraDeMariano {
	var humedad = 0.1
	
	method humedad() { return humedad }
	method humedad(nuevaHumedad) { humedad = nuevaHumedad }
}

class Chocolatin {
	// hay que acordarse de *dos* cosas, el peso inicial y el peso actual
	// el precio se calcula a partir del precio inicial
	// el mordisco afecta al peso actual
	var pesoInicial
	var comido = 0
	
	method pesoInicial(unPeso) { pesoInicial = unPeso }
	method precio() { return pesoInicial * 0.50 }
	method peso() { return (pesoInicial - comido).max(0) }
	method mordisco() { comido = comido + 2 }
	method sabor() { return chocolate }
	method libreGluten() { return false }
}

class ChocolatinVIP inherits Chocolatin {
	override method peso() { return super() * self.humedad() }
	method humedad() { return 1 + heladeraDeMariano.humedad() }
}

class ChocolatinPremium inherits ChocolatinVIP {
	override method humedad() { return super() / 2 }
}

/*Indicar en cuál clase se encuentra el método que se ejecuta en cada caso, detallando el recorrido que realiza el method lookup.
 
 * var chocolatin = new Chocolatin() 
 * chocolatin.peso() 

   |El método se ejecuta en la super clase Chocolatin, ya que la misma no hereda de ninguna otra|

 * chocolatin = new ChocolatinVIP() 
 * chocolatin.peso()

   |El método "peso()" se ejecuta en la clase ChocolatinVIP, ya que el mismo fue redefinido|

 * chocolatin = new ChocolatinPremium() 
 * chocolatin.peso() 

   |El método "peso()" se ejecuta en la clase ChocolatinVIP, al comienzo, el programa intenta buscarlo en la propia clase,
    al no encontralo, revisa en la clase sobre la que se construyó ChocolatinPremium|

*/

class GolosinaBaniada {
	var golosinaInterior
	var pesoBanio = 4
	
	method golosinaInterior(unaGolosina) { golosinaInterior = unaGolosina }
	method precio() { return golosinaInterior.precio() + 2 }
	method peso() { return golosinaInterior.peso() + pesoBanio }
	method mordisco() {
		golosinaInterior.mordisco()
		pesoBanio = (pesoBanio - 2).max(0) 
	}	
	method sabor() { return golosinaInterior.sabor() }
	method libreGluten() { return golosinaInterior.libreGluten() }	
}


class Tuttifrutti {
	var libreDeGluten
	const sabores = [frutilla, chocolate, naranja]
	var saborActual = 0
	
	method mordisco() { saborActual += 1 }	
	method sabor() { return sabores.get(saborActual % 3) }	

	method precio() { return (if(self.libreGluten()) 7 else 10) }
	method peso() { return 5 }
	method libreGluten() { return libreDeGluten }	
	method libreGluten(valor) { libreDeGluten = valor }
}
