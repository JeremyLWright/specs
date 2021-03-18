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

type Verb string

const (
	Set    Verb = "Set"
	Delete Verb = "Delete"
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
	clientId   string
}

func NewMapCRDT(name string, lamportClock chan Timestamp, b *broker.Broker) (*mapCRDT, func()) {
	m := &mapCRDT{
		values:     make(map[Key][]tValue),
		timestamps: lamportClock,
		publisher:  b,
		clientId:   name,
	}
	return m, func() {
		m.broadcastListen(m.publisher.Subscribe())
	}

}

func (self *mapCRDT) broadcastListen(conn chan interface{}) {
	for {
		msg := <-conn
		fmt.Printf("[%s]: %v\n", self.clientId, msg)

		switch m := msg.(type) {
		case broadcastRequest:
			switch m.action {
			case Set:
				self.deliveringSetByCausalBroadcast(m.t, m.k, m.v)
			case Delete:
				self.deliveringDeleteByCausalBroadcast(m.t, m.k)
			}
		default:
			fmt.Printf("Client %s got unknown message: %v\n", self.clientId, msg)
		}
	}
}

func (self *mapCRDT) broadcast(verb Verb, t Timestamp, k Key, v Value) {
	request := broadcastRequest{verb, t, k, v}
	self.publisher.Publish(request)
}

func (self *mapCRDT) RequestToReadValue(k Key) (Value, Timestamp, bool) {
	entries, ok := self.values[k]
	if ok {
		return entries[len(entries)-1].v, entries[len(entries)-1].t, ok
	}
	return "", -1, ok
}

func (self *mapCRDT) RequestToSetKey(k Key, v Value) Timestamp {
	t := <-self.timestamps
	self.broadcast(Set, t, k, v)
	return t
}

//isNewerThanAll implements the last write wins semantics. If the current timestamp is
//greater than all current values, permit the write.
func isNewerThanAll(t Timestamp, values []tValue) bool {
	for _, v := range values {
		if v.t > t {
			return false
		}
	}
	return true
}

func (self *mapCRDT) deliveringSetByCausalBroadcast(t Timestamp, k Key, v Value) {
	previous, ok := self.values[k]

	if !ok || isNewerThanAll(t, previous) {
		self.values[k] = []tValue{{t, v}}
	}
}

func (self *mapCRDT) RequestToDeleteKey(t Timestamp, k Key) {
	self.broadcast(Delete, t, k, "")
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
		newValues := removeIndex(self.values[k], idx)
		if len(newValues) > 0 {
			self.values[k] = newValues
		} else {
			delete(self.values, k)
		}
	}
}
