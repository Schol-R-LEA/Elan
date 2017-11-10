# Elan
Elan is a test project for various approaches towards translating 
programming languages in the Lisp family, initially using a sub-set of
Scheme as the source language to be translated.

It is meant to use table-driven model that can be used for both
interpreting and compiling, in which the 'target operations' -
whether immediate by-expression execution, translation to an intermediate
interpretable form, compilation to an assembly language, compilation
to an executable binary, or even some other set of operations which
need to parse and walk through Scheme code - can be encapsulated into
a closure encapsulating tables of procedures and data needed to perform
the translation.

This project is an intermediate experiment meant to further the
development of the language Apophasi, which is in turn a simplified
testbed for design ideas for a planned production-quality language
called Thelema. 

Depending on the outcome, the information gleaned from this may also
be applied to the associated Assiah assembler and other parts of
the toolchain which are intended to accompany Thelema in the future.

