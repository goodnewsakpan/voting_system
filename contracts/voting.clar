(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_NOT_AUTHORIZED (err u100))
(define-constant ERR_ALREADY_VOTED (err u101))
(define-constant ERR_INVALID_VOTE (err u102))
(define-constant ERR_VOTING_CLOSED (err u103))

(define-data-var voting-open bool true)
(define-data-var total-votes uint u0)

(define-map votes principal uint)
(define-map candidates
  uint
  {name: (string-utf8 50), vote-count: uint}
)


(define-read-only (get-vote-count (candidate-id uint))
  (match (map-get? candidates candidate-id)
    candidate (ok (get vote-count candidate))
    (err u404) ;; Candidate not found
  )
)

(define-read-only (get-total-votes)
  (ok (var-get total-votes))
)

(define-read-only (has-voted (voter principal))
  (is-some (map-get? votes voter))
)

(define-read-only (is-voting-open)
  (ok (var-get voting-open))
)

(define-read-only (get-candidate (candidate-id uint))
  (ok (map-get? candidates candidate-id))
)
