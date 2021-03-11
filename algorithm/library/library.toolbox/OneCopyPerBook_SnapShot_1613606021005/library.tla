------------------------------ MODULE library ------------------------------
EXTENDS Naturals, Integers, TLC, Sequences

PT == INSTANCE PT

CONSTANTS Books, People, NumCopies

ASSUME NumCopies \subseteq Nat \* The number of copies you can checkout is a natural number




\* some shorthand functions to add and remove from a set
set ++ x == set \union {x}
set -- x == set \ {x} 


(*--algorithm library

variables
    library \in [Books -> NumCopies], \* The library is a set of books, each with a number of >0 copies.
    reserves = [b \in Books |-> <<>>]; \* Initially,the library has no active reservations
\* People can only checkout 1 book at a time



define
    AvailableBooks == {b \in Books: library[b] > 0} \* a book is available if it's in the library and it's count is greater than 0
    BorrowableBooks(p) == {b \in AvailableBooks: 
        \/ reserves[b] = <<>>
        \/ p = Head(reserves[b])}
         \* a book is borrowable if it is not reserved, OR if it is your reserved
end define;

fair process person \in People
variables
    books = {}, \* The books they have? TODO JLW, Why is this not my_private
    wants \in SUBSET Books;
begin
    Person:
        either 
            \* Checkout
            with b \in BorrowableBooks(self) \ books do
                library[b] := library[b] - 1; \* decrement the count in the library
                books := books ++ b;
                wants := wants -- b;
                if reserves[b] /= <<>> /\ self =Head(reserves[b]) then
                    reserves[b] := Tail(reserves[b]);
                end if;
            end with;
        or
            \* Return
            with b \in books do
                library[b] := library[b] + 1; \* put it back in the library
                books := books -- b;
            end with;
        or 
            \* Reserve
            with b \in {b \in Books: self \notin  PT!Range(reserves[b])} do 
                reserves[b] := Append(reserves[b], self); \* Find a book I want to reserve
            end with;
        end either;
    goto Person;
end process




end algorithm; *)
\* BEGIN TRANSLATION (chksum(pcal) = "94028323" /\ chksum(tla) = "7aa98af")
VARIABLES library, reserves, pc

(* define statement *)
AvailableBooks == {b \in Books: library[b] > 0}
BorrowableBooks(p) == {b \in AvailableBooks:
    \/ reserves[b] = <<>>
    \/ p = Head(reserves[b])}

VARIABLES books, wants

vars == << library, reserves, pc, books, wants >>

ProcSet == (People)

Init == (* Global variables *)
        /\ library \in [Books -> NumCopies]
        /\ reserves = [b \in Books |-> <<>>]
        (* Process person *)
        /\ books = [self \in People |-> {}]
        /\ wants \in [People -> SUBSET Books]
        /\ pc = [self \in ProcSet |-> "Person"]

Person(self) == /\ pc[self] = "Person"
                /\ \/ /\ \E b \in BorrowableBooks(self) \ books[self]:
                           /\ library' = [library EXCEPT ![b] = library[b] - 1]
                           /\ books' = [books EXCEPT ![self] = books[self] ++ b]
                           /\ wants' = [wants EXCEPT ![self] = wants[self] -- b]
                           /\ IF reserves[b] /= <<>> /\ self =Head(reserves[b])
                                 THEN /\ reserves' = [reserves EXCEPT ![b] = Tail(reserves[b])]
                                 ELSE /\ TRUE
                                      /\ UNCHANGED reserves
                   \/ /\ \E b \in books[self]:
                           /\ library' = [library EXCEPT ![b] = library[b] + 1]
                           /\ books' = [books EXCEPT ![self] = books[self] -- b]
                      /\ UNCHANGED <<reserves, wants>>
                   \/ /\ \E b \in {b \in Books: self \notin  PT!Range(reserves[b])}:
                           reserves' = [reserves EXCEPT ![b] = Append(reserves[b], self)]
                      /\ UNCHANGED <<library, books, wants>>
                /\ pc' = [pc EXCEPT ![self] = "Person"]

person(self) == Person(self)

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == /\ \A self \in ProcSet: pc[self] = "Done"
               /\ UNCHANGED vars

Next == (\E self \in People: person(self))
           \/ Terminating

Spec == /\ Init /\ [][Next]_vars
        /\ \A self \in People : WF_vars(person(self))

Termination == <>(\A self \in ProcSet: pc[self] = "Done")

\* END TRANSLATION 

NoDuplicateReservations ==
    \A b \in Books:
        \A i, j \in 1..Len(reserves[b]):
            i /= j => reserves[b][i] /= reserves[b][j]

TypeInvariant ==
    /\ library \in [Books -> NumCopies ++ 0] \* library is always a map of books to number of copies or 0
    /\ books \in [People -> SUBSET Books] \* people never have books that aren't from the library
    /\ wants \in [People -> SUBSET Books] \* People can only want books we have
    /\ reserves \in [Books -> Seq(People)]
    /\ NoDuplicateReservations

Liveness ==
    /\ <>(\A p \in People: wants[p] = {}) \* Eventually you always get what you want.
=============================================================================
\* Modification History
\* Last modified Wed Feb 17 16:53:29 MST 2021 by jeremy
\* Created Wed Feb 17 09:26:49 MST 2021 by jeremy
