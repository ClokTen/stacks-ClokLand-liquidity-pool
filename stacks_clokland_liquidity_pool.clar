;; Define Stacks ClokLand Liquidity Pool Contract

(define-data-var owner-address (buff 36))

(define-read-only token-pair "Stacks / ClokTen SIP010")

(define-read-only initial-supply 5)

(define-public (initialize)
  (only-when
    (is-eq? (tx-sender) owner-address)
    (begin
      (set-data owner-address (tx-sender))
      (ok))))

(define-public (add-liquidity (amount-Stacks uint) (amount-ClokTen uint))
  (begin
    (transfer-tokens (caller) contract-principal amount-Stacks ust-tx-sender)
    (transfer-tokens (caller) contract-principal amount-ClokTen ust-tx-sender)
    (mint-liquidity-tokens (caller) contract-principal (concat (uint-to-string amount-Stacks) "-" (uint-to-string amount-ClokTen)))
    (ok)))

(define-public (remove-liquidity (liquidity-tokens uint))
  (begin
    (burn-liquidity-tokens (caller) contract-principal liquidity-tokens)
    (ok)))

(define-public (swap-tokens (amount-in uint) (token-in string) (token-out string))
  (ok))

(define-read-only (get-owner-address) owner-address)

(define-read-only (get-token-pair) token-pair)

(define-read-only (get-initial-supply) initial-supply)
