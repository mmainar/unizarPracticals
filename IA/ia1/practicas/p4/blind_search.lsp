;;;Breadth-first and depth-first search
;;;Assumes you have defined
;;;1. A set of operators as lisp function
;;;2. a function solution-state?(description) to determine if a state is a solution


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

(defparameter *stats* (make-search-statistics))

(defun reset-stats()
  (setq *stats* (make-search-statistics)))
        
(defun update-statistics (stats e node-list)
  "Changes stat structure to reflect new number of nodes visited,
  and optionally new maximum length and depth"
  (setf (search-statistics-nodes-visited stats)
        (+ 1 (search-statistics-nodes-visited stats)))
  (when (> (length node-list)
           (search-statistics-maximum-length-of-node-list stats))
    (setf (search-statistics-maximum-length-of-node-list stats)
          (length node-list)))
  (when (> (length (node-path e))
           (search-statistics-maximum-depth stats))
    (setf (search-statistics-maximum-depth stats)
          (length (node-path e)))))
           

;;;Search utilities
(defstruct node ;elements of node-list
  state
  path)


(defun successor-state (description operator)
  "Given a state description and an operator, 
   returns the state when the operator is applied
   or nil if the operator can't be applied.
   Operator is the name of a function of 1 argument, a state description"
  (if (fboundp operator)  ;;if it has a function definition
    (funcall (symbol-function operator) description)
    (error "The operator ~a does not have a function definition" operator)))

(defun successor-node(node operator)
  "Given a node and an operator, 
   returns the node when the operator is applied.
   or nil if the operator can't be applied.
   The next node is formed from the next state and adding the operator
   to the front of the path of the current node
   Operator is the name of a function of 1 argument, a state description"
  (let ((next (successor-state (node-state node) operator)))
    (when next
      (when *graphing* (draw-transition (node-state node) next)
            (when *pausing*
              (format t "~%pause> ")
              (setq *pausing* (not (eq #\n (read-char))))))
      (make-node :state next
                 :path (add-to-end operator (node-path node))))))


(defun add-to-end(atom list)
  "Create a new list with atom at the end of list"
  (append list (list atom)))

(defun add-to-front(atom list)
  "Create a new list with atom at the front of list"
  (cons atom list))


(defun breadth-first-search (initial-state operators)
  "Returns a list whose first element is the search statistics and 
  whose remaining elements are an ordered list of operators that need 
  to be applied to get to the goal state.  See pg 37."
  (let ((node-list (list (make-node :state initial-state 
                                    :path nil)))
        (solved nil)
        (next-node nil)
        (successors nil)
        (e nil))
    (when *graphing* (create-map-window "breadth first search"))
    (loop until (or (null node-list) ;;no more states
                    solved)
          do (setq e (first node-list))
          (update-statistics *stats* e node-list)
          (when *trace-search*
            (format t "~%~%Exploring ~a" e))
          (setq node-list (rest node-list))
          (cond ((solution-state? (node-state e)) 
                 ;;if e is a solution, exit with success  
                 (setq solved t))
                (t ;;otherwise add successors to the end of node-list
                 (setq successors nil)
                 (loop for rule in operators 
                       do (setq next-node (successor-node e rule))
                       (when next-node
                         (setq successors (add-to-end next-node successors))))
                 (setq node-list (append node-list successors)))))
    (when solved
      (setf (search-statistics-length-of-solution *stats*)
            (length (node-path e)))
      (when *graphing*
        (draw-solution (cons *start-state* (node-path e))))
      e)))




(defun depth-first-search (initial-state operators)
  "Returns a list whose first element is the search statistics and 
  whose remaining elements are an ordered list of operators that need 
  to be applied to get to the goal state.  See pg 39 Derived from best-first-search"
  (let ((node-list (list (make-node :state initial-state 
                                    :path nil)))
        (solved nil)
        (next-node nil)
        (successors nil)
        (e nil))
    (when *graphing* (create-map-window  "depth first search"))
    (loop until (or (null node-list) ;;no more states
                    solved)
          do (setq e (first node-list))
          (update-statistics *stats* e node-list)
          (when *trace-search*
            (format t "~%~%Exploring ~a" e))
          (setq node-list (rest node-list))
          (cond ((solution-state? (node-state e)) 
                 ;;if e is a solution, exit with success  
                 (setq solved t))
                (t ;;otherwise add successors to the front of node-list
                 (setq successors nil)
                 (loop for rule in operators 
                       do (setq next-node (successor-node e rule))
                       (when next-node
                         (setq successors (add-to-end next-node successors))))
                 (setq node-list (append successors node-list)))))
    (when solved
      (setf (search-statistics-length-of-solution *stats*)
            (length (node-path e)))
      (when *graphing*
        (draw-solution (cons *start-state* (node-path e))))
      e)))
              

                 
(defvar  *default-depth-limit* 5 "Cut off for depth-first-search-with-depth-limit")
;;LIKE DEPTH-FIRST-SEARCH, BUT STOPS IF THE DEPTH IS GREATER THAN THE LIMIT                  
(defun depth-first-search-with-depth-limit (initial-state operators 
                                                          &optional (depth-limit *default-depth-limit*)
                                                          )
  "Returns a list whose first element is the search statistics and 
  whose remaining elements are an ordered list of operators that need 
  to be applied to get to the goal state.  Derived from depth-first-search"
  ;;accepts *stats* as optional argument, so one can tell how much it did if it fails
  (let ((node-list (list (make-node :state initial-state 
                                    :path nil)))
        (solved nil)
        (next-node nil)
        (successors nil)
        (e nil))
    (when *graphing* (create-map-window "depth first search with depth limit"))
    (loop until (or (null node-list) ;;no more states
                    solved)
          do (setq e (first node-list))
          (update-statistics *stats* e node-list)
          (when *trace-search*
            (format t "~%~%Exploring ~a" e))
          (setq node-list (rest node-list))
          (cond ((solution-state? (node-state e)) 
                 ;;if e is a solution, exit with success  
                 (setq solved t))
                ((< (LENGTH (NODE-PATH E))
                     DEPTH-LIMIT)
                 ;;IF DEPTH LIMIT IS NOT EXCEEDED
                 (setq successors nil)
                 (loop for rule in operators 
                       do (setq next-node (successor-node e rule))
                       (when next-node
                         (setq successors (add-to-end next-node successors))))
                 (setq node-list (append successors node-list)))))
    (when solved
      (setf (search-statistics-length-of-solution *stats*)
            (length (node-path e)))
      (when *graphing*
        (draw-solution (cons *start-state*  (node-path e))))
      e)))    
                                
          

          
          
    
  
;;LIKE DEPTH-FIRST-SEARCH, BUT DOESN'T EXPLORE DUPLICATE NODES
(defun depth-first-search-with-duplicate-node-detection (initial-state operators)
  "Returns a list whose first element is the search statistics and 
  whose remaining elements are an ordered list of operators that need 
  to be applied to get to the goal state.  See page  58. Derived from depth-first-search"
  (let ((node-list (list (make-node :state initial-state 
                                    :path nil)))
        (solved nil)
        (next-node nil)
        (VISITED NIL) ;; A LIST OF STATES ALREADY EXPLORED
        (successors nil)
        (e nil))
    (when *graphing* (create-map-window "depth first search with duplicate node detection"))
    (loop until (or (null node-list) ;;no more states
                    solved)
          do (setq e (first node-list))
          (update-statistics *stats* e node-list)
          (SETQ VISITED (CONS (NODE-STATE E) VISITED)) ;;ADD E to VISITED
          (when *trace-search*
            (format t "~%~%Exploring ~a" e))
          (setq node-list (rest node-list))
          (cond ((solution-state? (node-state e)) 
                 ;;if e is a solution, exit with success  
                 (setq solved t))
                (t ;;otherwise add successors to the front of node-list
                 (setq successors nil)
                 (loop for rule in operators 
                       do (setq next-node (successor-node e rule))
                       (when (and next-node
                                  (NOT (ALREADY-VISITED? (NODE-STATE NEXT-NODE) VISITED)))
                         (setq successors (add-to-end next-node successors))))
                 (setq node-list (append successors node-list)))
                ))
    (when solved
      (setf (search-statistics-length-of-solution *stats*)
            (length (node-path e)))
      (when *graphing*
        (draw-solution (cons *start-state* (node-path e))))
      e)))   

(defun already-visited? (state visited)
  (member state visited :test #'equalp))


(defvar *search-methods* nil "Used by Search Menu")
(unless (member 'breadth-first-search *search-methods*)
  (setf *search-methods* (cons 'breadth-first-search *search-methods*)))
(unless (member 'depth-first-search *search-methods*)
  (setf *search-methods* (cons 'depth-first-search *search-methods*)))
(unless (member 'depth-first-search-with-duplicate-node-detection *search-methods*)
  (setf *search-methods* (cons 'depth-first-search-with-duplicate-node-detection *search-methods*)))
(unless (member 'depth-first-search-with-depth-limit *search-methods*)
  (setf *search-methods* (cons 'depth-first-search-with-depth-limit *search-methods*)))



;;Revision History
;;changed next-node next-state to successor-node successor-state
;;changed stats to global
;;use add-to-end to accumulate operators
;;return Node
 
