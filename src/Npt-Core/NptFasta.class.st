Class {
	#name : #NptFasta,
	#superclass : #Object,
	#category : #'Npt-Core-Tools'
}

{ #category : #printing }
NptFasta class >> printFile: aFilename [

	FileLocator home / aFilename readStreamDo: [ :stream |
		[ stream atEnd ] whileFalse: [
			| line |
			((line := stream nextLine) beginsWith: '>')
				ifTrue: [
					Transcript
						cr;
						show: (line copyFrom: 2 to: line size);
						show: ': ' ]
				ifFalse: [ Transcript show: line ] ] ]
]
