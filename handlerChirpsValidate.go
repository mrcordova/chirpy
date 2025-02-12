package main

import (
	"encoding/json"
	"net/http"
	"strings"
)


func handlerChirpsValidate(w http.ResponseWriter, r *http.Request) {
	type parameters struct {
		Body string `json:"body"`
	}
	type returnVals struct {
		Cleaned_Body string `json:"cleaned_body"`
	}
	profaneWords := map[string]string{"kerfuffle": "****", "sharbert": "****","fornax": "****"}

	decoder := json.NewDecoder(r.Body)
	params := parameters{}
	err := decoder.Decode(&params)
	if err != nil {
		respondWithError(w, http.StatusInternalServerError, "Couldn't decode parameters", err)
		return
	}

	const maxChirpLength = 140
	if len(params.Body) > maxChirpLength {
		respondWithError(w, http.StatusBadRequest, "Chirp is too long", nil)
		return
	}

	
	bodySlice := strings.Fields(params.Body)
	for i, word := range bodySlice {
		lowercaseWord := strings.ToLower(word)
		if val, ok := profaneWords[lowercaseWord]; ok {
			bodySlice[i] = val
		}
	}
	cleaned := getCleanedBody(params.Body, profaneWords)

	respondWithJSON(w, http.StatusOK, returnVals{
		Cleaned_Body: cleaned,
	})
}

func getCleanedBody(body string, badWords map[string]string) string {
	words := strings.Split(body, " ")
	for i, word := range words {
		loweredWord := strings.ToLower(word)
		if val, ok := badWords[loweredWord]; ok {
			words[i] = val
		}
	}
	cleaned := strings.Join(words, " ")
	return cleaned
}
