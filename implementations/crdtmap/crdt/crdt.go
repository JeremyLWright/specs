package crdt

import (
	"fmt"

	"github.com/JeremyLWright/specs/crdt/broker"
)

type Key string
type Value string
type Timestamp int

type tValue struct {
	t Timestamp
	v Value
}

type Verb int

const (
	Set Verb = iota
	Delete
)

type broadcastRequest struct {
	action Verb
	t      Timestamp
	k      Key
	v      Value
}

type mapCRDT struct {
	values     map[Key][]tValue
	timestamps chan Timestamp
	publisher  *broker.Broker
	clientId   int
}

func NewMapCRDT(lamportClock chan Timestamp, b *broker.Broker) (*mapCRDT, func()) {
	m := &mapCRDT{
		values:     make(map[Key][]tValue),
		timestamps: lamportClock,
		publisher:  b,
		clientId:   int(<-lamportClock),
	}
	return m, func() {
		m.broadcastListen(m.publisher.Subscribe())
	}

}

func (self *mapCRDT) broadcastListen(conn chan interface{}) {
	for {
		msg := <-conn
		fmt.Printf("Client %d got message: %v\n", self.clientId, msg)

		switch m := msg.(type) {
		case broadcastRequest:
			switch m.action {
			case Set:
				self.deliveringSetByCausalBroadcast(m.t, m.k, m.v)
			case Delete:
				self.deliveringDeleteByCausalBroadcast(m.t, m.k)
			}
		default:
			fmt.Printf("Client %d got unknown message: %v\n", self.clientId, msg)
		}
	}
}

func (self *mapCRDT) broadcast(verb Verb, t Timestamp, k Key, v Value) {
	request := broadcastRequest{verb, t, k, v}
	self.publisher.Publish(request)
}

func (self *mapCRDT) RequestToReadValue(k Key) (Value, bool) {
	entries := self.values[k]
	if len(entries) > 0 {
		return entries[len(entries)-1].v, true
	}
	return "", false
}

func (self *mapCRDT) RequestToSetKey(k Key, v Value) {
	t := <-self.timestamps
	self.broadcast(Set, t, k, v)
}

func forAllEntryYoungerThan(t Timestamp, previous []tValue) bool {
	for _, prime := range previous {
		if prime.t < t {
			continue
		}
		return false
	}
	return true
}

func (self *mapCRDT) deliveringSetByCausalBroadcast(t Timestamp, k Key, v Value) {
	previous, ok := self.values[k]

	if ok || forAllEntryYoungerThan(t, previous) {
		self.values[k] = []tValue{{t, v}}
	}
}

func (self *mapCRDT) RequestToDeleteKey(k Key) {
	entries, ok := self.values[k]
	if ok { //This line is suspicious.
		//I may have misunderstood the specification.
		//Only delete if you have that key.
		//It's possible the key is still propagating.
		//In which case, we won't forward the delete.
		for _, e := range entries {
			self.broadcast(Delete, e.t, k, "")
		}
	}
}

func (self *mapCRDT) findIdxByTimestamp(t Timestamp, k Key) int {
	entries := self.values[k]
	for idx, entry := range entries {
		if entry.t == t {
			return idx
		}
	}
	return -1
}

func removeIndex(s []tValue, index int) []tValue {
	ret := make([]tValue, 0)
	ret = append(ret, s[:index]...)
	return append(ret, s[index+1:]...)
}

func (self *mapCRDT) deliveringDeleteByCausalBroadcast(t Timestamp, k Key) {
	idx := self.findIdxByTimestamp(t, k)
	if idx != -1 {
		self.values[k] = removeIndex(self.values[k], idx)
	}
}
