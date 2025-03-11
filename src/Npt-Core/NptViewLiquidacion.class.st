Class {
	#name : #NptViewLiquidacion,
	#superclass : #WAComponent,
	#instVars : [
		'importes'
	],
	#category : #'Npt-Core-Web'
}

{ #category : #testing }
NptViewLiquidacion class >> canBeRoot [ 

	^ true
]

{ #category : #'class initialization' }
NptViewLiquidacion class >> initialize [

	<script>
	WAAdmin register: self asApplicationAt: 'npct/liquidacion'.
	TinyLogger default ensureFileLoggerNamed: 'npct.log'; clearLog
]

{ #category : #accessing }
NptViewLiquidacion >> aScaledNumber:  anIndex withValue: aScaledNumber [

	Transcript
		show: '--> processPartidaAt:> ';
		show: (' en {1} con valor: {2}' format: {
						 anIndex .
						 aScaledNumber });
	cr.
	importes at: anIndex put: aScaledNumber
]

{ #category : #'as yet unclassified' }
NptViewLiquidacion >> actualizaPartida01: aScaledNumber [

	importes at: 1 put: aScaledNumber.
	('#actualizaPartida01 --> actualiza Partida01 con: {1}\n' format: { aScaledNumber }) record
]

{ #category : #'as yet unclassified' }
NptViewLiquidacion >> actualizaPartida02: aScaledNumber [

	importes at: 2 put: aScaledNumber.
	Transcript
		show: '--> actualiza Partida02 con: ';
		show: aScaledNumber;
		cr
]

{ #category : #'as yet unclassified' }
NptViewLiquidacion >> changePartida: aNumber with: aNumberString [

	('changePartida: {1} nuevo valor: {2}\n' format: {aNumber . aNumberString }) record
]

{ #category : #'as yet unclassified' }
NptViewLiquidacion >> doEnviar [

	Transcript
		show: 'Enviar:>';
		show: importes; cr
]

{ #category : #initialization }
NptViewLiquidacion >> initialize [ 

	super initialize.
	importes := OrderedCollection new: 3 withAll: 0.0s2
]

{ #category : #'as yet unclassified' }
NptViewLiquidacion >> processChange [

	importes at: 3 put: (importes at: 1) + (importes at: 2).
	('--> processChange:> {1}' format: importes) record.
]

{ #category : #accessing }
NptViewLiquidacion >> processPartidaAt: anIndex withValue: aScaledNumber [

	('--> processPartidaAt: {1} con valor: {2}\n' format: { anIndex . aScaledNumber }) record.
	importes at: anIndex put: aScaledNumber
]

{ #category : #rendering }
NptViewLiquidacion >> renderButtonEnviarOn: html [

	html button 
		id: 'boton-enviar';
		class: 'float-right';
		callback: [ self doEnviar ];
		value: 'Enviar'
]

{ #category : #rendering }
NptViewLiquidacion >> renderContentOn: html [

	html document addLoadScript:
		(html jQuery id: 'input01') triggerSelect.
	html div
		class: 'container';
		with: [
			html heading
				level2;
				with: 'Liquidación'.
			html form
				id: 'this-form';
				with: [
					html div
						id: 'form-fields';
						with: [ self renderFormOn: html ].
					self renderButtonEnviarOn: html ] ]
]

{ #category : #rendering }
NptViewLiquidacion >> renderFormOn: html [

	self renderInput01On: html.
	self renderInput02On: html.
	self renderInputAccOn: html
]

{ #category : #rendering }
NptViewLiquidacion >> renderInput01On: html [

	html fieldSet: [
		html label
			for: 'input01';
			with: 'Primer importe'.
		html textInput
			id: 'input01';
			onChange: (html jQuery ajax
					 callback: [ :value |
						 self changePartida: 1 with: value. 
						 self
							 processPartidaAt: 1
							 withValue:
								 (ScaledDecimal newFromNumber: value asNumber scale: 2) ]
					 value: html jQuery this value;
					 script: [ :s |
						 self processChange.
						 s
							 <<
								 ((s jQuery id: 'form-fields') html: [ :r |
										  self renderFormOn: r ]);
							 << (html jQuery id: 'input02') triggerSelect ]);
			value: (importes at: 1);
			callback: [ :value |
				self actualizaPartida01:
					(ScaledDecimal newFromNumber: value asNumber scale: 2) ] ]
]

{ #category : #rendering }
NptViewLiquidacion >> renderInput02On: html [

	html fieldSet: [
		html label
			id: 'label-input02';
			for: 'input02';
			with: 'Segundo importe'.
		html textInput
			id: 'input02';
			onChange: (html jQuery post
					 serializeThis;
					 script: [ :s |
						 self processChange.
						 s
							 <<
								 ((s jQuery id: 'form-fields') html: [ :r |
										  self renderFormOn: r ]);
							 << (html jQuery id: 'boton-enviar') triggerSelect ]);
			value: (importes at: 2);
			callback: [ :value |
				self actualizaPartida02: (ScaledDecimal newFromNumber: value asNumber scale: 2)
				 ] ]
]

{ #category : #rendering }
NptViewLiquidacion >> renderInputAccOn: html [

	html fieldSet: [
		html label
			for: 'inputAcc';
			with: 'Importe Total'.
		html textInput
			id: 'inputAcc';
			value: (importes at: 3);
			disabled: true;
			callback: [ :value |
				importes
					at: 3
					put: (ScaledDecimal newFromNumber: value asNumber scale: 2) ] ]
]

{ #category : #updating }
NptViewLiquidacion >> updateRoot: aHtmlRoot [

	super updateRoot: aHtmlRoot.
	aHtmlRoot title: 'liquidación'.
	aHtmlRoot stylesheet url:
		'https://fonts.googleapis.com/css?family=Roboto:300,300italic,700,700italic'.
	aHtmlRoot stylesheet url:
		'https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.css'.
	aHtmlRoot stylesheet url:
		'/static-files/css/milligram-v1.4.1/milligram.min.css'.
	aHtmlRoot javascript url: '/static-files/js/jquery.min.js'
]
