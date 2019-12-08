s 		--> u(Uc), t, v(Vc), { Uc =:= (Vc * 2) }.
t 		--> [2].
u(0) 	--> [].
u(Ucp) 	--> [0], u(Uc), { Ucp is (Uc + 1) }.
u(Uc) 	--> [1], u(Uc).
v(0) 	--> [].
v(Vcp) 	--> [1], v(Vc), { Vcp is (Vc + 1) }.
v(Vc) 	--> [0], v(Vc).
