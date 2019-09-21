package stacks_and_queues

import (
	"gotest.tools/assert"
	"testing"
)

func TestAnimalShelter(t *testing.T) {
	shelter := NewAnimalShelter()

	thomas := &animal{kind: Cat, name: "Thomas"}
	murka := &animal{kind: Cat, name: "Murka"}
	matroskin := &animal{kind: Cat, name: "Matroskin"}

	sharik := &animal{kind: Dog, name: "Sharik"}
	polkan := &animal{kind: Dog, name: "Polkan"}
	azor := &animal{kind: Dog, name: "Azor"}

	shelter.Enqueue(thomas)
	shelter.Enqueue(murka)
	shelter.Enqueue(matroskin)

	shelter.Enqueue(sharik)
	shelter.Enqueue(polkan)
	shelter.Enqueue(azor)

	assert.Equal(t, shelter.DequeueAny(), thomas)
	assert.Equal(t, shelter.DequeueDog(), sharik)
	assert.Equal(t, shelter.DequeueCat(), murka)
	assert.Equal(t, shelter.DequeueDog(), polkan)

	assert.Equal(t, shelter.DequeueAny(), matroskin)
	assert.Equal(t, shelter.DequeueAny(), azor)

	assert.Equal(t, shelter.DequeueAny() == nil, true)
}
