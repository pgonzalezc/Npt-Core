Class {
	#name : #NpRscRepartos,
	#superclass : #WARestfulHandler,
	#instVars : [
		'herederos'
	],
	#category : #'Npt-Core-Restful'
}

{ #category : #'tools registry' }
NpRscRepartos class >> register [

	<script>
	WAAdmin register: self at: 'npt-core/restful/repartos'
]

{ #category : #'rendering-browser' }
NpRscRepartos >> benita [

	<get>
	<path: 'benita'>
	<produces: 'text/html'>
	^ WAHtmlCanvas builder render: [ :html |
		  self
			  renderRepartos: [ NptRepartos repartosBenita ]
			  withTitle: 'Repartos Benita'
			  on: html ]
]

{ #category : #'rendering-browser' }
NpRscRepartos >> dolores [
	"repartos correspondientes a Dolores"
	<get>
	<path: 'dolores'>
	<produces: 'text/html'>
	^ WAHtmlCanvas builder render: [ :html |
		  self
			  renderRepartos: [ NptRepartos repartosDolores ]
			  withTitle: 'Repartos Dolores'
			  on: html ]
]

{ #category : #accessing }
NpRscRepartos >> herederos [

	^ herederos ifNil: [ herederos := #('dolores' 'benita' 'pilar') ]
]

{ #category : #'rendering-browser' }
NpRscRepartos >> index [

	<get>
	<path: '/'>
	<produces: 'text/html'>
	^ WAHtmlCanvas builder
		  fullDocument: true;
		  rootBlock: [ :root |
			  root beHtml5.
			  root title: 'Índice de repartos'.
			  root stylesheet url:
					  '/static-files/css/milligram-v1.4.1/milligram.min.css'.
			  root javascript url: '/static-files/js/htmx/htmx.min.js'.
			  root meta charset: 'utf-8' ];
		  render: [ :html |
			  self herederos do: [ :each |
					  html anchor
						  url: '#';
						  attributeAt: 'hx-get' put: ('repartos/{1}' format: { each });
						  attributeAt: 'hx-target' put: '#repartos';
						  with: each.
					  html space ].
			  html div id: 'repartos' ]
]

{ #category : #'as yet unclassified' }
NpRscRepartos >> pilar [

	<get>
	<path: 'pilar'>
	<produces: 'text/html'>
	^ WAHtmlCanvas builder render: [ :html |
		  self
			  renderRepartos: [ NptRepartos repartosPilar ]
			  withTitle: 'Repartos Pilar'
			  on: html ]
]

{ #category : #'private-rendering' }
NpRscRepartos >> renderRepartos: aBlock withTitle: aString on: html [

	html heading
		level: 4;
		with: aString.
	html table: [
		html tableHead: [ 
			#('id' 'heredero' 'nro. orden' 'tipo' 'nombre' '%' 'area') do: [ :each | html tableHeading: each]
			 ].
		aBlock value do: [ :each |
			html tableRow: [ each do: [ :col | html tableData: col ] ] ] ]
]
