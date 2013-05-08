(defparameter *max-connect-four-depth* 4)
(defun deep-enough(state depth)
  (>= depth *max-connect-four-depth*))

(defun make-move (pos player move)
  (move-i pos player move))


(defparameter *start* 
  (make-array '(7 6) 
              :initial-element 'empty))

(defun copy-board(board)
  (let ((new-board (make-array '(7 6))))
    (loop for i from 0 to 6
        do (loop for j from 0 to 5
                 do (setf (aref new-board i j) 
                          (aref board i j) )))
    new-board))

(defun print-board(board)
  (format t "~%")
  (loop for j from 5 downto 0
      do (format t "===============~%" )
	 (loop for i from 0 to 6
	       do (format t "|~A" (if (eq (aref board i j) 'empty)
                                     " "
				   (aref board i j))))
	 (format t "|~%"))
  (format t "===============~%" )
  (loop for i from 0 to 6
      do (format t " ~A" i))
  (format t "~%"))

(defun move-i(state player i)
  (loop for j from 0 to 5
      when (eq (aref state i j) 'empty)
      do (let ((new-state (copy-board state)))
	     (setf (aref new-state i j) player)
	     (return-from move-i new-state))))

#| Trying the middle first makes it easier for a-b
(defun movegen (state player)
  (unless (or (won? state player)
              (won? state (opposite player)))
  (loop for i from 0 to 6
	when (eq 'empty (aref  state i 5))
	collect (move-i state player i))))
|#

(defun movegen (state player)
  (unless (or (won? state player)
              (won? state (opposite player)))
  (loop for i in '(3 4 2 1 5 6 0)
	when (eq 'empty (aref  state i 5))
	collect (move-i state player i))))



(defun won?(state player)
  "A state description is the solution if it matches the goal state"
  (or (vertical-line state player)
      (horizontal-line state player)
      (diagonal-up-line state player)
      (diagonal-down-line state player)))

(defun drawn?(state)
 (loop for i from 0 to 6
	never (eq 'empty (aref  state i 5))))
  


(defun vertical-line (state player)
  (loop for i from 0 to 6
      thereis (loop for j from 0 to 2
		  thereis (and (eq player (aref state i j))
			       (eq player (aref state i (+ j 1)))
			       (eq player (aref state i (+ j 2)))
			       (eq player (aref state i (+ j 3)))))))


(defun horizontal-line (state player)
  (loop for i from 0 to 3
      thereis (loop for j from 0 to 5
		  thereis (and (eq player (aref state i j))
			       (eq player (aref state (+ i 1) j))
			       (eq player (aref state (+ i 2) j))
			       (eq player (aref state (+ i 3) j))
			       ))))


(defun diagonal-up-line (state player)
  (loop for i from 0 to 3
      thereis (loop for j from 0 to 2
		  thereis (and (eq player (aref state i j))
			       (eq player (aref state  (+ i 1) (+ j 1)))
			       (eq player (aref state  (+ i 2)(+ j 2)))
			       (eq player (aref state  (+ i 3)(+ j 3)))))))


(defun diagonal-down-line (state player)
  (loop for i from 0 to 3
      thereis (loop for j from  3 to 5
		  thereis (and (eq player (aref state i j))
			       (eq player (aref state  (+ i 1)(- j 1)))
			       (eq player (aref state  (+ i 2)(- j 2)))
			       (eq player (aref state  (+ i 3)(- j 3)))))))



(defun test-play(state player)
  (let ((next (get-move state player)))
    (if (or (won? next player)
            (drawn? next))
	(print-board next)
      (test-play next (opposite player)))))

(defun opposite(x)
  (cond ((eq x 'x) 'o)
	((eq x 'o) 'x)
	(t (error "~%Illegal player ~a" X))))

(defun get-move(state player)
  (print-board state)
  (format t "~%~a> " player)
  (let ((n (read)))
    (cond ((and (numberp n)
		(>= n 0)
		(<= n 6)
		(move-i state player n)))
	  (t (format t "~%TRY AGAIN")
	     (get-move state player)))))

	  
	   



(defun print-board(board)
  (format t "~%")
  (loop for j from 5 downto 0
      do (format t "---------------~%" )
	 (loop for i from 0 to 6
	       do (format t "|~A" (if (eq (aref board i j) 'empty)
                                     " "
				   (aref board i j))))
	 (format t "|~%"))
  (format t "---------------~%" )
  (loop for i from 0 to 6
      do (format t " ~A" i))
  (format t "~%"))


(defun static(board player)
  (- (rank-board board player)
     (rank-board board (opposite player))))

(defun rank-board(state player)
  (+ (possible-vertical-line state player)
      (possible-horizontal-line state player)
      (possible-diagonal-up-line state player)
      (possible-diagonal-down-line state player)))

(defun neq (a b)
   (not (eq a b)))

(defun rank-line (player opposite s1 s2 s3 s4)
  (let ((matches 0))
    (when (and (neq opposite s1)
               (neq opposite s2)
               (neq opposite s3)
               (neq opposite s4))
      (when (eq player s1)
        (setq matches (+ matches 1)))
      (when (eq player s2)
        (setq matches (+ matches 1)))
      (when (eq player s3)
        (setq matches (+ matches 1)))
      (when (eq player s4)
        (setq matches (+ matches 1))))
    (cond ((<= matches 2) matches)
          ((= matches 3) 4)
          ((= matches 4) 1000))))

(defun possible-vertical-line (state player)
  (let ((score 0)
        (opposite (opposite player)))
    (loop for i from 0 to 6
          do (loop for j from 0 to 2
                   maximize (setq score (+ score
                                     (rank-line player opposite
                                             (aref state i j)
                                             (aref state i (+ j 1))
                                             (aref state i (+ j 2))
                                             (aref state i (+ j 3)))))))
    
    
    score))

(defun possible-horizontal-line (state player)
  (let ((score 0)
        (opposite (opposite player)))
    (loop for i from 0 to 3
          do (loop for j from 0 to 5
		        do (setq score (+ score
                                          (rank-line player opposite
                                                     (aref state i j)
			                           (aref state (+ i 1) j)
			                             (aref state (+ i 2) j)
			                             (aref state (+ i 3) j)
			             )))))
    score))


(defun possible-diagonal-up-line (state player)
  (let ((score 0)
        (opposite (opposite player)))
    (loop for i from 0 to 3
          do (loop for j from 0 to 2
                   do (setq score (+ score
                                     (rank-line player opposite
                                               (aref state i j)
			                       (aref state  (+ i 1) (+ j 1))
			                       (aref state  (+ i 2)(+ j 2))
			                     (aref state  (+ i 3)(+ j 3)))))))
    score))


(defun possible-diagonal-down-line (state player)
  (let ((score 0)
        (opposite (opposite player)))
    (loop for i from 0 to 3
          do (loop for j from  3 to 5
		        do (setq score (+ score
                                          (rank-line player opposite
                                                    (aref state i j)
			                            (aref state  (+ i 1)(- j 1))
			                             (aref state  (+ i 2)(- j 2))
			                             (aref state  (+ i 3)(- j 3)))))))
    score))



