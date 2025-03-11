Class {
	#name : #NptSierpinski,
	#superclass : #Object,
	#category : #'Npt-Core-Tools'
}

{ #category : #'as yet unclassified' }
NptSierpinski class >> drawOn: aCanvas origin: aPoint length: aLength [
	aCanvas pathTransform translateX: aPoint x Y: aPoint y.

	aCanvas setPaint: Color red.
	aCanvas drawShape: (aCanvas createPath: [ :path |
			 path
				 absolute;
				 moveTo: aLength / 2 @ 0;
				 lineTo: aLength @ aLength;
				 lineTo: 0 @ aLength;
				 lineTo: aLength / 2 @ 0 ]).
	aCanvas setPaint: Color white.
	aCanvas drawShape: (aCanvas createPath: [ :path |
			 path
				 absolute;
				 moveTo: aLength / 2 @ aLength;
				 lineTo: aLength / 4 @ (aLength / 2);
				 lineTo: aLength / 2 + aLength / 2 @ (aLength / 2);
				 lineTo: aLength / 2 @ aLength ])
]
