;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1b_quiz_submission) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; Image -> Boolean
; Returns true if the first of two provided images is larger than the other
(check-expect (larger (rectangle 20 30 "solid" "black")
                      (rectangle 40 30 "solid" "black"))
              false)
(check-expect (larger (rectangle 50 60 "solid" "black")
                      (rectangle 40 30 "solid" "black"))
              true)

; (define (larger img1 img2) false)         <- stub

;(define (larger img1 img2)
;  (... img1 img2))                         <- template

(define (larger img1 img2)
  (> (* (image-width img1) (image-height img1))
     (* (image-width img2) (image-height img2))))
