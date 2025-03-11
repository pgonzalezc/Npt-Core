Class {
	#name : #NptStrings,
	#superclass : #Object,
	#category : #'Npt-Core-Tools'
}

{ #category : #'as yet unclassified' }
NptStrings class >> threeEqualsIn: aFilename [

	| found |
	found := OrderedCollection new.
	FileLocator home / aFilename readStreamDo: [ :stream |
		[ stream atEnd ] whileFalse: [
			| line |
			line := stream nextLine.
			(line size > 5 and: [ line endsWith: (line copyFrom: 1 to: 3) ])
				ifTrue: [ found add: line ] ] ].
	^ found
]
