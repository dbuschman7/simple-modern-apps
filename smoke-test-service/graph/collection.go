package graph

import (
	"sync"

	sll "github.com/emirpasic/gods/lists/singlylinkedlist"
	cmap "github.com/orcaman/concurrent-map/v2"
)

type Timings struct {
	counts sll.List
}

var collection = cmap.New[Timings]()
var syncronize = sync.Mutex{}

// this method is semi-dangerous, not enitrely sure it is thread safe.
func Upsert(language string, time int) int {
	syncronize.Lock()
	defer syncronize.Unlock()

	tmp, exists := collection.Get(language)

	if exists == true {
		tmp.counts.Add(time)
		collection.Set(language, tmp)
		return tmp.counts.Size()
	} else {
		list := sll.New()
		list.Add(time)
		collection.Set(language, Timings{counts: *list})
		return 1
	}
}

func Counts(language string) int {
	tmp, exists := collection.Get(language)
	if exists == true {
		return tmp.counts.Size()
	}
	return 0
}

func Languages() []string {
	return collection.Keys()
}

func Average(language string) float64 {
	tmp, exists := collection.Get(language)
	if exists == true {
		return float64(sum(&tmp.counts)) / float64(tmp.counts.Size())
	}
	return 0
}

func sum(list *sll.List) int {
	it := list.Iterator()
	sum := int(0)
	for it.Next() {
		sum += it.Value().(int)
	}
	return sum
}
