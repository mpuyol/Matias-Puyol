
import Text.Show.Functions()



data  Participante = ConstructorParticipante { 
nombre               :: String,
cantidadDeDinero     :: Int,
tacticaDeJuego       :: Tactica,
propiedadesCompradas :: [Propiedad],
accionesDelJuego     :: [Accion]
}  deriving (Show)

type Accion = (Participante -> Participante)
type Tactica = String 
type Propiedad = (String,Int)



modificarCantidadDeDinero ::  (Int->Int) -> Participante -> Participante
modificarCantidadDeDinero unaFuncion unParticipante = unParticipante { cantidadDeDinero = unaFuncion ( cantidadDeDinero unParticipante ) }

modificarTactica ::  Tactica -> Participante -> Participante
modificarTactica  nuevaTactica unParticipante = unParticipante { tacticaDeJuego = nuevaTactica }

agregarAccion :: Accion -> Participante -> Participante
agregarAccion  unaAccion unParticipante = unParticipante {accionesDelJuego = accionesDelJuego unParticipante ++ [unaAccion] } 

esPropiedadBarata :: Propiedad -> Bool
esPropiedadBarata (_,precioPropiedad) = precioPropiedad < 150

esPropiedadCara ::  Propiedad -> Bool
esPropiedadCara (_,precioPropiedad) = precioPropiedad > 150

contarPropiedadesBaratas :: Participante -> Int
contarPropiedadesBaratas  unParticipante  =  (length.filter esPropiedadBarata) (propiedadesCompradas unParticipante) 

contarPropiedadesCaras :: Participante -> Int
contarPropiedadesCaras unParticipante  =  (length.filter esPropiedadCara) (propiedadesCompradas unParticipante) 

agregarPropiedad :: Propiedad -> Participante -> Participante
agregarPropiedad unaPropiedad (ConstructorParticipante unNombre dinero tactic unasPropiedades unasAcciones) = ConstructorParticipante unNombre (dinero -(snd unaPropiedad) ) tactic (unasPropiedades ++ [unaPropiedad]) unasAcciones



pasarPorElBanco :: Accion
pasarPorElBanco  unParticipante = (modificarCantidadDeDinero(+ 40). modificarTactica("Comprador Compulsivo") ) unParticipante

enojarse :: Accion
enojarse  unParticipante = (modificarCantidadDeDinero(+ 50). agregarAccion( gritar ) ) unParticipante

gritar :: Accion 
gritar unParticipante = unParticipante {nombre = "AHHHH " ++ nombre unParticipante}

cobrarAlquileres :: Accion
cobrarAlquileres unParticipante = modificarCantidadDeDinero ( + (10 * contarPropiedadesBaratas unParticipante + 20 * contarPropiedadesCaras unParticipante))  unParticipante

subastar :: Propiedad -> Accion
subastar unasPropiedades unParticipante 
    |  tacticaDeJuego unParticipante == "Accionista" = agregarPropiedad unasPropiedades unParticipante
    |  tacticaDeJuego unParticipante == "Oferente Singular" = agregarPropiedad unasPropiedades unParticipante
    |  otherwise = unParticipante

pagarAAccionistas ::  Accion
pagarAAccionistas unParticipante 
    | tacticaDeJuego unParticipante == "Accionista" = modificarCantidadDeDinero (+ 200) unParticipante
    | otherwise = modificarCantidadDeDinero (+ (-100)) unParticipante



carolina :: Participante
carolina = ConstructorParticipante "Carolina" 500 "Accionista" [] [pasarPorElBanco, pagarAAccionistas]

manuel :: Participante
manuel = ConstructorParticipante "Manuel" 500 "Oferente Singular" [] [pasarPorElBanco, enojarse]


