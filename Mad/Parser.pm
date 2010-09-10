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

      m{\G(FLOWRIGHT|ASSIGNOP|loopword|FLOWLEFT|FUNCTION|YADAYADA|FOREACH|INCLUDE|perlseq|PACKAGE|default|DORDOR|UNLESS|ACROSS|ANDAND|RETURN|DOTDOT|ANDOP|FINAL|RELOP|INCOP|ADDOP|MULOP|CONST|XOROP|POWOP|NOTOP|ELSIF|STEP|ELSE|OROP|UNIT|OROR|WORD|PERL|NOT2|FUNC|INIT|CALC|FOR|var|STR|USE|NUM|DOT|VAR|\%\}|\%\{|MY|\$\^|IF|\:|\}|\<|\@|\%|\[|\,|\)|\?|\{|\$|\]|\(|\>|\;|\=)}gc and return ($1, $1);



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
  [ 'progseq_4' => 'progseq', [ 'progseq', 'flow' ], 0 ],
  [ 'progseq_5' => 'progseq', [ 'progseq', 'line' ], 0 ],
  [ 'progstart_6' => 'progstart', [  ], 0 ],
  [ 'tl_decl_7' => 'tl_decl', [ 'var' ], 0 ],
  [ 'tl_decl_8' => 'tl_decl', [ 'default' ], 0 ],
  [ 'tl_decl_9' => 'tl_decl', [ 'package' ], 0 ],
  [ 'tl_decl_10' => 'tl_decl', [ 'include' ], 0 ],
  [ 'tl_decl_11' => 'tl_decl', [ 'use' ], 0 ],
  [ 'tl_decl_12' => 'tl_decl', [ 'unit' ], 0 ],
  [ 'tl_decl_13' => 'tl_decl', [ 'function' ], 0 ],
  [ 'tl_decl_14' => 'tl_decl', [ 'across_tl' ], 0 ],
  [ 'tl_decl_15' => 'tl_decl', [ 'flow' ], 0 ],
  [ 'vardecl_16' => 'vardecl', [ 'simplevar', 'unitopt' ], 0 ],
  [ 'vardecl_17' => 'vardecl', [ 'simplevar', 'dimspec', 'unitopt' ], 0 ],
  [ 'package_18' => 'package', [ 'PACKAGE', 'WORD', ';' ], 0 ],
  [ 'include_19' => 'include', [ 'INCLUDE', 'WORD', ';' ], 0 ],
  [ 'include_20' => 'include', [ 'INCLUDE', 'STR', ';' ], 0 ],
  [ 'use_21' => 'use', [ 'USE', 'WORD', ';' ], 0 ],
  [ 'unit_22' => 'unit', [ 'UNIT', 'wordlist', ';' ], 0 ],
  [ 'wordlist_23' => 'wordlist', [ 'WORD' ], 0 ],
  [ 'wordlist_24' => 'wordlist', [ 'wordlist', ',', 'WORD' ], 0 ],
  [ 'function_25' => 'function', [ 'FUNCTION', 'WORD', 'funargs', 'unitopt', ';' ], 0 ],
  [ 'function_26' => 'function', [ 'FUNCTION', 'WORD', 'funargs', 'unitopt', '{', '@26-5', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@26-5', [  ], 0 ],
  [ 'function_28' => 'function', [ 'PERL', 'FUNCTION', 'WORD', 'funargs', 'unitopt', ';' ], 0 ],
  [ 'function_29' => 'function', [ 'PERL', 'FUNCTION', 'WORD', 'funargs', 'unitopt', '{', '@29-6', 'perlseq', '}' ], 0 ],
  [ '_CODE' => '@29-6', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-1', [ 'STAR-1', ',', 'scalar' ], 0 ],
  [ '_STAR_LIST' => 'STAR-1', [ 'scalar' ], 0 ],
  [ '_STAR_LIST' => 'STAR-2', [ 'STAR-1' ], 0 ],
  [ '_STAR_LIST' => 'STAR-2', [  ], 0 ],
  [ 'funargs_35' => 'funargs', [  ], 0 ],
  [ 'funargs_36' => 'funargs', [ '(', 'STAR-2', ')' ], 0 ],
  [ 'unitopt_37' => 'unitopt', [  ], 0 ],
  [ 'unitopt_38' => 'unitopt', [ 'unitspec' ], 0 ],
  [ 'unitspec_39' => 'unitspec', [ '<', 'unitlist', '>' ], 0 ],
  [ 'unitlist_40' => 'unitlist', [  ], 0 ],
  [ 'unitlist_41' => 'unitlist', [ 'unitlist', 'UNIT' ], 0 ],
  [ 'across_tl_42' => 'across_tl', [ 'ACROSS', 'dimlist', '{', '@42-3', 'progseq', '}' ], 0 ],
  [ '_CODE' => '@42-3', [  ], 0 ],
  [ 'stmtseq_44' => 'stmtseq', [  ], 0 ],
  [ 'stmtseq_45' => 'stmtseq', [ 'stmtseq', 'across' ], 0 ],
  [ 'stmtseq_46' => 'stmtseq', [ 'stmtseq', 'line' ], 0 ],
  [ 'block_47' => 'block', [ '{', '@47-1', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@47-1', [  ], 0 ],
  [ 'perlblock_49' => 'perlblock', [ 'PERL', '{', '@49-2', 'perlseq', '}' ], 0 ],
  [ '_CODE' => '@49-2', [  ], 0 ],
  [ 'perlblock_51' => 'perlblock', [ '%{', '@51-1', 'perlseq', '%}' ], 0 ],
  [ '_CODE' => '@51-1', [  ], 0 ],
  [ 'phaseblock_53' => 'phaseblock', [ 'phase', '{', '@53-2', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@53-2', [  ], 0 ],
  [ 'phase_55' => 'phase', [ 'INIT' ], 0 ],
  [ 'phase_56' => 'phase', [ 'CALC' ], 0 ],
  [ 'phase_57' => 'phase', [ 'STEP' ], 0 ],
  [ 'phase_58' => 'phase', [ 'FINAL' ], 0 ],
  [ 'line_59' => 'line', [ 'block' ], 0 ],
  [ 'line_60' => 'line', [ 'perlblock' ], 0 ],
  [ 'line_61' => 'line', [ 'phaseblock' ], 0 ],
  [ 'line_62' => 'line', [ 'phase', '@62-1', 'sideff', ';' ], 0 ],
  [ '_CODE' => '@62-1', [  ], 0 ],
  [ 'line_64' => 'line', [ 'cond' ], 0 ],
  [ 'line_65' => 'line', [ 'loop' ], 0 ],
  [ 'line_66' => 'line', [ 'sideff', ';' ], 0 ],
  [ 'line_67' => 'line', [ 'VAR', 'vardecl', ';' ], 0 ],
  [ 'line_68' => 'line', [ 'CONST', 'vardecl', '=', '@68-3', 'expr', ';' ], 0 ],
  [ '_CODE' => '@68-3', [  ], 0 ],
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
  [ 'cond_81' => 'cond', [ 'condword', '(', '@81-2', 'expr', ')', '{', 'stmtseq', '}', '@81-8', 'else' ], 0 ],
  [ '_CODE' => '@81-2', [  ], 0 ],
  [ '_CODE' => '@81-8', [  ], 0 ],
  [ 'condword_84' => 'condword', [ 'IF' ], 0 ],
  [ 'condword_85' => 'condword', [ 'UNLESS' ], 0 ],
  [ 'else_86' => 'else', [  ], 0 ],
  [ 'else_87' => 'else', [ 'ELSE', '{', '@87-2', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@87-2', [  ], 0 ],
  [ 'else_89' => 'else', [ 'ELSIF', '(', '@89-2', 'expr', ')', '{', 'stmtseq', '}', '@89-8', 'else' ], 0 ],
  [ '_CODE' => '@89-2', [  ], 0 ],
  [ '_CODE' => '@89-8', [  ], 0 ],
  [ 'loop_92' => 'loop', [ 'loopword', '(', '@92-2', 'expr', ')', '{', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@92-2', [  ], 0 ],
  [ 'loop_94' => 'loop', [ 'FOREACH', '@94-1', 'scalarvar', '(', 'expr', ')', '{', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@94-1', [  ], 0 ],
  [ 'loop_96' => 'loop', [ 'FOR', '(', '@96-2', 'expr', ';', 'expr', ';', 'expr', ')', '{', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@96-2', [  ], 0 ],
  [ 'listexpr_98' => 'listexpr', [  ], 0 ],
  [ 'listexpr_99' => 'listexpr', [ 'argexpr' ], 0 ],
  [ 'argexpr_100' => 'argexpr', [ 'argexpr', ',' ], 0 ],
  [ 'argexpr_101' => 'argexpr', [ 'argexpr', ',', 'term' ], 0 ],
  [ 'argexpr_102' => 'argexpr', [ 'term' ], 0 ],
  [ 'expr_103' => 'expr', [ 'expr', 'ANDOP', 'expr' ], 0 ],
  [ 'expr_104' => 'expr', [ 'expr', 'OROP', 'expr' ], 0 ],
  [ 'expr_105' => 'expr', [ 'expr', 'XOROP', 'expr' ], 0 ],
  [ 'expr_106' => 'expr', [ 'NOTOP', 'expr' ], 0 ],
  [ 'expr_107' => 'expr', [ 'term' ], 0 ],
  [ 'term_108' => 'term', [ 'termbinop' ], 0 ],
  [ 'term_109' => 'term', [ 'termunop' ], 0 ],
  [ 'term_110' => 'term', [ 'term', '?', 'term', ':', 'term' ], 0 ],
  [ 'term_111' => 'term', [ '(', 'argexpr', ')' ], 0 ],
  [ 'term_112' => 'term', [ 'varexpr' ], 0 ],
  [ 'term_113' => 'term', [ 'dynvar' ], 0 ],
  [ 'term_114' => 'term', [ 'indexvar' ], 0 ],
  [ 'term_115' => 'term', [ 'NUM' ], 0 ],
  [ 'term_116' => 'term', [ 'STR' ], 0 ],
  [ 'term_117' => 'term', [ 'funcall' ], 0 ],
  [ 'term_118' => 'term', [ 'objblock' ], 0 ],
  [ 'term_119' => 'term', [ 'RETURN', 'expr' ], 0 ],
  [ 'term_120' => 'term', [ 'term', 'unitspec' ], 0 ],
  [ 'term_121' => 'term', [ 'YADAYADA' ], 0 ],
  [ 'termbinop_122' => 'termbinop', [ 'term', 'ASSIGNOP', 'term' ], 0 ],
  [ 'termbinop_123' => 'termbinop', [ 'term', '=', 'term' ], 0 ],
  [ 'termbinop_124' => 'termbinop', [ 'term', 'ADDOP', 'term' ], 0 ],
  [ 'termbinop_125' => 'termbinop', [ 'term', 'MULOP', 'term' ], 0 ],
  [ 'termbinop_126' => 'termbinop', [ 'term', '%', 'term' ], 0 ],
  [ 'termbinop_127' => 'termbinop', [ 'term', 'POWOP', 'term' ], 0 ],
  [ 'termbinop_128' => 'termbinop', [ 'term', 'RELOP', 'term' ], 0 ],
  [ 'termbinop_129' => 'termbinop', [ 'term', 'DOTDOT', 'term' ], 0 ],
  [ 'termbinop_130' => 'termbinop', [ 'term', 'ANDAND', 'term' ], 0 ],
  [ 'termbinop_131' => 'termbinop', [ 'term', 'OROR', 'term' ], 0 ],
  [ 'termbinop_132' => 'termbinop', [ 'term', 'DORDOR', 'term' ], 0 ],
  [ 'termunop_133' => 'termunop', [ 'ADDOP', 'term' ], 0 ],
  [ 'termunop_134' => 'termunop', [ 'NOT2', 'term' ], 0 ],
  [ 'termunop_135' => 'termunop', [ 'term', 'INCOP' ], 0 ],
  [ 'termunop_136' => 'termunop', [ 'INCOP', 'term' ], 0 ],
  [ 'varexpr_137' => 'varexpr', [ 'simplevar' ], 0 ],
  [ 'varexpr_138' => 'varexpr', [ 'simplevar', 'subexpr' ], 0 ],
  [ 'varexpr_139' => 'varexpr', [ 'varexpr', 'DOT', 'WORD' ], 0 ],
  [ 'varexpr_140' => 'varexpr', [ 'varexpr', 'DOT', 'FUNC', '(', 'listexpr', ')' ], 0 ],
  [ 'dynvar_141' => 'dynvar', [ 'MY', 'simplevar' ], 0 ],
  [ 'simplevar_142' => 'simplevar', [ 'scalar' ], 0 ],
  [ 'simplevar_143' => 'simplevar', [ 'array' ], 0 ],
  [ 'simplevar_144' => 'simplevar', [ 'set' ], 0 ],
  [ 'scalarvar_145' => 'scalarvar', [ 'scalar' ], 0 ],
  [ 'scalarvar_146' => 'scalarvar', [ 'MY', 'scalar' ], 0 ],
  [ 'scalar_147' => 'scalar', [ '$', 'WORD' ], 0 ],
  [ 'array_148' => 'array', [ '@', 'WORD' ], 0 ],
  [ 'set_149' => 'set', [ '%', 'WORD' ], 0 ],
  [ 'indexvar_150' => 'indexvar', [ '$^' ], 0 ],
  [ 'indexvar_151' => 'indexvar', [ '$^', 'NUM' ], 0 ],
  [ 'indexvar_152' => 'indexvar', [ '$^', 'WORD' ], 0 ],
  [ 'subexpr_153' => 'subexpr', [ 'subspec' ], 0 ],
  [ 'subexpr_154' => 'subexpr', [ 'subexpr', 'subspec' ], 0 ],
  [ 'subspec_155' => 'subspec', [ '[', ']' ], 0 ],
  [ 'subspec_156' => 'subspec', [ '[', 'expr', ']' ], 0 ],
  [ 'funcall_157' => 'funcall', [ 'FUNC', '(', 'listexpr', ')' ], 0 ],
  [ 'funcall_158' => 'funcall', [ 'FUNC', '(', 'listexpr', ')', 'DOT', 'WORD' ], 0 ],
  [ 'objblock_159' => 'objblock', [ 'WORD', 'pairblock' ], 0 ],
  [ 'pairblock_160' => 'pairblock', [ '{', 'pairlist', '}' ], 0 ],
  [ 'pairblock_161' => 'pairblock', [ '{', 'pairlist', ',', '}' ], 0 ],
  [ 'pairlist_162' => 'pairlist', [  ], 0 ],
  [ 'pairlist_163' => 'pairlist', [ 'pair' ], 0 ],
  [ 'pairlist_164' => 'pairlist', [ 'pairlist', ',', 'pair' ], 0 ],
  [ 'pair_165' => 'pair', [ 'WORD', ':', 'expr' ], 0 ],
  [ 'flow_166' => 'flow', [ 'scalar', 'MULOP', 'expr', 'FLOWRIGHT', 'scalar' ], 0 ],
  [ 'flow_167' => 'flow', [ 'scalar', 'MULOP', 'expr', 'FLOWLEFT', 'scalar' ], 0 ],
  [ 'flow_168' => 'flow', [ 'scalar', 'FLOWRIGHT', 'scalar', 'MULOP', 'expr' ], 0 ],
  [ 'flow_169' => 'flow', [ 'scalar', 'FLOWLEFT', 'scalar', 'MULOP', 'expr' ], 0 ],
  [ 'flow_170' => 'flow', [ 'scalar', '(', 'expr', ')', 'FLOWRIGHT', 'scalar' ], 0 ],
  [ 'flow_171' => 'flow', [ 'scalar', '(', 'expr', ')', 'FLOWLEFT', 'scalar' ], 0 ],
  [ 'flow_172' => 'flow', [ 'scalar', 'FLOWRIGHT', 'scalar', '(', 'expr', ')' ], 0 ],
  [ 'flow_173' => 'flow', [ 'scalar', 'FLOWLEFT', 'scalar', '(', 'expr', ')' ], 0 ],
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
	default => { ISSEMANTIC => 1 },
	loopword => { ISSEMANTIC => 1 },
	perlseq => { ISSEMANTIC => 1 },
	var => { ISSEMANTIC => 1 },
	error => { ISSEMANTIC => 0 },
},
    yyFILENAME  => 'Parser.eyp',
    yystates =>
[
	{#State 0
		DEFAULT => -6,
		GOTOS => {
			'progstart' => 1,
			'program' => 2
		}
	},
	{#State 1
		DEFAULT => -2,
		GOTOS => {
			'progseq' => 3
		}
	},
	{#State 2
		ACTIONS => {
			'' => 4
		}
	},
	{#State 3
		ACTIONS => {
			'' => -1,
			"%{" => 43,
			'WORD' => 42,
			'PACKAGE' => 44,
			"\@" => 6,
			'PERL' => 45,
			'MY' => 46,
			"%" => 7,
			"\$^" => 47,
			'UNLESS' => 8,
			'NUM' => 48,
			'STEP' => 10,
			"\$" => 50,
			'IF' => 49,
			'loopword' => 11,
			'FOREACH' => 13,
			'ACROSS' => 15,
			'NOTOP' => 52,
			'FINAL' => 18,
			'default' => 55,
			'INCLUDE' => 19,
			"(" => 56,
			'VAR' => 57,
			'INCOP' => 20,
			'NOT2' => 58,
			'FOR' => 24,
			'ADDOP' => 25,
			'FUNC' => 60,
			'UNIT' => 27,
			'RETURN' => 64,
			'INIT' => 65,
			'var' => 29,
			'FUNCTION' => 30,
			'STR' => 32,
			'CALC' => 67,
			"{" => 35,
			'CONST' => 36,
			'USE' => 40,
			'YADAYADA' => 69
		},
		GOTOS => {
			'scalar' => 5,
			'sideff' => 23,
			'function' => 22,
			'include' => 59,
			'term' => 61,
			'loop' => 9,
			'array' => 26,
			'expr' => 63,
			'use' => 62,
			'phase' => 28,
			'termbinop' => 51,
			'flow' => 12,
			'set' => 31,
			'termunop' => 14,
			'line' => 16,
			'cond' => 17,
			'dynvar' => 54,
			'phaseblock' => 53,
			'condword' => 68,
			'perlblock' => 66,
			'across_tl' => 33,
			'funcall' => 34,
			'tl_decl' => 37,
			'package' => 38,
			'unit' => 41,
			'varexpr' => 39,
			'block' => 70,
			'indexvar' => 71,
			'simplevar' => 72,
			'objblock' => 21
		}
	},
	{#State 4
		DEFAULT => 0
	},
	{#State 5
		ACTIONS => {
			'XOROP' => -142,
			"<" => -142,
			'DORDOR' => -142,
			";" => -142,
			'FLOWLEFT' => 73,
			'ADDOP' => -142,
			"%" => -142,
			'ANDOP' => -142,
			'UNLESS' => -142,
			'ASSIGNOP' => -142,
			'IF' => -142,
			"[" => -142,
			'FLOWRIGHT' => 76,
			'POWOP' => -142,
			'DOT' => -142,
			"?" => -142,
			'DOTDOT' => -142,
			'MULOP' => 74,
			'OROP' => -142,
			"=" => -142,
			"(" => 75,
			'ANDAND' => -142,
			'OROR' => -142,
			'RELOP' => -142,
			'INCOP' => -142
		}
	},
	{#State 6
		ACTIONS => {
			'WORD' => 77
		}
	},
	{#State 7
		ACTIONS => {
			'WORD' => 78
		}
	},
	{#State 8
		DEFAULT => -85
	},
	{#State 9
		DEFAULT => -65
	},
	{#State 10
		DEFAULT => -57
	},
	{#State 11
		ACTIONS => {
			"(" => 79
		}
	},
	{#State 12
		ACTIONS => {
			"%{" => -4,
			'WORD' => -4,
			'' => -4,
			"}" => -4,
			'PACKAGE' => -4,
			"\@" => -4,
			'PERL' => -4,
			'MY' => -4,
			"%" => -4,
			"\$^" => -4,
			'UNLESS' => -4,
			'NUM' => -4,
			'STEP' => -4,
			'IF' => -4,
			"\$" => -4,
			'loopword' => -4,
			'FOREACH' => -4,
			'ACROSS' => -4,
			'NOTOP' => -4,
			'FINAL' => -4,
			'default' => -4,
			'INCLUDE' => -4,
			"(" => -4,
			'VAR' => -4,
			'INCOP' => -4,
			'NOT2' => -4,
			'FOR' => -4,
			'ADDOP' => -4,
			'FUNC' => -4,
			'UNIT' => -4,
			'RETURN' => -4,
			'INIT' => -4,
			'FUNCTION' => -4,
			'var' => -4,
			'STR' => -4,
			'CALC' => -4,
			"{" => -4,
			'CONST' => -4,
			'USE' => -4,
			'YADAYADA' => -4
		}
	},
	{#State 13
		DEFAULT => -95,
		GOTOS => {
			'@94-1' => 80
		}
	},
	{#State 14
		DEFAULT => -109
	},
	{#State 15
		ACTIONS => {
			"[" => 81
		},
		GOTOS => {
			'dimlist' => 83,
			'dimspec' => 82
		}
	},
	{#State 16
		DEFAULT => -5
	},
	{#State 17
		DEFAULT => -64
	},
	{#State 18
		DEFAULT => -58
	},
	{#State 19
		ACTIONS => {
			'WORD' => 85,
			'STR' => 84
		}
	},
	{#State 20
		ACTIONS => {
			'WORD' => 42,
			'STR' => 32,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			"(" => 56,
			'YADAYADA' => 69,
			'RETURN' => 64,
			"\$" => 50,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 87,
			'array' => 26,
			'varexpr' => 39,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 21
		DEFAULT => -118
	},
	{#State 22
		DEFAULT => -13
	},
	{#State 23
		ACTIONS => {
			";" => 88
		}
	},
	{#State 24
		ACTIONS => {
			"(" => 89
		}
	},
	{#State 25
		ACTIONS => {
			'WORD' => 42,
			'STR' => 32,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			"(" => 56,
			'YADAYADA' => 69,
			'RETURN' => 64,
			"\$" => 50,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 90,
			'array' => 26,
			'varexpr' => 39,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 26
		DEFAULT => -143
	},
	{#State 27
		ACTIONS => {
			'WORD' => 92
		},
		GOTOS => {
			'wordlist' => 91
		}
	},
	{#State 28
		ACTIONS => {
			'WORD' => -63,
			'NOT2' => -63,
			"\@" => -63,
			'ADDOP' => -63,
			'MY' => -63,
			"%" => -63,
			'FUNC' => -63,
			"\$^" => -63,
			'NUM' => -63,
			'RETURN' => -63,
			"\$" => -63,
			'STR' => -63,
			'NOTOP' => -63,
			"{" => 93,
			"(" => -63,
			'YADAYADA' => -63,
			'INCOP' => -63
		},
		GOTOS => {
			'@62-1' => 94
		}
	},
	{#State 29
		DEFAULT => -7
	},
	{#State 30
		ACTIONS => {
			'WORD' => 95
		}
	},
	{#State 31
		DEFAULT => -144
	},
	{#State 32
		DEFAULT => -116
	},
	{#State 33
		DEFAULT => -14
	},
	{#State 34
		DEFAULT => -117
	},
	{#State 35
		DEFAULT => -48,
		GOTOS => {
			'@47-1' => 96
		}
	},
	{#State 36
		ACTIONS => {
			"\@" => 6,
			"\$" => 50,
			"%" => 7
		},
		GOTOS => {
			'array' => 26,
			'vardecl' => 97,
			'scalar' => 86,
			'simplevar' => 98,
			'set' => 31
		}
	},
	{#State 37
		DEFAULT => -3
	},
	{#State 38
		DEFAULT => -9
	},
	{#State 39
		ACTIONS => {
			"%{" => -112,
			'WORD' => -112,
			'' => -112,
			"}" => -112,
			":" => -112,
			'PACKAGE' => -112,
			'XOROP' => -112,
			"\@" => -112,
			"<" => -112,
			'DORDOR' => -112,
			'PERL' => -112,
			'MY' => -112,
			"%" => -112,
			'ANDOP' => -112,
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
			'DOT' => 99,
			'OROP' => -112,
			'default' => -112,
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
			'FUNCTION' => -112,
			'var' => -112,
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
	{#State 40
		ACTIONS => {
			'WORD' => 100
		}
	},
	{#State 41
		DEFAULT => -12
	},
	{#State 42
		ACTIONS => {
			"{" => 101
		},
		GOTOS => {
			'pairblock' => 102
		}
	},
	{#State 43
		DEFAULT => -52,
		GOTOS => {
			'@51-1' => 103
		}
	},
	{#State 44
		ACTIONS => {
			'WORD' => 104
		}
	},
	{#State 45
		ACTIONS => {
			"{" => 106,
			'FUNCTION' => 105
		}
	},
	{#State 46
		ACTIONS => {
			"\@" => 6,
			"\$" => 50,
			"%" => 7
		},
		GOTOS => {
			'array' => 26,
			'scalar' => 86,
			'simplevar' => 107,
			'set' => 31
		}
	},
	{#State 47
		ACTIONS => {
			"%{" => -150,
			'' => -150,
			"}" => -150,
			":" => -150,
			'WORD' => 108,
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
			'NUM' => 109,
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
			'OROP' => -150,
			'default' => -150,
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
			'FUNCTION' => -150,
			'var' => -150,
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
	{#State 48
		DEFAULT => -115
	},
	{#State 49
		DEFAULT => -84
	},
	{#State 50
		ACTIONS => {
			'WORD' => 110
		}
	},
	{#State 51
		DEFAULT => -108
	},
	{#State 52
		ACTIONS => {
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			'STR' => 32,
			'NOTOP' => 52,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 61,
			'array' => 26,
			'varexpr' => 39,
			'expr' => 111,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 53
		DEFAULT => -61
	},
	{#State 54
		DEFAULT => -113
	},
	{#State 55
		DEFAULT => -8
	},
	{#State 56
		ACTIONS => {
			'WORD' => 42,
			'STR' => 32,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			"(" => 56,
			'YADAYADA' => 69,
			'RETURN' => 64,
			"\$" => 50,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 113,
			'array' => 26,
			'varexpr' => 39,
			'termbinop' => 51,
			'indexvar' => 71,
			'argexpr' => 112,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 57
		ACTIONS => {
			"\@" => 6,
			"\$" => 50,
			"%" => 7
		},
		GOTOS => {
			'array' => 26,
			'vardecl' => 114,
			'scalar' => 86,
			'simplevar' => 98,
			'set' => 31
		}
	},
	{#State 58
		ACTIONS => {
			'WORD' => 42,
			'STR' => 32,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			"(" => 56,
			'YADAYADA' => 69,
			'RETURN' => 64,
			"\$" => 50,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 115,
			'array' => 26,
			'varexpr' => 39,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 59
		DEFAULT => -10
	},
	{#State 60
		ACTIONS => {
			"(" => 116
		}
	},
	{#State 61
		ACTIONS => {
			"%{" => -107,
			'WORD' => -107,
			'' => -107,
			"}" => -107,
			":" => -107,
			'PACKAGE' => -107,
			'XOROP' => -107,
			"\@" => -107,
			'DORDOR' => 118,
			"<" => 117,
			'PERL' => -107,
			'MY' => -107,
			"%" => 119,
			'ANDOP' => -107,
			"\$^" => -107,
			'UNLESS' => -107,
			'NUM' => -107,
			'STEP' => -107,
			'ASSIGNOP' => 120,
			'IF' => -107,
			"\$" => -107,
			'loopword' => -107,
			'FOREACH' => -107,
			"]" => -107,
			'ACROSS' => -107,
			'POWOP' => 128,
			'NOTOP' => -107,
			'FINAL' => -107,
			'OROP' => -107,
			'default' => -107,
			'INCLUDE' => -107,
			"(" => -107,
			'VAR' => -107,
			'ANDAND' => 129,
			'RELOP' => 123,
			'INCOP' => 122,
			'NOT2' => -107,
			";" => -107,
			'FOR' => -107,
			'FLOWLEFT' => -107,
			'ADDOP' => 124,
			"," => -107,
			'FUNC' => -107,
			'UNIT' => -107,
			'RETURN' => -107,
			'INIT' => -107,
			'var' => -107,
			'FUNCTION' => -107,
			'FLOWRIGHT' => -107,
			")" => -107,
			'STR' => -107,
			'CALC' => -107,
			"?" => 125,
			"{" => -107,
			'DOTDOT' => 130,
			'MULOP' => 126,
			'CONST' => -107,
			"=" => 131,
			'USE' => -107,
			'YADAYADA' => -107,
			'OROR' => 127
		},
		GOTOS => {
			'unitspec' => 121
		}
	},
	{#State 62
		DEFAULT => -11
	},
	{#State 63
		ACTIONS => {
			'XOROP' => 135,
			";" => -78,
			'IF' => 136,
			'OROP' => 134,
			'ANDOP' => 132,
			'UNLESS' => 133
		}
	},
	{#State 64
		ACTIONS => {
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			'STR' => 32,
			'NOTOP' => 52,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 61,
			'array' => 26,
			'varexpr' => 39,
			'expr' => 137,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 65
		DEFAULT => -55
	},
	{#State 66
		DEFAULT => -60
	},
	{#State 67
		DEFAULT => -56
	},
	{#State 68
		ACTIONS => {
			"(" => 138
		}
	},
	{#State 69
		DEFAULT => -121
	},
	{#State 70
		DEFAULT => -59
	},
	{#State 71
		DEFAULT => -114
	},
	{#State 72
		ACTIONS => {
			"%{" => -137,
			'WORD' => -137,
			'' => -137,
			"}" => -137,
			":" => -137,
			'PACKAGE' => -137,
			'XOROP' => -137,
			"\@" => -137,
			"<" => -137,
			'DORDOR' => -137,
			'PERL' => -137,
			'MY' => -137,
			"%" => -137,
			'ANDOP' => -137,
			"\$^" => -137,
			'UNLESS' => -137,
			'NUM' => -137,
			'STEP' => -137,
			'ASSIGNOP' => -137,
			'IF' => -137,
			"\$" => -137,
			'loopword' => -137,
			'FOREACH' => -137,
			"[" => 139,
			"]" => -137,
			'POWOP' => -137,
			'ACROSS' => -137,
			'NOTOP' => -137,
			'FINAL' => -137,
			'DOT' => -137,
			'OROP' => -137,
			'default' => -137,
			'INCLUDE' => -137,
			"(" => -137,
			'VAR' => -137,
			'ANDAND' => -137,
			'INCOP' => -137,
			'RELOP' => -137,
			'NOT2' => -137,
			";" => -137,
			'FOR' => -137,
			'FLOWLEFT' => -137,
			'ADDOP' => -137,
			"," => -137,
			'FUNC' => -137,
			'UNIT' => -137,
			'RETURN' => -137,
			'INIT' => -137,
			'FUNCTION' => -137,
			'var' => -137,
			'FLOWRIGHT' => -137,
			")" => -137,
			'STR' => -137,
			'CALC' => -137,
			"?" => -137,
			'DOTDOT' => -137,
			'MULOP' => -137,
			"{" => -137,
			'CONST' => -137,
			"=" => -137,
			'USE' => -137,
			'YADAYADA' => -137,
			'OROR' => -137
		},
		GOTOS => {
			'subexpr' => 141,
			'subspec' => 140
		}
	},
	{#State 73
		ACTIONS => {
			"\$" => 50
		},
		GOTOS => {
			'scalar' => 142
		}
	},
	{#State 74
		ACTIONS => {
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			'STR' => 32,
			'NOTOP' => 52,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 61,
			'array' => 26,
			'varexpr' => 39,
			'expr' => 143,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 75
		ACTIONS => {
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			'STR' => 32,
			'NOTOP' => 52,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 61,
			'array' => 26,
			'varexpr' => 39,
			'expr' => 144,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 76
		ACTIONS => {
			"\$" => 50
		},
		GOTOS => {
			'scalar' => 145
		}
	},
	{#State 77
		DEFAULT => -148
	},
	{#State 78
		DEFAULT => -149
	},
	{#State 79
		DEFAULT => -93,
		GOTOS => {
			'@92-2' => 146
		}
	},
	{#State 80
		ACTIONS => {
			"\$" => 50,
			'MY' => 148
		},
		GOTOS => {
			'scalar' => 147,
			'scalarvar' => 149
		}
	},
	{#State 81
		ACTIONS => {
			'WORD' => 150,
			"\@" => -76,
			"%" => -76
		},
		GOTOS => {
			'label' => 151
		}
	},
	{#State 82
		DEFAULT => -72
	},
	{#State 83
		ACTIONS => {
			"{" => 152,
			"[" => 81
		},
		GOTOS => {
			'dimspec' => 153
		}
	},
	{#State 84
		ACTIONS => {
			";" => 154
		}
	},
	{#State 85
		ACTIONS => {
			";" => 155
		}
	},
	{#State 86
		DEFAULT => -142
	},
	{#State 87
		ACTIONS => {
			"%{" => -136,
			'WORD' => -136,
			'' => -136,
			"}" => -136,
			":" => -136,
			'PACKAGE' => -136,
			'XOROP' => -136,
			"\@" => -136,
			'DORDOR' => -136,
			"<" => 117,
			'PERL' => -136,
			'MY' => -136,
			"%" => -136,
			'ANDOP' => -136,
			"\$^" => -136,
			'UNLESS' => -136,
			'NUM' => -136,
			'STEP' => -136,
			'ASSIGNOP' => -136,
			'IF' => -136,
			"\$" => -136,
			'loopword' => -136,
			'FOREACH' => -136,
			"]" => -136,
			'ACROSS' => -136,
			'POWOP' => -136,
			'NOTOP' => -136,
			'FINAL' => -136,
			'OROP' => -136,
			'default' => -136,
			'INCLUDE' => -136,
			"(" => -136,
			'VAR' => -136,
			'ANDAND' => -136,
			'RELOP' => -136,
			'INCOP' => undef,
			'NOT2' => -136,
			";" => -136,
			'FOR' => -136,
			'FLOWLEFT' => -136,
			'ADDOP' => -136,
			"," => -136,
			'FUNC' => -136,
			'UNIT' => -136,
			'RETURN' => -136,
			'INIT' => -136,
			'var' => -136,
			'FUNCTION' => -136,
			'FLOWRIGHT' => -136,
			")" => -136,
			'STR' => -136,
			'CALC' => -136,
			"?" => -136,
			"{" => -136,
			'DOTDOT' => -136,
			'MULOP' => -136,
			'CONST' => -136,
			"=" => -136,
			'USE' => -136,
			'YADAYADA' => -136,
			'OROR' => -136
		},
		GOTOS => {
			'unitspec' => 121
		}
	},
	{#State 88
		DEFAULT => -66
	},
	{#State 89
		DEFAULT => -97,
		GOTOS => {
			'@96-2' => 156
		}
	},
	{#State 90
		ACTIONS => {
			"%{" => -133,
			'WORD' => -133,
			'' => -133,
			"}" => -133,
			":" => -133,
			'PACKAGE' => -133,
			'XOROP' => -133,
			"\@" => -133,
			'DORDOR' => -133,
			"<" => 117,
			'PERL' => -133,
			'MY' => -133,
			"%" => -133,
			'ANDOP' => -133,
			"\$^" => -133,
			'UNLESS' => -133,
			'NUM' => -133,
			'STEP' => -133,
			'ASSIGNOP' => -133,
			'IF' => -133,
			"\$" => -133,
			'loopword' => -133,
			'FOREACH' => -133,
			"]" => -133,
			'ACROSS' => -133,
			'POWOP' => 128,
			'NOTOP' => -133,
			'FINAL' => -133,
			'OROP' => -133,
			'default' => -133,
			'INCLUDE' => -133,
			"(" => -133,
			'VAR' => -133,
			'ANDAND' => -133,
			'RELOP' => -133,
			'INCOP' => 122,
			'NOT2' => -133,
			";" => -133,
			'FOR' => -133,
			'FLOWLEFT' => -133,
			'ADDOP' => -133,
			"," => -133,
			'FUNC' => -133,
			'UNIT' => -133,
			'RETURN' => -133,
			'INIT' => -133,
			'var' => -133,
			'FUNCTION' => -133,
			'FLOWRIGHT' => -133,
			")" => -133,
			'STR' => -133,
			'CALC' => -133,
			"?" => -133,
			"{" => -133,
			'DOTDOT' => -133,
			'MULOP' => -133,
			'CONST' => -133,
			"=" => -133,
			'USE' => -133,
			'YADAYADA' => -133,
			'OROR' => -133
		},
		GOTOS => {
			'unitspec' => 121
		}
	},
	{#State 91
		ACTIONS => {
			";" => 158,
			"," => 157
		}
	},
	{#State 92
		DEFAULT => -23
	},
	{#State 93
		DEFAULT => -54,
		GOTOS => {
			'@53-2' => 159
		}
	},
	{#State 94
		ACTIONS => {
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			'STR' => 32,
			'NOTOP' => 52,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'sideff' => 160,
			'funcall' => 34,
			'term' => 61,
			'array' => 26,
			'varexpr' => 39,
			'expr' => 63,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 95
		ACTIONS => {
			"(" => 161,
			"<" => -35,
			";" => -35,
			"{" => -35
		},
		GOTOS => {
			'funargs' => 162
		}
	},
	{#State 96
		DEFAULT => -44,
		GOTOS => {
			'stmtseq' => 163
		}
	},
	{#State 97
		ACTIONS => {
			"=" => 164
		}
	},
	{#State 98
		ACTIONS => {
			"<" => 117,
			";" => -37,
			"[" => 81,
			"=" => -37
		},
		GOTOS => {
			'unitspec' => 166,
			'unitopt' => 165,
			'dimspec' => 167
		}
	},
	{#State 99
		ACTIONS => {
			'WORD' => 168,
			'FUNC' => 169
		}
	},
	{#State 100
		ACTIONS => {
			";" => 170
		}
	},
	{#State 101
		ACTIONS => {
			"}" => -162,
			'WORD' => 172,
			"," => -162
		},
		GOTOS => {
			'pair' => 173,
			'pairlist' => 171
		}
	},
	{#State 102
		DEFAULT => -159
	},
	{#State 103
		ACTIONS => {
			'perlseq' => 174
		}
	},
	{#State 104
		ACTIONS => {
			";" => 175
		}
	},
	{#State 105
		ACTIONS => {
			'WORD' => 176
		}
	},
	{#State 106
		DEFAULT => -50,
		GOTOS => {
			'@49-2' => 177
		}
	},
	{#State 107
		DEFAULT => -141
	},
	{#State 108
		DEFAULT => -152
	},
	{#State 109
		DEFAULT => -151
	},
	{#State 110
		DEFAULT => -147
	},
	{#State 111
		ACTIONS => {
			"%{" => -106,
			'WORD' => -106,
			'' => -106,
			"}" => -106,
			":" => -106,
			'PACKAGE' => -106,
			"\@" => -106,
			"<" => -106,
			'DORDOR' => -106,
			'XOROP' => -106,
			'PERL' => -106,
			'MY' => -106,
			"%" => -106,
			'ANDOP' => -106,
			"\$^" => -106,
			'UNLESS' => -106,
			'NUM' => -106,
			'STEP' => -106,
			'ASSIGNOP' => -106,
			'IF' => -106,
			"\$" => -106,
			'loopword' => -106,
			'FOREACH' => -106,
			"]" => -106,
			'POWOP' => -106,
			'ACROSS' => -106,
			'NOTOP' => -106,
			'FINAL' => -106,
			'OROP' => -106,
			'default' => -106,
			'INCLUDE' => -106,
			"(" => -106,
			'VAR' => -106,
			'ANDAND' => -106,
			'INCOP' => -106,
			'RELOP' => -106,
			'NOT2' => -106,
			";" => -106,
			'FOR' => -106,
			'FLOWLEFT' => -106,
			'ADDOP' => -106,
			"," => -106,
			'FUNC' => -106,
			'UNIT' => -106,
			'RETURN' => -106,
			'INIT' => -106,
			'FUNCTION' => -106,
			'var' => -106,
			'FLOWRIGHT' => -106,
			")" => -106,
			'STR' => -106,
			'CALC' => -106,
			"?" => -106,
			'DOTDOT' => -106,
			'MULOP' => -106,
			"{" => -106,
			'CONST' => -106,
			"=" => -106,
			'USE' => -106,
			'YADAYADA' => -106,
			'OROR' => -106
		}
	},
	{#State 112
		ACTIONS => {
			"," => 178,
			")" => 179
		}
	},
	{#State 113
		ACTIONS => {
			'DORDOR' => 118,
			"<" => 117,
			'ADDOP' => 124,
			"," => -102,
			"%" => 119,
			'ASSIGNOP' => 120,
			")" => -102,
			'POWOP' => 128,
			"?" => 125,
			'MULOP' => 126,
			'DOTDOT' => 130,
			"=" => 131,
			'OROR' => 127,
			'ANDAND' => 129,
			'RELOP' => 123,
			'INCOP' => 122
		},
		GOTOS => {
			'unitspec' => 121
		}
	},
	{#State 114
		ACTIONS => {
			";" => 180
		}
	},
	{#State 115
		ACTIONS => {
			"%{" => -134,
			'WORD' => -134,
			'' => -134,
			"}" => -134,
			":" => -134,
			'PACKAGE' => -134,
			'XOROP' => -134,
			"\@" => -134,
			'DORDOR' => -134,
			"<" => 117,
			'PERL' => -134,
			'MY' => -134,
			"%" => -134,
			'ANDOP' => -134,
			"\$^" => -134,
			'UNLESS' => -134,
			'NUM' => -134,
			'STEP' => -134,
			'ASSIGNOP' => -134,
			'IF' => -134,
			"\$" => -134,
			'loopword' => -134,
			'FOREACH' => -134,
			"]" => -134,
			'ACROSS' => -134,
			'POWOP' => 128,
			'NOTOP' => -134,
			'FINAL' => -134,
			'OROP' => -134,
			'default' => -134,
			'INCLUDE' => -134,
			"(" => -134,
			'VAR' => -134,
			'ANDAND' => -134,
			'RELOP' => -134,
			'INCOP' => 122,
			'NOT2' => -134,
			";" => -134,
			'FOR' => -134,
			'FLOWLEFT' => -134,
			'ADDOP' => -134,
			"," => -134,
			'FUNC' => -134,
			'UNIT' => -134,
			'RETURN' => -134,
			'INIT' => -134,
			'var' => -134,
			'FUNCTION' => -134,
			'FLOWRIGHT' => -134,
			")" => -134,
			'STR' => -134,
			'CALC' => -134,
			"?" => -134,
			"{" => -134,
			'DOTDOT' => -134,
			'MULOP' => -134,
			'CONST' => -134,
			"=" => -134,
			'USE' => -134,
			'YADAYADA' => -134,
			'OROR' => -134
		},
		GOTOS => {
			'unitspec' => 121
		}
	},
	{#State 116
		ACTIONS => {
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			")" => -98,
			'STR' => 32,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 113,
			'array' => 26,
			'varexpr' => 39,
			'termbinop' => 51,
			'indexvar' => 71,
			'argexpr' => 181,
			'simplevar' => 72,
			'listexpr' => 182,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 117
		DEFAULT => -40,
		GOTOS => {
			'unitlist' => 183
		}
	},
	{#State 118
		ACTIONS => {
			'WORD' => 42,
			'STR' => 32,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			"(" => 56,
			'YADAYADA' => 69,
			'RETURN' => 64,
			"\$" => 50,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 184,
			'array' => 26,
			'varexpr' => 39,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 119
		ACTIONS => {
			'WORD' => 42,
			'STR' => 32,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			"(" => 56,
			'YADAYADA' => 69,
			'RETURN' => 64,
			"\$" => 50,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 185,
			'array' => 26,
			'varexpr' => 39,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 120
		ACTIONS => {
			'WORD' => 42,
			'STR' => 32,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			"(" => 56,
			'YADAYADA' => 69,
			'RETURN' => 64,
			"\$" => 50,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 186,
			'array' => 26,
			'varexpr' => 39,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 121
		DEFAULT => -120
	},
	{#State 122
		DEFAULT => -135
	},
	{#State 123
		ACTIONS => {
			'WORD' => 42,
			'STR' => 32,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			"(" => 56,
			'YADAYADA' => 69,
			'RETURN' => 64,
			"\$" => 50,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 187,
			'array' => 26,
			'varexpr' => 39,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 124
		ACTIONS => {
			'WORD' => 42,
			'STR' => 32,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			"(" => 56,
			'YADAYADA' => 69,
			'RETURN' => 64,
			"\$" => 50,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 188,
			'array' => 26,
			'varexpr' => 39,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 125
		ACTIONS => {
			'WORD' => 42,
			'STR' => 32,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			"(" => 56,
			'YADAYADA' => 69,
			'RETURN' => 64,
			"\$" => 50,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 189,
			'array' => 26,
			'varexpr' => 39,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 126
		ACTIONS => {
			'WORD' => 42,
			'STR' => 32,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			"(" => 56,
			'YADAYADA' => 69,
			'RETURN' => 64,
			"\$" => 50,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 190,
			'array' => 26,
			'varexpr' => 39,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 127
		ACTIONS => {
			'WORD' => 42,
			'STR' => 32,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			"(" => 56,
			'YADAYADA' => 69,
			'RETURN' => 64,
			"\$" => 50,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 191,
			'array' => 26,
			'varexpr' => 39,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 128
		ACTIONS => {
			'WORD' => 42,
			'STR' => 32,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			"(" => 56,
			'YADAYADA' => 69,
			'RETURN' => 64,
			"\$" => 50,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 192,
			'array' => 26,
			'varexpr' => 39,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 129
		ACTIONS => {
			'WORD' => 42,
			'STR' => 32,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			"(" => 56,
			'YADAYADA' => 69,
			'RETURN' => 64,
			"\$" => 50,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 193,
			'array' => 26,
			'varexpr' => 39,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 130
		ACTIONS => {
			'WORD' => 42,
			'STR' => 32,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			"(" => 56,
			'YADAYADA' => 69,
			'RETURN' => 64,
			"\$" => 50,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 194,
			'array' => 26,
			'varexpr' => 39,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 131
		ACTIONS => {
			'WORD' => 42,
			'STR' => 32,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			"(" => 56,
			'YADAYADA' => 69,
			'RETURN' => 64,
			"\$" => 50,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 195,
			'array' => 26,
			'varexpr' => 39,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 132
		ACTIONS => {
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			'STR' => 32,
			'NOTOP' => 52,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 61,
			'array' => 26,
			'varexpr' => 39,
			'expr' => 196,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 133
		ACTIONS => {
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			'STR' => 32,
			'NOTOP' => 52,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 61,
			'array' => 26,
			'varexpr' => 39,
			'expr' => 197,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 134
		ACTIONS => {
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			'STR' => 32,
			'NOTOP' => 52,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 61,
			'array' => 26,
			'varexpr' => 39,
			'expr' => 198,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 135
		ACTIONS => {
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			'STR' => 32,
			'NOTOP' => 52,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 61,
			'array' => 26,
			'varexpr' => 39,
			'expr' => 199,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 136
		ACTIONS => {
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			'STR' => 32,
			'NOTOP' => 52,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 61,
			'array' => 26,
			'varexpr' => 39,
			'expr' => 200,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 137
		ACTIONS => {
			"%{" => -119,
			'WORD' => -119,
			'' => -119,
			"}" => -119,
			":" => -119,
			'PACKAGE' => -119,
			"\@" => -119,
			"<" => -119,
			'DORDOR' => -119,
			'XOROP' => 135,
			'PERL' => -119,
			'MY' => -119,
			"%" => -119,
			'ANDOP' => 132,
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
			'POWOP' => -119,
			'ACROSS' => -119,
			'NOTOP' => -119,
			'FINAL' => -119,
			'OROP' => 134,
			'default' => -119,
			'INCLUDE' => -119,
			"(" => -119,
			'VAR' => -119,
			'ANDAND' => -119,
			'INCOP' => -119,
			'RELOP' => -119,
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
			'var' => -119,
			'FLOWRIGHT' => -119,
			")" => -119,
			'STR' => -119,
			'CALC' => -119,
			"?" => -119,
			'DOTDOT' => -119,
			'MULOP' => -119,
			"{" => -119,
			'CONST' => -119,
			"=" => -119,
			'USE' => -119,
			'YADAYADA' => -119,
			'OROR' => -119
		}
	},
	{#State 138
		DEFAULT => -82,
		GOTOS => {
			'@81-2' => 201
		}
	},
	{#State 139
		ACTIONS => {
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			"]" => 202,
			'STR' => 32,
			'NOTOP' => 52,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 61,
			'array' => 26,
			'varexpr' => 39,
			'expr' => 203,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 140
		DEFAULT => -153
	},
	{#State 141
		ACTIONS => {
			"%{" => -138,
			'WORD' => -138,
			'' => -138,
			"}" => -138,
			":" => -138,
			'PACKAGE' => -138,
			'XOROP' => -138,
			"\@" => -138,
			"<" => -138,
			'DORDOR' => -138,
			'PERL' => -138,
			'MY' => -138,
			"%" => -138,
			'ANDOP' => -138,
			"\$^" => -138,
			'UNLESS' => -138,
			'NUM' => -138,
			'STEP' => -138,
			'ASSIGNOP' => -138,
			'IF' => -138,
			"\$" => -138,
			'loopword' => -138,
			'FOREACH' => -138,
			"[" => 139,
			"]" => -138,
			'POWOP' => -138,
			'ACROSS' => -138,
			'NOTOP' => -138,
			'FINAL' => -138,
			'DOT' => -138,
			'OROP' => -138,
			'default' => -138,
			'INCLUDE' => -138,
			"(" => -138,
			'VAR' => -138,
			'ANDAND' => -138,
			'INCOP' => -138,
			'RELOP' => -138,
			'NOT2' => -138,
			";" => -138,
			'FOR' => -138,
			'FLOWLEFT' => -138,
			'ADDOP' => -138,
			"," => -138,
			'FUNC' => -138,
			'UNIT' => -138,
			'RETURN' => -138,
			'INIT' => -138,
			'FUNCTION' => -138,
			'var' => -138,
			'FLOWRIGHT' => -138,
			")" => -138,
			'STR' => -138,
			'CALC' => -138,
			"?" => -138,
			'DOTDOT' => -138,
			'MULOP' => -138,
			"{" => -138,
			'CONST' => -138,
			"=" => -138,
			'USE' => -138,
			'YADAYADA' => -138,
			'OROR' => -138
		},
		GOTOS => {
			'subspec' => 204
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
			'XOROP' => 135,
			'FLOWLEFT' => 207,
			'OROP' => 134,
			'FLOWRIGHT' => 208,
			'ANDOP' => 132
		}
	},
	{#State 144
		ACTIONS => {
			'XOROP' => 135,
			'OROP' => 134,
			")" => 209,
			'ANDOP' => 132
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
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			'STR' => 32,
			'NOTOP' => 52,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 61,
			'array' => 26,
			'varexpr' => 39,
			'expr' => 212,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 147
		DEFAULT => -145
	},
	{#State 148
		ACTIONS => {
			"\$" => 50
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
			"\@" => 6,
			"%" => 7
		},
		GOTOS => {
			'array' => 216,
			'set' => 217
		}
	},
	{#State 152
		DEFAULT => -43,
		GOTOS => {
			'@42-3' => 218
		}
	},
	{#State 153
		DEFAULT => -73
	},
	{#State 154
		DEFAULT => -20
	},
	{#State 155
		DEFAULT => -19
	},
	{#State 156
		ACTIONS => {
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			'STR' => 32,
			'NOTOP' => 52,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 61,
			'array' => 26,
			'varexpr' => 39,
			'expr' => 219,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 157
		ACTIONS => {
			'WORD' => 220
		}
	},
	{#State 158
		DEFAULT => -22
	},
	{#State 159
		DEFAULT => -44,
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
			"\$" => 50,
			")" => -34
		},
		GOTOS => {
			'scalar' => 223,
			'STAR-2' => 224,
			'STAR-1' => 225
		}
	},
	{#State 162
		ACTIONS => {
			"<" => 117,
			";" => -37,
			"{" => -37
		},
		GOTOS => {
			'unitspec' => 166,
			'unitopt' => 226
		}
	},
	{#State 163
		ACTIONS => {
			"%{" => 43,
			'WORD' => 42,
			"}" => 227,
			"\@" => 6,
			'PERL' => 230,
			'MY' => 46,
			"%" => 7,
			"\$^" => 47,
			'UNLESS' => 8,
			'NUM' => 48,
			'STEP' => 10,
			'IF' => 49,
			"\$" => 50,
			'loopword' => 11,
			'FOREACH' => 13,
			'ACROSS' => 228,
			'NOTOP' => 52,
			'FINAL' => 18,
			"(" => 56,
			'VAR' => 57,
			'INCOP' => 20,
			'NOT2' => 58,
			'FOR' => 24,
			'ADDOP' => 25,
			'FUNC' => 60,
			'RETURN' => 64,
			'INIT' => 65,
			'STR' => 32,
			'CALC' => 67,
			"{" => 35,
			'CONST' => 36,
			'YADAYADA' => 69
		},
		GOTOS => {
			'scalar' => 86,
			'sideff' => 23,
			'term' => 61,
			'loop' => 9,
			'array' => 26,
			'expr' => 63,
			'phase' => 28,
			'termbinop' => 51,
			'set' => 31,
			'termunop' => 14,
			'line' => 229,
			'cond' => 17,
			'dynvar' => 54,
			'phaseblock' => 53,
			'perlblock' => 66,
			'condword' => 68,
			'funcall' => 34,
			'across' => 231,
			'varexpr' => 39,
			'block' => 70,
			'indexvar' => 71,
			'simplevar' => 72,
			'objblock' => 21
		}
	},
	{#State 164
		DEFAULT => -69,
		GOTOS => {
			'@68-3' => 232
		}
	},
	{#State 165
		DEFAULT => -16
	},
	{#State 166
		DEFAULT => -38
	},
	{#State 167
		ACTIONS => {
			"<" => 117,
			";" => -37,
			"=" => -37
		},
		GOTOS => {
			'unitspec' => 166,
			'unitopt' => 233
		}
	},
	{#State 168
		DEFAULT => -139
	},
	{#State 169
		ACTIONS => {
			"(" => 234
		}
	},
	{#State 170
		DEFAULT => -21
	},
	{#State 171
		ACTIONS => {
			"}" => 235,
			"," => 236
		}
	},
	{#State 172
		ACTIONS => {
			":" => 237
		}
	},
	{#State 173
		DEFAULT => -163
	},
	{#State 174
		ACTIONS => {
			"%}" => 238
		}
	},
	{#State 175
		DEFAULT => -18
	},
	{#State 176
		ACTIONS => {
			"(" => 161,
			"<" => -35,
			";" => -35,
			"{" => -35
		},
		GOTOS => {
			'funargs' => 239
		}
	},
	{#State 177
		ACTIONS => {
			'perlseq' => 240
		}
	},
	{#State 178
		ACTIONS => {
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			"," => -100,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			")" => -100,
			'STR' => 32,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 241,
			'array' => 26,
			'varexpr' => 39,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 179
		DEFAULT => -111
	},
	{#State 180
		DEFAULT => -67
	},
	{#State 181
		ACTIONS => {
			"," => 178,
			")" => -99
		}
	},
	{#State 182
		ACTIONS => {
			")" => 242
		}
	},
	{#State 183
		ACTIONS => {
			'UNIT' => 243,
			">" => 244
		}
	},
	{#State 184
		ACTIONS => {
			"%{" => -132,
			'WORD' => -132,
			'' => -132,
			"}" => -132,
			":" => -132,
			'PACKAGE' => -132,
			'XOROP' => -132,
			"\@" => -132,
			'DORDOR' => -132,
			"<" => 117,
			'PERL' => -132,
			'MY' => -132,
			"%" => 119,
			'ANDOP' => -132,
			"\$^" => -132,
			'UNLESS' => -132,
			'NUM' => -132,
			'STEP' => -132,
			'ASSIGNOP' => -132,
			'IF' => -132,
			"\$" => -132,
			'loopword' => -132,
			'FOREACH' => -132,
			"]" => -132,
			'ACROSS' => -132,
			'POWOP' => 128,
			'NOTOP' => -132,
			'FINAL' => -132,
			'OROP' => -132,
			'default' => -132,
			'INCLUDE' => -132,
			"(" => -132,
			'VAR' => -132,
			'ANDAND' => 129,
			'RELOP' => 123,
			'INCOP' => 122,
			'NOT2' => -132,
			";" => -132,
			'FOR' => -132,
			'FLOWLEFT' => -132,
			'ADDOP' => 124,
			"," => -132,
			'FUNC' => -132,
			'UNIT' => -132,
			'RETURN' => -132,
			'INIT' => -132,
			'var' => -132,
			'FUNCTION' => -132,
			'FLOWRIGHT' => -132,
			")" => -132,
			'STR' => -132,
			'CALC' => -132,
			"?" => -132,
			"{" => -132,
			'DOTDOT' => -132,
			'MULOP' => 126,
			'CONST' => -132,
			"=" => -132,
			'USE' => -132,
			'YADAYADA' => -132,
			'OROR' => -132
		},
		GOTOS => {
			'unitspec' => 121
		}
	},
	{#State 185
		ACTIONS => {
			"%{" => -126,
			'WORD' => -126,
			'' => -126,
			"}" => -126,
			":" => -126,
			'PACKAGE' => -126,
			'XOROP' => -126,
			"\@" => -126,
			'DORDOR' => -126,
			"<" => 117,
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
			'POWOP' => 128,
			'NOTOP' => -126,
			'FINAL' => -126,
			'OROP' => -126,
			'default' => -126,
			'INCLUDE' => -126,
			"(" => -126,
			'VAR' => -126,
			'ANDAND' => -126,
			'RELOP' => -126,
			'INCOP' => 122,
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
			'var' => -126,
			'FUNCTION' => -126,
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
			'unitspec' => 121
		}
	},
	{#State 186
		ACTIONS => {
			"%{" => -122,
			'WORD' => -122,
			'' => -122,
			"}" => -122,
			":" => -122,
			'PACKAGE' => -122,
			'XOROP' => -122,
			"\@" => -122,
			'DORDOR' => 118,
			"<" => 117,
			'PERL' => -122,
			'MY' => -122,
			"%" => 119,
			'ANDOP' => -122,
			"\$^" => -122,
			'UNLESS' => -122,
			'NUM' => -122,
			'STEP' => -122,
			'ASSIGNOP' => 120,
			'IF' => -122,
			"\$" => -122,
			'loopword' => -122,
			'FOREACH' => -122,
			"]" => -122,
			'ACROSS' => -122,
			'POWOP' => 128,
			'NOTOP' => -122,
			'FINAL' => -122,
			'OROP' => -122,
			'default' => -122,
			'INCLUDE' => -122,
			"(" => -122,
			'VAR' => -122,
			'ANDAND' => 129,
			'RELOP' => 123,
			'INCOP' => 122,
			'NOT2' => -122,
			";" => -122,
			'FOR' => -122,
			'FLOWLEFT' => -122,
			'ADDOP' => 124,
			"," => -122,
			'FUNC' => -122,
			'UNIT' => -122,
			'RETURN' => -122,
			'INIT' => -122,
			'var' => -122,
			'FUNCTION' => -122,
			'FLOWRIGHT' => -122,
			")" => -122,
			'STR' => -122,
			'CALC' => -122,
			"?" => 125,
			"{" => -122,
			'DOTDOT' => 130,
			'MULOP' => 126,
			'CONST' => -122,
			"=" => 131,
			'USE' => -122,
			'YADAYADA' => -122,
			'OROR' => 127
		},
		GOTOS => {
			'unitspec' => 121
		}
	},
	{#State 187
		ACTIONS => {
			"%{" => -128,
			'WORD' => -128,
			'' => -128,
			"}" => -128,
			":" => -128,
			'PACKAGE' => -128,
			'XOROP' => -128,
			"\@" => -128,
			'DORDOR' => -128,
			"<" => 117,
			'PERL' => -128,
			'MY' => -128,
			"%" => 119,
			'ANDOP' => -128,
			"\$^" => -128,
			'UNLESS' => -128,
			'NUM' => -128,
			'STEP' => -128,
			'ASSIGNOP' => -128,
			'IF' => -128,
			"\$" => -128,
			'loopword' => -128,
			'FOREACH' => -128,
			"]" => -128,
			'ACROSS' => -128,
			'POWOP' => 128,
			'NOTOP' => -128,
			'FINAL' => -128,
			'OROP' => -128,
			'default' => -128,
			'INCLUDE' => -128,
			"(" => -128,
			'VAR' => -128,
			'ANDAND' => -128,
			'RELOP' => undef,
			'INCOP' => 122,
			'NOT2' => -128,
			";" => -128,
			'FOR' => -128,
			'FLOWLEFT' => -128,
			'ADDOP' => 124,
			"," => -128,
			'FUNC' => -128,
			'UNIT' => -128,
			'RETURN' => -128,
			'INIT' => -128,
			'var' => -128,
			'FUNCTION' => -128,
			'FLOWRIGHT' => -128,
			")" => -128,
			'STR' => -128,
			'CALC' => -128,
			"?" => -128,
			"{" => -128,
			'DOTDOT' => -128,
			'MULOP' => 126,
			'CONST' => -128,
			"=" => -128,
			'USE' => -128,
			'YADAYADA' => -128,
			'OROR' => -128
		},
		GOTOS => {
			'unitspec' => 121
		}
	},
	{#State 188
		ACTIONS => {
			"%{" => -124,
			'WORD' => -124,
			'' => -124,
			"}" => -124,
			":" => -124,
			'PACKAGE' => -124,
			'XOROP' => -124,
			"\@" => -124,
			'DORDOR' => -124,
			"<" => 117,
			'PERL' => -124,
			'MY' => -124,
			"%" => 119,
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
			'POWOP' => 128,
			'NOTOP' => -124,
			'FINAL' => -124,
			'OROP' => -124,
			'default' => -124,
			'INCLUDE' => -124,
			"(" => -124,
			'VAR' => -124,
			'ANDAND' => -124,
			'RELOP' => -124,
			'INCOP' => 122,
			'NOT2' => -124,
			";" => -124,
			'FOR' => -124,
			'FLOWLEFT' => -124,
			'ADDOP' => -124,
			"," => -124,
			'FUNC' => -124,
			'UNIT' => -124,
			'RETURN' => -124,
			'INIT' => -124,
			'var' => -124,
			'FUNCTION' => -124,
			'FLOWRIGHT' => -124,
			")" => -124,
			'STR' => -124,
			'CALC' => -124,
			"?" => -124,
			"{" => -124,
			'DOTDOT' => -124,
			'MULOP' => 126,
			'CONST' => -124,
			"=" => -124,
			'USE' => -124,
			'YADAYADA' => -124,
			'OROR' => -124
		},
		GOTOS => {
			'unitspec' => 121
		}
	},
	{#State 189
		ACTIONS => {
			":" => 245,
			"?" => 125,
			'DORDOR' => 118,
			"<" => 117,
			'DOTDOT' => 130,
			'MULOP' => 126,
			'ADDOP' => 124,
			"%" => 119,
			"=" => 131,
			'ASSIGNOP' => 120,
			'ANDAND' => 129,
			'OROR' => 127,
			'POWOP' => 128,
			'INCOP' => 122,
			'RELOP' => 123
		},
		GOTOS => {
			'unitspec' => 121
		}
	},
	{#State 190
		ACTIONS => {
			"%{" => -125,
			'WORD' => -125,
			'' => -125,
			"}" => -125,
			":" => -125,
			'PACKAGE' => -125,
			'XOROP' => -125,
			"\@" => -125,
			'DORDOR' => -125,
			"<" => 117,
			'PERL' => -125,
			'MY' => -125,
			"%" => -125,
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
			'POWOP' => 128,
			'NOTOP' => -125,
			'FINAL' => -125,
			'OROP' => -125,
			'default' => -125,
			'INCLUDE' => -125,
			"(" => -125,
			'VAR' => -125,
			'ANDAND' => -125,
			'RELOP' => -125,
			'INCOP' => 122,
			'NOT2' => -125,
			";" => -125,
			'FOR' => -125,
			'FLOWLEFT' => -125,
			'ADDOP' => -125,
			"," => -125,
			'FUNC' => -125,
			'UNIT' => -125,
			'RETURN' => -125,
			'INIT' => -125,
			'var' => -125,
			'FUNCTION' => -125,
			'FLOWRIGHT' => -125,
			")" => -125,
			'STR' => -125,
			'CALC' => -125,
			"?" => -125,
			"{" => -125,
			'DOTDOT' => -125,
			'MULOP' => -125,
			'CONST' => -125,
			"=" => -125,
			'USE' => -125,
			'YADAYADA' => -125,
			'OROR' => -125
		},
		GOTOS => {
			'unitspec' => 121
		}
	},
	{#State 191
		ACTIONS => {
			"%{" => -131,
			'WORD' => -131,
			'' => -131,
			"}" => -131,
			":" => -131,
			'PACKAGE' => -131,
			'XOROP' => -131,
			"\@" => -131,
			'DORDOR' => -131,
			"<" => 117,
			'PERL' => -131,
			'MY' => -131,
			"%" => 119,
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
			"]" => -131,
			'ACROSS' => -131,
			'POWOP' => 128,
			'NOTOP' => -131,
			'FINAL' => -131,
			'OROP' => -131,
			'default' => -131,
			'INCLUDE' => -131,
			"(" => -131,
			'VAR' => -131,
			'ANDAND' => 129,
			'RELOP' => 123,
			'INCOP' => 122,
			'NOT2' => -131,
			";" => -131,
			'FOR' => -131,
			'FLOWLEFT' => -131,
			'ADDOP' => 124,
			"," => -131,
			'FUNC' => -131,
			'UNIT' => -131,
			'RETURN' => -131,
			'INIT' => -131,
			'var' => -131,
			'FUNCTION' => -131,
			'FLOWRIGHT' => -131,
			")" => -131,
			'STR' => -131,
			'CALC' => -131,
			"?" => -131,
			"{" => -131,
			'DOTDOT' => -131,
			'MULOP' => 126,
			'CONST' => -131,
			"=" => -131,
			'USE' => -131,
			'YADAYADA' => -131,
			'OROR' => -131
		},
		GOTOS => {
			'unitspec' => 121
		}
	},
	{#State 192
		ACTIONS => {
			"%{" => -127,
			'WORD' => -127,
			'' => -127,
			"}" => -127,
			":" => -127,
			'PACKAGE' => -127,
			'XOROP' => -127,
			"\@" => -127,
			'DORDOR' => -127,
			"<" => 117,
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
			'POWOP' => 128,
			'NOTOP' => -127,
			'FINAL' => -127,
			'OROP' => -127,
			'default' => -127,
			'INCLUDE' => -127,
			"(" => -127,
			'VAR' => -127,
			'ANDAND' => -127,
			'RELOP' => -127,
			'INCOP' => 122,
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
			'var' => -127,
			'FUNCTION' => -127,
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
			'unitspec' => 121
		}
	},
	{#State 193
		ACTIONS => {
			"%{" => -130,
			'WORD' => -130,
			'' => -130,
			"}" => -130,
			":" => -130,
			'PACKAGE' => -130,
			'XOROP' => -130,
			"\@" => -130,
			'DORDOR' => -130,
			"<" => 117,
			'PERL' => -130,
			'MY' => -130,
			"%" => 119,
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
			"]" => -130,
			'ACROSS' => -130,
			'POWOP' => 128,
			'NOTOP' => -130,
			'FINAL' => -130,
			'OROP' => -130,
			'default' => -130,
			'INCLUDE' => -130,
			"(" => -130,
			'VAR' => -130,
			'ANDAND' => -130,
			'RELOP' => 123,
			'INCOP' => 122,
			'NOT2' => -130,
			";" => -130,
			'FOR' => -130,
			'FLOWLEFT' => -130,
			'ADDOP' => 124,
			"," => -130,
			'FUNC' => -130,
			'UNIT' => -130,
			'RETURN' => -130,
			'INIT' => -130,
			'var' => -130,
			'FUNCTION' => -130,
			'FLOWRIGHT' => -130,
			")" => -130,
			'STR' => -130,
			'CALC' => -130,
			"?" => -130,
			"{" => -130,
			'DOTDOT' => -130,
			'MULOP' => 126,
			'CONST' => -130,
			"=" => -130,
			'USE' => -130,
			'YADAYADA' => -130,
			'OROR' => -130
		},
		GOTOS => {
			'unitspec' => 121
		}
	},
	{#State 194
		ACTIONS => {
			"%{" => -129,
			'WORD' => -129,
			'' => -129,
			"}" => -129,
			":" => -129,
			'PACKAGE' => -129,
			'XOROP' => -129,
			"\@" => -129,
			'DORDOR' => 118,
			"<" => 117,
			'PERL' => -129,
			'MY' => -129,
			"%" => 119,
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
			'POWOP' => 128,
			'NOTOP' => -129,
			'FINAL' => -129,
			'OROP' => -129,
			'default' => -129,
			'INCLUDE' => -129,
			"(" => -129,
			'VAR' => -129,
			'ANDAND' => 129,
			'RELOP' => 123,
			'INCOP' => 122,
			'NOT2' => -129,
			";" => -129,
			'FOR' => -129,
			'FLOWLEFT' => -129,
			'ADDOP' => 124,
			"," => -129,
			'FUNC' => -129,
			'UNIT' => -129,
			'RETURN' => -129,
			'INIT' => -129,
			'var' => -129,
			'FUNCTION' => -129,
			'FLOWRIGHT' => -129,
			")" => -129,
			'STR' => -129,
			'CALC' => -129,
			"?" => -129,
			"{" => -129,
			'DOTDOT' => undef,
			'MULOP' => 126,
			'CONST' => -129,
			"=" => -129,
			'USE' => -129,
			'YADAYADA' => -129,
			'OROR' => 127
		},
		GOTOS => {
			'unitspec' => 121
		}
	},
	{#State 195
		ACTIONS => {
			"%{" => -123,
			'WORD' => -123,
			'' => -123,
			"}" => -123,
			":" => -123,
			'PACKAGE' => -123,
			'XOROP' => -123,
			"\@" => -123,
			'DORDOR' => 118,
			"<" => 117,
			'PERL' => -123,
			'MY' => -123,
			"%" => 119,
			'ANDOP' => -123,
			"\$^" => -123,
			'UNLESS' => -123,
			'NUM' => -123,
			'STEP' => -123,
			'ASSIGNOP' => 120,
			'IF' => -123,
			"\$" => -123,
			'loopword' => -123,
			'FOREACH' => -123,
			"]" => -123,
			'ACROSS' => -123,
			'POWOP' => 128,
			'NOTOP' => -123,
			'FINAL' => -123,
			'OROP' => -123,
			'default' => -123,
			'INCLUDE' => -123,
			"(" => -123,
			'VAR' => -123,
			'ANDAND' => 129,
			'RELOP' => 123,
			'INCOP' => 122,
			'NOT2' => -123,
			";" => -123,
			'FOR' => -123,
			'FLOWLEFT' => -123,
			'ADDOP' => 124,
			"," => -123,
			'FUNC' => -123,
			'UNIT' => -123,
			'RETURN' => -123,
			'INIT' => -123,
			'var' => -123,
			'FUNCTION' => -123,
			'FLOWRIGHT' => -123,
			")" => -123,
			'STR' => -123,
			'CALC' => -123,
			"?" => 125,
			"{" => -123,
			'DOTDOT' => 130,
			'MULOP' => 126,
			'CONST' => -123,
			"=" => 131,
			'USE' => -123,
			'YADAYADA' => -123,
			'OROR' => 127
		},
		GOTOS => {
			'unitspec' => 121
		}
	},
	{#State 196
		ACTIONS => {
			"%{" => -103,
			'WORD' => -103,
			'' => -103,
			"}" => -103,
			":" => -103,
			'PACKAGE' => -103,
			"\@" => -103,
			"<" => -103,
			'DORDOR' => -103,
			'XOROP' => -103,
			'PERL' => -103,
			'MY' => -103,
			"%" => -103,
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
			'POWOP' => -103,
			'ACROSS' => -103,
			'NOTOP' => -103,
			'FINAL' => -103,
			'OROP' => -103,
			'default' => -103,
			'INCLUDE' => -103,
			"(" => -103,
			'VAR' => -103,
			'ANDAND' => -103,
			'INCOP' => -103,
			'RELOP' => -103,
			'NOT2' => -103,
			";" => -103,
			'FOR' => -103,
			'FLOWLEFT' => -103,
			'ADDOP' => -103,
			"," => -103,
			'FUNC' => -103,
			'UNIT' => -103,
			'RETURN' => -103,
			'INIT' => -103,
			'FUNCTION' => -103,
			'var' => -103,
			'FLOWRIGHT' => -103,
			")" => -103,
			'STR' => -103,
			'CALC' => -103,
			"?" => -103,
			'DOTDOT' => -103,
			'MULOP' => -103,
			"{" => -103,
			'CONST' => -103,
			"=" => -103,
			'USE' => -103,
			'YADAYADA' => -103,
			'OROR' => -103
		}
	},
	{#State 197
		ACTIONS => {
			'XOROP' => 135,
			";" => -80,
			'OROP' => 134,
			'ANDOP' => 132
		}
	},
	{#State 198
		ACTIONS => {
			"%{" => -104,
			'WORD' => -104,
			'' => -104,
			"}" => -104,
			":" => -104,
			'PACKAGE' => -104,
			"\@" => -104,
			"<" => -104,
			'DORDOR' => -104,
			'XOROP' => -104,
			'PERL' => -104,
			'MY' => -104,
			"%" => -104,
			'ANDOP' => 132,
			"\$^" => -104,
			'UNLESS' => -104,
			'NUM' => -104,
			'STEP' => -104,
			'ASSIGNOP' => -104,
			'IF' => -104,
			"\$" => -104,
			'loopword' => -104,
			'FOREACH' => -104,
			"]" => -104,
			'POWOP' => -104,
			'ACROSS' => -104,
			'NOTOP' => -104,
			'FINAL' => -104,
			'OROP' => -104,
			'default' => -104,
			'INCLUDE' => -104,
			"(" => -104,
			'VAR' => -104,
			'ANDAND' => -104,
			'INCOP' => -104,
			'RELOP' => -104,
			'NOT2' => -104,
			";" => -104,
			'FOR' => -104,
			'FLOWLEFT' => -104,
			'ADDOP' => -104,
			"," => -104,
			'FUNC' => -104,
			'UNIT' => -104,
			'RETURN' => -104,
			'INIT' => -104,
			'FUNCTION' => -104,
			'var' => -104,
			'FLOWRIGHT' => -104,
			")" => -104,
			'STR' => -104,
			'CALC' => -104,
			"?" => -104,
			'DOTDOT' => -104,
			'MULOP' => -104,
			"{" => -104,
			'CONST' => -104,
			"=" => -104,
			'USE' => -104,
			'YADAYADA' => -104,
			'OROR' => -104
		}
	},
	{#State 199
		ACTIONS => {
			"%{" => -105,
			'WORD' => -105,
			'' => -105,
			"}" => -105,
			":" => -105,
			'PACKAGE' => -105,
			"\@" => -105,
			"<" => -105,
			'DORDOR' => -105,
			'XOROP' => -105,
			'PERL' => -105,
			'MY' => -105,
			"%" => -105,
			'ANDOP' => 132,
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
			'OROP' => -105,
			'default' => -105,
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
			'FUNCTION' => -105,
			'var' => -105,
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
	{#State 200
		ACTIONS => {
			'XOROP' => 135,
			";" => -79,
			'OROP' => 134,
			'ANDOP' => 132
		}
	},
	{#State 201
		ACTIONS => {
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			'STR' => 32,
			'NOTOP' => 52,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 61,
			'array' => 26,
			'varexpr' => 39,
			'expr' => 246,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 202
		DEFAULT => -155
	},
	{#State 203
		ACTIONS => {
			'XOROP' => 135,
			'OROP' => 134,
			"]" => 247,
			'ANDOP' => 132
		}
	},
	{#State 204
		DEFAULT => -154
	},
	{#State 205
		ACTIONS => {
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			'STR' => 32,
			'NOTOP' => 52,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 61,
			'array' => 26,
			'varexpr' => 39,
			'expr' => 248,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 206
		ACTIONS => {
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			'STR' => 32,
			'NOTOP' => 52,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 61,
			'array' => 26,
			'varexpr' => 39,
			'expr' => 249,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 207
		ACTIONS => {
			"\$" => 50
		},
		GOTOS => {
			'scalar' => 250
		}
	},
	{#State 208
		ACTIONS => {
			"\$" => 50
		},
		GOTOS => {
			'scalar' => 251
		}
	},
	{#State 209
		ACTIONS => {
			'FLOWLEFT' => 252,
			'FLOWRIGHT' => 253
		}
	},
	{#State 210
		ACTIONS => {
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			'STR' => 32,
			'NOTOP' => 52,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 61,
			'array' => 26,
			'varexpr' => 39,
			'expr' => 254,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 211
		ACTIONS => {
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			'STR' => 32,
			'NOTOP' => 52,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 61,
			'array' => 26,
			'varexpr' => 39,
			'expr' => 255,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 212
		ACTIONS => {
			'XOROP' => 135,
			'OROP' => 134,
			")" => 256,
			'ANDOP' => 132
		}
	},
	{#State 213
		DEFAULT => -146
	},
	{#State 214
		ACTIONS => {
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			'STR' => 32,
			'NOTOP' => 52,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 61,
			'array' => 26,
			'varexpr' => 39,
			'expr' => 257,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 215
		DEFAULT => -77
	},
	{#State 216
		ACTIONS => {
			"]" => 258
		}
	},
	{#State 217
		ACTIONS => {
			"]" => 259
		}
	},
	{#State 218
		DEFAULT => -2,
		GOTOS => {
			'progseq' => 260
		}
	},
	{#State 219
		ACTIONS => {
			'XOROP' => 135,
			";" => 261,
			'OROP' => 134,
			'ANDOP' => 132
		}
	},
	{#State 220
		DEFAULT => -24
	},
	{#State 221
		ACTIONS => {
			"%{" => 43,
			'WORD' => 42,
			"}" => 262,
			"\@" => 6,
			'PERL' => 230,
			'MY' => 46,
			"%" => 7,
			"\$^" => 47,
			'UNLESS' => 8,
			'NUM' => 48,
			'STEP' => 10,
			'IF' => 49,
			"\$" => 50,
			'loopword' => 11,
			'FOREACH' => 13,
			'ACROSS' => 228,
			'NOTOP' => 52,
			'FINAL' => 18,
			"(" => 56,
			'VAR' => 57,
			'INCOP' => 20,
			'NOT2' => 58,
			'FOR' => 24,
			'ADDOP' => 25,
			'FUNC' => 60,
			'RETURN' => 64,
			'INIT' => 65,
			'STR' => 32,
			'CALC' => 67,
			"{" => 35,
			'CONST' => 36,
			'YADAYADA' => 69
		},
		GOTOS => {
			'scalar' => 86,
			'sideff' => 23,
			'term' => 61,
			'loop' => 9,
			'array' => 26,
			'expr' => 63,
			'phase' => 28,
			'termbinop' => 51,
			'set' => 31,
			'termunop' => 14,
			'line' => 229,
			'cond' => 17,
			'dynvar' => 54,
			'phaseblock' => 53,
			'perlblock' => 66,
			'condword' => 68,
			'funcall' => 34,
			'across' => 231,
			'varexpr' => 39,
			'block' => 70,
			'indexvar' => 71,
			'simplevar' => 72,
			'objblock' => 21
		}
	},
	{#State 222
		DEFAULT => -62
	},
	{#State 223
		DEFAULT => -32
	},
	{#State 224
		ACTIONS => {
			")" => 263
		}
	},
	{#State 225
		ACTIONS => {
			"," => 264,
			")" => -33
		}
	},
	{#State 226
		ACTIONS => {
			";" => 266,
			"{" => 265
		}
	},
	{#State 227
		DEFAULT => -47
	},
	{#State 228
		ACTIONS => {
			"[" => 81
		},
		GOTOS => {
			'dimlist' => 267,
			'dimspec' => 82
		}
	},
	{#State 229
		DEFAULT => -46
	},
	{#State 230
		ACTIONS => {
			"{" => 106
		}
	},
	{#State 231
		DEFAULT => -45
	},
	{#State 232
		ACTIONS => {
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			'STR' => 32,
			'NOTOP' => 52,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 61,
			'array' => 26,
			'varexpr' => 39,
			'expr' => 268,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 233
		DEFAULT => -17
	},
	{#State 234
		ACTIONS => {
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			")" => -98,
			'STR' => 32,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 113,
			'array' => 26,
			'varexpr' => 39,
			'termbinop' => 51,
			'indexvar' => 71,
			'argexpr' => 181,
			'simplevar' => 72,
			'listexpr' => 269,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 235
		DEFAULT => -160
	},
	{#State 236
		ACTIONS => {
			'WORD' => 172,
			"}" => 270
		},
		GOTOS => {
			'pair' => 271
		}
	},
	{#State 237
		ACTIONS => {
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			'STR' => 32,
			'NOTOP' => 52,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 61,
			'array' => 26,
			'varexpr' => 39,
			'expr' => 272,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 238
		DEFAULT => -51
	},
	{#State 239
		ACTIONS => {
			"<" => 117,
			";" => -37,
			"{" => -37
		},
		GOTOS => {
			'unitspec' => 166,
			'unitopt' => 273
		}
	},
	{#State 240
		ACTIONS => {
			"}" => 274
		}
	},
	{#State 241
		ACTIONS => {
			'DORDOR' => 118,
			"<" => 117,
			'ADDOP' => 124,
			"," => -101,
			"%" => 119,
			'ASSIGNOP' => 120,
			")" => -101,
			'POWOP' => 128,
			"?" => 125,
			'MULOP' => 126,
			'DOTDOT' => 130,
			"=" => 131,
			'OROR' => 127,
			'ANDAND' => 129,
			'RELOP' => 123,
			'INCOP' => 122
		},
		GOTOS => {
			'unitspec' => 121
		}
	},
	{#State 242
		ACTIONS => {
			"%{" => -157,
			'WORD' => -157,
			'' => -157,
			"}" => -157,
			":" => -157,
			'PACKAGE' => -157,
			'XOROP' => -157,
			"\@" => -157,
			"<" => -157,
			'DORDOR' => -157,
			'PERL' => -157,
			'MY' => -157,
			"%" => -157,
			'ANDOP' => -157,
			"\$^" => -157,
			'UNLESS' => -157,
			'NUM' => -157,
			'STEP' => -157,
			'ASSIGNOP' => -157,
			'IF' => -157,
			"\$" => -157,
			'loopword' => -157,
			'FOREACH' => -157,
			"]" => -157,
			'POWOP' => -157,
			'ACROSS' => -157,
			'NOTOP' => -157,
			'FINAL' => -157,
			'DOT' => 275,
			'OROP' => -157,
			'default' => -157,
			'INCLUDE' => -157,
			"(" => -157,
			'VAR' => -157,
			'ANDAND' => -157,
			'INCOP' => -157,
			'RELOP' => -157,
			'NOT2' => -157,
			";" => -157,
			'FOR' => -157,
			'FLOWLEFT' => -157,
			'ADDOP' => -157,
			"," => -157,
			'FUNC' => -157,
			'UNIT' => -157,
			'RETURN' => -157,
			'INIT' => -157,
			'FUNCTION' => -157,
			'var' => -157,
			'FLOWRIGHT' => -157,
			")" => -157,
			'STR' => -157,
			'CALC' => -157,
			"?" => -157,
			'DOTDOT' => -157,
			'MULOP' => -157,
			"{" => -157,
			'CONST' => -157,
			"=" => -157,
			'USE' => -157,
			'YADAYADA' => -157,
			'OROR' => -157
		}
	},
	{#State 243
		DEFAULT => -41
	},
	{#State 244
		DEFAULT => -39
	},
	{#State 245
		ACTIONS => {
			'WORD' => 42,
			'STR' => 32,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			"(" => 56,
			'YADAYADA' => 69,
			'RETURN' => 64,
			"\$" => 50,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 276,
			'array' => 26,
			'varexpr' => 39,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 246
		ACTIONS => {
			'XOROP' => 135,
			'OROP' => 134,
			")" => 277,
			'ANDOP' => 132
		}
	},
	{#State 247
		DEFAULT => -156
	},
	{#State 248
		ACTIONS => {
			"%{" => -169,
			'WORD' => -169,
			'' => -169,
			"}" => -169,
			'PACKAGE' => -169,
			"\@" => -169,
			'XOROP' => 135,
			'PERL' => -169,
			'MY' => -169,
			"%" => -169,
			'ANDOP' => 132,
			"\$^" => -169,
			'UNLESS' => -169,
			'NUM' => -169,
			'STEP' => -169,
			'IF' => -169,
			"\$" => -169,
			'loopword' => -169,
			'FOREACH' => -169,
			'ACROSS' => -169,
			'NOTOP' => -169,
			'FINAL' => -169,
			'OROP' => 134,
			'default' => -169,
			'INCLUDE' => -169,
			"(" => -169,
			'VAR' => -169,
			'INCOP' => -169,
			'NOT2' => -169,
			'FOR' => -169,
			'ADDOP' => -169,
			'FUNC' => -169,
			'UNIT' => -169,
			'RETURN' => -169,
			'INIT' => -169,
			'FUNCTION' => -169,
			'var' => -169,
			'STR' => -169,
			'CALC' => -169,
			"{" => -169,
			'CONST' => -169,
			'USE' => -169,
			'YADAYADA' => -169
		}
	},
	{#State 249
		ACTIONS => {
			'XOROP' => 135,
			'OROP' => 134,
			")" => 278,
			'ANDOP' => 132
		}
	},
	{#State 250
		DEFAULT => -167
	},
	{#State 251
		DEFAULT => -166
	},
	{#State 252
		ACTIONS => {
			"\$" => 50
		},
		GOTOS => {
			'scalar' => 279
		}
	},
	{#State 253
		ACTIONS => {
			"\$" => 50
		},
		GOTOS => {
			'scalar' => 280
		}
	},
	{#State 254
		ACTIONS => {
			"%{" => -168,
			'WORD' => -168,
			'' => -168,
			"}" => -168,
			'PACKAGE' => -168,
			"\@" => -168,
			'XOROP' => 135,
			'PERL' => -168,
			'MY' => -168,
			"%" => -168,
			'ANDOP' => 132,
			"\$^" => -168,
			'UNLESS' => -168,
			'NUM' => -168,
			'STEP' => -168,
			'IF' => -168,
			"\$" => -168,
			'loopword' => -168,
			'FOREACH' => -168,
			'ACROSS' => -168,
			'NOTOP' => -168,
			'FINAL' => -168,
			'OROP' => 134,
			'default' => -168,
			'INCLUDE' => -168,
			"(" => -168,
			'VAR' => -168,
			'INCOP' => -168,
			'NOT2' => -168,
			'FOR' => -168,
			'ADDOP' => -168,
			'FUNC' => -168,
			'UNIT' => -168,
			'RETURN' => -168,
			'INIT' => -168,
			'FUNCTION' => -168,
			'var' => -168,
			'STR' => -168,
			'CALC' => -168,
			"{" => -168,
			'CONST' => -168,
			'USE' => -168,
			'YADAYADA' => -168
		}
	},
	{#State 255
		ACTIONS => {
			'XOROP' => 135,
			'OROP' => 134,
			")" => 281,
			'ANDOP' => 132
		}
	},
	{#State 256
		ACTIONS => {
			"{" => 282
		}
	},
	{#State 257
		ACTIONS => {
			'XOROP' => 135,
			'OROP' => 134,
			")" => 283,
			'ANDOP' => 132
		}
	},
	{#State 258
		DEFAULT => -74
	},
	{#State 259
		DEFAULT => -75
	},
	{#State 260
		ACTIONS => {
			"%{" => 43,
			'WORD' => 42,
			"}" => 284,
			'PACKAGE' => 44,
			"\@" => 6,
			'PERL' => 45,
			'MY' => 46,
			"%" => 7,
			"\$^" => 47,
			'UNLESS' => 8,
			'NUM' => 48,
			'STEP' => 10,
			'IF' => 49,
			"\$" => 50,
			'loopword' => 11,
			'FOREACH' => 13,
			'ACROSS' => 15,
			'NOTOP' => 52,
			'FINAL' => 18,
			'default' => 55,
			'INCLUDE' => 19,
			"(" => 56,
			'VAR' => 57,
			'INCOP' => 20,
			'NOT2' => 58,
			'FOR' => 24,
			'ADDOP' => 25,
			'FUNC' => 60,
			'UNIT' => 27,
			'RETURN' => 64,
			'INIT' => 65,
			'FUNCTION' => 30,
			'var' => 29,
			'STR' => 32,
			'CALC' => 67,
			"{" => 35,
			'CONST' => 36,
			'USE' => 40,
			'YADAYADA' => 69
		},
		GOTOS => {
			'scalar' => 5,
			'function' => 22,
			'sideff' => 23,
			'include' => 59,
			'term' => 61,
			'loop' => 9,
			'array' => 26,
			'use' => 62,
			'expr' => 63,
			'phase' => 28,
			'termbinop' => 51,
			'flow' => 12,
			'set' => 31,
			'termunop' => 14,
			'line' => 16,
			'cond' => 17,
			'phaseblock' => 53,
			'dynvar' => 54,
			'perlblock' => 66,
			'condword' => 68,
			'across_tl' => 33,
			'funcall' => 34,
			'tl_decl' => 37,
			'package' => 38,
			'unit' => 41,
			'varexpr' => 39,
			'block' => 70,
			'indexvar' => 71,
			'simplevar' => 72,
			'objblock' => 21
		}
	},
	{#State 261
		ACTIONS => {
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			'STR' => 32,
			'NOTOP' => 52,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 61,
			'array' => 26,
			'varexpr' => 39,
			'expr' => 285,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 262
		DEFAULT => -53
	},
	{#State 263
		DEFAULT => -36
	},
	{#State 264
		ACTIONS => {
			"\$" => 50
		},
		GOTOS => {
			'scalar' => 286
		}
	},
	{#State 265
		DEFAULT => -27,
		GOTOS => {
			'@26-5' => 287
		}
	},
	{#State 266
		DEFAULT => -25
	},
	{#State 267
		ACTIONS => {
			"{" => 288,
			"[" => 81
		},
		GOTOS => {
			'dimspec' => 153
		}
	},
	{#State 268
		ACTIONS => {
			'XOROP' => 135,
			";" => 289,
			'OROP' => 134,
			'ANDOP' => 132
		}
	},
	{#State 269
		ACTIONS => {
			")" => 290
		}
	},
	{#State 270
		DEFAULT => -161
	},
	{#State 271
		DEFAULT => -164
	},
	{#State 272
		ACTIONS => {
			"}" => -165,
			'XOROP' => 135,
			'OROP' => 134,
			"," => -165,
			'ANDOP' => 132
		}
	},
	{#State 273
		ACTIONS => {
			";" => 292,
			"{" => 291
		}
	},
	{#State 274
		DEFAULT => -49
	},
	{#State 275
		ACTIONS => {
			'WORD' => 293
		}
	},
	{#State 276
		ACTIONS => {
			"%{" => -110,
			'WORD' => -110,
			'' => -110,
			"}" => -110,
			":" => -110,
			'PACKAGE' => -110,
			'XOROP' => -110,
			"\@" => -110,
			'DORDOR' => 118,
			"<" => 117,
			'PERL' => -110,
			'MY' => -110,
			"%" => 119,
			'ANDOP' => -110,
			"\$^" => -110,
			'UNLESS' => -110,
			'NUM' => -110,
			'STEP' => -110,
			'ASSIGNOP' => -110,
			'IF' => -110,
			"\$" => -110,
			'loopword' => -110,
			'FOREACH' => -110,
			"]" => -110,
			'ACROSS' => -110,
			'POWOP' => 128,
			'NOTOP' => -110,
			'FINAL' => -110,
			'OROP' => -110,
			'default' => -110,
			'INCLUDE' => -110,
			"(" => -110,
			'VAR' => -110,
			'ANDAND' => 129,
			'RELOP' => 123,
			'INCOP' => 122,
			'NOT2' => -110,
			";" => -110,
			'FOR' => -110,
			'FLOWLEFT' => -110,
			'ADDOP' => 124,
			"," => -110,
			'FUNC' => -110,
			'UNIT' => -110,
			'RETURN' => -110,
			'INIT' => -110,
			'var' => -110,
			'FUNCTION' => -110,
			'FLOWRIGHT' => -110,
			")" => -110,
			'STR' => -110,
			'CALC' => -110,
			"?" => 125,
			"{" => -110,
			'DOTDOT' => 130,
			'MULOP' => 126,
			'CONST' => -110,
			"=" => -110,
			'USE' => -110,
			'YADAYADA' => -110,
			'OROR' => 127
		},
		GOTOS => {
			'unitspec' => 121
		}
	},
	{#State 277
		ACTIONS => {
			"{" => 294
		}
	},
	{#State 278
		DEFAULT => -173
	},
	{#State 279
		DEFAULT => -171
	},
	{#State 280
		DEFAULT => -170
	},
	{#State 281
		DEFAULT => -172
	},
	{#State 282
		DEFAULT => -44,
		GOTOS => {
			'stmtseq' => 295
		}
	},
	{#State 283
		ACTIONS => {
			"{" => 296
		}
	},
	{#State 284
		DEFAULT => -42
	},
	{#State 285
		ACTIONS => {
			'XOROP' => 135,
			";" => 297,
			'OROP' => 134,
			'ANDOP' => 132
		}
	},
	{#State 286
		DEFAULT => -31
	},
	{#State 287
		DEFAULT => -44,
		GOTOS => {
			'stmtseq' => 298
		}
	},
	{#State 288
		DEFAULT => -71,
		GOTOS => {
			'@70-3' => 299
		}
	},
	{#State 289
		DEFAULT => -68
	},
	{#State 290
		DEFAULT => -140
	},
	{#State 291
		DEFAULT => -30,
		GOTOS => {
			'@29-6' => 300
		}
	},
	{#State 292
		DEFAULT => -28
	},
	{#State 293
		DEFAULT => -158
	},
	{#State 294
		DEFAULT => -44,
		GOTOS => {
			'stmtseq' => 301
		}
	},
	{#State 295
		ACTIONS => {
			"%{" => 43,
			'WORD' => 42,
			"}" => 302,
			"\@" => 6,
			'PERL' => 230,
			'MY' => 46,
			"%" => 7,
			"\$^" => 47,
			'UNLESS' => 8,
			'NUM' => 48,
			'STEP' => 10,
			'IF' => 49,
			"\$" => 50,
			'loopword' => 11,
			'FOREACH' => 13,
			'ACROSS' => 228,
			'NOTOP' => 52,
			'FINAL' => 18,
			"(" => 56,
			'VAR' => 57,
			'INCOP' => 20,
			'NOT2' => 58,
			'FOR' => 24,
			'ADDOP' => 25,
			'FUNC' => 60,
			'RETURN' => 64,
			'INIT' => 65,
			'STR' => 32,
			'CALC' => 67,
			"{" => 35,
			'CONST' => 36,
			'YADAYADA' => 69
		},
		GOTOS => {
			'scalar' => 86,
			'sideff' => 23,
			'term' => 61,
			'loop' => 9,
			'array' => 26,
			'expr' => 63,
			'phase' => 28,
			'termbinop' => 51,
			'set' => 31,
			'termunop' => 14,
			'line' => 229,
			'cond' => 17,
			'dynvar' => 54,
			'phaseblock' => 53,
			'perlblock' => 66,
			'condword' => 68,
			'funcall' => 34,
			'across' => 231,
			'varexpr' => 39,
			'block' => 70,
			'indexvar' => 71,
			'simplevar' => 72,
			'objblock' => 21
		}
	},
	{#State 296
		DEFAULT => -44,
		GOTOS => {
			'stmtseq' => 303
		}
	},
	{#State 297
		ACTIONS => {
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			'STR' => 32,
			'NOTOP' => 52,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 61,
			'array' => 26,
			'varexpr' => 39,
			'expr' => 304,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 298
		ACTIONS => {
			"%{" => 43,
			'WORD' => 42,
			"}" => 305,
			"\@" => 6,
			'PERL' => 230,
			'MY' => 46,
			"%" => 7,
			"\$^" => 47,
			'UNLESS' => 8,
			'NUM' => 48,
			'STEP' => 10,
			'IF' => 49,
			"\$" => 50,
			'loopword' => 11,
			'FOREACH' => 13,
			'ACROSS' => 228,
			'NOTOP' => 52,
			'FINAL' => 18,
			"(" => 56,
			'VAR' => 57,
			'INCOP' => 20,
			'NOT2' => 58,
			'FOR' => 24,
			'ADDOP' => 25,
			'FUNC' => 60,
			'RETURN' => 64,
			'INIT' => 65,
			'STR' => 32,
			'CALC' => 67,
			"{" => 35,
			'CONST' => 36,
			'YADAYADA' => 69
		},
		GOTOS => {
			'scalar' => 86,
			'sideff' => 23,
			'term' => 61,
			'loop' => 9,
			'array' => 26,
			'expr' => 63,
			'phase' => 28,
			'termbinop' => 51,
			'set' => 31,
			'termunop' => 14,
			'line' => 229,
			'cond' => 17,
			'dynvar' => 54,
			'phaseblock' => 53,
			'perlblock' => 66,
			'condword' => 68,
			'funcall' => 34,
			'across' => 231,
			'varexpr' => 39,
			'block' => 70,
			'indexvar' => 71,
			'simplevar' => 72,
			'objblock' => 21
		}
	},
	{#State 299
		DEFAULT => -44,
		GOTOS => {
			'stmtseq' => 306
		}
	},
	{#State 300
		ACTIONS => {
			'perlseq' => 307
		}
	},
	{#State 301
		ACTIONS => {
			"%{" => 43,
			'WORD' => 42,
			"}" => 308,
			"\@" => 6,
			'PERL' => 230,
			'MY' => 46,
			"%" => 7,
			"\$^" => 47,
			'UNLESS' => 8,
			'NUM' => 48,
			'STEP' => 10,
			'IF' => 49,
			"\$" => 50,
			'loopword' => 11,
			'FOREACH' => 13,
			'ACROSS' => 228,
			'NOTOP' => 52,
			'FINAL' => 18,
			"(" => 56,
			'VAR' => 57,
			'INCOP' => 20,
			'NOT2' => 58,
			'FOR' => 24,
			'ADDOP' => 25,
			'FUNC' => 60,
			'RETURN' => 64,
			'INIT' => 65,
			'STR' => 32,
			'CALC' => 67,
			"{" => 35,
			'CONST' => 36,
			'YADAYADA' => 69
		},
		GOTOS => {
			'scalar' => 86,
			'sideff' => 23,
			'term' => 61,
			'loop' => 9,
			'array' => 26,
			'expr' => 63,
			'phase' => 28,
			'termbinop' => 51,
			'set' => 31,
			'termunop' => 14,
			'line' => 229,
			'cond' => 17,
			'dynvar' => 54,
			'phaseblock' => 53,
			'perlblock' => 66,
			'condword' => 68,
			'funcall' => 34,
			'across' => 231,
			'varexpr' => 39,
			'block' => 70,
			'indexvar' => 71,
			'simplevar' => 72,
			'objblock' => 21
		}
	},
	{#State 302
		DEFAULT => -92
	},
	{#State 303
		ACTIONS => {
			"%{" => 43,
			'WORD' => 42,
			"}" => 309,
			"\@" => 6,
			'PERL' => 230,
			'MY' => 46,
			"%" => 7,
			"\$^" => 47,
			'UNLESS' => 8,
			'NUM' => 48,
			'STEP' => 10,
			'IF' => 49,
			"\$" => 50,
			'loopword' => 11,
			'FOREACH' => 13,
			'ACROSS' => 228,
			'NOTOP' => 52,
			'FINAL' => 18,
			"(" => 56,
			'VAR' => 57,
			'INCOP' => 20,
			'NOT2' => 58,
			'FOR' => 24,
			'ADDOP' => 25,
			'FUNC' => 60,
			'RETURN' => 64,
			'INIT' => 65,
			'STR' => 32,
			'CALC' => 67,
			"{" => 35,
			'CONST' => 36,
			'YADAYADA' => 69
		},
		GOTOS => {
			'scalar' => 86,
			'sideff' => 23,
			'term' => 61,
			'loop' => 9,
			'array' => 26,
			'expr' => 63,
			'phase' => 28,
			'termbinop' => 51,
			'set' => 31,
			'termunop' => 14,
			'line' => 229,
			'cond' => 17,
			'dynvar' => 54,
			'phaseblock' => 53,
			'perlblock' => 66,
			'condword' => 68,
			'funcall' => 34,
			'across' => 231,
			'varexpr' => 39,
			'block' => 70,
			'indexvar' => 71,
			'simplevar' => 72,
			'objblock' => 21
		}
	},
	{#State 304
		ACTIONS => {
			'XOROP' => 135,
			'OROP' => 134,
			")" => 310,
			'ANDOP' => 132
		}
	},
	{#State 305
		DEFAULT => -26
	},
	{#State 306
		ACTIONS => {
			"%{" => 43,
			'WORD' => 42,
			"}" => 311,
			"\@" => 6,
			'PERL' => 230,
			'MY' => 46,
			"%" => 7,
			"\$^" => 47,
			'UNLESS' => 8,
			'NUM' => 48,
			'STEP' => 10,
			'IF' => 49,
			"\$" => 50,
			'loopword' => 11,
			'FOREACH' => 13,
			'ACROSS' => 228,
			'NOTOP' => 52,
			'FINAL' => 18,
			"(" => 56,
			'VAR' => 57,
			'INCOP' => 20,
			'NOT2' => 58,
			'FOR' => 24,
			'ADDOP' => 25,
			'FUNC' => 60,
			'RETURN' => 64,
			'INIT' => 65,
			'STR' => 32,
			'CALC' => 67,
			"{" => 35,
			'CONST' => 36,
			'YADAYADA' => 69
		},
		GOTOS => {
			'scalar' => 86,
			'sideff' => 23,
			'term' => 61,
			'loop' => 9,
			'array' => 26,
			'expr' => 63,
			'phase' => 28,
			'termbinop' => 51,
			'set' => 31,
			'termunop' => 14,
			'line' => 229,
			'cond' => 17,
			'dynvar' => 54,
			'phaseblock' => 53,
			'perlblock' => 66,
			'condword' => 68,
			'funcall' => 34,
			'across' => 231,
			'varexpr' => 39,
			'block' => 70,
			'indexvar' => 71,
			'simplevar' => 72,
			'objblock' => 21
		}
	},
	{#State 307
		ACTIONS => {
			"}" => 312
		}
	},
	{#State 308
		DEFAULT => -83,
		GOTOS => {
			'@81-8' => 313
		}
	},
	{#State 309
		DEFAULT => -94
	},
	{#State 310
		ACTIONS => {
			"{" => 314
		}
	},
	{#State 311
		DEFAULT => -70
	},
	{#State 312
		DEFAULT => -29
	},
	{#State 313
		ACTIONS => {
			"%{" => -86,
			'WORD' => -86,
			'' => -86,
			"}" => -86,
			'PACKAGE' => -86,
			"\@" => -86,
			'PERL' => -86,
			'MY' => -86,
			"%" => -86,
			"\$^" => -86,
			'UNLESS' => -86,
			'NUM' => -86,
			'STEP' => -86,
			'IF' => -86,
			"\$" => -86,
			'loopword' => -86,
			'FOREACH' => -86,
			'ACROSS' => -86,
			'NOTOP' => -86,
			'FINAL' => -86,
			'ELSE' => 315,
			'default' => -86,
			'INCLUDE' => -86,
			"(" => -86,
			'VAR' => -86,
			'INCOP' => -86,
			'NOT2' => -86,
			'FOR' => -86,
			'ADDOP' => -86,
			'FUNC' => -86,
			'UNIT' => -86,
			'RETURN' => -86,
			'INIT' => -86,
			'FUNCTION' => -86,
			'var' => -86,
			'STR' => -86,
			'CALC' => -86,
			'ELSIF' => 317,
			"{" => -86,
			'CONST' => -86,
			'USE' => -86,
			'YADAYADA' => -86
		},
		GOTOS => {
			'else' => 316
		}
	},
	{#State 314
		DEFAULT => -44,
		GOTOS => {
			'stmtseq' => 318
		}
	},
	{#State 315
		ACTIONS => {
			"{" => 319
		}
	},
	{#State 316
		DEFAULT => -81
	},
	{#State 317
		ACTIONS => {
			"(" => 320
		}
	},
	{#State 318
		ACTIONS => {
			"%{" => 43,
			'WORD' => 42,
			"}" => 321,
			"\@" => 6,
			'PERL' => 230,
			'MY' => 46,
			"%" => 7,
			"\$^" => 47,
			'UNLESS' => 8,
			'NUM' => 48,
			'STEP' => 10,
			'IF' => 49,
			"\$" => 50,
			'loopword' => 11,
			'FOREACH' => 13,
			'ACROSS' => 228,
			'NOTOP' => 52,
			'FINAL' => 18,
			"(" => 56,
			'VAR' => 57,
			'INCOP' => 20,
			'NOT2' => 58,
			'FOR' => 24,
			'ADDOP' => 25,
			'FUNC' => 60,
			'RETURN' => 64,
			'INIT' => 65,
			'STR' => 32,
			'CALC' => 67,
			"{" => 35,
			'CONST' => 36,
			'YADAYADA' => 69
		},
		GOTOS => {
			'scalar' => 86,
			'sideff' => 23,
			'term' => 61,
			'loop' => 9,
			'array' => 26,
			'expr' => 63,
			'phase' => 28,
			'termbinop' => 51,
			'set' => 31,
			'termunop' => 14,
			'line' => 229,
			'cond' => 17,
			'dynvar' => 54,
			'phaseblock' => 53,
			'perlblock' => 66,
			'condword' => 68,
			'funcall' => 34,
			'across' => 231,
			'varexpr' => 39,
			'block' => 70,
			'indexvar' => 71,
			'simplevar' => 72,
			'objblock' => 21
		}
	},
	{#State 319
		DEFAULT => -88,
		GOTOS => {
			'@87-2' => 322
		}
	},
	{#State 320
		DEFAULT => -90,
		GOTOS => {
			'@89-2' => 323
		}
	},
	{#State 321
		DEFAULT => -96
	},
	{#State 322
		DEFAULT => -44,
		GOTOS => {
			'stmtseq' => 324
		}
	},
	{#State 323
		ACTIONS => {
			'WORD' => 42,
			'NOT2' => 58,
			"\@" => 6,
			'ADDOP' => 25,
			'MY' => 46,
			"%" => 7,
			'FUNC' => 60,
			"\$^" => 47,
			'NUM' => 48,
			'RETURN' => 64,
			"\$" => 50,
			'STR' => 32,
			'NOTOP' => 52,
			"(" => 56,
			'YADAYADA' => 69,
			'INCOP' => 20
		},
		GOTOS => {
			'scalar' => 86,
			'dynvar' => 54,
			'funcall' => 34,
			'term' => 61,
			'array' => 26,
			'varexpr' => 39,
			'expr' => 325,
			'termbinop' => 51,
			'indexvar' => 71,
			'simplevar' => 72,
			'termunop' => 14,
			'objblock' => 21,
			'set' => 31
		}
	},
	{#State 324
		ACTIONS => {
			"%{" => 43,
			'WORD' => 42,
			"}" => 326,
			"\@" => 6,
			'PERL' => 230,
			'MY' => 46,
			"%" => 7,
			"\$^" => 47,
			'UNLESS' => 8,
			'NUM' => 48,
			'STEP' => 10,
			'IF' => 49,
			"\$" => 50,
			'loopword' => 11,
			'FOREACH' => 13,
			'ACROSS' => 228,
			'NOTOP' => 52,
			'FINAL' => 18,
			"(" => 56,
			'VAR' => 57,
			'INCOP' => 20,
			'NOT2' => 58,
			'FOR' => 24,
			'ADDOP' => 25,
			'FUNC' => 60,
			'RETURN' => 64,
			'INIT' => 65,
			'STR' => 32,
			'CALC' => 67,
			"{" => 35,
			'CONST' => 36,
			'YADAYADA' => 69
		},
		GOTOS => {
			'scalar' => 86,
			'sideff' => 23,
			'term' => 61,
			'loop' => 9,
			'array' => 26,
			'expr' => 63,
			'phase' => 28,
			'termbinop' => 51,
			'set' => 31,
			'termunop' => 14,
			'line' => 229,
			'cond' => 17,
			'dynvar' => 54,
			'phaseblock' => 53,
			'perlblock' => 66,
			'condword' => 68,
			'funcall' => 34,
			'across' => 231,
			'varexpr' => 39,
			'block' => 70,
			'indexvar' => 71,
			'simplevar' => 72,
			'objblock' => 21
		}
	},
	{#State 325
		ACTIONS => {
			'XOROP' => 135,
			'OROP' => 134,
			")" => 327,
			'ANDOP' => 132
		}
	},
	{#State 326
		DEFAULT => -87
	},
	{#State 327
		ACTIONS => {
			"{" => 328
		}
	},
	{#State 328
		DEFAULT => -44,
		GOTOS => {
			'stmtseq' => 329
		}
	},
	{#State 329
		ACTIONS => {
			"%{" => 43,
			'WORD' => 42,
			"}" => 330,
			"\@" => 6,
			'PERL' => 230,
			'MY' => 46,
			"%" => 7,
			"\$^" => 47,
			'UNLESS' => 8,
			'NUM' => 48,
			'STEP' => 10,
			'IF' => 49,
			"\$" => 50,
			'loopword' => 11,
			'FOREACH' => 13,
			'ACROSS' => 228,
			'NOTOP' => 52,
			'FINAL' => 18,
			"(" => 56,
			'VAR' => 57,
			'INCOP' => 20,
			'NOT2' => 58,
			'FOR' => 24,
			'ADDOP' => 25,
			'FUNC' => 60,
			'RETURN' => 64,
			'INIT' => 65,
			'STR' => 32,
			'CALC' => 67,
			"{" => 35,
			'CONST' => 36,
			'YADAYADA' => 69
		},
		GOTOS => {
			'scalar' => 86,
			'sideff' => 23,
			'term' => 61,
			'loop' => 9,
			'array' => 26,
			'expr' => 63,
			'phase' => 28,
			'termbinop' => 51,
			'set' => 31,
			'termunop' => 14,
			'line' => 229,
			'cond' => 17,
			'dynvar' => 54,
			'phaseblock' => 53,
			'perlblock' => 66,
			'condword' => 68,
			'funcall' => 34,
			'across' => 231,
			'varexpr' => 39,
			'block' => 70,
			'indexvar' => 71,
			'simplevar' => 72,
			'objblock' => 21
		}
	},
	{#State 330
		DEFAULT => -91,
		GOTOS => {
			'@89-8' => 331
		}
	},
	{#State 331
		ACTIONS => {
			"%{" => -86,
			'WORD' => -86,
			'' => -86,
			"}" => -86,
			'PACKAGE' => -86,
			"\@" => -86,
			'PERL' => -86,
			'MY' => -86,
			"%" => -86,
			"\$^" => -86,
			'UNLESS' => -86,
			'NUM' => -86,
			'STEP' => -86,
			'IF' => -86,
			"\$" => -86,
			'loopword' => -86,
			'FOREACH' => -86,
			'ACROSS' => -86,
			'NOTOP' => -86,
			'FINAL' => -86,
			'ELSE' => 315,
			'default' => -86,
			'INCLUDE' => -86,
			"(" => -86,
			'VAR' => -86,
			'INCOP' => -86,
			'NOT2' => -86,
			'FOR' => -86,
			'ADDOP' => -86,
			'FUNC' => -86,
			'UNIT' => -86,
			'RETURN' => -86,
			'INIT' => -86,
			'FUNCTION' => -86,
			'var' => -86,
			'STR' => -86,
			'CALC' => -86,
			'ELSIF' => 317,
			"{" => -86,
			'CONST' => -86,
			'USE' => -86,
			'YADAYADA' => -86
		},
		GOTOS => {
			'else' => 332
		}
	},
	{#State 332
		DEFAULT => -89
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5948 Parser.pm
	],
	[#Rule program_1
		 'program', 2,
sub {
#line 34 "Parser.eyp"
 $_[0]->new_dnode('PROGRAM', $_[2]) }
#line 5955 Parser.pm
	],
	[#Rule progseq_2
		 'progseq', 0,
sub {
#line 38 "Parser.eyp"
 $_[0]->new_node('PROGSEQ') }
#line 5962 Parser.pm
	],
	[#Rule progseq_3
		 'progseq', 2,
sub {
#line 41 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 5969 Parser.pm
	],
	[#Rule progseq_4
		 'progseq', 2,
sub {
#line 44 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 5976 Parser.pm
	],
	[#Rule progseq_5
		 'progseq', 2,
sub {
#line 47 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 5983 Parser.pm
	],
	[#Rule progstart_6
		 'progstart', 0, undef
#line 5987 Parser.pm
	],
	[#Rule tl_decl_7
		 'tl_decl', 1,
sub {
#line 54 "Parser.eyp"
 $_[1] }
#line 5994 Parser.pm
	],
	[#Rule tl_decl_8
		 'tl_decl', 1,
sub {
#line 57 "Parser.eyp"
 $_[1] }
#line 6001 Parser.pm
	],
	[#Rule tl_decl_9
		 'tl_decl', 1,
sub {
#line 60 "Parser.eyp"
 $_[1] }
#line 6008 Parser.pm
	],
	[#Rule tl_decl_10
		 'tl_decl', 1,
sub {
#line 63 "Parser.eyp"
 $_[1] }
#line 6015 Parser.pm
	],
	[#Rule tl_decl_11
		 'tl_decl', 1,
sub {
#line 66 "Parser.eyp"
 $_[1] }
#line 6022 Parser.pm
	],
	[#Rule tl_decl_12
		 'tl_decl', 1,
sub {
#line 69 "Parser.eyp"
 $_[1] }
#line 6029 Parser.pm
	],
	[#Rule tl_decl_13
		 'tl_decl', 1,
sub {
#line 72 "Parser.eyp"
 $_[1] }
#line 6036 Parser.pm
	],
	[#Rule tl_decl_14
		 'tl_decl', 1,
sub {
#line 75 "Parser.eyp"
 $_[1] }
#line 6043 Parser.pm
	],
	[#Rule tl_decl_15
		 'tl_decl', 1,
sub {
#line 78 "Parser.eyp"
 $_[1] }
#line 6050 Parser.pm
	],
	[#Rule vardecl_16
		 'vardecl', 2,
sub {
#line 82 "Parser.eyp"
my $u = $_[2]; my $v = $_[1];  merge_units($v, $u) }
#line 6057 Parser.pm
	],
	[#Rule vardecl_17
		 'vardecl', 3,
sub {
#line 85 "Parser.eyp"
my $u = $_[3]; my $d = $_[2]; my $v = $_[1];  merge_units(add_child($v, $d), $u) }
#line 6064 Parser.pm
	],
	[#Rule package_18
		 'package', 3,
sub {
#line 89 "Parser.eyp"
my $w = $_[2];  $_[0]->set_package($w) }
#line 6071 Parser.pm
	],
	[#Rule include_19
		 'include', 3,
sub {
#line 93 "Parser.eyp"
my $w = $_[2];  $_[0]->parse_input($w . ".mad") }
#line 6078 Parser.pm
	],
	[#Rule include_20
		 'include', 3,
sub {
#line 96 "Parser.eyp"
my $w = $_[2];  $_[0]->parse_input($w) }
#line 6085 Parser.pm
	],
	[#Rule use_21
		 'use', 3,
sub {
#line 100 "Parser.eyp"
my $w = $_[2];  $_[0]->use_perl($w . ".pm") }
#line 6092 Parser.pm
	],
	[#Rule unit_22
		 'unit', 3,
sub {
#line 104 "Parser.eyp"
my $w = $_[2];  declare_units($_[0], $w) }
#line 6099 Parser.pm
	],
	[#Rule wordlist_23
		 'wordlist', 1,
sub {
#line 108 "Parser.eyp"
my $w = $_[1];  $_[0]->new_node('LIST', $_[0]->new_anode('STRING', $w)) }
#line 6106 Parser.pm
	],
	[#Rule wordlist_24
		 'wordlist', 3,
sub {
#line 111 "Parser.eyp"
my $w = $_[3]; my $l = $_[1];  add_child($l, $_[0]->new_anode('STRING', $w)) }
#line 6113 Parser.pm
	],
	[#Rule function_25
		 'function', 5,
sub {
#line 115 "Parser.eyp"
my $u = $_[4]; my $name = $_[2]; my $f = $_[3]; 
			    $_[0]->declare_function($name, $f, 'MAD_FUNC');
			}
#line 6122 Parser.pm
	],
	[#Rule function_26
		 'function', 8,
sub {
#line 126 "Parser.eyp"
my $u = $_[4]; my $q = $_[7]; my $name = $_[2]; my $f = $_[3]; 
			    print "AAA\n";
			    $_[0]->pop_frame('FUNCTION');
			    print "BBB\n";
			    merge_units($_[0]->new_anode('FUNCTION', $f, $q),
					$u);
			}
#line 6135 Parser.pm
	],
	[#Rule _CODE
		 '@26-5', 0,
sub {
#line 120 "Parser.eyp"
my $u = $_[4]; my $name = $_[2]; my $f = $_[3]; 
			    $_[0]->declare_function($name, $f, 'MAD_FUNC');
			    $_[0]->push_frame(tag => 'FUNCTION', name => $name,
					      args => $f, units => $u);
			}
#line 6146 Parser.pm
	],
	[#Rule function_28
		 'function', 6,
sub {
#line 135 "Parser.eyp"
my $u = $_[5]; my $name = $_[3]; my $f = $_[4]; 
			    $_[0]->declare_function($name, $f, 'PERL_FUNC');
			}
#line 6155 Parser.pm
	],
	[#Rule function_29
		 'function', 9,
sub {
#line 146 "Parser.eyp"
my $u = $_[5]; my $q = $_[8]; my $name = $_[3]; my $f = $_[4]; 
			    $_[0]->pop_frame('PERLFUNC');
			    merge_units($_[0]->new_anode('PERLFUNC', $f, $q),
					$u);
			}
#line 6166 Parser.pm
	],
	[#Rule _CODE
		 '@29-6', 0,
sub {
#line 140 "Parser.eyp"
my $u = $_[5]; my $name = $_[3]; my $f = $_[4]; 
			    $_[0]->declare_function($name, $f, 'PERL_FUNC');
			    $_[0]->push_frame(tag => 'PERLFUNC', name => $name,
					      args => $f, units => $u);
			}
#line 6177 Parser.pm
	],
	[#Rule _STAR_LIST
		 'STAR-1', 3,
sub {
#line 154 "Parser.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6184 Parser.pm
	],
	[#Rule _STAR_LIST
		 'STAR-1', 1,
sub {
#line 154 "Parser.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6191 Parser.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 1,
sub {
#line 154 "Parser.eyp"
 { $_[1] } # optimize 
}
#line 6199 Parser.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 0,
sub {
#line 154 "Parser.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6206 Parser.pm
	],
	[#Rule funargs_35
		 'funargs', 0, undef
#line 6210 Parser.pm
	],
	[#Rule funargs_36
		 'funargs', 3,
sub {
#line 155 "Parser.eyp"

			    $_[0]->new_node('LIST', undef, @{$_[2]->{children}});
			}
#line 6219 Parser.pm
	],
	[#Rule unitopt_37
		 'unitopt', 0, undef
#line 6223 Parser.pm
	],
	[#Rule unitopt_38
		 'unitopt', 1,
sub {
#line 163 "Parser.eyp"
 $_[1] }
#line 6230 Parser.pm
	],
	[#Rule unitspec_39
		 'unitspec', 3,
sub {
#line 167 "Parser.eyp"
my $ulist = $_[2];  merge_units($_[0]->new_node('UNITSPEC'), $ulist, 1) }
#line 6237 Parser.pm
	],
	[#Rule unitlist_40
		 'unitlist', 0,
sub {
#line 171 "Parser.eyp"
 $_[0]->new_node('UNITLIST') }
#line 6244 Parser.pm
	],
	[#Rule unitlist_41
		 'unitlist', 2,
sub {
#line 174 "Parser.eyp"

			    my (@u) = $_[0]->validate_unit($_[2]);
			    if ( $u[0] eq 'ERROR' ) {
				$_[0]->YYError();
			    }
			    else {
				add_units($_[1], @u);
			    }
			}
#line 6259 Parser.pm
	],
	[#Rule across_tl_42
		 'across_tl', 6,
sub {
#line 190 "Parser.eyp"
my $q = $_[5]; my $dl = $_[2]; 
			    $_[0]->pop_frame('ACROSS');
			}
#line 6268 Parser.pm
	],
	[#Rule _CODE
		 '@42-3', 0,
sub {
#line 186 "Parser.eyp"
my $dl = $_[2]; 
			    $_[0]->push_frame(tag => 'ACROSS', dimlist => $dl);
			}
#line 6277 Parser.pm
	],
	[#Rule stmtseq_44
		 'stmtseq', 0,
sub {
#line 196 "Parser.eyp"
 $_[0]->new_node('STMTSEQ') }
#line 6284 Parser.pm
	],
	[#Rule stmtseq_45
		 'stmtseq', 2,
sub {
#line 199 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 6291 Parser.pm
	],
	[#Rule stmtseq_46
		 'stmtseq', 2,
sub {
#line 202 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 6298 Parser.pm
	],
	[#Rule block_47
		 'block', 4,
sub {
#line 210 "Parser.eyp"

			    $_[0]->pop_frame('BLOCK');
			    $_[0]->new_dnode('BLOCK', $_[2]);
			}
#line 6308 Parser.pm
	],
	[#Rule _CODE
		 '@47-1', 0,
sub {
#line 206 "Parser.eyp"
 
			    $_[0]->push_frame(tag => 'BLOCK'); 
			}
#line 6317 Parser.pm
	],
	[#Rule perlblock_49
		 'perlblock', 5,
sub {
#line 222 "Parser.eyp"

			    $_[0]->pop_frame('PERLBLOCK');
			}
#line 6326 Parser.pm
	],
	[#Rule _CODE
		 '@49-2', 0,
sub {
#line 217 "Parser.eyp"

			    $_[0]->lex_mode('perl');
			    $_[0]->push_frame(tag => 'PERLBLOCK');
			}
#line 6336 Parser.pm
	],
	[#Rule perlblock_51
		 'perlblock', 4,
sub {
#line 232 "Parser.eyp"

			    $_[0]->pop_frame('PERLBLOCK');
			}
#line 6345 Parser.pm
	],
	[#Rule _CODE
		 '@51-1', 0,
sub {
#line 227 "Parser.eyp"

			    $_[0]->lex_mode('pperl');
			    $_[0]->push_frame(tag => 'PERLBLOCK');
			}
#line 6355 Parser.pm
	],
	[#Rule phaseblock_53
		 'phaseblock', 5,
sub {
#line 242 "Parser.eyp"
my $p = $_[1]; my $q = $_[4]; 
			    $_[0]->new_dnode($p, $q);
			    $_[0]->pop_frame('BLOCK');
			}
#line 6365 Parser.pm
	],
	[#Rule _CODE
		 '@53-2', 0,
sub {
#line 238 "Parser.eyp"
my $p = $_[1]; 
			    $_[0]->push_frame(tag => 'BLOCK', phase => $p);
			}
#line 6374 Parser.pm
	],
	[#Rule phase_55
		 'phase', 1, undef
#line 6378 Parser.pm
	],
	[#Rule phase_56
		 'phase', 1, undef
#line 6382 Parser.pm
	],
	[#Rule phase_57
		 'phase', 1, undef
#line 6386 Parser.pm
	],
	[#Rule phase_58
		 'phase', 1, undef
#line 6390 Parser.pm
	],
	[#Rule line_59
		 'line', 1,
sub {
#line 258 "Parser.eyp"
 $_[1]; }
#line 6397 Parser.pm
	],
	[#Rule line_60
		 'line', 1,
sub {
#line 261 "Parser.eyp"
 $_[1]; }
#line 6404 Parser.pm
	],
	[#Rule line_61
		 'line', 1,
sub {
#line 264 "Parser.eyp"
 $_[1]; }
#line 6411 Parser.pm
	],
	[#Rule line_62
		 'line', 4,
sub {
#line 271 "Parser.eyp"
my $e = $_[3]; my $p = $_[1]; 
			    $_[0]->pop_frame('line');
			    $e;
			}
#line 6421 Parser.pm
	],
	[#Rule _CODE
		 '@62-1', 0,
sub {
#line 267 "Parser.eyp"
my $p = $_[1]; 
			    $_[0]->push_frame(tag => 'line', phase => $p);
			}
#line 6430 Parser.pm
	],
	[#Rule line_64
		 'line', 1,
sub {
#line 277 "Parser.eyp"
 $_[1]; }
#line 6437 Parser.pm
	],
	[#Rule line_65
		 'line', 1,
sub {
#line 280 "Parser.eyp"
 $_[1]; }
#line 6444 Parser.pm
	],
	[#Rule line_66
		 'line', 2,
sub {
#line 283 "Parser.eyp"
my $e = $_[1];  $e; }
#line 6451 Parser.pm
	],
	[#Rule line_67
		 'line', 3,
sub {
#line 286 "Parser.eyp"
my $v = $_[2]; 
			    $_[0]->see_var($v, PLAIN_VAR);
			}
#line 6460 Parser.pm
	],
	[#Rule line_68
		 'line', 6,
sub {
#line 296 "Parser.eyp"
my $e = $_[5]; my $v = $_[2]; 
			    $_[0]->pop_frame('CONST');
			    $_[0]->new_anode('ASSIGN', '=', $v, $e);
			}
#line 6470 Parser.pm
	],
	[#Rule _CODE
		 '@68-3', 0,
sub {
#line 291 "Parser.eyp"
my $v = $_[2]; 
			    $_[0]->see_var($v, CONST_VAR);
			    $_[0]->push_frame(tag => 'CONST', phase => INIT_PHASE);
			}
#line 6480 Parser.pm
	],
	[#Rule across_70
		 'across', 6,
sub {
#line 307 "Parser.eyp"
my $q = $_[5]; my $dl = $_[2]; 
			    $_[0]->pop_frame('ACROSS');
			}
#line 6489 Parser.pm
	],
	[#Rule _CODE
		 '@70-3', 0,
sub {
#line 303 "Parser.eyp"
my $dl = $_[2]; 
			    $_[0]->push_frame(tag => 'ACROSS', dimlist => $dl);
			}
#line 6498 Parser.pm
	],
	[#Rule dimlist_72
		 'dimlist', 1,
sub {
#line 313 "Parser.eyp"
my $d = $_[1];  $_[0]->new_node('DIMLIST', $d); }
#line 6505 Parser.pm
	],
	[#Rule dimlist_73
		 'dimlist', 2,
sub {
#line 316 "Parser.eyp"
my $l = $_[1]; my $d = $_[2];  add_child($l, $d); }
#line 6512 Parser.pm
	],
	[#Rule dimspec_74
		 'dimspec', 4,
sub {
#line 320 "Parser.eyp"
my $l = $_[2]; my $d = $_[3];  add_child($d, $l); }
#line 6519 Parser.pm
	],
	[#Rule dimspec_75
		 'dimspec', 4,
sub {
#line 323 "Parser.eyp"
my $l = $_[2]; my $d = $_[3];  add_child($d, $l); }
#line 6526 Parser.pm
	],
	[#Rule label_76
		 'label', 0, undef
#line 6530 Parser.pm
	],
	[#Rule label_77
		 'label', 2,
sub {
#line 328 "Parser.eyp"
my $w = $_[1];  $_[0]->new_anode('LABEL', $w); }
#line 6537 Parser.pm
	],
	[#Rule sideff_78
		 'sideff', 1,
sub {
#line 332 "Parser.eyp"
 $_[1] }
#line 6544 Parser.pm
	],
	[#Rule sideff_79
		 'sideff', 3,
sub {
#line 335 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('AND', $r, $l) }
#line 6551 Parser.pm
	],
	[#Rule sideff_80
		 'sideff', 3,
sub {
#line 338 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('OR', $r, $l) }
#line 6558 Parser.pm
	],
	[#Rule cond_81
		 'cond', 10, undef
#line 6562 Parser.pm
	],
	[#Rule _CODE
		 '@81-2', 0,
sub {
#line 342 "Parser.eyp"
my $c = $_[1];  $_[0]->push_frame(tag => $c); }
#line 6569 Parser.pm
	],
	[#Rule _CODE
		 '@81-8', 0,
sub {
#line 344 "Parser.eyp"
my $e = $_[4]; my $c = $_[1]; my $q = $_[7];  
			    $_[0]->pop_frame($c);
			    $_[0]->new_node($c, $e, $q);
			}
#line 6579 Parser.pm
	],
	[#Rule condword_84
		 'condword', 1,
sub {
#line 352 "Parser.eyp"
 'IF' }
#line 6586 Parser.pm
	],
	[#Rule condword_85
		 'condword', 1,
sub {
#line 354 "Parser.eyp"
 'UNLESS' }
#line 6593 Parser.pm
	],
	[#Rule else_86
		 'else', 0, undef
#line 6597 Parser.pm
	],
	[#Rule else_87
		 'else', 5,
sub {
#line 364 "Parser.eyp"
my $q = $_[4];  
			    $_[0]->pop_frame('ELSE');
			    $_[0]->new_node('ELSE', $q);
			}
#line 6607 Parser.pm
	],
	[#Rule _CODE
		 '@87-2', 0,
sub {
#line 360 "Parser.eyp"

			    $_[0]->push_frame(tag => 'ELSE');
			}
#line 6616 Parser.pm
	],
	[#Rule else_89
		 'else', 10, undef
#line 6620 Parser.pm
	],
	[#Rule _CODE
		 '@89-2', 0,
sub {
#line 370 "Parser.eyp"
 $_[0]->push_frame(tag => 'ELSIF'); }
#line 6627 Parser.pm
	],
	[#Rule _CODE
		 '@89-8', 0,
sub {
#line 372 "Parser.eyp"
my $e = $_[4]; my $q = $_[7]; 
			    $_[0]->pop_frame('ELSIF');
			    $_[0]->new_node('ELSIF', $e, $q);
			}
#line 6637 Parser.pm
	],
	[#Rule loop_92
		 'loop', 8,
sub {
#line 384 "Parser.eyp"
my $e = $_[4]; my $c = $_[1]; my $q = $_[7]; 
			    $_[0]->pop_frame($c);
			    $_[0]->new_node($c, $e, $q);
			}
#line 6647 Parser.pm
	],
	[#Rule _CODE
		 '@92-2', 0,
sub {
#line 380 "Parser.eyp"
my $c = $_[1]; 
			    $_[0]->push_frame(tag => $c);
			}
#line 6656 Parser.pm
	],
	[#Rule loop_94
		 'loop', 9,
sub {
#line 394 "Parser.eyp"
my $e = $_[5]; my $q = $_[8]; my $i = $_[3]; 
			    $_[0]->see_var($i, ASSIGN_VAR);
			    $_[0]->pop_frame('FOREACH');
			    $_[0]->new_node('FOREACH', $i, $e, $q);
			}
#line 6667 Parser.pm
	],
	[#Rule _CODE
		 '@94-1', 0,
sub {
#line 390 "Parser.eyp"

			    $_[0]->push_frame(tag => 'FOREACH');
			}
#line 6676 Parser.pm
	],
	[#Rule loop_96
		 'loop', 12,
sub {
#line 405 "Parser.eyp"
my $e2 = $_[6]; my $e1 = $_[4]; my $q = $_[11]; my $e3 = $_[8]; 
			    $_[0]->pop_frame('FOR');
			    $_[0]->new_node('FOR', $e1, $e2, $e3, $q);
			}
#line 6686 Parser.pm
	],
	[#Rule _CODE
		 '@96-2', 0,
sub {
#line 401 "Parser.eyp"

			    $_[0]->push_frame('FOR');
			}
#line 6695 Parser.pm
	],
	[#Rule listexpr_98
		 'listexpr', 0, undef
#line 6699 Parser.pm
	],
	[#Rule listexpr_99
		 'listexpr', 1,
sub {
#line 414 "Parser.eyp"
 $_[1] }
#line 6706 Parser.pm
	],
	[#Rule argexpr_100
		 'argexpr', 2,
sub {
#line 418 "Parser.eyp"
 $_[1] }
#line 6713 Parser.pm
	],
	[#Rule argexpr_101
		 'argexpr', 3,
sub {
#line 421 "Parser.eyp"
my $t = $_[3]; 
			    if ( ref $_[1] eq 'LIST' ) {
				push @{$_[1]->{children}}, $t;
				$_[1];
			    }
			    else {
				$_[0]->new_node('LIST', $_[1], $t);
			    }
			}
#line 6728 Parser.pm
	],
	[#Rule argexpr_102
		 'argexpr', 1,
sub {
#line 432 "Parser.eyp"
 $_[1] }
#line 6735 Parser.pm
	],
	[#Rule expr_103
		 'expr', 3,
sub {
#line 436 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('AND', $l, $r) }
#line 6742 Parser.pm
	],
	[#Rule expr_104
		 'expr', 3,
sub {
#line 439 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('OR', $l, $r) }
#line 6749 Parser.pm
	],
	[#Rule expr_105
		 'expr', 3,
sub {
#line 442 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('XOR', $l, $r) }
#line 6756 Parser.pm
	],
	[#Rule expr_106
		 'expr', 2,
sub {
#line 445 "Parser.eyp"
my $e = $_[2];  $_[0]->new_node('NOT', $e) }
#line 6763 Parser.pm
	],
	[#Rule expr_107
		 'expr', 1,
sub {
#line 448 "Parser.eyp"
 $_[1] }
#line 6770 Parser.pm
	],
	[#Rule term_108
		 'term', 1,
sub {
#line 452 "Parser.eyp"
 $_[1] }
#line 6777 Parser.pm
	],
	[#Rule term_109
		 'term', 1,
sub {
#line 455 "Parser.eyp"
 $_[1] }
#line 6784 Parser.pm
	],
	[#Rule term_110
		 'term', 5,
sub {
#line 458 "Parser.eyp"
my $c = $_[5]; my $a = $_[1]; my $b = $_[3];  $_[0]->new_node('TRI', $a, $b, $c) }
#line 6791 Parser.pm
	],
	[#Rule term_111
		 'term', 3,
sub {
#line 461 "Parser.eyp"
 $_[2] }
#line 6798 Parser.pm
	],
	[#Rule term_112
		 'term', 1,
sub {
#line 464 "Parser.eyp"
 $_[1] }
#line 6805 Parser.pm
	],
	[#Rule term_113
		 'term', 1,
sub {
#line 467 "Parser.eyp"
 $_[1] }
#line 6812 Parser.pm
	],
	[#Rule term_114
		 'term', 1,
sub {
#line 470 "Parser.eyp"
 $_[1] }
#line 6819 Parser.pm
	],
	[#Rule term_115
		 'term', 1,
sub {
#line 473 "Parser.eyp"
 $_[0]->new_anode('NUM', $_[1]) }
#line 6826 Parser.pm
	],
	[#Rule term_116
		 'term', 1,
sub {
#line 476 "Parser.eyp"
 $_[0]->new_anode('STR', $_[1]) }
#line 6833 Parser.pm
	],
	[#Rule term_117
		 'term', 1,
sub {
#line 479 "Parser.eyp"
 $_[1] }
#line 6840 Parser.pm
	],
	[#Rule term_118
		 'term', 1,
sub {
#line 482 "Parser.eyp"
 $_[1] }
#line 6847 Parser.pm
	],
	[#Rule term_119
		 'term', 2,
sub {
#line 485 "Parser.eyp"
my $e = $_[2];  $_[0]->new_node('RETURN', $e) }
#line 6854 Parser.pm
	],
	[#Rule term_120
		 'term', 2,
sub {
#line 488 "Parser.eyp"
my $u = $_[2]; my $t = $_[1];  merge_units($t, $u) }
#line 6861 Parser.pm
	],
	[#Rule term_121
		 'term', 1,
sub {
#line 491 "Parser.eyp"
 $_[0]->new_node('YADAYADA'); }
#line 6868 Parser.pm
	],
	[#Rule termbinop_122
		 'termbinop', 3,
sub {
#line 495 "Parser.eyp"
my $l = $_[1]; my $r = $_[3]; my $op = $_[2]; 
			    $_[0]->see_var($l, ASSIGN_VAR);
			    $_[0]->new_anode('ASSIGN', $op, $l, $r);
			}
#line 6878 Parser.pm
	],
	[#Rule termbinop_123
		 'termbinop', 3,
sub {
#line 501 "Parser.eyp"
my $l = $_[1]; my $r = $_[3]; 
			    $_[0]->see_var($l, ASSIGN_VAR);
			    $_[0]->new_anode('ASSIGN', '=', $l, $r);
			}
#line 6888 Parser.pm
	],
	[#Rule termbinop_124
		 'termbinop', 3,
sub {
#line 507 "Parser.eyp"
my $l = $_[1]; my $r = $_[3]; my $op = $_[2];  $_[0]->new_anode('ADDOP', $op, $l, $r); }
#line 6895 Parser.pm
	],
	[#Rule termbinop_125
		 'termbinop', 3,
sub {
#line 510 "Parser.eyp"
my $l = $_[1]; my $r = $_[3]; my $op = $_[2];  $_[0]->new_anode('MULOP', $op, $l, $r); }
#line 6902 Parser.pm
	],
	[#Rule termbinop_126
		 'termbinop', 3,
sub {
#line 513 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_anode('MULOP', '%', $l, $r); }
#line 6909 Parser.pm
	],
	[#Rule termbinop_127
		 'termbinop', 3,
sub {
#line 516 "Parser.eyp"
my $l = $_[1]; my $r = $_[3]; my $op = $_[2];  $_[0]->new_anode('POWOP', $op, $l, $r); }
#line 6916 Parser.pm
	],
	[#Rule termbinop_128
		 'termbinop', 3,
sub {
#line 519 "Parser.eyp"
my $l = $_[1]; my $r = $_[3]; my $op = $_[2];  $_[0]->new_anode('RELOP', $op, $l, $r); }
#line 6923 Parser.pm
	],
	[#Rule termbinop_129
		 'termbinop', 3,
sub {
#line 522 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('DOTDOT', $l, $r); }
#line 6930 Parser.pm
	],
	[#Rule termbinop_130
		 'termbinop', 3,
sub {
#line 525 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('AND', $l, $r); }
#line 6937 Parser.pm
	],
	[#Rule termbinop_131
		 'termbinop', 3,
sub {
#line 528 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('OR', $l, $r); }
#line 6944 Parser.pm
	],
	[#Rule termbinop_132
		 'termbinop', 3,
sub {
#line 531 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('DOR', $l, $r); }
#line 6951 Parser.pm
	],
	[#Rule termunop_133
		 'termunop', 2,
sub {
#line 537 "Parser.eyp"
my $t = $_[2]; my $op = $_[1];  $op eq '-' ? $_[0]->new_node('UMINUS', $t) : $t }
#line 6958 Parser.pm
	],
	[#Rule termunop_134
		 'termunop', 2,
sub {
#line 540 "Parser.eyp"
my $t = $_[2];  $_[0]->new_node('NOT', $t) }
#line 6965 Parser.pm
	],
	[#Rule termunop_135
		 'termunop', 2,
sub {
#line 543 "Parser.eyp"
 $_[1]->{incr} = 'POST'; $_[1] }
#line 6972 Parser.pm
	],
	[#Rule termunop_136
		 'termunop', 2,
sub {
#line 546 "Parser.eyp"
 $_[2]->{incr} = 'PRE'; $_[2] }
#line 6979 Parser.pm
	],
	[#Rule varexpr_137
		 'varexpr', 1,
sub {
#line 550 "Parser.eyp"
my $v = $_[1]; 
			    $_[0]->see_var($v, PLAIN_VAR);
			}
#line 6988 Parser.pm
	],
	[#Rule varexpr_138
		 'varexpr', 2,
sub {
#line 555 "Parser.eyp"
my $d = $_[2]; my $v = $_[1]; 
			    add_child($v, $d);
			    $_[0]->see_var($v, PLAIN_VAR);
			}
#line 6998 Parser.pm
	],
	[#Rule varexpr_139
		 'varexpr', 3,
sub {
#line 561 "Parser.eyp"
my $v = $_[1]; my $f = $_[3]; 
			    $_[0]->see_var($v, PLAIN_VAR);
			    $_[0]->new_node('FIELD', $v, $f);
			}
#line 7008 Parser.pm
	],
	[#Rule varexpr_140
		 'varexpr', 6,
sub {
#line 567 "Parser.eyp"
my $args = $_[5]; my $m = $_[3]; my $v = $_[1];  
			    $_[0]->see_var($v, PLAIN_VAR);
			    $_[0]->new_node('METHOD', $v, $m, $args);
			}
#line 7018 Parser.pm
	],
	[#Rule dynvar_141
		 'dynvar', 2,
sub {
#line 574 "Parser.eyp"
my $v = $_[2]; 
			    $_[0]->see_var($v, DYN_VAR);
			}
#line 7027 Parser.pm
	],
	[#Rule simplevar_142
		 'simplevar', 1,
sub {
#line 580 "Parser.eyp"
 $_[1] }
#line 7034 Parser.pm
	],
	[#Rule simplevar_143
		 'simplevar', 1,
sub {
#line 583 "Parser.eyp"
 $_[1] }
#line 7041 Parser.pm
	],
	[#Rule simplevar_144
		 'simplevar', 1,
sub {
#line 586 "Parser.eyp"
 $_[1] }
#line 7048 Parser.pm
	],
	[#Rule scalarvar_145
		 'scalarvar', 1,
sub {
#line 590 "Parser.eyp"
my $v = $_[1];  $_[0]->see_var($v, PLAIN_VAR); }
#line 7055 Parser.pm
	],
	[#Rule scalarvar_146
		 'scalarvar', 2,
sub {
#line 593 "Parser.eyp"
my $v = $_[2];  $_[0]->see_var($v, DYN_VAR); }
#line 7062 Parser.pm
	],
	[#Rule scalar_147
		 'scalar', 2,
sub {
#line 597 "Parser.eyp"
 $_[0]->new_anode('SCALAR', $_[2]); }
#line 7069 Parser.pm
	],
	[#Rule array_148
		 'array', 2,
sub {
#line 601 "Parser.eyp"
 $_[0]->new_anode('ARRAY', $_[2]); }
#line 7076 Parser.pm
	],
	[#Rule set_149
		 'set', 2,
sub {
#line 605 "Parser.eyp"
 $_[0]->new_anode('SET', $_[2]); }
#line 7083 Parser.pm
	],
	[#Rule indexvar_150
		 'indexvar', 1,
sub {
#line 609 "Parser.eyp"
 $_[0]->new_node('INDEXVAR'); }
#line 7090 Parser.pm
	],
	[#Rule indexvar_151
		 'indexvar', 2,
sub {
#line 612 "Parser.eyp"
my $n = $_[2];  $_[0]->new_anode('INDEXVAR', $n); }
#line 7097 Parser.pm
	],
	[#Rule indexvar_152
		 'indexvar', 2,
sub {
#line 615 "Parser.eyp"
my $w = $_[2];  $_[0]->new_anode('INDEXVAR', $w); }
#line 7104 Parser.pm
	],
	[#Rule subexpr_153
		 'subexpr', 1,
sub {
#line 619 "Parser.eyp"
my $d = $_[1];  $_[0]->new_node('SUBSCRIPT', $d); }
#line 7111 Parser.pm
	],
	[#Rule subexpr_154
		 'subexpr', 2,
sub {
#line 622 "Parser.eyp"
my $l = $_[1]; my $d = $_[2];  add_child($l, $d); }
#line 7118 Parser.pm
	],
	[#Rule subspec_155
		 'subspec', 2,
sub {
#line 626 "Parser.eyp"
 $_[0]->new_node('EMPTYDIM') }
#line 7125 Parser.pm
	],
	[#Rule subspec_156
		 'subspec', 3,
sub {
#line 629 "Parser.eyp"
 $_[2] }
#line 7132 Parser.pm
	],
	[#Rule funcall_157
		 'funcall', 4,
sub {
#line 633 "Parser.eyp"
my $args = $_[3]; my $fun = $_[1];  $_[0]->new_node('FUNCALL', $fun, @{$args->{children}}) }
#line 7139 Parser.pm
	],
	[#Rule funcall_158
		 'funcall', 6,
sub {
#line 636 "Parser.eyp"
my $args = $_[3]; my $fld = $_[6]; my $fun = $_[1];  $_[0]->new_node('DOTFLD', $fld,
				   $_[0]->new_node('FUNCALL', $fun, @{$args->{children}}) ) }
#line 7147 Parser.pm
	],
	[#Rule objblock_159
		 'objblock', 2,
sub {
#line 641 "Parser.eyp"
my $p = $_[2]; my $n = $_[1];  $_[0]->new_anode('NEWOBJ', $n, $p) }
#line 7154 Parser.pm
	],
	[#Rule pairblock_160
		 'pairblock', 3,
sub {
#line 645 "Parser.eyp"
 $_[0]->new_dnode('PAIRBLOCK', $_[2]) }
#line 7161 Parser.pm
	],
	[#Rule pairblock_161
		 'pairblock', 4,
sub {
#line 648 "Parser.eyp"
 $_[0]->new_dnode('PAIRBLOCK', $_[2]) }
#line 7168 Parser.pm
	],
	[#Rule pairlist_162
		 'pairlist', 0, undef
#line 7172 Parser.pm
	],
	[#Rule pairlist_163
		 'pairlist', 1,
sub {
#line 654 "Parser.eyp"
my $p = $_[1];  $_[0]->new_node('LIST', $p) }
#line 7179 Parser.pm
	],
	[#Rule pairlist_164
		 'pairlist', 3,
sub {
#line 657 "Parser.eyp"
my $l = $_[1]; my $p = $_[3];  $_[0]->add_child($l, $p) }
#line 7186 Parser.pm
	],
	[#Rule pair_165
		 'pair', 3,
sub {
#line 661 "Parser.eyp"
my $left = $_[1]; my $right = $_[3];  $_[0]->new_node('PAIR', $left, $right) }
#line 7193 Parser.pm
	],
	[#Rule flow_166
		 'flow', 5,
sub {
#line 665 "Parser.eyp"
my $so = $_[1]; my $sn = $_[5]; my $coeff = $_[3]; my $op = $_[2]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->new_node('FLOW', $so, $sn, 
			                    $_[0]->new_anode('MULOP', $op, $so, $coeff));
			}
#line 7205 Parser.pm
	],
	[#Rule flow_167
		 'flow', 5,
sub {
#line 673 "Parser.eyp"
my $so = $_[5]; my $sn = $_[1]; my $coeff = $_[3]; my $op = $_[2]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->new_node('FLOW', $so, $sn, 
					    $_[0]->new_anode('MULOP', $op, $sn, $coeff));
			}
#line 7217 Parser.pm
	],
	[#Rule flow_168
		 'flow', 5,
sub {
#line 681 "Parser.eyp"
my $so = $_[1]; my $sn = $_[3]; my $coeff = $_[5]; my $op = $_[4]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->new_node('FLOW', $so, $sn,
					    $_[0]->new_anode('MULOP', $op, $sn, $coeff));
			}
#line 7229 Parser.pm
	],
	[#Rule flow_169
		 'flow', 5,
sub {
#line 689 "Parser.eyp"
my $so = $_[3]; my $sn = $_[1]; my $coeff = $_[5]; my $op = $_[4]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->new_node('FLOW', $so, $sn, 
					    $_[0]->new_anode('MULOP', $op, $so, $coeff));
			}
#line 7241 Parser.pm
	],
	[#Rule flow_170
		 'flow', 6,
sub {
#line 697 "Parser.eyp"
my $rate = $_[3]; my $so = $_[1]; my $sn = $_[6]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->new_node('FLOW', $so, $sn, $rate);
			}
#line 7252 Parser.pm
	],
	[#Rule flow_171
		 'flow', 6,
sub {
#line 704 "Parser.eyp"
my $so = $_[6]; my $rate = $_[3]; my $sn = $_[1]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->new_node('FLOW', $so, $sn, $rate);
			}
#line 7263 Parser.pm
	],
	[#Rule flow_172
		 'flow', 6,
sub {
#line 711 "Parser.eyp"
my $rate = $_[5]; my $so = $_[1]; my $sn = $_[3]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->new_node('FLOW', $so, $sn, $rate);
			}
#line 7274 Parser.pm
	],
	[#Rule flow_173
		 'flow', 6,
sub {
#line 718 "Parser.eyp"
my $rate = $_[5]; my $so = $_[3]; my $sn = $_[1]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->new_node('FLOW', $so, $sn, $rate);
			}
#line 7285 Parser.pm
	]
],
#line 7288 Parser.pm
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
         'progstart_6', 
         'tl_decl_7', 
         'tl_decl_8', 
         'tl_decl_9', 
         'tl_decl_10', 
         'tl_decl_11', 
         'tl_decl_12', 
         'tl_decl_13', 
         'tl_decl_14', 
         'tl_decl_15', 
         'vardecl_16', 
         'vardecl_17', 
         'package_18', 
         'include_19', 
         'include_20', 
         'use_21', 
         'unit_22', 
         'wordlist_23', 
         'wordlist_24', 
         'function_25', 
         'function_26', 
         '_CODE', 
         'function_28', 
         'function_29', 
         '_CODE', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'funargs_35', 
         'funargs_36', 
         'unitopt_37', 
         'unitopt_38', 
         'unitspec_39', 
         'unitlist_40', 
         'unitlist_41', 
         'across_tl_42', 
         '_CODE', 
         'stmtseq_44', 
         'stmtseq_45', 
         'stmtseq_46', 
         'block_47', 
         '_CODE', 
         'perlblock_49', 
         '_CODE', 
         'perlblock_51', 
         '_CODE', 
         'phaseblock_53', 
         '_CODE', 
         'phase_55', 
         'phase_56', 
         'phase_57', 
         'phase_58', 
         'line_59', 
         'line_60', 
         'line_61', 
         'line_62', 
         '_CODE', 
         'line_64', 
         'line_65', 
         'line_66', 
         'line_67', 
         'line_68', 
         '_CODE', 
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
         '_CODE', 
         'condword_84', 
         'condword_85', 
         'else_86', 
         'else_87', 
         '_CODE', 
         'else_89', 
         '_CODE', 
         '_CODE', 
         'loop_92', 
         '_CODE', 
         'loop_94', 
         '_CODE', 
         'loop_96', 
         '_CODE', 
         'listexpr_98', 
         'listexpr_99', 
         'argexpr_100', 
         'argexpr_101', 
         'argexpr_102', 
         'expr_103', 
         'expr_104', 
         'expr_105', 
         'expr_106', 
         'expr_107', 
         'term_108', 
         'term_109', 
         'term_110', 
         'term_111', 
         'term_112', 
         'term_113', 
         'term_114', 
         'term_115', 
         'term_116', 
         'term_117', 
         'term_118', 
         'term_119', 
         'term_120', 
         'term_121', 
         'termbinop_122', 
         'termbinop_123', 
         'termbinop_124', 
         'termbinop_125', 
         'termbinop_126', 
         'termbinop_127', 
         'termbinop_128', 
         'termbinop_129', 
         'termbinop_130', 
         'termbinop_131', 
         'termbinop_132', 
         'termunop_133', 
         'termunop_134', 
         'termunop_135', 
         'termunop_136', 
         'varexpr_137', 
         'varexpr_138', 
         'varexpr_139', 
         'varexpr_140', 
         'dynvar_141', 
         'simplevar_142', 
         'simplevar_143', 
         'simplevar_144', 
         'scalarvar_145', 
         'scalarvar_146', 
         'scalar_147', 
         'array_148', 
         'set_149', 
         'indexvar_150', 
         'indexvar_151', 
         'indexvar_152', 
         'subexpr_153', 
         'subexpr_154', 
         'subspec_155', 
         'subspec_156', 
         'funcall_157', 
         'funcall_158', 
         'objblock_159', 
         'pairblock_160', 
         'pairblock_161', 
         'pairlist_162', 
         'pairlist_163', 
         'pairlist_164', 
         'pair_165', 
         'flow_166', 
         'flow_167', 
         'flow_168', 
         'flow_169', 
         'flow_170', 
         'flow_171', 
         'flow_172', 
         'flow_173', );
  $self;
}

#line 725 "Parser.eyp"


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
	
	# identify the directory path of the current filename (if any) so that
	# we can look up the next filename in the same directory.
	
	my ($base) = ($self->{my_filename} =~ m{(.*/)});  
	$filename = "$base/$filename" if $base ne '';
	
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
    
    # If we actually got some input, process it.
    
    if ( $input =~ /\S/ ) {
	
	# If we are in the middle of handling another file, record that
	# information on the input stack.
	
	if ( $self->{my_filename} ne '' ) {
	    unshift @{$self->{my_input_stack}}, {file => $self->{my_filename}, 
						 line => $self->{my_line}, 
						 input => $self->{my_input}};
	}
	
	# Now remember the name of the file we are reading from, the starting
	# line number (1) and the contents that were read in.  Also start out
	# in the default package.
	
	$self->{my_filename} = $filename;
	$self->{my_line} = 1;
	$self->{my_input} = \$input;
	
	# Now parse the input, and return the resulting tree (if any).
	
	my $tree = $self->YYParse( yylex => \&my_lex_wrapper, yyerror => \&my_syntax, yybuildingtree => 1,
				   yydebug => 0x05);
	return $tree;
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

# validate_unit ( $raw )
# 
# Validate the unit specification contained in $raw.  If its syntax is
# incorrect, return 'ERROR'.  Otherwise, figure out the unit's power and
# return a list containing the unit that many times.  For example, <m^2> means
# "meters squared" and would result in the list ("m", "m").  Units that would
# appear in the denominator are prefixed with "~".  For example, <s^-2> means
# "per second per second" and would result in the list ("~s", "~s").

sub validate_unit {
    my ($self, $raw) = @_;
    my ($invert, $unit, $count);
    
    if ( $raw =~ m{^([/*]?)\s*([a-zA-Z]+)\^?([0-9]*)$} ) {
	$unit = $1 eq '/' ? "~$2" : $2;
	$count = $3 ne '' ? $3+0 : 1;
	return ($unit) x $count;
    }
    elsif ( $raw =~ m{^\*?\s*([a-zA-Z]+)\^?-([0-9]+)$} ) {
	$unit = "~$1";
	$count = $2 ne '' ? $2+0 : 1;
	return ($unit) x $count;
    }
    else {
	return 'ERROR';
    }
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

# my_error ( $msg )
# 
# Terminate parsing because of an error.

sub my_syntax {
    my ($self, $msg, $filename, $line) = @_;
    
    $filename = $self->{my_filename} unless defined $filename;
    $line = $self->{my_line} unless defined $line;
    
    if ( $msg ne '' ) {
        die "Syntax error at $filename line $line: $msg\n";
    }
    else {
        die "Syntax error at $filename line $line.\n";
    }
}

sub my_error {
    my ($self, $msg, $filename, $line) = @_;
    
    $filename = $self->{my_filename} unless defined $filename;
    $line = $self->{my_line} unless defined $line;
    
    die "Error at $self->{my_filename} line $self->{my_line}: $msg\n";
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
		m{\G\s*([/*]?\s*[a-zA-Z]+\^?-?[0-9]*)}gc	and return ('UNIT', $1);
		return ('ERROR', '');
	    }
	    
	    # Otherwise, we're parsing our modeling language.  Start by looking for
	    # keywords.
	    
	    m{\Gacross(?!\w)}gc		and return ('ACROSS', '');
	    m{\Gand(?!\w)}gc		and return ('ANDOP', '');
	    m{\Gcalc(?!\w)}gc		and return ('CALC', '');
	    m{\Gconst(?!\w)}gc		and return ('CONST', '');
	    m{\Gelse(?!\w)}gc		and return ('ELSE', '');
	    m{\Gelsif(?!\w)}gc		and return ('ELSIF', '');
	    m{\Gexternal(?!\w)}gc	and return ('EXTERNAL', '');
	    m{\Gfinal(?!\w)}gc		and return ('FINAL', '');
	    m{\Gfor(?!\w)}gc		and return ('FOR', '');
	    m{\Gfunction(?!\w)}gc	and return ('FUNCTION', '');
	    m{\Ginclude(?!\w)}gc	and return ('INCLUDE', '');
	    m{\Gif(?!\w)}gc		and return ('IF', '');
	    m{\Ginit(?!\w)}gc		and return ('INIT', '');
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
	    m{\Gstep(?!\w)}gc		and return ('STEP', '');
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
	    
	    m{\G(\w(?<!\d)\w*(?=\())}gc		and return ('FUNC', $1);
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


#line 7952 Parser.pm



1;
