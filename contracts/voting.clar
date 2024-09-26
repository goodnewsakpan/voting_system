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
