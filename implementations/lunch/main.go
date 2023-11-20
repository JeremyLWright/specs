package main

import (
	"fmt"
	"log"
	"math/rand"
	"os"
	"strconv"
	"time"
)

var lunchPlaces = [...]string{
	"Falafel", "Hamburgers", "Pizza",
}

type message struct {
	address    chan string
	suggestion string
}

func Acceptor(c chan message, quit chan int) {
	decidedValue := ""

	for {
		select {
		case msg := <-c:
			fmt.Printf("Received Proposal: %v\n", msg.suggestion)
			if decidedValue == "" && msg.suggestion != "" {
				decidedValue = msg.suggestion
				msg.address <- decidedValue
				fmt.Printf("Decided value: %v\n", decidedValue)
			} else {
				msg.address <- decidedValue
				fmt.Printf("Reporting Decided value: %v\n", decidedValue)
			}
		case <-quit:
			fmt.Println("Exiting Acceptor")
			close(c)
			return
		}
	}
}

func Proposer(proposerQueue chan message, done chan string) {
	me := make(chan string)
	r := rand.Intn(10)
	fmt.Printf("Thinking...\n")
	time.Sleep(time.Duration(r) * time.Second)
	suggestion := lunchPlaces[rand.Intn(len(lunchPlaces))]
	fmt.Printf("Suggesting: %v\n", suggestion)
	proposerQueue <- message{
		address:    me,
		suggestion: suggestion,
	}

	myValue := <-me
	fmt.Printf("Accepting: %v\n", myValue)
	close(me)

	done <- "done"
	fmt.Printf("Done: %v\n", myValue)
}

func main() {
	rand.Seed(time.Now().UnixNano())
	numberOfProposers := 1
	if len(os.Args) >= 2 {
		n := os.Args[1]
		var err error
		numberOfProposers, err = strconv.Atoi(n)
		if err != nil {
			log.Fatal(err)
		}
	}

	proposerQueue := make(chan message)

	proposerDone := make(chan string)
	exitQueue := make(chan int)

	go Acceptor(proposerQueue, exitQueue)
	for i := 0; i < numberOfProposers; i++ {
		go Proposer(proposerQueue, proposerDone)
	}
	i := 0
	for {
		k := <-proposerDone
		if k == "done" {
			i = i + 1
			fmt.Print(i)
		}
		if i == numberOfProposers {
			break
		}
	}
	fmt.Printf("Done.\n")
	exitQueue <- 0
}
