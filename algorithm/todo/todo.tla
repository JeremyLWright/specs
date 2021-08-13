---- MODULE todo ----
EXTENDS TLC, Sequences, FiniteSets, Integers

\* 1. Item 
\*      Item has state done/not-done
\* 2. Actor (superflueous)
\*      Actor can mark an item as resolved.
\*      Actor can make item as not resolved.
\* 3. List
\*      Add Item
\*      (step 2) Remove Item
\*      (step 2) Edit Item -> change the description of the item.


\* Spec'ing idea: ignore item state and start thinking about what restrictions we want
\* on the state space.


\* Can we put the same item in our list? Yes. 

VARIABLES todoList 

CONSTANT Tasks



ToSet(s) ==
  (*************************************************************************)
  (* The image of the given sequence s. Cardinality(ToSet(s)) <= Len(s)    *)
  (* see https://en.wikipedia.org/wiki/Image_(mathematics)                 *)
  (*************************************************************************)
  { s[i] : i \in DOMAIN s }


vars == <<todoList>>

Init == 
    /\ todoList = <<>>

AddItem == 
    \E task \in (Tasks \ ToSet(todoList)) : todoList' = Append(todoList, task)



Next ==
    
    /\ AddItem

DebugToDoTooLong == Len(todoList) < 6

Spec == Init /\ [][Next]_vars






====