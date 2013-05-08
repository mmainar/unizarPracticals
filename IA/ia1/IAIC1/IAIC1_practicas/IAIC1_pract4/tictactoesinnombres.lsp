
#|-----------------------------------------------------------------------------
Artificial Intelligence, Second Edition
Elaine Rich and Kevin Knight
McGraw Hill, 1991

This code may be freely copied and used for educational or research purposes.
All software written by Kevin Knight.
Comments, bugs, improvements to knight@cs.cmu.edu

    26-11-97   muro   modificado para quitar los nombres de funciones para la practica 4
----------------------------------------------------------------------------|#

#|----------------------------------------------------------------------------
                            TIC-TAC-TOE GAME
                            "tictactoe.lisp"
----------------------------------------------------------------------------|#

#|-----------------------------------------------------------------------------

This file contains code for the game of tic-tac-toe.
The important functions are:

 (deep-enough pos depth)        t if the search has proceeded deep enough.
 (static pos player)                evaluation of position pos from player's 
                                 point of view.
 (movegen pos player)                generate all successor positions to pos.
 (opposite player)                return the opposite player.
 (print-board pos)                print board position pos.
 (make-move pos player move)        return new position based on old position and 
                                 player's move.
 (won? pos player)                t if player has won.
 (drawn? pos)                         t if pos is a drawn position.

The important variables are:

 *start*                        the initial board configuration.

These functions and variables are all called from minimax.lisp.

----------------------------------------------------------------------------|#

;; Function NULL-BOARD creates an empty tic-tac-toe board. The board is 
;; stored as a list of nine elements.  Elements are either 'x, 'o, or nil 
;; (empty).

(defun null-board ()
  (list nil nil nil nil nil nil nil nil nil))

;; Variable *START* is the starting board position.

(defvar *start* nil)
(setq *start* (null-board))


;; Function ?????????? takes a board position (pos), a player (player, which 
;; is 'x or 'o), and a move (which is a number between 0 and 8). It returns 
;; a new board position.

(defun ?????????? (pos player move)
  (unless (nth move pos)  
    (let ((b (copy-list pos)))
      (setf (nth move b) player) 
      b)))


;; Function ?????????? takes a position and a player and generates all legal 
;; successor positions, i.e., all possible moves a player could make.

(defun ?????????? (pos player)
  (loop for m from 0 to 8
        unless  (nth m pos)
        collect (make-move pos player m)))
    

;; Function ?????????? returns t is pos is a winning position for player,
;; nil otherwise.

(defun ?????????? (pos player)
  (setq player (opposite player))
  (or (and (eq (first pos) player)
           (eq (second pos) player)
           (eq (third pos) player))
      (and (eq (fourth pos) player)
           (eq (fifth pos) player) 
           (eq (sixth pos) player))
      (and (eq (seventh pos) player) 
           (eq (eighth pos) player) 
           (eq (ninth pos) player))
      (and (eq (first pos) player) 
           (eq (fourth pos) player) 
           (eq (seventh pos) player))
      (and (eq (second pos) player) 
           (eq (fifth pos) player) 
           (eq (eighth pos) player))
      (and (eq (third pos) player) 
           (eq (sixth pos) player) 
           (eq (ninth pos) player))
      (and (eq (first pos) player) 
           (eq (fifth pos) player) 
           (eq (ninth pos) player))
      (and (eq (third pos) player) 
           (eq (fifth pos) player) 
           (eq (seventh pos) player))))

;; Function ?????????? returns t if pos is a drawn position, i.e., if there are
;; no more moves to be made.

(defun ?????????? (pos)
  (not (member nil pos)))


;; Function ?????????? returns 'x when given 'o, and vice-versa.

(defun ?????????? (player)
  (if (eq player 'x) 'o 'x))


;; Function ?????????? evaluates a position from the point of view of a 
;; particular player.  It returns a number -- the higher the number, the
;; more desirable the position.  The simplest static function would be:
;;
;;        (defun ?????????? (pos player)
;;          (cond ((won? pos player) 1)
;;                ((won? pos (opposite player)) -1)
;;                (t 0)))
;;
;; However, this heuristic suffers from the problem that minimax search 
;; will not "go in for the kill" in a won position.  The following static 
;; function weighs quick wins more highly than slower ones; it also 
;; ranks quick losses more negatively than slower ones, allowing the
;; program to "fight on" in a lost position.

(defun ?????????? (pos player)
  (cond ((won? pos player) 
         (+ 1 (/ 1 (length (remove nil pos)))))
        ((won? pos (opposite player)) 
         (- (+ 1 (/ 1 (length (remove nil pos))))))
        (t 0)))


;; Function ?????????? takes a board position and a depth and returns
;; t if the search has proceeded deep enough.  The implementation below 
;; causes the search to proceed all the way to a finished position.  Thus,
;; minimax search will examine the whole search space and never make a
;; wrong move.  A depth-limited search might look like:
;;
;;         (defun ?????????? (pos depth)
;;          (declare (ignore pos))
;;          (if (> depth 3) t nil))

(defun ?????????? (pos depth)
  (declare (ignore depth))
  (or (won? pos 'x) 
      (won? pos 'o)
      (drawn? pos)))


;; Function ?????????? prints a two-dimensional representation of the board.

(defun ?????????? (b)
  (format t "~% ~d ~d ~d   0 1 2~% ~d ~d ~d   3 4 5~% ~d ~d ~d   6 7 8~%~%"
          (or (first b) ".") (or (second b) ".") (or (third b) ".")
          (or (fourth b) ".") (or (fifth b) ".") (or (sixth b) ".")
          (or (seventh b) ".") (or (eighth b) ".") (or (ninth b) ".")))




