package main

import (
	"net/http"
	"net/http/httptest"
	"testing"
	"time"
)

func TestGreet(t *testing.T) {
	req, _ := http.NewRequest("GET", "/", nil)
	w := httptest.NewRecorder()
	greet(w, req)

	if w.Code != http.StatusOK {
		t.Errorf("Expected 200 OK, got %d", w.Code)
	}

	expected := "Hello World! " + time.Now().Format(time.RFC3339)
	if w.Body.String() != expected {
		t.Errorf("Expected %s, got %s", expected, w.Body.String())
	}
}
