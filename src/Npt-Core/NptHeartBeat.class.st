Class {
	#name : #NptHeartBeat,
	#superclass : #WAComponent,
	#instVars : [
		'heredero'
	],
	#category : #'Npt-Core-Web'
}

{ #category : #testing }
NptHeartBeat class >> canBeRoot [ 

	^ true
]

{ #category : #'class initialization' }
NptHeartBeat class >> initialize [

	<script>
	WAAdmin register: self asApplicationAt: '/npct/heartbeat'
]

{ #category : #hooks }
NptHeartBeat >> initialRequest: aRequest [

	(aRequest headers associationsSelect: [ :assoc |
		 assoc key beginsWith: 'ssl_' ]) inspect
]

{ #category : #rendering }
NptHeartBeat >> renderContentOn: html [

	html div
		class: 'container';
		with: [
			html heading
				level2;
				with: 'Consulta de repartos'.
			self renderSelectorOn: html ].
	heredero ifNotNil: [ self renderRepartosOn: html ]
]

{ #category : #rendering }
NptHeartBeat >> renderRepartosOn: html [

	html div
		class: 'container';
		with: [
			html heading
				level3;
				with: heredero.
			html table: [
				html tableHead: [
					html tableRow: [
						html
							tableHeading: 'Id';
							tableHeading: 'Nro. Orden';
							tableHeading: 'Tipo';
							tableHeading: 'Nombre';
							tableHeading: '%';
							tableHeading: 
								((heredero = 'Dolores')
									ifTrue: [ 'Ferrado' ]
									ifFalse: [ 'Área' ]) ]  ].
				html tableBody: [
					(NptRepartos repartosDe: heredero) do: [ :each |
						html tableRow: [
							html
								tableData: (each at: 1);
								tableData: (each at: 3);
								tableData: (each at: 4);
								tableData: (each at: 5);
								tableData: (each at: 6);
								tableData: (each at: 7) ] ] ] ] ] 
]

{ #category : #rendering }
NptHeartBeat >> renderSelectorOn: html [

html anchor
				class: 'button button-clear';
				callback: [ self showBenita ];
				with: 'Benita'.
			html space.
			html anchor
				class: 'button button-clear';
				callback: [ self showPilar ];
				with: 'Pilar'.
			html space.
			html anchor
				class: 'button button-clear';
				callback: [ self showDolores ];
				with: 'Dolores'
]

{ #category : #'as yet unclassified' }
NptHeartBeat >> showBenita [

	heredero := 'Benita'
]

{ #category : #'as yet unclassified' }
NptHeartBeat >> showDolores [

	heredero := 'Dolores'
]

{ #category : #'as yet unclassified' }
NptHeartBeat >> showPilar [

	heredero := 'Pilar'
]

{ #category : #updating }
NptHeartBeat >> updateRoot: aHtmlRoot [

	super updateRoot: aHtmlRoot.
	aHtmlRoot stylesheet url:
		'https://fonts.googleapis.com/css?family=Roboto:300,300italic,700,700italic'.
	aHtmlRoot stylesheet url:
		'https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.css'.
	aHtmlRoot stylesheet url:
		'/static-files/css/milligram-v1.4.1/milligram.min.css'.
	aHtmlRoot javascript url: '/static-files/js/jquery.min.js'
]
