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


(define-public (add-candidate (id uint) (name (string-utf8 50)))
  (begin
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_NOT_AUTHORIZED)
    (ok (map-set candidates id {name: name, vote-count: u0}))
  )
)

(define-public (vote (candidate-id uint))
  (let 
    (
      (voter tx-sender)
    )
    (asserts! (var-get voting-open) ERR_VOTING_CLOSED)
    (asserts! (is-none (map-get? votes voter)) ERR_ALREADY_VOTED)
    (match (map-get? candidates candidate-id)
      candidate
        (begin
          (map-set votes voter candidate-id)
          (map-set candidates candidate-id 
            (merge candidate {vote-count: (+ (get vote-count candidate) u1)}))
          )
          (var-set total-votes (+ (var-get total-votes) u1))
          (ok true)
        )
      ERR_INVALID_VOTE
    )
  )
)
