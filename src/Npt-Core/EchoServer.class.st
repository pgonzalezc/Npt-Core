Class {
	#name : #EchoServer,
	#superclass : #Object,
	#instVars : [
		'connectionSocket',
		'isRunning',
		'isRunningLock'
	],
	#category : #'Npt-Core-Web'
}

{ #category : #initialization }
EchoServer >> initialize [ 

	super initialize.
	isRunningLock := Mutex new.
	self isRunning: false
]

{ #category : #'as yet unclassified' }
EchoServer >> interactOnConnection [

	| interactionSocket |
	interactionSocket := connectionSocket waitForAcceptFor: 1 ifTimedOut: [ ^ self ].
	[ self interactUsing: interactionSocket ] fork
	
]

{ #category : #'as yet unclassified' }
EchoServer >> interactUsing: interactionSocket [

	| receivedData |
	[
	receivedData := interactionSocket receiveDataTimeout: 5.
	Transcript
		show: receivedData;
		cr.
	interactionSocket sendData: 'ECHO:' , receivedData.
	(Delay forSeconds: 1) wait.
	interactionSocket sendData: 'Processing...'.
	(Delay forSeconds: 3) wait.
	interactionSocket sendData: 'DONE' ] ensure: [
		interactionSocket closeAndDestroy ]
]

{ #category : #accessing }
EchoServer >> isRunning [

	^ isRunningLock critical: [ isRunning ]
]

{ #category : #accessing }
EchoServer >> isRunning: aBoolean [

	isRunningLock critical: [ isRunning := aBoolean ]
]

{ #category : #'as yet unclassified' }
EchoServer >> serve [
	
	[ [ self isRunning ] whileTrue: [ self interactOnConnection ] ] ensure: [ connectionSocket closeAndDestroy  ]
]

{ #category : #accessing }
EchoServer >> start [

	isRunningLock critical: [
		self isRunning ifTrue: [ ^ self ].
		self isRunning: true ].
	connectionSocket := Socket newTCP.
	connectionSocket listenOn: 1771 backlogSize: 10.
	[ self serve ] fork
]

{ #category : #accessing }
EchoServer >> stop [

	self isRunning: false
]
