;;;Steepest-Ascent Hill climbing, Best-first-tree-search, Best-first-graph-search
;;;Assumes you have defined
;;;1. A set of operators as lisp function
;;;2. a function solution-state?(description) to determine if a state is a solution
;;;3. a function to judge how close a state is to the goal: estimated-distance-from-goal(description)
;;;4. a function that indicates the cost of applying an operator cost-of-operator(Current-state, operator)


(defvar *trace-search* nil)

(defvar *graphing* nil "Should the search space be graphed? Only works for cities")
(defvar *pausing* nil "Should the system pause after each item graphed? Only works for cities")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Utilities to measure size of search space



(defstruct search-statistics
  (nodes-visited 0)
  (maximum-length-of-node-list 0)
  (length-of-solution 0)
  (maximum-depth 0)
  (cost-of-solution 0))

(defparameter *stats*(make-search-statistics))

(defun reset-stats()
  (setq *stats* (make-search-statistics)))
        
(defun update-heuristic-statistics (stats e node-list)
  "Changes stat structure to reflect new number of nodes visited,
  and optionally new maximum length and depth"
  (setf (search-statistics-nodes-visited stats)
        (+ 1 (search-statistics-nodes-visited stats)))
  (when (> (length node-list)
           (search-statistics-maximum-length-of-node-list stats))
    (setf (search-statistics-maximum-length-of-node-list stats)
          (length node-list)))
  (when (> (length (hnode-path e))
           (search-statistics-maximum-depth stats))
    (setf (search-statistics-maximum-depth stats)
          (length (hnode-path e)))))
           

;;;Search utilities
(defstruct hnode ;elements of node-list
  state
  path
  ESTIMATED-DISTANCE-FROM-GOAL
  COST-OF-PLAN-SO-FAR)


(defun successor-state (description operator)
  "Given a state description and an operator, 
   returns the state when the operator is applied
   or nil if the operator can't be applied.
   Operator is the name of a function of 1 argument, a state description"
  (if (fboundp operator)  ;;if it has a function definition
    (funcall (symbol-function operator) description)
    (error "The operator ~a does not have a function definition" operator)))

(defun successor-hnode(node operator)
  "Given a node and an operator, 
   returns the node when the operator is applied.
   or nil if the operator can't be applied.
   The next node is formed from the next state and adding the operator
   to the front of the path of the current node
   Operator is the name of a function of 1 argument, a state description"
  (let ((next (successor-state (hnode-state node) operator)))
    (when next
      (when *graphing* (draw-transition (hnode-state node) next)
            (when *pausing*
              (format t "~%pause> ")
              (setq *pausing* (not (eq #\n (read-char))))))
      (make-hnode :state next
                 :path (add-to-end operator (hnode-path node))
                 :estimated-distance-from-goal (estimated-distance-from-goal next)
                 :cost-of-plan-so-far (+ (cost-of-applying-operator (hnode-state node) operator)
                                         (hnode-cost-of-plan-so-far node))))))


(defun add-to-front(atom list)
  "Create a new list with atom at the end of list"
  (cons atom list))

(defun add-to-end(atom list)
  "Create a new list with atom at the end of list"
  (append list (list atom)))

(defun steepest-ascent-hill-climbing-search (initial-state operators)
  "Returns a list whose first element is the search statistics and 
   whose remaining elements are an ordered list of operators that need 
  to be applied to get to the goal state.   See pg 67."
  (let ((current-node (make-hnode :state initial-state 
                                 :path nil
                                 :cost-of-plan-so-far 0
                                 :estimated-distance-from-goal 
                                 (estimated-distance-from-goal initial-state)))
        (solved nil)
        (next-node nil)
        (best-successor nil)
        (minimum-distance-to-goal nil)
        )
    (when *graphing* (create-map-window "Steepest ascent hill climbing search"))
    (loop until (or (null current-node) ;;no state was better than current state
                    solved)
          do (setq minimum-distance-to-goal (hnode-estimated-distance-from-goal current-node))
          (setq best-successor nil)
          (update-heuristic-statistics *stats* current-node (list current-node))
          (when *trace-search*
            (format t "~%~%Exploring ~a" current-node))
          (cond ((solution-state? (hnode-state current-node)) 
                 ;;if current-node is a solution, exit with success  
                 (setq solved t))
                (t ;;otherwise apply each operator
                 ;;set best-successor to closest state to goal (provided it is better than
                 ;;than any state explored so far (minimum-distance-to-goal)
                 ;;when done, set current-node to best-successor 
                 ;;fail if no successor is better (best-successor = nil)
                 (loop for rule in operators 
                       do (setq next-node (successor-hnode  current-node rule))
                       (when (and next-node
                                  (< (hnode-estimated-distance-from-goal next-node)
                                     minimum-distance-to-goal))
                         (setq best-successor next-node)
                         (setq minimum-distance-to-goal (hnode-estimated-distance-from-goal best-successor))
                         ))
                 (if (null best-successor)
                   (setq current-node nil)
                   (setq current-node best-successor))
                 )))
    (when solved
      (setf (search-statistics-length-of-solution *stats*)
            (length (hnode-path current-node)))
      (setf (search-statistics-cost-of-solution *stats*)
            (hnode-cost-of-plan-so-far current-node))
      (setf (search-statistics-cost-of-solution *stats*)
            (hnode-cost-of-plan-so-far current-node))
      (when *graphing*
        (draw-solution (cons *start-state* (hnode-path current-node))))
      current-node)))


(defun best-first-tree-search (initial-state operators)
  "Returns a list whose first element is the search statistics and 
   whose remaining elements are an ordered list of operators that need 
  to be applied to get to the goal state.   See pg 75
  Like breadth first search, but sorts by estimated-distance to goal"
  (let ((open (list (make-hnode :state initial-state 
                                 :path nil
                                 :cost-of-plan-so-far 0
                                 :estimated-distance-from-goal 
                                 (estimated-distance-from-goal initial-state))))
        (solved nil)
        (next-node nil)
        (e nil))
    (when *graphing* (create-map-window "best first tree search"))
    (loop until (or (null open) ;;no more states
                    solved)
          do (setq e (first open))
          (update-heuristic-statistics *stats* e open)
          (when *trace-search*
            (format t "~%~%Exploring ~a" e))
          (setq open (rest open))
          (cond ((solution-state? (hnode-state e)) 
                 ;;if e is a solution, exit with success  
                 (setq solved t))
                (t ;;otherwise add next-node to the end of open
                 (loop for rule in operators 
                       do (setq next-node (successor-hnode  e rule))
                       (when next-node
                         (setq open (add-to-front next-node open))))
                 (setq open (sort-by-estimated-distance open)))))
    (when solved
      (setf (search-statistics-length-of-solution *stats*)
            (length (hnode-path e)))
      (setf (search-statistics-cost-of-solution *stats*)
            (hnode-cost-of-plan-so-far e))
      (when *graphing*
        (draw-solution (cons *start-state* (hnode-path e))))
      e)))


(defun sort-by-estimated-distance(list)
  "Sort list so that those with lowest distance to the goal are first"
  (sort list #'< :key #'hnode-estimated-distance-from-goal))

(defun best-first-graph-search (initial-state operators)
  "Returns a list whose first element is the search statistics and 
   whose remaining elements are an ordered list of operators that need 
  to be applied to get to the goal state.   See pg 75
  Like best first tree search, but detects duplicate nodes"
  (let ((open (list (make-hnode :state initial-state 
                                 :path nil
                                 :cost-of-plan-so-far 0
                                 :estimated-distance-from-goal 
                                 (estimated-distance-from-goal initial-state))))
        (solved nil)
        (CLOSED NIL) ;; A LIST OF STATES ALREADY EXPLORED
        (next-node nil)
        (e nil))
    (when *graphing* (create-map-window "best first graph search"))
    (loop until (or (null open) ;;no more states
                    solved)
          do (setq e (first open))
          (SETQ CLOSED (CONS (hnode-STATE E) CLOSED)) ;;ADD E to CLOSED
         
          (update-heuristic-statistics *stats* e open)
          (when *trace-search*
            (format t "~%~%Exploring ~a" e))
          (setq open (rest open))
          (cond ((solution-state? (hnode-state e)) 
                 ;;if e is a solution, exit with success  
                 (setq solved t))
                (t ;;otherwise add next-node to the end of open
                 (loop for rule in operators 
                       do (setq next-node (successor-hnode  e rule))
                       (when (and next-node
                                  (NOT (ALREADY-VISITED? (hnode-STATE NEXT-NODE) CLOSED)))
                         ;;ONLY ADD IF YOU HAVEN'T SEEN IT YET
                         (setq open (add-to-front next-node open))))
                 (setq open (sort-by-estimated-distance open)))))
    (when solved
      (setf (search-statistics-length-of-solution *stats*)
            (length (hnode-path e)))
      (setf (search-statistics-cost-of-solution *stats*)
            (hnode-cost-of-plan-so-far e))
      (when *graphing*
        (draw-solution (cons *start-state*  (hnode-path e))))
      e)))

(defun already-visited? (state visited)
  "Determines if a state is in the closed list"
  (member state visited :test #'equalp))


(defun hill-climbing-minimization (initial-state operators)
  (let ((current-node (make-hnode :state initial-state 
                                  :path nil
                                  :cost-of-plan-so-far 0
                                  :estimated-distance-from-goal 
                                  (estimated-distance-from-goal initial-state)))
        
        (next-node nil)
        (best-successor t)
        (minimum-value-of-state (value-of-state initial-state))
        )
    (when *graphing* 
      (setq *goal-state* initial-state)
      (create-map-window "Hill Climbing minimization")
      
      (loop until (null best-successor)
            do (setq best-successor nil)
            (update-heuristic-statistics *stats* current-node (list current-node))
            (when *trace-search*
              (format t "~%~%Exploring ~a" current-node))
            (loop for o in operators 
                  do (setq next-node (successor-hnode  current-node o))
                  (when (and next-node
                             (< (value-of-state (hnode-state next-node))
                                minimum-value-of-state))
                    (setq best-successor next-node)
                    (setq minimum-value-of-state (value-of-state (hnode-state next-node)))
                    ))
            
            (when best-successor
              (setq current-node best-successor)))
      
      current-node)))


(defvar *search-methods* nil "Used by Search Menu")
(unless (member 'steepest-ascent-hill-climbing-search *search-methods*)
  (setf *search-methods* (cons 'steepest-ascent-hill-climbing-search *search-methods*)))
(unless (member 'hill-climbing-minimization *search-methods*)
  (setf *search-methods* (cons 'hill-climbing-minimization *search-methods*)))
(unless (member 'best-first-tree-search *search-methods*)
  (setf *search-methods* (cons 'best-first-tree-search *search-methods*)))
(unless (member 'best-first-graph-search *search-methods*)
  (setf *search-methods* (cons 'best-first-graph-search *search-methods*)))



