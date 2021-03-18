package crdt

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
	broadcasts chan broadcastRequest
}

func NewMapCRDT(lamportClock chan Timestamp, network chan broadcastRequest) *mapCRDT {
	return &mapCRDT{
		timestamps: lamportClock,
		broadcasts: network,
	}
}

func (self *mapCRDT) broadcastListen(conn chan broadcastRequest) {
	for {
		m := <-conn

		switch m.action {
		case Set:
			self.deliveringSetByCausalBroadcast(m.t, m.k, m.v)
		case Delete:
			self.deliveringDeleteByCausalBroadcast(m.t, m.k)
		}
	}
}

func (self *mapCRDT) broadcast(verb Verb, t Timestamp, k Key, v Value) {
	request := broadcastRequest{verb, t, k, v}
	self.broadcasts <- request
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
		self.values[k] = []tValue{tValue{t, v}}
	}
}

func (self *mapCRDT) RequestToDeleteKey(k Key) {
	e, ok := self.values[k]
	if ok {
		for _, entries := range e {
			self.deliveringDeleteByCausalBroadcast(entries.t, k)
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
