

;;A problem description consists of
;;;1. A structure to represent the state description: 3x3 array
;;;2. A list of operators: *eight-puzzle-operators*
;;;3. A definition of each operator: fill-four etc
;;;   An operator is a lisp function, that given a state description, returns
;;;   A new state description (Or nil if the operator can't be applied)


;;; A particular problem requires
;;;1. A start state
;;;2. A function to deterimine whether a state is the goal state. 
;;;   By covention, we'll call this (solution-state? x)

;;In addition, this particular problem has a function called estimated-distance-from-goal(state)
;;that indicates how close a given state is from a solution
;;and a function cost-of-applying-operator(State Operator) that indicates
;;the cost of applying an operator

;;;00 01 02
;;;10 11 12
;;;20 21 22

(defparameter *goal-state* 
  (make-array '(3 3) 
              :initial-contents '((1 2 3)(4 5 6)(7 8 space))))

(defun copy-board(board)
  (let ((new-board (make-array '(3 3))))
    (loop for i from 0 to 2
        do (loop for j from 0 to 2 
                 do (setf (aref new-board i j) 
                          (aref board i j) )))
    new-board))

(defun print-board(board)
  (format t "~%-------")
  (loop for i from 0 to 2
        do (format t "~%|")
        (loop for j from 0 to 2 
              do (format t "~A|" (if (eq (aref board i j) 'space)
                                   " "
                                   (aref board i j))))
        (format t "~%-------")))

(defun find-square(x board)
"return a list with the x y coordinates of the piece x in board"
  (loop for i from 0 to 2
      thereis (loop for j from 0 to 2 
                  thereis
                    (when (eq (aref board i j) x) 
                      (list i j)))))
  

(defun move-up(state)
  (let* ((at-space (find-square 'space state))
         (i (first at-space)) 
         (j (second at-space))
         (new-state (copy-board state)))
    (when (> i 0)
      (setf (aref new-state i j) (aref new-state (- i 1) j))
      (setf (aref new-state (- i 1) j) 'space)
      new-state)))

(defun move-down(state)
  (let* ((at-space (find-square 'space state))
         (i (first at-space)) 
         (j (second at-space))
         (new-state (copy-board state)))
    (when (< i 2)
      (setf (aref new-state i j) (aref new-state (+ i 1) j))
      (setf (aref new-state (+ i 1) j) 'space)
      new-state)))

(defun move-left(state)
  (let* ((at-space (find-square 'space state))
         (i (first at-space)) 
         (j (second at-space))
         (new-state (copy-board state)))
    (when (> j 0)
      (setf (aref new-state i j) (aref new-state  i (- j 1)))
      (setf (aref new-state  i (- j 1)) 'space)
      new-state)))

(defun move-right(state)
  (let* ((at-space (find-square 'space state))
         (i (first at-space)) 
         (j (second at-space))
         (new-state (copy-board state)))
    (when (< j 2)
      (setf (aref new-state i j) (aref new-state  i (+ j 1)))
      (setf (aref new-state  i (+ j 1)) 'space)
      new-state)))
                           
  

(defun random-move(state)
  "randomly pick one of 4 operators. If it returns nil, choose again"
  (let ((r (random 4)))
    (or (cond ((= r 0)(move-left state))
        ((= r 1) (move-right state))
        ((= r 2) (move-up state))
        ((= r 3) (move-down state)))
      (random-move state))))

(defun random-moves (n state)
  "make N random moves"
  (loop for i from 1 to n 
        do (setq state (random-move state)))
  state)



(defparameter *start-state* 
  (random-moves 20 *goal-state*))


(defun solution-state?(state)
  "A state description is the solution if it matches the goal state"
  (equalp state *goal-state*))



(defparameter *eight-puzzle-operators* 
  '(move-up move-down move-left move-right))


(defun estimated-distance-from-goal (board)
"Compute Manhattan distance for each tile (except space)"
  (loop for i from 1 to 8 
        summing (manhattan-distance (find-square i board)
                                    (find-square i *goal-state*))))

(defun manhattan-distance (p1 p2)
"given two lists of x-y coords, sum the difference between x's and y's"
  (+ (abs (- (first p1) (first p2)))
     (abs (- (second p1) (second p2)))))





(defun cost-of-applying-operator (state operator)
  1)
                                    
