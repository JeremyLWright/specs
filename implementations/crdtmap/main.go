package main

import (
	"flag"
	"fmt"
	"time"

	"github.com/JeremyLWright/specs/crdt/broker"
	"github.com/JeremyLWright/specs/crdt/crdt"
)

var (
	clock = make(chan crdt.Timestamp)
)

func lamportClock(chan crdt.Timestamp) {
	globalClock := 1
	for {
		clock <- crdt.Timestamp(globalClock)
		fmt.Printf("Sent timestamp %d\n", globalClock)
		globalClock = globalClock + 1
	}
}

func main() {

	flag.Parse()
	// Create and start a broker:
	b := broker.NewBroker()
	go b.Start()

	//Start the clock source
	go lamportClock(clock)

	alice, m1Listen := crdt.NewMapCRDT("alice", clock, b)
	bob, m2Listen := crdt.NewMapCRDT("bob", clock, b)

	go m1Listen()
	go m2Listen()

	alice.RequestToSetKey("George", "v1")
	t2 := bob.RequestToSetKey("George", "v2")
	//bob.RequestToDeleteKey(georgeTimestamp, "George")
	bob.RequestToDeleteKey(t2, "George")

	time.Sleep(2 * time.Second)

	v1, _, ok1 := alice.RequestToReadValue("George")
	v2, _, ok2 := bob.RequestToReadValue("George")

	fmt.Printf("Get alice synchronized value %v %v\n", v1, ok1)
	fmt.Printf("Get bob synchronized value %v %v\n", v2, ok2)

}
