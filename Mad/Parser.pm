########################################################################################
#
#    This file was generated using Parse::Eyapp version 1.165.
#
# (c) Parse::Yapp Copyright 1998-2001 Francois Desarmenien.
# (c) Parse::Eyapp Copyright 2006-2008 Casiano Rodriguez-Leon. Universidad de La Laguna.
#        Don't edit this file, use source file 'Parser.eyp' instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
########################################################################################
package Mad::Parser;
use strict;

push @Mad::Parser::ISA, 'Parse::Eyapp::Driver';




BEGIN {
  # This strange way to load the modules is to guarantee compatibility when
  # using several standalone and non-standalone Eyapp parsers

  require Parse::Eyapp::Driver unless Parse::Eyapp::Driver->can('YYParse');
  require Parse::Eyapp::Node unless Parse::Eyapp::Node->can('hnew'); 
}
  

# Default lexical analyzer
our $LEX = sub {
    my $self = shift;

    for (${$self->input}) {
      

      m{\G(\s+)}gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(FLOWRIGHT|ASSIGNOP|loopword|FLOWLEFT|FUNCTION|YADAYADA|FOREACH|INCLUDE|perlseq|PACKAGE|progseg|DORDOR|UNLESS|ACROSS|ANDAND|RETURN|DOTDOT|ANDOP|FINAL|RELOP|INCOP|ADDOP|MULOP|CONST|XOROP|POWOP|NOTOP|ELSIF|STEP|ELSE|OROP|UNIT|OROR|WORD|PERL|NOT2|FUNC|INIT|CALC|FOR|STR|USE|NUM|DOT|VAR|\%\}|\%\{|MY|\$\^|IF|\:|\}|\<|\@|\%|\[|\,|\)|\?|\{|\$|\]|\(|\>|\;|\=)}gc and return ($1, $1);



      return ('', undef) if ($_ eq '') || (defined(pos($_)) && (pos($_) >= length($_)));
      /\G\s*(\S+)/;
      my $near = substr($1,0,10); 
      die( "Error inside the lexical analyzer near '". $near
          ."'. Line: ".$self->line()
          .". File: '".$self->YYFilename()."'. No match found.\n");
    }
  }
;


sub unexpendedInput { defined($_) ? substr($_, (defined(pos $_) ? pos $_ : 0)) : '' }

#line 2 "Parser.eyp"

use Mad::Model qw(:vartypes :phases);
use Mad::ParserAux;


#line 61 Parser.pm

my $warnmessage =<< "EOFWARN";
Warning!: Did you changed the \@Mad::Parser::ISA variable inside the header section of the eyapp program?
EOFWARN

sub new {
  my($class)=shift;
  ref($class) and $class=ref($class);

  warn $warnmessage unless __PACKAGE__->isa('Parse::Eyapp::Driver'); 
  my($self)=$class->SUPER::new( 
    yyversion => '1.165',
    yyGRAMMAR  =>
[
  [ '_SUPERSTART' => '$start', [ 'program', '$end' ], 0 ],
  [ 'program_1' => 'program', [ 'progstart', 'progseq' ], 0 ],
  [ 'progseq_2' => 'progseq', [  ], 0 ],
  [ 'progseq_3' => 'progseq', [ 'progseq', 'tl_decl' ], 0 ],
  [ 'progseq_4' => 'progseq', [ 'progseq', 'tl_across' ], 0 ],
  [ 'progseq_5' => 'progseq', [ 'progseq', 'block' ], 0 ],
  [ 'progseq_6' => 'progseq', [ 'progseg', 'perlblock' ], 0 ],
  [ 'progseq_7' => 'progseq', [ 'progseq', 'phaseblock' ], 0 ],
  [ 'progseq_8' => 'progseq', [ 'progseq', 'flow' ], 0 ],
  [ 'progseq_9' => 'progseq', [ 'progseq', 'line' ], 0 ],
  [ 'progstart_10' => 'progstart', [  ], 0 ],
  [ 'tl_decl_11' => 'tl_decl', [ 'include' ], 0 ],
  [ 'tl_decl_12' => 'tl_decl', [ 'use' ], 0 ],
  [ 'tl_decl_13' => 'tl_decl', [ 'unit' ], 0 ],
  [ 'tl_decl_14' => 'tl_decl', [ 'function' ], 0 ],
  [ 'include_15' => 'include', [ 'INCLUDE', 'WORD', ';' ], 0 ],
  [ 'include_16' => 'include', [ 'INCLUDE', 'STR', ';' ], 0 ],
  [ 'use_17' => 'use', [ 'USE', 'WORD', ';' ], 0 ],
  [ 'unit_18' => 'unit', [ 'UNIT', 'unitdecl', ';' ], 0 ],
  [ 'unitdecl_19' => 'unitdecl', [ 'WORD' ], 0 ],
  [ 'unitdecl_20' => 'unitdecl', [ 'unitdecl', ',', 'WORD' ], 0 ],
  [ 'function_21' => 'function', [ 'FUNCTION', 'FUNC', '(', 'params', ')', 'unitopt', ';' ], 0 ],
  [ 'function_22' => 'function', [ 'FUNCTION', 'FUNC', '(', 'params', ')', 'unitopt', '{', '@22-7', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@22-7', [  ], 0 ],
  [ 'function_24' => 'function', [ 'PERL', 'FUNCTION', 'FUNC', '(', 'params', ')', 'unitopt', ';' ], 0 ],
  [ 'function_25' => 'function', [ 'PERL', 'FUNCTION', 'FUNC', '(', 'params', ')', 'unitopt', '{', '@25-8', 'perlseq', '}' ], 0 ],
  [ '_CODE' => '@25-8', [  ], 0 ],
  [ 'params_27' => 'params', [  ], 0 ],
  [ 'params_28' => 'params', [ 'paramlist' ], 0 ],
  [ 'paramlist_29' => 'paramlist', [ 'param' ], 0 ],
  [ 'paramlist_30' => 'paramlist', [ 'paramlist', ',', 'param' ], 0 ],
  [ 'param_31' => 'param', [ 'scalar' ], 0 ],
  [ 'unitopt_32' => 'unitopt', [  ], 0 ],
  [ 'unitopt_33' => 'unitopt', [ 'unitspec' ], 0 ],
  [ 'unitspec_34' => 'unitspec', [ '<', 'unitlist', '>' ], 0 ],
  [ 'unitspec_35' => 'unitspec', [ 'error', '>' ], 0 ],
  [ 'unitlist_36' => 'unitlist', [  ], 0 ],
  [ 'unitlist_37' => 'unitlist', [ 'unitlist', 'UNIT' ], 0 ],
  [ 'tl_across_38' => 'tl_across', [ 'ACROSS', 'dimlist', '{', '@38-3', 'progseq', '}' ], 0 ],
  [ '_CODE' => '@38-3', [  ], 0 ],
  [ 'stmtseq_40' => 'stmtseq', [  ], 0 ],
  [ 'stmtseq_41' => 'stmtseq', [ 'stmtseq', 'across' ], 0 ],
  [ 'stmtseq_42' => 'stmtseq', [ 'stmtseq', 'block' ], 0 ],
  [ 'stmtseq_43' => 'stmtseq', [ 'stmtseq', 'perlblock' ], 0 ],
  [ 'stmtseq_44' => 'stmtseq', [ 'stmtseq', 'phaseblock' ], 0 ],
  [ 'stmtseq_45' => 'stmtseq', [ 'stmtseq', 'line' ], 0 ],
  [ 'block_46' => 'block', [ '{', '@46-1', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@46-1', [  ], 0 ],
  [ 'perlblock_48' => 'perlblock', [ 'PERL', '{', '@48-2', 'perlseq', '}' ], 0 ],
  [ '_CODE' => '@48-2', [  ], 0 ],
  [ 'perlblock_50' => 'perlblock', [ '%{', '@50-1', 'perlseq', '%}' ], 0 ],
  [ '_CODE' => '@50-1', [  ], 0 ],
  [ 'phaseblock_52' => 'phaseblock', [ 'phase', '{', '@52-2', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@52-2', [  ], 0 ],
  [ 'phase_54' => 'phase', [ 'INIT' ], 0 ],
  [ 'phase_55' => 'phase', [ 'CALC' ], 0 ],
  [ 'phase_56' => 'phase', [ 'STEP' ], 0 ],
  [ 'phase_57' => 'phase', [ 'FINAL' ], 0 ],
  [ 'line_58' => 'line', [ 'phase', '@58-1', 'sideff', ';' ], 0 ],
  [ '_CODE' => '@58-1', [  ], 0 ],
  [ 'line_60' => 'line', [ 'package' ], 0 ],
  [ 'line_61' => 'line', [ 'cond' ], 0 ],
  [ 'line_62' => 'line', [ 'loop' ], 0 ],
  [ 'line_63' => 'line', [ 'sideff', ';' ], 0 ],
  [ 'line_64' => 'line', [ 'VAR', 'vardecl', ';' ], 0 ],
  [ 'line_65' => 'line', [ 'CONST', 'vardecl', '=', '@65-3', 'expr', ';' ], 0 ],
  [ '_CODE' => '@65-3', [  ], 0 ],
  [ 'vardecl_67' => 'vardecl', [ 'simplevar', 'unitopt' ], 0 ],
  [ 'vardecl_68' => 'vardecl', [ 'simplevar', 'dimspec', 'unitopt' ], 0 ],
  [ 'package_69' => 'package', [ 'PACKAGE', 'WORD', ';' ], 0 ],
  [ 'across_70' => 'across', [ 'ACROSS', 'dimlist', '{', '@70-3', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@70-3', [  ], 0 ],
  [ 'dimlist_72' => 'dimlist', [ 'dimspec' ], 0 ],
  [ 'dimlist_73' => 'dimlist', [ 'dimlist', 'dimspec' ], 0 ],
  [ 'dimspec_74' => 'dimspec', [ '[', 'label', 'array', ']' ], 0 ],
  [ 'dimspec_75' => 'dimspec', [ '[', 'label', 'set', ']' ], 0 ],
  [ 'label_76' => 'label', [  ], 0 ],
  [ 'label_77' => 'label', [ 'WORD', ':' ], 0 ],
  [ 'sideff_78' => 'sideff', [ 'expr' ], 0 ],
  [ 'sideff_79' => 'sideff', [ 'expr', 'IF', 'expr' ], 0 ],
  [ 'sideff_80' => 'sideff', [ 'expr', 'UNLESS', 'expr' ], 0 ],
  [ 'cond_81' => 'cond', [ 'condword', '(', '@81-2', 'expr', ')', '{', 'stmtseq', '}', 'else' ], 0 ],
  [ '_CODE' => '@81-2', [  ], 0 ],
  [ 'condword_83' => 'condword', [ 'IF' ], 0 ],
  [ 'condword_84' => 'condword', [ 'UNLESS' ], 0 ],
  [ 'else_85' => 'else', [  ], 0 ],
  [ 'else_86' => 'else', [ 'ELSE', '{', '@86-2', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@86-2', [  ], 0 ],
  [ 'else_88' => 'else', [ 'ELSIF', '(', '@88-2', 'expr', ')', '{', 'stmtseq', '}', 'else' ], 0 ],
  [ '_CODE' => '@88-2', [  ], 0 ],
  [ 'loop_90' => 'loop', [ 'loopword', '(', '@90-2', 'expr', ')', '{', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@90-2', [  ], 0 ],
  [ 'loop_92' => 'loop', [ 'FOREACH', '@92-1', 'scalarvar', '(', 'expr', ')', '{', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@92-1', [  ], 0 ],
  [ 'loop_94' => 'loop', [ 'FOR', '(', '@94-2', 'expr', ';', 'expr', ';', 'expr', ')', '{', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@94-2', [  ], 0 ],
  [ 'expr_96' => 'expr', [ 'expr', 'ANDOP', 'expr' ], 0 ],
  [ 'expr_97' => 'expr', [ 'expr', 'OROP', 'expr' ], 0 ],
  [ 'expr_98' => 'expr', [ 'expr', 'XOROP', 'expr' ], 0 ],
  [ 'expr_99' => 'expr', [ 'NOTOP', 'expr' ], 0 ],
  [ 'expr_100' => 'expr', [ 'term' ], 0 ],
  [ 'term_101' => 'term', [ 'termbinop' ], 0 ],
  [ 'term_102' => 'term', [ 'termunop' ], 0 ],
  [ 'term_103' => 'term', [ 'term', '?', 'term', ':', 'term' ], 0 ],
  [ 'term_104' => 'term', [ '(', 'expr', ')' ], 0 ],
  [ 'term_105' => 'term', [ 'varexpr' ], 0 ],
  [ 'term_106' => 'term', [ 'dynvar' ], 0 ],
  [ 'term_107' => 'term', [ 'indexvar' ], 0 ],
  [ 'term_108' => 'term', [ 'NUM' ], 0 ],
  [ 'term_109' => 'term', [ 'STR' ], 0 ],
  [ 'term_110' => 'term', [ 'funcall' ], 0 ],
  [ 'term_111' => 'term', [ 'objname' ], 0 ],
  [ 'term_112' => 'term', [ 'RETURN', 'expr' ], 0 ],
  [ 'term_113' => 'term', [ 'term', 'unitspec' ], 0 ],
  [ 'term_114' => 'term', [ 'YADAYADA' ], 0 ],
  [ 'termbinop_115' => 'termbinop', [ 'term', 'ASSIGNOP', 'term' ], 0 ],
  [ 'termbinop_116' => 'termbinop', [ 'term', '=', 'term' ], 0 ],
  [ 'termbinop_117' => 'termbinop', [ 'term', 'ADDOP', 'term' ], 0 ],
  [ 'termbinop_118' => 'termbinop', [ 'term', 'MULOP', 'term' ], 0 ],
  [ 'termbinop_119' => 'termbinop', [ 'term', '%', 'term' ], 0 ],
  [ 'termbinop_120' => 'termbinop', [ 'term', 'POWOP', 'term' ], 0 ],
  [ 'termbinop_121' => 'termbinop', [ 'term', 'RELOP', 'term' ], 0 ],
  [ 'termbinop_122' => 'termbinop', [ 'term', 'DOTDOT', 'term' ], 0 ],
  [ 'termbinop_123' => 'termbinop', [ 'term', 'ANDAND', 'term' ], 0 ],
  [ 'termbinop_124' => 'termbinop', [ 'term', 'OROR', 'term' ], 0 ],
  [ 'termbinop_125' => 'termbinop', [ 'term', 'DORDOR', 'term' ], 0 ],
  [ 'termunop_126' => 'termunop', [ 'ADDOP', 'term' ], 0 ],
  [ 'termunop_127' => 'termunop', [ 'NOT2', 'term' ], 0 ],
  [ 'termunop_128' => 'termunop', [ 'term', 'INCOP' ], 0 ],
  [ 'termunop_129' => 'termunop', [ 'INCOP', 'term' ], 0 ],
  [ 'varexpr_130' => 'varexpr', [ 'simplevar' ], 0 ],
  [ 'varexpr_131' => 'varexpr', [ 'simplevar', 'subexpr' ], 0 ],
  [ 'varexpr_132' => 'varexpr', [ 'varexpr', 'DOT', 'WORD' ], 0 ],
  [ 'varexpr_133' => 'varexpr', [ 'varexpr', 'DOT', 'FUNC', '(', 'argexpr', ')' ], 0 ],
  [ 'dynvar_134' => 'dynvar', [ 'MY', 'simplevar' ], 0 ],
  [ 'simplevar_135' => 'simplevar', [ 'scalar' ], 0 ],
  [ 'simplevar_136' => 'simplevar', [ 'array' ], 0 ],
  [ 'simplevar_137' => 'simplevar', [ 'set' ], 0 ],
  [ 'scalarvar_138' => 'scalarvar', [ 'scalar' ], 0 ],
  [ 'scalarvar_139' => 'scalarvar', [ 'MY', 'scalar' ], 0 ],
  [ 'scalar_140' => 'scalar', [ '$', 'WORD' ], 0 ],
  [ 'array_141' => 'array', [ '@', 'WORD' ], 0 ],
  [ 'set_142' => 'set', [ '%', 'WORD' ], 0 ],
  [ 'indexvar_143' => 'indexvar', [ '$^' ], 0 ],
  [ 'indexvar_144' => 'indexvar', [ '$^', 'NUM' ], 0 ],
  [ 'indexvar_145' => 'indexvar', [ '$^', 'WORD' ], 0 ],
  [ 'subexpr_146' => 'subexpr', [ 'subspec' ], 0 ],
  [ 'subexpr_147' => 'subexpr', [ 'subexpr', 'subspec' ], 0 ],
  [ 'subspec_148' => 'subspec', [ '[', ']' ], 0 ],
  [ 'subspec_149' => 'subspec', [ '[', 'expr', ']' ], 0 ],
  [ 'funcall_150' => 'funcall', [ 'FUNC', '(', 'argexpr', ')' ], 0 ],
  [ 'funcall_151' => 'funcall', [ 'FUNC', '(', 'argexpr', ')', 'DOT', 'WORD' ], 0 ],
  [ 'objname_152' => 'objname', [ 'WORD' ], 0 ],
  [ 'argexpr_153' => 'argexpr', [  ], 0 ],
  [ 'argexpr_154' => 'argexpr', [ 'arglist' ], 0 ],
  [ 'arglist_155' => 'arglist', [ 'arg' ], 0 ],
  [ 'arglist_156' => 'arglist', [ 'argexpr', ',', 'arg' ], 0 ],
  [ 'arg_157' => 'arg', [ 'term' ], 0 ],
  [ 'arg_158' => 'arg', [ 'pair' ], 0 ],
  [ 'pair_159' => 'pair', [ 'WORD', ':', 'expr' ], 0 ],
  [ 'flow_160' => 'flow', [ 'scalar', 'MULOP', 'expr', 'FLOWRIGHT', 'scalar' ], 0 ],
  [ 'flow_161' => 'flow', [ 'scalar', 'MULOP', 'expr', 'FLOWLEFT', 'scalar' ], 0 ],
  [ 'flow_162' => 'flow', [ 'scalar', 'FLOWRIGHT', 'scalar', 'MULOP', 'expr' ], 0 ],
  [ 'flow_163' => 'flow', [ 'scalar', 'FLOWLEFT', 'scalar', 'MULOP', 'expr' ], 0 ],
  [ 'flow_164' => 'flow', [ 'scalar', '(', 'expr', ')', 'FLOWRIGHT', 'scalar' ], 0 ],
  [ 'flow_165' => 'flow', [ 'scalar', '(', 'expr', ')', 'FLOWLEFT', 'scalar' ], 0 ],
  [ 'flow_166' => 'flow', [ 'scalar', 'FLOWRIGHT', 'scalar', '(', 'expr', ')' ], 0 ],
  [ 'flow_167' => 'flow', [ 'scalar', 'FLOWLEFT', 'scalar', '(', 'expr', ')' ], 0 ],
],
    yyTERMS  =>
{ '' => { ISSEMANTIC => 0 },
	'$' => { ISSEMANTIC => 0 },
	'$^' => { ISSEMANTIC => 0 },
	'%' => { ISSEMANTIC => 0 },
	'%{' => { ISSEMANTIC => 0 },
	'%}' => { ISSEMANTIC => 0 },
	'(' => { ISSEMANTIC => 0 },
	')' => { ISSEMANTIC => 0 },
	',' => { ISSEMANTIC => 0 },
	':' => { ISSEMANTIC => 0 },
	';' => { ISSEMANTIC => 0 },
	'<' => { ISSEMANTIC => 0 },
	'=' => { ISSEMANTIC => 0 },
	'>' => { ISSEMANTIC => 0 },
	'?' => { ISSEMANTIC => 0 },
	'@' => { ISSEMANTIC => 0 },
	'[' => { ISSEMANTIC => 0 },
	']' => { ISSEMANTIC => 0 },
	'{' => { ISSEMANTIC => 0 },
	'}' => { ISSEMANTIC => 0 },
	ACROSS => { ISSEMANTIC => 1 },
	ADDOP => { ISSEMANTIC => 1 },
	ANDAND => { ISSEMANTIC => 1 },
	ANDOP => { ISSEMANTIC => 1 },
	ASSIGNOP => { ISSEMANTIC => 1 },
	CALC => { ISSEMANTIC => 1 },
	CONST => { ISSEMANTIC => 1 },
	DORDOR => { ISSEMANTIC => 1 },
	DOT => { ISSEMANTIC => 1 },
	DOTDOT => { ISSEMANTIC => 1 },
	ELSE => { ISSEMANTIC => 1 },
	ELSIF => { ISSEMANTIC => 1 },
	FINAL => { ISSEMANTIC => 1 },
	FLOWLEFT => { ISSEMANTIC => 1 },
	FLOWRIGHT => { ISSEMANTIC => 1 },
	FOR => { ISSEMANTIC => 1 },
	FOREACH => { ISSEMANTIC => 1 },
	FUNC => { ISSEMANTIC => 1 },
	FUNCTION => { ISSEMANTIC => 1 },
	IF => { ISSEMANTIC => 1 },
	INCLUDE => { ISSEMANTIC => 1 },
	INCOP => { ISSEMANTIC => 1 },
	INIT => { ISSEMANTIC => 1 },
	MULOP => { ISSEMANTIC => 1 },
	MY => { ISSEMANTIC => 1 },
	NOT2 => { ISSEMANTIC => 1 },
	NOTOP => { ISSEMANTIC => 1 },
	NUM => { ISSEMANTIC => 1 },
	OROP => { ISSEMANTIC => 1 },
	OROR => { ISSEMANTIC => 1 },
	PACKAGE => { ISSEMANTIC => 1 },
	PERL => { ISSEMANTIC => 1 },
	POWOP => { ISSEMANTIC => 1 },
	PREC_LOW => { ISSEMANTIC => 1 },
	RELOP => { ISSEMANTIC => 1 },
	RETURN => { ISSEMANTIC => 1 },
	STEP => { ISSEMANTIC => 1 },
	STR => { ISSEMANTIC => 1 },
	UMINUS => { ISSEMANTIC => 1 },
	UNIT => { ISSEMANTIC => 1 },
	UNLESS => { ISSEMANTIC => 1 },
	USE => { ISSEMANTIC => 1 },
	VAR => { ISSEMANTIC => 1 },
	WORD => { ISSEMANTIC => 1 },
	XOROP => { ISSEMANTIC => 1 },
	YADAYADA => { ISSEMANTIC => 1 },
	error => { ISSEMANTIC => 1 },
	loopword => { ISSEMANTIC => 1 },
	perlseq => { ISSEMANTIC => 1 },
	progseg => { ISSEMANTIC => 1 },
	error => { ISSEMANTIC => 0 },
},
    yyFILENAME  => 'Parser.eyp',
    yystates =>
[
	{#State 0
		DEFAULT => -10,
		GOTOS => {
			'progstart' => 1,
			'program' => 2
		}
	},
	{#State 1
		ACTIONS => {
			'WORD' => -2,
			'' => -2,
			'PACKAGE' => -2,
			"\@" => -2,
			'PERL' => -2,
			'MY' => -2,
			"%" => -2,
			"\$^" => -2,
			'UNLESS' => -2,
			'NUM' => -2,
			'STEP' => -2,
			'IF' => -2,
			"\$" => -2,
			'loopword' => -2,
			'FOREACH' => -2,
			'ACROSS' => -2,
			'NOTOP' => -2,
			'FINAL' => -2,
			'INCLUDE' => -2,
			"(" => -2,
			'VAR' => -2,
			'INCOP' => -2,
			'NOT2' => -2,
			'FOR' => -2,
			'ADDOP' => -2,
			'FUNC' => -2,
			'UNIT' => -2,
			'RETURN' => -2,
			'INIT' => -2,
			'FUNCTION' => -2,
			'STR' => -2,
			'CALC' => -2,
			"{" => -2,
			'CONST' => -2,
			'USE' => -2,
			'YADAYADA' => -2,
			'progseg' => 3
		},
		GOTOS => {
			'progseq' => 4
		}
	},
	{#State 2
		ACTIONS => {
			'' => 5
		}
	},
	{#State 3
		ACTIONS => {
			"%{" => 6,
			'PERL' => 8
		},
		GOTOS => {
			'perlblock' => 7
		}
	},
	{#State 4
		ACTIONS => {
			'' => -1,
			'WORD' => 44,
			'PACKAGE' => 45,
			"\@" => 10,
			'PERL' => 47,
			'MY' => 48,
			"%" => 12,
			"\$^" => 49,
			'UNLESS' => 13,
			'NUM' => 50,
			'STEP' => 15,
			"\$" => 52,
			'IF' => 51,
			'loopword' => 16,
			'FOREACH' => 18,
			'ACROSS' => 20,
			'NOTOP' => 54,
			'FINAL' => 23,
			'INCLUDE' => 24,
			"(" => 57,
			'VAR' => 58,
			'INCOP' => 25,
			'NOT2' => 59,
			'FOR' => 28,
			'ADDOP' => 29,
			'FUNC' => 62,
			'UNIT' => 31,
			'RETURN' => 65,
			'INIT' => 66,
			'FUNCTION' => 33,
			'STR' => 35,
			'CALC' => 68,
			"{" => 37,
			'CONST' => 38,
			'USE' => 42,
			'YADAYADA' => 69
		},
		GOTOS => {
			'scalar' => 9,
			'sideff' => 27,
			'function' => 26,
			'objname' => 11,
			'include' => 60,
			'tl_across' => 46,
			'term' => 61,
			'loop' => 14,
			'array' => 30,
			'use' => 64,
			'expr' => 63,
			'phase' => 32,
			'termbinop' => 53,
			'flow' => 17,
			'set' => 34,
			'termunop' => 19,
			'line' => 21,
			'cond' => 22,
			'dynvar' => 56,
			'phaseblock' => 55,
			'condword' => 67,
			'funcall' => 36,
			'tl_decl' => 39,
			'package' => 40,
			'varexpr' => 41,
			'unit' => 43,
			'block' => 70,
			'indexvar' => 71,
			'simplevar' => 72
		}
	},
	{#State 5
		DEFAULT => 0
	},
	{#State 6
		DEFAULT => -51,
		GOTOS => {
			'@50-1' => 73
		}
	},
	{#State 7
		DEFAULT => -6
	},
	{#State 8
		ACTIONS => {
			"{" => 74
		}
	},
	{#State 9
		ACTIONS => {
			'XOROP' => -135,
			"<" => -135,
			'DORDOR' => -135,
			";" => -135,
			'FLOWLEFT' => 75,
			'ADDOP' => -135,
			"%" => -135,
			'ANDOP' => -135,
			'UNLESS' => -135,
			'ASSIGNOP' => -135,
			'IF' => -135,
			'error' => -135,
			"[" => -135,
			'FLOWRIGHT' => 78,
			'POWOP' => -135,
			'DOT' => -135,
			"?" => -135,
			'DOTDOT' => -135,
			'MULOP' => 76,
			'OROP' => -135,
			"=" => -135,
			"(" => 77,
			'ANDAND' => -135,
			'OROR' => -135,
			'RELOP' => -135,
			'INCOP' => -135
		}
	},
	{#State 10
		ACTIONS => {
			'WORD' => 79
		}
	},
	{#State 11
		DEFAULT => -111
	},
	{#State 12
		ACTIONS => {
			'WORD' => 80
		}
	},
	{#State 13
		DEFAULT => -84
	},
	{#State 14
		DEFAULT => -62
	},
	{#State 15
		DEFAULT => -56
	},
	{#State 16
		ACTIONS => {
			"(" => 81
		}
	},
	{#State 17
		DEFAULT => -8
	},
	{#State 18
		DEFAULT => -93,
		GOTOS => {
			'@92-1' => 82
		}
	},
	{#State 19
		DEFAULT => -102
	},
	{#State 20
		ACTIONS => {
			"[" => 83
		},
		GOTOS => {
			'dimlist' => 85,
			'dimspec' => 84
		}
	},
	{#State 21
		DEFAULT => -9
	},
	{#State 22
		DEFAULT => -61
	},
	{#State 23
		DEFAULT => -57
	},
	{#State 24
		ACTIONS => {
			'WORD' => 87,
			'STR' => 86
		}
	},
	{#State 25
		ACTIONS => {
			'WORD' => 44,
			'STR' => 35,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			"(" => 57,
			'YADAYADA' => 69,
			'RETURN' => 65,
			"\$" => 52,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 89,
			'array' => 30,
			'varexpr' => 41,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 26
		DEFAULT => -14
	},
	{#State 27
		ACTIONS => {
			";" => 90
		}
	},
	{#State 28
		ACTIONS => {
			"(" => 91
		}
	},
	{#State 29
		ACTIONS => {
			'WORD' => 44,
			'STR' => 35,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			"(" => 57,
			'YADAYADA' => 69,
			'RETURN' => 65,
			"\$" => 52,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 92,
			'array' => 30,
			'varexpr' => 41,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 30
		DEFAULT => -136
	},
	{#State 31
		ACTIONS => {
			'WORD' => 94
		},
		GOTOS => {
			'unitdecl' => 93
		}
	},
	{#State 32
		ACTIONS => {
			'WORD' => -59,
			'NOT2' => -59,
			"\@" => -59,
			'ADDOP' => -59,
			'MY' => -59,
			"%" => -59,
			'FUNC' => -59,
			"\$^" => -59,
			'NUM' => -59,
			'RETURN' => -59,
			"\$" => -59,
			'STR' => -59,
			'NOTOP' => -59,
			"{" => 95,
			"(" => -59,
			'YADAYADA' => -59,
			'INCOP' => -59
		},
		GOTOS => {
			'@58-1' => 96
		}
	},
	{#State 33
		ACTIONS => {
			'FUNC' => 97
		}
	},
	{#State 34
		DEFAULT => -137
	},
	{#State 35
		DEFAULT => -109
	},
	{#State 36
		DEFAULT => -110
	},
	{#State 37
		DEFAULT => -47,
		GOTOS => {
			'@46-1' => 98
		}
	},
	{#State 38
		ACTIONS => {
			"\@" => 10,
			"\$" => 52,
			"%" => 12
		},
		GOTOS => {
			'array' => 30,
			'vardecl' => 99,
			'scalar' => 88,
			'simplevar' => 100,
			'set' => 34
		}
	},
	{#State 39
		DEFAULT => -3
	},
	{#State 40
		DEFAULT => -60
	},
	{#State 41
		ACTIONS => {
			'WORD' => -105,
			'' => -105,
			"}" => -105,
			":" => -105,
			'PACKAGE' => -105,
			'XOROP' => -105,
			"\@" => -105,
			"<" => -105,
			'DORDOR' => -105,
			'PERL' => -105,
			'MY' => -105,
			"%" => -105,
			'ANDOP' => -105,
			"\$^" => -105,
			'UNLESS' => -105,
			'NUM' => -105,
			'STEP' => -105,
			'ASSIGNOP' => -105,
			'IF' => -105,
			"\$" => -105,
			'loopword' => -105,
			'FOREACH' => -105,
			"]" => -105,
			'POWOP' => -105,
			'ACROSS' => -105,
			'NOTOP' => -105,
			'FINAL' => -105,
			'DOT' => 101,
			'OROP' => -105,
			'INCLUDE' => -105,
			"(" => -105,
			'VAR' => -105,
			'ANDAND' => -105,
			'INCOP' => -105,
			'RELOP' => -105,
			'NOT2' => -105,
			";" => -105,
			'FOR' => -105,
			'FLOWLEFT' => -105,
			'ADDOP' => -105,
			"," => -105,
			'FUNC' => -105,
			'UNIT' => -105,
			'RETURN' => -105,
			'INIT' => -105,
			'error' => -105,
			'FUNCTION' => -105,
			'FLOWRIGHT' => -105,
			")" => -105,
			'STR' => -105,
			'CALC' => -105,
			"?" => -105,
			'DOTDOT' => -105,
			'MULOP' => -105,
			"{" => -105,
			'CONST' => -105,
			"=" => -105,
			'USE' => -105,
			'YADAYADA' => -105,
			'OROR' => -105
		}
	},
	{#State 42
		ACTIONS => {
			'WORD' => 102
		}
	},
	{#State 43
		DEFAULT => -13
	},
	{#State 44
		DEFAULT => -152
	},
	{#State 45
		ACTIONS => {
			'WORD' => 103
		}
	},
	{#State 46
		DEFAULT => -4
	},
	{#State 47
		ACTIONS => {
			'FUNCTION' => 104
		}
	},
	{#State 48
		ACTIONS => {
			"\@" => 10,
			"\$" => 52,
			"%" => 12
		},
		GOTOS => {
			'array' => 30,
			'scalar' => 88,
			'simplevar' => 105,
			'set' => 34
		}
	},
	{#State 49
		ACTIONS => {
			'' => -143,
			"}" => -143,
			":" => -143,
			'WORD' => 106,
			'PACKAGE' => -143,
			'XOROP' => -143,
			"\@" => -143,
			"<" => -143,
			'DORDOR' => -143,
			'PERL' => -143,
			'MY' => -143,
			"%" => -143,
			'ANDOP' => -143,
			"\$^" => -143,
			'UNLESS' => -143,
			'NUM' => 107,
			'STEP' => -143,
			'ASSIGNOP' => -143,
			'IF' => -143,
			"\$" => -143,
			'loopword' => -143,
			'FOREACH' => -143,
			"]" => -143,
			'POWOP' => -143,
			'ACROSS' => -143,
			'NOTOP' => -143,
			'FINAL' => -143,
			'OROP' => -143,
			'INCLUDE' => -143,
			"(" => -143,
			'VAR' => -143,
			'ANDAND' => -143,
			'INCOP' => -143,
			'RELOP' => -143,
			'NOT2' => -143,
			";" => -143,
			'FOR' => -143,
			'FLOWLEFT' => -143,
			'ADDOP' => -143,
			"," => -143,
			'FUNC' => -143,
			'UNIT' => -143,
			'RETURN' => -143,
			'INIT' => -143,
			'error' => -143,
			'FUNCTION' => -143,
			'FLOWRIGHT' => -143,
			")" => -143,
			'STR' => -143,
			'CALC' => -143,
			"?" => -143,
			'DOTDOT' => -143,
			'MULOP' => -143,
			"{" => -143,
			'CONST' => -143,
			"=" => -143,
			'USE' => -143,
			'YADAYADA' => -143,
			'OROR' => -143
		}
	},
	{#State 50
		DEFAULT => -108
	},
	{#State 51
		DEFAULT => -83
	},
	{#State 52
		ACTIONS => {
			'WORD' => 108
		}
	},
	{#State 53
		DEFAULT => -101
	},
	{#State 54
		ACTIONS => {
			'WORD' => 44,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			'STR' => 35,
			'NOTOP' => 54,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 61,
			'array' => 30,
			'varexpr' => 41,
			'expr' => 109,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 55
		DEFAULT => -7
	},
	{#State 56
		DEFAULT => -106
	},
	{#State 57
		ACTIONS => {
			'WORD' => 44,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			'STR' => 35,
			'NOTOP' => 54,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 61,
			'array' => 30,
			'varexpr' => 41,
			'expr' => 110,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 58
		ACTIONS => {
			"\@" => 10,
			"\$" => 52,
			"%" => 12
		},
		GOTOS => {
			'array' => 30,
			'vardecl' => 111,
			'scalar' => 88,
			'simplevar' => 100,
			'set' => 34
		}
	},
	{#State 59
		ACTIONS => {
			'WORD' => 44,
			'STR' => 35,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			"(" => 57,
			'YADAYADA' => 69,
			'RETURN' => 65,
			"\$" => 52,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 112,
			'array' => 30,
			'varexpr' => 41,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 60
		DEFAULT => -11
	},
	{#State 61
		ACTIONS => {
			'WORD' => -100,
			'' => -100,
			"}" => -100,
			":" => -100,
			'PACKAGE' => -100,
			'XOROP' => -100,
			"\@" => -100,
			'DORDOR' => 114,
			"<" => 113,
			'PERL' => -100,
			'MY' => -100,
			"%" => 115,
			'ANDOP' => -100,
			"\$^" => -100,
			'UNLESS' => -100,
			'NUM' => -100,
			'STEP' => -100,
			'ASSIGNOP' => 116,
			'IF' => -100,
			"\$" => -100,
			'loopword' => -100,
			'FOREACH' => -100,
			"]" => -100,
			'ACROSS' => -100,
			'POWOP' => 125,
			'NOTOP' => -100,
			'FINAL' => -100,
			'OROP' => -100,
			'INCLUDE' => -100,
			"(" => -100,
			'VAR' => -100,
			'ANDAND' => 126,
			'RELOP' => 119,
			'INCOP' => 118,
			'NOT2' => -100,
			";" => -100,
			'FOR' => -100,
			'FLOWLEFT' => -100,
			'ADDOP' => 120,
			"," => -100,
			'FUNC' => -100,
			'UNIT' => -100,
			'RETURN' => -100,
			'INIT' => -100,
			'FUNCTION' => -100,
			'error' => 121,
			'FLOWRIGHT' => -100,
			")" => -100,
			'STR' => -100,
			'CALC' => -100,
			"?" => 122,
			"{" => -100,
			'DOTDOT' => 127,
			'MULOP' => 123,
			'CONST' => -100,
			"=" => 128,
			'USE' => -100,
			'YADAYADA' => -100,
			'OROR' => 124
		},
		GOTOS => {
			'unitspec' => 117
		}
	},
	{#State 62
		ACTIONS => {
			"(" => 129
		}
	},
	{#State 63
		ACTIONS => {
			'XOROP' => 133,
			";" => -78,
			'IF' => 134,
			'OROP' => 132,
			'ANDOP' => 130,
			'UNLESS' => 131
		}
	},
	{#State 64
		DEFAULT => -12
	},
	{#State 65
		ACTIONS => {
			'WORD' => 44,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			'STR' => 35,
			'NOTOP' => 54,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 61,
			'array' => 30,
			'varexpr' => 41,
			'expr' => 135,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 66
		DEFAULT => -54
	},
	{#State 67
		ACTIONS => {
			"(" => 136
		}
	},
	{#State 68
		DEFAULT => -55
	},
	{#State 69
		DEFAULT => -114
	},
	{#State 70
		DEFAULT => -5
	},
	{#State 71
		DEFAULT => -107
	},
	{#State 72
		ACTIONS => {
			'WORD' => -130,
			'' => -130,
			"}" => -130,
			":" => -130,
			'PACKAGE' => -130,
			'XOROP' => -130,
			"\@" => -130,
			"<" => -130,
			'DORDOR' => -130,
			'PERL' => -130,
			'MY' => -130,
			"%" => -130,
			'ANDOP' => -130,
			"\$^" => -130,
			'UNLESS' => -130,
			'NUM' => -130,
			'STEP' => -130,
			'ASSIGNOP' => -130,
			'IF' => -130,
			"\$" => -130,
			'loopword' => -130,
			'FOREACH' => -130,
			"[" => 137,
			"]" => -130,
			'POWOP' => -130,
			'ACROSS' => -130,
			'NOTOP' => -130,
			'FINAL' => -130,
			'DOT' => -130,
			'OROP' => -130,
			'INCLUDE' => -130,
			"(" => -130,
			'VAR' => -130,
			'ANDAND' => -130,
			'INCOP' => -130,
			'RELOP' => -130,
			'NOT2' => -130,
			";" => -130,
			'FOR' => -130,
			'FLOWLEFT' => -130,
			'ADDOP' => -130,
			"," => -130,
			'FUNC' => -130,
			'UNIT' => -130,
			'RETURN' => -130,
			'INIT' => -130,
			'error' => -130,
			'FUNCTION' => -130,
			'FLOWRIGHT' => -130,
			")" => -130,
			'STR' => -130,
			'CALC' => -130,
			"?" => -130,
			'DOTDOT' => -130,
			'MULOP' => -130,
			"{" => -130,
			'CONST' => -130,
			"=" => -130,
			'USE' => -130,
			'YADAYADA' => -130,
			'OROR' => -130
		},
		GOTOS => {
			'subexpr' => 139,
			'subspec' => 138
		}
	},
	{#State 73
		ACTIONS => {
			'perlseq' => 140
		}
	},
	{#State 74
		DEFAULT => -49,
		GOTOS => {
			'@48-2' => 141
		}
	},
	{#State 75
		ACTIONS => {
			"\$" => 52
		},
		GOTOS => {
			'scalar' => 142
		}
	},
	{#State 76
		ACTIONS => {
			'WORD' => 44,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			'STR' => 35,
			'NOTOP' => 54,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 61,
			'array' => 30,
			'varexpr' => 41,
			'expr' => 143,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 77
		ACTIONS => {
			'WORD' => 44,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			'STR' => 35,
			'NOTOP' => 54,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 61,
			'array' => 30,
			'varexpr' => 41,
			'expr' => 144,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 78
		ACTIONS => {
			"\$" => 52
		},
		GOTOS => {
			'scalar' => 145
		}
	},
	{#State 79
		DEFAULT => -141
	},
	{#State 80
		DEFAULT => -142
	},
	{#State 81
		DEFAULT => -91,
		GOTOS => {
			'@90-2' => 146
		}
	},
	{#State 82
		ACTIONS => {
			"\$" => 52,
			'MY' => 148
		},
		GOTOS => {
			'scalar' => 147,
			'scalarvar' => 149
		}
	},
	{#State 83
		ACTIONS => {
			'WORD' => 150,
			"\@" => -76,
			"%" => -76
		},
		GOTOS => {
			'label' => 151
		}
	},
	{#State 84
		DEFAULT => -72
	},
	{#State 85
		ACTIONS => {
			"{" => 152,
			"[" => 83
		},
		GOTOS => {
			'dimspec' => 153
		}
	},
	{#State 86
		ACTIONS => {
			";" => 154
		}
	},
	{#State 87
		ACTIONS => {
			";" => 155
		}
	},
	{#State 88
		DEFAULT => -135
	},
	{#State 89
		ACTIONS => {
			'WORD' => -129,
			'' => -129,
			"}" => -129,
			":" => -129,
			'PACKAGE' => -129,
			'XOROP' => -129,
			"\@" => -129,
			'DORDOR' => -129,
			"<" => 113,
			'PERL' => -129,
			'MY' => -129,
			"%" => -129,
			'ANDOP' => -129,
			"\$^" => -129,
			'UNLESS' => -129,
			'NUM' => -129,
			'STEP' => -129,
			'ASSIGNOP' => -129,
			'IF' => -129,
			"\$" => -129,
			'loopword' => -129,
			'FOREACH' => -129,
			"]" => -129,
			'ACROSS' => -129,
			'POWOP' => -129,
			'NOTOP' => -129,
			'FINAL' => -129,
			'OROP' => -129,
			'INCLUDE' => -129,
			"(" => -129,
			'VAR' => -129,
			'ANDAND' => -129,
			'RELOP' => -129,
			'INCOP' => undef,
			'NOT2' => -129,
			";" => -129,
			'FOR' => -129,
			'FLOWLEFT' => -129,
			'ADDOP' => -129,
			"," => -129,
			'FUNC' => -129,
			'UNIT' => -129,
			'RETURN' => -129,
			'INIT' => -129,
			'FUNCTION' => -129,
			'error' => 121,
			'FLOWRIGHT' => -129,
			")" => -129,
			'STR' => -129,
			'CALC' => -129,
			"?" => -129,
			"{" => -129,
			'DOTDOT' => -129,
			'MULOP' => -129,
			'CONST' => -129,
			"=" => -129,
			'USE' => -129,
			'YADAYADA' => -129,
			'OROR' => -129
		},
		GOTOS => {
			'unitspec' => 117
		}
	},
	{#State 90
		DEFAULT => -63
	},
	{#State 91
		DEFAULT => -95,
		GOTOS => {
			'@94-2' => 156
		}
	},
	{#State 92
		ACTIONS => {
			'WORD' => -126,
			'' => -126,
			"}" => -126,
			":" => -126,
			'PACKAGE' => -126,
			'XOROP' => -126,
			"\@" => -126,
			'DORDOR' => -126,
			"<" => 113,
			'PERL' => -126,
			'MY' => -126,
			"%" => -126,
			'ANDOP' => -126,
			"\$^" => -126,
			'UNLESS' => -126,
			'NUM' => -126,
			'STEP' => -126,
			'ASSIGNOP' => -126,
			'IF' => -126,
			"\$" => -126,
			'loopword' => -126,
			'FOREACH' => -126,
			"]" => -126,
			'ACROSS' => -126,
			'POWOP' => 125,
			'NOTOP' => -126,
			'FINAL' => -126,
			'OROP' => -126,
			'INCLUDE' => -126,
			"(" => -126,
			'VAR' => -126,
			'ANDAND' => -126,
			'RELOP' => -126,
			'INCOP' => 118,
			'NOT2' => -126,
			";" => -126,
			'FOR' => -126,
			'FLOWLEFT' => -126,
			'ADDOP' => -126,
			"," => -126,
			'FUNC' => -126,
			'UNIT' => -126,
			'RETURN' => -126,
			'INIT' => -126,
			'FUNCTION' => -126,
			'error' => 121,
			'FLOWRIGHT' => -126,
			")" => -126,
			'STR' => -126,
			'CALC' => -126,
			"?" => -126,
			"{" => -126,
			'DOTDOT' => -126,
			'MULOP' => -126,
			'CONST' => -126,
			"=" => -126,
			'USE' => -126,
			'YADAYADA' => -126,
			'OROR' => -126
		},
		GOTOS => {
			'unitspec' => 117
		}
	},
	{#State 93
		ACTIONS => {
			";" => 158,
			"," => 157
		}
	},
	{#State 94
		DEFAULT => -19
	},
	{#State 95
		DEFAULT => -53,
		GOTOS => {
			'@52-2' => 159
		}
	},
	{#State 96
		ACTIONS => {
			'WORD' => 44,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			'STR' => 35,
			'NOTOP' => 54,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'sideff' => 160,
			'objname' => 11,
			'funcall' => 36,
			'term' => 61,
			'array' => 30,
			'varexpr' => 41,
			'expr' => 63,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 97
		ACTIONS => {
			"(" => 161
		}
	},
	{#State 98
		DEFAULT => -40,
		GOTOS => {
			'stmtseq' => 162
		}
	},
	{#State 99
		ACTIONS => {
			"=" => 163
		}
	},
	{#State 100
		ACTIONS => {
			"<" => 113,
			";" => -32,
			'error' => 121,
			"[" => 83,
			"=" => -32
		},
		GOTOS => {
			'unitspec' => 165,
			'unitopt' => 164,
			'dimspec' => 166
		}
	},
	{#State 101
		ACTIONS => {
			'WORD' => 167,
			'FUNC' => 168
		}
	},
	{#State 102
		ACTIONS => {
			";" => 169
		}
	},
	{#State 103
		ACTIONS => {
			";" => 170
		}
	},
	{#State 104
		ACTIONS => {
			'FUNC' => 171
		}
	},
	{#State 105
		DEFAULT => -134
	},
	{#State 106
		DEFAULT => -145
	},
	{#State 107
		DEFAULT => -144
	},
	{#State 108
		DEFAULT => -140
	},
	{#State 109
		ACTIONS => {
			'WORD' => -99,
			'' => -99,
			"}" => -99,
			":" => -99,
			'PACKAGE' => -99,
			"\@" => -99,
			"<" => -99,
			'DORDOR' => -99,
			'XOROP' => -99,
			'PERL' => -99,
			'MY' => -99,
			"%" => -99,
			'ANDOP' => -99,
			"\$^" => -99,
			'UNLESS' => -99,
			'NUM' => -99,
			'STEP' => -99,
			'ASSIGNOP' => -99,
			'IF' => -99,
			"\$" => -99,
			'loopword' => -99,
			'FOREACH' => -99,
			"]" => -99,
			'POWOP' => -99,
			'ACROSS' => -99,
			'NOTOP' => -99,
			'FINAL' => -99,
			'OROP' => -99,
			'INCLUDE' => -99,
			"(" => -99,
			'VAR' => -99,
			'ANDAND' => -99,
			'INCOP' => -99,
			'RELOP' => -99,
			'NOT2' => -99,
			";" => -99,
			'FOR' => -99,
			'FLOWLEFT' => -99,
			'ADDOP' => -99,
			"," => -99,
			'FUNC' => -99,
			'UNIT' => -99,
			'RETURN' => -99,
			'INIT' => -99,
			'error' => -99,
			'FUNCTION' => -99,
			'FLOWRIGHT' => -99,
			")" => -99,
			'STR' => -99,
			'CALC' => -99,
			"?" => -99,
			'DOTDOT' => -99,
			'MULOP' => -99,
			"{" => -99,
			'CONST' => -99,
			"=" => -99,
			'USE' => -99,
			'YADAYADA' => -99,
			'OROR' => -99
		}
	},
	{#State 110
		ACTIONS => {
			'XOROP' => 133,
			'OROP' => 132,
			")" => 172,
			'ANDOP' => 130
		}
	},
	{#State 111
		ACTIONS => {
			";" => 173
		}
	},
	{#State 112
		ACTIONS => {
			'WORD' => -127,
			'' => -127,
			"}" => -127,
			":" => -127,
			'PACKAGE' => -127,
			'XOROP' => -127,
			"\@" => -127,
			'DORDOR' => -127,
			"<" => 113,
			'PERL' => -127,
			'MY' => -127,
			"%" => -127,
			'ANDOP' => -127,
			"\$^" => -127,
			'UNLESS' => -127,
			'NUM' => -127,
			'STEP' => -127,
			'ASSIGNOP' => -127,
			'IF' => -127,
			"\$" => -127,
			'loopword' => -127,
			'FOREACH' => -127,
			"]" => -127,
			'ACROSS' => -127,
			'POWOP' => 125,
			'NOTOP' => -127,
			'FINAL' => -127,
			'OROP' => -127,
			'INCLUDE' => -127,
			"(" => -127,
			'VAR' => -127,
			'ANDAND' => -127,
			'RELOP' => -127,
			'INCOP' => 118,
			'NOT2' => -127,
			";" => -127,
			'FOR' => -127,
			'FLOWLEFT' => -127,
			'ADDOP' => -127,
			"," => -127,
			'FUNC' => -127,
			'UNIT' => -127,
			'RETURN' => -127,
			'INIT' => -127,
			'FUNCTION' => -127,
			'error' => 121,
			'FLOWRIGHT' => -127,
			")" => -127,
			'STR' => -127,
			'CALC' => -127,
			"?" => -127,
			"{" => -127,
			'DOTDOT' => -127,
			'MULOP' => -127,
			'CONST' => -127,
			"=" => -127,
			'USE' => -127,
			'YADAYADA' => -127,
			'OROR' => -127
		},
		GOTOS => {
			'unitspec' => 117
		}
	},
	{#State 113
		DEFAULT => -36,
		GOTOS => {
			'unitlist' => 174
		}
	},
	{#State 114
		ACTIONS => {
			'WORD' => 44,
			'STR' => 35,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			"(" => 57,
			'YADAYADA' => 69,
			'RETURN' => 65,
			"\$" => 52,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 175,
			'array' => 30,
			'varexpr' => 41,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 115
		ACTIONS => {
			'WORD' => 44,
			'STR' => 35,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			"(" => 57,
			'YADAYADA' => 69,
			'RETURN' => 65,
			"\$" => 52,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 176,
			'array' => 30,
			'varexpr' => 41,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 116
		ACTIONS => {
			'WORD' => 44,
			'STR' => 35,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			"(" => 57,
			'YADAYADA' => 69,
			'RETURN' => 65,
			"\$" => 52,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 177,
			'array' => 30,
			'varexpr' => 41,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 117
		DEFAULT => -113
	},
	{#State 118
		DEFAULT => -128
	},
	{#State 119
		ACTIONS => {
			'WORD' => 44,
			'STR' => 35,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			"(" => 57,
			'YADAYADA' => 69,
			'RETURN' => 65,
			"\$" => 52,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 178,
			'array' => 30,
			'varexpr' => 41,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 120
		ACTIONS => {
			'WORD' => 44,
			'STR' => 35,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			"(" => 57,
			'YADAYADA' => 69,
			'RETURN' => 65,
			"\$" => 52,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 179,
			'array' => 30,
			'varexpr' => 41,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 121
		ACTIONS => {
			">" => 180
		}
	},
	{#State 122
		ACTIONS => {
			'WORD' => 44,
			'STR' => 35,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			"(" => 57,
			'YADAYADA' => 69,
			'RETURN' => 65,
			"\$" => 52,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 181,
			'array' => 30,
			'varexpr' => 41,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 123
		ACTIONS => {
			'WORD' => 44,
			'STR' => 35,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			"(" => 57,
			'YADAYADA' => 69,
			'RETURN' => 65,
			"\$" => 52,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 182,
			'array' => 30,
			'varexpr' => 41,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 124
		ACTIONS => {
			'WORD' => 44,
			'STR' => 35,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			"(" => 57,
			'YADAYADA' => 69,
			'RETURN' => 65,
			"\$" => 52,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 183,
			'array' => 30,
			'varexpr' => 41,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 125
		ACTIONS => {
			'WORD' => 44,
			'STR' => 35,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			"(" => 57,
			'YADAYADA' => 69,
			'RETURN' => 65,
			"\$" => 52,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 184,
			'array' => 30,
			'varexpr' => 41,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 126
		ACTIONS => {
			'WORD' => 44,
			'STR' => 35,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			"(" => 57,
			'YADAYADA' => 69,
			'RETURN' => 65,
			"\$" => 52,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 185,
			'array' => 30,
			'varexpr' => 41,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 127
		ACTIONS => {
			'WORD' => 44,
			'STR' => 35,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			"(" => 57,
			'YADAYADA' => 69,
			'RETURN' => 65,
			"\$" => 52,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 186,
			'array' => 30,
			'varexpr' => 41,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 128
		ACTIONS => {
			'WORD' => 44,
			'STR' => 35,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			"(" => 57,
			'YADAYADA' => 69,
			'RETURN' => 65,
			"\$" => 52,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 187,
			'array' => 30,
			'varexpr' => 41,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 129
		ACTIONS => {
			'WORD' => 190,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			"," => -153,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			")" => -153,
			'STR' => 35,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'objname' => 11,
			'arg' => 191,
			'term' => 193,
			'array' => 30,
			'pair' => 192,
			'termbinop' => 53,
			'termunop' => 19,
			'set' => 34,
			'dynvar' => 56,
			'funcall' => 36,
			'arglist' => 188,
			'varexpr' => 41,
			'argexpr' => 189,
			'indexvar' => 71,
			'simplevar' => 72
		}
	},
	{#State 130
		ACTIONS => {
			'WORD' => 44,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			'STR' => 35,
			'NOTOP' => 54,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 61,
			'array' => 30,
			'varexpr' => 41,
			'expr' => 194,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 131
		ACTIONS => {
			'WORD' => 44,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			'STR' => 35,
			'NOTOP' => 54,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 61,
			'array' => 30,
			'varexpr' => 41,
			'expr' => 195,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 132
		ACTIONS => {
			'WORD' => 44,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			'STR' => 35,
			'NOTOP' => 54,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 61,
			'array' => 30,
			'varexpr' => 41,
			'expr' => 196,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 133
		ACTIONS => {
			'WORD' => 44,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			'STR' => 35,
			'NOTOP' => 54,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 61,
			'array' => 30,
			'varexpr' => 41,
			'expr' => 197,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 134
		ACTIONS => {
			'WORD' => 44,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			'STR' => 35,
			'NOTOP' => 54,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 61,
			'array' => 30,
			'varexpr' => 41,
			'expr' => 198,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 135
		ACTIONS => {
			'WORD' => -112,
			'' => -112,
			"}" => -112,
			":" => -112,
			'PACKAGE' => -112,
			"\@" => -112,
			"<" => -112,
			'DORDOR' => -112,
			'XOROP' => 133,
			'PERL' => -112,
			'MY' => -112,
			"%" => -112,
			'ANDOP' => 130,
			"\$^" => -112,
			'UNLESS' => -112,
			'NUM' => -112,
			'STEP' => -112,
			'ASSIGNOP' => -112,
			'IF' => -112,
			"\$" => -112,
			'loopword' => -112,
			'FOREACH' => -112,
			"]" => -112,
			'POWOP' => -112,
			'ACROSS' => -112,
			'NOTOP' => -112,
			'FINAL' => -112,
			'OROP' => 132,
			'INCLUDE' => -112,
			"(" => -112,
			'VAR' => -112,
			'ANDAND' => -112,
			'INCOP' => -112,
			'RELOP' => -112,
			'NOT2' => -112,
			";" => -112,
			'FOR' => -112,
			'FLOWLEFT' => -112,
			'ADDOP' => -112,
			"," => -112,
			'FUNC' => -112,
			'UNIT' => -112,
			'RETURN' => -112,
			'INIT' => -112,
			'error' => -112,
			'FUNCTION' => -112,
			'FLOWRIGHT' => -112,
			")" => -112,
			'STR' => -112,
			'CALC' => -112,
			"?" => -112,
			'DOTDOT' => -112,
			'MULOP' => -112,
			"{" => -112,
			'CONST' => -112,
			"=" => -112,
			'USE' => -112,
			'YADAYADA' => -112,
			'OROR' => -112
		}
	},
	{#State 136
		DEFAULT => -82,
		GOTOS => {
			'@81-2' => 199
		}
	},
	{#State 137
		ACTIONS => {
			'WORD' => 44,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			"]" => 200,
			'STR' => 35,
			'NOTOP' => 54,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 61,
			'array' => 30,
			'varexpr' => 41,
			'expr' => 201,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 138
		DEFAULT => -146
	},
	{#State 139
		ACTIONS => {
			'WORD' => -131,
			'' => -131,
			"}" => -131,
			":" => -131,
			'PACKAGE' => -131,
			'XOROP' => -131,
			"\@" => -131,
			"<" => -131,
			'DORDOR' => -131,
			'PERL' => -131,
			'MY' => -131,
			"%" => -131,
			'ANDOP' => -131,
			"\$^" => -131,
			'UNLESS' => -131,
			'NUM' => -131,
			'STEP' => -131,
			'ASSIGNOP' => -131,
			'IF' => -131,
			"\$" => -131,
			'loopword' => -131,
			'FOREACH' => -131,
			"[" => 137,
			"]" => -131,
			'POWOP' => -131,
			'ACROSS' => -131,
			'NOTOP' => -131,
			'FINAL' => -131,
			'DOT' => -131,
			'OROP' => -131,
			'INCLUDE' => -131,
			"(" => -131,
			'VAR' => -131,
			'ANDAND' => -131,
			'INCOP' => -131,
			'RELOP' => -131,
			'NOT2' => -131,
			";" => -131,
			'FOR' => -131,
			'FLOWLEFT' => -131,
			'ADDOP' => -131,
			"," => -131,
			'FUNC' => -131,
			'UNIT' => -131,
			'RETURN' => -131,
			'INIT' => -131,
			'error' => -131,
			'FUNCTION' => -131,
			'FLOWRIGHT' => -131,
			")" => -131,
			'STR' => -131,
			'CALC' => -131,
			"?" => -131,
			'DOTDOT' => -131,
			'MULOP' => -131,
			"{" => -131,
			'CONST' => -131,
			"=" => -131,
			'USE' => -131,
			'YADAYADA' => -131,
			'OROR' => -131
		},
		GOTOS => {
			'subspec' => 202
		}
	},
	{#State 140
		ACTIONS => {
			"%}" => 203
		}
	},
	{#State 141
		ACTIONS => {
			'perlseq' => 204
		}
	},
	{#State 142
		ACTIONS => {
			"(" => 206,
			'MULOP' => 205
		}
	},
	{#State 143
		ACTIONS => {
			'XOROP' => 133,
			'FLOWLEFT' => 207,
			'OROP' => 132,
			'FLOWRIGHT' => 208,
			'ANDOP' => 130
		}
	},
	{#State 144
		ACTIONS => {
			'XOROP' => 133,
			'OROP' => 132,
			")" => 209,
			'ANDOP' => 130
		}
	},
	{#State 145
		ACTIONS => {
			"(" => 211,
			'MULOP' => 210
		}
	},
	{#State 146
		ACTIONS => {
			'WORD' => 44,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			'STR' => 35,
			'NOTOP' => 54,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 61,
			'array' => 30,
			'varexpr' => 41,
			'expr' => 212,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 147
		DEFAULT => -138
	},
	{#State 148
		ACTIONS => {
			"\$" => 52
		},
		GOTOS => {
			'scalar' => 213
		}
	},
	{#State 149
		ACTIONS => {
			"(" => 214
		}
	},
	{#State 150
		ACTIONS => {
			":" => 215
		}
	},
	{#State 151
		ACTIONS => {
			"\@" => 10,
			"%" => 12
		},
		GOTOS => {
			'array' => 216,
			'set' => 217
		}
	},
	{#State 152
		DEFAULT => -39,
		GOTOS => {
			'@38-3' => 218
		}
	},
	{#State 153
		DEFAULT => -73
	},
	{#State 154
		DEFAULT => -16
	},
	{#State 155
		DEFAULT => -15
	},
	{#State 156
		ACTIONS => {
			'WORD' => 44,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			'STR' => 35,
			'NOTOP' => 54,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 61,
			'array' => 30,
			'varexpr' => 41,
			'expr' => 219,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 157
		ACTIONS => {
			'WORD' => 220
		}
	},
	{#State 158
		DEFAULT => -18
	},
	{#State 159
		DEFAULT => -40,
		GOTOS => {
			'stmtseq' => 221
		}
	},
	{#State 160
		ACTIONS => {
			";" => 222
		}
	},
	{#State 161
		ACTIONS => {
			"\$" => 52,
			")" => -27
		},
		GOTOS => {
			'params' => 226,
			'scalar' => 223,
			'paramlist' => 224,
			'param' => 225
		}
	},
	{#State 162
		ACTIONS => {
			"%{" => 6,
			'WORD' => 44,
			"}" => 227,
			'PACKAGE' => 45,
			"\@" => 10,
			'PERL' => 8,
			'MY' => 48,
			"%" => 12,
			"\$^" => 49,
			'UNLESS' => 13,
			'NUM' => 50,
			'STEP' => 15,
			'IF' => 51,
			"\$" => 52,
			'loopword' => 16,
			'FOREACH' => 18,
			'ACROSS' => 228,
			'NOTOP' => 54,
			'FINAL' => 23,
			"(" => 57,
			'VAR' => 58,
			'INCOP' => 25,
			'NOT2' => 59,
			'FOR' => 28,
			'ADDOP' => 29,
			'FUNC' => 62,
			'RETURN' => 65,
			'INIT' => 66,
			'STR' => 35,
			'CALC' => 68,
			"{" => 37,
			'CONST' => 38,
			'YADAYADA' => 69
		},
		GOTOS => {
			'scalar' => 88,
			'sideff' => 27,
			'objname' => 11,
			'term' => 61,
			'loop' => 14,
			'array' => 30,
			'expr' => 63,
			'phase' => 32,
			'termbinop' => 53,
			'set' => 34,
			'termunop' => 19,
			'line' => 229,
			'cond' => 22,
			'dynvar' => 56,
			'phaseblock' => 230,
			'perlblock' => 231,
			'condword' => 67,
			'funcall' => 36,
			'across' => 232,
			'package' => 40,
			'varexpr' => 41,
			'block' => 233,
			'indexvar' => 71,
			'simplevar' => 72
		}
	},
	{#State 163
		DEFAULT => -66,
		GOTOS => {
			'@65-3' => 234
		}
	},
	{#State 164
		DEFAULT => -67
	},
	{#State 165
		DEFAULT => -33
	},
	{#State 166
		ACTIONS => {
			"<" => 113,
			";" => -32,
			'error' => 121,
			"=" => -32
		},
		GOTOS => {
			'unitspec' => 165,
			'unitopt' => 235
		}
	},
	{#State 167
		DEFAULT => -132
	},
	{#State 168
		ACTIONS => {
			"(" => 236
		}
	},
	{#State 169
		DEFAULT => -17
	},
	{#State 170
		DEFAULT => -69
	},
	{#State 171
		ACTIONS => {
			"(" => 237
		}
	},
	{#State 172
		DEFAULT => -104
	},
	{#State 173
		DEFAULT => -64
	},
	{#State 174
		ACTIONS => {
			'UNIT' => 238,
			">" => 239
		}
	},
	{#State 175
		ACTIONS => {
			'WORD' => -125,
			'' => -125,
			"}" => -125,
			":" => -125,
			'PACKAGE' => -125,
			'XOROP' => -125,
			"\@" => -125,
			'DORDOR' => -125,
			"<" => 113,
			'PERL' => -125,
			'MY' => -125,
			"%" => 115,
			'ANDOP' => -125,
			"\$^" => -125,
			'UNLESS' => -125,
			'NUM' => -125,
			'STEP' => -125,
			'ASSIGNOP' => -125,
			'IF' => -125,
			"\$" => -125,
			'loopword' => -125,
			'FOREACH' => -125,
			"]" => -125,
			'ACROSS' => -125,
			'POWOP' => 125,
			'NOTOP' => -125,
			'FINAL' => -125,
			'OROP' => -125,
			'INCLUDE' => -125,
			"(" => -125,
			'VAR' => -125,
			'ANDAND' => 126,
			'RELOP' => 119,
			'INCOP' => 118,
			'NOT2' => -125,
			";" => -125,
			'FOR' => -125,
			'FLOWLEFT' => -125,
			'ADDOP' => 120,
			"," => -125,
			'FUNC' => -125,
			'UNIT' => -125,
			'RETURN' => -125,
			'INIT' => -125,
			'FUNCTION' => -125,
			'error' => 121,
			'FLOWRIGHT' => -125,
			")" => -125,
			'STR' => -125,
			'CALC' => -125,
			"?" => -125,
			"{" => -125,
			'DOTDOT' => -125,
			'MULOP' => 123,
			'CONST' => -125,
			"=" => -125,
			'USE' => -125,
			'YADAYADA' => -125,
			'OROR' => -125
		},
		GOTOS => {
			'unitspec' => 117
		}
	},
	{#State 176
		ACTIONS => {
			'WORD' => -119,
			'' => -119,
			"}" => -119,
			":" => -119,
			'PACKAGE' => -119,
			'XOROP' => -119,
			"\@" => -119,
			'DORDOR' => -119,
			"<" => 113,
			'PERL' => -119,
			'MY' => -119,
			"%" => -119,
			'ANDOP' => -119,
			"\$^" => -119,
			'UNLESS' => -119,
			'NUM' => -119,
			'STEP' => -119,
			'ASSIGNOP' => -119,
			'IF' => -119,
			"\$" => -119,
			'loopword' => -119,
			'FOREACH' => -119,
			"]" => -119,
			'ACROSS' => -119,
			'POWOP' => 125,
			'NOTOP' => -119,
			'FINAL' => -119,
			'OROP' => -119,
			'INCLUDE' => -119,
			"(" => -119,
			'VAR' => -119,
			'ANDAND' => -119,
			'RELOP' => -119,
			'INCOP' => 118,
			'NOT2' => -119,
			";" => -119,
			'FOR' => -119,
			'FLOWLEFT' => -119,
			'ADDOP' => -119,
			"," => -119,
			'FUNC' => -119,
			'UNIT' => -119,
			'RETURN' => -119,
			'INIT' => -119,
			'FUNCTION' => -119,
			'error' => 121,
			'FLOWRIGHT' => -119,
			")" => -119,
			'STR' => -119,
			'CALC' => -119,
			"?" => -119,
			"{" => -119,
			'DOTDOT' => -119,
			'MULOP' => -119,
			'CONST' => -119,
			"=" => -119,
			'USE' => -119,
			'YADAYADA' => -119,
			'OROR' => -119
		},
		GOTOS => {
			'unitspec' => 117
		}
	},
	{#State 177
		ACTIONS => {
			'WORD' => -115,
			'' => -115,
			"}" => -115,
			":" => -115,
			'PACKAGE' => -115,
			'XOROP' => -115,
			"\@" => -115,
			'DORDOR' => 114,
			"<" => 113,
			'PERL' => -115,
			'MY' => -115,
			"%" => 115,
			'ANDOP' => -115,
			"\$^" => -115,
			'UNLESS' => -115,
			'NUM' => -115,
			'STEP' => -115,
			'ASSIGNOP' => 116,
			'IF' => -115,
			"\$" => -115,
			'loopword' => -115,
			'FOREACH' => -115,
			"]" => -115,
			'ACROSS' => -115,
			'POWOP' => 125,
			'NOTOP' => -115,
			'FINAL' => -115,
			'OROP' => -115,
			'INCLUDE' => -115,
			"(" => -115,
			'VAR' => -115,
			'ANDAND' => 126,
			'RELOP' => 119,
			'INCOP' => 118,
			'NOT2' => -115,
			";" => -115,
			'FOR' => -115,
			'FLOWLEFT' => -115,
			'ADDOP' => 120,
			"," => -115,
			'FUNC' => -115,
			'UNIT' => -115,
			'RETURN' => -115,
			'INIT' => -115,
			'FUNCTION' => -115,
			'error' => 121,
			'FLOWRIGHT' => -115,
			")" => -115,
			'STR' => -115,
			'CALC' => -115,
			"?" => 122,
			"{" => -115,
			'DOTDOT' => 127,
			'MULOP' => 123,
			'CONST' => -115,
			"=" => 128,
			'USE' => -115,
			'YADAYADA' => -115,
			'OROR' => 124
		},
		GOTOS => {
			'unitspec' => 117
		}
	},
	{#State 178
		ACTIONS => {
			'WORD' => -121,
			'' => -121,
			"}" => -121,
			":" => -121,
			'PACKAGE' => -121,
			'XOROP' => -121,
			"\@" => -121,
			'DORDOR' => -121,
			"<" => 113,
			'PERL' => -121,
			'MY' => -121,
			"%" => 115,
			'ANDOP' => -121,
			"\$^" => -121,
			'UNLESS' => -121,
			'NUM' => -121,
			'STEP' => -121,
			'ASSIGNOP' => -121,
			'IF' => -121,
			"\$" => -121,
			'loopword' => -121,
			'FOREACH' => -121,
			"]" => -121,
			'ACROSS' => -121,
			'POWOP' => 125,
			'NOTOP' => -121,
			'FINAL' => -121,
			'OROP' => -121,
			'INCLUDE' => -121,
			"(" => -121,
			'VAR' => -121,
			'ANDAND' => -121,
			'RELOP' => undef,
			'INCOP' => 118,
			'NOT2' => -121,
			";" => -121,
			'FOR' => -121,
			'FLOWLEFT' => -121,
			'ADDOP' => 120,
			"," => -121,
			'FUNC' => -121,
			'UNIT' => -121,
			'RETURN' => -121,
			'INIT' => -121,
			'FUNCTION' => -121,
			'error' => 121,
			'FLOWRIGHT' => -121,
			")" => -121,
			'STR' => -121,
			'CALC' => -121,
			"?" => -121,
			"{" => -121,
			'DOTDOT' => -121,
			'MULOP' => 123,
			'CONST' => -121,
			"=" => -121,
			'USE' => -121,
			'YADAYADA' => -121,
			'OROR' => -121
		},
		GOTOS => {
			'unitspec' => 117
		}
	},
	{#State 179
		ACTIONS => {
			'WORD' => -117,
			'' => -117,
			"}" => -117,
			":" => -117,
			'PACKAGE' => -117,
			'XOROP' => -117,
			"\@" => -117,
			'DORDOR' => -117,
			"<" => 113,
			'PERL' => -117,
			'MY' => -117,
			"%" => 115,
			'ANDOP' => -117,
			"\$^" => -117,
			'UNLESS' => -117,
			'NUM' => -117,
			'STEP' => -117,
			'ASSIGNOP' => -117,
			'IF' => -117,
			"\$" => -117,
			'loopword' => -117,
			'FOREACH' => -117,
			"]" => -117,
			'ACROSS' => -117,
			'POWOP' => 125,
			'NOTOP' => -117,
			'FINAL' => -117,
			'OROP' => -117,
			'INCLUDE' => -117,
			"(" => -117,
			'VAR' => -117,
			'ANDAND' => -117,
			'RELOP' => -117,
			'INCOP' => 118,
			'NOT2' => -117,
			";" => -117,
			'FOR' => -117,
			'FLOWLEFT' => -117,
			'ADDOP' => -117,
			"," => -117,
			'FUNC' => -117,
			'UNIT' => -117,
			'RETURN' => -117,
			'INIT' => -117,
			'FUNCTION' => -117,
			'error' => 121,
			'FLOWRIGHT' => -117,
			")" => -117,
			'STR' => -117,
			'CALC' => -117,
			"?" => -117,
			"{" => -117,
			'DOTDOT' => -117,
			'MULOP' => 123,
			'CONST' => -117,
			"=" => -117,
			'USE' => -117,
			'YADAYADA' => -117,
			'OROR' => -117
		},
		GOTOS => {
			'unitspec' => 117
		}
	},
	{#State 180
		DEFAULT => -35
	},
	{#State 181
		ACTIONS => {
			":" => 240,
			"?" => 122,
			'DORDOR' => 114,
			"<" => 113,
			'DOTDOT' => 127,
			'MULOP' => 123,
			'ADDOP' => 120,
			"%" => 115,
			"=" => 128,
			'ASSIGNOP' => 116,
			'error' => 121,
			'ANDAND' => 126,
			'OROR' => 124,
			'POWOP' => 125,
			'INCOP' => 118,
			'RELOP' => 119
		},
		GOTOS => {
			'unitspec' => 117
		}
	},
	{#State 182
		ACTIONS => {
			'WORD' => -118,
			'' => -118,
			"}" => -118,
			":" => -118,
			'PACKAGE' => -118,
			'XOROP' => -118,
			"\@" => -118,
			'DORDOR' => -118,
			"<" => 113,
			'PERL' => -118,
			'MY' => -118,
			"%" => -118,
			'ANDOP' => -118,
			"\$^" => -118,
			'UNLESS' => -118,
			'NUM' => -118,
			'STEP' => -118,
			'ASSIGNOP' => -118,
			'IF' => -118,
			"\$" => -118,
			'loopword' => -118,
			'FOREACH' => -118,
			"]" => -118,
			'ACROSS' => -118,
			'POWOP' => 125,
			'NOTOP' => -118,
			'FINAL' => -118,
			'OROP' => -118,
			'INCLUDE' => -118,
			"(" => -118,
			'VAR' => -118,
			'ANDAND' => -118,
			'RELOP' => -118,
			'INCOP' => 118,
			'NOT2' => -118,
			";" => -118,
			'FOR' => -118,
			'FLOWLEFT' => -118,
			'ADDOP' => -118,
			"," => -118,
			'FUNC' => -118,
			'UNIT' => -118,
			'RETURN' => -118,
			'INIT' => -118,
			'FUNCTION' => -118,
			'error' => 121,
			'FLOWRIGHT' => -118,
			")" => -118,
			'STR' => -118,
			'CALC' => -118,
			"?" => -118,
			"{" => -118,
			'DOTDOT' => -118,
			'MULOP' => -118,
			'CONST' => -118,
			"=" => -118,
			'USE' => -118,
			'YADAYADA' => -118,
			'OROR' => -118
		},
		GOTOS => {
			'unitspec' => 117
		}
	},
	{#State 183
		ACTIONS => {
			'WORD' => -124,
			'' => -124,
			"}" => -124,
			":" => -124,
			'PACKAGE' => -124,
			'XOROP' => -124,
			"\@" => -124,
			'DORDOR' => -124,
			"<" => 113,
			'PERL' => -124,
			'MY' => -124,
			"%" => 115,
			'ANDOP' => -124,
			"\$^" => -124,
			'UNLESS' => -124,
			'NUM' => -124,
			'STEP' => -124,
			'ASSIGNOP' => -124,
			'IF' => -124,
			"\$" => -124,
			'loopword' => -124,
			'FOREACH' => -124,
			"]" => -124,
			'ACROSS' => -124,
			'POWOP' => 125,
			'NOTOP' => -124,
			'FINAL' => -124,
			'OROP' => -124,
			'INCLUDE' => -124,
			"(" => -124,
			'VAR' => -124,
			'ANDAND' => 126,
			'RELOP' => 119,
			'INCOP' => 118,
			'NOT2' => -124,
			";" => -124,
			'FOR' => -124,
			'FLOWLEFT' => -124,
			'ADDOP' => 120,
			"," => -124,
			'FUNC' => -124,
			'UNIT' => -124,
			'RETURN' => -124,
			'INIT' => -124,
			'FUNCTION' => -124,
			'error' => 121,
			'FLOWRIGHT' => -124,
			")" => -124,
			'STR' => -124,
			'CALC' => -124,
			"?" => -124,
			"{" => -124,
			'DOTDOT' => -124,
			'MULOP' => 123,
			'CONST' => -124,
			"=" => -124,
			'USE' => -124,
			'YADAYADA' => -124,
			'OROR' => -124
		},
		GOTOS => {
			'unitspec' => 117
		}
	},
	{#State 184
		ACTIONS => {
			'WORD' => -120,
			'' => -120,
			"}" => -120,
			":" => -120,
			'PACKAGE' => -120,
			'XOROP' => -120,
			"\@" => -120,
			'DORDOR' => -120,
			"<" => 113,
			'PERL' => -120,
			'MY' => -120,
			"%" => -120,
			'ANDOP' => -120,
			"\$^" => -120,
			'UNLESS' => -120,
			'NUM' => -120,
			'STEP' => -120,
			'ASSIGNOP' => -120,
			'IF' => -120,
			"\$" => -120,
			'loopword' => -120,
			'FOREACH' => -120,
			"]" => -120,
			'ACROSS' => -120,
			'POWOP' => 125,
			'NOTOP' => -120,
			'FINAL' => -120,
			'OROP' => -120,
			'INCLUDE' => -120,
			"(" => -120,
			'VAR' => -120,
			'ANDAND' => -120,
			'RELOP' => -120,
			'INCOP' => 118,
			'NOT2' => -120,
			";" => -120,
			'FOR' => -120,
			'FLOWLEFT' => -120,
			'ADDOP' => -120,
			"," => -120,
			'FUNC' => -120,
			'UNIT' => -120,
			'RETURN' => -120,
			'INIT' => -120,
			'FUNCTION' => -120,
			'error' => 121,
			'FLOWRIGHT' => -120,
			")" => -120,
			'STR' => -120,
			'CALC' => -120,
			"?" => -120,
			"{" => -120,
			'DOTDOT' => -120,
			'MULOP' => -120,
			'CONST' => -120,
			"=" => -120,
			'USE' => -120,
			'YADAYADA' => -120,
			'OROR' => -120
		},
		GOTOS => {
			'unitspec' => 117
		}
	},
	{#State 185
		ACTIONS => {
			'WORD' => -123,
			'' => -123,
			"}" => -123,
			":" => -123,
			'PACKAGE' => -123,
			'XOROP' => -123,
			"\@" => -123,
			'DORDOR' => -123,
			"<" => 113,
			'PERL' => -123,
			'MY' => -123,
			"%" => 115,
			'ANDOP' => -123,
			"\$^" => -123,
			'UNLESS' => -123,
			'NUM' => -123,
			'STEP' => -123,
			'ASSIGNOP' => -123,
			'IF' => -123,
			"\$" => -123,
			'loopword' => -123,
			'FOREACH' => -123,
			"]" => -123,
			'ACROSS' => -123,
			'POWOP' => 125,
			'NOTOP' => -123,
			'FINAL' => -123,
			'OROP' => -123,
			'INCLUDE' => -123,
			"(" => -123,
			'VAR' => -123,
			'ANDAND' => -123,
			'RELOP' => 119,
			'INCOP' => 118,
			'NOT2' => -123,
			";" => -123,
			'FOR' => -123,
			'FLOWLEFT' => -123,
			'ADDOP' => 120,
			"," => -123,
			'FUNC' => -123,
			'UNIT' => -123,
			'RETURN' => -123,
			'INIT' => -123,
			'FUNCTION' => -123,
			'error' => 121,
			'FLOWRIGHT' => -123,
			")" => -123,
			'STR' => -123,
			'CALC' => -123,
			"?" => -123,
			"{" => -123,
			'DOTDOT' => -123,
			'MULOP' => 123,
			'CONST' => -123,
			"=" => -123,
			'USE' => -123,
			'YADAYADA' => -123,
			'OROR' => -123
		},
		GOTOS => {
			'unitspec' => 117
		}
	},
	{#State 186
		ACTIONS => {
			'WORD' => -122,
			'' => -122,
			"}" => -122,
			":" => -122,
			'PACKAGE' => -122,
			'XOROP' => -122,
			"\@" => -122,
			'DORDOR' => 114,
			"<" => 113,
			'PERL' => -122,
			'MY' => -122,
			"%" => 115,
			'ANDOP' => -122,
			"\$^" => -122,
			'UNLESS' => -122,
			'NUM' => -122,
			'STEP' => -122,
			'ASSIGNOP' => -122,
			'IF' => -122,
			"\$" => -122,
			'loopword' => -122,
			'FOREACH' => -122,
			"]" => -122,
			'ACROSS' => -122,
			'POWOP' => 125,
			'NOTOP' => -122,
			'FINAL' => -122,
			'OROP' => -122,
			'INCLUDE' => -122,
			"(" => -122,
			'VAR' => -122,
			'ANDAND' => 126,
			'RELOP' => 119,
			'INCOP' => 118,
			'NOT2' => -122,
			";" => -122,
			'FOR' => -122,
			'FLOWLEFT' => -122,
			'ADDOP' => 120,
			"," => -122,
			'FUNC' => -122,
			'UNIT' => -122,
			'RETURN' => -122,
			'INIT' => -122,
			'FUNCTION' => -122,
			'error' => 121,
			'FLOWRIGHT' => -122,
			")" => -122,
			'STR' => -122,
			'CALC' => -122,
			"?" => -122,
			"{" => -122,
			'DOTDOT' => undef,
			'MULOP' => 123,
			'CONST' => -122,
			"=" => -122,
			'USE' => -122,
			'YADAYADA' => -122,
			'OROR' => 124
		},
		GOTOS => {
			'unitspec' => 117
		}
	},
	{#State 187
		ACTIONS => {
			'WORD' => -116,
			'' => -116,
			"}" => -116,
			":" => -116,
			'PACKAGE' => -116,
			'XOROP' => -116,
			"\@" => -116,
			'DORDOR' => 114,
			"<" => 113,
			'PERL' => -116,
			'MY' => -116,
			"%" => 115,
			'ANDOP' => -116,
			"\$^" => -116,
			'UNLESS' => -116,
			'NUM' => -116,
			'STEP' => -116,
			'ASSIGNOP' => 116,
			'IF' => -116,
			"\$" => -116,
			'loopword' => -116,
			'FOREACH' => -116,
			"]" => -116,
			'ACROSS' => -116,
			'POWOP' => 125,
			'NOTOP' => -116,
			'FINAL' => -116,
			'OROP' => -116,
			'INCLUDE' => -116,
			"(" => -116,
			'VAR' => -116,
			'ANDAND' => 126,
			'RELOP' => 119,
			'INCOP' => 118,
			'NOT2' => -116,
			";" => -116,
			'FOR' => -116,
			'FLOWLEFT' => -116,
			'ADDOP' => 120,
			"," => -116,
			'FUNC' => -116,
			'UNIT' => -116,
			'RETURN' => -116,
			'INIT' => -116,
			'FUNCTION' => -116,
			'error' => 121,
			'FLOWRIGHT' => -116,
			")" => -116,
			'STR' => -116,
			'CALC' => -116,
			"?" => 122,
			"{" => -116,
			'DOTDOT' => 127,
			'MULOP' => 123,
			'CONST' => -116,
			"=" => 128,
			'USE' => -116,
			'YADAYADA' => -116,
			'OROR' => 124
		},
		GOTOS => {
			'unitspec' => 117
		}
	},
	{#State 188
		DEFAULT => -154
	},
	{#State 189
		ACTIONS => {
			"," => 241,
			")" => 242
		}
	},
	{#State 190
		ACTIONS => {
			":" => 243,
			"<" => -152,
			'DORDOR' => -152,
			'ADDOP' => -152,
			"," => -152,
			"%" => -152,
			'ASSIGNOP' => -152,
			'error' => -152,
			")" => -152,
			'POWOP' => -152,
			"?" => -152,
			'DOTDOT' => -152,
			'MULOP' => -152,
			"=" => -152,
			'ANDAND' => -152,
			'OROR' => -152,
			'INCOP' => -152,
			'RELOP' => -152
		}
	},
	{#State 191
		DEFAULT => -155
	},
	{#State 192
		DEFAULT => -158
	},
	{#State 193
		ACTIONS => {
			'DORDOR' => 114,
			"<" => 113,
			'ADDOP' => 120,
			"," => -157,
			"%" => 115,
			'ASSIGNOP' => 116,
			'error' => 121,
			")" => -157,
			'POWOP' => 125,
			"?" => 122,
			'MULOP' => 123,
			'DOTDOT' => 127,
			"=" => 128,
			'OROR' => 124,
			'ANDAND' => 126,
			'RELOP' => 119,
			'INCOP' => 118
		},
		GOTOS => {
			'unitspec' => 117
		}
	},
	{#State 194
		ACTIONS => {
			'WORD' => -96,
			'' => -96,
			"}" => -96,
			":" => -96,
			'PACKAGE' => -96,
			"\@" => -96,
			"<" => -96,
			'DORDOR' => -96,
			'XOROP' => -96,
			'PERL' => -96,
			'MY' => -96,
			"%" => -96,
			'ANDOP' => -96,
			"\$^" => -96,
			'UNLESS' => -96,
			'NUM' => -96,
			'STEP' => -96,
			'ASSIGNOP' => -96,
			'IF' => -96,
			"\$" => -96,
			'loopword' => -96,
			'FOREACH' => -96,
			"]" => -96,
			'POWOP' => -96,
			'ACROSS' => -96,
			'NOTOP' => -96,
			'FINAL' => -96,
			'OROP' => -96,
			'INCLUDE' => -96,
			"(" => -96,
			'VAR' => -96,
			'ANDAND' => -96,
			'INCOP' => -96,
			'RELOP' => -96,
			'NOT2' => -96,
			";" => -96,
			'FOR' => -96,
			'FLOWLEFT' => -96,
			'ADDOP' => -96,
			"," => -96,
			'FUNC' => -96,
			'UNIT' => -96,
			'RETURN' => -96,
			'INIT' => -96,
			'error' => -96,
			'FUNCTION' => -96,
			'FLOWRIGHT' => -96,
			")" => -96,
			'STR' => -96,
			'CALC' => -96,
			"?" => -96,
			'DOTDOT' => -96,
			'MULOP' => -96,
			"{" => -96,
			'CONST' => -96,
			"=" => -96,
			'USE' => -96,
			'YADAYADA' => -96,
			'OROR' => -96
		}
	},
	{#State 195
		ACTIONS => {
			'XOROP' => 133,
			";" => -80,
			'OROP' => 132,
			'ANDOP' => 130
		}
	},
	{#State 196
		ACTIONS => {
			'WORD' => -97,
			'' => -97,
			"}" => -97,
			":" => -97,
			'PACKAGE' => -97,
			"\@" => -97,
			"<" => -97,
			'DORDOR' => -97,
			'XOROP' => -97,
			'PERL' => -97,
			'MY' => -97,
			"%" => -97,
			'ANDOP' => 130,
			"\$^" => -97,
			'UNLESS' => -97,
			'NUM' => -97,
			'STEP' => -97,
			'ASSIGNOP' => -97,
			'IF' => -97,
			"\$" => -97,
			'loopword' => -97,
			'FOREACH' => -97,
			"]" => -97,
			'POWOP' => -97,
			'ACROSS' => -97,
			'NOTOP' => -97,
			'FINAL' => -97,
			'OROP' => -97,
			'INCLUDE' => -97,
			"(" => -97,
			'VAR' => -97,
			'ANDAND' => -97,
			'INCOP' => -97,
			'RELOP' => -97,
			'NOT2' => -97,
			";" => -97,
			'FOR' => -97,
			'FLOWLEFT' => -97,
			'ADDOP' => -97,
			"," => -97,
			'FUNC' => -97,
			'UNIT' => -97,
			'RETURN' => -97,
			'INIT' => -97,
			'error' => -97,
			'FUNCTION' => -97,
			'FLOWRIGHT' => -97,
			")" => -97,
			'STR' => -97,
			'CALC' => -97,
			"?" => -97,
			'DOTDOT' => -97,
			'MULOP' => -97,
			"{" => -97,
			'CONST' => -97,
			"=" => -97,
			'USE' => -97,
			'YADAYADA' => -97,
			'OROR' => -97
		}
	},
	{#State 197
		ACTIONS => {
			'WORD' => -98,
			'' => -98,
			"}" => -98,
			":" => -98,
			'PACKAGE' => -98,
			"\@" => -98,
			"<" => -98,
			'DORDOR' => -98,
			'XOROP' => -98,
			'PERL' => -98,
			'MY' => -98,
			"%" => -98,
			'ANDOP' => 130,
			"\$^" => -98,
			'UNLESS' => -98,
			'NUM' => -98,
			'STEP' => -98,
			'ASSIGNOP' => -98,
			'IF' => -98,
			"\$" => -98,
			'loopword' => -98,
			'FOREACH' => -98,
			"]" => -98,
			'POWOP' => -98,
			'ACROSS' => -98,
			'NOTOP' => -98,
			'FINAL' => -98,
			'OROP' => -98,
			'INCLUDE' => -98,
			"(" => -98,
			'VAR' => -98,
			'ANDAND' => -98,
			'INCOP' => -98,
			'RELOP' => -98,
			'NOT2' => -98,
			";" => -98,
			'FOR' => -98,
			'FLOWLEFT' => -98,
			'ADDOP' => -98,
			"," => -98,
			'FUNC' => -98,
			'UNIT' => -98,
			'RETURN' => -98,
			'INIT' => -98,
			'error' => -98,
			'FUNCTION' => -98,
			'FLOWRIGHT' => -98,
			")" => -98,
			'STR' => -98,
			'CALC' => -98,
			"?" => -98,
			'DOTDOT' => -98,
			'MULOP' => -98,
			"{" => -98,
			'CONST' => -98,
			"=" => -98,
			'USE' => -98,
			'YADAYADA' => -98,
			'OROR' => -98
		}
	},
	{#State 198
		ACTIONS => {
			'XOROP' => 133,
			";" => -79,
			'OROP' => 132,
			'ANDOP' => 130
		}
	},
	{#State 199
		ACTIONS => {
			'WORD' => 44,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			'STR' => 35,
			'NOTOP' => 54,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 61,
			'array' => 30,
			'varexpr' => 41,
			'expr' => 244,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 200
		DEFAULT => -148
	},
	{#State 201
		ACTIONS => {
			'XOROP' => 133,
			'OROP' => 132,
			"]" => 245,
			'ANDOP' => 130
		}
	},
	{#State 202
		DEFAULT => -147
	},
	{#State 203
		DEFAULT => -50
	},
	{#State 204
		ACTIONS => {
			"}" => 246
		}
	},
	{#State 205
		ACTIONS => {
			'WORD' => 44,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			'STR' => 35,
			'NOTOP' => 54,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 61,
			'array' => 30,
			'varexpr' => 41,
			'expr' => 247,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 206
		ACTIONS => {
			'WORD' => 44,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			'STR' => 35,
			'NOTOP' => 54,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 61,
			'array' => 30,
			'varexpr' => 41,
			'expr' => 248,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 207
		ACTIONS => {
			"\$" => 52
		},
		GOTOS => {
			'scalar' => 249
		}
	},
	{#State 208
		ACTIONS => {
			"\$" => 52
		},
		GOTOS => {
			'scalar' => 250
		}
	},
	{#State 209
		ACTIONS => {
			'FLOWLEFT' => 251,
			'FLOWRIGHT' => 252
		}
	},
	{#State 210
		ACTIONS => {
			'WORD' => 44,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			'STR' => 35,
			'NOTOP' => 54,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 61,
			'array' => 30,
			'varexpr' => 41,
			'expr' => 253,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 211
		ACTIONS => {
			'WORD' => 44,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			'STR' => 35,
			'NOTOP' => 54,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 61,
			'array' => 30,
			'varexpr' => 41,
			'expr' => 254,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 212
		ACTIONS => {
			'XOROP' => 133,
			'OROP' => 132,
			")" => 255,
			'ANDOP' => 130
		}
	},
	{#State 213
		DEFAULT => -139
	},
	{#State 214
		ACTIONS => {
			'WORD' => 44,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			'STR' => 35,
			'NOTOP' => 54,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 61,
			'array' => 30,
			'varexpr' => 41,
			'expr' => 256,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 215
		DEFAULT => -77
	},
	{#State 216
		ACTIONS => {
			"]" => 257
		}
	},
	{#State 217
		ACTIONS => {
			"]" => 258
		}
	},
	{#State 218
		ACTIONS => {
			'WORD' => -2,
			"}" => -2,
			'PACKAGE' => -2,
			"\@" => -2,
			'PERL' => -2,
			'MY' => -2,
			"%" => -2,
			"\$^" => -2,
			'UNLESS' => -2,
			'NUM' => -2,
			'STEP' => -2,
			'IF' => -2,
			"\$" => -2,
			'loopword' => -2,
			'FOREACH' => -2,
			'ACROSS' => -2,
			'NOTOP' => -2,
			'FINAL' => -2,
			'INCLUDE' => -2,
			"(" => -2,
			'VAR' => -2,
			'INCOP' => -2,
			'NOT2' => -2,
			'FOR' => -2,
			'ADDOP' => -2,
			'FUNC' => -2,
			'UNIT' => -2,
			'RETURN' => -2,
			'INIT' => -2,
			'FUNCTION' => -2,
			'STR' => -2,
			'CALC' => -2,
			"{" => -2,
			'CONST' => -2,
			'USE' => -2,
			'YADAYADA' => -2,
			'progseg' => 3
		},
		GOTOS => {
			'progseq' => 259
		}
	},
	{#State 219
		ACTIONS => {
			'XOROP' => 133,
			";" => 260,
			'OROP' => 132,
			'ANDOP' => 130
		}
	},
	{#State 220
		DEFAULT => -20
	},
	{#State 221
		ACTIONS => {
			"%{" => 6,
			'WORD' => 44,
			"}" => 261,
			'PACKAGE' => 45,
			"\@" => 10,
			'PERL' => 8,
			'MY' => 48,
			"%" => 12,
			"\$^" => 49,
			'UNLESS' => 13,
			'NUM' => 50,
			'STEP' => 15,
			'IF' => 51,
			"\$" => 52,
			'loopword' => 16,
			'FOREACH' => 18,
			'ACROSS' => 228,
			'NOTOP' => 54,
			'FINAL' => 23,
			"(" => 57,
			'VAR' => 58,
			'INCOP' => 25,
			'NOT2' => 59,
			'FOR' => 28,
			'ADDOP' => 29,
			'FUNC' => 62,
			'RETURN' => 65,
			'INIT' => 66,
			'STR' => 35,
			'CALC' => 68,
			"{" => 37,
			'CONST' => 38,
			'YADAYADA' => 69
		},
		GOTOS => {
			'scalar' => 88,
			'sideff' => 27,
			'objname' => 11,
			'term' => 61,
			'loop' => 14,
			'array' => 30,
			'expr' => 63,
			'phase' => 32,
			'termbinop' => 53,
			'set' => 34,
			'termunop' => 19,
			'line' => 229,
			'cond' => 22,
			'dynvar' => 56,
			'phaseblock' => 230,
			'perlblock' => 231,
			'condword' => 67,
			'funcall' => 36,
			'across' => 232,
			'package' => 40,
			'varexpr' => 41,
			'block' => 233,
			'indexvar' => 71,
			'simplevar' => 72
		}
	},
	{#State 222
		DEFAULT => -58
	},
	{#State 223
		DEFAULT => -31
	},
	{#State 224
		ACTIONS => {
			"," => 262,
			")" => -28
		}
	},
	{#State 225
		DEFAULT => -29
	},
	{#State 226
		ACTIONS => {
			")" => 263
		}
	},
	{#State 227
		DEFAULT => -46
	},
	{#State 228
		ACTIONS => {
			"[" => 83
		},
		GOTOS => {
			'dimlist' => 264,
			'dimspec' => 84
		}
	},
	{#State 229
		DEFAULT => -45
	},
	{#State 230
		DEFAULT => -44
	},
	{#State 231
		DEFAULT => -43
	},
	{#State 232
		DEFAULT => -41
	},
	{#State 233
		DEFAULT => -42
	},
	{#State 234
		ACTIONS => {
			'WORD' => 44,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			'STR' => 35,
			'NOTOP' => 54,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 61,
			'array' => 30,
			'varexpr' => 41,
			'expr' => 265,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 235
		DEFAULT => -68
	},
	{#State 236
		ACTIONS => {
			'WORD' => 190,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			"," => -153,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			")" => -153,
			'STR' => 35,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'objname' => 11,
			'arg' => 191,
			'term' => 193,
			'array' => 30,
			'pair' => 192,
			'termbinop' => 53,
			'termunop' => 19,
			'set' => 34,
			'dynvar' => 56,
			'funcall' => 36,
			'arglist' => 188,
			'varexpr' => 41,
			'argexpr' => 266,
			'indexvar' => 71,
			'simplevar' => 72
		}
	},
	{#State 237
		ACTIONS => {
			"\$" => 52,
			")" => -27
		},
		GOTOS => {
			'params' => 267,
			'scalar' => 223,
			'paramlist' => 224,
			'param' => 225
		}
	},
	{#State 238
		DEFAULT => -37
	},
	{#State 239
		DEFAULT => -34
	},
	{#State 240
		ACTIONS => {
			'WORD' => 44,
			'STR' => 35,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			"(" => 57,
			'YADAYADA' => 69,
			'RETURN' => 65,
			"\$" => 52,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 268,
			'array' => 30,
			'varexpr' => 41,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 241
		ACTIONS => {
			'WORD' => 190,
			'STR' => 35,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			"(" => 57,
			'YADAYADA' => 69,
			'RETURN' => 65,
			"\$" => 52,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'arg' => 269,
			'funcall' => 36,
			'term' => 193,
			'array' => 30,
			'varexpr' => 41,
			'pair' => 192,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 242
		ACTIONS => {
			'WORD' => -150,
			'' => -150,
			"}" => -150,
			":" => -150,
			'PACKAGE' => -150,
			'XOROP' => -150,
			"\@" => -150,
			"<" => -150,
			'DORDOR' => -150,
			'PERL' => -150,
			'MY' => -150,
			"%" => -150,
			'ANDOP' => -150,
			"\$^" => -150,
			'UNLESS' => -150,
			'NUM' => -150,
			'STEP' => -150,
			'ASSIGNOP' => -150,
			'IF' => -150,
			"\$" => -150,
			'loopword' => -150,
			'FOREACH' => -150,
			"]" => -150,
			'POWOP' => -150,
			'ACROSS' => -150,
			'NOTOP' => -150,
			'FINAL' => -150,
			'DOT' => 270,
			'OROP' => -150,
			'INCLUDE' => -150,
			"(" => -150,
			'VAR' => -150,
			'ANDAND' => -150,
			'INCOP' => -150,
			'RELOP' => -150,
			'NOT2' => -150,
			";" => -150,
			'FOR' => -150,
			'FLOWLEFT' => -150,
			'ADDOP' => -150,
			"," => -150,
			'FUNC' => -150,
			'UNIT' => -150,
			'RETURN' => -150,
			'INIT' => -150,
			'error' => -150,
			'FUNCTION' => -150,
			'FLOWRIGHT' => -150,
			")" => -150,
			'STR' => -150,
			'CALC' => -150,
			"?" => -150,
			'DOTDOT' => -150,
			'MULOP' => -150,
			"{" => -150,
			'CONST' => -150,
			"=" => -150,
			'USE' => -150,
			'YADAYADA' => -150,
			'OROR' => -150
		}
	},
	{#State 243
		ACTIONS => {
			'WORD' => 44,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			'STR' => 35,
			'NOTOP' => 54,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 61,
			'array' => 30,
			'varexpr' => 41,
			'expr' => 271,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 244
		ACTIONS => {
			'XOROP' => 133,
			'OROP' => 132,
			")" => 272,
			'ANDOP' => 130
		}
	},
	{#State 245
		DEFAULT => -149
	},
	{#State 246
		DEFAULT => -48
	},
	{#State 247
		ACTIONS => {
			'WORD' => -163,
			'' => -163,
			"}" => -163,
			'PACKAGE' => -163,
			"\@" => -163,
			'XOROP' => 133,
			'PERL' => -163,
			'MY' => -163,
			"%" => -163,
			'ANDOP' => 130,
			"\$^" => -163,
			'UNLESS' => -163,
			'NUM' => -163,
			'STEP' => -163,
			'IF' => -163,
			"\$" => -163,
			'loopword' => -163,
			'FOREACH' => -163,
			'ACROSS' => -163,
			'NOTOP' => -163,
			'FINAL' => -163,
			'OROP' => 132,
			'INCLUDE' => -163,
			"(" => -163,
			'VAR' => -163,
			'INCOP' => -163,
			'NOT2' => -163,
			'FOR' => -163,
			'ADDOP' => -163,
			'FUNC' => -163,
			'UNIT' => -163,
			'RETURN' => -163,
			'INIT' => -163,
			'FUNCTION' => -163,
			'STR' => -163,
			'CALC' => -163,
			"{" => -163,
			'CONST' => -163,
			'USE' => -163,
			'YADAYADA' => -163
		}
	},
	{#State 248
		ACTIONS => {
			'XOROP' => 133,
			'OROP' => 132,
			")" => 273,
			'ANDOP' => 130
		}
	},
	{#State 249
		DEFAULT => -161
	},
	{#State 250
		DEFAULT => -160
	},
	{#State 251
		ACTIONS => {
			"\$" => 52
		},
		GOTOS => {
			'scalar' => 274
		}
	},
	{#State 252
		ACTIONS => {
			"\$" => 52
		},
		GOTOS => {
			'scalar' => 275
		}
	},
	{#State 253
		ACTIONS => {
			'WORD' => -162,
			'' => -162,
			"}" => -162,
			'PACKAGE' => -162,
			"\@" => -162,
			'XOROP' => 133,
			'PERL' => -162,
			'MY' => -162,
			"%" => -162,
			'ANDOP' => 130,
			"\$^" => -162,
			'UNLESS' => -162,
			'NUM' => -162,
			'STEP' => -162,
			'IF' => -162,
			"\$" => -162,
			'loopword' => -162,
			'FOREACH' => -162,
			'ACROSS' => -162,
			'NOTOP' => -162,
			'FINAL' => -162,
			'OROP' => 132,
			'INCLUDE' => -162,
			"(" => -162,
			'VAR' => -162,
			'INCOP' => -162,
			'NOT2' => -162,
			'FOR' => -162,
			'ADDOP' => -162,
			'FUNC' => -162,
			'UNIT' => -162,
			'RETURN' => -162,
			'INIT' => -162,
			'FUNCTION' => -162,
			'STR' => -162,
			'CALC' => -162,
			"{" => -162,
			'CONST' => -162,
			'USE' => -162,
			'YADAYADA' => -162
		}
	},
	{#State 254
		ACTIONS => {
			'XOROP' => 133,
			'OROP' => 132,
			")" => 276,
			'ANDOP' => 130
		}
	},
	{#State 255
		ACTIONS => {
			"{" => 277
		}
	},
	{#State 256
		ACTIONS => {
			'XOROP' => 133,
			'OROP' => 132,
			")" => 278,
			'ANDOP' => 130
		}
	},
	{#State 257
		DEFAULT => -74
	},
	{#State 258
		DEFAULT => -75
	},
	{#State 259
		ACTIONS => {
			'WORD' => 44,
			"}" => 279,
			'PACKAGE' => 45,
			"\@" => 10,
			'PERL' => 47,
			'MY' => 48,
			"%" => 12,
			"\$^" => 49,
			'UNLESS' => 13,
			'NUM' => 50,
			'STEP' => 15,
			'IF' => 51,
			"\$" => 52,
			'loopword' => 16,
			'FOREACH' => 18,
			'ACROSS' => 20,
			'NOTOP' => 54,
			'FINAL' => 23,
			'INCLUDE' => 24,
			"(" => 57,
			'VAR' => 58,
			'INCOP' => 25,
			'NOT2' => 59,
			'FOR' => 28,
			'ADDOP' => 29,
			'FUNC' => 62,
			'UNIT' => 31,
			'RETURN' => 65,
			'INIT' => 66,
			'FUNCTION' => 33,
			'STR' => 35,
			'CALC' => 68,
			"{" => 37,
			'CONST' => 38,
			'USE' => 42,
			'YADAYADA' => 69
		},
		GOTOS => {
			'scalar' => 9,
			'function' => 26,
			'sideff' => 27,
			'objname' => 11,
			'include' => 60,
			'tl_across' => 46,
			'term' => 61,
			'loop' => 14,
			'array' => 30,
			'use' => 64,
			'expr' => 63,
			'phase' => 32,
			'termbinop' => 53,
			'flow' => 17,
			'set' => 34,
			'termunop' => 19,
			'line' => 21,
			'cond' => 22,
			'phaseblock' => 55,
			'dynvar' => 56,
			'condword' => 67,
			'funcall' => 36,
			'tl_decl' => 39,
			'package' => 40,
			'varexpr' => 41,
			'unit' => 43,
			'block' => 70,
			'indexvar' => 71,
			'simplevar' => 72
		}
	},
	{#State 260
		ACTIONS => {
			'WORD' => 44,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			'STR' => 35,
			'NOTOP' => 54,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 61,
			'array' => 30,
			'varexpr' => 41,
			'expr' => 280,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 261
		DEFAULT => -52
	},
	{#State 262
		ACTIONS => {
			"\$" => 52
		},
		GOTOS => {
			'scalar' => 223,
			'param' => 281
		}
	},
	{#State 263
		ACTIONS => {
			"<" => 113,
			";" => -32,
			"{" => -32,
			'error' => 121
		},
		GOTOS => {
			'unitspec' => 165,
			'unitopt' => 282
		}
	},
	{#State 264
		ACTIONS => {
			"{" => 283,
			"[" => 83
		},
		GOTOS => {
			'dimspec' => 153
		}
	},
	{#State 265
		ACTIONS => {
			'XOROP' => 133,
			";" => 284,
			'OROP' => 132,
			'ANDOP' => 130
		}
	},
	{#State 266
		ACTIONS => {
			"," => 241,
			")" => 285
		}
	},
	{#State 267
		ACTIONS => {
			")" => 286
		}
	},
	{#State 268
		ACTIONS => {
			'WORD' => -103,
			'' => -103,
			"}" => -103,
			":" => -103,
			'PACKAGE' => -103,
			'XOROP' => -103,
			"\@" => -103,
			'DORDOR' => 114,
			"<" => 113,
			'PERL' => -103,
			'MY' => -103,
			"%" => 115,
			'ANDOP' => -103,
			"\$^" => -103,
			'UNLESS' => -103,
			'NUM' => -103,
			'STEP' => -103,
			'ASSIGNOP' => -103,
			'IF' => -103,
			"\$" => -103,
			'loopword' => -103,
			'FOREACH' => -103,
			"]" => -103,
			'ACROSS' => -103,
			'POWOP' => 125,
			'NOTOP' => -103,
			'FINAL' => -103,
			'OROP' => -103,
			'INCLUDE' => -103,
			"(" => -103,
			'VAR' => -103,
			'ANDAND' => 126,
			'RELOP' => 119,
			'INCOP' => 118,
			'NOT2' => -103,
			";" => -103,
			'FOR' => -103,
			'FLOWLEFT' => -103,
			'ADDOP' => 120,
			"," => -103,
			'FUNC' => -103,
			'UNIT' => -103,
			'RETURN' => -103,
			'INIT' => -103,
			'FUNCTION' => -103,
			'error' => 121,
			'FLOWRIGHT' => -103,
			")" => -103,
			'STR' => -103,
			'CALC' => -103,
			"?" => 122,
			"{" => -103,
			'DOTDOT' => 127,
			'MULOP' => 123,
			'CONST' => -103,
			"=" => -103,
			'USE' => -103,
			'YADAYADA' => -103,
			'OROR' => 124
		},
		GOTOS => {
			'unitspec' => 117
		}
	},
	{#State 269
		DEFAULT => -156
	},
	{#State 270
		ACTIONS => {
			'WORD' => 287
		}
	},
	{#State 271
		ACTIONS => {
			'XOROP' => 133,
			'OROP' => 132,
			"," => -159,
			")" => -159,
			'ANDOP' => 130
		}
	},
	{#State 272
		ACTIONS => {
			"{" => 288
		}
	},
	{#State 273
		DEFAULT => -167
	},
	{#State 274
		DEFAULT => -165
	},
	{#State 275
		DEFAULT => -164
	},
	{#State 276
		DEFAULT => -166
	},
	{#State 277
		DEFAULT => -40,
		GOTOS => {
			'stmtseq' => 289
		}
	},
	{#State 278
		ACTIONS => {
			"{" => 290
		}
	},
	{#State 279
		DEFAULT => -38
	},
	{#State 280
		ACTIONS => {
			'XOROP' => 133,
			";" => 291,
			'OROP' => 132,
			'ANDOP' => 130
		}
	},
	{#State 281
		DEFAULT => -30
	},
	{#State 282
		ACTIONS => {
			";" => 293,
			"{" => 292
		}
	},
	{#State 283
		DEFAULT => -71,
		GOTOS => {
			'@70-3' => 294
		}
	},
	{#State 284
		DEFAULT => -65
	},
	{#State 285
		DEFAULT => -133
	},
	{#State 286
		ACTIONS => {
			"<" => 113,
			";" => -32,
			"{" => -32,
			'error' => 121
		},
		GOTOS => {
			'unitspec' => 165,
			'unitopt' => 295
		}
	},
	{#State 287
		DEFAULT => -151
	},
	{#State 288
		DEFAULT => -40,
		GOTOS => {
			'stmtseq' => 296
		}
	},
	{#State 289
		ACTIONS => {
			"%{" => 6,
			'WORD' => 44,
			"}" => 297,
			'PACKAGE' => 45,
			"\@" => 10,
			'PERL' => 8,
			'MY' => 48,
			"%" => 12,
			"\$^" => 49,
			'UNLESS' => 13,
			'NUM' => 50,
			'STEP' => 15,
			'IF' => 51,
			"\$" => 52,
			'loopword' => 16,
			'FOREACH' => 18,
			'ACROSS' => 228,
			'NOTOP' => 54,
			'FINAL' => 23,
			"(" => 57,
			'VAR' => 58,
			'INCOP' => 25,
			'NOT2' => 59,
			'FOR' => 28,
			'ADDOP' => 29,
			'FUNC' => 62,
			'RETURN' => 65,
			'INIT' => 66,
			'STR' => 35,
			'CALC' => 68,
			"{" => 37,
			'CONST' => 38,
			'YADAYADA' => 69
		},
		GOTOS => {
			'scalar' => 88,
			'sideff' => 27,
			'objname' => 11,
			'term' => 61,
			'loop' => 14,
			'array' => 30,
			'expr' => 63,
			'phase' => 32,
			'termbinop' => 53,
			'set' => 34,
			'termunop' => 19,
			'line' => 229,
			'cond' => 22,
			'dynvar' => 56,
			'phaseblock' => 230,
			'perlblock' => 231,
			'condword' => 67,
			'funcall' => 36,
			'across' => 232,
			'package' => 40,
			'varexpr' => 41,
			'block' => 233,
			'indexvar' => 71,
			'simplevar' => 72
		}
	},
	{#State 290
		DEFAULT => -40,
		GOTOS => {
			'stmtseq' => 298
		}
	},
	{#State 291
		ACTIONS => {
			'WORD' => 44,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			'STR' => 35,
			'NOTOP' => 54,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 61,
			'array' => 30,
			'varexpr' => 41,
			'expr' => 299,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 292
		DEFAULT => -23,
		GOTOS => {
			'@22-7' => 300
		}
	},
	{#State 293
		DEFAULT => -21
	},
	{#State 294
		DEFAULT => -40,
		GOTOS => {
			'stmtseq' => 301
		}
	},
	{#State 295
		ACTIONS => {
			";" => 303,
			"{" => 302
		}
	},
	{#State 296
		ACTIONS => {
			"%{" => 6,
			'WORD' => 44,
			"}" => 304,
			'PACKAGE' => 45,
			"\@" => 10,
			'PERL' => 8,
			'MY' => 48,
			"%" => 12,
			"\$^" => 49,
			'UNLESS' => 13,
			'NUM' => 50,
			'STEP' => 15,
			'IF' => 51,
			"\$" => 52,
			'loopword' => 16,
			'FOREACH' => 18,
			'ACROSS' => 228,
			'NOTOP' => 54,
			'FINAL' => 23,
			"(" => 57,
			'VAR' => 58,
			'INCOP' => 25,
			'NOT2' => 59,
			'FOR' => 28,
			'ADDOP' => 29,
			'FUNC' => 62,
			'RETURN' => 65,
			'INIT' => 66,
			'STR' => 35,
			'CALC' => 68,
			"{" => 37,
			'CONST' => 38,
			'YADAYADA' => 69
		},
		GOTOS => {
			'scalar' => 88,
			'sideff' => 27,
			'objname' => 11,
			'term' => 61,
			'loop' => 14,
			'array' => 30,
			'expr' => 63,
			'phase' => 32,
			'termbinop' => 53,
			'set' => 34,
			'termunop' => 19,
			'line' => 229,
			'cond' => 22,
			'dynvar' => 56,
			'phaseblock' => 230,
			'perlblock' => 231,
			'condword' => 67,
			'funcall' => 36,
			'across' => 232,
			'package' => 40,
			'varexpr' => 41,
			'block' => 233,
			'indexvar' => 71,
			'simplevar' => 72
		}
	},
	{#State 297
		DEFAULT => -90
	},
	{#State 298
		ACTIONS => {
			"%{" => 6,
			'WORD' => 44,
			"}" => 305,
			'PACKAGE' => 45,
			"\@" => 10,
			'PERL' => 8,
			'MY' => 48,
			"%" => 12,
			"\$^" => 49,
			'UNLESS' => 13,
			'NUM' => 50,
			'STEP' => 15,
			'IF' => 51,
			"\$" => 52,
			'loopword' => 16,
			'FOREACH' => 18,
			'ACROSS' => 228,
			'NOTOP' => 54,
			'FINAL' => 23,
			"(" => 57,
			'VAR' => 58,
			'INCOP' => 25,
			'NOT2' => 59,
			'FOR' => 28,
			'ADDOP' => 29,
			'FUNC' => 62,
			'RETURN' => 65,
			'INIT' => 66,
			'STR' => 35,
			'CALC' => 68,
			"{" => 37,
			'CONST' => 38,
			'YADAYADA' => 69
		},
		GOTOS => {
			'scalar' => 88,
			'sideff' => 27,
			'objname' => 11,
			'term' => 61,
			'loop' => 14,
			'array' => 30,
			'expr' => 63,
			'phase' => 32,
			'termbinop' => 53,
			'set' => 34,
			'termunop' => 19,
			'line' => 229,
			'cond' => 22,
			'dynvar' => 56,
			'phaseblock' => 230,
			'perlblock' => 231,
			'condword' => 67,
			'funcall' => 36,
			'across' => 232,
			'package' => 40,
			'varexpr' => 41,
			'block' => 233,
			'indexvar' => 71,
			'simplevar' => 72
		}
	},
	{#State 299
		ACTIONS => {
			'XOROP' => 133,
			'OROP' => 132,
			")" => 306,
			'ANDOP' => 130
		}
	},
	{#State 300
		DEFAULT => -40,
		GOTOS => {
			'stmtseq' => 307
		}
	},
	{#State 301
		ACTIONS => {
			"%{" => 6,
			'WORD' => 44,
			"}" => 308,
			'PACKAGE' => 45,
			"\@" => 10,
			'PERL' => 8,
			'MY' => 48,
			"%" => 12,
			"\$^" => 49,
			'UNLESS' => 13,
			'NUM' => 50,
			'STEP' => 15,
			'IF' => 51,
			"\$" => 52,
			'loopword' => 16,
			'FOREACH' => 18,
			'ACROSS' => 228,
			'NOTOP' => 54,
			'FINAL' => 23,
			"(" => 57,
			'VAR' => 58,
			'INCOP' => 25,
			'NOT2' => 59,
			'FOR' => 28,
			'ADDOP' => 29,
			'FUNC' => 62,
			'RETURN' => 65,
			'INIT' => 66,
			'STR' => 35,
			'CALC' => 68,
			"{" => 37,
			'CONST' => 38,
			'YADAYADA' => 69
		},
		GOTOS => {
			'scalar' => 88,
			'sideff' => 27,
			'objname' => 11,
			'term' => 61,
			'loop' => 14,
			'array' => 30,
			'expr' => 63,
			'phase' => 32,
			'termbinop' => 53,
			'set' => 34,
			'termunop' => 19,
			'line' => 229,
			'cond' => 22,
			'dynvar' => 56,
			'phaseblock' => 230,
			'perlblock' => 231,
			'condword' => 67,
			'funcall' => 36,
			'across' => 232,
			'package' => 40,
			'varexpr' => 41,
			'block' => 233,
			'indexvar' => 71,
			'simplevar' => 72
		}
	},
	{#State 302
		DEFAULT => -26,
		GOTOS => {
			'@25-8' => 309
		}
	},
	{#State 303
		DEFAULT => -24
	},
	{#State 304
		ACTIONS => {
			"%{" => -85,
			'WORD' => -85,
			'' => -85,
			"}" => -85,
			'PACKAGE' => -85,
			"\@" => -85,
			'PERL' => -85,
			'MY' => -85,
			"%" => -85,
			"\$^" => -85,
			'UNLESS' => -85,
			'NUM' => -85,
			'STEP' => -85,
			'IF' => -85,
			"\$" => -85,
			'loopword' => -85,
			'FOREACH' => -85,
			'ACROSS' => -85,
			'NOTOP' => -85,
			'FINAL' => -85,
			'ELSE' => 310,
			'INCLUDE' => -85,
			"(" => -85,
			'VAR' => -85,
			'INCOP' => -85,
			'NOT2' => -85,
			'FOR' => -85,
			'ADDOP' => -85,
			'FUNC' => -85,
			'UNIT' => -85,
			'RETURN' => -85,
			'INIT' => -85,
			'FUNCTION' => -85,
			'STR' => -85,
			'CALC' => -85,
			'ELSIF' => 312,
			"{" => -85,
			'CONST' => -85,
			'USE' => -85,
			'YADAYADA' => -85
		},
		GOTOS => {
			'else' => 311
		}
	},
	{#State 305
		DEFAULT => -92
	},
	{#State 306
		ACTIONS => {
			"{" => 313
		}
	},
	{#State 307
		ACTIONS => {
			"%{" => 6,
			'WORD' => 44,
			"}" => 314,
			'PACKAGE' => 45,
			"\@" => 10,
			'PERL' => 8,
			'MY' => 48,
			"%" => 12,
			"\$^" => 49,
			'UNLESS' => 13,
			'NUM' => 50,
			'STEP' => 15,
			'IF' => 51,
			"\$" => 52,
			'loopword' => 16,
			'FOREACH' => 18,
			'ACROSS' => 228,
			'NOTOP' => 54,
			'FINAL' => 23,
			"(" => 57,
			'VAR' => 58,
			'INCOP' => 25,
			'NOT2' => 59,
			'FOR' => 28,
			'ADDOP' => 29,
			'FUNC' => 62,
			'RETURN' => 65,
			'INIT' => 66,
			'STR' => 35,
			'CALC' => 68,
			"{" => 37,
			'CONST' => 38,
			'YADAYADA' => 69
		},
		GOTOS => {
			'scalar' => 88,
			'sideff' => 27,
			'objname' => 11,
			'term' => 61,
			'loop' => 14,
			'array' => 30,
			'expr' => 63,
			'phase' => 32,
			'termbinop' => 53,
			'set' => 34,
			'termunop' => 19,
			'line' => 229,
			'cond' => 22,
			'dynvar' => 56,
			'phaseblock' => 230,
			'perlblock' => 231,
			'condword' => 67,
			'funcall' => 36,
			'across' => 232,
			'package' => 40,
			'varexpr' => 41,
			'block' => 233,
			'indexvar' => 71,
			'simplevar' => 72
		}
	},
	{#State 308
		DEFAULT => -70
	},
	{#State 309
		ACTIONS => {
			'perlseq' => 315
		}
	},
	{#State 310
		ACTIONS => {
			"{" => 316
		}
	},
	{#State 311
		DEFAULT => -81
	},
	{#State 312
		ACTIONS => {
			"(" => 317
		}
	},
	{#State 313
		DEFAULT => -40,
		GOTOS => {
			'stmtseq' => 318
		}
	},
	{#State 314
		DEFAULT => -22
	},
	{#State 315
		ACTIONS => {
			"}" => 319
		}
	},
	{#State 316
		DEFAULT => -87,
		GOTOS => {
			'@86-2' => 320
		}
	},
	{#State 317
		DEFAULT => -89,
		GOTOS => {
			'@88-2' => 321
		}
	},
	{#State 318
		ACTIONS => {
			"%{" => 6,
			'WORD' => 44,
			"}" => 322,
			'PACKAGE' => 45,
			"\@" => 10,
			'PERL' => 8,
			'MY' => 48,
			"%" => 12,
			"\$^" => 49,
			'UNLESS' => 13,
			'NUM' => 50,
			'STEP' => 15,
			'IF' => 51,
			"\$" => 52,
			'loopword' => 16,
			'FOREACH' => 18,
			'ACROSS' => 228,
			'NOTOP' => 54,
			'FINAL' => 23,
			"(" => 57,
			'VAR' => 58,
			'INCOP' => 25,
			'NOT2' => 59,
			'FOR' => 28,
			'ADDOP' => 29,
			'FUNC' => 62,
			'RETURN' => 65,
			'INIT' => 66,
			'STR' => 35,
			'CALC' => 68,
			"{" => 37,
			'CONST' => 38,
			'YADAYADA' => 69
		},
		GOTOS => {
			'scalar' => 88,
			'sideff' => 27,
			'objname' => 11,
			'term' => 61,
			'loop' => 14,
			'array' => 30,
			'expr' => 63,
			'phase' => 32,
			'termbinop' => 53,
			'set' => 34,
			'termunop' => 19,
			'line' => 229,
			'cond' => 22,
			'dynvar' => 56,
			'phaseblock' => 230,
			'perlblock' => 231,
			'condword' => 67,
			'funcall' => 36,
			'across' => 232,
			'package' => 40,
			'varexpr' => 41,
			'block' => 233,
			'indexvar' => 71,
			'simplevar' => 72
		}
	},
	{#State 319
		DEFAULT => -25
	},
	{#State 320
		DEFAULT => -40,
		GOTOS => {
			'stmtseq' => 323
		}
	},
	{#State 321
		ACTIONS => {
			'WORD' => 44,
			'NOT2' => 59,
			"\@" => 10,
			'ADDOP' => 29,
			'MY' => 48,
			"%" => 12,
			'FUNC' => 62,
			"\$^" => 49,
			'NUM' => 50,
			'RETURN' => 65,
			"\$" => 52,
			'STR' => 35,
			'NOTOP' => 54,
			"(" => 57,
			'YADAYADA' => 69,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 88,
			'dynvar' => 56,
			'objname' => 11,
			'funcall' => 36,
			'term' => 61,
			'array' => 30,
			'varexpr' => 41,
			'expr' => 324,
			'termbinop' => 53,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 19,
			'set' => 34
		}
	},
	{#State 322
		DEFAULT => -94
	},
	{#State 323
		ACTIONS => {
			"%{" => 6,
			'WORD' => 44,
			"}" => 325,
			'PACKAGE' => 45,
			"\@" => 10,
			'PERL' => 8,
			'MY' => 48,
			"%" => 12,
			"\$^" => 49,
			'UNLESS' => 13,
			'NUM' => 50,
			'STEP' => 15,
			'IF' => 51,
			"\$" => 52,
			'loopword' => 16,
			'FOREACH' => 18,
			'ACROSS' => 228,
			'NOTOP' => 54,
			'FINAL' => 23,
			"(" => 57,
			'VAR' => 58,
			'INCOP' => 25,
			'NOT2' => 59,
			'FOR' => 28,
			'ADDOP' => 29,
			'FUNC' => 62,
			'RETURN' => 65,
			'INIT' => 66,
			'STR' => 35,
			'CALC' => 68,
			"{" => 37,
			'CONST' => 38,
			'YADAYADA' => 69
		},
		GOTOS => {
			'scalar' => 88,
			'sideff' => 27,
			'objname' => 11,
			'term' => 61,
			'loop' => 14,
			'array' => 30,
			'expr' => 63,
			'phase' => 32,
			'termbinop' => 53,
			'set' => 34,
			'termunop' => 19,
			'line' => 229,
			'cond' => 22,
			'dynvar' => 56,
			'phaseblock' => 230,
			'perlblock' => 231,
			'condword' => 67,
			'funcall' => 36,
			'across' => 232,
			'package' => 40,
			'varexpr' => 41,
			'block' => 233,
			'indexvar' => 71,
			'simplevar' => 72
		}
	},
	{#State 324
		ACTIONS => {
			'XOROP' => 133,
			'OROP' => 132,
			")" => 326,
			'ANDOP' => 130
		}
	},
	{#State 325
		DEFAULT => -86
	},
	{#State 326
		ACTIONS => {
			"{" => 327
		}
	},
	{#State 327
		DEFAULT => -40,
		GOTOS => {
			'stmtseq' => 328
		}
	},
	{#State 328
		ACTIONS => {
			"%{" => 6,
			'WORD' => 44,
			"}" => 329,
			'PACKAGE' => 45,
			"\@" => 10,
			'PERL' => 8,
			'MY' => 48,
			"%" => 12,
			"\$^" => 49,
			'UNLESS' => 13,
			'NUM' => 50,
			'STEP' => 15,
			'IF' => 51,
			"\$" => 52,
			'loopword' => 16,
			'FOREACH' => 18,
			'ACROSS' => 228,
			'NOTOP' => 54,
			'FINAL' => 23,
			"(" => 57,
			'VAR' => 58,
			'INCOP' => 25,
			'NOT2' => 59,
			'FOR' => 28,
			'ADDOP' => 29,
			'FUNC' => 62,
			'RETURN' => 65,
			'INIT' => 66,
			'STR' => 35,
			'CALC' => 68,
			"{" => 37,
			'CONST' => 38,
			'YADAYADA' => 69
		},
		GOTOS => {
			'scalar' => 88,
			'sideff' => 27,
			'objname' => 11,
			'term' => 61,
			'loop' => 14,
			'array' => 30,
			'expr' => 63,
			'phase' => 32,
			'termbinop' => 53,
			'set' => 34,
			'termunop' => 19,
			'line' => 229,
			'cond' => 22,
			'dynvar' => 56,
			'phaseblock' => 230,
			'perlblock' => 231,
			'condword' => 67,
			'funcall' => 36,
			'across' => 232,
			'package' => 40,
			'varexpr' => 41,
			'block' => 233,
			'indexvar' => 71,
			'simplevar' => 72
		}
	},
	{#State 329
		ACTIONS => {
			"%{" => -85,
			'WORD' => -85,
			'' => -85,
			"}" => -85,
			'PACKAGE' => -85,
			"\@" => -85,
			'PERL' => -85,
			'MY' => -85,
			"%" => -85,
			"\$^" => -85,
			'UNLESS' => -85,
			'NUM' => -85,
			'STEP' => -85,
			'IF' => -85,
			"\$" => -85,
			'loopword' => -85,
			'FOREACH' => -85,
			'ACROSS' => -85,
			'NOTOP' => -85,
			'FINAL' => -85,
			'ELSE' => 310,
			'INCLUDE' => -85,
			"(" => -85,
			'VAR' => -85,
			'INCOP' => -85,
			'NOT2' => -85,
			'FOR' => -85,
			'ADDOP' => -85,
			'FUNC' => -85,
			'UNIT' => -85,
			'RETURN' => -85,
			'INIT' => -85,
			'FUNCTION' => -85,
			'STR' => -85,
			'CALC' => -85,
			'ELSIF' => 312,
			"{" => -85,
			'CONST' => -85,
			'USE' => -85,
			'YADAYADA' => -85
		},
		GOTOS => {
			'else' => 330
		}
	},
	{#State 330
		DEFAULT => -88
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5913 Parser.pm
	],
	[#Rule program_1
		 'program', 2,
sub {
#line 34 "Parser.eyp"
 $_[0]->new_dnode('PROGRAM', $_[2]) }
#line 5920 Parser.pm
	],
	[#Rule progseq_2
		 'progseq', 0,
sub {
#line 38 "Parser.eyp"
 $_[0]->new_node('PROGSEQ') }
#line 5927 Parser.pm
	],
	[#Rule progseq_3
		 'progseq', 2,
sub {
#line 41 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 5934 Parser.pm
	],
	[#Rule progseq_4
		 'progseq', 2,
sub {
#line 44 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 5941 Parser.pm
	],
	[#Rule progseq_5
		 'progseq', 2,
sub {
#line 47 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 5948 Parser.pm
	],
	[#Rule progseq_6
		 'progseq', 2,
sub {
#line 50 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 5955 Parser.pm
	],
	[#Rule progseq_7
		 'progseq', 2,
sub {
#line 53 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 5962 Parser.pm
	],
	[#Rule progseq_8
		 'progseq', 2,
sub {
#line 56 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 5969 Parser.pm
	],
	[#Rule progseq_9
		 'progseq', 2,
sub {
#line 59 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 5976 Parser.pm
	],
	[#Rule progstart_10
		 'progstart', 0, undef
#line 5980 Parser.pm
	],
	[#Rule tl_decl_11
		 'tl_decl', 1,
sub {
#line 66 "Parser.eyp"
 $_[1] }
#line 5987 Parser.pm
	],
	[#Rule tl_decl_12
		 'tl_decl', 1,
sub {
#line 69 "Parser.eyp"
 $_[1] }
#line 5994 Parser.pm
	],
	[#Rule tl_decl_13
		 'tl_decl', 1,
sub {
#line 72 "Parser.eyp"
 $_[1] }
#line 6001 Parser.pm
	],
	[#Rule tl_decl_14
		 'tl_decl', 1,
sub {
#line 75 "Parser.eyp"
 $_[1] }
#line 6008 Parser.pm
	],
	[#Rule include_15
		 'include', 3,
sub {
#line 79 "Parser.eyp"
my $w = $_[2]; 
 			    $_[0]->push_frame(tag => 'INCLUDE');
			    $_[0]->parse_include($w . ".mad");
			    $_[0]->pop_frame('INCLUDE');
			}
#line 6019 Parser.pm
	],
	[#Rule include_16
		 'include', 3,
sub {
#line 86 "Parser.eyp"
my $w = $_[2]; 
 			    $_[0]->push_frame(tag => 'INCLUDE');
			    $_[0]->parse_include($w);
			    $_[0]->pop_frame('INCLUDE');
			}
#line 6030 Parser.pm
	],
	[#Rule use_17
		 'use', 3,
sub {
#line 94 "Parser.eyp"
my $w = $_[2]; 
			    $_[0]->use_perl($w . ".pm");
			}
#line 6039 Parser.pm
	],
	[#Rule unit_18
		 'unit', 3, undef
#line 6043 Parser.pm
	],
	[#Rule unitdecl_19
		 'unitdecl', 1,
sub {
#line 103 "Parser.eyp"
my $w = $_[1]; 
			    $_[0]->declare_unit($w);
			}
#line 6052 Parser.pm
	],
	[#Rule unitdecl_20
		 'unitdecl', 3,
sub {
#line 108 "Parser.eyp"
my $w = $_[3]; 
			    $_[0]->declare_unit($w);
			}
#line 6061 Parser.pm
	],
	[#Rule function_21
		 'function', 7,
sub {
#line 114 "Parser.eyp"
my $u = $_[6]; my $p = $_[4]; my $name = $_[2]; 
			    $_[0]->declare_function($name, $p, 'MAD_FUNC');
			    merge_units($_[0]->new_anode('FUNDECL', $name, $p), $u);
			}
#line 6071 Parser.pm
	],
	[#Rule function_22
		 'function', 10,
sub {
#line 126 "Parser.eyp"
my $u = $_[6]; my $p = $_[4]; my $q = $_[9]; my $name = $_[2]; 
			    $_[0]->pop_frame('FUNDECL');
			    merge_units($_[0]->new_anode('FUNDECL', $name, $p, $q), $u);
			}
#line 6081 Parser.pm
	],
	[#Rule _CODE
		 '@22-7', 0,
sub {
#line 120 "Parser.eyp"
my $u = $_[6]; my $p = $_[4]; my $name = $_[2]; 
			    $_[0]->declare_function($name, $p, 'MAD_FUNC');
			    $_[0]->push_frame(tag => 'FUNDECL', name => $name,
					      params => $p, units => $u);
			}
#line 6092 Parser.pm
	],
	[#Rule function_24
		 'function', 8,
sub {
#line 132 "Parser.eyp"
my $u = $_[7]; my $p = $_[5]; my $name = $_[3]; 
			    $_[0]->declare_function($name, $p, 'PERL_FUNC');
			    merge_units($_[0]->new_anode('PERLFUNDECL', $name, $p), $u);
			}
#line 6102 Parser.pm
	],
	[#Rule function_25
		 'function', 11,
sub {
#line 144 "Parser.eyp"
my $u = $_[7]; my $p = $_[5]; my $q = $_[10]; my $name = $_[3]; 
			    $_[0]->pop_frame('PERLFUNDECL');
			    merge_units($_[0]->new_anode('PERLFUNDECL', $name, $p, $q), $u);
			}
#line 6112 Parser.pm
	],
	[#Rule _CODE
		 '@25-8', 0,
sub {
#line 138 "Parser.eyp"
my $u = $_[7]; my $p = $_[5]; my $name = $_[3]; 
			    $_[0]->declare_function($name, $p, 'PERL_FUNC');
			    $_[0]->push_frame(tag => 'PERLFUNDECL', name => $name,
					      params => $p, units => $u);
			}
#line 6123 Parser.pm
	],
	[#Rule params_27
		 'params', 0,
sub {
#line 151 "Parser.eyp"
 $_[0]->new_node('PARAMS'); }
#line 6130 Parser.pm
	],
	[#Rule params_28
		 'params', 1,
sub {
#line 154 "Parser.eyp"
 $_[2]; }
#line 6137 Parser.pm
	],
	[#Rule paramlist_29
		 'paramlist', 1,
sub {
#line 158 "Parser.eyp"
my $p = $_[1]; 
			    $_[0]->new_node('PARAMS', $p);
			}
#line 6146 Parser.pm
	],
	[#Rule paramlist_30
		 'paramlist', 3,
sub {
#line 163 "Parser.eyp"
my $l = $_[1]; my $p = $_[3]; 
			    $_[0]->add_child($l, $p);
			}
#line 6155 Parser.pm
	],
	[#Rule param_31
		 'param', 1,
sub {
#line 169 "Parser.eyp"
 $_[1] }
#line 6162 Parser.pm
	],
	[#Rule unitopt_32
		 'unitopt', 0, undef
#line 6166 Parser.pm
	],
	[#Rule unitopt_33
		 'unitopt', 1,
sub {
#line 175 "Parser.eyp"
 $_[1] }
#line 6173 Parser.pm
	],
	[#Rule unitspec_34
		 'unitspec', 3,
sub {
#line 179 "Parser.eyp"
my $ulist = $_[2];  merge_units($_[0]->new_node('UNITSPEC'), $ulist, 1) }
#line 6180 Parser.pm
	],
	[#Rule unitspec_35
		 'unitspec', 2,
sub {
#line 182 "Parser.eyp"
 $_[0]->YYErrok(); undef; }
#line 6187 Parser.pm
	],
	[#Rule unitlist_36
		 'unitlist', 0,
sub {
#line 186 "Parser.eyp"
 $_[0]->new_node('UNITLIST') }
#line 6194 Parser.pm
	],
	[#Rule unitlist_37
		 'unitlist', 2,
sub {
#line 189 "Parser.eyp"

			    my (@u) = $_[0]->validate_unit($_[2]);
			    if ( $u[0] eq 'ERROR' ) {
				
			    }
			    else {
				add_units($_[1], @u);
			    }
			}
#line 6209 Parser.pm
	],
	[#Rule tl_across_38
		 'tl_across', 6,
sub {
#line 206 "Parser.eyp"
my $q = $_[5]; my $dl = $_[2]; 
			    $_[0]->pop_frame('ACROSS');
			    $_[0]->new_node('ACROSS', $dl, @{$q->{children}});
			}
#line 6219 Parser.pm
	],
	[#Rule _CODE
		 '@38-3', 0,
sub {
#line 201 "Parser.eyp"
my $dl = $_[2]; 
			    $_[0]->push_frame(tag => 'ACROSS', 
					      dimlist => $dl->{children});
			}
#line 6229 Parser.pm
	],
	[#Rule stmtseq_40
		 'stmtseq', 0,
sub {
#line 213 "Parser.eyp"
 $_[0]->new_node('STMTSEQ') }
#line 6236 Parser.pm
	],
	[#Rule stmtseq_41
		 'stmtseq', 2,
sub {
#line 216 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 6243 Parser.pm
	],
	[#Rule stmtseq_42
		 'stmtseq', 2,
sub {
#line 219 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 6250 Parser.pm
	],
	[#Rule stmtseq_43
		 'stmtseq', 2,
sub {
#line 222 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 6257 Parser.pm
	],
	[#Rule stmtseq_44
		 'stmtseq', 2,
sub {
#line 225 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 6264 Parser.pm
	],
	[#Rule stmtseq_45
		 'stmtseq', 2,
sub {
#line 228 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 6271 Parser.pm
	],
	[#Rule block_46
		 'block', 4,
sub {
#line 236 "Parser.eyp"

			    $_[0]->pop_frame('BLOCK');
			    $_[0]->new_dnode('BLOCK', $_[2]);
			}
#line 6281 Parser.pm
	],
	[#Rule _CODE
		 '@46-1', 0,
sub {
#line 232 "Parser.eyp"
 
			    $_[0]->push_frame(tag => 'BLOCK'); 
			}
#line 6290 Parser.pm
	],
	[#Rule perlblock_48
		 'perlblock', 5,
sub {
#line 248 "Parser.eyp"
my $q = $_[4]; 
			    $_[0]->pop_frame('PERLBLOCK');
			    $_[0]->new_node('PERLBLOCK', @{$q->{children}});
			}
#line 6300 Parser.pm
	],
	[#Rule _CODE
		 '@48-2', 0,
sub {
#line 243 "Parser.eyp"

			    $_[0]->lex_mode('perl');
			    $_[0]->push_frame(tag => 'PERLBLOCK');
			}
#line 6310 Parser.pm
	],
	[#Rule perlblock_50
		 'perlblock', 4,
sub {
#line 259 "Parser.eyp"
my $q = $_[3]; 
			    $_[0]->pop_frame('PERLBLOCK');
			    $_[0]->new_node('PERLBLOCK', @{$q->{children}});
			}
#line 6320 Parser.pm
	],
	[#Rule _CODE
		 '@50-1', 0,
sub {
#line 254 "Parser.eyp"

			    $_[0]->lex_mode('pperl');
			    $_[0]->push_frame(tag => 'PERLBLOCK');
			}
#line 6330 Parser.pm
	],
	[#Rule phaseblock_52
		 'phaseblock', 5,
sub {
#line 270 "Parser.eyp"
my $p = $_[1]; my $q = $_[4]; 
			    $_[0]->pop_frame('BLOCK');
			    $_[0]->new_node($p, @{$q->{children}});
			}
#line 6340 Parser.pm
	],
	[#Rule _CODE
		 '@52-2', 0,
sub {
#line 266 "Parser.eyp"
my $p = $_[1]; 
			    $_[0]->push_frame(tag => 'BLOCK', phase => $p);
			}
#line 6349 Parser.pm
	],
	[#Rule phase_54
		 'phase', 1, undef
#line 6353 Parser.pm
	],
	[#Rule phase_55
		 'phase', 1, undef
#line 6357 Parser.pm
	],
	[#Rule phase_56
		 'phase', 1, undef
#line 6361 Parser.pm
	],
	[#Rule phase_57
		 'phase', 1, undef
#line 6365 Parser.pm
	],
	[#Rule line_58
		 'line', 4,
sub {
#line 290 "Parser.eyp"
my $e = $_[3]; my $p = $_[1]; 
			    $_[0]->pop_frame('line');
			    $_[0]->new_node($p, $e);
			}
#line 6375 Parser.pm
	],
	[#Rule _CODE
		 '@58-1', 0,
sub {
#line 286 "Parser.eyp"
my $p = $_[1]; 
			    $_[0]->push_frame(tag => 'line', phase => $p);
			}
#line 6384 Parser.pm
	],
	[#Rule line_60
		 'line', 1,
sub {
#line 296 "Parser.eyp"
 $_[1] }
#line 6391 Parser.pm
	],
	[#Rule line_61
		 'line', 1,
sub {
#line 299 "Parser.eyp"
 $_[1]; }
#line 6398 Parser.pm
	],
	[#Rule line_62
		 'line', 1,
sub {
#line 302 "Parser.eyp"
 $_[1]; }
#line 6405 Parser.pm
	],
	[#Rule line_63
		 'line', 2,
sub {
#line 305 "Parser.eyp"
my $e = $_[1];  $e; }
#line 6412 Parser.pm
	],
	[#Rule line_64
		 'line', 3,
sub {
#line 308 "Parser.eyp"
my $v = $_[2]; 
			    $_[0]->see_var($v, PLAIN_VAR);
			}
#line 6421 Parser.pm
	],
	[#Rule line_65
		 'line', 6,
sub {
#line 318 "Parser.eyp"
my $e = $_[5]; my $v = $_[2]; 
			    $_[0]->pop_frame('CONST');
			    $_[0]->new_anode('ASSIGN', '=', $v, $e);
			}
#line 6431 Parser.pm
	],
	[#Rule _CODE
		 '@65-3', 0,
sub {
#line 313 "Parser.eyp"
my $v = $_[2]; 
			    $_[0]->see_var($v, CONST_VAR);
			    $_[0]->push_frame(tag => 'CONST', phase => INIT_PHASE);
			}
#line 6441 Parser.pm
	],
	[#Rule vardecl_67
		 'vardecl', 2,
sub {
#line 325 "Parser.eyp"
my $u = $_[2]; my $v = $_[1];  merge_units($v, $u) }
#line 6448 Parser.pm
	],
	[#Rule vardecl_68
		 'vardecl', 3,
sub {
#line 328 "Parser.eyp"
my $u = $_[3]; my $d = $_[2]; my $v = $_[1];  merge_units(add_child($v, $d), $u) }
#line 6455 Parser.pm
	],
	[#Rule package_69
		 'package', 3,
sub {
#line 332 "Parser.eyp"
my $w = $_[2];  $_[0]->set_package($w); $_[0]->new_anode('PACKAGE', $w); }
#line 6462 Parser.pm
	],
	[#Rule across_70
		 'across', 6,
sub {
#line 341 "Parser.eyp"
my $q = $_[5]; my $dl = $_[2]; 
			    $_[0]->pop_frame('ACROSS');
			    $_[0]->new_child('ACROSS', $dl, @{$q->{children}});
			}
#line 6472 Parser.pm
	],
	[#Rule _CODE
		 '@70-3', 0,
sub {
#line 336 "Parser.eyp"
my $dl = $_[2]; 
			    $_[0]->push_frame(tag => 'ACROSS', 
					      dimlist => $dl->{children});
			}
#line 6482 Parser.pm
	],
	[#Rule dimlist_72
		 'dimlist', 1,
sub {
#line 348 "Parser.eyp"
my $d = $_[1];  $_[0]->new_node('DIMLIST', $d); }
#line 6489 Parser.pm
	],
	[#Rule dimlist_73
		 'dimlist', 2,
sub {
#line 351 "Parser.eyp"
my $l = $_[1]; my $d = $_[2];  add_child($l, $d); }
#line 6496 Parser.pm
	],
	[#Rule dimspec_74
		 'dimspec', 4,
sub {
#line 355 "Parser.eyp"
my $l = $_[2]; my $d = $_[3];  add_child($d, $l); }
#line 6503 Parser.pm
	],
	[#Rule dimspec_75
		 'dimspec', 4,
sub {
#line 358 "Parser.eyp"
my $l = $_[2]; my $d = $_[3];  add_child($d, $l); }
#line 6510 Parser.pm
	],
	[#Rule label_76
		 'label', 0, undef
#line 6514 Parser.pm
	],
	[#Rule label_77
		 'label', 2,
sub {
#line 363 "Parser.eyp"
my $w = $_[1];  $_[0]->new_anode('LABEL', $w); }
#line 6521 Parser.pm
	],
	[#Rule sideff_78
		 'sideff', 1,
sub {
#line 367 "Parser.eyp"
 $_[1] }
#line 6528 Parser.pm
	],
	[#Rule sideff_79
		 'sideff', 3,
sub {
#line 370 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('AND', $r, $l) }
#line 6535 Parser.pm
	],
	[#Rule sideff_80
		 'sideff', 3,
sub {
#line 373 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('OR', $r, $l) }
#line 6542 Parser.pm
	],
	[#Rule cond_81
		 'cond', 9,
sub {
#line 379 "Parser.eyp"
my $e = $_[4]; my $c = $_[1]; my $q = $_[7]; my $x = $_[9];  
			    $_[0]->pop_frame($c);
			    $_[0]->new_node($c, $e, $q, $x);
			}
#line 6552 Parser.pm
	],
	[#Rule _CODE
		 '@81-2', 0,
sub {
#line 377 "Parser.eyp"
my $c = $_[1];  $_[0]->push_frame(tag => $c); }
#line 6559 Parser.pm
	],
	[#Rule condword_83
		 'condword', 1,
sub {
#line 386 "Parser.eyp"
 'IF' }
#line 6566 Parser.pm
	],
	[#Rule condword_84
		 'condword', 1,
sub {
#line 388 "Parser.eyp"
 'UNLESS' }
#line 6573 Parser.pm
	],
	[#Rule else_85
		 'else', 0, undef
#line 6577 Parser.pm
	],
	[#Rule else_86
		 'else', 5,
sub {
#line 398 "Parser.eyp"
my $q = $_[4];  
			    $_[0]->pop_frame('ELSE');
			    $_[0]->new_node('ELSE', $q);
			}
#line 6587 Parser.pm
	],
	[#Rule _CODE
		 '@86-2', 0,
sub {
#line 394 "Parser.eyp"

			    $_[0]->push_frame(tag => 'ELSE');
			}
#line 6596 Parser.pm
	],
	[#Rule else_88
		 'else', 9,
sub {
#line 406 "Parser.eyp"
my $e = $_[4]; my $q = $_[7]; my $x = $_[9]; 
			    $_[0]->pop_frame('ELSIF');
			    $_[0]->new_node('ELSIF', $e, $q, $x);
			}
#line 6606 Parser.pm
	],
	[#Rule _CODE
		 '@88-2', 0,
sub {
#line 404 "Parser.eyp"
 $_[0]->push_frame(tag => 'ELSIF'); }
#line 6613 Parser.pm
	],
	[#Rule loop_90
		 'loop', 8,
sub {
#line 417 "Parser.eyp"
my $e = $_[4]; my $c = $_[1]; my $q = $_[7]; 
			    $_[0]->pop_frame($c);
			    $_[0]->new_node($c, $e, $q);
			}
#line 6623 Parser.pm
	],
	[#Rule _CODE
		 '@90-2', 0,
sub {
#line 413 "Parser.eyp"
my $c = $_[1]; 
			    $_[0]->push_frame(tag => $c);
			}
#line 6632 Parser.pm
	],
	[#Rule loop_92
		 'loop', 9,
sub {
#line 427 "Parser.eyp"
my $e = $_[5]; my $q = $_[8]; my $i = $_[3]; 
			    $_[0]->see_var($i, ASSIGN_VAR);
			    $_[0]->pop_frame('FOREACH');
			    $_[0]->new_node('FOREACH', $i, $e, $q);
			}
#line 6643 Parser.pm
	],
	[#Rule _CODE
		 '@92-1', 0,
sub {
#line 423 "Parser.eyp"

			    $_[0]->push_frame(tag => 'FOREACH');
			}
#line 6652 Parser.pm
	],
	[#Rule loop_94
		 'loop', 12,
sub {
#line 438 "Parser.eyp"
my $e2 = $_[6]; my $e1 = $_[4]; my $q = $_[11]; my $e3 = $_[8]; 
			    $_[0]->pop_frame('FOR');
			    $_[0]->new_node('FOR', $e1, $e2, $e3, $q);
			}
#line 6662 Parser.pm
	],
	[#Rule _CODE
		 '@94-2', 0,
sub {
#line 434 "Parser.eyp"

			    $_[0]->push_frame('FOR');
			}
#line 6671 Parser.pm
	],
	[#Rule expr_96
		 'expr', 3,
sub {
#line 445 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('AND', $l, $r) }
#line 6678 Parser.pm
	],
	[#Rule expr_97
		 'expr', 3,
sub {
#line 448 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('OR', $l, $r) }
#line 6685 Parser.pm
	],
	[#Rule expr_98
		 'expr', 3,
sub {
#line 451 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('XOR', $l, $r) }
#line 6692 Parser.pm
	],
	[#Rule expr_99
		 'expr', 2,
sub {
#line 454 "Parser.eyp"
my $e = $_[2];  $_[0]->new_node('NOT', $e) }
#line 6699 Parser.pm
	],
	[#Rule expr_100
		 'expr', 1,
sub {
#line 457 "Parser.eyp"
 $_[1] }
#line 6706 Parser.pm
	],
	[#Rule term_101
		 'term', 1,
sub {
#line 461 "Parser.eyp"
 $_[1] }
#line 6713 Parser.pm
	],
	[#Rule term_102
		 'term', 1,
sub {
#line 464 "Parser.eyp"
 $_[1] }
#line 6720 Parser.pm
	],
	[#Rule term_103
		 'term', 5,
sub {
#line 467 "Parser.eyp"
my $c = $_[5]; my $a = $_[1]; my $b = $_[3];  $_[0]->new_node('TRI', $a, $b, $c) }
#line 6727 Parser.pm
	],
	[#Rule term_104
		 'term', 3,
sub {
#line 470 "Parser.eyp"
 $_[2] }
#line 6734 Parser.pm
	],
	[#Rule term_105
		 'term', 1,
sub {
#line 473 "Parser.eyp"
 $_[1] }
#line 6741 Parser.pm
	],
	[#Rule term_106
		 'term', 1,
sub {
#line 476 "Parser.eyp"
 $_[1] }
#line 6748 Parser.pm
	],
	[#Rule term_107
		 'term', 1,
sub {
#line 479 "Parser.eyp"
 $_[1] }
#line 6755 Parser.pm
	],
	[#Rule term_108
		 'term', 1,
sub {
#line 482 "Parser.eyp"
 $_[0]->new_anode('NUM', $_[1]) }
#line 6762 Parser.pm
	],
	[#Rule term_109
		 'term', 1,
sub {
#line 485 "Parser.eyp"
 $_[0]->new_anode('STR', $_[1]) }
#line 6769 Parser.pm
	],
	[#Rule term_110
		 'term', 1,
sub {
#line 488 "Parser.eyp"
 $_[1] }
#line 6776 Parser.pm
	],
	[#Rule term_111
		 'term', 1,
sub {
#line 492 "Parser.eyp"
 $_[1] }
#line 6783 Parser.pm
	],
	[#Rule term_112
		 'term', 2,
sub {
#line 495 "Parser.eyp"
my $e = $_[2];  $_[0]->new_node('RETURN', $e) }
#line 6790 Parser.pm
	],
	[#Rule term_113
		 'term', 2,
sub {
#line 498 "Parser.eyp"
my $u = $_[2]; my $t = $_[1];  merge_units($t, $u) }
#line 6797 Parser.pm
	],
	[#Rule term_114
		 'term', 1,
sub {
#line 501 "Parser.eyp"
 $_[0]->new_node('YADAYADA'); }
#line 6804 Parser.pm
	],
	[#Rule termbinop_115
		 'termbinop', 3,
sub {
#line 505 "Parser.eyp"
my $l = $_[1]; my $r = $_[3]; my $op = $_[2]; 
			    $_[0]->see_var($l, ASSIGN_VAR);
			    $_[0]->new_anode('ASSIGN', $op, $l, $r);
			}
#line 6814 Parser.pm
	],
	[#Rule termbinop_116
		 'termbinop', 3,
sub {
#line 511 "Parser.eyp"
my $l = $_[1]; my $r = $_[3]; 
			    $_[0]->see_var($l, ASSIGN_VAR);
			    $_[0]->new_anode('ASSIGN', '=', $l, $r);
			}
#line 6824 Parser.pm
	],
	[#Rule termbinop_117
		 'termbinop', 3,
sub {
#line 517 "Parser.eyp"
my $l = $_[1]; my $r = $_[3]; my $op = $_[2];  $_[0]->new_anode('ADDOP', $op, $l, $r); }
#line 6831 Parser.pm
	],
	[#Rule termbinop_118
		 'termbinop', 3,
sub {
#line 520 "Parser.eyp"
my $l = $_[1]; my $r = $_[3]; my $op = $_[2];  $_[0]->new_anode('MULOP', $op, $l, $r); }
#line 6838 Parser.pm
	],
	[#Rule termbinop_119
		 'termbinop', 3,
sub {
#line 523 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_anode('MULOP', '%', $l, $r); }
#line 6845 Parser.pm
	],
	[#Rule termbinop_120
		 'termbinop', 3,
sub {
#line 526 "Parser.eyp"
my $l = $_[1]; my $r = $_[3]; my $op = $_[2];  $_[0]->new_anode('POWOP', $op, $l, $r); }
#line 6852 Parser.pm
	],
	[#Rule termbinop_121
		 'termbinop', 3,
sub {
#line 529 "Parser.eyp"
my $l = $_[1]; my $r = $_[3]; my $op = $_[2];  $_[0]->new_anode('RELOP', $op, $l, $r); }
#line 6859 Parser.pm
	],
	[#Rule termbinop_122
		 'termbinop', 3,
sub {
#line 532 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('DOTDOT', $l, $r); }
#line 6866 Parser.pm
	],
	[#Rule termbinop_123
		 'termbinop', 3,
sub {
#line 535 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('AND', $l, $r); }
#line 6873 Parser.pm
	],
	[#Rule termbinop_124
		 'termbinop', 3,
sub {
#line 538 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('OR', $l, $r); }
#line 6880 Parser.pm
	],
	[#Rule termbinop_125
		 'termbinop', 3,
sub {
#line 541 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('DOR', $l, $r); }
#line 6887 Parser.pm
	],
	[#Rule termunop_126
		 'termunop', 2,
sub {
#line 547 "Parser.eyp"
my $t = $_[2]; my $op = $_[1];  $op eq '-' ? $_[0]->new_node('UMINUS', $t) : $t }
#line 6894 Parser.pm
	],
	[#Rule termunop_127
		 'termunop', 2,
sub {
#line 550 "Parser.eyp"
my $t = $_[2];  $_[0]->new_node('NOT', $t) }
#line 6901 Parser.pm
	],
	[#Rule termunop_128
		 'termunop', 2,
sub {
#line 553 "Parser.eyp"
 $_[1]->{incr} = 'POST'; $_[1] }
#line 6908 Parser.pm
	],
	[#Rule termunop_129
		 'termunop', 2,
sub {
#line 556 "Parser.eyp"
 $_[2]->{incr} = 'PRE'; $_[2] }
#line 6915 Parser.pm
	],
	[#Rule varexpr_130
		 'varexpr', 1,
sub {
#line 560 "Parser.eyp"
my $v = $_[1]; 
			    $_[0]->see_var($v, PLAIN_VAR);
			}
#line 6924 Parser.pm
	],
	[#Rule varexpr_131
		 'varexpr', 2,
sub {
#line 565 "Parser.eyp"
my $d = $_[2]; my $v = $_[1]; 
			    add_child($v, $d);
			    $_[0]->see_var($v, PLAIN_VAR);
			}
#line 6934 Parser.pm
	],
	[#Rule varexpr_132
		 'varexpr', 3,
sub {
#line 571 "Parser.eyp"
my $v = $_[1]; my $f = $_[3]; 
			    $_[0]->see_var($v, PLAIN_VAR);
			    $_[0]->new_anode('DOTFLD', $f, $v);
			}
#line 6944 Parser.pm
	],
	[#Rule varexpr_133
		 'varexpr', 6,
sub {
#line 577 "Parser.eyp"
my $a = $_[5]; my $m = $_[3]; my $v = $_[1]; 
			    $_[0]->see_var($v, PLAIN_VAR);
			    $_[0]->new_anode('METHOD', $m, $v, $a);
			}
#line 6954 Parser.pm
	],
	[#Rule dynvar_134
		 'dynvar', 2,
sub {
#line 584 "Parser.eyp"
my $v = $_[2]; 
			    $_[0]->see_var($v, DYN_VAR);
			}
#line 6963 Parser.pm
	],
	[#Rule simplevar_135
		 'simplevar', 1,
sub {
#line 590 "Parser.eyp"
 $_[1] }
#line 6970 Parser.pm
	],
	[#Rule simplevar_136
		 'simplevar', 1,
sub {
#line 593 "Parser.eyp"
 $_[1] }
#line 6977 Parser.pm
	],
	[#Rule simplevar_137
		 'simplevar', 1,
sub {
#line 596 "Parser.eyp"
 $_[1] }
#line 6984 Parser.pm
	],
	[#Rule scalarvar_138
		 'scalarvar', 1,
sub {
#line 600 "Parser.eyp"
my $v = $_[1];  $_[0]->see_var($v, PLAIN_VAR); }
#line 6991 Parser.pm
	],
	[#Rule scalarvar_139
		 'scalarvar', 2,
sub {
#line 603 "Parser.eyp"
my $v = $_[2];  $_[0]->see_var($v, DYN_VAR); }
#line 6998 Parser.pm
	],
	[#Rule scalar_140
		 'scalar', 2,
sub {
#line 607 "Parser.eyp"
 $_[0]->new_anode('SCALARV', $_[2]); }
#line 7005 Parser.pm
	],
	[#Rule array_141
		 'array', 2,
sub {
#line 611 "Parser.eyp"
 $_[0]->new_anode('ARRAYV', $_[2]); }
#line 7012 Parser.pm
	],
	[#Rule set_142
		 'set', 2,
sub {
#line 615 "Parser.eyp"
 $_[0]->new_anode('SETV', $_[2]); }
#line 7019 Parser.pm
	],
	[#Rule indexvar_143
		 'indexvar', 1,
sub {
#line 619 "Parser.eyp"
 $_[0]->new_node('INDEXVAR'); }
#line 7026 Parser.pm
	],
	[#Rule indexvar_144
		 'indexvar', 2,
sub {
#line 622 "Parser.eyp"
my $n = $_[2];  $_[0]->new_anode('INDEXVAR', $n); }
#line 7033 Parser.pm
	],
	[#Rule indexvar_145
		 'indexvar', 2,
sub {
#line 625 "Parser.eyp"
my $w = $_[2];  $_[0]->new_anode('INDEXVAR', $w); }
#line 7040 Parser.pm
	],
	[#Rule subexpr_146
		 'subexpr', 1,
sub {
#line 629 "Parser.eyp"
my $d = $_[1];  $_[0]->new_node('SUBSCRIPT', $d); }
#line 7047 Parser.pm
	],
	[#Rule subexpr_147
		 'subexpr', 2,
sub {
#line 632 "Parser.eyp"
my $l = $_[1]; my $d = $_[2];  add_child($l, $d); }
#line 7054 Parser.pm
	],
	[#Rule subspec_148
		 'subspec', 2,
sub {
#line 636 "Parser.eyp"
 $_[0]->new_node('EMPTYDIM') }
#line 7061 Parser.pm
	],
	[#Rule subspec_149
		 'subspec', 3,
sub {
#line 639 "Parser.eyp"
 $_[2] }
#line 7068 Parser.pm
	],
	[#Rule funcall_150
		 'funcall', 4,
sub {
#line 643 "Parser.eyp"
my $a = $_[3]; my $fun = $_[1];  $_[0]->new_anode('FUNCALL', $fun, @{$a->{children}}) }
#line 7075 Parser.pm
	],
	[#Rule funcall_151
		 'funcall', 6,
sub {
#line 646 "Parser.eyp"
my $a = $_[3]; my $fld = $_[6]; my $fun = $_[1];  $_[0]->new_anode('DOTFLD', $fld,
				            $_[0]->new_node('FUNCALL', $fun, 
						   @{$a->{children}}) ) }
#line 7084 Parser.pm
	],
	[#Rule objname_152
		 'objname', 1,
sub {
#line 652 "Parser.eyp"
my $n = $_[1];  $_[0]->new_anode('FUNCALL', $n) }
#line 7091 Parser.pm
	],
	[#Rule argexpr_153
		 'argexpr', 0, undef
#line 7095 Parser.pm
	],
	[#Rule argexpr_154
		 'argexpr', 1,
sub {
#line 658 "Parser.eyp"
 $_[1] }
#line 7102 Parser.pm
	],
	[#Rule arglist_155
		 'arglist', 1,
sub {
#line 662 "Parser.eyp"
my $t = $_[1];  $_[0]->new_node('ARGS', $t); }
#line 7109 Parser.pm
	],
	[#Rule arglist_156
		 'arglist', 3,
sub {
#line 665 "Parser.eyp"
my $a = $_[1]; my $t = $_[3];  add_child($a, $t); }
#line 7116 Parser.pm
	],
	[#Rule arg_157
		 'arg', 1,
sub {
#line 669 "Parser.eyp"
 $_[1] }
#line 7123 Parser.pm
	],
	[#Rule arg_158
		 'arg', 1,
sub {
#line 672 "Parser.eyp"
 $_[1] }
#line 7130 Parser.pm
	],
	[#Rule pair_159
		 'pair', 3,
sub {
#line 676 "Parser.eyp"
my $value = $_[3]; my $tag = $_[1];  $_[0]->new_anode('KEY', $tag, $value) }
#line 7137 Parser.pm
	],
	[#Rule flow_160
		 'flow', 5,
sub {
#line 680 "Parser.eyp"
my $so = $_[1]; my $sn = $_[5]; my $coeff = $_[3]; my $op = $_[2]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->new_node('FLOW', $so, $sn, 
			                    $_[0]->new_anode('MULOP', $op, $so, $coeff));
			}
#line 7149 Parser.pm
	],
	[#Rule flow_161
		 'flow', 5,
sub {
#line 688 "Parser.eyp"
my $so = $_[5]; my $sn = $_[1]; my $coeff = $_[3]; my $op = $_[2]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->new_node('FLOW', $so, $sn, 
					    $_[0]->new_anode('MULOP', $op, $sn, $coeff));
			}
#line 7161 Parser.pm
	],
	[#Rule flow_162
		 'flow', 5,
sub {
#line 696 "Parser.eyp"
my $so = $_[1]; my $sn = $_[3]; my $coeff = $_[5]; my $op = $_[4]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->new_node('FLOW', $so, $sn,
					    $_[0]->new_anode('MULOP', $op, $sn, $coeff));
			}
#line 7173 Parser.pm
	],
	[#Rule flow_163
		 'flow', 5,
sub {
#line 704 "Parser.eyp"
my $so = $_[3]; my $sn = $_[1]; my $coeff = $_[5]; my $op = $_[4]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->new_node('FLOW', $so, $sn, 
					    $_[0]->new_anode('MULOP', $op, $so, $coeff));
			}
#line 7185 Parser.pm
	],
	[#Rule flow_164
		 'flow', 6,
sub {
#line 712 "Parser.eyp"
my $rate = $_[3]; my $so = $_[1]; my $sn = $_[6]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->new_node('FLOW', $so, $sn, $rate);
			}
#line 7196 Parser.pm
	],
	[#Rule flow_165
		 'flow', 6,
sub {
#line 719 "Parser.eyp"
my $so = $_[6]; my $rate = $_[3]; my $sn = $_[1]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->new_node('FLOW', $so, $sn, $rate);
			}
#line 7207 Parser.pm
	],
	[#Rule flow_166
		 'flow', 6,
sub {
#line 726 "Parser.eyp"
my $rate = $_[5]; my $so = $_[1]; my $sn = $_[3]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->new_node('FLOW', $so, $sn, $rate);
			}
#line 7218 Parser.pm
	],
	[#Rule flow_167
		 'flow', 6,
sub {
#line 733 "Parser.eyp"
my $rate = $_[5]; my $so = $_[3]; my $sn = $_[1]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->new_node('FLOW', $so, $sn, $rate);
			}
#line 7229 Parser.pm
	]
],
#line 7232 Parser.pm
    yybypass       => 0,
    yybuildingtree => 0,
    yyprefix       => '',
    yyaccessors    => {
   },
    yyconflicthandlers => {}
,
    @_,
  );
  bless($self,$class);

  $self->make_node_classes('TERMINAL', '_OPTIONAL', '_STAR_LIST', '_PLUS_LIST', 
         '_SUPERSTART', 
         'program_1', 
         'progseq_2', 
         'progseq_3', 
         'progseq_4', 
         'progseq_5', 
         'progseq_6', 
         'progseq_7', 
         'progseq_8', 
         'progseq_9', 
         'progstart_10', 
         'tl_decl_11', 
         'tl_decl_12', 
         'tl_decl_13', 
         'tl_decl_14', 
         'include_15', 
         'include_16', 
         'use_17', 
         'unit_18', 
         'unitdecl_19', 
         'unitdecl_20', 
         'function_21', 
         'function_22', 
         '_CODE', 
         'function_24', 
         'function_25', 
         '_CODE', 
         'params_27', 
         'params_28', 
         'paramlist_29', 
         'paramlist_30', 
         'param_31', 
         'unitopt_32', 
         'unitopt_33', 
         'unitspec_34', 
         'unitspec_35', 
         'unitlist_36', 
         'unitlist_37', 
         'tl_across_38', 
         '_CODE', 
         'stmtseq_40', 
         'stmtseq_41', 
         'stmtseq_42', 
         'stmtseq_43', 
         'stmtseq_44', 
         'stmtseq_45', 
         'block_46', 
         '_CODE', 
         'perlblock_48', 
         '_CODE', 
         'perlblock_50', 
         '_CODE', 
         'phaseblock_52', 
         '_CODE', 
         'phase_54', 
         'phase_55', 
         'phase_56', 
         'phase_57', 
         'line_58', 
         '_CODE', 
         'line_60', 
         'line_61', 
         'line_62', 
         'line_63', 
         'line_64', 
         'line_65', 
         '_CODE', 
         'vardecl_67', 
         'vardecl_68', 
         'package_69', 
         'across_70', 
         '_CODE', 
         'dimlist_72', 
         'dimlist_73', 
         'dimspec_74', 
         'dimspec_75', 
         'label_76', 
         'label_77', 
         'sideff_78', 
         'sideff_79', 
         'sideff_80', 
         'cond_81', 
         '_CODE', 
         'condword_83', 
         'condword_84', 
         'else_85', 
         'else_86', 
         '_CODE', 
         'else_88', 
         '_CODE', 
         'loop_90', 
         '_CODE', 
         'loop_92', 
         '_CODE', 
         'loop_94', 
         '_CODE', 
         'expr_96', 
         'expr_97', 
         'expr_98', 
         'expr_99', 
         'expr_100', 
         'term_101', 
         'term_102', 
         'term_103', 
         'term_104', 
         'term_105', 
         'term_106', 
         'term_107', 
         'term_108', 
         'term_109', 
         'term_110', 
         'term_111', 
         'term_112', 
         'term_113', 
         'term_114', 
         'termbinop_115', 
         'termbinop_116', 
         'termbinop_117', 
         'termbinop_118', 
         'termbinop_119', 
         'termbinop_120', 
         'termbinop_121', 
         'termbinop_122', 
         'termbinop_123', 
         'termbinop_124', 
         'termbinop_125', 
         'termunop_126', 
         'termunop_127', 
         'termunop_128', 
         'termunop_129', 
         'varexpr_130', 
         'varexpr_131', 
         'varexpr_132', 
         'varexpr_133', 
         'dynvar_134', 
         'simplevar_135', 
         'simplevar_136', 
         'simplevar_137', 
         'scalarvar_138', 
         'scalarvar_139', 
         'scalar_140', 
         'array_141', 
         'set_142', 
         'indexvar_143', 
         'indexvar_144', 
         'indexvar_145', 
         'subexpr_146', 
         'subexpr_147', 
         'subspec_148', 
         'subspec_149', 
         'funcall_150', 
         'funcall_151', 
         'objname_152', 
         'argexpr_153', 
         'argexpr_154', 
         'arglist_155', 
         'arglist_156', 
         'arg_157', 
         'arg_158', 
         'pair_159', 
         'flow_160', 
         'flow_161', 
         'flow_162', 
         'flow_163', 
         'flow_164', 
         'flow_165', 
         'flow_166', 
         'flow_167', );
  $self;
}

#line 740 "Parser.eyp"


use Carp;
#use Text::Balanced qw/:ALL/;

# Auxiliary routines
# ==================

# init ( )
# 
# This function modifies the EYapp Parser object by adding the extra fields we
# will need.

sub init {

    my ($self) = @_;
    
}

# new_model ( )
# 
# Create a new, empty model, associate it with this parser object, and return
# a reference to it.  This model will be populated using the code parsed by
# this parser.

sub new_model {

    my ($self) = @_;
    
    # Initialize the parser to parse a new model.
    
    $self->{my_stack} = [];
    $self->{lex_mode} = 'mad';
    $self->{frame} = [{tag => 'PROGRAM', phase => CALC_PHASE, module => '', dimcount => 0}];
    $self->{cf} = $self->{frame}[0];
    
    # Create a new object to hold the model as it is read in.  Return a
    # reference to this object as the function result.
    
    $self->{model} = Mad::Model->new();
    $self->{model}{parser} = $self;
    return $self->{model};
}

# parse_input ( $filename )
# 
# If $filename is given, parse the contents of that file using the grammar
# specified above.  Unless, of course, the file cannot be read, in which case
# the program will terminate.  If $filename is empty, read from standard input
# and parse that.

sub parse_input {

    my ($self, $filename) = @_;
    my $input;
    
    # First check that we have called new_model() previously.
    
    croak "You must first call the new_model() method" unless ref $self->{model};
    
    # If a filename was specified...
    
    if ( $filename ne '' ) {
	
	# Read the entire file as if it were a single line, by locally
	# undefining $/ ($INPUT_RECORD_SEPARATOR).
	
	local $/;
	
	# Open the file, or die trying.  Read the contents into $input.
	
 	open my $ifh, "<", $filename or die "Error reading file \"$filename\": $!";
	$input = <$ifh>;
    }
    
    # If no filename was specified...
    
    else {
	
	# Use the dummy filename "<>" in case we have to emit any error messages.
	
	$filename = "<>";
	
	# Read the entire input as if it were a single line, by locally
	# undefining $/ ($INPUT_RECORD_SEPARATOR).
	
	local $/;
	
	# Read from standard input into the variable $input.
	
	$input = <STDIN>;
    }
    
    # Remember the name of the file we are reading from, the starting line
    # number (1) and the contents that we read in.
    
    $self->{my_filename} = $filename;
    $self->{my_line} = 1;
    $self->{my_input} = \$input;
}


sub parse_include {

    my ($self, $filename) = @_;
    my $input;
    
    # identify the directory path of the current filename (if any) so that
    # we can look up the next filename in the same directory.
    
    my ($base) = ($self->{my_filename} =~ m{(.*/)});  
    $filename = "$base$filename" if $base ne '';
    
    # Read the entire file as if it were a single line, by locally
    # undefining $/ ($INPUT_RECORD_SEPARATOR).
    
    local $/;
    
    # Open the file, or die trying.  Read the contents into $input.
    
    open my $ifh, "<", $filename or die "Error reading file \"$filename\": $!";
    $input = <$ifh>;

    # If we actually got some input, process it.
    
    if ( $input =~ /\S/ ) {
	
	# Push the current file's information on the stack, so that we can
	# return to it when we're done with this included file.
	
	unshift @{$self->{my_input_stack}}, {file => $self->{my_filename}, 
					     line => $self->{my_line}, 
					     input => $self->{my_input}};
	
	# Now remember the name of the file we are reading from, the starting
	# line number (1) and the contents that were read in.
	
	$self->{my_filename} = $filename;
	$self->{my_line} = 1;
	$self->{my_input} = \$input;
    }
}


# pop_input ( )
# 
# This function is called by the lexer when it gets to the end of its input.
# The input stack is popped.  The function will then return true if there
# is anything remaining on the stack (i.e. a file which we need to pick up
# parsing again after the pause for an included file) and false otherwise.

sub pop_input {

    my $self = shift;
    
    # If the input stack is empty, return false.  We have finished processing
    # the file we started with, and there is nothing left to do.
    
    if ( @{$self->{my_input_stack}} == 0 ) {
	return 0;
    }

    # Otherwise, we have finished processing a file that was included from
    # another one, and should resume the other file where we left off.
    
    else {
	$self->{my_filename} = $self->{my_input_stack}[0]{file};
	$self->{my_line} = $self->{my_input_stack}[0]{line};
	$self->{my_input} = $self->{my_input_stack}[0]{input};
	shift @{$self->{my_input_stack}};
	return 1;
    }
}

# Functions that help the lexical analyzer
# ----------------------------------------

# lex_mode ( $mode )
# 
# Put the lexical analyzer into the given mode.  This will tell it what to
# expect next.  Options include:
# 
# mad		Expect regular Mad code
# perl		Expect Perl code
# pperl		Expect Perl code which will be terminated by %}
# units		Expect a unit specification, i.e. "<mi/hr>"

sub lex_mode {
    my ($self, $mode) = @_;
    
    # Set our "lex_mode" field, and then initialize the brace count to 1 in
    # case we need to count braces to determine when the current mode ends.
    
    $self->{lex_mode} = $mode;
    $self->{brcount} = 1;
}


# count_brace ( $adjustment )
# 
# Adjust the brace count up or down (depending on whether $adjustment is
# greater than or less than zero).  If the brace count becomes zero, the
# lexical mode returns to 'mad' and we return the token '{'.  Otherwise,
# whichever token is currently being parsed is part of perl code and so we
# return the token 'PERLPART'.

sub count_brace {
    my ($self, $adjustment) = @_;
    $self->{brcount} += $adjustment;
    if ( $self->{brcount} == 0 && $adjustment < 0 ) {
	$self->{lex_mode} = 'mad';
	return '}';
    }
    else {
	return 'PERLPART';
    }
}

# my_syntax ( $msg )
# 
# Terminate parsing because of an error.

sub my_syntax {
    my ($self, $msg) = @_;
    
    my $filename = $self->{error_filename} || $self->{my_filename};
    my $line = $self->{error_line} || $self->{my_line};
    
    $self->{error_filename} = undef;
    $self->{error_line} = undef;
    
    my $token = $self->YYCurval();
    my $near = ", near '$token'" if $token;
    
    $msg = $self->{my_error} unless defined $msg;
    $self->{my_error} = undef;
    
    if ( $msg ) {
        warn "Syntax error at $filename line $line$near: $msg\n";
    }
    else {
	my @expected = $self->YYExpect();
	if ( @expected == 1 ) {
	    warn "Syntax error at $filename line $line$near: expected $expected[0]";
	}
	else {
	    warn "Syntax error at $filename line $line$near.\n";
	}
    }
}

sub my_error {
    my ($self, $msg, $filename, $line) = @_;
    
    $self->my_syntax($msg);
    ${$$self{NBERR}} += 1;
}

sub my_warning {
    my ($self, $msg, $filename, $line) = @_;
    
    $filename = $self->{my_filename} unless defined $filename;
    $line = $self->{my_line} unless defined $line;
    
    warn "Warning at $self->{my_filename} line $self->{my_line}: $msg\n";
}

# The lexical analyzer
# --------------------

# This function is called repeatedly by the parser.  Its job is to determine
# the next token in the input stream and return a pair ($token, $value).  It
# should return ('', undef) when it runs out of input, which signals the
# parser that we are done.

sub my_lexer {
    my $self = shift;
    my $m;
    
    # Allow retries when we process comments, or when we get to the end of a
    # file and need to pop the input file stack (i.e. because we were
    # processing an included file).
    
    while ( 1 )
    {
	# The 'for' is used below to set $_ rather than as a loop.
	
	for (${$self->{my_input}}) {
	    
	    # Start by skipping whitespace.  Note that we have to keep count
	    # of the number of newlines we pass, so that error messages will
	    # indicate the proper line number.
	    
	    m{\G(\s+)}gc and $self->{my_line} += ($1 =~ tr{\n}{});
	    
	    # If we find a comment, skip the rest of the line.  There might
	    # not be a following newline if the comment is the last thing in
	    # the file.
	    
	    m{\G#.*\n?}gc and $self->{my_line}++, next;
	    
	    # Now, if we are done with the current input, see if there's
	    # anything waiting on the input file stack (i.e. because we were
	    # processing an included file).  If not, return the signal for
	    # "end of input".
	    
	    if ( defined(pos($_)) and pos($_) >= length($_) ) {
		next if $self->pop_input();
		return ('', undef); # otherwise
	    }
	    	    
	    # Check for %{, which always signals the start of a Perl block
	    
	    if ( m[\G%{]gc ) {
		$self->lex_mode('pperl');
		return ('%{', '');
	    }

	    # If we are expecting Perl code, then we use a very simplified
	    # lexer that counts brackets to figure out when the enclosing
	    # block is done.  There are two modes: 'perl' which expects
	    # regular brackets, and 'pperl' which expects '%}'.  NEEDED:
	    # PROPER HANDLING OF COMMENTS AND QUOTES, ALSO SOURCE FILTER.
	    
	    if ( $self->{lex_mode} eq 'pperl' ) {
		m<\G\%\}>gc		and $self->{lex_mode} = 'mad', return ('%}','');
		m<\G(.*?)(?=%})>gcs	and $self->{my_line} += ($1 =~ tr{\n}{}),
		    return ('PERLPART', $1);
		croak "Syntax error in $self->{my_filename} line $self->{my_line}: %{ block not closed.\n";
	    }

	    elsif ( $self->{lex_mode} eq 'perl' ) {
		m<\G{>gc		and return ($self->count_brace(1), '{');
		m<\G}>gc		and return ($self->count_brace(-1), '}');
		m<([^{}]+)>gc and $self->{my_line} += ($1 =~ tr{\n}{}), 
		    return ('PERLPART', $1);
		croak "Syntax error in $self->{my_filename} line $self->{my_line}: Perl block not closed.\n";
	    }
	    
	    # If we find something that could be the start of a unit
	    # specification, then we switch to 'units' mode.
	    
	    if ( m{\G<(?=[\sa-zA-Z0-9/*^-]*>)}gc ) {
		$self->{lex_mode} = 'units';
		return ('<', '');
	    }
	    
	    if ( $self->{lex_mode} eq 'units' ) {
		my $t;
		m{\G>}gc		and $self->{lex_mode} = 'mad', return ('>', '');
		m{\G\s*([/*]?\s*[a-zA-Z0-9]+(:?\^-?[0-9]+)?)}gc	and return ('UNIT', $1);
		return ('ERROR', '');
	    }
	    
	    # Otherwise, we're parsing our modeling language.  Start by looking for
	    # keywords.
	    
	    m{\Gacross(?!\w)}gc		and return ('ACROSS', '');
	    m{\Gand(?!\w)}gc		and return ('ANDOP', '');
	    m{\Gcalc(?!\w)}gc		and return ('CALC', 'CALC');
	    m{\Gconst(?!\w)}gc		and return ('CONST', '');
	    m{\Gelse(?!\w)}gc		and return ('ELSE', '');
	    m{\Gelsif(?!\w)}gc		and return ('ELSIF', '');
	    m{\Gexternal(?!\w)}gc	and return ('EXTERNAL', '');
	    m{\Gfinal(?!\w)}gc		and return ('FINAL', 'FINAL');
	    m{\Gfor(?!\w)}gc		and return ('FOR', '');
	    m{\Gfunction(?!\w)}gc	and return ('FUNCTION', '');
	    m{\Ginclude(?!\w)}gc	and return ('INCLUDE', '');
	    m{\Gif(?!\w)}gc		and return ('IF', '');
	    m{\Ginit(?!\w)}gc		and return ('INIT', 'INIT');
	    m{\Glast(?!\w)}gc		and return ('LAST', '');
	    m{\Gnext(?!\w)}gc		and return ('NEXT', '');
	    m{\Gnot(?!\w)}gc		and return ('NOTOP', '');
	    m{\Gor(?!\w)}gc		and return ('OROP', '');
	    m{\Gover(?!\w)}gc		and return ('OVER', '');
	    m{\Gpackage(?!\w)}gc	and return ('PACKAGE', '');
	    m{\Gperl(?!\w)}gc		and return ('PERL', '');
	    m{\Gresult(?!\w)}gc		and return ('RESULT', '');
	    m{\Greturn(?!\w)}gc		and return ('RETURN', '');
	    m{\Grun(?!\w)}gc		and return ('RUN', '');
	    m{\Gstep(?!\w)}gc		and return ('STEP', 'STEP');
	    m{\Gunit(?!\w)}gc		and return ('UNIT', '');
	    m{\Gunless(?!\w)}gc		and return ('UNLESS', '');
	    m{\Guntil(?!\w)}gc		and return ('UNTIL', '');
	    m{\Guse(?!\w)}gc		and return ('USE', '');
	    m{\Gvar(?!\w)}gc		and return ('VAR', '');
	    m{\Gwhile(?!\w)}gc		and return ('WHILE', '');
	    m{\Gxor(?!\w)}gc		and return ('XOROP', '');
	    
	    # Otherwise, any alphanumeric sequence is a function
	    # (i.e. sin, push, etc.) if followed by a parenthesis, and a
	    # bareword otherwise.
	    
	    m{\G(\w(?<!\d)\w*(?=\s*\())}gc		and return ('FUNC', $1);
	    m{\G(\w(?<!\d)\w*)}gc		and return ('WORD', $1);
	    
	    # Now check for numeric and string literals
	    # NEEDED: INTERPOLATION, MULTILINE
	    
	    m{\G((?:\d+\.\d*|\d*\.\d+|\d+)(?:[eE]-?\d+)?)}gc and return ('NUM', $1);
	    
	    m{\G'((?:[^\\']|\\.)*)'}gc		and return ('STR', $1);
	    m{\G"((?:[^\\"]|\\.)*)"}gc		and return ('STR', $1);
	    	    
	    # Now, all of the punctuation
	    
	    m{\G==>}gc				and return ('FLOWRIGHT', '');
	    m{\G<==}gc				and return ('FLOWLEFT', '');
	    m{\G\.\.\.}gc			and return ('YADAYADA', '');
	    m{\G\.\.}gc				and return ('DOTDOT', '');
	    m{\G\.}gc				and return ('DOT', '');
	    m{\G=>}gc				and return ('=>', '');
	    m{\G,}gc				and return (',', ',');
	    m{\G\|\|}gc				and return ('OROR', '');
	    m{\G\/\/}gc				and return ('DORDOR', '');
	    m{\G&&}gc				and return ('ANDAND', '');
	    m{\G(=~|!~)}gc			and return ('MATCHOP', $1);
	    m{\G(==|!=|<=>|eq|ne|cmp)}gc	and return ('RELOP', $1);
	    m{\G(<=|>=|lt|gt|le|ge)}gc		and return ('RELOP', $1);
	    m{\G(<|>)}gc			and return ('RELOP', $1);
	    m{\G([-+\*\/\^|%]=|\*\*=|&&=|\|\|=)}gc and return ('ASSIGNOP', $1);
	    m{\G(\+\+|--)}gc			and return ('INCOP', $1);
	    m{\G->}gc				and return ('ARROW', '');
	    m{\G\*\*}gc				and return ('POWOP', '');
	    m{\G([\*\/])}gc			and return ('MULOP', $1);
	    m{\G([+-])}gc			and return ('ADDOP', $1);
	    m{\G\\}gc				and return ('REFGEN', $1);
	    m{\G!}gc				and return ('NOT2', $1);
	    
	    # Miscellaneous characters
	    
	    m{\G\$\^}gc				and return ('$^', '');
	    m{\G([:;=~()\[\]\{\}\$\@\%])}gc	and return ($1, $1);
	    
	    # If we get here and the current line is not empty, then we've got
	    # an unrecognized character.
	    
	    if ( m{\G(\S)}gc ) {
		$self->my_syntax("unrecognized character '$1'");
	    }
	    else {
		die "Strange lexer error at $self->{my_filename} line $self->{my_line}.\n";
	    }
	}
    }
    
    return ('', undef);
}

# my_lex_wrapper ( ) 
# 
# This function is used for debugging only.  It serves as a wrapper around
# my_lexer, printing out each token and value as they are found.

sub my_lex_wrapper {
    my $parser = shift;
    my ($token, $value);
    ($token, $value) = &my_lexer($parser);
    if (ref $value)
    {
	print "FOUND ($parser->{my_line}) $token '$value->{attr}'\n";
    }
    else
    {
	print "FOUND ($parser->{my_line}) $token '$value'\n";
    }
    return ($token, $value);
}


=for None

=cut


#line 7892 Parser.pm



1;
