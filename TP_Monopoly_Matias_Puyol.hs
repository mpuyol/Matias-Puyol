
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

cambiarTactica ::  Tactica -> Participante -> Participante
cambiarTactica  nuevaTactica unParticipante = unParticipante { tacticaDeJuego = nuevaTactica }

agregarAccion :: Accion -> Participante -> Participante
agregarAccion  unaAccion unParticipante = unParticipante {accionesDelJuego = accionesDelJuego unParticipante ++ [unaAccion] } 

esPropiedadBarata :: Propiedad -> Bool
esPropiedadBarata (_,precioPropiedad) = precioPropiedad < 150

precioAlquiler :: Propiedad -> Int
precioAlquiler unaPropiedad
  | esPropiedadBarata unaPropiedad = 10
  | otherwise                   = 20

agregarPropiedad :: Propiedad -> Participante -> Participante
agregarPropiedad unaPropiedad (ConstructorParticipante unNombre dinero tactic unasPropiedades unasAcciones) = ConstructorParticipante unNombre (dinero -(snd unaPropiedad) ) tactic (unasPropiedades ++ [unaPropiedad]) unasAcciones

ingresosPorAlquileres :: Participante -> Int
ingresosPorAlquileres persona = sum . map precioAlquiler . propiedadesCompradas $ persona

pasarPorElBanco :: Accion
pasarPorElBanco  unParticipante = (modificarCantidadDeDinero(+ 40). cambiarTactica("Comprador Compulsivo") ) unParticipante

enojarse :: Accion
enojarse  unParticipante = (modificarCantidadDeDinero(+ 50). agregarAccion( gritar ) ) unParticipante

gritar :: Accion 
gritar unParticipante = unParticipante {nombre = "AHHHH " ++ nombre unParticipante}

cobrarAlquileres :: Accion
cobrarAlquileres unParticipante = modificarCantidadDeDinero ((+).ingresosPorAlquileres $ unParticipante) unParticipante

tieneLaTactica :: Participante -> Tactica -> Bool
tieneLaTactica unParticipante unaTactica = tacticaDeJuego unParticipante == unaTactica

subastar :: Propiedad -> Accion
subastar unasPropiedades unParticipante 
    |  tieneLaTactica unParticipante "Accionista" || tieneLaTactica unParticipante "Oferente Singular"= agregarPropiedad unasPropiedades unParticipante 
    |  otherwise = unParticipante

pagarAAccionistas ::  Accion
pagarAAccionistas unParticipante 
    | tieneLaTactica unParticipante "Accionista" = modificarCantidadDeDinero (+ 200) unParticipante
    | otherwise = modificarCantidadDeDinero (+ (-100)) unParticipante



carolina :: Participante
carolina = ConstructorParticipante "Carolina" 500 "Accionista" [] [pasarPorElBanco, pagarAAccionistas]

manuel :: Participante
manuel = ConstructorParticipante "Manuel" 500 "Oferente Singular" [] [pasarPorElBanco, enojarse]

--tieneLaPropiedad :: Participante -> Participante -> Bool
--tieneLaPropiedad  unaPropiedad (ConstructorParticipante _ _ _ [unaPropiedad] _ )  = True
--tieneLaPropiedad _ = False

--hacerBerrinchePor ::  Propiedad -> Accion
--hacerBerrinchePor 