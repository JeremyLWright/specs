package main

import (
	"fmt"
	"testing"
	"time"

	"github.com/JeremyLWright/specs/crdt/broker"
	"github.com/JeremyLWright/specs/crdt/crdt"
	"github.com/stretchr/testify/assert"
)

func testClock(tick int, clock chan crdt.Timestamp) {
	for {
		clock <- crdt.Timestamp(tick)
		fmt.Printf("t=%d\n", tick)
		tick = tick + 1
	}
}

func TestEventuallyConsistent(t *testing.T) {

	// Create and start a broker:
	b := broker.NewBroker()
	go b.Start()

	//Start the clock source
	clock = make(chan crdt.Timestamp)
	go testClock(1, clock)

	alice, m1Listen := crdt.NewMapCRDT("alice", clock, b)
	bob, m2Listen := crdt.NewMapCRDT("bob", clock, b)

	go m1Listen()
	go m2Listen()

	alice.RequestToSetKey("George", "v1")
	t2 := bob.RequestToSetKey("George", "v2")
	bob.RequestToDeleteKey(t2, "George")

	time.Sleep(time.Millisecond)

	_, _, ok1 := alice.RequestToReadValue("George")
	_, _, ok2 := bob.RequestToReadValue("George")
	assert.False(t, ok1, "Alice incorrectly had the value.")
	assert.False(t, ok2, "Bob incorrectly had the value.")

}
