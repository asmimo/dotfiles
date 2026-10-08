(require "smooth-scroll/smooth-scroll.scm")
(require "showkeys/showkeys.scm")
; (require "steel-pty/term.scm")
(require "forest/forest.scm")

;; Optional: which side the tree renders on ('left by default), and which
;; entry names are always hidden
(forest-configure! 'left #:ignore (list ".git" "target" "__pycache__"))

;; Optional: which explorer UI forest-open uses ('snacks by default)
;; (forest-set-style! style)
(forest-set-style! 'snacks) ; or 'mini
