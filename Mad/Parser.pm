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

      m{\G(FLOWRIGHT|ASSIGNOP|loopword|FLOWLEFT|FUNCTION|YADAYADA|PERLPART|FOREACH|INCLUDE|PACKAGE|progseg|DORDOR|UNLESS|ACROSS|ANDAND|RETURN|DOTDOT|ANDOP|FINAL|RELOP|INCOP|ADDOP|MULOP|CONST|XOROP|POWOP|NOTOP|ELSIF|STEP|ELSE|OROP|UNIT|OROR|WORD|PERL|NOT2|FUNC|INIT|CALC|FOR|STR|USE|NUM|DOT|VAR|\%\}|\%\{|MY|\$\^|IF|\:|\}|\<|\@|\%|\[|\,|\)|\?|\{|\$|\]|\(|\>|\;|\=)}gc and return ($1, $1);



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
  [ 'progseq_5' => 'progseq', [ 'progseq', 'tl_block' ], 0 ],
  [ 'progseq_6' => 'progseq', [ 'progseg', 'tl_perlblock' ], 0 ],
  [ 'progseq_7' => 'progseq', [ 'progseq', 'tl_line' ], 0 ],
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
  [ 'params_21' => 'params', [  ], 0 ],
  [ 'params_22' => 'params', [ 'paramlist' ], 0 ],
  [ 'paramlist_23' => 'paramlist', [ 'param' ], 0 ],
  [ 'paramlist_24' => 'paramlist', [ 'paramlist', ',', 'param' ], 0 ],
  [ 'param_25' => 'param', [ 'scalar' ], 0 ],
  [ 'unitopt_26' => 'unitopt', [  ], 0 ],
  [ 'unitopt_27' => 'unitopt', [ 'unitspec' ], 0 ],
  [ 'unitspec_28' => 'unitspec', [ '<', 'unitlist', '>' ], 0 ],
  [ 'unitspec_29' => 'unitspec', [ 'error', '>' ], 0 ],
  [ 'unitlist_30' => 'unitlist', [  ], 0 ],
  [ 'unitlist_31' => 'unitlist', [ 'unitlist', 'UNIT' ], 0 ],
  [ 'tl_across_32' => 'tl_across', [ 'phase', 'ACROSS', 'dimlist', '{', '@32-4', 'progseq', '}' ], 0 ],
  [ '_CODE' => '@32-4', [  ], 0 ],
  [ 'tl_block_34' => 'tl_block', [ 'phase', '{', '@34-2', 'progseq', '}' ], 0 ],
  [ '_CODE' => '@34-2', [  ], 0 ],
  [ 'tl_perlblock_36' => 'tl_perlblock', [ 'phase', 'PERL', '{', '@36-3', 'tl_perlseq', '}' ], 0 ],
  [ '_CODE' => '@36-3', [  ], 0 ],
  [ 'tl_perlblock_38' => 'tl_perlblock', [ 'phase', '%{', '@38-2', 'tl_perlseq', '%}' ], 0 ],
  [ '_CODE' => '@38-2', [  ], 0 ],
  [ 'tl_perlseq_40' => 'tl_perlseq', [  ], 0 ],
  [ 'tl_perlseq_41' => 'tl_perlseq', [ 'tl_perlseq', 'PERLPART' ], 0 ],
  [ 'tl_line_42' => 'tl_line', [ 'phaseword', '@42-1', 'sideff', ';' ], 0 ],
  [ '_CODE' => '@42-1', [  ], 0 ],
  [ 'phase_44' => 'phase', [  ], 0 ],
  [ 'phase_45' => 'phase', [ 'phaseword' ], 0 ],
  [ 'phaseword_46' => 'phaseword', [ 'INIT' ], 0 ],
  [ 'phaseword_47' => 'phaseword', [ 'CALC' ], 0 ],
  [ 'phaseword_48' => 'phaseword', [ 'STEP' ], 0 ],
  [ 'phaseword_49' => 'phaseword', [ 'FINAL' ], 0 ],
  [ 'line_50' => 'line', [ 'package' ], 0 ],
  [ 'line_51' => 'line', [ 'sideff', ';' ], 0 ],
  [ 'line_52' => 'line', [ 'cond' ], 0 ],
  [ 'line_53' => 'line', [ 'loop' ], 0 ],
  [ 'line_54' => 'line', [ 'VAR', 'vardecl', ';' ], 0 ],
  [ 'line_55' => 'line', [ 'CONST', 'vardecl', '=', '@55-3', 'expr', ';' ], 0 ],
  [ '_CODE' => '@55-3', [  ], 0 ],
  [ 'package_57' => 'package', [ 'PACKAGE', 'WORD', ';' ], 0 ],
  [ 'sideff_58' => 'sideff', [ 'expr' ], 0 ],
  [ 'sideff_59' => 'sideff', [ 'expr', 'IF', 'expr' ], 0 ],
  [ 'sideff_60' => 'sideff', [ 'expr', 'UNLESS', 'expr' ], 0 ],
  [ 'cond_61' => 'cond', [ 'condword', '(', '@61-2', 'expr', ')', '{', 'stmtseq', '}', 'else' ], 0 ],
  [ '_CODE' => '@61-2', [  ], 0 ],
  [ 'condword_63' => 'condword', [ 'IF' ], 0 ],
  [ 'condword_64' => 'condword', [ 'UNLESS' ], 0 ],
  [ 'else_65' => 'else', [  ], 0 ],
  [ 'else_66' => 'else', [ 'ELSE', '{', '@66-2', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@66-2', [  ], 0 ],
  [ 'else_68' => 'else', [ 'ELSIF', '(', '@68-2', 'expr', ')', '{', 'stmtseq', '}', 'else' ], 0 ],
  [ '_CODE' => '@68-2', [  ], 0 ],
  [ 'loop_70' => 'loop', [ 'loopword', '(', '@70-2', 'expr', ')', '{', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@70-2', [  ], 0 ],
  [ 'loop_72' => 'loop', [ 'FOREACH', '@72-1', 'scalarvar', '(', 'expr', ')', '{', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@72-1', [  ], 0 ],
  [ 'loop_74' => 'loop', [ 'FOR', '(', '@74-2', 'expr', ';', 'expr', ';', 'expr', ')', '{', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@74-2', [  ], 0 ],
  [ 'stmtseq_76' => 'stmtseq', [  ], 0 ],
  [ 'stmtseq_77' => 'stmtseq', [ 'stmtseq', 'across' ], 0 ],
  [ 'stmtseq_78' => 'stmtseq', [ 'stmtseq', 'block' ], 0 ],
  [ 'stmtseq_79' => 'stmtseq', [ 'stmtseq', 'perlblock' ], 0 ],
  [ 'stmtseq_80' => 'stmtseq', [ 'stmtseq', 'line' ], 0 ],
  [ 'across_81' => 'across', [ 'ACROSS', 'dimlist', '{', '@81-3', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@81-3', [  ], 0 ],
  [ 'block_83' => 'block', [ '{', '@83-1', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@83-1', [  ], 0 ],
  [ 'perlblock_85' => 'perlblock', [ 'PERL', '{', '@85-2', 'perlseq', '}' ], 0 ],
  [ '_CODE' => '@85-2', [  ], 0 ],
  [ 'perlblock_87' => 'perlblock', [ '%{', '@87-1', 'perlseq', '%}' ], 0 ],
  [ '_CODE' => '@87-1', [  ], 0 ],
  [ 'perlseq_89' => 'perlseq', [  ], 0 ],
  [ 'perlseq_90' => 'perlseq', [ 'perlseq', 'PERLPART' ], 0 ],
  [ 'vardecl_91' => 'vardecl', [ 'simplevar', 'unitopt' ], 0 ],
  [ 'vardecl_92' => 'vardecl', [ 'simplevar', 'dimspec', 'unitopt' ], 0 ],
  [ 'expr_93' => 'expr', [ 'expr', 'ANDOP', 'expr' ], 0 ],
  [ 'expr_94' => 'expr', [ 'expr', 'OROP', 'expr' ], 0 ],
  [ 'expr_95' => 'expr', [ 'expr', 'XOROP', 'expr' ], 0 ],
  [ 'expr_96' => 'expr', [ 'NOTOP', 'expr' ], 0 ],
  [ 'expr_97' => 'expr', [ 'term' ], 0 ],
  [ 'term_98' => 'term', [ 'termbinop' ], 0 ],
  [ 'term_99' => 'term', [ 'termunop' ], 0 ],
  [ 'term_100' => 'term', [ 'term', '?', 'term', ':', 'term' ], 0 ],
  [ 'term_101' => 'term', [ '(', 'expr', ')' ], 0 ],
  [ 'term_102' => 'term', [ 'varexpr' ], 0 ],
  [ 'term_103' => 'term', [ 'dynvar' ], 0 ],
  [ 'term_104' => 'term', [ 'indexvar' ], 0 ],
  [ 'term_105' => 'term', [ 'NUM' ], 0 ],
  [ 'term_106' => 'term', [ 'STR' ], 0 ],
  [ 'term_107' => 'term', [ 'funcall' ], 0 ],
  [ 'term_108' => 'term', [ 'objname' ], 0 ],
  [ 'term_109' => 'term', [ 'RETURN', 'expr' ], 0 ],
  [ 'term_110' => 'term', [ 'term', 'unitspec' ], 0 ],
  [ 'term_111' => 'term', [ 'YADAYADA' ], 0 ],
  [ 'termbinop_112' => 'termbinop', [ 'term', 'ASSIGNOP', 'term' ], 0 ],
  [ 'termbinop_113' => 'termbinop', [ 'term', '=', 'term' ], 0 ],
  [ 'termbinop_114' => 'termbinop', [ 'term', 'ADDOP', 'term' ], 0 ],
  [ 'termbinop_115' => 'termbinop', [ 'term', 'MULOP', 'term' ], 0 ],
  [ 'termbinop_116' => 'termbinop', [ 'term', '%', 'term' ], 0 ],
  [ 'termbinop_117' => 'termbinop', [ 'term', 'POWOP', 'term' ], 0 ],
  [ 'termbinop_118' => 'termbinop', [ 'term', 'RELOP', 'term' ], 0 ],
  [ 'termbinop_119' => 'termbinop', [ 'term', 'DOTDOT', 'term' ], 0 ],
  [ 'termbinop_120' => 'termbinop', [ 'term', 'ANDAND', 'term' ], 0 ],
  [ 'termbinop_121' => 'termbinop', [ 'term', 'OROR', 'term' ], 0 ],
  [ 'termbinop_122' => 'termbinop', [ 'term', 'DORDOR', 'term' ], 0 ],
  [ 'termunop_123' => 'termunop', [ 'ADDOP', 'term' ], 0 ],
  [ 'termunop_124' => 'termunop', [ 'NOT2', 'term' ], 0 ],
  [ 'termunop_125' => 'termunop', [ 'term', 'INCOP' ], 0 ],
  [ 'termunop_126' => 'termunop', [ 'INCOP', 'term' ], 0 ],
  [ 'varexpr_127' => 'varexpr', [ 'simplevar' ], 0 ],
  [ 'varexpr_128' => 'varexpr', [ 'simplevar', 'subexpr' ], 0 ],
  [ 'varexpr_129' => 'varexpr', [ 'varexpr', 'DOT', 'WORD' ], 0 ],
  [ 'varexpr_130' => 'varexpr', [ 'varexpr', 'DOT', 'FUNC', '(', 'argexpr', ')' ], 0 ],
  [ 'dynvar_131' => 'dynvar', [ 'MY', 'simplevar' ], 0 ],
  [ 'simplevar_132' => 'simplevar', [ 'scalar' ], 0 ],
  [ 'simplevar_133' => 'simplevar', [ 'array' ], 0 ],
  [ 'simplevar_134' => 'simplevar', [ 'set' ], 0 ],
  [ 'scalarvar_135' => 'scalarvar', [ 'scalar' ], 0 ],
  [ 'scalarvar_136' => 'scalarvar', [ 'MY', 'scalar' ], 0 ],
  [ 'scalar_137' => 'scalar', [ '$', 'WORD' ], 0 ],
  [ 'array_138' => 'array', [ '@', 'WORD' ], 0 ],
  [ 'set_139' => 'set', [ '%', 'WORD' ], 0 ],
  [ 'indexvar_140' => 'indexvar', [ '$^' ], 0 ],
  [ 'indexvar_141' => 'indexvar', [ '$^', 'NUM' ], 0 ],
  [ 'indexvar_142' => 'indexvar', [ '$^', 'WORD' ], 0 ],
  [ 'dimlist_143' => 'dimlist', [ 'dimspec' ], 0 ],
  [ 'dimlist_144' => 'dimlist', [ 'dimlist', 'dimspec' ], 0 ],
  [ 'dimspec_145' => 'dimspec', [ '[', 'label', 'array', ']' ], 0 ],
  [ 'dimspec_146' => 'dimspec', [ '[', 'label', 'set', ']' ], 0 ],
  [ 'label_147' => 'label', [  ], 0 ],
  [ 'label_148' => 'label', [ 'WORD', ':' ], 0 ],
  [ 'subexpr_149' => 'subexpr', [ 'subspec' ], 0 ],
  [ 'subexpr_150' => 'subexpr', [ 'subexpr', 'subspec' ], 0 ],
  [ 'subspec_151' => 'subspec', [ '[', ']' ], 0 ],
  [ 'subspec_152' => 'subspec', [ '[', 'expr', ']' ], 0 ],
  [ 'funcall_153' => 'funcall', [ 'FUNC', '(', 'argexpr', ')' ], 0 ],
  [ 'funcall_154' => 'funcall', [ 'FUNC', '(', 'argexpr', ')', 'DOT', 'WORD' ], 0 ],
  [ 'objname_155' => 'objname', [ 'WORD' ], 0 ],
  [ 'argexpr_156' => 'argexpr', [  ], 0 ],
  [ 'argexpr_157' => 'argexpr', [ 'arglist' ], 0 ],
  [ 'arglist_158' => 'arglist', [ 'arg' ], 0 ],
  [ 'arglist_159' => 'arglist', [ 'argexpr', ',', 'arg' ], 0 ],
  [ 'arg_160' => 'arg', [ 'term' ], 0 ],
  [ 'arg_161' => 'arg', [ 'pair' ], 0 ],
  [ 'pair_162' => 'pair', [ 'WORD', ':', 'expr' ], 0 ],
  [ 'flow_163' => 'flow', [ 'scalar', 'MULOP', 'expr', 'FLOWRIGHT', 'scalar' ], 0 ],
  [ 'flow_164' => 'flow', [ 'scalar', 'MULOP', 'expr', 'FLOWLEFT', 'scalar' ], 0 ],
  [ 'flow_165' => 'flow', [ 'scalar', 'FLOWRIGHT', 'scalar', 'MULOP', 'expr' ], 0 ],
  [ 'flow_166' => 'flow', [ 'scalar', 'FLOWLEFT', 'scalar', 'MULOP', 'expr' ], 0 ],
  [ 'flow_167' => 'flow', [ 'scalar', '(', 'expr', ')', 'FLOWRIGHT', 'scalar' ], 0 ],
  [ 'flow_168' => 'flow', [ 'scalar', '(', 'expr', ')', 'FLOWLEFT', 'scalar' ], 0 ],
  [ 'flow_169' => 'flow', [ 'scalar', 'FLOWRIGHT', 'scalar', '(', 'expr', ')' ], 0 ],
  [ 'flow_170' => 'flow', [ 'scalar', 'FLOWLEFT', 'scalar', '(', 'expr', ')' ], 0 ],
  [ 'function_171' => 'function', [ 'FUNCTION', 'FUNC', '(', 'params', ')', 'unitopt', ';' ], 0 ],
  [ 'function_172' => 'function', [ 'FUNCTION', 'FUNC', '(', 'params', ')', 'unitopt', '{', '@172-7', 'stmtseq', '}' ], 0 ],
  [ '_CODE' => '@172-7', [  ], 0 ],
  [ 'function_174' => 'function', [ 'PERL', 'FUNCTION', 'FUNC', '(', 'params', ')', 'unitopt', ';' ], 0 ],
  [ 'function_175' => 'function', [ 'PERL', 'FUNCTION', 'FUNC', '(', 'params', ')', 'unitopt', '{', '@175-8', 'perlseq', '}' ], 0 ],
  [ '_CODE' => '@175-8', [  ], 0 ],
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
	PERLPART => { ISSEMANTIC => 1 },
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
			"%{" => -44,
			'FINAL' => 7,
			'CALC' => 9,
			'STEP' => 8,
			'PERL' => -44,
			'INIT' => 11
		},
		GOTOS => {
			'phaseword' => 6,
			'phase' => 10,
			'tl_perlblock' => 12
		}
	},
	{#State 4
		ACTIONS => {
			'' => -1,
			'WORD' => 13,
			'PACKAGE' => 18,
			"\@" => 16,
			'PERL' => 19,
			'MY' => 22,
			"%" => 21,
			'UNLESS' => 24,
			"\$^" => 23,
			'NUM' => 26,
			'STEP' => 8,
			'IF' => 28,
			"\$" => 27,
			'loopword' => 30,
			'FOREACH' => 32,
			'ACROSS' => -44,
			'NOTOP' => 35,
			'FINAL' => 7,
			'INCLUDE' => 38,
			"(" => 39,
			'VAR' => 40,
			'INCOP' => 41,
			'NOT2' => 42,
			'FOR' => 45,
			'ADDOP' => 46,
			'FUNC' => 49,
			'UNIT' => 52,
			'RETURN' => 55,
			'FUNCTION' => 57,
			'INIT' => 11,
			'STR' => 59,
			'CALC' => 9,
			"{" => -44,
			'CONST' => 63,
			'USE' => 67,
			'YADAYADA' => 69
		},
		GOTOS => {
			'phaseword' => 15,
			'scalar' => 14,
			'sideff' => 44,
			'function' => 43,
			'objname' => 17,
			'include' => 48,
			'tl_block' => 47,
			'tl_across' => 20,
			'term' => 50,
			'loop' => 25,
			'array' => 51,
			'expr' => 54,
			'use' => 53,
			'phase' => 56,
			'termbinop' => 29,
			'flow' => 31,
			'set' => 58,
			'line' => 34,
			'termunop' => 33,
			'cond' => 36,
			'dynvar' => 37,
			'condword' => 60,
			'funcall' => 61,
			'tl_line' => 62,
			'tl_decl' => 64,
			'package' => 65,
			'unit' => 68,
			'varexpr' => 66,
			'indexvar' => 70,
			'simplevar' => 71
		}
	},
	{#State 5
		DEFAULT => 0
	},
	{#State 6
		DEFAULT => -45
	},
	{#State 7
		DEFAULT => -49
	},
	{#State 8
		DEFAULT => -48
	},
	{#State 9
		DEFAULT => -47
	},
	{#State 10
		ACTIONS => {
			"%{" => 72,
			'PERL' => 73
		}
	},
	{#State 11
		DEFAULT => -46
	},
	{#State 12
		DEFAULT => -6
	},
	{#State 13
		DEFAULT => -155
	},
	{#State 14
		ACTIONS => {
			'XOROP' => -132,
			"<" => -132,
			'DORDOR' => -132,
			";" => -132,
			'FLOWLEFT' => 75,
			'ADDOP' => -132,
			"%" => -132,
			'ANDOP' => -132,
			'UNLESS' => -132,
			'ASSIGNOP' => -132,
			'IF' => -132,
			'error' => -132,
			"[" => -132,
			'FLOWRIGHT' => 76,
			'POWOP' => -132,
			'DOT' => -132,
			"?" => -132,
			'DOTDOT' => -132,
			'MULOP' => 77,
			'OROP' => -132,
			"=" => -132,
			"(" => 74,
			'ANDAND' => -132,
			'OROR' => -132,
			'RELOP' => -132,
			'INCOP' => -132
		}
	},
	{#State 15
		ACTIONS => {
			'WORD' => -43,
			'NOT2' => -43,
			"\@" => -43,
			'ADDOP' => -43,
			'MY' => -43,
			"%" => -43,
			'FUNC' => -43,
			"\$^" => -43,
			'NUM' => -43,
			'RETURN' => -43,
			"\$" => -43,
			'ACROSS' => -45,
			'STR' => -43,
			'NOTOP' => -43,
			"{" => -45,
			"(" => -43,
			'YADAYADA' => -43,
			'INCOP' => -43
		},
		GOTOS => {
			'@42-1' => 78
		}
	},
	{#State 16
		ACTIONS => {
			'WORD' => 79
		}
	},
	{#State 17
		DEFAULT => -108
	},
	{#State 18
		ACTIONS => {
			'WORD' => 80
		}
	},
	{#State 19
		ACTIONS => {
			'FUNCTION' => 81
		}
	},
	{#State 20
		DEFAULT => -4
	},
	{#State 21
		ACTIONS => {
			'WORD' => 82
		}
	},
	{#State 22
		ACTIONS => {
			"\@" => 16,
			"\$" => 27,
			"%" => 21
		},
		GOTOS => {
			'array' => 51,
			'scalar' => 83,
			'simplevar' => 84,
			'set' => 58
		}
	},
	{#State 23
		ACTIONS => {
			'' => -140,
			"}" => -140,
			":" => -140,
			'WORD' => 85,
			'PACKAGE' => -140,
			'XOROP' => -140,
			"\@" => -140,
			"<" => -140,
			'DORDOR' => -140,
			'PERL' => -140,
			'MY' => -140,
			"%" => -140,
			'ANDOP' => -140,
			"\$^" => -140,
			'UNLESS' => -140,
			'NUM' => 86,
			'STEP' => -140,
			'ASSIGNOP' => -140,
			'IF' => -140,
			"\$" => -140,
			'loopword' => -140,
			'FOREACH' => -140,
			"]" => -140,
			'POWOP' => -140,
			'ACROSS' => -140,
			'NOTOP' => -140,
			'FINAL' => -140,
			'OROP' => -140,
			'INCLUDE' => -140,
			"(" => -140,
			'VAR' => -140,
			'ANDAND' => -140,
			'INCOP' => -140,
			'RELOP' => -140,
			'NOT2' => -140,
			";" => -140,
			'FOR' => -140,
			'FLOWLEFT' => -140,
			'ADDOP' => -140,
			"," => -140,
			'FUNC' => -140,
			'UNIT' => -140,
			'RETURN' => -140,
			'INIT' => -140,
			'FUNCTION' => -140,
			'error' => -140,
			'FLOWRIGHT' => -140,
			")" => -140,
			'STR' => -140,
			'CALC' => -140,
			"?" => -140,
			'DOTDOT' => -140,
			'MULOP' => -140,
			"{" => -140,
			'CONST' => -140,
			"=" => -140,
			'USE' => -140,
			'YADAYADA' => -140,
			'OROR' => -140
		}
	},
	{#State 24
		DEFAULT => -64
	},
	{#State 25
		DEFAULT => -53
	},
	{#State 26
		DEFAULT => -105
	},
	{#State 27
		ACTIONS => {
			'WORD' => 87
		}
	},
	{#State 28
		DEFAULT => -63
	},
	{#State 29
		DEFAULT => -98
	},
	{#State 30
		ACTIONS => {
			"(" => 88
		}
	},
	{#State 31
		DEFAULT => -8
	},
	{#State 32
		DEFAULT => -73,
		GOTOS => {
			'@72-1' => 89
		}
	},
	{#State 33
		DEFAULT => -99
	},
	{#State 34
		DEFAULT => -9
	},
	{#State 35
		ACTIONS => {
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			'NOTOP' => 35,
			'STR' => 59,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 50,
			'array' => 51,
			'varexpr' => 66,
			'expr' => 90,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'set' => 58,
			'termunop' => 33
		}
	},
	{#State 36
		DEFAULT => -52
	},
	{#State 37
		DEFAULT => -103
	},
	{#State 38
		ACTIONS => {
			'STR' => 92,
			'WORD' => 91
		}
	},
	{#State 39
		ACTIONS => {
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			'NOTOP' => 35,
			'STR' => 59,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 50,
			'array' => 51,
			'varexpr' => 66,
			'expr' => 93,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'set' => 58,
			'termunop' => 33
		}
	},
	{#State 40
		ACTIONS => {
			"\@" => 16,
			"\$" => 27,
			"%" => 21
		},
		GOTOS => {
			'array' => 51,
			'vardecl' => 94,
			'scalar' => 83,
			'simplevar' => 95,
			'set' => 58
		}
	},
	{#State 41
		ACTIONS => {
			'STR' => 59,
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			"(" => 39,
			'YADAYADA' => 69,
			'RETURN' => 55,
			"\$" => 27,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 96,
			'array' => 51,
			'varexpr' => 66,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'termunop' => 33,
			'set' => 58
		}
	},
	{#State 42
		ACTIONS => {
			'STR' => 59,
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			"(" => 39,
			'YADAYADA' => 69,
			'RETURN' => 55,
			"\$" => 27,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 97,
			'array' => 51,
			'varexpr' => 66,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'termunop' => 33,
			'set' => 58
		}
	},
	{#State 43
		DEFAULT => -14
	},
	{#State 44
		ACTIONS => {
			";" => 98
		}
	},
	{#State 45
		ACTIONS => {
			"(" => 99
		}
	},
	{#State 46
		ACTIONS => {
			'STR' => 59,
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			"(" => 39,
			'YADAYADA' => 69,
			'RETURN' => 55,
			"\$" => 27,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 100,
			'array' => 51,
			'varexpr' => 66,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'termunop' => 33,
			'set' => 58
		}
	},
	{#State 47
		DEFAULT => -5
	},
	{#State 48
		DEFAULT => -11
	},
	{#State 49
		ACTIONS => {
			"(" => 101
		}
	},
	{#State 50
		ACTIONS => {
			'WORD' => -97,
			'' => -97,
			"}" => -97,
			":" => -97,
			'PACKAGE' => -97,
			'XOROP' => -97,
			"\@" => -97,
			'DORDOR' => 103,
			"<" => 102,
			'PERL' => -97,
			'MY' => -97,
			"%" => 104,
			'ANDOP' => -97,
			"\$^" => -97,
			'UNLESS' => -97,
			'NUM' => -97,
			'STEP' => -97,
			'ASSIGNOP' => 105,
			'IF' => -97,
			"\$" => -97,
			'loopword' => -97,
			'FOREACH' => -97,
			"]" => -97,
			'ACROSS' => -97,
			'POWOP' => 106,
			'NOTOP' => -97,
			'FINAL' => -97,
			'OROP' => -97,
			'INCLUDE' => -97,
			"(" => -97,
			'VAR' => -97,
			'ANDAND' => 108,
			'INCOP' => 109,
			'RELOP' => 110,
			'NOT2' => -97,
			";" => -97,
			'FOR' => -97,
			'FLOWLEFT' => -97,
			'ADDOP' => 111,
			"," => -97,
			'FUNC' => -97,
			'UNIT' => -97,
			'RETURN' => -97,
			'INIT' => -97,
			'FUNCTION' => -97,
			'error' => 112,
			'FLOWRIGHT' => -97,
			")" => -97,
			'STR' => -97,
			'CALC' => -97,
			"?" => 113,
			"{" => -97,
			'MULOP' => 115,
			'DOTDOT' => 114,
			'CONST' => -97,
			"=" => 116,
			'USE' => -97,
			'YADAYADA' => -97,
			'OROR' => 117
		},
		GOTOS => {
			'unitspec' => 107
		}
	},
	{#State 51
		DEFAULT => -133
	},
	{#State 52
		ACTIONS => {
			'WORD' => 118
		},
		GOTOS => {
			'unitdecl' => 119
		}
	},
	{#State 53
		DEFAULT => -12
	},
	{#State 54
		ACTIONS => {
			'XOROP' => 120,
			";" => -58,
			'IF' => 123,
			'OROP' => 124,
			'ANDOP' => 121,
			'UNLESS' => 122
		}
	},
	{#State 55
		ACTIONS => {
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			'NOTOP' => 35,
			'STR' => 59,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 50,
			'array' => 51,
			'varexpr' => 66,
			'expr' => 125,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'set' => 58,
			'termunop' => 33
		}
	},
	{#State 56
		ACTIONS => {
			"{" => 127,
			'ACROSS' => 126
		}
	},
	{#State 57
		ACTIONS => {
			'FUNC' => 128
		}
	},
	{#State 58
		DEFAULT => -134
	},
	{#State 59
		DEFAULT => -106
	},
	{#State 60
		ACTIONS => {
			"(" => 129
		}
	},
	{#State 61
		DEFAULT => -107
	},
	{#State 62
		DEFAULT => -7
	},
	{#State 63
		ACTIONS => {
			"\@" => 16,
			"\$" => 27,
			"%" => 21
		},
		GOTOS => {
			'array' => 51,
			'vardecl' => 130,
			'scalar' => 83,
			'simplevar' => 95,
			'set' => 58
		}
	},
	{#State 64
		DEFAULT => -3
	},
	{#State 65
		DEFAULT => -50
	},
	{#State 66
		ACTIONS => {
			'WORD' => -102,
			'' => -102,
			"}" => -102,
			":" => -102,
			'PACKAGE' => -102,
			'XOROP' => -102,
			"\@" => -102,
			"<" => -102,
			'DORDOR' => -102,
			'PERL' => -102,
			'MY' => -102,
			"%" => -102,
			'ANDOP' => -102,
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
			'DOT' => 131,
			'OROP' => -102,
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
			'error' => -102,
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
	{#State 67
		ACTIONS => {
			'WORD' => 132
		}
	},
	{#State 68
		DEFAULT => -13
	},
	{#State 69
		DEFAULT => -111
	},
	{#State 70
		DEFAULT => -104
	},
	{#State 71
		ACTIONS => {
			'WORD' => -127,
			'' => -127,
			"}" => -127,
			":" => -127,
			'PACKAGE' => -127,
			'XOROP' => -127,
			"\@" => -127,
			"<" => -127,
			'DORDOR' => -127,
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
			"[" => 133,
			"]" => -127,
			'POWOP' => -127,
			'ACROSS' => -127,
			'NOTOP' => -127,
			'FINAL' => -127,
			'DOT' => -127,
			'OROP' => -127,
			'INCLUDE' => -127,
			"(" => -127,
			'VAR' => -127,
			'ANDAND' => -127,
			'INCOP' => -127,
			'RELOP' => -127,
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
			'error' => -127,
			'FLOWRIGHT' => -127,
			")" => -127,
			'STR' => -127,
			'CALC' => -127,
			"?" => -127,
			'DOTDOT' => -127,
			'MULOP' => -127,
			"{" => -127,
			'CONST' => -127,
			"=" => -127,
			'USE' => -127,
			'YADAYADA' => -127,
			'OROR' => -127
		},
		GOTOS => {
			'subexpr' => 135,
			'subspec' => 134
		}
	},
	{#State 72
		DEFAULT => -39,
		GOTOS => {
			'@38-2' => 136
		}
	},
	{#State 73
		ACTIONS => {
			"{" => 137
		}
	},
	{#State 74
		ACTIONS => {
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			'NOTOP' => 35,
			'STR' => 59,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 50,
			'array' => 51,
			'varexpr' => 66,
			'expr' => 138,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'set' => 58,
			'termunop' => 33
		}
	},
	{#State 75
		ACTIONS => {
			"\$" => 27
		},
		GOTOS => {
			'scalar' => 139
		}
	},
	{#State 76
		ACTIONS => {
			"\$" => 27
		},
		GOTOS => {
			'scalar' => 140
		}
	},
	{#State 77
		ACTIONS => {
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			'NOTOP' => 35,
			'STR' => 59,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 50,
			'array' => 51,
			'varexpr' => 66,
			'expr' => 141,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'set' => 58,
			'termunop' => 33
		}
	},
	{#State 78
		ACTIONS => {
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			'NOTOP' => 35,
			'STR' => 59,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'sideff' => 142,
			'objname' => 17,
			'funcall' => 61,
			'term' => 50,
			'array' => 51,
			'varexpr' => 66,
			'expr' => 54,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'set' => 58,
			'termunop' => 33
		}
	},
	{#State 79
		DEFAULT => -138
	},
	{#State 80
		ACTIONS => {
			";" => 143
		}
	},
	{#State 81
		ACTIONS => {
			'FUNC' => 144
		}
	},
	{#State 82
		DEFAULT => -139
	},
	{#State 83
		DEFAULT => -132
	},
	{#State 84
		DEFAULT => -131
	},
	{#State 85
		DEFAULT => -142
	},
	{#State 86
		DEFAULT => -141
	},
	{#State 87
		DEFAULT => -137
	},
	{#State 88
		DEFAULT => -71,
		GOTOS => {
			'@70-2' => 145
		}
	},
	{#State 89
		ACTIONS => {
			"\$" => 27,
			'MY' => 147
		},
		GOTOS => {
			'scalar' => 146,
			'scalarvar' => 148
		}
	},
	{#State 90
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
			'FUNCTION' => -96,
			'error' => -96,
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
	{#State 91
		ACTIONS => {
			";" => 149
		}
	},
	{#State 92
		ACTIONS => {
			";" => 150
		}
	},
	{#State 93
		ACTIONS => {
			'XOROP' => 120,
			'OROP' => 124,
			")" => 151,
			'ANDOP' => 121
		}
	},
	{#State 94
		ACTIONS => {
			";" => 152
		}
	},
	{#State 95
		ACTIONS => {
			"<" => 102,
			";" => -26,
			'error' => 112,
			"[" => 153,
			"=" => -26
		},
		GOTOS => {
			'unitspec' => 156,
			'unitopt' => 154,
			'dimspec' => 155
		}
	},
	{#State 96
		ACTIONS => {
			'WORD' => -126,
			'' => -126,
			"}" => -126,
			":" => -126,
			'PACKAGE' => -126,
			'XOROP' => -126,
			"\@" => -126,
			'DORDOR' => -126,
			"<" => 102,
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
			'POWOP' => -126,
			'NOTOP' => -126,
			'FINAL' => -126,
			'OROP' => -126,
			'INCLUDE' => -126,
			"(" => -126,
			'VAR' => -126,
			'ANDAND' => -126,
			'INCOP' => undef,
			'RELOP' => -126,
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
			'error' => 112,
			'FLOWRIGHT' => -126,
			")" => -126,
			'STR' => -126,
			'CALC' => -126,
			"?" => -126,
			"{" => -126,
			'MULOP' => -126,
			'DOTDOT' => -126,
			'CONST' => -126,
			"=" => -126,
			'USE' => -126,
			'YADAYADA' => -126,
			'OROR' => -126
		},
		GOTOS => {
			'unitspec' => 107
		}
	},
	{#State 97
		ACTIONS => {
			'WORD' => -124,
			'' => -124,
			"}" => -124,
			":" => -124,
			'PACKAGE' => -124,
			'XOROP' => -124,
			"\@" => -124,
			'DORDOR' => -124,
			"<" => 102,
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
			'POWOP' => 106,
			'NOTOP' => -124,
			'FINAL' => -124,
			'OROP' => -124,
			'INCLUDE' => -124,
			"(" => -124,
			'VAR' => -124,
			'ANDAND' => -124,
			'INCOP' => 109,
			'RELOP' => -124,
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
			'FUNCTION' => -124,
			'error' => 112,
			'FLOWRIGHT' => -124,
			")" => -124,
			'STR' => -124,
			'CALC' => -124,
			"?" => -124,
			"{" => -124,
			'MULOP' => -124,
			'DOTDOT' => -124,
			'CONST' => -124,
			"=" => -124,
			'USE' => -124,
			'YADAYADA' => -124,
			'OROR' => -124
		},
		GOTOS => {
			'unitspec' => 107
		}
	},
	{#State 98
		DEFAULT => -51
	},
	{#State 99
		DEFAULT => -75,
		GOTOS => {
			'@74-2' => 157
		}
	},
	{#State 100
		ACTIONS => {
			'WORD' => -123,
			'' => -123,
			"}" => -123,
			":" => -123,
			'PACKAGE' => -123,
			'XOROP' => -123,
			"\@" => -123,
			'DORDOR' => -123,
			"<" => 102,
			'PERL' => -123,
			'MY' => -123,
			"%" => -123,
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
			'POWOP' => 106,
			'NOTOP' => -123,
			'FINAL' => -123,
			'OROP' => -123,
			'INCLUDE' => -123,
			"(" => -123,
			'VAR' => -123,
			'ANDAND' => -123,
			'INCOP' => 109,
			'RELOP' => -123,
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
			'FUNCTION' => -123,
			'error' => 112,
			'FLOWRIGHT' => -123,
			")" => -123,
			'STR' => -123,
			'CALC' => -123,
			"?" => -123,
			"{" => -123,
			'MULOP' => -123,
			'DOTDOT' => -123,
			'CONST' => -123,
			"=" => -123,
			'USE' => -123,
			'YADAYADA' => -123,
			'OROR' => -123
		},
		GOTOS => {
			'unitspec' => 107
		}
	},
	{#State 101
		ACTIONS => {
			'WORD' => 158,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			"," => -156,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			")" => -156,
			'STR' => 59,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'objname' => 17,
			'arg' => 159,
			'term' => 161,
			'array' => 51,
			'pair' => 160,
			'termbinop' => 29,
			'set' => 58,
			'termunop' => 33,
			'dynvar' => 37,
			'funcall' => 61,
			'arglist' => 162,
			'varexpr' => 66,
			'indexvar' => 70,
			'argexpr' => 163,
			'simplevar' => 71
		}
	},
	{#State 102
		DEFAULT => -30,
		GOTOS => {
			'unitlist' => 164
		}
	},
	{#State 103
		ACTIONS => {
			'STR' => 59,
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			"(" => 39,
			'YADAYADA' => 69,
			'RETURN' => 55,
			"\$" => 27,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 165,
			'array' => 51,
			'varexpr' => 66,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'termunop' => 33,
			'set' => 58
		}
	},
	{#State 104
		ACTIONS => {
			'STR' => 59,
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			"(" => 39,
			'YADAYADA' => 69,
			'RETURN' => 55,
			"\$" => 27,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 166,
			'array' => 51,
			'varexpr' => 66,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'termunop' => 33,
			'set' => 58
		}
	},
	{#State 105
		ACTIONS => {
			'STR' => 59,
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			"(" => 39,
			'YADAYADA' => 69,
			'RETURN' => 55,
			"\$" => 27,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 167,
			'array' => 51,
			'varexpr' => 66,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'termunop' => 33,
			'set' => 58
		}
	},
	{#State 106
		ACTIONS => {
			'STR' => 59,
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			"(" => 39,
			'YADAYADA' => 69,
			'RETURN' => 55,
			"\$" => 27,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 168,
			'array' => 51,
			'varexpr' => 66,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'termunop' => 33,
			'set' => 58
		}
	},
	{#State 107
		DEFAULT => -110
	},
	{#State 108
		ACTIONS => {
			'STR' => 59,
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			"(" => 39,
			'YADAYADA' => 69,
			'RETURN' => 55,
			"\$" => 27,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 169,
			'array' => 51,
			'varexpr' => 66,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'termunop' => 33,
			'set' => 58
		}
	},
	{#State 109
		DEFAULT => -125
	},
	{#State 110
		ACTIONS => {
			'STR' => 59,
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			"(" => 39,
			'YADAYADA' => 69,
			'RETURN' => 55,
			"\$" => 27,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 170,
			'array' => 51,
			'varexpr' => 66,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'termunop' => 33,
			'set' => 58
		}
	},
	{#State 111
		ACTIONS => {
			'STR' => 59,
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			"(" => 39,
			'YADAYADA' => 69,
			'RETURN' => 55,
			"\$" => 27,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 171,
			'array' => 51,
			'varexpr' => 66,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'termunop' => 33,
			'set' => 58
		}
	},
	{#State 112
		ACTIONS => {
			">" => 172
		}
	},
	{#State 113
		ACTIONS => {
			'STR' => 59,
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			"(" => 39,
			'YADAYADA' => 69,
			'RETURN' => 55,
			"\$" => 27,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 173,
			'array' => 51,
			'varexpr' => 66,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'termunop' => 33,
			'set' => 58
		}
	},
	{#State 114
		ACTIONS => {
			'STR' => 59,
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			"(" => 39,
			'YADAYADA' => 69,
			'RETURN' => 55,
			"\$" => 27,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 174,
			'array' => 51,
			'varexpr' => 66,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'termunop' => 33,
			'set' => 58
		}
	},
	{#State 115
		ACTIONS => {
			'STR' => 59,
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			"(" => 39,
			'YADAYADA' => 69,
			'RETURN' => 55,
			"\$" => 27,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 175,
			'array' => 51,
			'varexpr' => 66,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'termunop' => 33,
			'set' => 58
		}
	},
	{#State 116
		ACTIONS => {
			'STR' => 59,
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			"(" => 39,
			'YADAYADA' => 69,
			'RETURN' => 55,
			"\$" => 27,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 176,
			'array' => 51,
			'varexpr' => 66,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'termunop' => 33,
			'set' => 58
		}
	},
	{#State 117
		ACTIONS => {
			'STR' => 59,
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			"(" => 39,
			'YADAYADA' => 69,
			'RETURN' => 55,
			"\$" => 27,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 177,
			'array' => 51,
			'varexpr' => 66,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'termunop' => 33,
			'set' => 58
		}
	},
	{#State 118
		DEFAULT => -19
	},
	{#State 119
		ACTIONS => {
			";" => 178,
			"," => 179
		}
	},
	{#State 120
		ACTIONS => {
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			'NOTOP' => 35,
			'STR' => 59,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 50,
			'array' => 51,
			'varexpr' => 66,
			'expr' => 180,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'set' => 58,
			'termunop' => 33
		}
	},
	{#State 121
		ACTIONS => {
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			'NOTOP' => 35,
			'STR' => 59,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 50,
			'array' => 51,
			'varexpr' => 66,
			'expr' => 181,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'set' => 58,
			'termunop' => 33
		}
	},
	{#State 122
		ACTIONS => {
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			'NOTOP' => 35,
			'STR' => 59,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 50,
			'array' => 51,
			'varexpr' => 66,
			'expr' => 182,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'set' => 58,
			'termunop' => 33
		}
	},
	{#State 123
		ACTIONS => {
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			'NOTOP' => 35,
			'STR' => 59,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 50,
			'array' => 51,
			'varexpr' => 66,
			'expr' => 183,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'set' => 58,
			'termunop' => 33
		}
	},
	{#State 124
		ACTIONS => {
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			'NOTOP' => 35,
			'STR' => 59,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 50,
			'array' => 51,
			'varexpr' => 66,
			'expr' => 184,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'set' => 58,
			'termunop' => 33
		}
	},
	{#State 125
		ACTIONS => {
			'WORD' => -109,
			'' => -109,
			"}" => -109,
			":" => -109,
			'PACKAGE' => -109,
			"\@" => -109,
			"<" => -109,
			'DORDOR' => -109,
			'XOROP' => 120,
			'PERL' => -109,
			'MY' => -109,
			"%" => -109,
			'ANDOP' => 121,
			"\$^" => -109,
			'UNLESS' => -109,
			'NUM' => -109,
			'STEP' => -109,
			'ASSIGNOP' => -109,
			'IF' => -109,
			"\$" => -109,
			'loopword' => -109,
			'FOREACH' => -109,
			"]" => -109,
			'POWOP' => -109,
			'ACROSS' => -109,
			'NOTOP' => -109,
			'FINAL' => -109,
			'OROP' => 124,
			'INCLUDE' => -109,
			"(" => -109,
			'VAR' => -109,
			'ANDAND' => -109,
			'INCOP' => -109,
			'RELOP' => -109,
			'NOT2' => -109,
			";" => -109,
			'FOR' => -109,
			'FLOWLEFT' => -109,
			'ADDOP' => -109,
			"," => -109,
			'FUNC' => -109,
			'UNIT' => -109,
			'RETURN' => -109,
			'INIT' => -109,
			'FUNCTION' => -109,
			'error' => -109,
			'FLOWRIGHT' => -109,
			")" => -109,
			'STR' => -109,
			'CALC' => -109,
			"?" => -109,
			'DOTDOT' => -109,
			'MULOP' => -109,
			"{" => -109,
			'CONST' => -109,
			"=" => -109,
			'USE' => -109,
			'YADAYADA' => -109,
			'OROR' => -109
		}
	},
	{#State 126
		ACTIONS => {
			"[" => 153
		},
		GOTOS => {
			'dimlist' => 186,
			'dimspec' => 185
		}
	},
	{#State 127
		DEFAULT => -35,
		GOTOS => {
			'@34-2' => 187
		}
	},
	{#State 128
		ACTIONS => {
			"(" => 188
		}
	},
	{#State 129
		DEFAULT => -62,
		GOTOS => {
			'@61-2' => 189
		}
	},
	{#State 130
		ACTIONS => {
			"=" => 190
		}
	},
	{#State 131
		ACTIONS => {
			'WORD' => 191,
			'FUNC' => 192
		}
	},
	{#State 132
		ACTIONS => {
			";" => 193
		}
	},
	{#State 133
		ACTIONS => {
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			"]" => 194,
			'NOTOP' => 35,
			'STR' => 59,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 50,
			'array' => 51,
			'varexpr' => 66,
			'expr' => 195,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'set' => 58,
			'termunop' => 33
		}
	},
	{#State 134
		DEFAULT => -149
	},
	{#State 135
		ACTIONS => {
			'WORD' => -128,
			'' => -128,
			"}" => -128,
			":" => -128,
			'PACKAGE' => -128,
			'XOROP' => -128,
			"\@" => -128,
			"<" => -128,
			'DORDOR' => -128,
			'PERL' => -128,
			'MY' => -128,
			"%" => -128,
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
			"[" => 133,
			"]" => -128,
			'POWOP' => -128,
			'ACROSS' => -128,
			'NOTOP' => -128,
			'FINAL' => -128,
			'DOT' => -128,
			'OROP' => -128,
			'INCLUDE' => -128,
			"(" => -128,
			'VAR' => -128,
			'ANDAND' => -128,
			'INCOP' => -128,
			'RELOP' => -128,
			'NOT2' => -128,
			";" => -128,
			'FOR' => -128,
			'FLOWLEFT' => -128,
			'ADDOP' => -128,
			"," => -128,
			'FUNC' => -128,
			'UNIT' => -128,
			'RETURN' => -128,
			'INIT' => -128,
			'FUNCTION' => -128,
			'error' => -128,
			'FLOWRIGHT' => -128,
			")" => -128,
			'STR' => -128,
			'CALC' => -128,
			"?" => -128,
			'DOTDOT' => -128,
			'MULOP' => -128,
			"{" => -128,
			'CONST' => -128,
			"=" => -128,
			'USE' => -128,
			'YADAYADA' => -128,
			'OROR' => -128
		},
		GOTOS => {
			'subspec' => 196
		}
	},
	{#State 136
		DEFAULT => -40,
		GOTOS => {
			'tl_perlseq' => 197
		}
	},
	{#State 137
		DEFAULT => -37,
		GOTOS => {
			'@36-3' => 198
		}
	},
	{#State 138
		ACTIONS => {
			'XOROP' => 120,
			'OROP' => 124,
			")" => 199,
			'ANDOP' => 121
		}
	},
	{#State 139
		ACTIONS => {
			"(" => 200,
			'MULOP' => 201
		}
	},
	{#State 140
		ACTIONS => {
			"(" => 202,
			'MULOP' => 203
		}
	},
	{#State 141
		ACTIONS => {
			'XOROP' => 120,
			'FLOWLEFT' => 204,
			'OROP' => 124,
			'FLOWRIGHT' => 205,
			'ANDOP' => 121
		}
	},
	{#State 142
		ACTIONS => {
			";" => 206
		}
	},
	{#State 143
		DEFAULT => -57
	},
	{#State 144
		ACTIONS => {
			"(" => 207
		}
	},
	{#State 145
		ACTIONS => {
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			'NOTOP' => 35,
			'STR' => 59,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 50,
			'array' => 51,
			'varexpr' => 66,
			'expr' => 208,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'set' => 58,
			'termunop' => 33
		}
	},
	{#State 146
		DEFAULT => -135
	},
	{#State 147
		ACTIONS => {
			"\$" => 27
		},
		GOTOS => {
			'scalar' => 209
		}
	},
	{#State 148
		ACTIONS => {
			"(" => 210
		}
	},
	{#State 149
		DEFAULT => -15
	},
	{#State 150
		DEFAULT => -16
	},
	{#State 151
		DEFAULT => -101
	},
	{#State 152
		DEFAULT => -54
	},
	{#State 153
		ACTIONS => {
			'WORD' => 211,
			"\@" => -147,
			"%" => -147
		},
		GOTOS => {
			'label' => 212
		}
	},
	{#State 154
		DEFAULT => -91
	},
	{#State 155
		ACTIONS => {
			"<" => 102,
			";" => -26,
			'error' => 112,
			"=" => -26
		},
		GOTOS => {
			'unitspec' => 156,
			'unitopt' => 213
		}
	},
	{#State 156
		DEFAULT => -27
	},
	{#State 157
		ACTIONS => {
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			'NOTOP' => 35,
			'STR' => 59,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 50,
			'array' => 51,
			'varexpr' => 66,
			'expr' => 214,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'set' => 58,
			'termunop' => 33
		}
	},
	{#State 158
		ACTIONS => {
			":" => 215,
			"<" => -155,
			'DORDOR' => -155,
			'ADDOP' => -155,
			"," => -155,
			"%" => -155,
			'ASSIGNOP' => -155,
			'error' => -155,
			")" => -155,
			'POWOP' => -155,
			"?" => -155,
			'DOTDOT' => -155,
			'MULOP' => -155,
			"=" => -155,
			'ANDAND' => -155,
			'OROR' => -155,
			'INCOP' => -155,
			'RELOP' => -155
		}
	},
	{#State 159
		DEFAULT => -158
	},
	{#State 160
		DEFAULT => -161
	},
	{#State 161
		ACTIONS => {
			'DORDOR' => 103,
			"<" => 102,
			'ADDOP' => 111,
			"," => -160,
			"%" => 104,
			'ASSIGNOP' => 105,
			'error' => 112,
			")" => -160,
			'POWOP' => 106,
			"?" => 113,
			'DOTDOT' => 114,
			'MULOP' => 115,
			"=" => 116,
			'ANDAND' => 108,
			'OROR' => 117,
			'INCOP' => 109,
			'RELOP' => 110
		},
		GOTOS => {
			'unitspec' => 107
		}
	},
	{#State 162
		DEFAULT => -157
	},
	{#State 163
		ACTIONS => {
			"," => 216,
			")" => 217
		}
	},
	{#State 164
		ACTIONS => {
			'UNIT' => 219,
			">" => 218
		}
	},
	{#State 165
		ACTIONS => {
			'WORD' => -122,
			'' => -122,
			"}" => -122,
			":" => -122,
			'PACKAGE' => -122,
			'XOROP' => -122,
			"\@" => -122,
			'DORDOR' => -122,
			"<" => 102,
			'PERL' => -122,
			'MY' => -122,
			"%" => 104,
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
			'POWOP' => 106,
			'NOTOP' => -122,
			'FINAL' => -122,
			'OROP' => -122,
			'INCLUDE' => -122,
			"(" => -122,
			'VAR' => -122,
			'ANDAND' => 108,
			'INCOP' => 109,
			'RELOP' => 110,
			'NOT2' => -122,
			";" => -122,
			'FOR' => -122,
			'FLOWLEFT' => -122,
			'ADDOP' => 111,
			"," => -122,
			'FUNC' => -122,
			'UNIT' => -122,
			'RETURN' => -122,
			'INIT' => -122,
			'FUNCTION' => -122,
			'error' => 112,
			'FLOWRIGHT' => -122,
			")" => -122,
			'STR' => -122,
			'CALC' => -122,
			"?" => -122,
			"{" => -122,
			'MULOP' => 115,
			'DOTDOT' => -122,
			'CONST' => -122,
			"=" => -122,
			'USE' => -122,
			'YADAYADA' => -122,
			'OROR' => -122
		},
		GOTOS => {
			'unitspec' => 107
		}
	},
	{#State 166
		ACTIONS => {
			'WORD' => -116,
			'' => -116,
			"}" => -116,
			":" => -116,
			'PACKAGE' => -116,
			'XOROP' => -116,
			"\@" => -116,
			'DORDOR' => -116,
			"<" => 102,
			'PERL' => -116,
			'MY' => -116,
			"%" => -116,
			'ANDOP' => -116,
			"\$^" => -116,
			'UNLESS' => -116,
			'NUM' => -116,
			'STEP' => -116,
			'ASSIGNOP' => -116,
			'IF' => -116,
			"\$" => -116,
			'loopword' => -116,
			'FOREACH' => -116,
			"]" => -116,
			'ACROSS' => -116,
			'POWOP' => 106,
			'NOTOP' => -116,
			'FINAL' => -116,
			'OROP' => -116,
			'INCLUDE' => -116,
			"(" => -116,
			'VAR' => -116,
			'ANDAND' => -116,
			'INCOP' => 109,
			'RELOP' => -116,
			'NOT2' => -116,
			";" => -116,
			'FOR' => -116,
			'FLOWLEFT' => -116,
			'ADDOP' => -116,
			"," => -116,
			'FUNC' => -116,
			'UNIT' => -116,
			'RETURN' => -116,
			'INIT' => -116,
			'FUNCTION' => -116,
			'error' => 112,
			'FLOWRIGHT' => -116,
			")" => -116,
			'STR' => -116,
			'CALC' => -116,
			"?" => -116,
			"{" => -116,
			'MULOP' => -116,
			'DOTDOT' => -116,
			'CONST' => -116,
			"=" => -116,
			'USE' => -116,
			'YADAYADA' => -116,
			'OROR' => -116
		},
		GOTOS => {
			'unitspec' => 107
		}
	},
	{#State 167
		ACTIONS => {
			'WORD' => -112,
			'' => -112,
			"}" => -112,
			":" => -112,
			'PACKAGE' => -112,
			'XOROP' => -112,
			"\@" => -112,
			'DORDOR' => 103,
			"<" => 102,
			'PERL' => -112,
			'MY' => -112,
			"%" => 104,
			'ANDOP' => -112,
			"\$^" => -112,
			'UNLESS' => -112,
			'NUM' => -112,
			'STEP' => -112,
			'ASSIGNOP' => 105,
			'IF' => -112,
			"\$" => -112,
			'loopword' => -112,
			'FOREACH' => -112,
			"]" => -112,
			'ACROSS' => -112,
			'POWOP' => 106,
			'NOTOP' => -112,
			'FINAL' => -112,
			'OROP' => -112,
			'INCLUDE' => -112,
			"(" => -112,
			'VAR' => -112,
			'ANDAND' => 108,
			'INCOP' => 109,
			'RELOP' => 110,
			'NOT2' => -112,
			";" => -112,
			'FOR' => -112,
			'FLOWLEFT' => -112,
			'ADDOP' => 111,
			"," => -112,
			'FUNC' => -112,
			'UNIT' => -112,
			'RETURN' => -112,
			'INIT' => -112,
			'FUNCTION' => -112,
			'error' => 112,
			'FLOWRIGHT' => -112,
			")" => -112,
			'STR' => -112,
			'CALC' => -112,
			"?" => 113,
			"{" => -112,
			'MULOP' => 115,
			'DOTDOT' => 114,
			'CONST' => -112,
			"=" => 116,
			'USE' => -112,
			'YADAYADA' => -112,
			'OROR' => 117
		},
		GOTOS => {
			'unitspec' => 107
		}
	},
	{#State 168
		ACTIONS => {
			'WORD' => -117,
			'' => -117,
			"}" => -117,
			":" => -117,
			'PACKAGE' => -117,
			'XOROP' => -117,
			"\@" => -117,
			'DORDOR' => -117,
			"<" => 102,
			'PERL' => -117,
			'MY' => -117,
			"%" => -117,
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
			'POWOP' => 106,
			'NOTOP' => -117,
			'FINAL' => -117,
			'OROP' => -117,
			'INCLUDE' => -117,
			"(" => -117,
			'VAR' => -117,
			'ANDAND' => -117,
			'INCOP' => 109,
			'RELOP' => -117,
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
			'error' => 112,
			'FLOWRIGHT' => -117,
			")" => -117,
			'STR' => -117,
			'CALC' => -117,
			"?" => -117,
			"{" => -117,
			'MULOP' => -117,
			'DOTDOT' => -117,
			'CONST' => -117,
			"=" => -117,
			'USE' => -117,
			'YADAYADA' => -117,
			'OROR' => -117
		},
		GOTOS => {
			'unitspec' => 107
		}
	},
	{#State 169
		ACTIONS => {
			'WORD' => -120,
			'' => -120,
			"}" => -120,
			":" => -120,
			'PACKAGE' => -120,
			'XOROP' => -120,
			"\@" => -120,
			'DORDOR' => -120,
			"<" => 102,
			'PERL' => -120,
			'MY' => -120,
			"%" => 104,
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
			'POWOP' => 106,
			'NOTOP' => -120,
			'FINAL' => -120,
			'OROP' => -120,
			'INCLUDE' => -120,
			"(" => -120,
			'VAR' => -120,
			'ANDAND' => -120,
			'INCOP' => 109,
			'RELOP' => 110,
			'NOT2' => -120,
			";" => -120,
			'FOR' => -120,
			'FLOWLEFT' => -120,
			'ADDOP' => 111,
			"," => -120,
			'FUNC' => -120,
			'UNIT' => -120,
			'RETURN' => -120,
			'INIT' => -120,
			'FUNCTION' => -120,
			'error' => 112,
			'FLOWRIGHT' => -120,
			")" => -120,
			'STR' => -120,
			'CALC' => -120,
			"?" => -120,
			"{" => -120,
			'MULOP' => 115,
			'DOTDOT' => -120,
			'CONST' => -120,
			"=" => -120,
			'USE' => -120,
			'YADAYADA' => -120,
			'OROR' => -120
		},
		GOTOS => {
			'unitspec' => 107
		}
	},
	{#State 170
		ACTIONS => {
			'WORD' => -118,
			'' => -118,
			"}" => -118,
			":" => -118,
			'PACKAGE' => -118,
			'XOROP' => -118,
			"\@" => -118,
			'DORDOR' => -118,
			"<" => 102,
			'PERL' => -118,
			'MY' => -118,
			"%" => 104,
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
			'POWOP' => 106,
			'NOTOP' => -118,
			'FINAL' => -118,
			'OROP' => -118,
			'INCLUDE' => -118,
			"(" => -118,
			'VAR' => -118,
			'ANDAND' => -118,
			'INCOP' => 109,
			'RELOP' => undef,
			'NOT2' => -118,
			";" => -118,
			'FOR' => -118,
			'FLOWLEFT' => -118,
			'ADDOP' => 111,
			"," => -118,
			'FUNC' => -118,
			'UNIT' => -118,
			'RETURN' => -118,
			'INIT' => -118,
			'FUNCTION' => -118,
			'error' => 112,
			'FLOWRIGHT' => -118,
			")" => -118,
			'STR' => -118,
			'CALC' => -118,
			"?" => -118,
			"{" => -118,
			'MULOP' => 115,
			'DOTDOT' => -118,
			'CONST' => -118,
			"=" => -118,
			'USE' => -118,
			'YADAYADA' => -118,
			'OROR' => -118
		},
		GOTOS => {
			'unitspec' => 107
		}
	},
	{#State 171
		ACTIONS => {
			'WORD' => -114,
			'' => -114,
			"}" => -114,
			":" => -114,
			'PACKAGE' => -114,
			'XOROP' => -114,
			"\@" => -114,
			'DORDOR' => -114,
			"<" => 102,
			'PERL' => -114,
			'MY' => -114,
			"%" => 104,
			'ANDOP' => -114,
			"\$^" => -114,
			'UNLESS' => -114,
			'NUM' => -114,
			'STEP' => -114,
			'ASSIGNOP' => -114,
			'IF' => -114,
			"\$" => -114,
			'loopword' => -114,
			'FOREACH' => -114,
			"]" => -114,
			'ACROSS' => -114,
			'POWOP' => 106,
			'NOTOP' => -114,
			'FINAL' => -114,
			'OROP' => -114,
			'INCLUDE' => -114,
			"(" => -114,
			'VAR' => -114,
			'ANDAND' => -114,
			'INCOP' => 109,
			'RELOP' => -114,
			'NOT2' => -114,
			";" => -114,
			'FOR' => -114,
			'FLOWLEFT' => -114,
			'ADDOP' => -114,
			"," => -114,
			'FUNC' => -114,
			'UNIT' => -114,
			'RETURN' => -114,
			'INIT' => -114,
			'FUNCTION' => -114,
			'error' => 112,
			'FLOWRIGHT' => -114,
			")" => -114,
			'STR' => -114,
			'CALC' => -114,
			"?" => -114,
			"{" => -114,
			'MULOP' => 115,
			'DOTDOT' => -114,
			'CONST' => -114,
			"=" => -114,
			'USE' => -114,
			'YADAYADA' => -114,
			'OROR' => -114
		},
		GOTOS => {
			'unitspec' => 107
		}
	},
	{#State 172
		DEFAULT => -29
	},
	{#State 173
		ACTIONS => {
			":" => 220,
			'DORDOR' => 103,
			"<" => 102,
			'ADDOP' => 111,
			"%" => 104,
			'ASSIGNOP' => 105,
			'error' => 112,
			'POWOP' => 106,
			"?" => 113,
			'DOTDOT' => 114,
			'MULOP' => 115,
			"=" => 116,
			'ANDAND' => 108,
			'OROR' => 117,
			'INCOP' => 109,
			'RELOP' => 110
		},
		GOTOS => {
			'unitspec' => 107
		}
	},
	{#State 174
		ACTIONS => {
			'WORD' => -119,
			'' => -119,
			"}" => -119,
			":" => -119,
			'PACKAGE' => -119,
			'XOROP' => -119,
			"\@" => -119,
			'DORDOR' => 103,
			"<" => 102,
			'PERL' => -119,
			'MY' => -119,
			"%" => 104,
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
			'POWOP' => 106,
			'NOTOP' => -119,
			'FINAL' => -119,
			'OROP' => -119,
			'INCLUDE' => -119,
			"(" => -119,
			'VAR' => -119,
			'ANDAND' => 108,
			'INCOP' => 109,
			'RELOP' => 110,
			'NOT2' => -119,
			";" => -119,
			'FOR' => -119,
			'FLOWLEFT' => -119,
			'ADDOP' => 111,
			"," => -119,
			'FUNC' => -119,
			'UNIT' => -119,
			'RETURN' => -119,
			'INIT' => -119,
			'FUNCTION' => -119,
			'error' => 112,
			'FLOWRIGHT' => -119,
			")" => -119,
			'STR' => -119,
			'CALC' => -119,
			"?" => -119,
			"{" => -119,
			'MULOP' => 115,
			'DOTDOT' => undef,
			'CONST' => -119,
			"=" => -119,
			'USE' => -119,
			'YADAYADA' => -119,
			'OROR' => 117
		},
		GOTOS => {
			'unitspec' => 107
		}
	},
	{#State 175
		ACTIONS => {
			'WORD' => -115,
			'' => -115,
			"}" => -115,
			":" => -115,
			'PACKAGE' => -115,
			'XOROP' => -115,
			"\@" => -115,
			'DORDOR' => -115,
			"<" => 102,
			'PERL' => -115,
			'MY' => -115,
			"%" => -115,
			'ANDOP' => -115,
			"\$^" => -115,
			'UNLESS' => -115,
			'NUM' => -115,
			'STEP' => -115,
			'ASSIGNOP' => -115,
			'IF' => -115,
			"\$" => -115,
			'loopword' => -115,
			'FOREACH' => -115,
			"]" => -115,
			'ACROSS' => -115,
			'POWOP' => 106,
			'NOTOP' => -115,
			'FINAL' => -115,
			'OROP' => -115,
			'INCLUDE' => -115,
			"(" => -115,
			'VAR' => -115,
			'ANDAND' => -115,
			'INCOP' => 109,
			'RELOP' => -115,
			'NOT2' => -115,
			";" => -115,
			'FOR' => -115,
			'FLOWLEFT' => -115,
			'ADDOP' => -115,
			"," => -115,
			'FUNC' => -115,
			'UNIT' => -115,
			'RETURN' => -115,
			'INIT' => -115,
			'FUNCTION' => -115,
			'error' => 112,
			'FLOWRIGHT' => -115,
			")" => -115,
			'STR' => -115,
			'CALC' => -115,
			"?" => -115,
			"{" => -115,
			'MULOP' => -115,
			'DOTDOT' => -115,
			'CONST' => -115,
			"=" => -115,
			'USE' => -115,
			'YADAYADA' => -115,
			'OROR' => -115
		},
		GOTOS => {
			'unitspec' => 107
		}
	},
	{#State 176
		ACTIONS => {
			'WORD' => -113,
			'' => -113,
			"}" => -113,
			":" => -113,
			'PACKAGE' => -113,
			'XOROP' => -113,
			"\@" => -113,
			'DORDOR' => 103,
			"<" => 102,
			'PERL' => -113,
			'MY' => -113,
			"%" => 104,
			'ANDOP' => -113,
			"\$^" => -113,
			'UNLESS' => -113,
			'NUM' => -113,
			'STEP' => -113,
			'ASSIGNOP' => 105,
			'IF' => -113,
			"\$" => -113,
			'loopword' => -113,
			'FOREACH' => -113,
			"]" => -113,
			'ACROSS' => -113,
			'POWOP' => 106,
			'NOTOP' => -113,
			'FINAL' => -113,
			'OROP' => -113,
			'INCLUDE' => -113,
			"(" => -113,
			'VAR' => -113,
			'ANDAND' => 108,
			'INCOP' => 109,
			'RELOP' => 110,
			'NOT2' => -113,
			";" => -113,
			'FOR' => -113,
			'FLOWLEFT' => -113,
			'ADDOP' => 111,
			"," => -113,
			'FUNC' => -113,
			'UNIT' => -113,
			'RETURN' => -113,
			'INIT' => -113,
			'FUNCTION' => -113,
			'error' => 112,
			'FLOWRIGHT' => -113,
			")" => -113,
			'STR' => -113,
			'CALC' => -113,
			"?" => 113,
			"{" => -113,
			'MULOP' => 115,
			'DOTDOT' => 114,
			'CONST' => -113,
			"=" => 116,
			'USE' => -113,
			'YADAYADA' => -113,
			'OROR' => 117
		},
		GOTOS => {
			'unitspec' => 107
		}
	},
	{#State 177
		ACTIONS => {
			'WORD' => -121,
			'' => -121,
			"}" => -121,
			":" => -121,
			'PACKAGE' => -121,
			'XOROP' => -121,
			"\@" => -121,
			'DORDOR' => -121,
			"<" => 102,
			'PERL' => -121,
			'MY' => -121,
			"%" => 104,
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
			'POWOP' => 106,
			'NOTOP' => -121,
			'FINAL' => -121,
			'OROP' => -121,
			'INCLUDE' => -121,
			"(" => -121,
			'VAR' => -121,
			'ANDAND' => 108,
			'INCOP' => 109,
			'RELOP' => 110,
			'NOT2' => -121,
			";" => -121,
			'FOR' => -121,
			'FLOWLEFT' => -121,
			'ADDOP' => 111,
			"," => -121,
			'FUNC' => -121,
			'UNIT' => -121,
			'RETURN' => -121,
			'INIT' => -121,
			'FUNCTION' => -121,
			'error' => 112,
			'FLOWRIGHT' => -121,
			")" => -121,
			'STR' => -121,
			'CALC' => -121,
			"?" => -121,
			"{" => -121,
			'MULOP' => 115,
			'DOTDOT' => -121,
			'CONST' => -121,
			"=" => -121,
			'USE' => -121,
			'YADAYADA' => -121,
			'OROR' => -121
		},
		GOTOS => {
			'unitspec' => 107
		}
	},
	{#State 178
		DEFAULT => -18
	},
	{#State 179
		ACTIONS => {
			'WORD' => 221
		}
	},
	{#State 180
		ACTIONS => {
			'WORD' => -95,
			'' => -95,
			"}" => -95,
			":" => -95,
			'PACKAGE' => -95,
			"\@" => -95,
			"<" => -95,
			'DORDOR' => -95,
			'XOROP' => -95,
			'PERL' => -95,
			'MY' => -95,
			"%" => -95,
			'ANDOP' => 121,
			"\$^" => -95,
			'UNLESS' => -95,
			'NUM' => -95,
			'STEP' => -95,
			'ASSIGNOP' => -95,
			'IF' => -95,
			"\$" => -95,
			'loopword' => -95,
			'FOREACH' => -95,
			"]" => -95,
			'POWOP' => -95,
			'ACROSS' => -95,
			'NOTOP' => -95,
			'FINAL' => -95,
			'OROP' => -95,
			'INCLUDE' => -95,
			"(" => -95,
			'VAR' => -95,
			'ANDAND' => -95,
			'INCOP' => -95,
			'RELOP' => -95,
			'NOT2' => -95,
			";" => -95,
			'FOR' => -95,
			'FLOWLEFT' => -95,
			'ADDOP' => -95,
			"," => -95,
			'FUNC' => -95,
			'UNIT' => -95,
			'RETURN' => -95,
			'INIT' => -95,
			'FUNCTION' => -95,
			'error' => -95,
			'FLOWRIGHT' => -95,
			")" => -95,
			'STR' => -95,
			'CALC' => -95,
			"?" => -95,
			'DOTDOT' => -95,
			'MULOP' => -95,
			"{" => -95,
			'CONST' => -95,
			"=" => -95,
			'USE' => -95,
			'YADAYADA' => -95,
			'OROR' => -95
		}
	},
	{#State 181
		ACTIONS => {
			'WORD' => -93,
			'' => -93,
			"}" => -93,
			":" => -93,
			'PACKAGE' => -93,
			"\@" => -93,
			"<" => -93,
			'DORDOR' => -93,
			'XOROP' => -93,
			'PERL' => -93,
			'MY' => -93,
			"%" => -93,
			'ANDOP' => -93,
			"\$^" => -93,
			'UNLESS' => -93,
			'NUM' => -93,
			'STEP' => -93,
			'ASSIGNOP' => -93,
			'IF' => -93,
			"\$" => -93,
			'loopword' => -93,
			'FOREACH' => -93,
			"]" => -93,
			'POWOP' => -93,
			'ACROSS' => -93,
			'NOTOP' => -93,
			'FINAL' => -93,
			'OROP' => -93,
			'INCLUDE' => -93,
			"(" => -93,
			'VAR' => -93,
			'ANDAND' => -93,
			'INCOP' => -93,
			'RELOP' => -93,
			'NOT2' => -93,
			";" => -93,
			'FOR' => -93,
			'FLOWLEFT' => -93,
			'ADDOP' => -93,
			"," => -93,
			'FUNC' => -93,
			'UNIT' => -93,
			'RETURN' => -93,
			'INIT' => -93,
			'FUNCTION' => -93,
			'error' => -93,
			'FLOWRIGHT' => -93,
			")" => -93,
			'STR' => -93,
			'CALC' => -93,
			"?" => -93,
			'DOTDOT' => -93,
			'MULOP' => -93,
			"{" => -93,
			'CONST' => -93,
			"=" => -93,
			'USE' => -93,
			'YADAYADA' => -93,
			'OROR' => -93
		}
	},
	{#State 182
		ACTIONS => {
			'XOROP' => 120,
			";" => -60,
			'OROP' => 124,
			'ANDOP' => 121
		}
	},
	{#State 183
		ACTIONS => {
			'XOROP' => 120,
			";" => -59,
			'OROP' => 124,
			'ANDOP' => 121
		}
	},
	{#State 184
		ACTIONS => {
			'WORD' => -94,
			'' => -94,
			"}" => -94,
			":" => -94,
			'PACKAGE' => -94,
			"\@" => -94,
			"<" => -94,
			'DORDOR' => -94,
			'XOROP' => -94,
			'PERL' => -94,
			'MY' => -94,
			"%" => -94,
			'ANDOP' => 121,
			"\$^" => -94,
			'UNLESS' => -94,
			'NUM' => -94,
			'STEP' => -94,
			'ASSIGNOP' => -94,
			'IF' => -94,
			"\$" => -94,
			'loopword' => -94,
			'FOREACH' => -94,
			"]" => -94,
			'POWOP' => -94,
			'ACROSS' => -94,
			'NOTOP' => -94,
			'FINAL' => -94,
			'OROP' => -94,
			'INCLUDE' => -94,
			"(" => -94,
			'VAR' => -94,
			'ANDAND' => -94,
			'INCOP' => -94,
			'RELOP' => -94,
			'NOT2' => -94,
			";" => -94,
			'FOR' => -94,
			'FLOWLEFT' => -94,
			'ADDOP' => -94,
			"," => -94,
			'FUNC' => -94,
			'UNIT' => -94,
			'RETURN' => -94,
			'INIT' => -94,
			'FUNCTION' => -94,
			'error' => -94,
			'FLOWRIGHT' => -94,
			")" => -94,
			'STR' => -94,
			'CALC' => -94,
			"?" => -94,
			'DOTDOT' => -94,
			'MULOP' => -94,
			"{" => -94,
			'CONST' => -94,
			"=" => -94,
			'USE' => -94,
			'YADAYADA' => -94,
			'OROR' => -94
		}
	},
	{#State 185
		DEFAULT => -143
	},
	{#State 186
		ACTIONS => {
			"{" => 223,
			"[" => 153
		},
		GOTOS => {
			'dimspec' => 222
		}
	},
	{#State 187
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
			'progseq' => 224
		}
	},
	{#State 188
		ACTIONS => {
			"\$" => 27,
			")" => -21
		},
		GOTOS => {
			'params' => 227,
			'scalar' => 225,
			'paramlist' => 228,
			'param' => 226
		}
	},
	{#State 189
		ACTIONS => {
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			'NOTOP' => 35,
			'STR' => 59,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 50,
			'array' => 51,
			'varexpr' => 66,
			'expr' => 229,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'set' => 58,
			'termunop' => 33
		}
	},
	{#State 190
		DEFAULT => -56,
		GOTOS => {
			'@55-3' => 230
		}
	},
	{#State 191
		DEFAULT => -129
	},
	{#State 192
		ACTIONS => {
			"(" => 231
		}
	},
	{#State 193
		DEFAULT => -17
	},
	{#State 194
		DEFAULT => -151
	},
	{#State 195
		ACTIONS => {
			'XOROP' => 120,
			'OROP' => 124,
			"]" => 232,
			'ANDOP' => 121
		}
	},
	{#State 196
		DEFAULT => -150
	},
	{#State 197
		ACTIONS => {
			'PERLPART' => 234,
			"%}" => 233
		}
	},
	{#State 198
		DEFAULT => -40,
		GOTOS => {
			'tl_perlseq' => 235
		}
	},
	{#State 199
		ACTIONS => {
			'FLOWLEFT' => 236,
			'FLOWRIGHT' => 237
		}
	},
	{#State 200
		ACTIONS => {
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			'NOTOP' => 35,
			'STR' => 59,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 50,
			'array' => 51,
			'varexpr' => 66,
			'expr' => 238,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'set' => 58,
			'termunop' => 33
		}
	},
	{#State 201
		ACTIONS => {
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			'NOTOP' => 35,
			'STR' => 59,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 50,
			'array' => 51,
			'varexpr' => 66,
			'expr' => 239,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'set' => 58,
			'termunop' => 33
		}
	},
	{#State 202
		ACTIONS => {
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			'NOTOP' => 35,
			'STR' => 59,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 50,
			'array' => 51,
			'varexpr' => 66,
			'expr' => 240,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'set' => 58,
			'termunop' => 33
		}
	},
	{#State 203
		ACTIONS => {
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			'NOTOP' => 35,
			'STR' => 59,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 50,
			'array' => 51,
			'varexpr' => 66,
			'expr' => 241,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'set' => 58,
			'termunop' => 33
		}
	},
	{#State 204
		ACTIONS => {
			"\$" => 27
		},
		GOTOS => {
			'scalar' => 242
		}
	},
	{#State 205
		ACTIONS => {
			"\$" => 27
		},
		GOTOS => {
			'scalar' => 243
		}
	},
	{#State 206
		DEFAULT => -42
	},
	{#State 207
		ACTIONS => {
			"\$" => 27,
			")" => -21
		},
		GOTOS => {
			'params' => 244,
			'scalar' => 225,
			'paramlist' => 228,
			'param' => 226
		}
	},
	{#State 208
		ACTIONS => {
			'XOROP' => 120,
			'OROP' => 124,
			")" => 245,
			'ANDOP' => 121
		}
	},
	{#State 209
		DEFAULT => -136
	},
	{#State 210
		ACTIONS => {
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			'NOTOP' => 35,
			'STR' => 59,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 50,
			'array' => 51,
			'varexpr' => 66,
			'expr' => 246,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'set' => 58,
			'termunop' => 33
		}
	},
	{#State 211
		ACTIONS => {
			":" => 247
		}
	},
	{#State 212
		ACTIONS => {
			"\@" => 16,
			"%" => 21
		},
		GOTOS => {
			'array' => 248,
			'set' => 249
		}
	},
	{#State 213
		DEFAULT => -92
	},
	{#State 214
		ACTIONS => {
			'XOROP' => 120,
			";" => 250,
			'OROP' => 124,
			'ANDOP' => 121
		}
	},
	{#State 215
		ACTIONS => {
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			'NOTOP' => 35,
			'STR' => 59,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 50,
			'array' => 51,
			'varexpr' => 66,
			'expr' => 251,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'set' => 58,
			'termunop' => 33
		}
	},
	{#State 216
		ACTIONS => {
			'STR' => 59,
			'WORD' => 158,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			"(" => 39,
			'YADAYADA' => 69,
			'RETURN' => 55,
			"\$" => 27,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'arg' => 252,
			'funcall' => 61,
			'term' => 161,
			'array' => 51,
			'varexpr' => 66,
			'pair' => 160,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'set' => 58,
			'termunop' => 33
		}
	},
	{#State 217
		ACTIONS => {
			'WORD' => -153,
			'' => -153,
			"}" => -153,
			":" => -153,
			'PACKAGE' => -153,
			'XOROP' => -153,
			"\@" => -153,
			"<" => -153,
			'DORDOR' => -153,
			'PERL' => -153,
			'MY' => -153,
			"%" => -153,
			'ANDOP' => -153,
			"\$^" => -153,
			'UNLESS' => -153,
			'NUM' => -153,
			'STEP' => -153,
			'ASSIGNOP' => -153,
			'IF' => -153,
			"\$" => -153,
			'loopword' => -153,
			'FOREACH' => -153,
			"]" => -153,
			'POWOP' => -153,
			'ACROSS' => -153,
			'NOTOP' => -153,
			'FINAL' => -153,
			'DOT' => 253,
			'OROP' => -153,
			'INCLUDE' => -153,
			"(" => -153,
			'VAR' => -153,
			'ANDAND' => -153,
			'INCOP' => -153,
			'RELOP' => -153,
			'NOT2' => -153,
			";" => -153,
			'FOR' => -153,
			'FLOWLEFT' => -153,
			'ADDOP' => -153,
			"," => -153,
			'FUNC' => -153,
			'UNIT' => -153,
			'RETURN' => -153,
			'INIT' => -153,
			'FUNCTION' => -153,
			'error' => -153,
			'FLOWRIGHT' => -153,
			")" => -153,
			'STR' => -153,
			'CALC' => -153,
			"?" => -153,
			'DOTDOT' => -153,
			'MULOP' => -153,
			"{" => -153,
			'CONST' => -153,
			"=" => -153,
			'USE' => -153,
			'YADAYADA' => -153,
			'OROR' => -153
		}
	},
	{#State 218
		DEFAULT => -28
	},
	{#State 219
		DEFAULT => -31
	},
	{#State 220
		ACTIONS => {
			'STR' => 59,
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			"(" => 39,
			'YADAYADA' => 69,
			'RETURN' => 55,
			"\$" => 27,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 254,
			'array' => 51,
			'varexpr' => 66,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'termunop' => 33,
			'set' => 58
		}
	},
	{#State 221
		DEFAULT => -20
	},
	{#State 222
		DEFAULT => -144
	},
	{#State 223
		DEFAULT => -33,
		GOTOS => {
			'@32-4' => 255
		}
	},
	{#State 224
		ACTIONS => {
			'WORD' => 13,
			"}" => 256,
			'PACKAGE' => 18,
			"\@" => 16,
			'PERL' => 19,
			'MY' => 22,
			"%" => 21,
			"\$^" => 23,
			'UNLESS' => 24,
			'NUM' => 26,
			'STEP' => 8,
			"\$" => 27,
			'IF' => 28,
			'loopword' => 30,
			'FOREACH' => 32,
			'ACROSS' => -44,
			'NOTOP' => 35,
			'FINAL' => 7,
			'INCLUDE' => 38,
			"(" => 39,
			'VAR' => 40,
			'INCOP' => 41,
			'NOT2' => 42,
			'FOR' => 45,
			'ADDOP' => 46,
			'FUNC' => 49,
			'UNIT' => 52,
			'RETURN' => 55,
			'INIT' => 11,
			'FUNCTION' => 57,
			'STR' => 59,
			'CALC' => 9,
			"{" => -44,
			'CONST' => 63,
			'USE' => 67,
			'YADAYADA' => 69
		},
		GOTOS => {
			'phaseword' => 15,
			'scalar' => 14,
			'function' => 43,
			'sideff' => 44,
			'objname' => 17,
			'include' => 48,
			'tl_across' => 20,
			'tl_block' => 47,
			'term' => 50,
			'loop' => 25,
			'array' => 51,
			'expr' => 54,
			'use' => 53,
			'phase' => 56,
			'termbinop' => 29,
			'flow' => 31,
			'set' => 58,
			'termunop' => 33,
			'line' => 34,
			'cond' => 36,
			'dynvar' => 37,
			'condword' => 60,
			'funcall' => 61,
			'tl_line' => 62,
			'tl_decl' => 64,
			'package' => 65,
			'unit' => 68,
			'varexpr' => 66,
			'indexvar' => 70,
			'simplevar' => 71
		}
	},
	{#State 225
		DEFAULT => -25
	},
	{#State 226
		DEFAULT => -23
	},
	{#State 227
		ACTIONS => {
			")" => 257
		}
	},
	{#State 228
		ACTIONS => {
			"," => 258,
			")" => -22
		}
	},
	{#State 229
		ACTIONS => {
			'XOROP' => 120,
			'OROP' => 124,
			")" => 259,
			'ANDOP' => 121
		}
	},
	{#State 230
		ACTIONS => {
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			'STR' => 59,
			'NOTOP' => 35,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 50,
			'array' => 51,
			'varexpr' => 66,
			'expr' => 260,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'termunop' => 33,
			'set' => 58
		}
	},
	{#State 231
		ACTIONS => {
			'WORD' => 158,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			"," => -156,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			")" => -156,
			'STR' => 59,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'objname' => 17,
			'arg' => 159,
			'term' => 161,
			'array' => 51,
			'pair' => 160,
			'termbinop' => 29,
			'termunop' => 33,
			'set' => 58,
			'dynvar' => 37,
			'funcall' => 61,
			'arglist' => 162,
			'varexpr' => 66,
			'argexpr' => 261,
			'indexvar' => 70,
			'simplevar' => 71
		}
	},
	{#State 232
		DEFAULT => -152
	},
	{#State 233
		DEFAULT => -38
	},
	{#State 234
		DEFAULT => -41
	},
	{#State 235
		ACTIONS => {
			"}" => 262,
			'PERLPART' => 234
		}
	},
	{#State 236
		ACTIONS => {
			"\$" => 27
		},
		GOTOS => {
			'scalar' => 263
		}
	},
	{#State 237
		ACTIONS => {
			"\$" => 27
		},
		GOTOS => {
			'scalar' => 264
		}
	},
	{#State 238
		ACTIONS => {
			'XOROP' => 120,
			'OROP' => 124,
			")" => 265,
			'ANDOP' => 121
		}
	},
	{#State 239
		ACTIONS => {
			'WORD' => -166,
			'' => -166,
			"}" => -166,
			'PACKAGE' => -166,
			"\@" => -166,
			'XOROP' => 120,
			'PERL' => -166,
			'MY' => -166,
			"%" => -166,
			'ANDOP' => 121,
			"\$^" => -166,
			'UNLESS' => -166,
			'NUM' => -166,
			'STEP' => -166,
			'IF' => -166,
			"\$" => -166,
			'loopword' => -166,
			'FOREACH' => -166,
			'ACROSS' => -166,
			'NOTOP' => -166,
			'FINAL' => -166,
			'OROP' => 124,
			'INCLUDE' => -166,
			"(" => -166,
			'VAR' => -166,
			'INCOP' => -166,
			'NOT2' => -166,
			'FOR' => -166,
			'ADDOP' => -166,
			'FUNC' => -166,
			'UNIT' => -166,
			'RETURN' => -166,
			'INIT' => -166,
			'FUNCTION' => -166,
			'STR' => -166,
			'CALC' => -166,
			"{" => -166,
			'CONST' => -166,
			'USE' => -166,
			'YADAYADA' => -166
		}
	},
	{#State 240
		ACTIONS => {
			'XOROP' => 120,
			'OROP' => 124,
			")" => 266,
			'ANDOP' => 121
		}
	},
	{#State 241
		ACTIONS => {
			'WORD' => -165,
			'' => -165,
			"}" => -165,
			'PACKAGE' => -165,
			"\@" => -165,
			'XOROP' => 120,
			'PERL' => -165,
			'MY' => -165,
			"%" => -165,
			'ANDOP' => 121,
			"\$^" => -165,
			'UNLESS' => -165,
			'NUM' => -165,
			'STEP' => -165,
			'IF' => -165,
			"\$" => -165,
			'loopword' => -165,
			'FOREACH' => -165,
			'ACROSS' => -165,
			'NOTOP' => -165,
			'FINAL' => -165,
			'OROP' => 124,
			'INCLUDE' => -165,
			"(" => -165,
			'VAR' => -165,
			'INCOP' => -165,
			'NOT2' => -165,
			'FOR' => -165,
			'ADDOP' => -165,
			'FUNC' => -165,
			'UNIT' => -165,
			'RETURN' => -165,
			'INIT' => -165,
			'FUNCTION' => -165,
			'STR' => -165,
			'CALC' => -165,
			"{" => -165,
			'CONST' => -165,
			'USE' => -165,
			'YADAYADA' => -165
		}
	},
	{#State 242
		DEFAULT => -164
	},
	{#State 243
		DEFAULT => -163
	},
	{#State 244
		ACTIONS => {
			")" => 267
		}
	},
	{#State 245
		ACTIONS => {
			"{" => 268
		}
	},
	{#State 246
		ACTIONS => {
			'XOROP' => 120,
			'OROP' => 124,
			")" => 269,
			'ANDOP' => 121
		}
	},
	{#State 247
		DEFAULT => -148
	},
	{#State 248
		ACTIONS => {
			"]" => 270
		}
	},
	{#State 249
		ACTIONS => {
			"]" => 271
		}
	},
	{#State 250
		ACTIONS => {
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			'STR' => 59,
			'NOTOP' => 35,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 50,
			'array' => 51,
			'varexpr' => 66,
			'expr' => 272,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'termunop' => 33,
			'set' => 58
		}
	},
	{#State 251
		ACTIONS => {
			'XOROP' => 120,
			'OROP' => 124,
			"," => -162,
			")" => -162,
			'ANDOP' => 121
		}
	},
	{#State 252
		DEFAULT => -159
	},
	{#State 253
		ACTIONS => {
			'WORD' => 273
		}
	},
	{#State 254
		ACTIONS => {
			'WORD' => -100,
			'' => -100,
			"}" => -100,
			":" => -100,
			'PACKAGE' => -100,
			'XOROP' => -100,
			"\@" => -100,
			'DORDOR' => 103,
			"<" => 102,
			'PERL' => -100,
			'MY' => -100,
			"%" => 104,
			'ANDOP' => -100,
			"\$^" => -100,
			'UNLESS' => -100,
			'NUM' => -100,
			'STEP' => -100,
			'ASSIGNOP' => -100,
			'IF' => -100,
			"\$" => -100,
			'loopword' => -100,
			'FOREACH' => -100,
			"]" => -100,
			'ACROSS' => -100,
			'POWOP' => 106,
			'NOTOP' => -100,
			'FINAL' => -100,
			'OROP' => -100,
			'INCLUDE' => -100,
			"(" => -100,
			'VAR' => -100,
			'ANDAND' => 108,
			'RELOP' => 110,
			'INCOP' => 109,
			'NOT2' => -100,
			";" => -100,
			'FOR' => -100,
			'FLOWLEFT' => -100,
			'ADDOP' => 111,
			"," => -100,
			'FUNC' => -100,
			'UNIT' => -100,
			'RETURN' => -100,
			'INIT' => -100,
			'FUNCTION' => -100,
			'error' => 112,
			'FLOWRIGHT' => -100,
			")" => -100,
			'STR' => -100,
			'CALC' => -100,
			"?" => 113,
			"{" => -100,
			'DOTDOT' => 114,
			'MULOP' => 115,
			'CONST' => -100,
			"=" => -100,
			'USE' => -100,
			'YADAYADA' => -100,
			'OROR' => 117
		},
		GOTOS => {
			'unitspec' => 107
		}
	},
	{#State 255
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
			'progseq' => 274
		}
	},
	{#State 256
		DEFAULT => -34
	},
	{#State 257
		ACTIONS => {
			"<" => 102,
			";" => -26,
			"{" => -26,
			'error' => 112
		},
		GOTOS => {
			'unitspec' => 156,
			'unitopt' => 275
		}
	},
	{#State 258
		ACTIONS => {
			"\$" => 27
		},
		GOTOS => {
			'scalar' => 225,
			'param' => 276
		}
	},
	{#State 259
		ACTIONS => {
			"{" => 277
		}
	},
	{#State 260
		ACTIONS => {
			'XOROP' => 120,
			";" => 278,
			'OROP' => 124,
			'ANDOP' => 121
		}
	},
	{#State 261
		ACTIONS => {
			"," => 216,
			")" => 279
		}
	},
	{#State 262
		DEFAULT => -36
	},
	{#State 263
		DEFAULT => -168
	},
	{#State 264
		DEFAULT => -167
	},
	{#State 265
		DEFAULT => -170
	},
	{#State 266
		DEFAULT => -169
	},
	{#State 267
		ACTIONS => {
			"<" => 102,
			";" => -26,
			"{" => -26,
			'error' => 112
		},
		GOTOS => {
			'unitspec' => 156,
			'unitopt' => 280
		}
	},
	{#State 268
		DEFAULT => -76,
		GOTOS => {
			'stmtseq' => 281
		}
	},
	{#State 269
		ACTIONS => {
			"{" => 282
		}
	},
	{#State 270
		DEFAULT => -145
	},
	{#State 271
		DEFAULT => -146
	},
	{#State 272
		ACTIONS => {
			'XOROP' => 120,
			";" => 283,
			'OROP' => 124,
			'ANDOP' => 121
		}
	},
	{#State 273
		DEFAULT => -154
	},
	{#State 274
		ACTIONS => {
			'WORD' => 13,
			"}" => 284,
			'PACKAGE' => 18,
			"\@" => 16,
			'PERL' => 19,
			'MY' => 22,
			"%" => 21,
			"\$^" => 23,
			'UNLESS' => 24,
			'NUM' => 26,
			'STEP' => 8,
			'IF' => 28,
			"\$" => 27,
			'loopword' => 30,
			'FOREACH' => 32,
			'ACROSS' => -44,
			'NOTOP' => 35,
			'FINAL' => 7,
			'INCLUDE' => 38,
			"(" => 39,
			'VAR' => 40,
			'INCOP' => 41,
			'NOT2' => 42,
			'FOR' => 45,
			'ADDOP' => 46,
			'FUNC' => 49,
			'UNIT' => 52,
			'RETURN' => 55,
			'INIT' => 11,
			'FUNCTION' => 57,
			'STR' => 59,
			'CALC' => 9,
			"{" => -44,
			'CONST' => 63,
			'USE' => 67,
			'YADAYADA' => 69
		},
		GOTOS => {
			'phaseword' => 15,
			'scalar' => 14,
			'function' => 43,
			'sideff' => 44,
			'objname' => 17,
			'include' => 48,
			'tl_across' => 20,
			'tl_block' => 47,
			'term' => 50,
			'loop' => 25,
			'array' => 51,
			'use' => 53,
			'expr' => 54,
			'phase' => 56,
			'termbinop' => 29,
			'flow' => 31,
			'set' => 58,
			'termunop' => 33,
			'line' => 34,
			'cond' => 36,
			'dynvar' => 37,
			'condword' => 60,
			'funcall' => 61,
			'tl_line' => 62,
			'tl_decl' => 64,
			'package' => 65,
			'unit' => 68,
			'varexpr' => 66,
			'indexvar' => 70,
			'simplevar' => 71
		}
	},
	{#State 275
		ACTIONS => {
			";" => 286,
			"{" => 285
		}
	},
	{#State 276
		DEFAULT => -24
	},
	{#State 277
		DEFAULT => -76,
		GOTOS => {
			'stmtseq' => 287
		}
	},
	{#State 278
		DEFAULT => -55
	},
	{#State 279
		DEFAULT => -130
	},
	{#State 280
		ACTIONS => {
			";" => 289,
			"{" => 288
		}
	},
	{#State 281
		ACTIONS => {
			"%{" => 294,
			'WORD' => 13,
			"}" => 290,
			'NOT2' => 42,
			'PACKAGE' => 18,
			"\@" => 16,
			'FOR' => 45,
			'PERL' => 295,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'UNLESS' => 24,
			'NUM' => 26,
			'RETURN' => 55,
			'IF' => 28,
			"\$" => 27,
			'loopword' => 30,
			'FOREACH' => 32,
			'ACROSS' => 291,
			'NOTOP' => 35,
			'STR' => 59,
			"{" => 293,
			'CONST' => 63,
			"(" => 39,
			'YADAYADA' => 69,
			'VAR' => 40,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'sideff' => 44,
			'objname' => 17,
			'term' => 50,
			'loop' => 25,
			'array' => 51,
			'expr' => 54,
			'termbinop' => 29,
			'set' => 58,
			'termunop' => 33,
			'line' => 292,
			'cond' => 36,
			'dynvar' => 37,
			'perlblock' => 296,
			'condword' => 60,
			'funcall' => 61,
			'across' => 297,
			'package' => 65,
			'varexpr' => 66,
			'block' => 298,
			'indexvar' => 70,
			'simplevar' => 71
		}
	},
	{#State 282
		DEFAULT => -76,
		GOTOS => {
			'stmtseq' => 299
		}
	},
	{#State 283
		ACTIONS => {
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			'STR' => 59,
			'NOTOP' => 35,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 50,
			'array' => 51,
			'varexpr' => 66,
			'expr' => 300,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'termunop' => 33,
			'set' => 58
		}
	},
	{#State 284
		DEFAULT => -32
	},
	{#State 285
		DEFAULT => -173,
		GOTOS => {
			'@172-7' => 301
		}
	},
	{#State 286
		DEFAULT => -171
	},
	{#State 287
		ACTIONS => {
			"%{" => 294,
			'WORD' => 13,
			"}" => 302,
			'NOT2' => 42,
			'PACKAGE' => 18,
			"\@" => 16,
			'FOR' => 45,
			'PERL' => 295,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'UNLESS' => 24,
			'NUM' => 26,
			'RETURN' => 55,
			'IF' => 28,
			"\$" => 27,
			'loopword' => 30,
			'FOREACH' => 32,
			'ACROSS' => 291,
			'NOTOP' => 35,
			'STR' => 59,
			"{" => 293,
			'CONST' => 63,
			"(" => 39,
			'YADAYADA' => 69,
			'VAR' => 40,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'sideff' => 44,
			'objname' => 17,
			'term' => 50,
			'loop' => 25,
			'array' => 51,
			'expr' => 54,
			'termbinop' => 29,
			'set' => 58,
			'termunop' => 33,
			'line' => 292,
			'cond' => 36,
			'dynvar' => 37,
			'perlblock' => 296,
			'condword' => 60,
			'funcall' => 61,
			'across' => 297,
			'package' => 65,
			'varexpr' => 66,
			'block' => 298,
			'indexvar' => 70,
			'simplevar' => 71
		}
	},
	{#State 288
		DEFAULT => -176,
		GOTOS => {
			'@175-8' => 303
		}
	},
	{#State 289
		DEFAULT => -174
	},
	{#State 290
		DEFAULT => -70
	},
	{#State 291
		ACTIONS => {
			"[" => 153
		},
		GOTOS => {
			'dimlist' => 304,
			'dimspec' => 185
		}
	},
	{#State 292
		DEFAULT => -80
	},
	{#State 293
		DEFAULT => -84,
		GOTOS => {
			'@83-1' => 305
		}
	},
	{#State 294
		DEFAULT => -88,
		GOTOS => {
			'@87-1' => 306
		}
	},
	{#State 295
		ACTIONS => {
			"{" => 307
		}
	},
	{#State 296
		DEFAULT => -79
	},
	{#State 297
		DEFAULT => -77
	},
	{#State 298
		DEFAULT => -78
	},
	{#State 299
		ACTIONS => {
			"%{" => 294,
			'WORD' => 13,
			"}" => 308,
			'NOT2' => 42,
			'PACKAGE' => 18,
			"\@" => 16,
			'FOR' => 45,
			'PERL' => 295,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'UNLESS' => 24,
			'NUM' => 26,
			'RETURN' => 55,
			'IF' => 28,
			"\$" => 27,
			'loopword' => 30,
			'FOREACH' => 32,
			'ACROSS' => 291,
			'NOTOP' => 35,
			'STR' => 59,
			"{" => 293,
			'CONST' => 63,
			"(" => 39,
			'YADAYADA' => 69,
			'VAR' => 40,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'sideff' => 44,
			'objname' => 17,
			'term' => 50,
			'loop' => 25,
			'array' => 51,
			'expr' => 54,
			'termbinop' => 29,
			'set' => 58,
			'termunop' => 33,
			'line' => 292,
			'cond' => 36,
			'dynvar' => 37,
			'perlblock' => 296,
			'condword' => 60,
			'funcall' => 61,
			'across' => 297,
			'package' => 65,
			'varexpr' => 66,
			'block' => 298,
			'indexvar' => 70,
			'simplevar' => 71
		}
	},
	{#State 300
		ACTIONS => {
			'XOROP' => 120,
			'OROP' => 124,
			")" => 309,
			'ANDOP' => 121
		}
	},
	{#State 301
		DEFAULT => -76,
		GOTOS => {
			'stmtseq' => 310
		}
	},
	{#State 302
		ACTIONS => {
			"%{" => -65,
			'WORD' => -65,
			'' => -65,
			"}" => -65,
			'PACKAGE' => -65,
			"\@" => -65,
			'PERL' => -65,
			'MY' => -65,
			"%" => -65,
			"\$^" => -65,
			'UNLESS' => -65,
			'NUM' => -65,
			'STEP' => -65,
			'IF' => -65,
			"\$" => -65,
			'loopword' => -65,
			'FOREACH' => -65,
			'ACROSS' => -65,
			'NOTOP' => -65,
			'FINAL' => -65,
			'ELSE' => 311,
			'INCLUDE' => -65,
			"(" => -65,
			'VAR' => -65,
			'INCOP' => -65,
			'NOT2' => -65,
			'FOR' => -65,
			'ADDOP' => -65,
			'FUNC' => -65,
			'UNIT' => -65,
			'RETURN' => -65,
			'INIT' => -65,
			'FUNCTION' => -65,
			'STR' => -65,
			'CALC' => -65,
			'ELSIF' => 313,
			"{" => -65,
			'CONST' => -65,
			'USE' => -65,
			'YADAYADA' => -65
		},
		GOTOS => {
			'else' => 312
		}
	},
	{#State 303
		DEFAULT => -89,
		GOTOS => {
			'perlseq' => 314
		}
	},
	{#State 304
		ACTIONS => {
			"{" => 315,
			"[" => 153
		},
		GOTOS => {
			'dimspec' => 222
		}
	},
	{#State 305
		DEFAULT => -76,
		GOTOS => {
			'stmtseq' => 316
		}
	},
	{#State 306
		DEFAULT => -89,
		GOTOS => {
			'perlseq' => 317
		}
	},
	{#State 307
		DEFAULT => -86,
		GOTOS => {
			'@85-2' => 318
		}
	},
	{#State 308
		DEFAULT => -72
	},
	{#State 309
		ACTIONS => {
			"{" => 319
		}
	},
	{#State 310
		ACTIONS => {
			"%{" => 294,
			'WORD' => 13,
			"}" => 320,
			'NOT2' => 42,
			'PACKAGE' => 18,
			"\@" => 16,
			'FOR' => 45,
			'PERL' => 295,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'UNLESS' => 24,
			'NUM' => 26,
			'RETURN' => 55,
			'IF' => 28,
			"\$" => 27,
			'loopword' => 30,
			'FOREACH' => 32,
			'ACROSS' => 291,
			'NOTOP' => 35,
			'STR' => 59,
			"{" => 293,
			'CONST' => 63,
			"(" => 39,
			'YADAYADA' => 69,
			'VAR' => 40,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'sideff' => 44,
			'objname' => 17,
			'term' => 50,
			'loop' => 25,
			'array' => 51,
			'expr' => 54,
			'termbinop' => 29,
			'set' => 58,
			'termunop' => 33,
			'line' => 292,
			'cond' => 36,
			'dynvar' => 37,
			'perlblock' => 296,
			'condword' => 60,
			'funcall' => 61,
			'across' => 297,
			'package' => 65,
			'varexpr' => 66,
			'block' => 298,
			'indexvar' => 70,
			'simplevar' => 71
		}
	},
	{#State 311
		ACTIONS => {
			"{" => 321
		}
	},
	{#State 312
		DEFAULT => -61
	},
	{#State 313
		ACTIONS => {
			"(" => 322
		}
	},
	{#State 314
		ACTIONS => {
			"}" => 323,
			'PERLPART' => 324
		}
	},
	{#State 315
		DEFAULT => -82,
		GOTOS => {
			'@81-3' => 325
		}
	},
	{#State 316
		ACTIONS => {
			"%{" => 294,
			'WORD' => 13,
			"}" => 326,
			'NOT2' => 42,
			'PACKAGE' => 18,
			"\@" => 16,
			'FOR' => 45,
			'PERL' => 295,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'UNLESS' => 24,
			'NUM' => 26,
			'RETURN' => 55,
			'IF' => 28,
			"\$" => 27,
			'loopword' => 30,
			'FOREACH' => 32,
			'ACROSS' => 291,
			'NOTOP' => 35,
			'STR' => 59,
			"{" => 293,
			'CONST' => 63,
			"(" => 39,
			'YADAYADA' => 69,
			'VAR' => 40,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'sideff' => 44,
			'objname' => 17,
			'term' => 50,
			'loop' => 25,
			'array' => 51,
			'expr' => 54,
			'termbinop' => 29,
			'set' => 58,
			'termunop' => 33,
			'line' => 292,
			'cond' => 36,
			'dynvar' => 37,
			'perlblock' => 296,
			'condword' => 60,
			'funcall' => 61,
			'across' => 297,
			'package' => 65,
			'varexpr' => 66,
			'block' => 298,
			'indexvar' => 70,
			'simplevar' => 71
		}
	},
	{#State 317
		ACTIONS => {
			'PERLPART' => 324,
			"%}" => 327
		}
	},
	{#State 318
		DEFAULT => -89,
		GOTOS => {
			'perlseq' => 328
		}
	},
	{#State 319
		DEFAULT => -76,
		GOTOS => {
			'stmtseq' => 329
		}
	},
	{#State 320
		DEFAULT => -172
	},
	{#State 321
		DEFAULT => -67,
		GOTOS => {
			'@66-2' => 330
		}
	},
	{#State 322
		DEFAULT => -69,
		GOTOS => {
			'@68-2' => 331
		}
	},
	{#State 323
		DEFAULT => -175
	},
	{#State 324
		DEFAULT => -90
	},
	{#State 325
		DEFAULT => -76,
		GOTOS => {
			'stmtseq' => 332
		}
	},
	{#State 326
		DEFAULT => -83
	},
	{#State 327
		DEFAULT => -87
	},
	{#State 328
		ACTIONS => {
			"}" => 333,
			'PERLPART' => 324
		}
	},
	{#State 329
		ACTIONS => {
			"%{" => 294,
			'WORD' => 13,
			"}" => 334,
			'NOT2' => 42,
			'PACKAGE' => 18,
			"\@" => 16,
			'FOR' => 45,
			'PERL' => 295,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'UNLESS' => 24,
			'NUM' => 26,
			'RETURN' => 55,
			'IF' => 28,
			"\$" => 27,
			'loopword' => 30,
			'FOREACH' => 32,
			'ACROSS' => 291,
			'NOTOP' => 35,
			'STR' => 59,
			"{" => 293,
			'CONST' => 63,
			"(" => 39,
			'YADAYADA' => 69,
			'VAR' => 40,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'sideff' => 44,
			'objname' => 17,
			'term' => 50,
			'loop' => 25,
			'array' => 51,
			'expr' => 54,
			'termbinop' => 29,
			'set' => 58,
			'termunop' => 33,
			'line' => 292,
			'cond' => 36,
			'dynvar' => 37,
			'perlblock' => 296,
			'condword' => 60,
			'funcall' => 61,
			'across' => 297,
			'package' => 65,
			'varexpr' => 66,
			'block' => 298,
			'indexvar' => 70,
			'simplevar' => 71
		}
	},
	{#State 330
		DEFAULT => -76,
		GOTOS => {
			'stmtseq' => 335
		}
	},
	{#State 331
		ACTIONS => {
			'WORD' => 13,
			'NOT2' => 42,
			"\@" => 16,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'NUM' => 26,
			'RETURN' => 55,
			"\$" => 27,
			'STR' => 59,
			'NOTOP' => 35,
			"(" => 39,
			'YADAYADA' => 69,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'dynvar' => 37,
			'objname' => 17,
			'funcall' => 61,
			'term' => 50,
			'array' => 51,
			'varexpr' => 66,
			'expr' => 336,
			'termbinop' => 29,
			'indexvar' => 70,
			'simplevar' => 71,
			'termunop' => 33,
			'set' => 58
		}
	},
	{#State 332
		ACTIONS => {
			"%{" => 294,
			'WORD' => 13,
			"}" => 337,
			'NOT2' => 42,
			'PACKAGE' => 18,
			"\@" => 16,
			'FOR' => 45,
			'PERL' => 295,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'UNLESS' => 24,
			'NUM' => 26,
			'RETURN' => 55,
			'IF' => 28,
			"\$" => 27,
			'loopword' => 30,
			'FOREACH' => 32,
			'ACROSS' => 291,
			'NOTOP' => 35,
			'STR' => 59,
			"{" => 293,
			'CONST' => 63,
			"(" => 39,
			'YADAYADA' => 69,
			'VAR' => 40,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'sideff' => 44,
			'objname' => 17,
			'term' => 50,
			'loop' => 25,
			'array' => 51,
			'expr' => 54,
			'termbinop' => 29,
			'set' => 58,
			'termunop' => 33,
			'line' => 292,
			'cond' => 36,
			'dynvar' => 37,
			'perlblock' => 296,
			'condword' => 60,
			'funcall' => 61,
			'across' => 297,
			'package' => 65,
			'varexpr' => 66,
			'block' => 298,
			'indexvar' => 70,
			'simplevar' => 71
		}
	},
	{#State 333
		DEFAULT => -85
	},
	{#State 334
		DEFAULT => -74
	},
	{#State 335
		ACTIONS => {
			"%{" => 294,
			'WORD' => 13,
			"}" => 338,
			'NOT2' => 42,
			'PACKAGE' => 18,
			"\@" => 16,
			'FOR' => 45,
			'PERL' => 295,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'UNLESS' => 24,
			'NUM' => 26,
			'RETURN' => 55,
			'IF' => 28,
			"\$" => 27,
			'loopword' => 30,
			'FOREACH' => 32,
			'ACROSS' => 291,
			'NOTOP' => 35,
			'STR' => 59,
			"{" => 293,
			'CONST' => 63,
			"(" => 39,
			'YADAYADA' => 69,
			'VAR' => 40,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'sideff' => 44,
			'objname' => 17,
			'term' => 50,
			'loop' => 25,
			'array' => 51,
			'expr' => 54,
			'termbinop' => 29,
			'set' => 58,
			'termunop' => 33,
			'line' => 292,
			'cond' => 36,
			'dynvar' => 37,
			'perlblock' => 296,
			'condword' => 60,
			'funcall' => 61,
			'across' => 297,
			'package' => 65,
			'varexpr' => 66,
			'block' => 298,
			'indexvar' => 70,
			'simplevar' => 71
		}
	},
	{#State 336
		ACTIONS => {
			'XOROP' => 120,
			'OROP' => 124,
			")" => 339,
			'ANDOP' => 121
		}
	},
	{#State 337
		DEFAULT => -81
	},
	{#State 338
		DEFAULT => -66
	},
	{#State 339
		ACTIONS => {
			"{" => 340
		}
	},
	{#State 340
		DEFAULT => -76,
		GOTOS => {
			'stmtseq' => 341
		}
	},
	{#State 341
		ACTIONS => {
			"%{" => 294,
			'WORD' => 13,
			"}" => 342,
			'NOT2' => 42,
			'PACKAGE' => 18,
			"\@" => 16,
			'FOR' => 45,
			'PERL' => 295,
			'ADDOP' => 46,
			'MY' => 22,
			"%" => 21,
			'FUNC' => 49,
			"\$^" => 23,
			'UNLESS' => 24,
			'NUM' => 26,
			'RETURN' => 55,
			'IF' => 28,
			"\$" => 27,
			'loopword' => 30,
			'FOREACH' => 32,
			'ACROSS' => 291,
			'NOTOP' => 35,
			'STR' => 59,
			"{" => 293,
			'CONST' => 63,
			"(" => 39,
			'YADAYADA' => 69,
			'VAR' => 40,
			'INCOP' => 41
		},
		GOTOS => {
			'scalar' => 83,
			'sideff' => 44,
			'objname' => 17,
			'term' => 50,
			'loop' => 25,
			'array' => 51,
			'expr' => 54,
			'termbinop' => 29,
			'set' => 58,
			'termunop' => 33,
			'line' => 292,
			'cond' => 36,
			'dynvar' => 37,
			'perlblock' => 296,
			'condword' => 60,
			'funcall' => 61,
			'across' => 297,
			'package' => 65,
			'varexpr' => 66,
			'block' => 298,
			'indexvar' => 70,
			'simplevar' => 71
		}
	},
	{#State 342
		ACTIONS => {
			"%{" => -65,
			'WORD' => -65,
			'' => -65,
			"}" => -65,
			'PACKAGE' => -65,
			"\@" => -65,
			'PERL' => -65,
			'MY' => -65,
			"%" => -65,
			"\$^" => -65,
			'UNLESS' => -65,
			'NUM' => -65,
			'STEP' => -65,
			'IF' => -65,
			"\$" => -65,
			'loopword' => -65,
			'FOREACH' => -65,
			'ACROSS' => -65,
			'NOTOP' => -65,
			'FINAL' => -65,
			'ELSE' => 311,
			'INCLUDE' => -65,
			"(" => -65,
			'VAR' => -65,
			'INCOP' => -65,
			'NOT2' => -65,
			'FOR' => -65,
			'ADDOP' => -65,
			'FUNC' => -65,
			'UNIT' => -65,
			'RETURN' => -65,
			'INIT' => -65,
			'FUNCTION' => -65,
			'STR' => -65,
			'CALC' => -65,
			'ELSIF' => 313,
			"{" => -65,
			'CONST' => -65,
			'USE' => -65,
			'YADAYADA' => -65
		},
		GOTOS => {
			'else' => 343
		}
	},
	{#State 343
		DEFAULT => -68
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5995 Parser.pm
	],
	[#Rule program_1
		 'program', 2,
sub {
#line 34 "Parser.eyp"
 $_[0]->new_dnode('PROGRAM', $_[2]) }
#line 6002 Parser.pm
	],
	[#Rule progseq_2
		 'progseq', 0, undef
#line 6006 Parser.pm
	],
	[#Rule progseq_3
		 'progseq', 2, undef
#line 6010 Parser.pm
	],
	[#Rule progseq_4
		 'progseq', 2, undef
#line 6014 Parser.pm
	],
	[#Rule progseq_5
		 'progseq', 2, undef
#line 6018 Parser.pm
	],
	[#Rule progseq_6
		 'progseq', 2, undef
#line 6022 Parser.pm
	],
	[#Rule progseq_7
		 'progseq', 2, undef
#line 6026 Parser.pm
	],
	[#Rule progseq_8
		 'progseq', 2, undef
#line 6030 Parser.pm
	],
	[#Rule progseq_9
		 'progseq', 2,
sub {
#line 52 "Parser.eyp"
 $_[0]->add_stmt($_[2]) if $_[2]; }
#line 6037 Parser.pm
	],
	[#Rule progstart_10
		 'progstart', 0, undef
#line 6041 Parser.pm
	],
	[#Rule tl_decl_11
		 'tl_decl', 1, undef
#line 6045 Parser.pm
	],
	[#Rule tl_decl_12
		 'tl_decl', 1, undef
#line 6049 Parser.pm
	],
	[#Rule tl_decl_13
		 'tl_decl', 1, undef
#line 6053 Parser.pm
	],
	[#Rule tl_decl_14
		 'tl_decl', 1,
sub {
#line 65 "Parser.eyp"
 $_[1] }
#line 6060 Parser.pm
	],
	[#Rule include_15
		 'include', 3,
sub {
#line 69 "Parser.eyp"
my $w = $_[2]; 
 			    $_[0]->push_frame(tag => 'INCLUDE');
			    $_[0]->parse_include($w . ".mad");
			    $_[0]->pop_frame('INCLUDE');
			}
#line 6071 Parser.pm
	],
	[#Rule include_16
		 'include', 3,
sub {
#line 76 "Parser.eyp"
my $w = $_[2]; 
 			    $_[0]->push_frame(tag => 'INCLUDE');
			    $_[0]->parse_include($w);
			    $_[0]->pop_frame('INCLUDE');
			}
#line 6082 Parser.pm
	],
	[#Rule use_17
		 'use', 3,
sub {
#line 84 "Parser.eyp"
my $w = $_[2]; 
			    $_[0]->use_perl($w . ".pm");
			}
#line 6091 Parser.pm
	],
	[#Rule unit_18
		 'unit', 3, undef
#line 6095 Parser.pm
	],
	[#Rule unitdecl_19
		 'unitdecl', 1,
sub {
#line 93 "Parser.eyp"
my $w = $_[1]; 
			    $_[0]->declare_unit($w);
			}
#line 6104 Parser.pm
	],
	[#Rule unitdecl_20
		 'unitdecl', 3,
sub {
#line 98 "Parser.eyp"
my $w = $_[3]; 
			    $_[0]->declare_unit($w);
			}
#line 6113 Parser.pm
	],
	[#Rule params_21
		 'params', 0,
sub {
#line 104 "Parser.eyp"
 $_[0]->new_node('PARAMS'); }
#line 6120 Parser.pm
	],
	[#Rule params_22
		 'params', 1,
sub {
#line 107 "Parser.eyp"
 $_[2]; }
#line 6127 Parser.pm
	],
	[#Rule paramlist_23
		 'paramlist', 1,
sub {
#line 111 "Parser.eyp"
my $p = $_[1]; 
			    $_[0]->new_node('PARAMS', $p);
			}
#line 6136 Parser.pm
	],
	[#Rule paramlist_24
		 'paramlist', 3,
sub {
#line 116 "Parser.eyp"
my $l = $_[1]; my $p = $_[3]; 
			    $_[0]->add_child($l, $p);
			}
#line 6145 Parser.pm
	],
	[#Rule param_25
		 'param', 1,
sub {
#line 122 "Parser.eyp"
 $_[1] }
#line 6152 Parser.pm
	],
	[#Rule unitopt_26
		 'unitopt', 0, undef
#line 6156 Parser.pm
	],
	[#Rule unitopt_27
		 'unitopt', 1,
sub {
#line 128 "Parser.eyp"
 $_[1] }
#line 6163 Parser.pm
	],
	[#Rule unitspec_28
		 'unitspec', 3,
sub {
#line 132 "Parser.eyp"
my $ulist = $_[2];  merge_units($_[0]->new_node('UNITSPEC'), $ulist, 1) }
#line 6170 Parser.pm
	],
	[#Rule unitspec_29
		 'unitspec', 2,
sub {
#line 135 "Parser.eyp"
 $_[0]->YYErrok(); undef; }
#line 6177 Parser.pm
	],
	[#Rule unitlist_30
		 'unitlist', 0,
sub {
#line 139 "Parser.eyp"
 $_[0]->new_node('UNITLIST') }
#line 6184 Parser.pm
	],
	[#Rule unitlist_31
		 'unitlist', 2,
sub {
#line 142 "Parser.eyp"

			    my (@u) = $_[0]->validate_unit($_[2]);
			    if ( $u[0] eq 'ERROR' ) {
				
			    }
			    else {
				add_units($_[1], @u);
			    }
			}
#line 6199 Parser.pm
	],
	[#Rule tl_across_32
		 'tl_across', 7,
sub {
#line 159 "Parser.eyp"
my $p = $_[1]; my $dl = $_[3]; 
			    $_[0]->pop_frame('ACROSS');
			}
#line 6208 Parser.pm
	],
	[#Rule _CODE
		 '@32-4', 0,
sub {
#line 154 "Parser.eyp"
my $p = $_[1]; my $dl = $_[3]; 
			    $_[0]->push_frame(tag => 'ACROSS', phase => $p,
					      dimlist => $dl->{children});
			}
#line 6218 Parser.pm
	],
	[#Rule tl_block_34
		 'tl_block', 5,
sub {
#line 169 "Parser.eyp"
my $p = $_[1]; 
			    $_[0]->pop_frame('BLOCK');
			}
#line 6227 Parser.pm
	],
	[#Rule _CODE
		 '@34-2', 0,
sub {
#line 165 "Parser.eyp"
my $p = $_[1]; 
			    $_[0]->push_frame(tag => 'BLOCK', phase => $p);
			}
#line 6236 Parser.pm
	],
	[#Rule tl_perlblock_36
		 'tl_perlblock', 6,
sub {
#line 181 "Parser.eyp"
my $p = $_[1]; 
			    $_[0]->add_rightbrace();
			    $_[0]->pop_frame('PERLBLOCK');
			}
#line 6246 Parser.pm
	],
	[#Rule _CODE
		 '@36-3', 0,
sub {
#line 175 "Parser.eyp"
my $p = $_[1]; 
			    $_[0]->lex_mode('perl');
			    $_[0]->push_frame(tag => 'PERLBLOCK', phase => $p);
			    $_[0]->add_leftbrace();
			}
#line 6257 Parser.pm
	],
	[#Rule tl_perlblock_38
		 'tl_perlblock', 5,
sub {
#line 192 "Parser.eyp"
my $p = $_[1]; 
			    #$_[0]->pop_frame('PERLBLOCK');
			}
#line 6266 Parser.pm
	],
	[#Rule _CODE
		 '@38-2', 0,
sub {
#line 187 "Parser.eyp"
my $p = $_[1]; 
			    $_[0]->lex_mode('pperl');
			    #$_[0]->push_frame(tag => 'PERLBLOCK', phase => $p);
			}
#line 6276 Parser.pm
	],
	[#Rule tl_perlseq_40
		 'tl_perlseq', 0, undef
#line 6280 Parser.pm
	],
	[#Rule tl_perlseq_41
		 'tl_perlseq', 2,
sub {
#line 200 "Parser.eyp"

			    $_[0]->add_perl($_[2]);
			}
#line 6289 Parser.pm
	],
	[#Rule tl_line_42
		 'tl_line', 4,
sub {
#line 210 "Parser.eyp"
my $e = $_[3]; my $p = $_[1]; 
			    $_[0]->add_stmt($e);
			    $_[0]->pop_frame('line');
			}
#line 6299 Parser.pm
	],
	[#Rule _CODE
		 '@42-1', 0,
sub {
#line 206 "Parser.eyp"
my $p = $_[1]; 
			    $_[0]->push_frame(tag => 'line', phase => $p);
			}
#line 6308 Parser.pm
	],
	[#Rule phase_44
		 'phase', 0,
sub {
#line 217 "Parser.eyp"
 $_[0]->{cf}{phase} }
#line 6315 Parser.pm
	],
	[#Rule phase_45
		 'phase', 1,
sub {
#line 220 "Parser.eyp"
 $_[1] }
#line 6322 Parser.pm
	],
	[#Rule phaseword_46
		 'phaseword', 1,
sub {
#line 224 "Parser.eyp"
 $_[1] }
#line 6329 Parser.pm
	],
	[#Rule phaseword_47
		 'phaseword', 1,
sub {
#line 227 "Parser.eyp"
 $_[1] }
#line 6336 Parser.pm
	],
	[#Rule phaseword_48
		 'phaseword', 1,
sub {
#line 230 "Parser.eyp"
 $_[1] }
#line 6343 Parser.pm
	],
	[#Rule phaseword_49
		 'phaseword', 1,
sub {
#line 233 "Parser.eyp"
 $_[1] }
#line 6350 Parser.pm
	],
	[#Rule line_50
		 'line', 1,
sub {
#line 237 "Parser.eyp"
 undef }
#line 6357 Parser.pm
	],
	[#Rule line_51
		 'line', 2,
sub {
#line 240 "Parser.eyp"
my $e = $_[1];  $e }
#line 6364 Parser.pm
	],
	[#Rule line_52
		 'line', 1,
sub {
#line 243 "Parser.eyp"
 $_[1] }
#line 6371 Parser.pm
	],
	[#Rule line_53
		 'line', 1,
sub {
#line 246 "Parser.eyp"
 $_[1] }
#line 6378 Parser.pm
	],
	[#Rule line_54
		 'line', 3,
sub {
#line 249 "Parser.eyp"
my $v = $_[2]; 
			    $_[0]->see_var($v, PLAIN_VAR); undef;
			}
#line 6387 Parser.pm
	],
	[#Rule line_55
		 'line', 6,
sub {
#line 259 "Parser.eyp"
my $e = $_[5]; my $v = $_[2]; 
			    $_[0]->pop_frame('CONST');
			    $_[0]->new_anode('ASSIGN', '=', $v, $e);
			}
#line 6397 Parser.pm
	],
	[#Rule _CODE
		 '@55-3', 0,
sub {
#line 254 "Parser.eyp"
my $v = $_[2]; 
			    $_[0]->see_var($v, CONST_VAR);
			    $_[0]->push_frame(tag => 'CONST', phase => INIT_PHASE);
			}
#line 6407 Parser.pm
	],
	[#Rule package_57
		 'package', 3,
sub {
#line 266 "Parser.eyp"
my $w = $_[2];  $_[0]->set_package($w); undef }
#line 6414 Parser.pm
	],
	[#Rule sideff_58
		 'sideff', 1,
sub {
#line 270 "Parser.eyp"
 $_[1] }
#line 6421 Parser.pm
	],
	[#Rule sideff_59
		 'sideff', 3,
sub {
#line 273 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('AND', $r, $l) }
#line 6428 Parser.pm
	],
	[#Rule sideff_60
		 'sideff', 3,
sub {
#line 276 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('OR', $r, $l) }
#line 6435 Parser.pm
	],
	[#Rule cond_61
		 'cond', 9,
sub {
#line 282 "Parser.eyp"
my $e = $_[4]; my $c = $_[1]; my $q = $_[7]; my $x = $_[9];  
			    $_[0]->pop_frame($c);
			    $_[0]->new_node($c, $e, $q, $x);
			}
#line 6445 Parser.pm
	],
	[#Rule _CODE
		 '@61-2', 0,
sub {
#line 280 "Parser.eyp"
my $c = $_[1];  $_[0]->push_frame(tag => $c); }
#line 6452 Parser.pm
	],
	[#Rule condword_63
		 'condword', 1,
sub {
#line 289 "Parser.eyp"
 'IF' }
#line 6459 Parser.pm
	],
	[#Rule condword_64
		 'condword', 1,
sub {
#line 291 "Parser.eyp"
 'UNLESS' }
#line 6466 Parser.pm
	],
	[#Rule else_65
		 'else', 0, undef
#line 6470 Parser.pm
	],
	[#Rule else_66
		 'else', 5,
sub {
#line 301 "Parser.eyp"
my $q = $_[4];  
			    $_[0]->pop_frame('ELSE');
			    $_[0]->new_node('ELSE', $q);
			}
#line 6480 Parser.pm
	],
	[#Rule _CODE
		 '@66-2', 0,
sub {
#line 297 "Parser.eyp"

			    $_[0]->push_frame(tag => 'ELSE');
			}
#line 6489 Parser.pm
	],
	[#Rule else_68
		 'else', 9,
sub {
#line 309 "Parser.eyp"
my $e = $_[4]; my $q = $_[7]; my $x = $_[9]; 
			    $_[0]->pop_frame('ELSIF');
			    $_[0]->new_node('ELSIF', $e, $q, $x);
			}
#line 6499 Parser.pm
	],
	[#Rule _CODE
		 '@68-2', 0,
sub {
#line 307 "Parser.eyp"
 $_[0]->push_frame(tag => 'ELSIF'); }
#line 6506 Parser.pm
	],
	[#Rule loop_70
		 'loop', 8,
sub {
#line 320 "Parser.eyp"
my $e = $_[4]; my $c = $_[1]; my $q = $_[7]; 
			    $_[0]->pop_frame($c);
			    $_[0]->new_node($c, $e, $q);
			}
#line 6516 Parser.pm
	],
	[#Rule _CODE
		 '@70-2', 0,
sub {
#line 316 "Parser.eyp"
my $c = $_[1]; 
			    $_[0]->push_frame(tag => $c);
			}
#line 6525 Parser.pm
	],
	[#Rule loop_72
		 'loop', 9,
sub {
#line 330 "Parser.eyp"
my $e = $_[5]; my $q = $_[8]; my $i = $_[3]; 
			    $_[0]->see_var($i, ASSIGN_VAR);
			    $_[0]->pop_frame('FOREACH');
			    $_[0]->new_node('FOREACH', $i, $e, $q);
			}
#line 6536 Parser.pm
	],
	[#Rule _CODE
		 '@72-1', 0,
sub {
#line 326 "Parser.eyp"

			    $_[0]->push_frame(tag => 'FOREACH');
			}
#line 6545 Parser.pm
	],
	[#Rule loop_74
		 'loop', 12,
sub {
#line 341 "Parser.eyp"
my $e2 = $_[6]; my $e1 = $_[4]; my $q = $_[11]; my $e3 = $_[8]; 
			    $_[0]->pop_frame('FOR');
			    $_[0]->new_node('FOR', $e1, $e2, $e3, $q);
			}
#line 6555 Parser.pm
	],
	[#Rule _CODE
		 '@74-2', 0,
sub {
#line 337 "Parser.eyp"

			    $_[0]->push_frame('FOR');
			}
#line 6564 Parser.pm
	],
	[#Rule stmtseq_76
		 'stmtseq', 0,
sub {
#line 348 "Parser.eyp"
 $_[0]->new_node('STMTSEQ') }
#line 6571 Parser.pm
	],
	[#Rule stmtseq_77
		 'stmtseq', 2,
sub {
#line 351 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 6578 Parser.pm
	],
	[#Rule stmtseq_78
		 'stmtseq', 2,
sub {
#line 354 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 6585 Parser.pm
	],
	[#Rule stmtseq_79
		 'stmtseq', 2,
sub {
#line 357 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 6592 Parser.pm
	],
	[#Rule stmtseq_80
		 'stmtseq', 2,
sub {
#line 360 "Parser.eyp"
 add_child($_[1], $_[2]) }
#line 6599 Parser.pm
	],
	[#Rule across_81
		 'across', 6,
sub {
#line 369 "Parser.eyp"
my $q = $_[5]; my $dl = $_[2]; 
			    $_[0]->pop_frame('ACROSS');
			    $_[0]->new_node('ACROSS', $dl, @{$q->{children}});
			}
#line 6609 Parser.pm
	],
	[#Rule _CODE
		 '@81-3', 0,
sub {
#line 364 "Parser.eyp"
my $dl = $_[2]; 
			    $_[0]->push_frame(tag => 'ACROSS', 
					      dimlist => $dl->{children});
			}
#line 6619 Parser.pm
	],
	[#Rule block_83
		 'block', 4,
sub {
#line 380 "Parser.eyp"
my $q = $_[3]; 
			    $_[0]->pop_frame('BLOCK');
			    $_[0]->new_node('BLOCK', @{$q->{children}});
			}
#line 6629 Parser.pm
	],
	[#Rule _CODE
		 '@83-1', 0,
sub {
#line 376 "Parser.eyp"
 
			    $_[0]->push_frame(tag => 'BLOCK'); 
			}
#line 6638 Parser.pm
	],
	[#Rule perlblock_85
		 'perlblock', 5,
sub {
#line 392 "Parser.eyp"
my $q = $_[4]; 
			    $_[0]->pop_frame('PERLBLOCK');
			    $_[0]->new_node('PERLBLOCK', @{$q->{children}});
			}
#line 6648 Parser.pm
	],
	[#Rule _CODE
		 '@85-2', 0,
sub {
#line 387 "Parser.eyp"

			    $_[0]->lex_mode('perl');
			    $_[0]->push_frame(tag => 'PERLBLOCK');
			}
#line 6658 Parser.pm
	],
	[#Rule perlblock_87
		 'perlblock', 4,
sub {
#line 403 "Parser.eyp"
my $q = $_[3]; 
			    #$_[0]->pop_frame('PERLBLOCK');
			    $q;
			}
#line 6668 Parser.pm
	],
	[#Rule _CODE
		 '@87-1', 0,
sub {
#line 398 "Parser.eyp"

			    $_[0]->lex_mode('pperl');
			    #$_[0]->push_frame(tag => 'PERLBLOCK');
			}
#line 6678 Parser.pm
	],
	[#Rule perlseq_89
		 'perlseq', 0,
sub {
#line 410 "Parser.eyp"

			    $_[0]->new_node('PERLSEQ');
			}
#line 6687 Parser.pm
	],
	[#Rule perlseq_90
		 'perlseq', 2,
sub {
#line 415 "Parser.eyp"

			    $_[0]->add_child($_[1], $_[2]);
			}
#line 6696 Parser.pm
	],
	[#Rule vardecl_91
		 'vardecl', 2,
sub {
#line 421 "Parser.eyp"
my $u = $_[2]; my $v = $_[1];  merge_units($v, $u) }
#line 6703 Parser.pm
	],
	[#Rule vardecl_92
		 'vardecl', 3,
sub {
#line 424 "Parser.eyp"
my $u = $_[3]; my $d = $_[2]; my $v = $_[1];  merge_units(add_child($v, $d), $u) }
#line 6710 Parser.pm
	],
	[#Rule expr_93
		 'expr', 3,
sub {
#line 428 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('AND', $l, $r) }
#line 6717 Parser.pm
	],
	[#Rule expr_94
		 'expr', 3,
sub {
#line 431 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('OR', $l, $r) }
#line 6724 Parser.pm
	],
	[#Rule expr_95
		 'expr', 3,
sub {
#line 434 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('XOR', $l, $r) }
#line 6731 Parser.pm
	],
	[#Rule expr_96
		 'expr', 2,
sub {
#line 437 "Parser.eyp"
my $e = $_[2];  $_[0]->new_node('NOT', $e) }
#line 6738 Parser.pm
	],
	[#Rule expr_97
		 'expr', 1,
sub {
#line 440 "Parser.eyp"
 $_[1] }
#line 6745 Parser.pm
	],
	[#Rule term_98
		 'term', 1,
sub {
#line 444 "Parser.eyp"
 $_[1] }
#line 6752 Parser.pm
	],
	[#Rule term_99
		 'term', 1,
sub {
#line 447 "Parser.eyp"
 $_[1] }
#line 6759 Parser.pm
	],
	[#Rule term_100
		 'term', 5,
sub {
#line 450 "Parser.eyp"
my $c = $_[5]; my $a = $_[1]; my $b = $_[3];  $_[0]->new_node('TRI', $a, $b, $c) }
#line 6766 Parser.pm
	],
	[#Rule term_101
		 'term', 3,
sub {
#line 453 "Parser.eyp"
 $_[2] }
#line 6773 Parser.pm
	],
	[#Rule term_102
		 'term', 1,
sub {
#line 456 "Parser.eyp"
 $_[1] }
#line 6780 Parser.pm
	],
	[#Rule term_103
		 'term', 1,
sub {
#line 459 "Parser.eyp"
 $_[1] }
#line 6787 Parser.pm
	],
	[#Rule term_104
		 'term', 1,
sub {
#line 462 "Parser.eyp"
 $_[1] }
#line 6794 Parser.pm
	],
	[#Rule term_105
		 'term', 1,
sub {
#line 465 "Parser.eyp"
 $_[0]->new_anode('NUM', $_[1]) }
#line 6801 Parser.pm
	],
	[#Rule term_106
		 'term', 1,
sub {
#line 468 "Parser.eyp"
 $_[0]->new_anode('STR', $_[1]) }
#line 6808 Parser.pm
	],
	[#Rule term_107
		 'term', 1,
sub {
#line 471 "Parser.eyp"
 $_[1] }
#line 6815 Parser.pm
	],
	[#Rule term_108
		 'term', 1,
sub {
#line 475 "Parser.eyp"
 $_[1] }
#line 6822 Parser.pm
	],
	[#Rule term_109
		 'term', 2,
sub {
#line 478 "Parser.eyp"
my $e = $_[2];  $_[0]->new_node('RETURN', $e) }
#line 6829 Parser.pm
	],
	[#Rule term_110
		 'term', 2,
sub {
#line 481 "Parser.eyp"
my $u = $_[2]; my $t = $_[1];  merge_units($t, $u) }
#line 6836 Parser.pm
	],
	[#Rule term_111
		 'term', 1,
sub {
#line 484 "Parser.eyp"
 $_[0]->new_node('YADAYADA'); }
#line 6843 Parser.pm
	],
	[#Rule termbinop_112
		 'termbinop', 3,
sub {
#line 488 "Parser.eyp"
my $l = $_[1]; my $r = $_[3]; my $op = $_[2]; 
			    $_[0]->see_var($l, ASSIGN_VAR);
			    $_[0]->new_anode('ASSIGN', $op, $l, $r);
			}
#line 6853 Parser.pm
	],
	[#Rule termbinop_113
		 'termbinop', 3,
sub {
#line 494 "Parser.eyp"
my $l = $_[1]; my $r = $_[3]; 
			    $_[0]->see_var($l, ASSIGN_VAR);
			    $_[0]->new_anode('ASSIGN', '=', $l, $r);
			}
#line 6863 Parser.pm
	],
	[#Rule termbinop_114
		 'termbinop', 3,
sub {
#line 500 "Parser.eyp"
my $l = $_[1]; my $r = $_[3]; my $op = $_[2];  $_[0]->new_anode('ADDOP', $op, $l, $r); }
#line 6870 Parser.pm
	],
	[#Rule termbinop_115
		 'termbinop', 3,
sub {
#line 503 "Parser.eyp"
my $l = $_[1]; my $r = $_[3]; my $op = $_[2];  $_[0]->new_anode('MULOP', $op, $l, $r); }
#line 6877 Parser.pm
	],
	[#Rule termbinop_116
		 'termbinop', 3,
sub {
#line 506 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_anode('MULOP', '%', $l, $r); }
#line 6884 Parser.pm
	],
	[#Rule termbinop_117
		 'termbinop', 3,
sub {
#line 509 "Parser.eyp"
my $l = $_[1]; my $r = $_[3]; my $op = $_[2];  $_[0]->new_anode('POWOP', $op, $l, $r); }
#line 6891 Parser.pm
	],
	[#Rule termbinop_118
		 'termbinop', 3,
sub {
#line 512 "Parser.eyp"
my $l = $_[1]; my $r = $_[3]; my $op = $_[2];  $_[0]->new_anode('RELOP', $op, $l, $r); }
#line 6898 Parser.pm
	],
	[#Rule termbinop_119
		 'termbinop', 3,
sub {
#line 515 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('DOTDOT', $l, $r); }
#line 6905 Parser.pm
	],
	[#Rule termbinop_120
		 'termbinop', 3,
sub {
#line 518 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('AND', $l, $r); }
#line 6912 Parser.pm
	],
	[#Rule termbinop_121
		 'termbinop', 3,
sub {
#line 521 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('OR', $l, $r); }
#line 6919 Parser.pm
	],
	[#Rule termbinop_122
		 'termbinop', 3,
sub {
#line 524 "Parser.eyp"
my $l = $_[1]; my $r = $_[3];  $_[0]->new_node('DOR', $l, $r); }
#line 6926 Parser.pm
	],
	[#Rule termunop_123
		 'termunop', 2,
sub {
#line 530 "Parser.eyp"
my $t = $_[2]; my $op = $_[1];  $op eq '-' ? $_[0]->new_node('UMINUS', $t) : $t }
#line 6933 Parser.pm
	],
	[#Rule termunop_124
		 'termunop', 2,
sub {
#line 533 "Parser.eyp"
my $t = $_[2];  $_[0]->new_node('NOT', $t) }
#line 6940 Parser.pm
	],
	[#Rule termunop_125
		 'termunop', 2,
sub {
#line 536 "Parser.eyp"
 $_[1]->{incr} = 'POST'; $_[1] }
#line 6947 Parser.pm
	],
	[#Rule termunop_126
		 'termunop', 2,
sub {
#line 539 "Parser.eyp"
 $_[2]->{incr} = 'PRE'; $_[2] }
#line 6954 Parser.pm
	],
	[#Rule varexpr_127
		 'varexpr', 1,
sub {
#line 543 "Parser.eyp"
my $v = $_[1]; 
			    $_[0]->see_var($v, PLAIN_VAR);
			}
#line 6963 Parser.pm
	],
	[#Rule varexpr_128
		 'varexpr', 2,
sub {
#line 548 "Parser.eyp"
my $d = $_[2]; my $v = $_[1]; 
			    add_child($v, $d);
			    $_[0]->see_var($v, PLAIN_VAR);
			}
#line 6973 Parser.pm
	],
	[#Rule varexpr_129
		 'varexpr', 3,
sub {
#line 554 "Parser.eyp"
my $v = $_[1]; my $f = $_[3]; 
			    $_[0]->see_var($v, PLAIN_VAR);
			    $_[0]->new_anode('DOTFLD', $f, $v);
			}
#line 6983 Parser.pm
	],
	[#Rule varexpr_130
		 'varexpr', 6,
sub {
#line 560 "Parser.eyp"
my $a = $_[5]; my $m = $_[3]; my $v = $_[1]; 
			    $_[0]->see_var($v, PLAIN_VAR);
			    $_[0]->new_anode('METHOD', $m, $v, $a);
			}
#line 6993 Parser.pm
	],
	[#Rule dynvar_131
		 'dynvar', 2,
sub {
#line 567 "Parser.eyp"
my $v = $_[2]; 
			    $_[0]->see_var($v, DYN_VAR);
			}
#line 7002 Parser.pm
	],
	[#Rule simplevar_132
		 'simplevar', 1,
sub {
#line 573 "Parser.eyp"
 $_[1] }
#line 7009 Parser.pm
	],
	[#Rule simplevar_133
		 'simplevar', 1,
sub {
#line 576 "Parser.eyp"
 $_[1] }
#line 7016 Parser.pm
	],
	[#Rule simplevar_134
		 'simplevar', 1,
sub {
#line 579 "Parser.eyp"
 $_[1] }
#line 7023 Parser.pm
	],
	[#Rule scalarvar_135
		 'scalarvar', 1,
sub {
#line 583 "Parser.eyp"
my $v = $_[1];  $_[0]->see_var($v, PLAIN_VAR); }
#line 7030 Parser.pm
	],
	[#Rule scalarvar_136
		 'scalarvar', 2,
sub {
#line 586 "Parser.eyp"
my $v = $_[2];  $_[0]->see_var($v, DYN_VAR); }
#line 7037 Parser.pm
	],
	[#Rule scalar_137
		 'scalar', 2,
sub {
#line 590 "Parser.eyp"
 $_[0]->new_anode('SCALARV', $_[2]); }
#line 7044 Parser.pm
	],
	[#Rule array_138
		 'array', 2,
sub {
#line 594 "Parser.eyp"
 $_[0]->new_anode('ARRAYV', $_[2]); }
#line 7051 Parser.pm
	],
	[#Rule set_139
		 'set', 2,
sub {
#line 598 "Parser.eyp"
 $_[0]->new_anode('SETV', $_[2]); }
#line 7058 Parser.pm
	],
	[#Rule indexvar_140
		 'indexvar', 1,
sub {
#line 602 "Parser.eyp"
 $_[0]->new_node('INDEXVAR'); }
#line 7065 Parser.pm
	],
	[#Rule indexvar_141
		 'indexvar', 2,
sub {
#line 605 "Parser.eyp"
my $n = $_[2];  $_[0]->new_anode('INDEXVAR', $n); }
#line 7072 Parser.pm
	],
	[#Rule indexvar_142
		 'indexvar', 2,
sub {
#line 608 "Parser.eyp"
my $w = $_[2];  $_[0]->new_anode('INDEXVAR', $w); }
#line 7079 Parser.pm
	],
	[#Rule dimlist_143
		 'dimlist', 1,
sub {
#line 612 "Parser.eyp"
my $d = $_[1];  $_[0]->new_node('DIMLIST', $d); }
#line 7086 Parser.pm
	],
	[#Rule dimlist_144
		 'dimlist', 2,
sub {
#line 615 "Parser.eyp"
my $l = $_[1]; my $d = $_[2];  add_child($l, $d); }
#line 7093 Parser.pm
	],
	[#Rule dimspec_145
		 'dimspec', 4,
sub {
#line 619 "Parser.eyp"
my $l = $_[2]; my $d = $_[3];  add_child($d, $l); }
#line 7100 Parser.pm
	],
	[#Rule dimspec_146
		 'dimspec', 4,
sub {
#line 622 "Parser.eyp"
my $l = $_[2]; my $d = $_[3];  add_child($d, $l); }
#line 7107 Parser.pm
	],
	[#Rule label_147
		 'label', 0, undef
#line 7111 Parser.pm
	],
	[#Rule label_148
		 'label', 2,
sub {
#line 627 "Parser.eyp"
my $w = $_[1];  $_[0]->new_anode('LABEL', $w); }
#line 7118 Parser.pm
	],
	[#Rule subexpr_149
		 'subexpr', 1,
sub {
#line 631 "Parser.eyp"
my $d = $_[1];  $_[0]->new_node('SUBSCRIPT', $d); }
#line 7125 Parser.pm
	],
	[#Rule subexpr_150
		 'subexpr', 2,
sub {
#line 634 "Parser.eyp"
my $l = $_[1]; my $d = $_[2];  add_child($l, $d); }
#line 7132 Parser.pm
	],
	[#Rule subspec_151
		 'subspec', 2,
sub {
#line 638 "Parser.eyp"
 $_[0]->new_node('EMPTYDIM') }
#line 7139 Parser.pm
	],
	[#Rule subspec_152
		 'subspec', 3,
sub {
#line 641 "Parser.eyp"
 $_[2] }
#line 7146 Parser.pm
	],
	[#Rule funcall_153
		 'funcall', 4,
sub {
#line 645 "Parser.eyp"
my $a = $_[3]; my $fun = $_[1];  $_[0]->new_anode('FUNCALL', $fun, @{$a->{children}}) }
#line 7153 Parser.pm
	],
	[#Rule funcall_154
		 'funcall', 6,
sub {
#line 648 "Parser.eyp"
my $a = $_[3]; my $fld = $_[6]; my $fun = $_[1];  $_[0]->new_anode('DOTFLD', $fld,
				            $_[0]->new_node('FUNCALL', $fun, 
						   @{$a->{children}}) ) }
#line 7162 Parser.pm
	],
	[#Rule objname_155
		 'objname', 1,
sub {
#line 654 "Parser.eyp"
my $n = $_[1];  $_[0]->new_anode('FUNCALL', $n) }
#line 7169 Parser.pm
	],
	[#Rule argexpr_156
		 'argexpr', 0, undef
#line 7173 Parser.pm
	],
	[#Rule argexpr_157
		 'argexpr', 1,
sub {
#line 660 "Parser.eyp"
 $_[1] }
#line 7180 Parser.pm
	],
	[#Rule arglist_158
		 'arglist', 1,
sub {
#line 664 "Parser.eyp"
my $t = $_[1];  $_[0]->new_node('ARGS', $t); }
#line 7187 Parser.pm
	],
	[#Rule arglist_159
		 'arglist', 3,
sub {
#line 667 "Parser.eyp"
my $a = $_[1]; my $t = $_[3];  add_child($a, $t); }
#line 7194 Parser.pm
	],
	[#Rule arg_160
		 'arg', 1,
sub {
#line 671 "Parser.eyp"
 $_[1] }
#line 7201 Parser.pm
	],
	[#Rule arg_161
		 'arg', 1,
sub {
#line 674 "Parser.eyp"
 $_[1] }
#line 7208 Parser.pm
	],
	[#Rule pair_162
		 'pair', 3,
sub {
#line 678 "Parser.eyp"
my $value = $_[3]; my $tag = $_[1];  $_[0]->new_anode('KEY', $tag, $value) }
#line 7215 Parser.pm
	],
	[#Rule flow_163
		 'flow', 5,
sub {
#line 682 "Parser.eyp"
my $so = $_[1]; my $sn = $_[5]; my $coeff = $_[3]; my $op = $_[2]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->add_flow($so, $sn, 
			                    $_[0]->new_anode('MULOP', $op, $so, $coeff));
			}
#line 7227 Parser.pm
	],
	[#Rule flow_164
		 'flow', 5,
sub {
#line 690 "Parser.eyp"
my $so = $_[5]; my $sn = $_[1]; my $coeff = $_[3]; my $op = $_[2]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->add_flow($so, $sn, 
					    $_[0]->new_anode('MULOP', $op, $sn, $coeff));
			}
#line 7239 Parser.pm
	],
	[#Rule flow_165
		 'flow', 5,
sub {
#line 698 "Parser.eyp"
my $so = $_[1]; my $sn = $_[3]; my $coeff = $_[5]; my $op = $_[4]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->add_flow($so, $sn,
					    $_[0]->new_anode('MULOP', $op, $sn, $coeff));
			}
#line 7251 Parser.pm
	],
	[#Rule flow_166
		 'flow', 5,
sub {
#line 706 "Parser.eyp"
my $so = $_[3]; my $sn = $_[1]; my $coeff = $_[5]; my $op = $_[4]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->add_flow($so, $sn, 
					    $_[0]->new_anode('MULOP', $op, $so, $coeff));
			}
#line 7263 Parser.pm
	],
	[#Rule flow_167
		 'flow', 6,
sub {
#line 714 "Parser.eyp"
my $rate = $_[3]; my $so = $_[1]; my $sn = $_[6]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->add_flow($so, $sn, $rate);
			}
#line 7274 Parser.pm
	],
	[#Rule flow_168
		 'flow', 6,
sub {
#line 721 "Parser.eyp"
my $so = $_[6]; my $rate = $_[3]; my $sn = $_[1]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->add_flow($so, $sn, $rate);
			}
#line 7285 Parser.pm
	],
	[#Rule flow_169
		 'flow', 6,
sub {
#line 728 "Parser.eyp"
my $rate = $_[5]; my $so = $_[1]; my $sn = $_[3]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->add_flow($so, $sn, $rate);
			}
#line 7296 Parser.pm
	],
	[#Rule flow_170
		 'flow', 6,
sub {
#line 735 "Parser.eyp"
my $rate = $_[5]; my $so = $_[3]; my $sn = $_[1]; 
			    $_[0]->see_var($so, ASSIGN_VAR);
			    $_[0]->see_var($sn, ASSIGN_VAR);
			    $_[0]->add_flow($so, $sn, $rate);
			}
#line 7307 Parser.pm
	],
	[#Rule function_171
		 'function', 7,
sub {
#line 743 "Parser.eyp"
my $u = $_[6]; my $p = $_[4]; my $name = $_[2]; 
			    $_[0]->declare_function($name, 'MAD_FUNC', $p, $u);
			}
#line 7316 Parser.pm
	],
	[#Rule function_172
		 'function', 10,
sub {
#line 754 "Parser.eyp"
my $u = $_[6]; my $p = $_[4]; my $q = $_[9]; my $name = $_[2]; 
			    $_[0]->pop_frame('FUNDECL');
			    $_[0]->define_function($name, $q);
			}
#line 7326 Parser.pm
	],
	[#Rule _CODE
		 '@172-7', 0,
sub {
#line 748 "Parser.eyp"
my $u = $_[6]; my $p = $_[4]; my $name = $_[2]; 
			    $_[0]->declare_function($name, 'MAD_FUNC', $p, $u);
			    $_[0]->push_frame(tag => 'FUNDECL', name => $name,
					      params => $p);
			}
#line 7337 Parser.pm
	],
	[#Rule function_174
		 'function', 8,
sub {
#line 760 "Parser.eyp"
my $u = $_[7]; my $p = $_[5]; my $name = $_[3]; 
			    $_[0]->declare_function($name, $p, 'PERL_FUNC');
			    merge_units($_[0]->new_anode('PERLFUNDECL', $name, $p), $u);
			}
#line 7347 Parser.pm
	],
	[#Rule function_175
		 'function', 11,
sub {
#line 772 "Parser.eyp"
my $u = $_[7]; my $p = $_[5]; my $q = $_[10]; my $name = $_[3]; 
			    $_[0]->pop_frame('PERLFUNDECL');
			    merge_units($_[0]->new_anode('PERLFUNDECL', $name, $p, $q), $u);
			}
#line 7357 Parser.pm
	],
	[#Rule _CODE
		 '@175-8', 0,
sub {
#line 766 "Parser.eyp"
my $u = $_[7]; my $p = $_[5]; my $name = $_[3]; 
			    $_[0]->declare_function($name, $p, 'PERL_FUNC');
			    $_[0]->push_frame(tag => 'PERLFUNDECL', name => $name,
					      params => $p, units => $u);
			}
#line 7368 Parser.pm
	]
],
#line 7371 Parser.pm
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
         'params_21', 
         'params_22', 
         'paramlist_23', 
         'paramlist_24', 
         'param_25', 
         'unitopt_26', 
         'unitopt_27', 
         'unitspec_28', 
         'unitspec_29', 
         'unitlist_30', 
         'unitlist_31', 
         'tl_across_32', 
         '_CODE', 
         'tl_block_34', 
         '_CODE', 
         'tl_perlblock_36', 
         '_CODE', 
         'tl_perlblock_38', 
         '_CODE', 
         'tl_perlseq_40', 
         'tl_perlseq_41', 
         'tl_line_42', 
         '_CODE', 
         'phase_44', 
         'phase_45', 
         'phaseword_46', 
         'phaseword_47', 
         'phaseword_48', 
         'phaseword_49', 
         'line_50', 
         'line_51', 
         'line_52', 
         'line_53', 
         'line_54', 
         'line_55', 
         '_CODE', 
         'package_57', 
         'sideff_58', 
         'sideff_59', 
         'sideff_60', 
         'cond_61', 
         '_CODE', 
         'condword_63', 
         'condword_64', 
         'else_65', 
         'else_66', 
         '_CODE', 
         'else_68', 
         '_CODE', 
         'loop_70', 
         '_CODE', 
         'loop_72', 
         '_CODE', 
         'loop_74', 
         '_CODE', 
         'stmtseq_76', 
         'stmtseq_77', 
         'stmtseq_78', 
         'stmtseq_79', 
         'stmtseq_80', 
         'across_81', 
         '_CODE', 
         'block_83', 
         '_CODE', 
         'perlblock_85', 
         '_CODE', 
         'perlblock_87', 
         '_CODE', 
         'perlseq_89', 
         'perlseq_90', 
         'vardecl_91', 
         'vardecl_92', 
         'expr_93', 
         'expr_94', 
         'expr_95', 
         'expr_96', 
         'expr_97', 
         'term_98', 
         'term_99', 
         'term_100', 
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
         'termbinop_112', 
         'termbinop_113', 
         'termbinop_114', 
         'termbinop_115', 
         'termbinop_116', 
         'termbinop_117', 
         'termbinop_118', 
         'termbinop_119', 
         'termbinop_120', 
         'termbinop_121', 
         'termbinop_122', 
         'termunop_123', 
         'termunop_124', 
         'termunop_125', 
         'termunop_126', 
         'varexpr_127', 
         'varexpr_128', 
         'varexpr_129', 
         'varexpr_130', 
         'dynvar_131', 
         'simplevar_132', 
         'simplevar_133', 
         'simplevar_134', 
         'scalarvar_135', 
         'scalarvar_136', 
         'scalar_137', 
         'array_138', 
         'set_139', 
         'indexvar_140', 
         'indexvar_141', 
         'indexvar_142', 
         'dimlist_143', 
         'dimlist_144', 
         'dimspec_145', 
         'dimspec_146', 
         'label_147', 
         'label_148', 
         'subexpr_149', 
         'subexpr_150', 
         'subspec_151', 
         'subspec_152', 
         'funcall_153', 
         'funcall_154', 
         'objname_155', 
         'argexpr_156', 
         'argexpr_157', 
         'arglist_158', 
         'arglist_159', 
         'arg_160', 
         'arg_161', 
         'pair_162', 
         'flow_163', 
         'flow_164', 
         'flow_165', 
         'flow_166', 
         'flow_167', 
         'flow_168', 
         'flow_169', 
         'flow_170', 
         'function_171', 
         'function_172', 
         '_CODE', 
         'function_174', 
         'function_175', 
         '_CODE', );
  $self;
}

#line 778 "Parser.eyp"


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


#line 8040 Parser.pm



1;
