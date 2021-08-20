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


\* Can we put the same item in our list? 
\* > Initially we thought yes, but what does it mean to be "done", that it's done.... So, no

\* Spec Goal (Eventually)
\* =======================
\* Your Replica has task "Pick up Kids"
\* Wife's replica has the same task, e.g., "Pick up Kids"
\* You move item to top of list.
\* Wife moves item to bottom of list.
\* You mark item done.
\* Once all replicas are synchronized, item is eventually marked done. 


\* List Actions
\* ============
\* 1. Add item to list.
\* 2. Mark them done.
\* 3. re-order them. (priority)


VARIABLES todoList 

CONSTANT Tasks




Range(s) ==
  (*************************************************************************)
  (* The image of the given sequence s. Cardinality(ToSet(s)) <= Len(s)    *)
  (* see https://en.wikipedia.org/wiki/Image_(mathematics)                 *)
  (*************************************************************************)
  { s[i] : i \in DOMAIN s }

      


vars == <<todoList>>

Init == 
    /\ todoList = <<>>

AddItem == 
    \*\E task \in {Tasks : g \notin ToSet(todoList) } : todoList' = Append(todoList, task)
    \E task \in {g \in Tasks : g \notin Range(todoList) } : todoList' = Append(todoList, task)


ItemsLeftToDo == (Tasks \ Range(todoList)) /= {}

Next ==
    \/ ItemsLeftToDo
        /\ AddItem
    \/ ~ItemsLeftToDo
        /\ UNCHANGED vars

DebugToDoTooLong == Len(todoList) < 2

Spec == Init /\ [][Next]_vars






====