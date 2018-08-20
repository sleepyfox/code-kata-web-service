#lang racket
(require net/url rackunit json)

(define (get-json url)
   (call/input-url (string->url url)
                   get-pure-port
                   (compose string->jsexpr port->string)))

;; Returns a parsed JSON expression
; (get-json "https://forecast.gower.st/status")

;; Read the test file
(define in (open-input-file "README.md"))

(define (is-test? line)
  (string-prefix? line "TEST"))

(check-equal? (is-test? "TEST123") true "should be a test")
(check-equal? (is-test? "cat") false "should not be a test")

(define (read-till-test! handle)
  (let ([current-line (read-line handle)])
    (if (is-test? current-line)
        current-line
        (read-till-test! handle))))

(let ([test-clause (read-till-test! in)]
      [when-clause (read-line in)]
      [then-clause (read-line in)]
      [json-clause (read-line in)])
  (displayln (format "Now running test ~a" (substring test-clause 5)))
  (displayln (format "when ~a" (substring when-clause 5)))
  (displayln (format "checking ~a" (substring then-clause 5)))
  (displayln (format "matches JSON ~a" (substring json-clause 5))))
