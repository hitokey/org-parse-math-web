(defun parser-file-emenda(lc &optional (results nil) (rest nil) (n 1) (control nil))
  (cond ((null lc) (values (reverse results) rest))
	((and (eq (car lc) '#\*) (eq (cadr lc) '#\*))
	 (parser-file-emenda (cdr lc) results rest n nil))
	((and (eq (car lc) '#\*) (eq (cadr lc) '#\Space))
	 (progn
	   (push (cons (cons (caddr lc) nil) (cons (cons n 'NONE) nil)) results)
	   (parser-file-emenda (cdddr lc) results rest (+ n 1) t)))
	((and (eq (car lc) '#\Newline) (eq (cadr lc) '#\*))
	 (parser-file-emenda (cdr lc) results rest n nil))
	(control
	 (progn
	   (push (car lc) (caar results))
	   (parser-file-emenda (cdr lc) results rest n t)))
	(t (progn
	     (push (car lc) rest)
	     (parser-file-emenda (cdr lc) results rest n nil))) ))


;; (multiple-value-bind (top body) (parser-file-emenda (read-org "twm.org")) (dolist (x top) (format t "~{~a~}~%" (reverse (car x))))  (format t "~{~a~}~%" (reverse body)))

(defun read-org(file &optional (results nil))
  (with-open-file (in file)
    (loop for line = (read-char in nil)
       while line do
	 (push line results)))
  (reverse results))
