package main

import "testing"

func TestGenerate(t *testing.T) {
	channel := make(chan int)

	go Generate(channel)

	first := <-channel
	if first != 2 {
		t.Errorf("Expected Generator to give me 2, but I got %d", first)
	}

	second := <-channel
	if second != 3 {
		t.Errorf("Expected Generator to give me 2, but I got %d", second)
	}
}
