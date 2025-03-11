Class {
	#name : #NptRepartos,
	#superclass : #Object,
	#category : #'Npt-Tables'
}

{ #category : #'as yet unclassified' }
NptRepartos class >> repartosBenita [

	^ self repartosDe: 'Benita'
]

{ #category : #'as yet unclassified' }
NptRepartos class >> repartosDe: unHeredero [

	^ (P3Client new url:
		   'psql://ratodalua:rat0da.ua@localhost:5432/ratodalua') in: [
		  :client |
		  | stmt |
		  [
		  stmt := client prepare:
			          'SELECT id, heredero, n_orden, tipo, nombre, porcentaje, area FROM public.repartos WHERE heredero = $1'.
		  (stmt query: { unHeredero }) records ] ensure: [
			  stmt close.
			  client close ] ]
]
