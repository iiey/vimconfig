" Tomorrow Night - Full Colour and 256 Colour
" http://chriskempson.com

" Color definitions
" [GUI, 256-color, 88-color]
let s:foreground = ["c5c8c6", 250, 86]
let s:background = ["1d1f21", 16, 80]
let s:selection = ["373b41", 16, 80]
let s:line = ["282a2e", 16, 80]
let s:comment = ["969896", 245, 84]
let s:red = ["cc6666", 167, 53]
let s:orange = ["de935f", 173, 53]
let s:yellow = ["f0c674", 222, 73]
let s:green = ["b5bd68", 143, 57]
let s:aqua = ["8abeb7", 109, 42]
let s:blue = ["81a2be", 109, 38]
let s:purple = ["b294bb", 139, 54]
let s:window = ["4d5057", 59, 81]
let s:diffAdd = ["4c4e39", 58, 36]
let s:diffChange = ["2B5B77", 24, 21]

" Console 256 Colours
if !has("gui_running")
	let s:background = ["303030", 235, 80]
	let s:window = ["5e5e5e", 240, 81]
	let s:line = ["3a3a3a", 236, 80]
	let s:selection = ["585858", 239, 81]
end

hi clear
hi clear CursorLineNr
syntax reset

let g:colors_name = "tomorrow-night"

if has("gui_running") || &t_Co == 88 || &t_Co == 256

	" Sets the highlighting for the given group
	fun <SID>X(group, fg, bg, attr)
		if len(a:fg) != 0
			exec "hi " . a:group . " guifg=#" . a:fg[0] . " ctermfg=" . (&t_Co == 88 ? a:fg[2] : a:fg[1])
		endif
		if len(a:bg) != 0
			exec "hi " . a:group . " guibg=#" . a:bg[0] . " ctermbg=" . (&t_Co == 88 ? a:bg[2] : a:bg[1])
		endif
		if a:attr != ""
			exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
		endif
	endfun

	" Vim Highlighting
	call <SID>X("Normal", s:foreground, s:background, "")
	call <SID>X("LineNr", s:selection, [], "")
	call <SID>X("NonText", s:selection, [], "")
	call <SID>X("SpecialKey", s:selection, [], "")
	call <SID>X("Search", s:background, s:yellow, "")
	call <SID>X("TabLine", s:window, s:foreground, "reverse")
	call <SID>X("TabLineFill", s:window, s:foreground, "reverse")
	call <SID>X("StatusLine", s:window, s:yellow, "reverse")
	call <SID>X("StatusLineNC", s:window, s:foreground, "reverse")
	call <SID>X("VertSplit", s:window, s:window, "none")
	call <SID>X("Visual", [], s:selection, "")
	call <SID>X("Directory", s:blue, [], "")
	call <SID>X("ModeMsg", s:green, [], "")
	call <SID>X("MoreMsg", s:green, [], "")
	call <SID>X("Question", s:green, [], "")
	call <SID>X("WarningMsg", s:red, [], "")
	call <SID>X("MatchParen", [], s:selection, "")
	call <SID>X("Folded", s:comment, s:background, "")
	call <SID>X("FoldColumn", [], s:background, "")
	if version >= 700
		call <SID>X("CursorLine", [], s:line, "none")
		call <SID>X("CursorColumn", [], s:line, "none")
		call <SID>X("PMenu", s:foreground, s:selection, "none")
		call <SID>X("PMenuSel", s:foreground, s:selection, "reverse")
		call <SID>X("SignColumn", [], s:background, "none")
	end
	if version >= 703
		call <SID>X("ColorColumn", [], s:line, "none")
	end

	" Standard Highlighting
	call <SID>X("Comment", s:comment, [], "")
	call <SID>X("Todo", s:comment, s:background, "")
	call <SID>X("Title", s:comment, [], "")
	call <SID>X("Identifier", s:red, [], "none")
	call <SID>X("Statement", s:foreground, [], "")
	call <SID>X("Conditional", s:foreground, [], "")
	call <SID>X("Repeat", s:foreground, [], "")
	call <SID>X("Structure", s:purple, [], "")
	call <SID>X("Function", s:blue, [], "")
	call <SID>X("Constant", s:orange, [], "")
	call <SID>X("Keyword", s:orange, [], "")
	call <SID>X("String", s:green, [], "")
	call <SID>X("Special", s:foreground, [], "")
	call <SID>X("PreProc", s:purple, [], "")
	call <SID>X("Operator", s:aqua, [], "none")
	call <SID>X("Type", s:blue, [], "none")
	call <SID>X("Define", s:purple, [], "none")
	call <SID>X("Include", s:blue, [], "")
	"call <SID>X("Ignore", "666666", [], "")

	" Vim Highlighting
	call <SID>X("vimCommand", s:red, [], "none")

	" C Highlighting
	call <SID>X("cType", s:yellow, [], "")
	call <SID>X("cStorageClass", s:purple, [], "")
	call <SID>X("cConditional", s:purple, [], "")
	call <SID>X("cRepeat", s:purple, [], "")

	" PHP Highlighting
	call <SID>X("phpVarSelector", s:red, [], "")
	call <SID>X("phpKeyword", s:purple, [], "")
	call <SID>X("phpRepeat", s:purple, [], "")
	call <SID>X("phpConditional", s:purple, [], "")
	call <SID>X("phpStatement", s:purple, [], "")
	call <SID>X("phpMemberSelector", s:foreground, [], "")

	" Ruby Highlighting
	call <SID>X("rubySymbol", s:green, [], "")
	call <SID>X("rubyConstant", s:yellow, [], "")
	call <SID>X("rubyAccess", s:yellow, [], "")
	call <SID>X("rubyAttribute", s:blue, [], "")
	call <SID>X("rubyInclude", s:blue, [], "")
	call <SID>X("rubyLocalVariableOrMethod", s:orange, [], "")
	call <SID>X("rubyCurlyBlock", s:orange, [], "")
	call <SID>X("rubyStringDelimiter", s:green, [], "")
	call <SID>X("rubyInterpolationDelimiter", s:orange, [], "")
	call <SID>X("rubyConditional", s:purple, [], "")
	call <SID>X("rubyRepeat", s:purple, [], "")
	call <SID>X("rubyControl", s:purple, [], "")
	call <SID>X("rubyException", s:purple, [], "")

	" Crystal Highlighting
	call <SID>X("crystalSymbol", s:green, [], "")
	call <SID>X("crystalConstant", s:yellow, [], "")
	call <SID>X("crystalAccess", s:yellow, [], "")
	call <SID>X("crystalAttribute", s:blue, [], "")
	call <SID>X("crystalInclude", s:blue, [], "")
	call <SID>X("crystalLocalVariableOrMethod", s:orange, [], "")
	call <SID>X("crystalCurlyBlock", s:orange, [], "")
	call <SID>X("crystalStringDelimiter", s:green, [], "")
	call <SID>X("crystalInterpolationDelimiter", s:orange, [], "")
	call <SID>X("crystalConditional", s:purple, [], "")
	call <SID>X("crystalRepeat", s:purple, [], "")
	call <SID>X("crystalControl", s:purple, [], "")
	call <SID>X("crystalException", s:purple, [], "")

	" Python Highlighting
	call <SID>X("pythonInclude", s:purple, [], "")
	call <SID>X("pythonStatement", s:purple, [], "")
	call <SID>X("pythonConditional", s:purple, [], "")
	call <SID>X("pythonRepeat", s:purple, [], "")
	call <SID>X("pythonException", s:purple, [], "")
	call <SID>X("pythonFunction", s:blue, [], "")
	call <SID>X("pythonPreCondit", s:purple, [], "")
	call <SID>X("pythonRepeat", s:aqua, [], "")
	call <SID>X("pythonExClass", s:orange, [], "")

	" Go Highlighting
	call <SID>X("goStatement", s:purple, [], "")
	call <SID>X("goConditional", s:purple, [], "")
	call <SID>X("goRepeat", s:purple, [], "")
	call <SID>X("goException", s:purple, [], "")
	call <SID>X("goDeclaration", s:blue, [], "")
	call <SID>X("goConstants", s:yellow, [], "")
	call <SID>X("goBuiltins", s:orange, [], "")

	" CoffeeScript Highlighting
	call <SID>X("coffeeKeyword", s:purple, [], "")
	call <SID>X("coffeeConditional", s:purple, [], "")

	" JavaScript Highlighting
	call <SID>X("javaScriptBraces", s:foreground, [], "")
	call <SID>X("javaScriptFunction", s:purple, [], "")
	call <SID>X("javaScriptConditional", s:purple, [], "")
	call <SID>X("javaScriptRepeat", s:purple, [], "")
	call <SID>X("javaScriptNumber", s:orange, [], "")
	call <SID>X("javaScriptMember", s:orange, [], "")
	call <SID>X("javaScriptTemplateVar", s:red, [], "")
	call <SID>X("javaScriptTemplateDelim", s:orange, [], "")
	call <SID>X("javaScriptTemplateString", s:green, [], "")
	call <SID>X("javascriptNull", s:orange, [], "")
	call <SID>X("javascriptGlobal", s:blue, [], "")
	call <SID>X("javascriptStatement", s:red, [], "")

	" CoffeeScript Highlighting
	call <SID>X("coffeeRepeat", s:purple, [], "")
	call <SID>X("coffeeConditional", s:purple, [], "")
	call <SID>X("coffeeKeyword", s:purple, [], "")
	call <SID>X("coffeeObject", s:yellow, [], "")

	" HTML Highlighting
	call <SID>X("htmlTag", s:red, [], "")
	call <SID>X("htmlTagName", s:red, [], "")
	call <SID>X("htmlArg", s:red, [], "")
	call <SID>X("htmlScriptTag", s:red, [], "")

	" Diff Highlighting
	call <SID>X("diffAdd", [], s:diffAdd, "")
	call <SID>X("diffDelete", s:background, s:red, "")
	call <SID>X("diffChange", [], s:diffChange, "")
	call <SID>X("diffText", s:line, s:blue, "")

	" ShowMarks Highlighting
	call <SID>X("ShowMarksHLl", s:orange, s:background, "none")
	call <SID>X("ShowMarksHLo", s:purple, s:background, "none")
	call <SID>X("ShowMarksHLu", s:yellow, s:background, "none")
	call <SID>X("ShowMarksHLm", s:aqua, s:background, "none")

	" Lua Highlighting
	call <SID>X("luaStatement", s:purple, [], "")
	call <SID>X("luaRepeat", s:purple, [], "")
	call <SID>X("luaCondStart", s:purple, [], "")
	call <SID>X("luaCondElseif", s:purple, [], "")
	call <SID>X("luaCond", s:purple, [], "")
	call <SID>X("luaCondEnd", s:purple, [], "")

	" Cucumber Highlighting
	call <SID>X("cucumberGiven", s:blue, [], "")
	call <SID>X("cucumberGivenAnd", s:blue, [], "")

	" Go Highlighting
	call <SID>X("goDirective", s:purple, [], "")
	call <SID>X("goDeclaration", s:purple, [], "")
	call <SID>X("goStatement", s:purple, [], "")
	call <SID>X("goConditional", s:purple, [], "")
	call <SID>X("goConstants", s:orange, [], "")
	call <SID>X("goTodo", s:yellow, [], "")
	call <SID>X("goDeclType", s:blue, [], "")
	call <SID>X("goBuiltins", s:purple, [], "")
	call <SID>X("goRepeat", s:purple, [], "")
	call <SID>X("goLabel", s:purple, [], "")

	" Clojure Highlighting
	call <SID>X("clojureConstant", s:orange, [], "")
	call <SID>X("clojureBoolean", s:orange, [], "")
	call <SID>X("clojureCharacter", s:orange, [], "")
	call <SID>X("clojureKeyword", s:green, [], "")
	call <SID>X("clojureNumber", s:orange, [], "")
	call <SID>X("clojureString", s:green, [], "")
	call <SID>X("clojureRegexp", s:green, [], "")
	call <SID>X("clojureParen", s:aqua, [], "")
	call <SID>X("clojureVariable", s:yellow, [], "")
	call <SID>X("clojureCond", s:blue, [], "")
	call <SID>X("clojureDefine", s:purple, [], "")
	call <SID>X("clojureException", s:red, [], "")
	call <SID>X("clojureFunc", s:blue, [], "")
	call <SID>X("clojureMacro", s:blue, [], "")
	call <SID>X("clojureRepeat", s:blue, [], "")
	call <SID>X("clojureSpecial", s:purple, [], "")
	call <SID>X("clojureQuote", s:blue, [], "")
	call <SID>X("clojureUnquote", s:blue, [], "")
	call <SID>X("clojureMeta", s:blue, [], "")
	call <SID>X("clojureDeref", s:blue, [], "")
	call <SID>X("clojureAnonArg", s:blue, [], "")
	call <SID>X("clojureRepeat", s:blue, [], "")
	call <SID>X("clojureDispatch", s:blue, [], "")

	" Scala Highlighting
	call <SID>X("scalaKeyword", s:purple, [], "")
	call <SID>X("scalaKeywordModifier", s:purple, [], "")
	call <SID>X("scalaOperator", s:blue, [], "")
	call <SID>X("scalaPackage", s:red, [], "")
	call <SID>X("scalaFqn", s:foreground, [], "")
	call <SID>X("scalaFqnSet", s:foreground, [], "")
	call <SID>X("scalaImport", s:purple, [], "")
	call <SID>X("scalaBoolean", s:orange, [], "")
	call <SID>X("scalaDef", s:purple, [], "")
	call <SID>X("scalaVal", s:purple, [], "")
	call <SID>X("scalaVar", s:aqua, [], "")
	call <SID>X("scalaClass", s:purple, [], "")
	call <SID>X("scalaObject", s:purple, [], "")
	call <SID>X("scalaTrait", s:purple, [], "")
	call <SID>X("scalaDefName", s:blue, [], "")
	call <SID>X("scalaValName", s:foreground, [], "")
	call <SID>X("scalaVarName", s:foreground, [], "")
	call <SID>X("scalaClassName", s:foreground, [], "")
	call <SID>X("scalaType", s:yellow, [], "")
	call <SID>X("scalaTypeSpecializer", s:yellow, [], "")
	call <SID>X("scalaAnnotation", s:orange, [], "")
	call <SID>X("scalaNumber", s:orange, [], "")
	call <SID>X("scalaDefSpecializer", s:yellow, [], "")
	call <SID>X("scalaClassSpecializer", s:yellow, [], "")
	call <SID>X("scalaBackTick", s:green, [], "")
	call <SID>X("scalaRoot", s:foreground, [], "")
	call <SID>X("scalaMethodCall", s:blue, [], "")
	call <SID>X("scalaCaseType", s:yellow, [], "")
	call <SID>X("scalaLineComment", s:comment, [], "")
	call <SID>X("scalaComment", s:comment, [], "")
	call <SID>X("scalaDocComment", s:comment, [], "")
	call <SID>X("scalaDocTags", s:comment, [], "")
	call <SID>X("scalaEmptyString", s:green, [], "")
	call <SID>X("scalaMultiLineString", s:green, [], "")
	call <SID>X("scalaUnicode", s:orange, [], "")
	call <SID>X("scalaString", s:green, [], "")
	call <SID>X("scalaStringEscape", s:green, [], "")
	call <SID>X("scalaSymbol", s:orange, [], "")
	call <SID>X("scalaChar", s:orange, [], "")
	call <SID>X("scalaXml", s:green, [], "")
	call <SID>X("scalaConstructorSpecializer", s:yellow, [], "")
	call <SID>X("scalaBackTick", s:blue, [], "")

	" Git
	call <SID>X("diffAdded", s:green, [], "")
	call <SID>X("diffRemoved", s:red, [], "")
	call <SID>X("gitcommitSummary", [], [], "bold")

	" Delete Functions
	delf <SID>X
endif

set background=dark
