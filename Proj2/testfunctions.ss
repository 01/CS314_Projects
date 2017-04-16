;; Test functions

;; key ← 5187
;; for each character c in w
;; reading from right to left do
;; key ← 29 · key + ctv(c)
;; end for
;; where ctv (“character-to-value”) maps ‘a’ to 1, ‘b’ to 2, ... and ‘z’ to 26.

(define ctv
  (lambda (x)
    (cond
      ((eq? x 'a) 1)
      ((eq? x 'b) 2)
      ((eq? x 'c) 3)
      ((eq? x 'd) 4)
      ((eq? x 'e) 5)
      ((eq? x 'f) 6)
      ((eq? x 'g) 7)
      ((eq? x 'h) 8)
      ((eq? x 'i) 9)
      ((eq? x 'j) 10)
      ((eq? x 'k) 11)
      ((eq? x 'l) 12)
      ((eq? x 'm) 13)
      ((eq? x 'n) 14)
      ((eq? x 'o) 15)
      ((eq? x 'p) 16)
      ((eq? x 'q) 17)
      ((eq? x 'r) 18)
      ((eq? x 's) 19)
      ((eq? x 't) 20)
      ((eq? x 'u) 21)
      ((eq? x 'v) 22)
      ((eq? x 'w) 23)
      ((eq? x 'x) 24)
      ((eq? x 'y) 25)
      ((eq? x 'z) 26))))

;; key ← 5187
;; for each character c in w
;; reading from right to left do
;; key ← 29 · key + ctv(c)
;; end for
;; where ctv (“character-to-value”) maps ‘a’ to 1, ‘b’ to 2, ... and ‘z’ to 26.
;; Needs to hall null check when to multiply by 5187
(define key
  (lambda (w)
          (if (null? w)
            5187 
            (+(ctv (car w))(* 29 (key (cdr w)))))))

    ; key = key * 29 + ctv(c) 
    ; (key '(A B C)) = ctv(C) + 29 * (ctv (B) + 29 *(ctv(A) + (29 * ctv(null)= 5187)))
    ; (key '(A B C)) = ctv(C) + 29 * (ctv (B) + 29 * (ctv(A) + 29 *)
                ; if(w = null) key = 5187 else key = key * 29 + ctv(w)
    ; starting from last character  
       ;; *** FUNCTION BODY IS MISSING ***

;; -----------------------------------------------------
;; EXAMPLE KEY VALUES
;;   (key '(h e l l o))       = 106402241991
;;   (key '(m a y))           = 126526810
;;   (key '(t r e e f r o g)) = 2594908189083745

;; -----------------------------------------------------


;; HASH FUNCTION GENERATORS
; In the division method, a key k is mapped into size slots by taking the
; remainder (modulo) of k divided by size. In other words, the hash functions
; have the form:h(k) = k mod size
; size should be a prime number in order to generate a more uniform spread
; of the hash function values over the function’s entire [0, size − 1] range.
;; value of parameter "size" should be a prime number
(define gen-hash-division-method
  (lambda (size) ;; range of values: 0..size-1
     (lambda (w) ;; h(k) = k mod size -> h(k) = (k mod size)
        (if (null? w)
           0
           (modulo (key w) size)))));;

;; EXAMPLE HASH FUNCTIONS AND HASH FUNCTION LISTS

(define hash-1 (gen-hash-division-method 70111))
(define hash-2 (gen-hash-division-method 89997))
(hash-1 '(h e l l o))
;; -----------------------------------------------------
;; EXAMPLE HASH VALUES
;;   to test your hash function implementation
;;
;;  (hash-1 '(h e l l o))       ==> 35616
;;  (hash-1 '(m a y))           ==> 46566
;;  (hash-1 '(t r e e f r o g)) ==> 48238

;; value of parameter "size" is not critical
;; Note: hash functions may return integer values in "real"
;;       format, e.g., 17.0 for 17
;; value of parameter "size" is not critical
;; Note: hash functions may return integer values in "real"
;;       format, e.g., 17.0 for 17
;;The multiplication method for creating hash functions operates in two steps.
;; First, we multiply the key k by a constant A (we choose A= 0.6780219887),
;; and then extract the fractional part of kA. Then, we multiply this value with
;; size and take the floor of the result. In other words, the hash functions have
;; the form:
;; h(k) = FLOOR(size * (k * A - FLOOR(k * A)))
;; The desired uniform spread of the hash function over its entire range is
;; not dependent on a particular selection of size.
(define A 0.6780219887)

(define gen-hash-multiplication-method
  (lambda (size) ;; range of values: 0..size-1
    (lambda (w)
      (if (null? w)
          0
          (floor (* (- (* (key w) A)(floor (* (key w) A))) size))))))
                 ;; First we multiply key k by constant A -> k * A
                 ;; extract the fractional part of k*A - floor(k*A)
                 ;; floor((k * A)-


(define hash-3 (gen-hash-multiplication-method 7224))
(define hash-4 (gen-hash-multiplication-method 900))


;;  (hash-3 '(h e l l o))       ==> 6331.0
;;  (hash-3 '(m a y))           ==> 2456.0
;;  (hash-3 '(t r e e f r o g)) ==> 1806.0
;;
;;  (hash-4 '(h e l l o))       ==> 788.0
;;  (hash-4 '(m a y))           ==> 306.0
;;  (hash-4 '(t r e e f r o g)) ==> 225.0

(if (equal? (key '(h e l l o)) 106402241991)
   "(key '(hello)) worked!"
   "(key '(hello)) failed......you suck")
(if (equal? (hash-1 '(h e l l o)) 35616)
   "hash-1 '(h e l l o)) worked!"
   "hash-1 '(h e l l o)) failled.....you suck")
(if (equal? (hash-3 '(h e l l o)) 6331.0)
   "hash-3 '(h e l l o)) worked!"
   "hash-3 '(h e l l o)) failled.....you suck")

(if (equal? (key '(m a y)) 126526810)
   "(key '(m a y)) worked!"
   "(key '(m a y)) failed....you suck")
(if (equal? (hash-1 '(m a y)) 46566)
   "hash-1 '(m a y)) worked!"
   "hash-1 '(m a y)) failled.....you suck")
(if (equal? (hash-3 '(m a y)) 2456.0)
   "hash-3 '(m a y)) worked!"
   "hash-3 '(m a y)) failled.....you suck")

(if (equal? (key '(t r e e f r o g)) 2594908189083745)
   "(key '(t r e e f r o g)) worked!"
   "(key '(t r e e f r o g)) failled.....you suck")
(if (equal? (hash-1 '(t r e e f r o g)) 48238)
   "hash-1 '(t r e e f r o g)) worked!"
   "hash-1 '(t r e e f r o g)) failled.....you suck")
(if (equal? (hash-3 '(t r e e f r o g)) 1806.0)
   "hash-3 '(t r e e f r o g)) worked!"
   "hash-3 '(t r e e f r o g)) failled.....you suck")




