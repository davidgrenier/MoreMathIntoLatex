(defmacro until (ce)
  (let ((cond (car ce))
        (exp (cadr ce)))
    '(letrec ((loop (lambda ()
                      (if ,cond
                        ,cond
                        (progn ,exp (funcall loop))))))
       (funcall loop))))

(until (exp (setq exp (read-expression))))
==>
    (letrec
      ((loop (lambda ()
               (if exp
                 exp
                 (progn (setq exp (read-expression)) (funcall loop))))))
      (funcall loop))

(until ((progn (message "new iteration") cond)
        (setq cond (read-answer))))
==>
    (letrec ((loop (lambda ()
                     (if (progn (message "new iteration") cond)
                       (progn (message "new iteration") cond)
                       (progn (setq cond (read-answer)) (funcall loop))))))
      (funcall loop))

(let ((loop nil))
  (until (loop (setq loop (read-answer)))))
==>
    (let ((loop nil))
      (letrec
        ((loop (lambda ()
                 (if loop ; Capture la lambda plutot que la condition
                   loop ; À nouveau
                   (progn (setq loop (read-answer)) (funcall loop)))))) ; va écraser la lambda
        (funcall loop)))

; Dans tous les cas le problème est la capture de nom
(defmacro until (ce)
  (letrec ((loopsym (gensym))
           (cond (car ce))
           (exp (cadr ce)))
    '(letrec ((,loopsym (lambda ()
                          (if ,cond
                            ,cond
                            (progn ,exp (funcall ,loopsym))))))
       (funcall ,loopsym))))

; Ou encore
(define until-loop (cond exp)
  (letrec ((loop (lambda ()
                   (if (funcall cond)
                     (funcall cond)
                     (progn (funcall exp) (funcall loop))))))
    (funcall loop)))

(defmacro until (ce)
  (let ((cond (car ce))
        (exp (cadr ce)))
    '(until-loop ((lambda () ,cond) (lambda () ,exp)))))

(plet (f . xs) fx (map f xs))
==>
    (let ((x (car fx))
          (y (cdr fx)))
      (plet f x
            (plet xs y (map f xs))))
==>
    (let ((x (car fx))
          (y (cdr fx)))
      (let ((f x)) (let ((xs y)) (map f xs))))

(defmacro postfix (ops)



(/ (* (+ 1 x) 3) 2)
