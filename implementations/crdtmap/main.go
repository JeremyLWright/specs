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
		fmt.Printf("Sending timestamp %d\n", globalClock)
		clock <- crdt.Timestamp(globalClock)
		globalClock = globalClock + 1
	}
}

func main() {
	extraSettle := flag.Bool("extraSettle", false, "Allow extra time between set and delete for messages to synchronize.")
	flag.Parse()
	// Create and start a broker:
	b := broker.NewBroker()
	go b.Start()

	//Start the clock source
	go lamportClock(clock)

	m1, m1Listen := crdt.NewMapCRDT(clock, b)
	m2, m2Listen := crdt.NewMapCRDT(clock, b)
	//m3, m3Listen := crdt.NewMapCRDT(clock, b)
	//m4, m4Listen := crdt.NewMapCRDT(clock, b)

	go m1Listen()
	go m2Listen()
	//go m3Listen()
	//go m4Listen()

	m1.RequestToSetKey("Alex", "2")
	m2.RequestToSetKey("George", "3")
	if *extraSettle {
		fmt.Println("Waiting for messages")
		time.Sleep(2 * time.Second)
	}
	m2.RequestToDeleteKey("George")
	//m3.RequestToSetKey("Sam", "4")

	time.Sleep(2 * time.Second)

	v1, ok1 := m1.RequestToReadValue("George")
	v2, ok2 := m2.RequestToReadValue("George")
	//v3, _ := m3.RequestToReadValue("George")
	//v4, _ := m4.RequestToReadValue("George")

	fmt.Printf("Get 1 synchronized value %v %v\n", v1, ok1)
	fmt.Printf("Get 2 synchronized value %v %v\n", v2, ok2)
	//fmt.Printf("Get synchronized value %v \n", v3)
	//fmt.Printf("Get synchronized value %v \n", v4)

}
