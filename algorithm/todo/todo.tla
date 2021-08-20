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


VARIABLES itemDone, itemRank

CONSTANT Tasks


\* Imagine list on phone
\* - Groceries              (order: 0.2)
\* - Practice Guitar        (order: 0.255)
\* - Pick up kids           (order: 0.25)

\*ItemIsDone == (Groceries :> True)
\*
\*ItemRank == (Groceries :> 0.2)
\* TLC doesn't support reals, so we will model 0.0 to 1.0 as 0 to 100 (prentend fixed point)




Range(s) ==
  (*************************************************************************)
  (* The image of the given sequence s. Cardinality(ToSet(s)) <= Len(s)    *)
  (* see https://en.wikipedia.org/wiki/Image_(mathematics)                 *)
  (*************************************************************************)
  { s[i] : i \in DOMAIN s }

      


vars == <<itemDone, itemRank>>

TodoListItems == DOMAIN itemDone

NotInTodoList == {t \in Tasks : t \notin TodoListItems } 

MaxRank == Cardinality(TodoListItems)


Init == 
    /\ itemDone = [i \in {} |-> FALSE]
    /\ itemRank = [i \in {} |-> 0]

AddItem == 
    \E task \in NotInTodoList : 
        /\ itemDone' = itemDone @@ (task :> FALSE) \* This is not [ task |-> FALSE ], since this would treat the variable name 'task' as literally the word task.
        /\ itemRank' = itemRank @@ (task :> MaxRank)



ItemsLeftToDo == (Tasks \ TodoListItems) /= {}

Next ==
    \/ ItemsLeftToDo
        /\ AddItem
    \/ ~ItemsLeftToDo
        /\ UNCHANGED vars


\* Becomes a Foreign Key in DB
ItemsInDoneAreAlsoInRank == DOMAIN itemDone = DOMAIN itemRank

DebugToDoTooLong == Cardinality(DOMAIN itemDone) < 2

Spec == Init /\ [][Next]_vars






====