\ vim: ft=forth fdm=marker

private{

0 value toshell-fid
0 value fromshell-fid

: gthrow  ( ior addr u -- )  2 pick  if  type ." ; cli error " dup . cr throw  else  2drop drop  then  ;

: >shell  ( addr u -- )  toshell-fid write-file s" >shell error" gthrow  ;
: >shell-ln  ( addr u -- )  toshell-fid write-line s" >shell-ln error" gthrow  ;
: shell-ln>  ( addr u -- )  dup >r fromshell-fid read-line s" shell> error" gthrow drop r> min  ;

}private

: >shell!  ( addr u -- )  w/o open-file s" >shell! error" gthrow to toshell-fid  ;
: shell>!  ( addr u -- )  r/o open-file s" shell>! error" gthrow to fromshell-fid  ;

: -shell  ( -- )
    toshell-fid ?dup  if  close-file s" -shell error 1" gthrow  then
    fromshell-fid ?dup  if  close-file s" -shell error 2" gthrow  then  ;

: main  ( -- )
    ." hello, world!" cr  ;

privatize

