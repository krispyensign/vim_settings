syn match Operator	"\(<<\|>>\|[-+*/%&^|<>!=]\)="
syn match Operator	"<<\|>>\|&&\|||\|++\|--\|->"
syn match Operator	"[.!~*&%<>^|=,+-;]"
syn match Operator	"/[^/*=]"me=e-1
syn match Operator	"/$"
syn match Operator "&&\|||"
syn match Operator	"[][]"

hi! link Type GruvboxRed
hi! link Class GruvboxOrangeBold
hi! link DefinedName GruvboxGreen
hi! link EnumerationValue GruvboxGreenBold
hi! link Function GruvboxYellow
hi! link Enumeration GruvboxYellowBold
hi! link EnumerationName GruvboxYellowBold
hi! link Constant GruvboxBlue
hi! link LocalVariable GruvBoxBlueBold
hi! link Member GruvboxPurple
hi! link Namespace GruvboxPurpleBold
hi! link Function GruvboxAqua
hi! link Structure GruvboxAquaBold
hi! link Union GruvboxOrange
hi! link GlobalVariable GruvboxOrangeBold
hi! link Extern GruvboxGray
hi Operator guifg=RoyalBlue3
