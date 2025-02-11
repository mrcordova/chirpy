package main

import (
	"net/http"
)
// type apiHandler struct{}

// func (apiHandler) ServeHTTP(http.ResponseWriter, *http.Request) {}
func main() {
	mux := http.NewServeMux()
	mux.Handle("/", http.FileServer(http.Dir('.')))
	// mux.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
	// 	if r.URL.Path != "/" {
	// 		http.NotFound(w, r)
	// 		return
	// 	}
	// 	// fmt.Fprintf(w, "Welcome to the home page!")
	// })
	server := http.Server{Handler: mux}
	server.Addr = ":8080"
	server.ListenAndServe()
}