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

      m{\G(FLOWRIGHT|ASSIGNOP|loopword|FLOWLEFT|FUNCTION|YADAYADA|FOREACH|INCLUDE|perlseq|PACKAGE|default|progseg|DORDOR|UNLESS|ACROSS|ANDAND|RETURN|DOTDOT|ANDOP|FINAL|RELOP|INCOP|ADDOP|MULOP|CONST|XOROP|POWOP|NOTOP|ELSIF|STEP|ELSE|OROP|UNIT|OROR|WORD|PERL|NOT2|FUNC|INIT|CALC|FOR|var|STR|USE|NUM|DOT|VAR|\%\}|\%\{|MY|\$\^|IF|\:|\}|\<|\@|\%|\[|\,|\)|\?|\{|\$|\]|\(|\>|\;|\=)}gc and return ($1, $1);



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
  [ 'tl_decl_11' => 'tl_decl', [ 'var' ], 0 ],
  [ 'tl_decl_12' => 'tl_decl', [ 'default' ], 0 ],
  [ 'tl_decl_13' => 'tl_decl', [ 'include' ], 0 ],
  [ 'tl_decl_14' => 'tl_decl', [ 'use' ], 0 ],
  [ 'tl_decl_15' => 'tl_decl', [ 'unit' ], 0 ],
  [ 'tl_decl_16' => 'tl_decl', [ 'function' ], 0 ],
  [ 'vardecl_17' => 'vardecl', [ 'simplevar', 'unitopt' ], 0 ],
  [ 'vardecl_18' => 'vardecl', [ 'simplevar', 'dimspec', 'unitopt' ], 0 ],
  [ 'package_19' => 'package', [ 'PACKAGE', 'WORD', ';' ], 0 ],
  [ 'include_20' => 'include', [ 'INCLUDE', 'WORD', ';' ], 0 ],
  [ 'include_21' => 'include', [ 'INCLUDE', 'STR', ';' ], 0 ],
  [ 'use_22' => 'use', [ 'USE', 'WORD', ';' ], 0 ],
  [ 'unit_23' => 'unit', [ 'UNIT', 'wordlist', ';' ], 0 ],
  [ 'wordlist_24' => 'wordlist', [ 'WORD' ], 0 ],
  [ 'wordlist_25' => 'wordlist', [ 'wordlist', ',', 'WORD' ], 0 ],
  [ 'function_26' => 'function', [ 'FUNCTION', 'WORD', '(', 'params', ')', 'unitopt', ';' ], 0 ],
  [ 'function_27' => 'function', [ 'FUNCTION', 'WORD', '(', 'params', ')', 'unitopt', '{', '@27-7', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@27-7', [  ], 0 ],
  [ 'function_29' => 'function', [ 'PERL', 'FUNCTION', 'WORD', '(', 'params', ')', 'unitopt', ';' ], 0 ],
  [ 'function_30' => 'function', [ 'PERL', 'FUNCTION', 'WORD', '(', 'params', ')', 'unitopt', '{', '@30-8', 'perlseq', '}' ], 0 ],
  [ '_CODE' => '@30-8', [  ], 0 ],
  [ 'params_32' => 'params', [  ], 0 ],
  [ 'params_33' => 'params', [ 'paramlist' ], 0 ],
  [ 'paramlist_34' => 'paramlist', [ 'param' ], 0 ],
  [ 'paramlist_35' => 'paramlist', [ 'paramlist', ',', 'param' ], 0 ],
  [ 'param_36' => 'param', [ 'scalar' ], 0 ],
  [ 'unitopt_37' => 'unitopt', [  ], 0 ],
  [ 'unitopt_38' => 'unitopt', [ 'unitspec' ], 0 ],
  [ 'unitspec_39' => 'unitspec', [ '<', 'unitlist', '>' ], 0 ],
  [ 'unitlist_40' => 'unitlist', [  ], 0 ],
  [ 'unitlist_41' => 'unitlist', [ 'unitlist', 'UNIT' ], 0 ],
  [ 'tl_across_42' => 'tl_across', [ 'ACROSS', 'dimlist', '{', '@42-3', 'progseq', '}' ], 0 ],
  [ '_CODE' => '@42-3', [  ], 0 ],
  [ 'stmtseq_44' => 'stmtseq', [  ], 0 ],
  [ 'stmtseq_45' => 'stmtseq', [ 'stmtseq', 'across' ], 0 ],
  [ 'stmtseq_46' => 'stmtseq', [ 'stmtseq', 'block' ], 0 ],
  [ 'stmtseq_47' => 'stmtseq', [ 'stmtseq', 'perlblock' ], 0 ],
  [ 'stmtseq_48' => 'stmtseq', [ 'stmtseq', 'phaseblock' ], 0 ],
  [ 'stmtseq_49' => 'stmtseq', [ 'stmtseq', 'line' ], 0 ],
  [ 'block_50' => 'block', [ '{', '@50-1', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@50-1', [  ], 0 ],
  [ 'perlblock_52' => 'perlblock', [ 'PERL', '{', '@52-2', 'perlseq', '}' ], 0 ],
  [ '_CODE' => '@52-2', [  ], 0 ],
  [ 'perlblock_54' => 'perlblock', [ '%{', '@54-1', 'perlseq', '%}' ], 0 ],
  [ '_CODE' => '@54-1', [  ], 0 ],
  [ 'phaseblock_56' => 'phaseblock', [ 'phase', '{', '@56-2', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@56-2', [  ], 0 ],
  [ 'phase_58' => 'phase', [ 'INIT' ], 0 ],
  [ 'phase_59' => 'phase', [ 'CALC' ], 0 ],
  [ 'phase_60' => 'phase', [ 'STEP' ], 0 ],
  [ 'phase_61' => 'phase', [ 'FINAL' ], 0 ],
  [ 'line_62' => 'line', [ 'phase', '@62-1', 'sideff', ';' ], 0 ],
  [ '_CODE' => '@62-1', [  ], 0 ],
  [ 'line_64' => 'line', [ 'package' ], 0 ],
  [ 'line_65' => 'line', [ 'cond' ], 0 ],
  [ 'line_66' => 'line', [ 'loop' ], 0 ],
  [ 'line_67' => 'line', [ 'sideff', ';' ], 0 ],
  [ 'line_68' => 'line', [ 'VAR', 'vardecl', ';' ], 0 ],
  [ 'line_69' => 'line', [ 'CONST', 'vardecl', '=', '@69-3', 'expr', ';' ], 0 ],
  [ '_CODE' => '@69-3', [  ], 0 ],
  [ 'across_71' => 'across', [ 'ACROSS', 'dimlist', '{', '@71-3', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@71-3', [  ], 0 ],
  [ 'dimlist_73' => 'dimlist', [ 'dimspec' ], 0 ],
  [ 'dimlist_74' => 'dimlist', [ 'dimlist', 'dimspec' ], 0 ],
  [ 'dimspec_75' => 'dimspec', [ '[', 'label', 'array', ']' ], 0 ],
  [ 'dimspec_76' => 'dimspec', [ '[', 'label', 'set', ']' ], 0 ],
  [ 'label_77' => 'label', [  ], 0 ],
  [ 'label_78' => 'label', [ 'WORD', ':' ], 0 ],
  [ 'sideff_79' => 'sideff', [ 'expr' ], 0 ],
  [ 'sideff_80' => 'sideff', [ 'expr', 'IF', 'expr' ], 0 ],
  [ 'sideff_81' => 'sideff', [ 'expr', 'UNLESS', 'expr' ], 0 ],
  [ 'cond_82' => 'cond', [ 'condword', '(', '@82-2', 'expr', ')', '{', 'stmtseq', '}', 'else' ], 0 ],
  [ '_CODE' => '@82-2', [  ], 0 ],
  [ 'condword_84' => 'condword', [ 'IF' ], 0 ],
  [ 'condword_85' => 'condword', [ 'UNLESS' ], 0 ],
  [ 'else_86' => 'else', [  ], 0 ],
  [ 'else_87' => 'else', [ 'ELSE', '{', '@87-2', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@87-2', [  ], 0 ],
  [ 'else_89' => 'else', [ 'ELSIF', '(', '@89-2', 'expr', ')', '{', 'stmtseq', '}', 'else' ], 0 ],
  [ '_CODE' => '@89-2', [  ], 0 ],
  [ 'loop_91' => 'loop', [ 'loopword', '(', '@91-2', 'expr', ')', '{', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@91-2', [  ], 0 ],
  [ 'loop_93' => 'loop', [ 'FOREACH', '@93-1', 'scalarvar', '(', 'expr', ')', '{', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@93-1', [  ], 0 ],
  [ 'loop_95' => 'loop', [ 'FOR', '(', '@95-2', 'expr', ';', 'expr', ';', 'expr', ')', '{', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@95-2', [  ], 0 ],
  [ 'argexpr_97' => 'argexpr', [  ], 0 ],
  [ 'argexpr_98' => 'argexpr', [ 'arglist' ], 0 ],
  [ 'arglist_99' => 'arglist', [ 'term' ], 0 ],
  [ 'arglist_100' => 'arglist', [ 'argexpr', ',', 'term' ], 0 ],
  [ 'expr_101' => 'expr', [ 'expr', 'ANDOP', 'expr' ], 0 ],
  [ 'expr_102' => 'expr', [ 'expr', 'OROP', 'expr' ], 0 ],
  [ 'expr_103' => 'expr', [ 'expr', 'XOROP', 'expr' ], 0 ],
  [ 'expr_104' => 'expr', [ 'NOTOP', 'expr' ], 0 ],
  [ 'expr_105' => 'expr', [ 'term' ], 0 ],
  [ 'term_106' => 'term', [ 'termbinop' ], 0 ],
  [ 'term_107' => 'term', [ 'termunop' ], 0 ],
  [ 'term_108' => 'term', [ 'term', '?', 'term', ':', 'term' ], 0 ],
  [ 'term_109' => 'term', [ '(', 'expr', ')' ], 0 ],
  [ 'term_110' => 'term', [ 'varexpr' ], 0 ],
  [ 'term_111' => 'term', [ 'dynvar' ], 0 ],
  [ 'term_112' => 'term', [ 'indexvar' ], 0 ],
  [ 'term_113' => 'term', [ 'NUM' ], 0 ],
  [ 'term_114' => 'term', [ 'STR' ], 0 ],
  [ 'term_115' => 'term', [ 'funcall' ], 0 ],
  [ 'term_116' => 'term', [ 'objname' ], 0 ],
  [ 'term_117' => 'term', [ 'objblock' ], 0 ],
  [ 'term_118' => 'term', [ 'RETURN', 'expr' ], 0 ],
  [ 'term_119' => 'term', [ 'term', 'unitspec' ], 0 ],
  [ 'term_120' => 'term', [ 'YADAYADA' ], 0 ],
  [ 'termbinop_121' => 'termbinop', [ 'term', 'ASSIGNOP', 'term' ], 0 ],
  [ 'termbinop_122' => 'termbinop', [ 'term', '=', 'term' ], 0 ],
  [ 'termbinop_123' => 'termbinop', [ 'term', 'ADDOP', 'term' ], 0 ],
  [ 'termbinop_124' => 'termbinop', [ 'term', 'MULOP', 'term' ], 0 ],
  [ 'termbinop_125' => 'termbinop', [ 'term', '%', 'term' ], 0 ],
  [ 'termbinop_126' => 'termbinop', [ 'term', 'POWOP', 'term' ], 0 ],
  [ 'termbinop_127' => 'termbinop', [ 'term', 'RELOP', 'term' ], 0 ],
  [ 'termbinop_128' => 'termbinop', [ 'term', 'DOTDOT', 'term' ], 0 ],
  [ 'termbinop_129' => 'termbinop', [ 'term', 'ANDAND', 'term' ], 0 ],
  [ 'termbinop_130' => 'termbinop', [ 'term', 'OROR', 'term' ], 0 ],
  [ 'termbinop_131' => 'termbinop', [ 'term', 'DORDOR', 'term' ], 0 ],
  [ 'termunop_132' => 'termunop', [ 'ADDOP', 'term' ], 0 ],
  [ 'termunop_133' => 'termunop', [ 'NOT2', 'term' ], 0 ],
  [ 'termunop_134' => 'termunop', [ 'term', 'INCOP' ], 0 ],
  [ 'termunop_135' => 'termunop', [ 'INCOP', 'term' ], 0 ],
  [ 'varexpr_136' => 'varexpr', [ 'simplevar' ], 0 ],
  [ 'varexpr_137' => 'varexpr', [ 'simplevar', 'subexpr' ], 0 ],
  [ 'varexpr_138' => 'varexpr', [ 'varexpr', 'DOT', 'WORD' ], 0 ],
  [ 'varexpr_139' => 'varexpr', [ 'varexpr', 'DOT', 'FUNC', '(', 'argexpr', ')' ], 0 ],
  [ 'dynvar_140' => 'dynvar', [ 'MY', 'simplevar' ], 0 ],
  [ 'simplevar_141' => 'simplevar', [ 'scalar' ], 0 ],
  [ 'simplevar_142' => 'simplevar', [ 'array' ], 0 ],
  [ 'simplevar_143' => 'simplevar', [ 'set' ], 0 ],
  [ 'scalarvar_144' => 'scalarvar', [ 'scalar' ], 0 ],
  [ 'scalarvar_145' => 'scalarvar', [ 'MY', 'scalar' ], 0 ],
  [ 'scalar_146' => 'scalar', [ '$', 'WORD' ], 0 ],
  [ 'array_147' => 'array', [ '@', 'WORD' ], 0 ],
  [ 'set_148' => 'set', [ '%', 'WORD' ], 0 ],
  [ 'indexvar_149' => 'indexvar', [ '$^' ], 0 ],
  [ 'indexvar_150' => 'indexvar', [ '$^', 'NUM' ], 0 ],
  [ 'indexvar_151' => 'indexvar', [ '$^', 'WORD' ], 0 ],
  [ 'subexpr_152' => 'subexpr', [ 'subspec' ], 0 ],
  [ 'subexpr_153' => 'subexpr', [ 'subexpr', 'subspec' ], 0 ],
  [ 'subspec_154' => 'subspec', [ '[', ']' ], 0 ],
  [ 'subspec_155' => 'subspec', [ '[', 'expr', ']' ], 0 ],
  [ 'funcall_156' => 'funcall', [ 'FUNC', '(', 'argexpr', ')' ], 0 ],
  [ 'funcall_157' => 'funcall', [ 'FUNC', '(', 'argexpr', ')', 'DOT', 'WORD' ], 0 ],
  [ 'objname_158' => 'objname', [ 'WORD' ], 0 ],
  [ 'objblock_159' => 'objblock', [ 'WORD', 'pairblock' ], 0 ],
  [ 'pairblock_160' => 'pairblock', [ '{', 'pairlist', '}' ], 0 ],
  [ 'pairblock_161' => 'pairblock', [ '{', 'pairlist', ',', '}' ], 0 ],
  [ 'pairlist_162' => 'pairlist', [ 'pair' ], 0 ],
  [ 'pairlist_163' => 'pairlist', [ 'pairlist', ',', 'pair' ], 0 ],
  [ 'pair_164' => 'pair', [ 'WORD', ':', 'expr' ], 0 ],
  [ 'flow_165' => 'flow', [ 'scalar', 'MULOP', 'expr', 'FLOWRIGHT', 'scalar' ], 0 ],
  [ 'flow_166' => 'flow', [ 'scalar', 'MULOP', 'expr', 'FLOWLEFT', 'scalar' ], 0 ],
  [ 'flow_167' => 'flow', [ 'scalar', 'FLOWRIGHT', 'scalar', 'MULOP', 'expr' ], 0 ],
  [ 'flow_168' => 'flow', [ 'scalar', 'FLOWLEFT', 'scalar', 'MULOP', 'expr' ], 0 ],
  [ 'flow_169' => 'flow', [ 'scalar', '(', 'expr', ')', 'FLOWRIGHT', 'scalar' ], 0 ],
  [ 'flow_170' => 'flow', [ 'scalar', '(', 'expr', ')', 'FLOWLEFT', 'scalar' ], 0 ],
  [ 'flow_171' => 'flow', [ 'scalar', 'FLOWRIGHT', 'scalar', '(', 'expr', ')' ], 0 ],
  [ 'flow_172' => 'flow', [ 'scalar', 'FLOWLEFT', 'scalar', '(', 'expr', ')' ], 0 ],
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
	progseg => { ISSEMANTIC => 1 },
	var => { ISSEMANTIC => 1 },
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
			'default' => -2,
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
			'var' => -2,
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
			'WORD' => 46,
			'PACKAGE' => 47,
			"\@" => 10,
			'PERL' => 49,
			'MY' => 50,
			"%" => 12,
			"\$^" => 51,
			'UNLESS' => 13,
			'NUM' => 52,
			'STEP' => 15,
			"\$" => 54,
			'IF' => 53,
			'loopword' => 16,
			'FOREACH' => 18,
			'ACROSS' => 20,
			'NOTOP' => 56,
			'FINAL' => 23,
			'default' => 59,
			'INCLUDE' => 24,
			"(" => 60,
			'VAR' => 61,
			'INCOP' => 25,
			'NOT2' => 62,
			'FOR' => 29,
			'ADDOP' => 30,
			'FUNC' => 64,
			'UNIT' => 32,
			'RETURN' => 68,
			'INIT' => 69,
			'var' => 34,
			'FUNCTION' => 35,
			'STR' => 37,
			'CALC' => 70,
			"{" => 39,
			'CONST' => 40,
			'USE' => 44,
			'YADAYADA' => 72
		},
		GOTOS => {
			'scalar' => 9,
			'sideff' => 28,
			'function' => 27,
			'objname' => 11,
			'include' => 63,
			'tl_across' => 48,
			'term' => 65,
			'loop' => 14,
			'array' => 31,
			'use' => 67,
			'expr' => 66,
			'phase' => 33,
			'termbinop' => 55,
			'flow' => 17,
			'set' => 36,
			'termunop' => 19,
			'line' => 21,
			'cond' => 22,
			'dynvar' => 58,
			'phaseblock' => 57,
			'condword' => 71,
			'funcall' => 38,
			'tl_decl' => 41,
			'package' => 42,
			'unit' => 45,
			'varexpr' => 43,
			'block' => 73,
			'indexvar' => 74,
			'simplevar' => 75,
			'objblock' => 26
		}
	},
	{#State 5
		DEFAULT => 0
	},
	{#State 6
		DEFAULT => -55,
		GOTOS => {
			'@54-1' => 76
		}
	},
	{#State 7
		DEFAULT => -6
	},
	{#State 8
		ACTIONS => {
			"{" => 77
		}
	},
	{#State 9
		ACTIONS => {
			'XOROP' => -141,
			"<" => -141,
			'DORDOR' => -141,
			";" => -141,
			'FLOWLEFT' => 78,
			'ADDOP' => -141,
			"%" => -141,
			'ANDOP' => -141,
			'UNLESS' => -141,
			'ASSIGNOP' => -141,
			'IF' => -141,
			"[" => -141,
			'FLOWRIGHT' => 81,
			'POWOP' => -141,
			'DOT' => -141,
			"?" => -141,
			'DOTDOT' => -141,
			'MULOP' => 79,
			'OROP' => -141,
			"=" => -141,
			"(" => 80,
			'ANDAND' => -141,
			'OROR' => -141,
			'RELOP' => -141,
			'INCOP' => -141
		}
	},
	{#State 10
		ACTIONS => {
			'WORD' => 82
		}
	},
	{#State 11
		DEFAULT => -116
	},
	{#State 12
		ACTIONS => {
			'WORD' => 83
		}
	},
	{#State 13
		DEFAULT => -85
	},
	{#State 14
		DEFAULT => -66
	},
	{#State 15
		DEFAULT => -60
	},
	{#State 16
		ACTIONS => {
			"(" => 84
		}
	},
	{#State 17
		DEFAULT => -8
	},
	{#State 18
		DEFAULT => -94,
		GOTOS => {
			'@93-1' => 85
		}
	},
	{#State 19
		DEFAULT => -107
	},
	{#State 20
		ACTIONS => {
			"[" => 86
		},
		GOTOS => {
			'dimlist' => 88,
			'dimspec' => 87
		}
	},
	{#State 21
		DEFAULT => -9
	},
	{#State 22
		DEFAULT => -65
	},
	{#State 23
		DEFAULT => -61
	},
	{#State 24
		ACTIONS => {
			'WORD' => 90,
			'STR' => 89
		}
	},
	{#State 25
		ACTIONS => {
			'WORD' => 46,
			'STR' => 37,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			"(" => 60,
			'YADAYADA' => 72,
			'RETURN' => 68,
			"\$" => 54,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 92,
			'array' => 31,
			'varexpr' => 43,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 26
		DEFAULT => -117
	},
	{#State 27
		DEFAULT => -16
	},
	{#State 28
		ACTIONS => {
			";" => 93
		}
	},
	{#State 29
		ACTIONS => {
			"(" => 94
		}
	},
	{#State 30
		ACTIONS => {
			'WORD' => 46,
			'STR' => 37,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			"(" => 60,
			'YADAYADA' => 72,
			'RETURN' => 68,
			"\$" => 54,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 95,
			'array' => 31,
			'varexpr' => 43,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 31
		DEFAULT => -142
	},
	{#State 32
		ACTIONS => {
			'WORD' => 97
		},
		GOTOS => {
			'wordlist' => 96
		}
	},
	{#State 33
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
			"{" => 98,
			"(" => -63,
			'YADAYADA' => -63,
			'INCOP' => -63
		},
		GOTOS => {
			'@62-1' => 99
		}
	},
	{#State 34
		DEFAULT => -11
	},
	{#State 35
		ACTIONS => {
			'WORD' => 100
		}
	},
	{#State 36
		DEFAULT => -143
	},
	{#State 37
		DEFAULT => -114
	},
	{#State 38
		DEFAULT => -115
	},
	{#State 39
		DEFAULT => -51,
		GOTOS => {
			'@50-1' => 101
		}
	},
	{#State 40
		ACTIONS => {
			"\@" => 10,
			"\$" => 54,
			"%" => 12
		},
		GOTOS => {
			'array' => 31,
			'vardecl' => 102,
			'scalar' => 91,
			'simplevar' => 103,
			'set' => 36
		}
	},
	{#State 41
		DEFAULT => -3
	},
	{#State 42
		DEFAULT => -64
	},
	{#State 43
		ACTIONS => {
			'WORD' => -110,
			'' => -110,
			"}" => -110,
			":" => -110,
			'PACKAGE' => -110,
			'XOROP' => -110,
			"\@" => -110,
			"<" => -110,
			'DORDOR' => -110,
			'PERL' => -110,
			'MY' => -110,
			"%" => -110,
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
			'POWOP' => -110,
			'ACROSS' => -110,
			'NOTOP' => -110,
			'FINAL' => -110,
			'DOT' => 104,
			'OROP' => -110,
			'default' => -110,
			'INCLUDE' => -110,
			"(" => -110,
			'VAR' => -110,
			'ANDAND' => -110,
			'INCOP' => -110,
			'RELOP' => -110,
			'NOT2' => -110,
			";" => -110,
			'FOR' => -110,
			'FLOWLEFT' => -110,
			'ADDOP' => -110,
			"," => -110,
			'FUNC' => -110,
			'UNIT' => -110,
			'RETURN' => -110,
			'INIT' => -110,
			'FUNCTION' => -110,
			'var' => -110,
			'FLOWRIGHT' => -110,
			")" => -110,
			'STR' => -110,
			'CALC' => -110,
			"?" => -110,
			'DOTDOT' => -110,
			'MULOP' => -110,
			"{" => -110,
			'CONST' => -110,
			"=" => -110,
			'USE' => -110,
			'YADAYADA' => -110,
			'OROR' => -110
		}
	},
	{#State 44
		ACTIONS => {
			'WORD' => 105
		}
	},
	{#State 45
		DEFAULT => -15
	},
	{#State 46
		ACTIONS => {
			'WORD' => -158,
			'' => -158,
			"}" => -158,
			":" => -158,
			'PACKAGE' => -158,
			'XOROP' => -158,
			"\@" => -158,
			"<" => -158,
			'DORDOR' => -158,
			'PERL' => -158,
			'MY' => -158,
			"%" => -158,
			'ANDOP' => -158,
			"\$^" => -158,
			'UNLESS' => -158,
			'NUM' => -158,
			'STEP' => -158,
			'ASSIGNOP' => -158,
			'IF' => -158,
			"\$" => -158,
			'loopword' => -158,
			'FOREACH' => -158,
			"]" => -158,
			'POWOP' => -158,
			'ACROSS' => -158,
			'NOTOP' => -158,
			'FINAL' => -158,
			'OROP' => -158,
			'default' => -158,
			'INCLUDE' => -158,
			"(" => -158,
			'VAR' => -158,
			'ANDAND' => -158,
			'INCOP' => -158,
			'RELOP' => -158,
			'NOT2' => -158,
			";" => -158,
			'FOR' => -158,
			'FLOWLEFT' => -158,
			'ADDOP' => -158,
			"," => -158,
			'FUNC' => -158,
			'UNIT' => -158,
			'RETURN' => -158,
			'INIT' => -158,
			'FUNCTION' => -158,
			'var' => -158,
			'FLOWRIGHT' => -158,
			")" => -158,
			'STR' => -158,
			'CALC' => -158,
			"?" => -158,
			'DOTDOT' => -158,
			"{" => 106,
			'MULOP' => -158,
			'CONST' => -158,
			"=" => -158,
			'USE' => -158,
			'YADAYADA' => -158,
			'OROR' => -158
		},
		GOTOS => {
			'pairblock' => 107
		}
	},
	{#State 47
		ACTIONS => {
			'WORD' => 108
		}
	},
	{#State 48
		DEFAULT => -4
	},
	{#State 49
		ACTIONS => {
			'FUNCTION' => 109
		}
	},
	{#State 50
		ACTIONS => {
			"\@" => 10,
			"\$" => 54,
			"%" => 12
		},
		GOTOS => {
			'array' => 31,
			'scalar' => 91,
			'simplevar' => 110,
			'set' => 36
		}
	},
	{#State 51
		ACTIONS => {
			'' => -149,
			"}" => -149,
			":" => -149,
			'WORD' => 111,
			'PACKAGE' => -149,
			'XOROP' => -149,
			"\@" => -149,
			"<" => -149,
			'DORDOR' => -149,
			'PERL' => -149,
			'MY' => -149,
			"%" => -149,
			'ANDOP' => -149,
			"\$^" => -149,
			'UNLESS' => -149,
			'NUM' => 112,
			'STEP' => -149,
			'ASSIGNOP' => -149,
			'IF' => -149,
			"\$" => -149,
			'loopword' => -149,
			'FOREACH' => -149,
			"]" => -149,
			'POWOP' => -149,
			'ACROSS' => -149,
			'NOTOP' => -149,
			'FINAL' => -149,
			'OROP' => -149,
			'default' => -149,
			'INCLUDE' => -149,
			"(" => -149,
			'VAR' => -149,
			'ANDAND' => -149,
			'INCOP' => -149,
			'RELOP' => -149,
			'NOT2' => -149,
			";" => -149,
			'FOR' => -149,
			'FLOWLEFT' => -149,
			'ADDOP' => -149,
			"," => -149,
			'FUNC' => -149,
			'UNIT' => -149,
			'RETURN' => -149,
			'INIT' => -149,
			'FUNCTION' => -149,
			'var' => -149,
			'FLOWRIGHT' => -149,
			")" => -149,
			'STR' => -149,
			'CALC' => -149,
			"?" => -149,
			'DOTDOT' => -149,
			'MULOP' => -149,
			"{" => -149,
			'CONST' => -149,
			"=" => -149,
			'USE' => -149,
			'YADAYADA' => -149,
			'OROR' => -149
		}
	},
	{#State 52
		DEFAULT => -113
	},
	{#State 53
		DEFAULT => -84
	},
	{#State 54
		ACTIONS => {
			'WORD' => 113
		}
	},
	{#State 55
		DEFAULT => -106
	},
	{#State 56
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			'STR' => 37,
			'NOTOP' => 56,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 65,
			'array' => 31,
			'varexpr' => 43,
			'expr' => 114,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 57
		DEFAULT => -7
	},
	{#State 58
		DEFAULT => -111
	},
	{#State 59
		DEFAULT => -12
	},
	{#State 60
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			'STR' => 37,
			'NOTOP' => 56,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 65,
			'array' => 31,
			'varexpr' => 43,
			'expr' => 115,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 61
		ACTIONS => {
			"\@" => 10,
			"\$" => 54,
			"%" => 12
		},
		GOTOS => {
			'array' => 31,
			'vardecl' => 116,
			'scalar' => 91,
			'simplevar' => 103,
			'set' => 36
		}
	},
	{#State 62
		ACTIONS => {
			'WORD' => 46,
			'STR' => 37,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			"(" => 60,
			'YADAYADA' => 72,
			'RETURN' => 68,
			"\$" => 54,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 117,
			'array' => 31,
			'varexpr' => 43,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 63
		DEFAULT => -13
	},
	{#State 64
		ACTIONS => {
			"(" => 118
		}
	},
	{#State 65
		ACTIONS => {
			'WORD' => -105,
			'' => -105,
			"}" => -105,
			":" => -105,
			'PACKAGE' => -105,
			'XOROP' => -105,
			"\@" => -105,
			'DORDOR' => 120,
			"<" => 119,
			'PERL' => -105,
			'MY' => -105,
			"%" => 121,
			'ANDOP' => -105,
			"\$^" => -105,
			'UNLESS' => -105,
			'NUM' => -105,
			'STEP' => -105,
			'ASSIGNOP' => 122,
			'IF' => -105,
			"\$" => -105,
			'loopword' => -105,
			'FOREACH' => -105,
			"]" => -105,
			'ACROSS' => -105,
			'POWOP' => 130,
			'NOTOP' => -105,
			'FINAL' => -105,
			'OROP' => -105,
			'default' => -105,
			'INCLUDE' => -105,
			"(" => -105,
			'VAR' => -105,
			'ANDAND' => 131,
			'RELOP' => 125,
			'INCOP' => 124,
			'NOT2' => -105,
			";" => -105,
			'FOR' => -105,
			'FLOWLEFT' => -105,
			'ADDOP' => 126,
			"," => -105,
			'FUNC' => -105,
			'UNIT' => -105,
			'RETURN' => -105,
			'INIT' => -105,
			'var' => -105,
			'FUNCTION' => -105,
			'FLOWRIGHT' => -105,
			")" => -105,
			'STR' => -105,
			'CALC' => -105,
			"?" => 127,
			"{" => -105,
			'DOTDOT' => 132,
			'MULOP' => 128,
			'CONST' => -105,
			"=" => 133,
			'USE' => -105,
			'YADAYADA' => -105,
			'OROR' => 129
		},
		GOTOS => {
			'unitspec' => 123
		}
	},
	{#State 66
		ACTIONS => {
			'XOROP' => 137,
			";" => -79,
			'IF' => 138,
			'OROP' => 136,
			'ANDOP' => 134,
			'UNLESS' => 135
		}
	},
	{#State 67
		DEFAULT => -14
	},
	{#State 68
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			'STR' => 37,
			'NOTOP' => 56,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 65,
			'array' => 31,
			'varexpr' => 43,
			'expr' => 139,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 69
		DEFAULT => -58
	},
	{#State 70
		DEFAULT => -59
	},
	{#State 71
		ACTIONS => {
			"(" => 140
		}
	},
	{#State 72
		DEFAULT => -120
	},
	{#State 73
		DEFAULT => -5
	},
	{#State 74
		DEFAULT => -112
	},
	{#State 75
		ACTIONS => {
			'WORD' => -136,
			'' => -136,
			"}" => -136,
			":" => -136,
			'PACKAGE' => -136,
			'XOROP' => -136,
			"\@" => -136,
			"<" => -136,
			'DORDOR' => -136,
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
			"[" => 141,
			"]" => -136,
			'POWOP' => -136,
			'ACROSS' => -136,
			'NOTOP' => -136,
			'FINAL' => -136,
			'DOT' => -136,
			'OROP' => -136,
			'default' => -136,
			'INCLUDE' => -136,
			"(" => -136,
			'VAR' => -136,
			'ANDAND' => -136,
			'INCOP' => -136,
			'RELOP' => -136,
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
			'FUNCTION' => -136,
			'var' => -136,
			'FLOWRIGHT' => -136,
			")" => -136,
			'STR' => -136,
			'CALC' => -136,
			"?" => -136,
			'DOTDOT' => -136,
			'MULOP' => -136,
			"{" => -136,
			'CONST' => -136,
			"=" => -136,
			'USE' => -136,
			'YADAYADA' => -136,
			'OROR' => -136
		},
		GOTOS => {
			'subexpr' => 143,
			'subspec' => 142
		}
	},
	{#State 76
		ACTIONS => {
			'perlseq' => 144
		}
	},
	{#State 77
		DEFAULT => -53,
		GOTOS => {
			'@52-2' => 145
		}
	},
	{#State 78
		ACTIONS => {
			"\$" => 54
		},
		GOTOS => {
			'scalar' => 146
		}
	},
	{#State 79
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			'STR' => 37,
			'NOTOP' => 56,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 65,
			'array' => 31,
			'varexpr' => 43,
			'expr' => 147,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 80
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			'STR' => 37,
			'NOTOP' => 56,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 65,
			'array' => 31,
			'varexpr' => 43,
			'expr' => 148,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 81
		ACTIONS => {
			"\$" => 54
		},
		GOTOS => {
			'scalar' => 149
		}
	},
	{#State 82
		DEFAULT => -147
	},
	{#State 83
		DEFAULT => -148
	},
	{#State 84
		DEFAULT => -92,
		GOTOS => {
			'@91-2' => 150
		}
	},
	{#State 85
		ACTIONS => {
			"\$" => 54,
			'MY' => 152
		},
		GOTOS => {
			'scalar' => 151,
			'scalarvar' => 153
		}
	},
	{#State 86
		ACTIONS => {
			'WORD' => 154,
			"\@" => -77,
			"%" => -77
		},
		GOTOS => {
			'label' => 155
		}
	},
	{#State 87
		DEFAULT => -73
	},
	{#State 88
		ACTIONS => {
			"{" => 156,
			"[" => 86
		},
		GOTOS => {
			'dimspec' => 157
		}
	},
	{#State 89
		ACTIONS => {
			";" => 158
		}
	},
	{#State 90
		ACTIONS => {
			";" => 159
		}
	},
	{#State 91
		DEFAULT => -141
	},
	{#State 92
		ACTIONS => {
			'WORD' => -135,
			'' => -135,
			"}" => -135,
			":" => -135,
			'PACKAGE' => -135,
			'XOROP' => -135,
			"\@" => -135,
			'DORDOR' => -135,
			"<" => 119,
			'PERL' => -135,
			'MY' => -135,
			"%" => -135,
			'ANDOP' => -135,
			"\$^" => -135,
			'UNLESS' => -135,
			'NUM' => -135,
			'STEP' => -135,
			'ASSIGNOP' => -135,
			'IF' => -135,
			"\$" => -135,
			'loopword' => -135,
			'FOREACH' => -135,
			"]" => -135,
			'ACROSS' => -135,
			'POWOP' => -135,
			'NOTOP' => -135,
			'FINAL' => -135,
			'OROP' => -135,
			'default' => -135,
			'INCLUDE' => -135,
			"(" => -135,
			'VAR' => -135,
			'ANDAND' => -135,
			'RELOP' => -135,
			'INCOP' => undef,
			'NOT2' => -135,
			";" => -135,
			'FOR' => -135,
			'FLOWLEFT' => -135,
			'ADDOP' => -135,
			"," => -135,
			'FUNC' => -135,
			'UNIT' => -135,
			'RETURN' => -135,
			'INIT' => -135,
			'var' => -135,
			'FUNCTION' => -135,
			'FLOWRIGHT' => -135,
			")" => -135,
			'STR' => -135,
			'CALC' => -135,
			"?" => -135,
			"{" => -135,
			'DOTDOT' => -135,
			'MULOP' => -135,
			'CONST' => -135,
			"=" => -135,
			'USE' => -135,
			'YADAYADA' => -135,
			'OROR' => -135
		},
		GOTOS => {
			'unitspec' => 123
		}
	},
	{#State 93
		DEFAULT => -67
	},
	{#State 94
		DEFAULT => -96,
		GOTOS => {
			'@95-2' => 160
		}
	},
	{#State 95
		ACTIONS => {
			'WORD' => -132,
			'' => -132,
			"}" => -132,
			":" => -132,
			'PACKAGE' => -132,
			'XOROP' => -132,
			"\@" => -132,
			'DORDOR' => -132,
			"<" => 119,
			'PERL' => -132,
			'MY' => -132,
			"%" => -132,
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
			'POWOP' => 130,
			'NOTOP' => -132,
			'FINAL' => -132,
			'OROP' => -132,
			'default' => -132,
			'INCLUDE' => -132,
			"(" => -132,
			'VAR' => -132,
			'ANDAND' => -132,
			'RELOP' => -132,
			'INCOP' => 124,
			'NOT2' => -132,
			";" => -132,
			'FOR' => -132,
			'FLOWLEFT' => -132,
			'ADDOP' => -132,
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
			'MULOP' => -132,
			'CONST' => -132,
			"=" => -132,
			'USE' => -132,
			'YADAYADA' => -132,
			'OROR' => -132
		},
		GOTOS => {
			'unitspec' => 123
		}
	},
	{#State 96
		ACTIONS => {
			";" => 162,
			"," => 161
		}
	},
	{#State 97
		DEFAULT => -24
	},
	{#State 98
		DEFAULT => -57,
		GOTOS => {
			'@56-2' => 163
		}
	},
	{#State 99
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			'STR' => 37,
			'NOTOP' => 56,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'sideff' => 164,
			'objname' => 11,
			'funcall' => 38,
			'term' => 65,
			'array' => 31,
			'varexpr' => 43,
			'expr' => 66,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 100
		ACTIONS => {
			"(" => 165
		}
	},
	{#State 101
		DEFAULT => -44,
		GOTOS => {
			'stmtseq' => 166
		}
	},
	{#State 102
		ACTIONS => {
			"=" => 167
		}
	},
	{#State 103
		ACTIONS => {
			"<" => 119,
			";" => -37,
			"[" => 86,
			"=" => -37
		},
		GOTOS => {
			'unitspec' => 169,
			'unitopt' => 168,
			'dimspec' => 170
		}
	},
	{#State 104
		ACTIONS => {
			'WORD' => 171,
			'FUNC' => 172
		}
	},
	{#State 105
		ACTIONS => {
			";" => 173
		}
	},
	{#State 106
		ACTIONS => {
			'WORD' => 175
		},
		GOTOS => {
			'pair' => 176,
			'pairlist' => 174
		}
	},
	{#State 107
		DEFAULT => -159
	},
	{#State 108
		ACTIONS => {
			";" => 177
		}
	},
	{#State 109
		ACTIONS => {
			'WORD' => 178
		}
	},
	{#State 110
		DEFAULT => -140
	},
	{#State 111
		DEFAULT => -151
	},
	{#State 112
		DEFAULT => -150
	},
	{#State 113
		DEFAULT => -146
	},
	{#State 114
		ACTIONS => {
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
			'ANDOP' => -104,
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
	{#State 115
		ACTIONS => {
			'XOROP' => 137,
			'OROP' => 136,
			")" => 179,
			'ANDOP' => 134
		}
	},
	{#State 116
		ACTIONS => {
			";" => 180
		}
	},
	{#State 117
		ACTIONS => {
			'WORD' => -133,
			'' => -133,
			"}" => -133,
			":" => -133,
			'PACKAGE' => -133,
			'XOROP' => -133,
			"\@" => -133,
			'DORDOR' => -133,
			"<" => 119,
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
			'POWOP' => 130,
			'NOTOP' => -133,
			'FINAL' => -133,
			'OROP' => -133,
			'default' => -133,
			'INCLUDE' => -133,
			"(" => -133,
			'VAR' => -133,
			'ANDAND' => -133,
			'RELOP' => -133,
			'INCOP' => 124,
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
			'unitspec' => 123
		}
	},
	{#State 118
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			"," => -97,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			")" => -97,
			'STR' => 37,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 183,
			'array' => 31,
			'arglist' => 181,
			'varexpr' => 43,
			'termbinop' => 55,
			'indexvar' => 74,
			'argexpr' => 182,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 119
		DEFAULT => -40,
		GOTOS => {
			'unitlist' => 184
		}
	},
	{#State 120
		ACTIONS => {
			'WORD' => 46,
			'STR' => 37,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			"(" => 60,
			'YADAYADA' => 72,
			'RETURN' => 68,
			"\$" => 54,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 185,
			'array' => 31,
			'varexpr' => 43,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 121
		ACTIONS => {
			'WORD' => 46,
			'STR' => 37,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			"(" => 60,
			'YADAYADA' => 72,
			'RETURN' => 68,
			"\$" => 54,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 186,
			'array' => 31,
			'varexpr' => 43,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 122
		ACTIONS => {
			'WORD' => 46,
			'STR' => 37,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			"(" => 60,
			'YADAYADA' => 72,
			'RETURN' => 68,
			"\$" => 54,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 187,
			'array' => 31,
			'varexpr' => 43,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 123
		DEFAULT => -119
	},
	{#State 124
		DEFAULT => -134
	},
	{#State 125
		ACTIONS => {
			'WORD' => 46,
			'STR' => 37,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			"(" => 60,
			'YADAYADA' => 72,
			'RETURN' => 68,
			"\$" => 54,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 188,
			'array' => 31,
			'varexpr' => 43,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 126
		ACTIONS => {
			'WORD' => 46,
			'STR' => 37,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			"(" => 60,
			'YADAYADA' => 72,
			'RETURN' => 68,
			"\$" => 54,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 189,
			'array' => 31,
			'varexpr' => 43,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 127
		ACTIONS => {
			'WORD' => 46,
			'STR' => 37,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			"(" => 60,
			'YADAYADA' => 72,
			'RETURN' => 68,
			"\$" => 54,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 190,
			'array' => 31,
			'varexpr' => 43,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 128
		ACTIONS => {
			'WORD' => 46,
			'STR' => 37,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			"(" => 60,
			'YADAYADA' => 72,
			'RETURN' => 68,
			"\$" => 54,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 191,
			'array' => 31,
			'varexpr' => 43,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 129
		ACTIONS => {
			'WORD' => 46,
			'STR' => 37,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			"(" => 60,
			'YADAYADA' => 72,
			'RETURN' => 68,
			"\$" => 54,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 192,
			'array' => 31,
			'varexpr' => 43,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 130
		ACTIONS => {
			'WORD' => 46,
			'STR' => 37,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			"(" => 60,
			'YADAYADA' => 72,
			'RETURN' => 68,
			"\$" => 54,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 193,
			'array' => 31,
			'varexpr' => 43,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 131
		ACTIONS => {
			'WORD' => 46,
			'STR' => 37,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			"(" => 60,
			'YADAYADA' => 72,
			'RETURN' => 68,
			"\$" => 54,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 194,
			'array' => 31,
			'varexpr' => 43,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 132
		ACTIONS => {
			'WORD' => 46,
			'STR' => 37,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			"(" => 60,
			'YADAYADA' => 72,
			'RETURN' => 68,
			"\$" => 54,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 195,
			'array' => 31,
			'varexpr' => 43,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 133
		ACTIONS => {
			'WORD' => 46,
			'STR' => 37,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			"(" => 60,
			'YADAYADA' => 72,
			'RETURN' => 68,
			"\$" => 54,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 196,
			'array' => 31,
			'varexpr' => 43,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 134
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			'STR' => 37,
			'NOTOP' => 56,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 65,
			'array' => 31,
			'varexpr' => 43,
			'expr' => 197,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 135
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			'STR' => 37,
			'NOTOP' => 56,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 65,
			'array' => 31,
			'varexpr' => 43,
			'expr' => 198,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 136
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			'STR' => 37,
			'NOTOP' => 56,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 65,
			'array' => 31,
			'varexpr' => 43,
			'expr' => 199,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 137
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			'STR' => 37,
			'NOTOP' => 56,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 65,
			'array' => 31,
			'varexpr' => 43,
			'expr' => 200,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 138
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			'STR' => 37,
			'NOTOP' => 56,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 65,
			'array' => 31,
			'varexpr' => 43,
			'expr' => 201,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 139
		ACTIONS => {
			'WORD' => -118,
			'' => -118,
			"}" => -118,
			":" => -118,
			'PACKAGE' => -118,
			"\@" => -118,
			"<" => -118,
			'DORDOR' => -118,
			'XOROP' => 137,
			'PERL' => -118,
			'MY' => -118,
			"%" => -118,
			'ANDOP' => 134,
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
			'POWOP' => -118,
			'ACROSS' => -118,
			'NOTOP' => -118,
			'FINAL' => -118,
			'OROP' => 136,
			'default' => -118,
			'INCLUDE' => -118,
			"(" => -118,
			'VAR' => -118,
			'ANDAND' => -118,
			'INCOP' => -118,
			'RELOP' => -118,
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
			'var' => -118,
			'FLOWRIGHT' => -118,
			")" => -118,
			'STR' => -118,
			'CALC' => -118,
			"?" => -118,
			'DOTDOT' => -118,
			'MULOP' => -118,
			"{" => -118,
			'CONST' => -118,
			"=" => -118,
			'USE' => -118,
			'YADAYADA' => -118,
			'OROR' => -118
		}
	},
	{#State 140
		DEFAULT => -83,
		GOTOS => {
			'@82-2' => 202
		}
	},
	{#State 141
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			"]" => 203,
			'STR' => 37,
			'NOTOP' => 56,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 65,
			'array' => 31,
			'varexpr' => 43,
			'expr' => 204,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 142
		DEFAULT => -152
	},
	{#State 143
		ACTIONS => {
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
			"[" => 141,
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
			'subspec' => 205
		}
	},
	{#State 144
		ACTIONS => {
			"%}" => 206
		}
	},
	{#State 145
		ACTIONS => {
			'perlseq' => 207
		}
	},
	{#State 146
		ACTIONS => {
			"(" => 209,
			'MULOP' => 208
		}
	},
	{#State 147
		ACTIONS => {
			'XOROP' => 137,
			'FLOWLEFT' => 210,
			'OROP' => 136,
			'FLOWRIGHT' => 211,
			'ANDOP' => 134
		}
	},
	{#State 148
		ACTIONS => {
			'XOROP' => 137,
			'OROP' => 136,
			")" => 212,
			'ANDOP' => 134
		}
	},
	{#State 149
		ACTIONS => {
			"(" => 214,
			'MULOP' => 213
		}
	},
	{#State 150
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			'STR' => 37,
			'NOTOP' => 56,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 65,
			'array' => 31,
			'varexpr' => 43,
			'expr' => 215,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 151
		DEFAULT => -144
	},
	{#State 152
		ACTIONS => {
			"\$" => 54
		},
		GOTOS => {
			'scalar' => 216
		}
	},
	{#State 153
		ACTIONS => {
			"(" => 217
		}
	},
	{#State 154
		ACTIONS => {
			":" => 218
		}
	},
	{#State 155
		ACTIONS => {
			"\@" => 10,
			"%" => 12
		},
		GOTOS => {
			'array' => 219,
			'set' => 220
		}
	},
	{#State 156
		DEFAULT => -43,
		GOTOS => {
			'@42-3' => 221
		}
	},
	{#State 157
		DEFAULT => -74
	},
	{#State 158
		DEFAULT => -21
	},
	{#State 159
		DEFAULT => -20
	},
	{#State 160
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			'STR' => 37,
			'NOTOP' => 56,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 65,
			'array' => 31,
			'varexpr' => 43,
			'expr' => 222,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 161
		ACTIONS => {
			'WORD' => 223
		}
	},
	{#State 162
		DEFAULT => -23
	},
	{#State 163
		DEFAULT => -44,
		GOTOS => {
			'stmtseq' => 224
		}
	},
	{#State 164
		ACTIONS => {
			";" => 225
		}
	},
	{#State 165
		ACTIONS => {
			"\$" => 54,
			")" => -32
		},
		GOTOS => {
			'params' => 229,
			'scalar' => 226,
			'paramlist' => 227,
			'param' => 228
		}
	},
	{#State 166
		ACTIONS => {
			"%{" => 6,
			'WORD' => 46,
			"}" => 230,
			'PACKAGE' => 47,
			"\@" => 10,
			'PERL' => 8,
			'MY' => 50,
			"%" => 12,
			"\$^" => 51,
			'UNLESS' => 13,
			'NUM' => 52,
			'STEP' => 15,
			'IF' => 53,
			"\$" => 54,
			'loopword' => 16,
			'FOREACH' => 18,
			'ACROSS' => 231,
			'NOTOP' => 56,
			'FINAL' => 23,
			"(" => 60,
			'VAR' => 61,
			'INCOP' => 25,
			'NOT2' => 62,
			'FOR' => 29,
			'ADDOP' => 30,
			'FUNC' => 64,
			'RETURN' => 68,
			'INIT' => 69,
			'STR' => 37,
			'CALC' => 70,
			"{" => 39,
			'CONST' => 40,
			'YADAYADA' => 72
		},
		GOTOS => {
			'scalar' => 91,
			'sideff' => 28,
			'objname' => 11,
			'term' => 65,
			'loop' => 14,
			'array' => 31,
			'expr' => 66,
			'phase' => 33,
			'termbinop' => 55,
			'set' => 36,
			'termunop' => 19,
			'line' => 232,
			'cond' => 22,
			'dynvar' => 58,
			'phaseblock' => 233,
			'perlblock' => 234,
			'condword' => 71,
			'funcall' => 38,
			'across' => 235,
			'package' => 42,
			'varexpr' => 43,
			'block' => 236,
			'indexvar' => 74,
			'simplevar' => 75,
			'objblock' => 26
		}
	},
	{#State 167
		DEFAULT => -70,
		GOTOS => {
			'@69-3' => 237
		}
	},
	{#State 168
		DEFAULT => -17
	},
	{#State 169
		DEFAULT => -38
	},
	{#State 170
		ACTIONS => {
			"<" => 119,
			";" => -37,
			"=" => -37
		},
		GOTOS => {
			'unitspec' => 169,
			'unitopt' => 238
		}
	},
	{#State 171
		DEFAULT => -138
	},
	{#State 172
		ACTIONS => {
			"(" => 239
		}
	},
	{#State 173
		DEFAULT => -22
	},
	{#State 174
		ACTIONS => {
			"}" => 240,
			"," => 241
		}
	},
	{#State 175
		ACTIONS => {
			":" => 242
		}
	},
	{#State 176
		DEFAULT => -162
	},
	{#State 177
		DEFAULT => -19
	},
	{#State 178
		ACTIONS => {
			"(" => 243
		}
	},
	{#State 179
		DEFAULT => -109
	},
	{#State 180
		DEFAULT => -68
	},
	{#State 181
		DEFAULT => -98
	},
	{#State 182
		ACTIONS => {
			"," => 244,
			")" => 245
		}
	},
	{#State 183
		ACTIONS => {
			'DORDOR' => 120,
			"<" => 119,
			'ADDOP' => 126,
			"," => -99,
			"%" => 121,
			'ASSIGNOP' => 122,
			")" => -99,
			'POWOP' => 130,
			"?" => 127,
			'MULOP' => 128,
			'DOTDOT' => 132,
			"=" => 133,
			'OROR' => 129,
			'ANDAND' => 131,
			'RELOP' => 125,
			'INCOP' => 124
		},
		GOTOS => {
			'unitspec' => 123
		}
	},
	{#State 184
		ACTIONS => {
			'UNIT' => 246,
			">" => 247
		}
	},
	{#State 185
		ACTIONS => {
			'WORD' => -131,
			'' => -131,
			"}" => -131,
			":" => -131,
			'PACKAGE' => -131,
			'XOROP' => -131,
			"\@" => -131,
			'DORDOR' => -131,
			"<" => 119,
			'PERL' => -131,
			'MY' => -131,
			"%" => 121,
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
			'POWOP' => 130,
			'NOTOP' => -131,
			'FINAL' => -131,
			'OROP' => -131,
			'default' => -131,
			'INCLUDE' => -131,
			"(" => -131,
			'VAR' => -131,
			'ANDAND' => 131,
			'RELOP' => 125,
			'INCOP' => 124,
			'NOT2' => -131,
			";" => -131,
			'FOR' => -131,
			'FLOWLEFT' => -131,
			'ADDOP' => 126,
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
			'MULOP' => 128,
			'CONST' => -131,
			"=" => -131,
			'USE' => -131,
			'YADAYADA' => -131,
			'OROR' => -131
		},
		GOTOS => {
			'unitspec' => 123
		}
	},
	{#State 186
		ACTIONS => {
			'WORD' => -125,
			'' => -125,
			"}" => -125,
			":" => -125,
			'PACKAGE' => -125,
			'XOROP' => -125,
			"\@" => -125,
			'DORDOR' => -125,
			"<" => 119,
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
			'POWOP' => 130,
			'NOTOP' => -125,
			'FINAL' => -125,
			'OROP' => -125,
			'default' => -125,
			'INCLUDE' => -125,
			"(" => -125,
			'VAR' => -125,
			'ANDAND' => -125,
			'RELOP' => -125,
			'INCOP' => 124,
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
			'unitspec' => 123
		}
	},
	{#State 187
		ACTIONS => {
			'WORD' => -121,
			'' => -121,
			"}" => -121,
			":" => -121,
			'PACKAGE' => -121,
			'XOROP' => -121,
			"\@" => -121,
			'DORDOR' => 120,
			"<" => 119,
			'PERL' => -121,
			'MY' => -121,
			"%" => 121,
			'ANDOP' => -121,
			"\$^" => -121,
			'UNLESS' => -121,
			'NUM' => -121,
			'STEP' => -121,
			'ASSIGNOP' => 122,
			'IF' => -121,
			"\$" => -121,
			'loopword' => -121,
			'FOREACH' => -121,
			"]" => -121,
			'ACROSS' => -121,
			'POWOP' => 130,
			'NOTOP' => -121,
			'FINAL' => -121,
			'OROP' => -121,
			'default' => -121,
			'INCLUDE' => -121,
			"(" => -121,
			'VAR' => -121,
			'ANDAND' => 131,
			'RELOP' => 125,
			'INCOP' => 124,
			'NOT2' => -121,
			";" => -121,
			'FOR' => -121,
			'FLOWLEFT' => -121,
			'ADDOP' => 126,
			"," => -121,
			'FUNC' => -121,
			'UNIT' => -121,
			'RETURN' => -121,
			'INIT' => -121,
			'var' => -121,
			'FUNCTION' => -121,
			'FLOWRIGHT' => -121,
			")" => -121,
			'STR' => -121,
			'CALC' => -121,
			"?" => 127,
			"{" => -121,
			'DOTDOT' => 132,
			'MULOP' => 128,
			'CONST' => -121,
			"=" => 133,
			'USE' => -121,
			'YADAYADA' => -121,
			'OROR' => 129
		},
		GOTOS => {
			'unitspec' => 123
		}
	},
	{#State 188
		ACTIONS => {
			'WORD' => -127,
			'' => -127,
			"}" => -127,
			":" => -127,
			'PACKAGE' => -127,
			'XOROP' => -127,
			"\@" => -127,
			'DORDOR' => -127,
			"<" => 119,
			'PERL' => -127,
			'MY' => -127,
			"%" => 121,
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
			'POWOP' => 130,
			'NOTOP' => -127,
			'FINAL' => -127,
			'OROP' => -127,
			'default' => -127,
			'INCLUDE' => -127,
			"(" => -127,
			'VAR' => -127,
			'ANDAND' => -127,
			'RELOP' => undef,
			'INCOP' => 124,
			'NOT2' => -127,
			";" => -127,
			'FOR' => -127,
			'FLOWLEFT' => -127,
			'ADDOP' => 126,
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
			'MULOP' => 128,
			'CONST' => -127,
			"=" => -127,
			'USE' => -127,
			'YADAYADA' => -127,
			'OROR' => -127
		},
		GOTOS => {
			'unitspec' => 123
		}
	},
	{#State 189
		ACTIONS => {
			'WORD' => -123,
			'' => -123,
			"}" => -123,
			":" => -123,
			'PACKAGE' => -123,
			'XOROP' => -123,
			"\@" => -123,
			'DORDOR' => -123,
			"<" => 119,
			'PERL' => -123,
			'MY' => -123,
			"%" => 121,
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
			'POWOP' => 130,
			'NOTOP' => -123,
			'FINAL' => -123,
			'OROP' => -123,
			'default' => -123,
			'INCLUDE' => -123,
			"(" => -123,
			'VAR' => -123,
			'ANDAND' => -123,
			'RELOP' => -123,
			'INCOP' => 124,
			'NOT2' => -123,
			";" => -123,
			'FOR' => -123,
			'FLOWLEFT' => -123,
			'ADDOP' => -123,
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
			"?" => -123,
			"{" => -123,
			'DOTDOT' => -123,
			'MULOP' => 128,
			'CONST' => -123,
			"=" => -123,
			'USE' => -123,
			'YADAYADA' => -123,
			'OROR' => -123
		},
		GOTOS => {
			'unitspec' => 123
		}
	},
	{#State 190
		ACTIONS => {
			":" => 248,
			"?" => 127,
			'DORDOR' => 120,
			"<" => 119,
			'DOTDOT' => 132,
			'MULOP' => 128,
			'ADDOP' => 126,
			"%" => 121,
			"=" => 133,
			'ASSIGNOP' => 122,
			'ANDAND' => 131,
			'OROR' => 129,
			'POWOP' => 130,
			'INCOP' => 124,
			'RELOP' => 125
		},
		GOTOS => {
			'unitspec' => 123
		}
	},
	{#State 191
		ACTIONS => {
			'WORD' => -124,
			'' => -124,
			"}" => -124,
			":" => -124,
			'PACKAGE' => -124,
			'XOROP' => -124,
			"\@" => -124,
			'DORDOR' => -124,
			"<" => 119,
			'PERL' => -124,
			'MY' => -124,
			"%" => -124,
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
			'POWOP' => 130,
			'NOTOP' => -124,
			'FINAL' => -124,
			'OROP' => -124,
			'default' => -124,
			'INCLUDE' => -124,
			"(" => -124,
			'VAR' => -124,
			'ANDAND' => -124,
			'RELOP' => -124,
			'INCOP' => 124,
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
			'MULOP' => -124,
			'CONST' => -124,
			"=" => -124,
			'USE' => -124,
			'YADAYADA' => -124,
			'OROR' => -124
		},
		GOTOS => {
			'unitspec' => 123
		}
	},
	{#State 192
		ACTIONS => {
			'WORD' => -130,
			'' => -130,
			"}" => -130,
			":" => -130,
			'PACKAGE' => -130,
			'XOROP' => -130,
			"\@" => -130,
			'DORDOR' => -130,
			"<" => 119,
			'PERL' => -130,
			'MY' => -130,
			"%" => 121,
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
			'POWOP' => 130,
			'NOTOP' => -130,
			'FINAL' => -130,
			'OROP' => -130,
			'default' => -130,
			'INCLUDE' => -130,
			"(" => -130,
			'VAR' => -130,
			'ANDAND' => 131,
			'RELOP' => 125,
			'INCOP' => 124,
			'NOT2' => -130,
			";" => -130,
			'FOR' => -130,
			'FLOWLEFT' => -130,
			'ADDOP' => 126,
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
			'MULOP' => 128,
			'CONST' => -130,
			"=" => -130,
			'USE' => -130,
			'YADAYADA' => -130,
			'OROR' => -130
		},
		GOTOS => {
			'unitspec' => 123
		}
	},
	{#State 193
		ACTIONS => {
			'WORD' => -126,
			'' => -126,
			"}" => -126,
			":" => -126,
			'PACKAGE' => -126,
			'XOROP' => -126,
			"\@" => -126,
			'DORDOR' => -126,
			"<" => 119,
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
			'POWOP' => 130,
			'NOTOP' => -126,
			'FINAL' => -126,
			'OROP' => -126,
			'default' => -126,
			'INCLUDE' => -126,
			"(" => -126,
			'VAR' => -126,
			'ANDAND' => -126,
			'RELOP' => -126,
			'INCOP' => 124,
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
			'unitspec' => 123
		}
	},
	{#State 194
		ACTIONS => {
			'WORD' => -129,
			'' => -129,
			"}" => -129,
			":" => -129,
			'PACKAGE' => -129,
			'XOROP' => -129,
			"\@" => -129,
			'DORDOR' => -129,
			"<" => 119,
			'PERL' => -129,
			'MY' => -129,
			"%" => 121,
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
			'POWOP' => 130,
			'NOTOP' => -129,
			'FINAL' => -129,
			'OROP' => -129,
			'default' => -129,
			'INCLUDE' => -129,
			"(" => -129,
			'VAR' => -129,
			'ANDAND' => -129,
			'RELOP' => 125,
			'INCOP' => 124,
			'NOT2' => -129,
			";" => -129,
			'FOR' => -129,
			'FLOWLEFT' => -129,
			'ADDOP' => 126,
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
			'DOTDOT' => -129,
			'MULOP' => 128,
			'CONST' => -129,
			"=" => -129,
			'USE' => -129,
			'YADAYADA' => -129,
			'OROR' => -129
		},
		GOTOS => {
			'unitspec' => 123
		}
	},
	{#State 195
		ACTIONS => {
			'WORD' => -128,
			'' => -128,
			"}" => -128,
			":" => -128,
			'PACKAGE' => -128,
			'XOROP' => -128,
			"\@" => -128,
			'DORDOR' => 120,
			"<" => 119,
			'PERL' => -128,
			'MY' => -128,
			"%" => 121,
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
			'POWOP' => 130,
			'NOTOP' => -128,
			'FINAL' => -128,
			'OROP' => -128,
			'default' => -128,
			'INCLUDE' => -128,
			"(" => -128,
			'VAR' => -128,
			'ANDAND' => 131,
			'RELOP' => 125,
			'INCOP' => 124,
			'NOT2' => -128,
			";" => -128,
			'FOR' => -128,
			'FLOWLEFT' => -128,
			'ADDOP' => 126,
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
			'DOTDOT' => undef,
			'MULOP' => 128,
			'CONST' => -128,
			"=" => -128,
			'USE' => -128,
			'YADAYADA' => -128,
			'OROR' => 129
		},
		GOTOS => {
			'unitspec' => 123
		}
	},
	{#State 196
		ACTIONS => {
			'WORD' => -122,
			'' => -122,
			"}" => -122,
			":" => -122,
			'PACKAGE' => -122,
			'XOROP' => -122,
			"\@" => -122,
			'DORDOR' => 120,
			"<" => 119,
			'PERL' => -122,
			'MY' => -122,
			"%" => 121,
			'ANDOP' => -122,
			"\$^" => -122,
			'UNLESS' => -122,
			'NUM' => -122,
			'STEP' => -122,
			'ASSIGNOP' => 122,
			'IF' => -122,
			"\$" => -122,
			'loopword' => -122,
			'FOREACH' => -122,
			"]" => -122,
			'ACROSS' => -122,
			'POWOP' => 130,
			'NOTOP' => -122,
			'FINAL' => -122,
			'OROP' => -122,
			'default' => -122,
			'INCLUDE' => -122,
			"(" => -122,
			'VAR' => -122,
			'ANDAND' => 131,
			'RELOP' => 125,
			'INCOP' => 124,
			'NOT2' => -122,
			";" => -122,
			'FOR' => -122,
			'FLOWLEFT' => -122,
			'ADDOP' => 126,
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
			"?" => 127,
			"{" => -122,
			'DOTDOT' => 132,
			'MULOP' => 128,
			'CONST' => -122,
			"=" => 133,
			'USE' => -122,
			'YADAYADA' => -122,
			'OROR' => 129
		},
		GOTOS => {
			'unitspec' => 123
		}
	},
	{#State 197
		ACTIONS => {
			'WORD' => -101,
			'' => -101,
			"}" => -101,
			":" => -101,
			'PACKAGE' => -101,
			"\@" => -101,
			"<" => -101,
			'DORDOR' => -101,
			'XOROP' => -101,
			'PERL' => -101,
			'MY' => -101,
			"%" => -101,
			'ANDOP' => -101,
			"\$^" => -101,
			'UNLESS' => -101,
			'NUM' => -101,
			'STEP' => -101,
			'ASSIGNOP' => -101,
			'IF' => -101,
			"\$" => -101,
			'loopword' => -101,
			'FOREACH' => -101,
			"]" => -101,
			'POWOP' => -101,
			'ACROSS' => -101,
			'NOTOP' => -101,
			'FINAL' => -101,
			'OROP' => -101,
			'default' => -101,
			'INCLUDE' => -101,
			"(" => -101,
			'VAR' => -101,
			'ANDAND' => -101,
			'INCOP' => -101,
			'RELOP' => -101,
			'NOT2' => -101,
			";" => -101,
			'FOR' => -101,
			'FLOWLEFT' => -101,
			'ADDOP' => -101,
			"," => -101,
			'FUNC' => -101,
			'UNIT' => -101,
			'RETURN' => -101,
			'INIT' => -101,
			'FUNCTION' => -101,
			'var' => -101,
			'FLOWRIGHT' => -101,
			")" => -101,
			'STR' => -101,
			'CALC' => -101,
			"?" => -101,
			'DOTDOT' => -101,
			'MULOP' => -101,
			"{" => -101,
			'CONST' => -101,
			"=" => -101,
			'USE' => -101,
			'YADAYADA' => -101,
			'OROR' => -101
		}
	},
	{#State 198
		ACTIONS => {
			'XOROP' => 137,
			";" => -81,
			'OROP' => 136,
			'ANDOP' => 134
		}
	},
	{#State 199
		ACTIONS => {
			'WORD' => -102,
			'' => -102,
			"}" => -102,
			":" => -102,
			'PACKAGE' => -102,
			"\@" => -102,
			"<" => -102,
			'DORDOR' => -102,
			'XOROP' => -102,
			'PERL' => -102,
			'MY' => -102,
			"%" => -102,
			'ANDOP' => 134,
			"\$^" => -102,
			'UNLESS' => -102,
			'NUM' => -102,
			'STEP' => -102,
			'ASSIGNOP' => -102,
			'IF' => -102,
			"\$" => -102,
			'loopword' => -102,
			'FOREACH' => -102,
			"]" => -102,
			'POWOP' => -102,
			'ACROSS' => -102,
			'NOTOP' => -102,
			'FINAL' => -102,
			'OROP' => -102,
			'default' => -102,
			'INCLUDE' => -102,
			"(" => -102,
			'VAR' => -102,
			'ANDAND' => -102,
			'INCOP' => -102,
			'RELOP' => -102,
			'NOT2' => -102,
			";" => -102,
			'FOR' => -102,
			'FLOWLEFT' => -102,
			'ADDOP' => -102,
			"," => -102,
			'FUNC' => -102,
			'UNIT' => -102,
			'RETURN' => -102,
			'INIT' => -102,
			'FUNCTION' => -102,
			'var' => -102,
			'FLOWRIGHT' => -102,
			")" => -102,
			'STR' => -102,
			'CALC' => -102,
			"?" => -102,
			'DOTDOT' => -102,
			'MULOP' => -102,
			"{" => -102,
			'CONST' => -102,
			"=" => -102,
			'USE' => -102,
			'YADAYADA' => -102,
			'OROR' => -102
		}
	},
	{#State 200
		ACTIONS => {
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
			'ANDOP' => 134,
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
	{#State 201
		ACTIONS => {
			'XOROP' => 137,
			";" => -80,
			'OROP' => 136,
			'ANDOP' => 134
		}
	},
	{#State 202
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			'STR' => 37,
			'NOTOP' => 56,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 65,
			'array' => 31,
			'varexpr' => 43,
			'expr' => 249,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 203
		DEFAULT => -154
	},
	{#State 204
		ACTIONS => {
			'XOROP' => 137,
			'OROP' => 136,
			"]" => 250,
			'ANDOP' => 134
		}
	},
	{#State 205
		DEFAULT => -153
	},
	{#State 206
		DEFAULT => -54
	},
	{#State 207
		ACTIONS => {
			"}" => 251
		}
	},
	{#State 208
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			'STR' => 37,
			'NOTOP' => 56,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 65,
			'array' => 31,
			'varexpr' => 43,
			'expr' => 252,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 209
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			'STR' => 37,
			'NOTOP' => 56,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 65,
			'array' => 31,
			'varexpr' => 43,
			'expr' => 253,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 210
		ACTIONS => {
			"\$" => 54
		},
		GOTOS => {
			'scalar' => 254
		}
	},
	{#State 211
		ACTIONS => {
			"\$" => 54
		},
		GOTOS => {
			'scalar' => 255
		}
	},
	{#State 212
		ACTIONS => {
			'FLOWLEFT' => 256,
			'FLOWRIGHT' => 257
		}
	},
	{#State 213
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			'STR' => 37,
			'NOTOP' => 56,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 65,
			'array' => 31,
			'varexpr' => 43,
			'expr' => 258,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 214
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			'STR' => 37,
			'NOTOP' => 56,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 65,
			'array' => 31,
			'varexpr' => 43,
			'expr' => 259,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 215
		ACTIONS => {
			'XOROP' => 137,
			'OROP' => 136,
			")" => 260,
			'ANDOP' => 134
		}
	},
	{#State 216
		DEFAULT => -145
	},
	{#State 217
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			'STR' => 37,
			'NOTOP' => 56,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 65,
			'array' => 31,
			'varexpr' => 43,
			'expr' => 261,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 218
		DEFAULT => -78
	},
	{#State 219
		ACTIONS => {
			"]" => 262
		}
	},
	{#State 220
		ACTIONS => {
			"]" => 263
		}
	},
	{#State 221
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
			'default' => -2,
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
			'var' => -2,
			'STR' => -2,
			'CALC' => -2,
			"{" => -2,
			'CONST' => -2,
			'USE' => -2,
			'YADAYADA' => -2,
			'progseg' => 3
		},
		GOTOS => {
			'progseq' => 264
		}
	},
	{#State 222
		ACTIONS => {
			'XOROP' => 137,
			";" => 265,
			'OROP' => 136,
			'ANDOP' => 134
		}
	},
	{#State 223
		DEFAULT => -25
	},
	{#State 224
		ACTIONS => {
			"%{" => 6,
			'WORD' => 46,
			"}" => 266,
			'PACKAGE' => 47,
			"\@" => 10,
			'PERL' => 8,
			'MY' => 50,
			"%" => 12,
			"\$^" => 51,
			'UNLESS' => 13,
			'NUM' => 52,
			'STEP' => 15,
			'IF' => 53,
			"\$" => 54,
			'loopword' => 16,
			'FOREACH' => 18,
			'ACROSS' => 231,
			'NOTOP' => 56,
			'FINAL' => 23,
			"(" => 60,
			'VAR' => 61,
			'INCOP' => 25,
			'NOT2' => 62,
			'FOR' => 29,
			'ADDOP' => 30,
			'FUNC' => 64,
			'RETURN' => 68,
			'INIT' => 69,
			'STR' => 37,
			'CALC' => 70,
			"{" => 39,
			'CONST' => 40,
			'YADAYADA' => 72
		},
		GOTOS => {
			'scalar' => 91,
			'sideff' => 28,
			'objname' => 11,
			'term' => 65,
			'loop' => 14,
			'array' => 31,
			'expr' => 66,
			'phase' => 33,
			'termbinop' => 55,
			'set' => 36,
			'termunop' => 19,
			'line' => 232,
			'cond' => 22,
			'dynvar' => 58,
			'phaseblock' => 233,
			'perlblock' => 234,
			'condword' => 71,
			'funcall' => 38,
			'across' => 235,
			'package' => 42,
			'varexpr' => 43,
			'block' => 236,
			'indexvar' => 74,
			'simplevar' => 75,
			'objblock' => 26
		}
	},
	{#State 225
		DEFAULT => -62
	},
	{#State 226
		DEFAULT => -36
	},
	{#State 227
		ACTIONS => {
			"," => 267,
			")" => -33
		}
	},
	{#State 228
		DEFAULT => -34
	},
	{#State 229
		ACTIONS => {
			")" => 268
		}
	},
	{#State 230
		DEFAULT => -50
	},
	{#State 231
		ACTIONS => {
			"[" => 86
		},
		GOTOS => {
			'dimlist' => 269,
			'dimspec' => 87
		}
	},
	{#State 232
		DEFAULT => -49
	},
	{#State 233
		DEFAULT => -48
	},
	{#State 234
		DEFAULT => -47
	},
	{#State 235
		DEFAULT => -45
	},
	{#State 236
		DEFAULT => -46
	},
	{#State 237
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			'STR' => 37,
			'NOTOP' => 56,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 65,
			'array' => 31,
			'varexpr' => 43,
			'expr' => 270,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 238
		DEFAULT => -18
	},
	{#State 239
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			"," => -97,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			")" => -97,
			'STR' => 37,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 183,
			'array' => 31,
			'arglist' => 181,
			'varexpr' => 43,
			'termbinop' => 55,
			'indexvar' => 74,
			'argexpr' => 271,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 240
		DEFAULT => -160
	},
	{#State 241
		ACTIONS => {
			'WORD' => 175,
			"}" => 272
		},
		GOTOS => {
			'pair' => 273
		}
	},
	{#State 242
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			'STR' => 37,
			'NOTOP' => 56,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 65,
			'array' => 31,
			'varexpr' => 43,
			'expr' => 274,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 243
		ACTIONS => {
			"\$" => 54,
			")" => -32
		},
		GOTOS => {
			'params' => 275,
			'scalar' => 226,
			'paramlist' => 227,
			'param' => 228
		}
	},
	{#State 244
		ACTIONS => {
			'WORD' => 46,
			'STR' => 37,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			"(" => 60,
			'YADAYADA' => 72,
			'RETURN' => 68,
			"\$" => 54,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 276,
			'array' => 31,
			'varexpr' => 43,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 245
		ACTIONS => {
			'WORD' => -156,
			'' => -156,
			"}" => -156,
			":" => -156,
			'PACKAGE' => -156,
			'XOROP' => -156,
			"\@" => -156,
			"<" => -156,
			'DORDOR' => -156,
			'PERL' => -156,
			'MY' => -156,
			"%" => -156,
			'ANDOP' => -156,
			"\$^" => -156,
			'UNLESS' => -156,
			'NUM' => -156,
			'STEP' => -156,
			'ASSIGNOP' => -156,
			'IF' => -156,
			"\$" => -156,
			'loopword' => -156,
			'FOREACH' => -156,
			"]" => -156,
			'POWOP' => -156,
			'ACROSS' => -156,
			'NOTOP' => -156,
			'FINAL' => -156,
			'DOT' => 277,
			'OROP' => -156,
			'default' => -156,
			'INCLUDE' => -156,
			"(" => -156,
			'VAR' => -156,
			'ANDAND' => -156,
			'INCOP' => -156,
			'RELOP' => -156,
			'NOT2' => -156,
			";" => -156,
			'FOR' => -156,
			'FLOWLEFT' => -156,
			'ADDOP' => -156,
			"," => -156,
			'FUNC' => -156,
			'UNIT' => -156,
			'RETURN' => -156,
			'INIT' => -156,
			'FUNCTION' => -156,
			'var' => -156,
			'FLOWRIGHT' => -156,
			")" => -156,
			'STR' => -156,
			'CALC' => -156,
			"?" => -156,
			'DOTDOT' => -156,
			'MULOP' => -156,
			"{" => -156,
			'CONST' => -156,
			"=" => -156,
			'USE' => -156,
			'YADAYADA' => -156,
			'OROR' => -156
		}
	},
	{#State 246
		DEFAULT => -41
	},
	{#State 247
		DEFAULT => -39
	},
	{#State 248
		ACTIONS => {
			'WORD' => 46,
			'STR' => 37,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			"(" => 60,
			'YADAYADA' => 72,
			'RETURN' => 68,
			"\$" => 54,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 278,
			'array' => 31,
			'varexpr' => 43,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 249
		ACTIONS => {
			'XOROP' => 137,
			'OROP' => 136,
			")" => 279,
			'ANDOP' => 134
		}
	},
	{#State 250
		DEFAULT => -155
	},
	{#State 251
		DEFAULT => -52
	},
	{#State 252
		ACTIONS => {
			'WORD' => -168,
			'' => -168,
			"}" => -168,
			'PACKAGE' => -168,
			"\@" => -168,
			'XOROP' => 137,
			'PERL' => -168,
			'MY' => -168,
			"%" => -168,
			'ANDOP' => 134,
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
			'OROP' => 136,
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
	{#State 253
		ACTIONS => {
			'XOROP' => 137,
			'OROP' => 136,
			")" => 280,
			'ANDOP' => 134
		}
	},
	{#State 254
		DEFAULT => -166
	},
	{#State 255
		DEFAULT => -165
	},
	{#State 256
		ACTIONS => {
			"\$" => 54
		},
		GOTOS => {
			'scalar' => 281
		}
	},
	{#State 257
		ACTIONS => {
			"\$" => 54
		},
		GOTOS => {
			'scalar' => 282
		}
	},
	{#State 258
		ACTIONS => {
			'WORD' => -167,
			'' => -167,
			"}" => -167,
			'PACKAGE' => -167,
			"\@" => -167,
			'XOROP' => 137,
			'PERL' => -167,
			'MY' => -167,
			"%" => -167,
			'ANDOP' => 134,
			"\$^" => -167,
			'UNLESS' => -167,
			'NUM' => -167,
			'STEP' => -167,
			'IF' => -167,
			"\$" => -167,
			'loopword' => -167,
			'FOREACH' => -167,
			'ACROSS' => -167,
			'NOTOP' => -167,
			'FINAL' => -167,
			'OROP' => 136,
			'default' => -167,
			'INCLUDE' => -167,
			"(" => -167,
			'VAR' => -167,
			'INCOP' => -167,
			'NOT2' => -167,
			'FOR' => -167,
			'ADDOP' => -167,
			'FUNC' => -167,
			'UNIT' => -167,
			'RETURN' => -167,
			'INIT' => -167,
			'FUNCTION' => -167,
			'var' => -167,
			'STR' => -167,
			'CALC' => -167,
			"{" => -167,
			'CONST' => -167,
			'USE' => -167,
			'YADAYADA' => -167
		}
	},
	{#State 259
		ACTIONS => {
			'XOROP' => 137,
			'OROP' => 136,
			")" => 283,
			'ANDOP' => 134
		}
	},
	{#State 260
		ACTIONS => {
			"{" => 284
		}
	},
	{#State 261
		ACTIONS => {
			'XOROP' => 137,
			'OROP' => 136,
			")" => 285,
			'ANDOP' => 134
		}
	},
	{#State 262
		DEFAULT => -75
	},
	{#State 263
		DEFAULT => -76
	},
	{#State 264
		ACTIONS => {
			'WORD' => 46,
			"}" => 286,
			'PACKAGE' => 47,
			"\@" => 10,
			'PERL' => 49,
			'MY' => 50,
			"%" => 12,
			"\$^" => 51,
			'UNLESS' => 13,
			'NUM' => 52,
			'STEP' => 15,
			'IF' => 53,
			"\$" => 54,
			'loopword' => 16,
			'FOREACH' => 18,
			'ACROSS' => 20,
			'NOTOP' => 56,
			'FINAL' => 23,
			'default' => 59,
			'INCLUDE' => 24,
			"(" => 60,
			'VAR' => 61,
			'INCOP' => 25,
			'NOT2' => 62,
			'FOR' => 29,
			'ADDOP' => 30,
			'FUNC' => 64,
			'UNIT' => 32,
			'RETURN' => 68,
			'INIT' => 69,
			'FUNCTION' => 35,
			'var' => 34,
			'STR' => 37,
			'CALC' => 70,
			"{" => 39,
			'CONST' => 40,
			'USE' => 44,
			'YADAYADA' => 72
		},
		GOTOS => {
			'scalar' => 9,
			'function' => 27,
			'sideff' => 28,
			'objname' => 11,
			'include' => 63,
			'tl_across' => 48,
			'term' => 65,
			'loop' => 14,
			'array' => 31,
			'use' => 67,
			'expr' => 66,
			'phase' => 33,
			'termbinop' => 55,
			'flow' => 17,
			'set' => 36,
			'termunop' => 19,
			'line' => 21,
			'cond' => 22,
			'phaseblock' => 57,
			'dynvar' => 58,
			'condword' => 71,
			'funcall' => 38,
			'tl_decl' => 41,
			'package' => 42,
			'unit' => 45,
			'varexpr' => 43,
			'block' => 73,
			'indexvar' => 74,
			'simplevar' => 75,
			'objblock' => 26
		}
	},
	{#State 265
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			'STR' => 37,
			'NOTOP' => 56,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 65,
			'array' => 31,
			'varexpr' => 43,
			'expr' => 287,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 266
		DEFAULT => -56
	},
	{#State 267
		ACTIONS => {
			"\$" => 54
		},
		GOTOS => {
			'scalar' => 226,
			'param' => 288
		}
	},
	{#State 268
		ACTIONS => {
			"<" => 119,
			";" => -37,
			"{" => -37
		},
		GOTOS => {
			'unitspec' => 169,
			'unitopt' => 289
		}
	},
	{#State 269
		ACTIONS => {
			"{" => 290,
			"[" => 86
		},
		GOTOS => {
			'dimspec' => 157
		}
	},
	{#State 270
		ACTIONS => {
			'XOROP' => 137,
			";" => 291,
			'OROP' => 136,
			'ANDOP' => 134
		}
	},
	{#State 271
		ACTIONS => {
			"," => 244,
			")" => 292
		}
	},
	{#State 272
		DEFAULT => -161
	},
	{#State 273
		DEFAULT => -163
	},
	{#State 274
		ACTIONS => {
			"}" => -164,
			'XOROP' => 137,
			'OROP' => 136,
			"," => -164,
			'ANDOP' => 134
		}
	},
	{#State 275
		ACTIONS => {
			")" => 293
		}
	},
	{#State 276
		ACTIONS => {
			'DORDOR' => 120,
			"<" => 119,
			'ADDOP' => 126,
			"," => -100,
			"%" => 121,
			'ASSIGNOP' => 122,
			")" => -100,
			'POWOP' => 130,
			"?" => 127,
			'MULOP' => 128,
			'DOTDOT' => 132,
			"=" => 133,
			'OROR' => 129,
			'ANDAND' => 131,
			'RELOP' => 125,
			'INCOP' => 124
		},
		GOTOS => {
			'unitspec' => 123
		}
	},
	{#State 277
		ACTIONS => {
			'WORD' => 294
		}
	},
	{#State 278
		ACTIONS => {
			'WORD' => -108,
			'' => -108,
			"}" => -108,
			":" => -108,
			'PACKAGE' => -108,
			'XOROP' => -108,
			"\@" => -108,
			'DORDOR' => 120,
			"<" => 119,
			'PERL' => -108,
			'MY' => -108,
			"%" => 121,
			'ANDOP' => -108,
			"\$^" => -108,
			'UNLESS' => -108,
			'NUM' => -108,
			'STEP' => -108,
			'ASSIGNOP' => -108,
			'IF' => -108,
			"\$" => -108,
			'loopword' => -108,
			'FOREACH' => -108,
			"]" => -108,
			'ACROSS' => -108,
			'POWOP' => 130,
			'NOTOP' => -108,
			'FINAL' => -108,
			'OROP' => -108,
			'default' => -108,
			'INCLUDE' => -108,
			"(" => -108,
			'VAR' => -108,
			'ANDAND' => 131,
			'RELOP' => 125,
			'INCOP' => 124,
			'NOT2' => -108,
			";" => -108,
			'FOR' => -108,
			'FLOWLEFT' => -108,
			'ADDOP' => 126,
			"," => -108,
			'FUNC' => -108,
			'UNIT' => -108,
			'RETURN' => -108,
			'INIT' => -108,
			'var' => -108,
			'FUNCTION' => -108,
			'FLOWRIGHT' => -108,
			")" => -108,
			'STR' => -108,
			'CALC' => -108,
			"?" => 127,
			"{" => -108,
			'DOTDOT' => 132,
			'MULOP' => 128,
			'CONST' => -108,
			"=" => -108,
			'USE' => -108,
			'YADAYADA' => -108,
			'OROR' => 129
		},
		GOTOS => {
			'unitspec' => 123
		}
	},
	{#State 279
		ACTIONS => {
			"{" => 295
		}
	},
	{#State 280
		DEFAULT => -172
	},
	{#State 281
		DEFAULT => -170
	},
	{#State 282
		DEFAULT => -169
	},
	{#State 283
		DEFAULT => -171
	},
	{#State 284
		DEFAULT => -44,
		GOTOS => {
			'stmtseq' => 296
		}
	},
	{#State 285
		ACTIONS => {
			"{" => 297
		}
	},
	{#State 286
		DEFAULT => -42
	},
	{#State 287
		ACTIONS => {
			'XOROP' => 137,
			";" => 298,
			'OROP' => 136,
			'ANDOP' => 134
		}
	},
	{#State 288
		DEFAULT => -35
	},
	{#State 289
		ACTIONS => {
			";" => 300,
			"{" => 299
		}
	},
	{#State 290
		DEFAULT => -72,
		GOTOS => {
			'@71-3' => 301
		}
	},
	{#State 291
		DEFAULT => -69
	},
	{#State 292
		DEFAULT => -139
	},
	{#State 293
		ACTIONS => {
			"<" => 119,
			";" => -37,
			"{" => -37
		},
		GOTOS => {
			'unitspec' => 169,
			'unitopt' => 302
		}
	},
	{#State 294
		DEFAULT => -157
	},
	{#State 295
		DEFAULT => -44,
		GOTOS => {
			'stmtseq' => 303
		}
	},
	{#State 296
		ACTIONS => {
			"%{" => 6,
			'WORD' => 46,
			"}" => 304,
			'PACKAGE' => 47,
			"\@" => 10,
			'PERL' => 8,
			'MY' => 50,
			"%" => 12,
			"\$^" => 51,
			'UNLESS' => 13,
			'NUM' => 52,
			'STEP' => 15,
			'IF' => 53,
			"\$" => 54,
			'loopword' => 16,
			'FOREACH' => 18,
			'ACROSS' => 231,
			'NOTOP' => 56,
			'FINAL' => 23,
			"(" => 60,
			'VAR' => 61,
			'INCOP' => 25,
			'NOT2' => 62,
			'FOR' => 29,
			'ADDOP' => 30,
			'FUNC' => 64,
			'RETURN' => 68,
			'INIT' => 69,
			'STR' => 37,
			'CALC' => 70,
			"{" => 39,
			'CONST' => 40,
			'YADAYADA' => 72
		},
		GOTOS => {
			'scalar' => 91,
			'sideff' => 28,
			'objname' => 11,
			'term' => 65,
			'loop' => 14,
			'array' => 31,
			'expr' => 66,
			'phase' => 33,
			'termbinop' => 55,
			'set' => 36,
			'termunop' => 19,
			'line' => 232,
			'cond' => 22,
			'dynvar' => 58,
			'phaseblock' => 233,
			'perlblock' => 234,
			'condword' => 71,
			'funcall' => 38,
			'across' => 235,
			'package' => 42,
			'varexpr' => 43,
			'block' => 236,
			'indexvar' => 74,
			'simplevar' => 75,
			'objblock' => 26
		}
	},
	{#State 297
		DEFAULT => -44,
		GOTOS => {
			'stmtseq' => 305
		}
	},
	{#State 298
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			'STR' => 37,
			'NOTOP' => 56,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 65,
			'array' => 31,
			'varexpr' => 43,
			'expr' => 306,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 299
		DEFAULT => -28,
		GOTOS => {
			'@27-7' => 307
		}
	},
	{#State 300
		DEFAULT => -26
	},
	{#State 301
		DEFAULT => -44,
		GOTOS => {
			'stmtseq' => 308
		}
	},
	{#State 302
		ACTIONS => {
			";" => 310,
			"{" => 309
		}
	},
	{#State 303
		ACTIONS => {
			"%{" => 6,
			'WORD' => 46,
			"}" => 311,
			'PACKAGE' => 47,
			"\@" => 10,
			'PERL' => 8,
			'MY' => 50,
			"%" => 12,
			"\$^" => 51,
			'UNLESS' => 13,
			'NUM' => 52,
			'STEP' => 15,
			'IF' => 53,
			"\$" => 54,
			'loopword' => 16,
			'FOREACH' => 18,
			'ACROSS' => 231,
			'NOTOP' => 56,
			'FINAL' => 23,
			"(" => 60,
			'VAR' => 61,
			'INCOP' => 25,
			'NOT2' => 62,
			'FOR' => 29,
			'ADDOP' => 30,
			'FUNC' => 64,
			'RETURN' => 68,
			'INIT' => 69,
			'STR' => 37,
			'CALC' => 70,
			"{" => 39,
			'CONST' => 40,
			'YADAYADA' => 72
		},
		GOTOS => {
			'scalar' => 91,
			'sideff' => 28,
			'objname' => 11,
			'term' => 65,
			'loop' => 14,
			'array' => 31,
			'expr' => 66,
			'phase' => 33,
			'termbinop' => 55,
			'set' => 36,
			'termunop' => 19,
			'line' => 232,
			'cond' => 22,
			'dynvar' => 58,
			'phaseblock' => 233,
			'perlblock' => 234,
			'condword' => 71,
			'funcall' => 38,
			'across' => 235,
			'package' => 42,
			'varexpr' => 43,
			'block' => 236,
			'indexvar' => 74,
			'simplevar' => 75,
			'objblock' => 26
		}
	},
	{#State 304
		DEFAULT => -91
	},
	{#State 305
		ACTIONS => {
			"%{" => 6,
			'WORD' => 46,
			"}" => 312,
			'PACKAGE' => 47,
			"\@" => 10,
			'PERL' => 8,
			'MY' => 50,
			"%" => 12,
			"\$^" => 51,
			'UNLESS' => 13,
			'NUM' => 52,
			'STEP' => 15,
			'IF' => 53,
			"\$" => 54,
			'loopword' => 16,
			'FOREACH' => 18,
			'ACROSS' => 231,
			'NOTOP' => 56,
			'FINAL' => 23,
			"(" => 60,
			'VAR' => 61,
			'INCOP' => 25,
			'NOT2' => 62,
			'FOR' => 29,
			'ADDOP' => 30,
			'FUNC' => 64,
			'RETURN' => 68,
			'INIT' => 69,
			'STR' => 37,
			'CALC' => 70,
			"{" => 39,
			'CONST' => 40,
			'YADAYADA' => 72
		},
		GOTOS => {
			'scalar' => 91,
			'sideff' => 28,
			'objname' => 11,
			'term' => 65,
			'loop' => 14,
			'array' => 31,
			'expr' => 66,
			'phase' => 33,
			'termbinop' => 55,
			'set' => 36,
			'termunop' => 19,
			'line' => 232,
			'cond' => 22,
			'dynvar' => 58,
			'phaseblock' => 233,
			'perlblock' => 234,
			'condword' => 71,
			'funcall' => 38,
			'across' => 235,
			'package' => 42,
			'varexpr' => 43,
			'block' => 236,
			'indexvar' => 74,
			'simplevar' => 75,
			'objblock' => 26
		}
	},
	{#State 306
		ACTIONS => {
			'XOROP' => 137,
			'OROP' => 136,
			")" => 313,
			'ANDOP' => 134
		}
	},
	{#State 307
		DEFAULT => -44,
		GOTOS => {
			'stmtseq' => 314
		}
	},
	{#State 308
		ACTIONS => {
			"%{" => 6,
			'WORD' => 46,
			"}" => 315,
			'PACKAGE' => 47,
			"\@" => 10,
			'PERL' => 8,
			'MY' => 50,
			"%" => 12,
			"\$^" => 51,
			'UNLESS' => 13,
			'NUM' => 52,
			'STEP' => 15,
			'IF' => 53,
			"\$" => 54,
			'loopword' => 16,
			'FOREACH' => 18,
			'ACROSS' => 231,
			'NOTOP' => 56,
			'FINAL' => 23,
			"(" => 60,
			'VAR' => 61,
			'INCOP' => 25,
			'NOT2' => 62,
			'FOR' => 29,
			'ADDOP' => 30,
			'FUNC' => 64,
			'RETURN' => 68,
			'INIT' => 69,
			'STR' => 37,
			'CALC' => 70,
			"{" => 39,
			'CONST' => 40,
			'YADAYADA' => 72
		},
		GOTOS => {
			'scalar' => 91,
			'sideff' => 28,
			'objname' => 11,
			'term' => 65,
			'loop' => 14,
			'array' => 31,
			'expr' => 66,
			'phase' => 33,
			'termbinop' => 55,
			'set' => 36,
			'termunop' => 19,
			'line' => 232,
			'cond' => 22,
			'dynvar' => 58,
			'phaseblock' => 233,
			'perlblock' => 234,
			'condword' => 71,
			'funcall' => 38,
			'across' => 235,
			'package' => 42,
			'varexpr' => 43,
			'block' => 236,
			'indexvar' => 74,
			'simplevar' => 75,
			'objblock' => 26
		}
	},
	{#State 309
		DEFAULT => -31,
		GOTOS => {
			'@30-8' => 316
		}
	},
	{#State 310
		DEFAULT => -29
	},
	{#State 311
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
			'ELSE' => 317,
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
			'ELSIF' => 319,
			"{" => -86,
			'CONST' => -86,
			'USE' => -86,
			'YADAYADA' => -86
		},
		GOTOS => {
			'else' => 318
		}
	},
	{#State 312
		DEFAULT => -93
	},
	{#State 313
		ACTIONS => {
			"{" => 320
		}
	},
	{#State 314
		ACTIONS => {
			"%{" => 6,
			'WORD' => 46,
			"}" => 321,
			'PACKAGE' => 47,
			"\@" => 10,
			'PERL' => 8,
			'MY' => 50,
			"%" => 12,
			"\$^" => 51,
			'UNLESS' => 13,
			'NUM' => 52,
			'STEP' => 15,
			'IF' => 53,
			"\$" => 54,
			'loopword' => 16,
			'FOREACH' => 18,
			'ACROSS' => 231,
			'NOTOP' => 56,
			'FINAL' => 23,
			"(" => 60,
			'VAR' => 61,
			'INCOP' => 25,
			'NOT2' => 62,
			'FOR' => 29,
			'ADDOP' => 30,
			'FUNC' => 64,
			'RETURN' => 68,
			'INIT' => 69,
			'STR' => 37,
			'CALC' => 70,
			"{" => 39,
			'CONST' => 40,
			'YADAYADA' => 72
		},
		GOTOS => {
			'scalar' => 91,
			'sideff' => 28,
			'objname' => 11,
			'term' => 65,
			'loop' => 14,
			'array' => 31,
			'expr' => 66,
			'phase' => 33,
			'termbinop' => 55,
			'set' => 36,
			'termunop' => 19,
			'line' => 232,
			'cond' => 22,
			'dynvar' => 58,
			'phaseblock' => 233,
			'perlblock' => 234,
			'condword' => 71,
			'funcall' => 38,
			'across' => 235,
			'package' => 42,
			'varexpr' => 43,
			'block' => 236,
			'indexvar' => 74,
			'simplevar' => 75,
			'objblock' => 26
		}
	},
	{#State 315
		DEFAULT => -71
	},
	{#State 316
		ACTIONS => {
			'perlseq' => 322
		}
	},
	{#State 317
		ACTIONS => {
			"{" => 323
		}
	},
	{#State 318
		DEFAULT => -82
	},
	{#State 319
		ACTIONS => {
			"(" => 324
		}
	},
	{#State 320
		DEFAULT => -44,
		GOTOS => {
			'stmtseq' => 325
		}
	},
	{#State 321
		DEFAULT => -27
	},
	{#State 322
		ACTIONS => {
			"}" => 326
		}
	},
	{#State 323
		DEFAULT => -88,
		GOTOS => {
			'@87-2' => 327
		}
	},
	{#State 324
		DEFAULT => -90,
		GOTOS => {
			'@89-2' => 328
		}
	},
	{#State 325
		ACTIONS => {
			"%{" => 6,
			'WORD' => 46,
			"}" => 329,
			'PACKAGE' => 47,
			"\@" => 10,
			'PERL' => 8,
			'MY' => 50,
			"%" => 12,
			"\$^" => 51,
			'UNLESS' => 13,
			'NUM' => 52,
			'STEP' => 15,
			'IF' => 53,
			"\$" => 54,
			'loopword' => 16,
			'FOREACH' => 18,
			'ACROSS' => 231,
			'NOTOP' => 56,
			'FINAL' => 23,
			"(" => 60,
			'VAR' => 61,
			'INCOP' => 25,
			'NOT2' => 62,
			'FOR' => 29,
			'ADDOP' => 30,
			'FUNC' => 64,
			'RETURN' => 68,
			'INIT' => 69,
			'STR' => 37,
			'CALC' => 70,
			"{" => 39,
			'CONST' => 40,
			'YADAYADA' => 72
		},
		GOTOS => {
			'scalar' => 91,
			'sideff' => 28,
			'objname' => 11,
			'term' => 65,
			'loop' => 14,
			'array' => 31,
			'expr' => 66,
			'phase' => 33,
			'termbinop' => 55,
			'set' => 36,
			'termunop' => 19,
			'line' => 232,
			'cond' => 22,
			'dynvar' => 58,
			'phaseblock' => 233,
			'perlblock' => 234,
			'condword' => 71,
			'funcall' => 38,
			'across' => 235,
			'package' => 42,
			'varexpr' => 43,
			'block' => 236,
			'indexvar' => 74,
			'simplevar' => 75,
			'objblock' => 26
		}
	},
	{#State 326
		DEFAULT => -30
	},
	{#State 327
		DEFAULT => -44,
		GOTOS => {
			'stmtseq' => 330
		}
	},
	{#State 328
		ACTIONS => {
			'WORD' => 46,
			'NOT2' => 62,
			"\@" => 10,
			'ADDOP' => 30,
			'MY' => 50,
			"%" => 12,
			'FUNC' => 64,
			"\$^" => 51,
			'NUM' => 52,
			'RETURN' => 68,
			"\$" => 54,
			'STR' => 37,
			'NOTOP' => 56,
			"(" => 60,
			'YADAYADA' => 72,
			'INCOP' => 25
		},
		GOTOS => {
			'scalar' => 91,
			'dynvar' => 58,
			'objname' => 11,
			'funcall' => 38,
			'term' => 65,
			'array' => 31,
			'varexpr' => 43,
			'expr' => 331,
			'termbinop' => 55,
			'indexvar' => 74,
			'simplevar' => 75,
			'termunop' => 19,
			'objblock' => 26,
			'set' => 36
		}
	},
	{#State 329
		DEFAULT => -95
	},
	{#State 330
		ACTIONS => {
			"%{" => 6,
			'WORD' => 46,
			"}" => 332,
			'PACKAGE' => 47,
			"\@" => 10,
			'PERL' => 8,
			'MY' => 50,
			"%" => 12,
			"\$^" => 51,
			'UNLESS' => 13,
			'NUM' => 52,
			'STEP' => 15,
			'IF' => 53,
			"\$" => 54,
			'loopword' => 16,
			'FOREACH' => 18,
			'ACROSS' => 231,
			'NOTOP' => 56,
			'FINAL' => 23,
			"(" => 60,
			'VAR' => 61,
			'INCOP' => 25,
			'NOT2' => 62,
			'FOR' => 29,
			'ADDOP' => 30,
			'FUNC' => 64,
			'RETURN' => 68,
			'INIT' => 69,
			'STR' => 37,
			'CALC' => 70,
			"{" => 39,
			'CONST' => 40,
			'YADAYADA' => 72
		},
		GOTOS => {
			'scalar' => 91,
			'sideff' => 28,
			'objname' => 11,
			'term' => 65,
			'loop' => 14,
			'array' => 31,
			'expr' => 66,
			'phase' => 33,
			'termbinop' => 55,
			'set' => 36,
			'termunop' => 19,
			'line' => 232,
			'cond' => 22,
			'dynvar' => 58,
			'phaseblock' => 233,
			'perlblock' => 234,
			'condword' => 71,
			'funcall' => 38,
			'across' => 235,
			'package' => 42,
			'varexpr' => 43,
			'block' => 236,
			'indexvar' => 74,
			'simplevar' => 75,
			'objblock' => 26
		}
	},
	{#State 331
		ACTIONS => {
			'XOROP' => 137,
			'OROP' => 136,
			")" => 333,
			'ANDOP' => 134
		}
	},
	{#State 332
		DEFAULT => -87
	},
	{#State 333
		ACTIONS => {
			"{" => 334
		}
	},
	{#State 334
		DEFAULT => -44,
		GOTOS => {
			'stmtseq' => 335
		}
	},
	{#State 335
		ACTIONS => {
			"%{" => 6,
			'WORD' => 46,
			"}" => 336,
			'PACKAGE' => 47,
			"\@" => 10,
			'PERL' => 8,
			'MY' => 50,
			"%" => 12,
			"\$^" => 51,
			'UNLESS' => 13,
			'NUM' => 52,
			'STEP' => 15,
			'IF' => 53,
			"\$" => 54,
			'loopword' => 16,
			'FOREACH' => 18,
			'ACROSS' => 231,
			'NOTOP' => 56,
			'FINAL' => 23,
			"(" => 60,
			'VAR' => 61,
			'INCOP' => 25,
			'NOT2' => 62,
			'FOR' => 29,
			'ADDOP' => 30,
			'FUNC' => 64,
			'RETURN' => 68,
			'INIT' => 69,
			'STR' => 37,
			'CALC' => 70,
			"{" => 39,
			'CONST' => 40,
			'YADAYADA' => 72
		},
		GOTOS => {
			'scalar' => 91,
			'sideff' => 28,
			'objname' => 11,
			'term' => 65,
			'loop' => 14,
			'array' => 31,
			'expr' => 66,
			'phase' => 33,
			'termbinop' => 55,
			'set' => 36,
			'termunop' => 19,
			'line' => 232,
			'cond' => 22,
			'dynvar' => 58,
			'phaseblock' => 233,
			'perlblock' => 234,
			'condword' => 71,
			'funcall' => 38,
			'across' => 235,
			'package' => 42,
			'varexpr' => 43,
			'block' => 236,
			'indexvar' => 74,
			'simplevar' => 75,
			'objblock' => 26
		}
	},
	{#State 336
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
			'ELSE' => 317,
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
			'ELSIF' => 319,
			"{" => -86,
			'CONST' => -86,
			'USE' => -86,
			'YADAYADA' => -86
		},
		GOTOS => {
			'else' => 337
		}
	},
	{#State 337
		DEFAULT => -89
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 6105 Parser.pm
	],
	[#Rule program_1
		 'program', 2,
sub {
#line 34 "Parser.eyp"
 $_[0]->new_dnode('PROGRAM', $_[2]) }
#line 6112 Parser.pm
	],
	[#Rule progseq_2
		 'progseq', 0,
sub {
#line 38 "Parser.eyp"
 $_[0]->new_node('PROGSEQ') }
#line 6119 Parser.pm
	],
	[#Rule progseq_3
		 'progseq', 2,
sub {
#line 41 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 6126 Parser.pm
	],
	[#Rule progseq_4
		 'progseq', 2,
sub {
#line 44 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 6133 Parser.pm
	],
	[#Rule progseq_5
		 'progseq', 2,
sub {
#line 47 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 6140 Parser.pm
	],
	[#Rule progseq_6
		 'progseq', 2,
sub {
#line 50 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 6147 Parser.pm
	],
	[#Rule progseq_7
		 'progseq', 2,
sub {
#line 53 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 6154 Parser.pm
	],
	[#Rule progseq_8
		 'progseq', 2,
sub {
#line 56 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 6161 Parser.pm
	],
	[#Rule progseq_9
		 'progseq', 2,
sub {
#line 59 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 6168 Parser.pm
	],
	[#Rule progstart_10
		 'progstart', 0, undef
#line 6172 Parser.pm
	],
	[#Rule tl_decl_11
		 'tl_decl', 1,
sub {
#line 66 "Parser.eyp"
 $_[1] }
#line 6179 Parser.pm
	],
	[#Rule tl_decl_12
		 'tl_decl', 1,
sub {
#line 69 "Parser.eyp"
 $_[1] }
#line 6186 Parser.pm
	],
	[#Rule tl_decl_13
		 'tl_decl', 1,
sub {
#line 72 "Parser.eyp"
 $_[1] }
#line 6193 Parser.pm
	],
	[#Rule tl_decl_14
		 'tl_decl', 1,
sub {
#line 75 "Parser.eyp"
 $_[1] }
#line 6200 Parser.pm
	],
	[#Rule tl_decl_15
		 'tl_decl', 1,
sub {
#line 78 "Parser.eyp"
 $_[1] }
#line 6207 Parser.pm
	],
	[#Rule tl_decl_16
		 'tl_decl', 1,
sub {
#line 81 "Parser.eyp"
 $_[1] }
#line 6214 Parser.pm
	],
	[#Rule vardecl_17
		 'vardecl', 2,
sub {
#line 85 "Parser.eyp"
my $u = $_[2]; my $v = $_[1];  merge_units($v, $u) }
#line 6221 Parser.pm
	],
	[#Rule vardecl_18
		 'vardecl', 3,
sub {
#line 88 "Parser.eyp"
my $u = $_[3]; my $d = $_[2]; my $v = $_[1];  merge_units(add_child($v, $d), $u) }
#line 6228 Parser.pm
	],
	[#Rule package_19
		 'package', 3,
sub {
#line 92 "Parser.eyp"
my $w = $_[2];  $_[0]->set_package($w); $_[0]->new_anode('DUMMY', "package $w"); }
#line 6235 Parser.pm
	],
	[#Rule include_20
		 'include', 3,
sub {
#line 96 "Parser.eyp"
my $w = $_[2];  $_[0]->parse_input($w . ".mad"); $_[0]->new_anode('DUMMY', "include $w"); }
#line 6242 Parser.pm
	],
	[#Rule include_21
		 'include', 3,
sub {
#line 99 "Parser.eyp"
my $w = $_[2];  $_[0]->parse_input($w); $_[0]->new_anode('DUMMY', "include $w"); }
#line 6249 Parser.pm
	],
	[#Rule use_22
		 'use', 3,
sub {
#line 103 "Parser.eyp"
my $w = $_[2];  $_[0]->use_perl($w . ".pm"); $_[0]->new_anode('DUMMY', "use $w"); }
#line 6256 Parser.pm
	],
	[#Rule unit_23
		 'unit', 3,
sub {
#line 107 "Parser.eyp"
my $w = $_[2];  declare_units($_[0], $w); $_[0]->new_node('UNIT', @{$w->{children}}); }
#line 6263 Parser.pm
	],
	[#Rule wordlist_24
		 'wordlist', 1,
sub {
#line 111 "Parser.eyp"
my $w = $_[1];  $_[0]->new_node('LIST', $_[0]->new_anode('STRING', $w)) }
#line 6270 Parser.pm
	],
	[#Rule wordlist_25
		 'wordlist', 3,
sub {
#line 114 "Parser.eyp"
my $w = $_[3]; my $l = $_[1];  add_child($l, $_[0]->new_anode('STRING', $w)) }
#line 6277 Parser.pm
	],
	[#Rule function_26
		 'function', 7,
sub {
#line 118 "Parser.eyp"
my $u = $_[6]; my $p = $_[4]; my $name = $_[2]; 
			    $_[0]->declare_function($name, $p, 'MAD_FUNC');
			    merge_units($_[0]->new_anode('FUNDECL', $name, $p), $u);
			}
#line 6287 Parser.pm
	],
	[#Rule function_27
		 'function', 10,
sub {
#line 130 "Parser.eyp"
my $u = $_[6]; my $p = $_[4]; my $q = $_[9]; my $name = $_[2]; 
			    $_[0]->pop_frame('FUNDECL');
			    merge_units($_[0]->new_anode('FUNDECL', $name, $p, $q), $u);
			}
#line 6297 Parser.pm
	],
	[#Rule _CODE
		 '@27-7', 0,
sub {
#line 124 "Parser.eyp"
my $u = $_[6]; my $p = $_[4]; my $name = $_[2]; 
			    $_[0]->declare_function($name, $p, 'MAD_FUNC');
			    $_[0]->push_frame(tag => 'FUNDECL', name => $name,
					      params => $p, units => $u);
			}
#line 6308 Parser.pm
	],
	[#Rule function_29
		 'function', 8,
sub {
#line 136 "Parser.eyp"
my $u = $_[7]; my $p = $_[5]; my $name = $_[3]; 
			    $_[0]->declare_function($name, $p, 'PERL_FUNC');
			    merge_units($_[0]->new_anode('PERLFUNDECL', $name, $p), $u);
			}
#line 6318 Parser.pm
	],
	[#Rule function_30
		 'function', 11,
sub {
#line 148 "Parser.eyp"
my $u = $_[7]; my $p = $_[5]; my $q = $_[10]; my $name = $_[3]; 
			    $_[0]->pop_frame('PERLFUNDECL');
			    merge_units($_[0]->new_anode('PERLFUNDECL', $name, $p, $q), $u);
			}
#line 6328 Parser.pm
	],
	[#Rule _CODE
		 '@30-8', 0,
sub {
#line 142 "Parser.eyp"
my $u = $_[7]; my $p = $_[5]; my $name = $_[3]; 
			    $_[0]->declare_function($name, $p, 'PERL_FUNC');
			    $_[0]->push_frame(tag => 'PERLFUNDECL', name => $name,
					      params => $p, units => $u);
			}
#line 6339 Parser.pm
	],
	[#Rule params_32
		 'params', 0,
sub {
#line 155 "Parser.eyp"
 $_[0]->new_node('PARAMS'); }
#line 6346 Parser.pm
	],
	[#Rule params_33
		 'params', 1,
sub {
#line 158 "Parser.eyp"
 $_[2]; }
#line 6353 Parser.pm
	],
	[#Rule paramlist_34
		 'paramlist', 1,
sub {
#line 162 "Parser.eyp"
my $p = $_[1]; 
			    $_[0]->new_node('PARAMS', $p);
			}
#line 6362 Parser.pm
	],
	[#Rule paramlist_35
		 'paramlist', 3,
sub {
#line 167 "Parser.eyp"
my $l = $_[1]; my $p = $_[3]; 
			    $_[0]->add_child($l, $p);
			}
#line 6371 Parser.pm
	],
	[#Rule param_36
		 'param', 1,
sub {
#line 173 "Parser.eyp"
 $_[1] }
#line 6378 Parser.pm
	],
	[#Rule unitopt_37
		 'unitopt', 0, undef
#line 6382 Parser.pm
	],
	[#Rule unitopt_38
		 'unitopt', 1,
sub {
#line 179 "Parser.eyp"
 $_[1] }
#line 6389 Parser.pm
	],
	[#Rule unitspec_39
		 'unitspec', 3,
sub {
#line 183 "Parser.eyp"
my $ulist = $_[2];  merge_units($_[0]->new_node('UNITSPEC'), $ulist, 1) }
#line 6396 Parser.pm
	],
	[#Rule unitlist_40
		 'unitlist', 0,
sub {
#line 187 "Parser.eyp"
 $_[0]->new_node('UNITLIST') }
#line 6403 Parser.pm
	],
	[#Rule unitlist_41
		 'unitlist', 2,
sub {
#line 190 "Parser.eyp"

			    my (@u) = $_[0]->validate_unit($_[2]);
			    if ( $u[0] eq 'ERROR' ) {
				$_[0]->YYError();
			    }
			    else {
				add_units($_[1], @u);
			    }
			}
#line 6418 Parser.pm
	],
	[#Rule tl_across_42
		 'tl_across', 6,
sub {
#line 207 "Parser.eyp"
my $q = $_[5]; my $dl = $_[2]; 
			    $_[0]->pop_frame('ACROSS');
			    $_[0]->new_node('ACROSS', $dl, @{$q->{children}});
			}
#line 6428 Parser.pm
	],
	[#Rule _CODE
		 '@42-3', 0,
sub {
#line 202 "Parser.eyp"
my $dl = $_[2]; 
			    $_[0]->push_frame(tag => 'ACROSS', 
					      dimlist => $dl->{children});
			}
#line 6438 Parser.pm
	],
	[#Rule stmtseq_44
		 'stmtseq', 0,
sub {
#line 214 "Parser.eyp"
 $_[0]->new_node('STMTSEQ') }
#line 6445 Parser.pm
	],
	[#Rule stmtseq_45
		 'stmtseq', 2,
sub {
#line 217 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 6452 Parser.pm
	],
	[#Rule stmtseq_46
		 'stmtseq', 2,
sub {
#line 220 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 6459 Parser.pm
	],
	[#Rule stmtseq_47
		 'stmtseq', 2,
sub {
#line 223 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 6466 Parser.pm
	],
	[#Rule stmtseq_48
		 'stmtseq', 2,
sub {
#line 226 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 6473 Parser.pm
	],
	[#Rule stmtseq_49
		 'stmtseq', 2,
sub {
#line 229 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 6480 Parser.pm
	],
	[#Rule block_50
		 'block', 4,
sub {
#line 237 "Parser.eyp"

			    $_[0]->pop_frame('BLOCK');
			    $_[0]->new_dnode('BLOCK', $_[2]);
			}
#line 6490 Parser.pm
	],
	[#Rule _CODE
		 '@50-1', 0,
sub {
#line 233 "Parser.eyp"
 
			    $_[0]->push_frame(tag => 'BLOCK'); 
			}
#line 6499 Parser.pm
	],
	[#Rule perlblock_52
		 'perlblock', 5,
sub {
#line 249 "Parser.eyp"
my $q = $_[4]; 
			    $_[0]->pop_frame('PERLBLOCK');
			    $_[0]->new_node('PERLBLOCK', @{$q->{children}});
			}
#line 6509 Parser.pm
	],
	[#Rule _CODE
		 '@52-2', 0,
sub {
#line 244 "Parser.eyp"

			    $_[0]->lex_mode('perl');
			    $_[0]->push_frame(tag => 'PERLBLOCK');
			}
#line 6519 Parser.pm
	],
	[#Rule perlblock_54
		 'perlblock', 4,
sub {
#line 260 "Parser.eyp"
my $q = $_[3]; 
			    $_[0]->pop_frame('PERLBLOCK');
			    $_[0]->new_node('PERLBLOCK', @{$q->{children}});
			}
#line 6529 Parser.pm
	],
	[#Rule _CODE
		 '@54-1', 0,
sub {
#line 255 "Parser.eyp"

			    $_[0]->lex_mode('pperl');
			    $_[0]->push_frame(tag => 'PERLBLOCK');
			}
#line 6539 Parser.pm
	],
	[#Rule phaseblock_56
		 'phaseblock', 5,
sub {
#line 271 "Parser.eyp"
my $p = $_[1]; my $q = $_[4]; 
			    $_[0]->pop_frame('BLOCK');
			    $_[0]->new_node($p, @{$q->{children}});
			}
#line 6549 Parser.pm
	],
	[#Rule _CODE
		 '@56-2', 0,
sub {
#line 267 "Parser.eyp"
my $p = $_[1]; 
			    $_[0]->push_frame(tag => 'BLOCK', phase => $p);
			}
#line 6558 Parser.pm
	],
	[#Rule phase_58
		 'phase', 1, undef
#line 6562 Parser.pm
	],
	[#Rule phase_59
		 'phase', 1, undef
#line 6566 Parser.pm
	],
	[#Rule phase_60
		 'phase', 1, undef
#line 6570 Parser.pm
	],
	[#Rule phase_61
		 'phase', 1, undef
#line 6574 Parser.pm
	],
	[#Rule line_62
		 'line', 4,
sub {
#line 291 "Parser.eyp"
my $e = $_[3]; my $p = $_[1]; 
			    $_[0]->pop_frame('line');
			    $_[0]->new_node($p, $e);
			}
#line 6584 Parser.pm
	],
	[#Rule _CODE
		 '@62-1', 0,
sub {
#line 287 "Parser.eyp"
my $p = $_[1]; 
			    $_[0]->push_frame(tag => 'line', phase => $p);
			}
#line 6593 Parser.pm
	],
	[#Rule line_64
		 'line', 1,
sub {
#line 297 "Parser.eyp"
 $_[1] }
#line 6600 Parser.pm
	],
	[#Rule line_65
		 'line', 1,
sub {
#line 300 "Parser.eyp"
 $_[1]; }
#line 6607 Parser.pm
	],
	[#Rule line_66
		 'line', 1,
sub {
#line 303 "Parser.eyp"
 $_[1]; }
#line 6614 Parser.pm
	],
	[#Rule line_67
		 'line', 2,
sub {
#line 306 "Parser.eyp"
my $e = $_[1];  $e; }
#line 6621 Parser.pm
	],
	[#Rule line_68
		 'line', 3,
sub {
#line 309 "Parser.eyp"
my $v = $_[2]; 
			    $_[0]->see_var($v, PLAIN_VAR);
			}
#line 6630 Parser.pm
	],
	[#Rule line_69
		 'line', 6,
sub {
#line 319 "Parser.eyp"
my $e = $_[5]; my $v = $_[2]; 
			    $_[0]->pop_frame('CONST');
			    $_[0]->new_anode('ASSIGN', '=', $v, $e);
			}
#line 6640 Parser.pm
	],
	[#Rule _CODE
		 '@69-3', 0,
sub {
#line 314 "Parser.eyp"
my $v = $_[2]; 
			    $_[0]->see_var($v, CONST_VAR);
			    $_[0]->push_frame(tag => 'CONST', phase => INIT_PHASE);
			}
#line 6650 Parser.pm
	],
	[#Rule across_71
		 'across', 6,
sub {
#line 331 "Parser.eyp"
my $q = $_[5]; my $dl = $_[2]; 
			    $_[0]->pop_frame('ACROSS');
			    $_[0]->new_child('ACROSS', $dl, @{$q->{children}});
			}
#line 6660 Parser.pm
	],
	[#Rule _CODE
		 '@71-3', 0,
sub {
#line 326 "Parser.eyp"
my $dl = $_[2]; 
			    $_[0]->push_frame(tag => 'ACROSS', 
					      dimlist => $dl->{children});
			}
#line 6670 Parser.pm
	],
	[#Rule dimlist_73
		 'dimlist', 1,
sub {
#line 338 "Parser.eyp"
my $d = $_[1];  $_[0]->new_node('DIMLIST', $d); }
#line 6677 Parser.pm
	],
	[#Rule dimlist_74
		 'dimlist', 2,
sub {
#line 341 "Parser.eyp"
my $l = $_[1]; my $d = $_[2];  add_child($l, $d); }
#line 6684 Parser.pm
	],
	[#Rule dimspec_75
		 'dimspec', 4,
sub {
#line 345 "Parser.eyp"
my $l = $_[2]; my $d = $_[3];  add_child($d, $l); }
#line 6691 Parser.pm
	],
	[#Rule dimspec_76
		 'dimspec', 4,
sub {
#line 348 "Parser.eyp"
my $l = $_[2]; my $d = $_[3];  add_child($d, $l); }
#line 6698 Parser.pm
	],
	[#Rule label_77
		 'label', 0, undef
#line 6702 Parser.pm
	],
	[#Rule label_78
		 'label', 2,
sub {
#line 353 "Parser.eyp"
my $w = $_[1];  $_[0]->new_anode('LABEL', $w); }
#line 6709 Parser.pm
	],
	[#Rule sideff_79
		 'sideff', 1,
sub {
#line 357 "Parser.eyp"
 $_[1] }
#line 6716 Parser.pm
	],
	[#Rule sideff_80
		 'sideff', 3,
sub {
#line 360 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('AND', $r, $l) }
#line 6723 Parser.pm
	],
	[#Rule sideff_81
		 'sideff', 3,
sub {
#line 363 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('OR', $r, $l) }
#line 6730 Parser.pm
	],
	[#Rule cond_82
		 'cond', 9,
sub {
#line 369 "Parser.eyp"
my $e = $_[4]; my $c = $_[1]; my $q = $_[7]; my $x = $_[9];  
			    $_[0]->pop_frame($c);
			    $_[0]->new_node($c, $e, $q, $x);
			}
#line 6740 Parser.pm
	],
	[#Rule _CODE
		 '@82-2', 0,
sub {
#line 367 "Parser.eyp"
my $c = $_[1];  $_[0]->push_frame(tag => $c); }
#line 6747 Parser.pm
	],
	[#Rule condword_84
		 'condword', 1,
sub {
#line 376 "Parser.eyp"
 'IF' }
#line 6754 Parser.pm
	],
	[#Rule condword_85
		 'condword', 1,
sub {
#line 378 "Parser.eyp"
 'UNLESS' }
#line 6761 Parser.pm
	],
	[#Rule else_86
		 'else', 0, undef
#line 6765 Parser.pm
	],
	[#Rule else_87
		 'else', 5,
sub {
#line 388 "Parser.eyp"
my $q = $_[4];  
			    $_[0]->pop_frame('ELSE');
			    $_[0]->new_node('ELSE', $q);
			}
#line 6775 Parser.pm
	],
	[#Rule _CODE
		 '@87-2', 0,
sub {
#line 384 "Parser.eyp"

			    $_[0]->push_frame(tag => 'ELSE');
			}
#line 6784 Parser.pm
	],
	[#Rule else_89
		 'else', 9,
sub {
#line 396 "Parser.eyp"
my $e = $_[4]; my $q = $_[7]; my $x = $_[9]; 
			    $_[0]->pop_frame('ELSIF');
			    $_[0]->new_node('ELSIF', $e, $q, $x);
			}
#line 6794 Parser.pm
	],
	[#Rule _CODE
		 '@89-2', 0,
sub {
#line 394 "Parser.eyp"
 $_[0]->push_frame(tag => 'ELSIF'); }
#line 6801 Parser.pm
	],
	[#Rule loop_91
		 'loop', 8,
sub {
#line 407 "Parser.eyp"
my $e = $_[4]; my $c = $_[1]; my $q = $_[7]; 
			    $_[0]->pop_frame($c);
			    $_[0]->new_node($c, $e, $q);
			}
#line 6811 Parser.pm
	],
	[#Rule _CODE
		 '@91-2', 0,
sub {
#line 403 "Parser.eyp"
my $c = $_[1]; 
			    $_[0]->push_frame(tag => $c);
			}
#line 6820 Parser.pm
	],
	[#Rule loop_93
		 'loop', 9,
sub {
#line 417 "Parser.eyp"
my $e = $_[5]; my $q = $_[8]; my $i = $_[3]; 
			    $_[0]->see_var($i, ASSIGN_VAR);
			    $_[0]->pop_frame('FOREACH');
			    $_[0]->new_node('FOREACH', $i, $e, $q);
			}
#line 6831 Parser.pm
	],
	[#Rule _CODE
		 '@93-1', 0,
sub {
#line 413 "Parser.eyp"

			    $_[0]->push_frame(tag => 'FOREACH');
			}
#line 6840 Parser.pm
	],
	[#Rule loop_95
		 'loop', 12,
sub {
#line 428 "Parser.eyp"
my $e2 = $_[6]; my $e1 = $_[4]; my $q = $_[11]; my $e3 = $_[8]; 
			    $_[0]->pop_frame('FOR');
			    $_[0]->new_node('FOR', $e1, $e2, $e3, $q);
			}
#line 6850 Parser.pm
	],
	[#Rule _CODE
		 '@95-2', 0,
sub {
#line 424 "Parser.eyp"

			    $_[0]->push_frame('FOR');
			}
#line 6859 Parser.pm
	],
	[#Rule argexpr_97
		 'argexpr', 0,
sub {
#line 435 "Parser.eyp"
 $_[0]->new_node('NULLARGS'); }
#line 6866 Parser.pm
	],
	[#Rule argexpr_98
		 'argexpr', 1,
sub {
#line 438 "Parser.eyp"
 $_[1]; }
#line 6873 Parser.pm
	],
	[#Rule arglist_99
		 'arglist', 1,
sub {
#line 442 "Parser.eyp"
my $t = $_[1];  $_[0]->new_node('ARGS', $t); }
#line 6880 Parser.pm
	],
	[#Rule arglist_100
		 'arglist', 3,
sub {
#line 445 "Parser.eyp"
my $a = $_[1]; my $t = $_[3];  add_child($a, $t); }
#line 6887 Parser.pm
	],
	[#Rule expr_101
		 'expr', 3,
sub {
#line 449 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('AND', $l, $r) }
#line 6894 Parser.pm
	],
	[#Rule expr_102
		 'expr', 3,
sub {
#line 452 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('OR', $l, $r) }
#line 6901 Parser.pm
	],
	[#Rule expr_103
		 'expr', 3,
sub {
#line 455 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('XOR', $l, $r) }
#line 6908 Parser.pm
	],
	[#Rule expr_104
		 'expr', 2,
sub {
#line 458 "Parser.eyp"
my $e = $_[2];  $_[0]->new_node('NOT', $e) }
#line 6915 Parser.pm
	],
	[#Rule expr_105
		 'expr', 1,
sub {
#line 461 "Parser.eyp"
 $_[1] }
#line 6922 Parser.pm
	],
	[#Rule term_106
		 'term', 1,
sub {
#line 465 "Parser.eyp"
 $_[1] }
#line 6929 Parser.pm
	],
	[#Rule term_107
		 'term', 1,
sub {
#line 468 "Parser.eyp"
 $_[1] }
#line 6936 Parser.pm
	],
	[#Rule term_108
		 'term', 5,
sub {
#line 471 "Parser.eyp"
my $c = $_[5]; my $a = $_[1]; my $b = $_[3];  $_[0]->new_node('TRI', $a, $b, $c) }
#line 6943 Parser.pm
	],
	[#Rule term_109
		 'term', 3,
sub {
#line 474 "Parser.eyp"
 $_[2] }
#line 6950 Parser.pm
	],
	[#Rule term_110
		 'term', 1,
sub {
#line 477 "Parser.eyp"
 $_[1] }
#line 6957 Parser.pm
	],
	[#Rule term_111
		 'term', 1,
sub {
#line 480 "Parser.eyp"
 $_[1] }
#line 6964 Parser.pm
	],
	[#Rule term_112
		 'term', 1,
sub {
#line 483 "Parser.eyp"
 $_[1] }
#line 6971 Parser.pm
	],
	[#Rule term_113
		 'term', 1,
sub {
#line 486 "Parser.eyp"
 $_[0]->new_anode('NUM', $_[1]) }
#line 6978 Parser.pm
	],
	[#Rule term_114
		 'term', 1,
sub {
#line 489 "Parser.eyp"
 $_[0]->new_anode('STR', $_[1]) }
#line 6985 Parser.pm
	],
	[#Rule term_115
		 'term', 1,
sub {
#line 492 "Parser.eyp"
 $_[1] }
#line 6992 Parser.pm
	],
	[#Rule term_116
		 'term', 1,
sub {
#line 496 "Parser.eyp"
 $_[1] }
#line 6999 Parser.pm
	],
	[#Rule term_117
		 'term', 1,
sub {
#line 499 "Parser.eyp"
 $_[1] }
#line 7006 Parser.pm
	],
	[#Rule term_118
		 'term', 2,
sub {
#line 502 "Parser.eyp"
my $e = $_[2];  $_[0]->new_node('RETURN', $e) }
#line 7013 Parser.pm
	],
	[#Rule term_119
		 'term', 2,
sub {
#line 505 "Parser.eyp"
my $u = $_[2]; my $t = $_[1];  merge_units($t, $u) }
#line 7020 Parser.pm
	],
	[#Rule term_120
		 'term', 1,
sub {
#line 508 "Parser.eyp"
 $_[0]->new_node('YADAYADA'); }
#line 7027 Parser.pm
	],
	[#Rule termbinop_121
		 'termbinop', 3,
sub {
#line 512 "Parser.eyp"
my $l = $_[1]; my $r = $_[3]; my $op = $_[2]; 
			    $_[0]->see_var($l, ASSIGN_VAR);
			    $_[0]->new_anode('ASSIGN', $op, $l, $r);
			}
#line 7037 Parser.pm
	],
	[#Rule termbinop_122
		 'termbinop', 3,
sub {
#line 518 "Parser.eyp"
my $l = $_[1]; my $r = $_[3]; 
			    $_[0]->see_var($l, ASSIGN_VAR);
			    $_[0]->new_anode('ASSIGN', '=', $l, $r);
			}
#line 7047 Parser.pm
	],
	[#Rule termbinop_123
		 'termbinop', 3,
sub {
#line 524 "Parser.eyp"
my $l = $_[1]; my $r = $_[3]; my $op = $_[2];  $_[0]->new_anode('ADDOP', $op, $l, $r); }
#line 7054 Parser.pm
	],
	[#Rule termbinop_124
		 'termbinop', 3,
sub {
#line 527 "Parser.eyp"
my $l = $_[1]; my $r = $_[3]; my $op = $_[2];  $_[0]->new_anode('MULOP', $op, $l, $r); }
#line 7061 Parser.pm
	],
	[#Rule termbinop_125
		 'termbinop', 3,
sub {
#line 530 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_anode('MULOP', '%', $l, $r); }
#line 7068 Parser.pm
	],
	[#Rule termbinop_126
		 'termbinop', 3,
sub {
#line 533 "Parser.eyp"
my $l = $_[1]; my $r = $_[3]; my $op = $_[2];  $_[0]->new_anode('POWOP', $op, $l, $r); }
#line 7075 Parser.pm
	],
	[#Rule termbinop_127
		 'termbinop', 3,
sub {
#line 536 "Parser.eyp"
my $l = $_[1]; my $r = $_[3]; my $op = $_[2];  $_[0]->new_anode('RELOP', $op, $l, $r); }
#line 7082 Parser.pm
	],
	[#Rule termbinop_128
		 'termbinop', 3,
sub {
#line 539 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('DOTDOT', $l, $r); }
#line 7089 Parser.pm
	],
	[#Rule termbinop_129
		 'termbinop', 3,
sub {
#line 542 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('AND', $l, $r); }
#line 7096 Parser.pm
	],
	[#Rule termbinop_130
		 'termbinop', 3,
sub {
#line 545 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('OR', $l, $r); }
#line 7103 Parser.pm
	],
	[#Rule termbinop_131
		 'termbinop', 3,
sub {
#line 548 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('DOR', $l, $r); }
#line 7110 Parser.pm
	],
	[#Rule termunop_132
		 'termunop', 2,
sub {
#line 554 "Parser.eyp"
my $t = $_[2]; my $op = $_[1];  $op eq '-' ? $_[0]->new_node('UMINUS', $t) : $t }
#line 7117 Parser.pm
	],
	[#Rule termunop_133
		 'termunop', 2,
sub {
#line 557 "Parser.eyp"
my $t = $_[2];  $_[0]->new_node('NOT', $t) }
#line 7124 Parser.pm
	],
	[#Rule termunop_134
		 'termunop', 2,
sub {
#line 560 "Parser.eyp"
 $_[1]->{incr} = 'POST'; $_[1] }
#line 7131 Parser.pm
	],
	[#Rule termunop_135
		 'termunop', 2,
sub {
#line 563 "Parser.eyp"
 $_[2]->{incr} = 'PRE'; $_[2] }
#line 7138 Parser.pm
	],
	[#Rule varexpr_136
		 'varexpr', 1,
sub {
#line 567 "Parser.eyp"
my $v = $_[1]; 
			    $_[0]->see_var($v, PLAIN_VAR);
			}
#line 7147 Parser.pm
	],
	[#Rule varexpr_137
		 'varexpr', 2,
sub {
#line 572 "Parser.eyp"
my $d = $_[2]; my $v = $_[1]; 
			    add_child($v, $d);
			    $_[0]->see_var($v, PLAIN_VAR);
			}
#line 7157 Parser.pm
	],
	[#Rule varexpr_138
		 'varexpr', 3,
sub {
#line 578 "Parser.eyp"
my $v = $_[1]; my $f = $_[3]; 
			    $_[0]->see_var($v, PLAIN_VAR);
			    $_[0]->new_anode('DOTFLD', $f, $v);
			}
#line 7167 Parser.pm
	],
	[#Rule varexpr_139
		 'varexpr', 6,
sub {
#line 584 "Parser.eyp"
my $a = $_[5]; my $m = $_[3]; my $v = $_[1]; 
			    $_[0]->see_var($v, PLAIN_VAR);
			    $_[0]->new_anode('METHOD', $m, $v, $a);
			}
#line 7177 Parser.pm
	],
	[#Rule dynvar_140
		 'dynvar', 2,
sub {
#line 591 "Parser.eyp"
my $v = $_[2]; 
			    $_[0]->see_var($v, DYN_VAR);
			}
#line 7186 Parser.pm
	],
	[#Rule simplevar_141
		 'simplevar', 1,
sub {
#line 597 "Parser.eyp"
 $_[1] }
#line 7193 Parser.pm
	],
	[#Rule simplevar_142
		 'simplevar', 1,
sub {
#line 600 "Parser.eyp"
 $_[1] }
#line 7200 Parser.pm
	],
	[#Rule simplevar_143
		 'simplevar', 1,
sub {
#line 603 "Parser.eyp"
 $_[1] }
#line 7207 Parser.pm
	],
	[#Rule scalarvar_144
		 'scalarvar', 1,
sub {
#line 607 "Parser.eyp"
my $v = $_[1];  $_[0]->see_var($v, PLAIN_VAR); }
#line 7214 Parser.pm
	],
	[#Rule scalarvar_145
		 'scalarvar', 2,
sub {
#line 610 "Parser.eyp"
my $v = $_[2];  $_[0]->see_var($v, DYN_VAR); }
#line 7221 Parser.pm
	],
	[#Rule scalar_146
		 'scalar', 2,
sub {
#line 614 "Parser.eyp"
 $_[0]->new_anode('SCALARV', $_[2]); }
#line 7228 Parser.pm
	],
	[#Rule array_147
		 'array', 2,
sub {
#line 618 "Parser.eyp"
 $_[0]->new_anode('ARRAYV', $_[2]); }
#line 7235 Parser.pm
	],
	[#Rule set_148
		 'set', 2,
sub {
#line 622 "Parser.eyp"
 $_[0]->new_anode('SETV', $_[2]); }
#line 7242 Parser.pm
	],
	[#Rule indexvar_149
		 'indexvar', 1,
sub {
#line 626 "Parser.eyp"
 $_[0]->new_node('INDEXVAR'); }
#line 7249 Parser.pm
	],
	[#Rule indexvar_150
		 'indexvar', 2,
sub {
#line 629 "Parser.eyp"
my $n = $_[2];  $_[0]->new_anode('INDEXVAR', $n); }
#line 7256 Parser.pm
	],
	[#Rule indexvar_151
		 'indexvar', 2,
sub {
#line 632 "Parser.eyp"
my $w = $_[2];  $_[0]->new_anode('INDEXVAR', $w); }
#line 7263 Parser.pm
	],
	[#Rule subexpr_152
		 'subexpr', 1,
sub {
#line 636 "Parser.eyp"
my $d = $_[1];  $_[0]->new_node('SUBSCRIPT', $d); }
#line 7270 Parser.pm
	],
	[#Rule subexpr_153
		 'subexpr', 2,
sub {
#line 639 "Parser.eyp"
my $l = $_[1]; my $d = $_[2];  add_child($l, $d); }
#line 7277 Parser.pm
	],
	[#Rule subspec_154
		 'subspec', 2,
sub {
#line 643 "Parser.eyp"
 $_[0]->new_node('EMPTYDIM') }
#line 7284 Parser.pm
	],
	[#Rule subspec_155
		 'subspec', 3,
sub {
#line 646 "Parser.eyp"
 $_[2] }
#line 7291 Parser.pm
	],
	[#Rule funcall_156
		 'funcall', 4,
sub {
#line 650 "Parser.eyp"
my $a = $_[3]; my $fun = $_[1];  $_[0]->new_anode('FUNCALL', $fun, @{$a->{children}}) }
#line 7298 Parser.pm
	],
	[#Rule funcall_157
		 'funcall', 6,
sub {
#line 653 "Parser.eyp"
my $a = $_[3]; my $fld = $_[6]; my $fun = $_[1];  $_[0]->new_anode('DOTFLD', $fld,
				            $_[0]->new_node('FUNCALL', $fun, 
						   @{$a->{children}}) ) }
#line 7307 Parser.pm
	],
	[#Rule objname_158
		 'objname', 1,
sub {
#line 659 "Parser.eyp"
my $n = $_[1];  $_[0]->new_anode('NEWOBJ', $n) }
#line 7314 Parser.pm
	],
	[#Rule objblock_159
		 'objblock', 2,
sub {
#line 663 "Parser.eyp"
my $p = $_[2]; my $n = $_[1];  $_[0]->new_anode('NEWOBJ', $n, $p) }
#line 7321 Parser.pm
	],
	[#Rule pairblock_160
		 'pairblock', 3,
sub {
#line 667 "Parser.eyp"
 $_[0]->new_dnode('PAIRBLOCK', $_[2]) }
#line 7328 Parser.pm
	],
	[#Rule pairblock_161
		 'pairblock', 4,
sub {
#line 670 "Parser.eyp"
 $_[0]->new_dnode('PAIRBLOCK', $_[2]) }
#line 7335 Parser.pm
	],
	[#Rule pairlist_162
		 'pairlist', 1,
sub {
#line 674 "Parser.eyp"
my $p = $_[1];  $_[0]->new_node('LIST', $p) }
#line 7342 Parser.pm
	],
	[#Rule pairlist_163
		 'pairlist', 3,
sub {
#line 677 "Parser.eyp"
my $l = $_[1]; my $p = $_[3];  add_child($l, $p) }
#line 7349 Parser.pm
	],
	[#Rule pair_164
		 'pair', 3,
sub {
#line 681 "Parser.eyp"
my $left = $_[1]; my $right = $_[3];  $_[0]->new_anode('KEY', $left, $right) }
#line 7356 Parser.pm
	],
	[#Rule flow_165
		 'flow', 5,
sub {
#line 685 "Parser.eyp"
my $so = $_[1]; my $sn = $_[5]; my $coeff = $_[3]; my $op = $_[2]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->new_node('FLOW', $so, $sn, 
			                    $_[0]->new_anode('MULOP', $op, $so, $coeff));
			}
#line 7368 Parser.pm
	],
	[#Rule flow_166
		 'flow', 5,
sub {
#line 693 "Parser.eyp"
my $so = $_[5]; my $sn = $_[1]; my $coeff = $_[3]; my $op = $_[2]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->new_node('FLOW', $so, $sn, 
					    $_[0]->new_anode('MULOP', $op, $sn, $coeff));
			}
#line 7380 Parser.pm
	],
	[#Rule flow_167
		 'flow', 5,
sub {
#line 701 "Parser.eyp"
my $so = $_[1]; my $sn = $_[3]; my $coeff = $_[5]; my $op = $_[4]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->new_node('FLOW', $so, $sn,
					    $_[0]->new_anode('MULOP', $op, $sn, $coeff));
			}
#line 7392 Parser.pm
	],
	[#Rule flow_168
		 'flow', 5,
sub {
#line 709 "Parser.eyp"
my $so = $_[3]; my $sn = $_[1]; my $coeff = $_[5]; my $op = $_[4]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->new_node('FLOW', $so, $sn, 
					    $_[0]->new_anode('MULOP', $op, $so, $coeff));
			}
#line 7404 Parser.pm
	],
	[#Rule flow_169
		 'flow', 6,
sub {
#line 717 "Parser.eyp"
my $rate = $_[3]; my $so = $_[1]; my $sn = $_[6]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->new_node('FLOW', $so, $sn, $rate);
			}
#line 7415 Parser.pm
	],
	[#Rule flow_170
		 'flow', 6,
sub {
#line 724 "Parser.eyp"
my $so = $_[6]; my $rate = $_[3]; my $sn = $_[1]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->new_node('FLOW', $so, $sn, $rate);
			}
#line 7426 Parser.pm
	],
	[#Rule flow_171
		 'flow', 6,
sub {
#line 731 "Parser.eyp"
my $rate = $_[5]; my $so = $_[1]; my $sn = $_[3]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->new_node('FLOW', $so, $sn, $rate);
			}
#line 7437 Parser.pm
	],
	[#Rule flow_172
		 'flow', 6,
sub {
#line 738 "Parser.eyp"
my $rate = $_[5]; my $so = $_[3]; my $sn = $_[1]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->new_node('FLOW', $so, $sn, $rate);
			}
#line 7448 Parser.pm
	]
],
#line 7451 Parser.pm
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
         'tl_decl_15', 
         'tl_decl_16', 
         'vardecl_17', 
         'vardecl_18', 
         'package_19', 
         'include_20', 
         'include_21', 
         'use_22', 
         'unit_23', 
         'wordlist_24', 
         'wordlist_25', 
         'function_26', 
         'function_27', 
         '_CODE', 
         'function_29', 
         'function_30', 
         '_CODE', 
         'params_32', 
         'params_33', 
         'paramlist_34', 
         'paramlist_35', 
         'param_36', 
         'unitopt_37', 
         'unitopt_38', 
         'unitspec_39', 
         'unitlist_40', 
         'unitlist_41', 
         'tl_across_42', 
         '_CODE', 
         'stmtseq_44', 
         'stmtseq_45', 
         'stmtseq_46', 
         'stmtseq_47', 
         'stmtseq_48', 
         'stmtseq_49', 
         'block_50', 
         '_CODE', 
         'perlblock_52', 
         '_CODE', 
         'perlblock_54', 
         '_CODE', 
         'phaseblock_56', 
         '_CODE', 
         'phase_58', 
         'phase_59', 
         'phase_60', 
         'phase_61', 
         'line_62', 
         '_CODE', 
         'line_64', 
         'line_65', 
         'line_66', 
         'line_67', 
         'line_68', 
         'line_69', 
         '_CODE', 
         'across_71', 
         '_CODE', 
         'dimlist_73', 
         'dimlist_74', 
         'dimspec_75', 
         'dimspec_76', 
         'label_77', 
         'label_78', 
         'sideff_79', 
         'sideff_80', 
         'sideff_81', 
         'cond_82', 
         '_CODE', 
         'condword_84', 
         'condword_85', 
         'else_86', 
         'else_87', 
         '_CODE', 
         'else_89', 
         '_CODE', 
         'loop_91', 
         '_CODE', 
         'loop_93', 
         '_CODE', 
         'loop_95', 
         '_CODE', 
         'argexpr_97', 
         'argexpr_98', 
         'arglist_99', 
         'arglist_100', 
         'expr_101', 
         'expr_102', 
         'expr_103', 
         'expr_104', 
         'expr_105', 
         'term_106', 
         'term_107', 
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
         'termbinop_121', 
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
         'termunop_132', 
         'termunop_133', 
         'termunop_134', 
         'termunop_135', 
         'varexpr_136', 
         'varexpr_137', 
         'varexpr_138', 
         'varexpr_139', 
         'dynvar_140', 
         'simplevar_141', 
         'simplevar_142', 
         'simplevar_143', 
         'scalarvar_144', 
         'scalarvar_145', 
         'scalar_146', 
         'array_147', 
         'set_148', 
         'indexvar_149', 
         'indexvar_150', 
         'indexvar_151', 
         'subexpr_152', 
         'subexpr_153', 
         'subspec_154', 
         'subspec_155', 
         'funcall_156', 
         'funcall_157', 
         'objname_158', 
         'objblock_159', 
         'pairblock_160', 
         'pairblock_161', 
         'pairlist_162', 
         'pairlist_163', 
         'pair_164', 
         'flow_165', 
         'flow_166', 
         'flow_167', 
         'flow_168', 
         'flow_169', 
         'flow_170', 
         'flow_171', 
         'flow_172', );
  $self;
}

#line 745 "Parser.eyp"


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
    
    if ( $raw =~ m{^([/*]?)\s*([a-zA-Z0-9]+)(\^([0-9]+))?$} ) {
	$unit = $1 eq '/' ? "~$2" : $2;
	$count = $4 ne '' ? $4+0 : 1;
	return ($unit) x $count;
    }
    elsif ( $raw =~ m{^\*?\s*([a-zA-Z]+)\^-([0-9]+)$} ) {
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


#line 8108 Parser.pm



1;
