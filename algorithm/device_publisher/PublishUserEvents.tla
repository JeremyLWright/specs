------------------------- MODULE PublishUserEvents -------------------------

EXTENDS Naturals, Integers, TLC, Sequences

PT == INSTANCE PT

\*CONSTANTS Devices, People


People == {"George", "Harold"}
Devices == {"iOS"}


\*ASSUME NumCopies \subseteq Nat \* The number of copies you can checkout is a natural number


\* some shorthand functions to add and remove from a set
set ++ x == set \union {x}
set -- x == set \ {x} 



(*--algorithm memo_userhub

variables
    userhub_subscribedUsers = {}



fair process Person \in People
variables
    
    userhub_subscribedUsersLock = 1 \* model the lock
    subscriptions = {} \* The set of subscriptions for that user. 
    
begin
    Person:
    while TRUE do
        either 
            \* Subscribe
            userhub_subscribedUsers := userhub_subscribedUsers ++ Person;
        or 
            \* Unsubscribe
            userhub_subscribedUsers := ubserhub_subscribedUsers -- Person;
        end either;
    end while;
    goto Person;
end process

fair process Event \in Events
begin
    Event:
    while TRUE do
        \*either \* Publish Event
            with person \in userhub_subscribedUsers do
                device := userhub_subscribedUsers[person]
                \* "send the message"
                
            end with;
        \*or
        \* do nothing
        \*end either;
    end while;
end process

\* Properties



end algorithm; *)
=============================================================================
\* Modification History
\* Last modified Fri Feb 26 21:46:07 MST 2021 by jeremy
\* Created Thu Feb 25 09:35:00 MST 2021 by jeremy

