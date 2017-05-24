;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname quiz_submission) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; abstract: program that creates a flower at a spot clicked on the screen.
;           the flower grows over time and clicking again will restart the
;           process at a different point.

;=============================
;Constants

(define WIDTH 400)
(define HEIGHT 200)
(define MTS (empty-scene WIDTH HEIGHT))
(define GSPEED 1)



;========================
; Data Definitions:

(define-struct flower (x y s))
; Flower is (make-flower Natural[0. WIDTH], Natural[0. HEIGHT], Integer)
; interp. (make-flower x y s) is a flower with x/y coordinates x & y and
;         size s. x/y are the center of the flower.

(define F1 (make-flower 30 40 5))
(define F2 (make-flower 140 20 8))

#;
(define (fn-for-flower f)
  (... (flower-x c)
       (flower-y c)
       (flower-s c)))

; Template rules used:
;  - compound: 3 fields


;==============================
; Functions

; Flower -> Flower
; called to start the program: (main (make-flower 0 0 0))
; no tests for main function
(define (main f)
  (big-bang f
            (on-tick grow-flower)       ; Flower -> Flower
            (to-draw place-flower)      ; Flower -> Image
            (on-mouse pos-change)))     ; Flower MouseEvent -> Flower

; Flower -> Flower
; grow flower by GSPEED
(check-expect (grow-flower (make-flower 20 20 3))
              (make-flower 20 20 (+ 3 GSPEED)))

(define (grow-flower f)
  (make-flower (flower-x f) (flower-y f) (+ (flower-s f) GSPEED)))

; Flower -> Image
; draw appropriate flower image of size (flower-s f)
(check-expect (draw-flower (make-flower 10 10 5))
              (overlay (circle 5 "solid" "black")
                       (pulled-regular-polygon (* 5 2.5) 5 1.1 140 "solid" "yellow")))
(check-expect (draw-flower (make-flower 100 100 8))
              (overlay (circle 8 "solid" "black")
                       (pulled-regular-polygon (* 8 2.5) 5 1.1 140 "solid" "yellow")))

(define (draw-flower f)
  (overlay (circle (flower-s f) "solid" "black")
           (pulled-regular-polygon (* (flower-s f) 2.5) 5 1.1 140 "solid" "yellow")))

; Flower -> Image
; draw appropriate flower image on MTS at (flower-x f) and (flower-y f)
; with (flower-s f)
(check-expect (place-flower (make-flower 10 10 5))
              (place-image (draw-flower (make-flower 10 10 5)) 10 10 MTS))
(check-expect (place-flower (make-flower 105 104 4))
              (place-image (draw-flower (make-flower 105 104 4)) 105 104 MTS))

(define (place-flower f)
  (place-image (draw-flower f) (flower-x f) (flower-y f) MTS))

; Flower MouseEvent-> Flower
; respawn the flower at the position of the curser when clicked
(check-expect (pos-change (make-flower 0 0 0) 5 5 "button-down")
              (make-flower 5 5 0))
(check-expect (pos-change (make-flower 0 0 0) 5 5 "button-up")
              (make-flower 0 0 0))
(check-expect (pos-change (make-flower 460 550 0) 50 50 "button-down")
              (make-flower 50 50 0))

(define (pos-change f x y me)
  (cond [(mouse=? me "button-down") (make-flower x y 0)]
        [else f]))

