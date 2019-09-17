(defun list-p-char(listc &optional (results nil) (con nil))
  (cond ((null results) results)
	((and (eq (car listc) '#\*) (eq (cadr listc) '#\Space))
	 (list-p-char (cdr listc) (car listc) T))
	(con (progn
	       (push (cons (cons (caddr listc) nil) 'NONE) results)
	       (list-p-char (cdddr listc) results T)))
	((eq (car listc) '#\*) 
	 (list-p-char (cdr listc) results NIL))
	(T (list-p-char (cdr listc) results NIL))))


(defun read-org(file &optional (results nil))
  (with-open-file (in file)
    (loop for line = (read-char in nil)
       while line do
	 (push line results)))
  (reverse results))

