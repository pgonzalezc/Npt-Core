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
	WAAdmin register: self at: 'repartos'
]

{ #category : #'as yet unclassified' }
NpRscRepartos >> benita [

	<get>
	<path: 'benita'>
	<produces: 'text/html'>
	
	^ 'repartos de benita'
]

{ #category : #'as yet unclassified' }
NpRscRepartos >> dolores [

	<get>
	<path: 'dolores'>
	<produces: 'text/html'>
	^ 'repartos de dolores'
]

{ #category : #accessing }
NpRscRepartos >> herederos [

	^ herederos ifNil: [ herederos := #('dolores' 'benita' 'pilar') ]
]

{ #category : #accessing }
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
						  attributeAt: 'hx-get' put: ('/repartos/{1}' format: { each });
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
	^ 'repartos de pilar'
]
