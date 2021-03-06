(module redact-gensyms ()
  (import (scheme))
  (import (chicken base))
  (import (chicken irregex))
  (import (chicken type))
  (import (only (chicken io) read-line)
          (only (chicken process-context) command-line-arguments)
          (only (chicken string) string-split))

  (define prefixes (if (null? (command-line-arguments))
                       '("tmp" "g" "scm:")
                       (string-split (car (command-line-arguments)) ",")))

  (let ((rege (irregex `(: bow ($ (or ,@prefixes)) (+ numeric)))))
    (print ";; numbers replaced with XXX by redact-gensyms.scm")
    (print ";; prefixes: " prefixes)
    (let lp ()
      (let ((l (read-line)))
        (if (not (eof-object? l))
            (begin
              (print (irregex-replace/all rege l 1 "XXX"))
              (lp)))))))
