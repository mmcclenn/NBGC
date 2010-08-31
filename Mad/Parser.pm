########################################################################################
#
#    This file was generated using Parse::Eyapp version 1.165.
#
# (c) Parse::Yapp Copyright 1998-2001 Francois Desarmenien.
# (c) Parse::Eyapp Copyright 2006-2008 Casiano Rodriguez-Leon. Universidad de La Laguna.
#        Don't edit this file, use source file 'Mad/Parser.eyp' instead.
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

      m{\G(FLOWRIGHT|TIMESTEP|ASSIGNOP|FLOWLEFT|EXTERNAL|FUNCTION|PERLPART|INCLUDE|DORDOR|UNLESS|ANDAND|RETURN|MODULE|DOTDOT|XOROP|ANDOP|POWOP|NOTOP|RELOP|INCOP|ADDOP|UNITS|ELSIF|MULOP|CONST|WORD|PERL|POOL|STEP|ELSE|OROP|NOT2|FUNC|UNIT|INIT|OROR|NUM|DOT|VAR|STR|\%\{|\%\}|IF|\=\>|\:|\}|\<|\@|\$|\[|\]|\(|\>|\;|\,|\)|\?|\{|\=)}gc and return ($1, $1);



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

#line 2 "Mad/Parser.eyp"

use Mad::Model;
use Data::Dumper;
$Data::Dumper::indent = 0;

use constant {
    PLAIN_VAR => 0,
    CONST_VAR => 1,
    POOL_VAR => 2,
};

use constant {
    INIT_PHASE => 1,
    STEP_PHASE => 2,
    TIME_PHASE => 3,
};


#line 74 Mad/Parser.pm

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
  [ 'program_1' => 'program', [ 'progstart', 'stmtseq' ], 0 ],
  [ 'progstart_2' => 'progstart', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-1', [ 'STAR-1', 'PERLPART' ], 0 ],
  [ '_STAR_LIST' => 'STAR-1', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-2', [ 'STAR-2', 'PERLPART' ], 0 ],
  [ '_STAR_LIST' => 'STAR-2', [  ], 0 ],
  [ 'block_7' => 'block', [ '{', 'stmtseq', '}' ], 0 ],
  [ 'block_8' => 'block', [ 'PERL', '{', '@8-2', 'STAR-1', '}' ], 0 ],
  [ '_CODE' => '@8-2', [  ], 0 ],
  [ 'block_10' => 'block', [ '%{', '@10-1', 'STAR-2', '%}' ], 0 ],
  [ '_CODE' => '@10-1', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-3', [ 'STAR-3', ',', 'pair' ], 0 ],
  [ '_STAR_LIST' => 'STAR-3', [ 'pair' ], 0 ],
  [ '_STAR_LIST' => 'STAR-4', [ 'STAR-3' ], 0 ],
  [ '_STAR_LIST' => 'STAR-4', [  ], 0 ],
  [ 'pairblock_16' => 'pairblock', [ '{', 'STAR-4', '}' ], 0 ],
  [ 'pair_17' => 'pair', [ 'WORD', '=>', 'expr' ], 0 ],
  [ 'unitspec_18' => 'unitspec', [  ], 0 ],
  [ 'unitspec_19' => 'unitspec', [ '<', 'unitlist', '>' ], 0 ],
  [ 'unitlist_20' => 'unitlist', [  ], 0 ],
  [ 'unitlist_21' => 'unitlist', [ 'unitlist', 'UNIT' ], 0 ],
  [ 'stmtseq_22' => 'stmtseq', [  ], 0 ],
  [ 'stmtseq_23' => 'stmtseq', [ 'stmtseq', 'decl' ], 0 ],
  [ 'stmtseq_24' => 'stmtseq', [ 'stmtseq', 'line' ], 0 ],
  [ 'decl_25' => 'decl', [ 'const' ], 0 ],
  [ 'decl_26' => 'decl', [ 'var' ], 0 ],
  [ 'decl_27' => 'decl', [ 'pool' ], 0 ],
  [ 'decl_28' => 'decl', [ 'include' ], 0 ],
  [ 'decl_29' => 'decl', [ 'module' ], 0 ],
  [ 'decl_30' => 'decl', [ 'units' ], 0 ],
  [ 'decl_31' => 'decl', [ 'external' ], 0 ],
  [ 'decl_32' => 'decl', [ 'function' ], 0 ],
  [ 'const_33' => 'const', [ 'CONST', 'vardecl', '=', 'expr', ';' ], 0 ],
  [ 'const_34' => 'const', [ 'CONST', 'vardecl', ';' ], 0 ],
  [ 'var_35' => 'var', [ 'VAR', 'vardecl', 'phase', '=', 'expr', ';' ], 0 ],
  [ 'var_36' => 'var', [ 'VAR', 'vardecl', ';' ], 0 ],
  [ 'pool_37' => 'pool', [ 'POOL', 'vardecl', 'phase', '=', 'expr', ';' ], 0 ],
  [ 'pool_38' => 'pool', [ 'POOL', 'vardecl', ';' ], 0 ],
  [ 'vardecl_39' => 'vardecl', [ 'scalar', 'unitspec' ], 0 ],
  [ 'vardecl_40' => 'vardecl', [ 'scalar', '[', 'set', ']', 'unitspec' ], 0 ],
  [ 'vardecl_41' => 'vardecl', [ 'set', 'unitspec' ], 0 ],
  [ 'phase_42' => 'phase', [  ], 0 ],
  [ 'phase_43' => 'phase', [ 'INIT' ], 0 ],
  [ 'phase_44' => 'phase', [ 'STEP' ], 0 ],
  [ 'phase_45' => 'phase', [ 'TIMESTEP' ], 0 ],
  [ 'include_46' => 'include', [ 'INCLUDE', 'WORD', ';' ], 0 ],
  [ 'module_47' => 'module', [ 'MODULE', 'WORD', ';' ], 0 ],
  [ 'units_48' => 'units', [ 'UNITS', 'wordlist', ';' ], 0 ],
  [ 'wordlist_49' => 'wordlist', [ 'WORD' ], 0 ],
  [ 'wordlist_50' => 'wordlist', [ 'wordlist', ',', 'WORD' ], 0 ],
  [ 'external_51' => 'external', [ 'EXTERNAL', 'WORD', 'funargs', 'unitspec', 'pairblock', ';' ], 0 ],
  [ 'function_52' => 'function', [ 'FUNCTION', 'WORD', 'funargs', 'unitspec', 'funbody' ], 0 ],
  [ '_STAR_LIST' => 'STAR-5', [ 'STAR-5', ',', 'scalar' ], 0 ],
  [ '_STAR_LIST' => 'STAR-5', [ 'scalar' ], 0 ],
  [ '_STAR_LIST' => 'STAR-6', [ 'STAR-5' ], 0 ],
  [ '_STAR_LIST' => 'STAR-6', [  ], 0 ],
  [ 'funargs_57' => 'funargs', [  ], 0 ],
  [ 'funargs_58' => 'funargs', [ '(', 'STAR-6', ')' ], 0 ],
  [ 'funbody_59' => 'funbody', [ 'block' ], 0 ],
  [ 'funbody_60' => 'funbody', [ ';' ], 0 ],
  [ 'line_61' => 'line', [ 'phase', 'block' ], 0 ],
  [ 'line_62' => 'line', [ 'phase', 'sideff', ';' ], 0 ],
  [ 'line_63' => 'line', [ 'block' ], 0 ],
  [ 'line_64' => 'line', [ 'cond' ], 0 ],
  [ 'line_65' => 'line', [ 'flow', ';' ], 0 ],
  [ 'line_66' => 'line', [ 'sideff', ';' ], 0 ],
  [ 'sideff_67' => 'sideff', [ 'expr' ], 0 ],
  [ 'sideff_68' => 'sideff', [ 'expr', 'IF', 'expr' ], 0 ],
  [ 'sideff_69' => 'sideff', [ 'expr', 'UNLESS', 'expr' ], 0 ],
  [ 'cond_70' => 'cond', [ 'IF', '(', 'expr', ')', 'block', 'else' ], 0 ],
  [ 'cond_71' => 'cond', [ 'UNLESS', '(', 'expr', ')', 'block', 'else' ], 0 ],
  [ 'else_72' => 'else', [  ], 0 ],
  [ 'else_73' => 'else', [ 'ELSE', 'block' ], 0 ],
  [ 'else_74' => 'else', [ 'ELSIF', '(', 'expr', ')', 'block', 'else' ], 0 ],
  [ 'listexpr_75' => 'listexpr', [  ], 0 ],
  [ 'listexpr_76' => 'listexpr', [ 'argexpr' ], 0 ],
  [ 'argexpr_77' => 'argexpr', [ 'argexpr', ',' ], 0 ],
  [ 'argexpr_78' => 'argexpr', [ 'argexpr', ',', 'term' ], 0 ],
  [ 'argexpr_79' => 'argexpr', [ 'term' ], 0 ],
  [ 'expr_80' => 'expr', [ 'expr', 'ANDOP', 'expr' ], 0 ],
  [ 'expr_81' => 'expr', [ 'expr', 'OROP', 'expr' ], 0 ],
  [ 'expr_82' => 'expr', [ 'expr', 'XOROP', 'expr' ], 0 ],
  [ 'expr_83' => 'expr', [ 'NOTOP', 'expr' ], 0 ],
  [ 'expr_84' => 'expr', [ 'term', 'unitspec' ], 0 ],
  [ 'funcall_85' => 'funcall', [ 'FUNC', '(', 'listexpr', ')' ], 0 ],
  [ 'funcall_86' => 'funcall', [ 'FUNC', '(', 'listexpr', ')', 'DOT', 'WORD' ], 0 ],
  [ 'term_87' => 'term', [ 'termbinop' ], 0 ],
  [ 'term_88' => 'term', [ 'termunop' ], 0 ],
  [ 'term_89' => 'term', [ 'term', '?', 'term', ':', 'term' ], 0 ],
  [ 'term_90' => 'term', [ '(', 'argexpr', ')' ], 0 ],
  [ 'term_91' => 'term', [ 'scalar' ], 0 ],
  [ 'term_92' => 'term', [ 'set' ], 0 ],
  [ 'term_93' => 'term', [ 'NUM', 'unitspec' ], 0 ],
  [ 'term_94' => 'term', [ 'STR' ], 0 ],
  [ 'term_95' => 'term', [ 'funcall' ], 0 ],
  [ 'term_96' => 'term', [ 'RETURN', 'expr' ], 0 ],
  [ 'termbinop_97' => 'termbinop', [ 'term', 'ASSIGNOP', 'term' ], 0 ],
  [ 'termbinop_98' => 'termbinop', [ 'term', '=', 'term' ], 0 ],
  [ 'termbinop_99' => 'termbinop', [ 'term', 'ADDOP', 'term' ], 0 ],
  [ 'termbinop_100' => 'termbinop', [ 'term', 'MULOP', 'term' ], 0 ],
  [ 'termbinop_101' => 'termbinop', [ 'term', 'POWOP', 'term' ], 0 ],
  [ 'termbinop_102' => 'termbinop', [ 'term', 'RELOP', 'term' ], 0 ],
  [ 'termbinop_103' => 'termbinop', [ 'term', 'DOTDOT', 'term' ], 0 ],
  [ 'termbinop_104' => 'termbinop', [ 'term', 'ANDAND', 'term' ], 0 ],
  [ 'termbinop_105' => 'termbinop', [ 'term', 'OROR', 'term' ], 0 ],
  [ 'termbinop_106' => 'termbinop', [ 'term', 'DORDOR', 'term' ], 0 ],
  [ 'termunop_107' => 'termunop', [ 'ADDOP', 'term' ], 0 ],
  [ 'termunop_108' => 'termunop', [ 'NOT2', 'term' ], 0 ],
  [ 'termunop_109' => 'termunop', [ 'term', 'INCOP' ], 0 ],
  [ 'termunop_110' => 'termunop', [ 'INCOP', 'term' ], 0 ],
  [ 'scalar_111' => 'scalar', [ '$', 'WORD' ], 0 ],
  [ 'set_112' => 'set', [ '@', 'WORD' ], 0 ],
  [ 'flow_113' => 'flow', [ 'scalar', 'MULOP', 'expr', 'FLOWRIGHT', 'scalar' ], 0 ],
  [ 'flow_114' => 'flow', [ 'scalar', 'MULOP', 'expr', 'FLOWLEFT', 'scalar' ], 0 ],
  [ 'flow_115' => 'flow', [ 'scalar', 'FLOWRIGHT', 'scalar', 'MULOP', 'expr' ], 0 ],
  [ 'flow_116' => 'flow', [ 'scalar', 'FLOWLEFT', 'scalar', 'MULOP', 'expr' ], 0 ],
  [ 'flow_117' => 'flow', [ 'scalar', '(', 'expr', ')', 'FLOWRIGHT', 'scalar' ], 0 ],
  [ 'flow_118' => 'flow', [ 'scalar', '(', 'expr', ')', 'FLOWLEFT', 'scalar' ], 0 ],
  [ 'flow_119' => 'flow', [ 'scalar', 'FLOWRIGHT', 'scalar', '(', 'expr', ')' ], 0 ],
  [ 'flow_120' => 'flow', [ 'scalar', 'FLOWLEFT', 'scalar', '(', 'expr', ')' ], 0 ],
],
    yyTERMS  =>
{ '' => { ISSEMANTIC => 0 },
	'$' => { ISSEMANTIC => 0 },
	'%{' => { ISSEMANTIC => 0 },
	'%}' => { ISSEMANTIC => 0 },
	'(' => { ISSEMANTIC => 0 },
	')' => { ISSEMANTIC => 0 },
	',' => { ISSEMANTIC => 0 },
	':' => { ISSEMANTIC => 0 },
	';' => { ISSEMANTIC => 0 },
	'<' => { ISSEMANTIC => 0 },
	'=' => { ISSEMANTIC => 0 },
	'=>' => { ISSEMANTIC => 0 },
	'>' => { ISSEMANTIC => 0 },
	'?' => { ISSEMANTIC => 0 },
	'@' => { ISSEMANTIC => 0 },
	'[' => { ISSEMANTIC => 0 },
	']' => { ISSEMANTIC => 0 },
	'{' => { ISSEMANTIC => 0 },
	'}' => { ISSEMANTIC => 0 },
	ADDOP => { ISSEMANTIC => 1 },
	ANDAND => { ISSEMANTIC => 1 },
	ANDOP => { ISSEMANTIC => 1 },
	ASSIGNOP => { ISSEMANTIC => 1 },
	CONST => { ISSEMANTIC => 1 },
	DORDOR => { ISSEMANTIC => 1 },
	DOT => { ISSEMANTIC => 1 },
	DOTDOT => { ISSEMANTIC => 1 },
	ELSE => { ISSEMANTIC => 1 },
	ELSIF => { ISSEMANTIC => 1 },
	EXTERNAL => { ISSEMANTIC => 1 },
	FLOWLEFT => { ISSEMANTIC => 1 },
	FLOWRIGHT => { ISSEMANTIC => 1 },
	FUNC => { ISSEMANTIC => 1 },
	FUNCTION => { ISSEMANTIC => 1 },
	IF => { ISSEMANTIC => 1 },
	INCLUDE => { ISSEMANTIC => 1 },
	INCOP => { ISSEMANTIC => 1 },
	INIT => { ISSEMANTIC => 1 },
	MODULE => { ISSEMANTIC => 1 },
	MULOP => { ISSEMANTIC => 1 },
	NOT2 => { ISSEMANTIC => 1 },
	NOTOP => { ISSEMANTIC => 1 },
	NUM => { ISSEMANTIC => 1 },
	OROP => { ISSEMANTIC => 1 },
	OROR => { ISSEMANTIC => 1 },
	PERL => { ISSEMANTIC => 1 },
	PERLPART => { ISSEMANTIC => 1 },
	POOL => { ISSEMANTIC => 1 },
	POWOP => { ISSEMANTIC => 1 },
	PREC_LOW => { ISSEMANTIC => 1 },
	RELOP => { ISSEMANTIC => 1 },
	RETURN => { ISSEMANTIC => 1 },
	STEP => { ISSEMANTIC => 1 },
	STR => { ISSEMANTIC => 1 },
	TIMESTEP => { ISSEMANTIC => 1 },
	UMINUS => { ISSEMANTIC => 1 },
	UNIT => { ISSEMANTIC => 1 },
	UNITS => { ISSEMANTIC => 1 },
	UNLESS => { ISSEMANTIC => 1 },
	VAR => { ISSEMANTIC => 1 },
	WORD => { ISSEMANTIC => 1 },
	XOROP => { ISSEMANTIC => 1 },
	error => { ISSEMANTIC => 0 },
},
    yyFILENAME  => 'Mad/Parser.eyp',
    yystates =>
[
	{#State 0
		DEFAULT => -2,
		GOTOS => {
			'progstart' => 1,
			'program' => 2
		}
	},
	{#State 1
		DEFAULT => -22,
		GOTOS => {
			'stmtseq' => 3
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
			"%{" => 7,
			'TIMESTEP' => 6,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'PERL' => 9,
			'POOL' => 10,
			'FUNC' => 33,
			'UNLESS' => 11,
			'NUM' => 12,
			'EXTERNAL' => 36,
			'UNITS' => 35,
			'STEP' => 13,
			'RETURN' => 38,
			'IF' => 16,
			"\$" => 15,
			'FUNCTION' => 43,
			'INIT' => 42,
			'STR' => 46,
			'NOTOP' => 21,
			'MODULE' => 47,
			"{" => 49,
			'CONST' => 50,
			'INCLUDE' => 23,
			"(" => 24,
			'VAR' => 26,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 5,
			'sideff' => 30,
			'function' => 29,
			'include' => 32,
			'term' => 34,
			'expr' => 37,
			'decl' => 14,
			'phase' => 40,
			'pool' => 39,
			'var' => 41,
			'termbinop' => 17,
			'flow' => 18,
			'module' => 45,
			'set' => 44,
			'termunop' => 19,
			'line' => 20,
			'cond' => 22,
			'funcall' => 48,
			'external' => 51,
			'const' => 25,
			'block' => 52,
			'units' => 53
		}
	},
	{#State 4
		DEFAULT => 0
	},
	{#State 5
		ACTIONS => {
			"<" => -91,
			'DORDOR' => -91,
			'XOROP' => -91,
			";" => -91,
			'FLOWLEFT' => 55,
			'ADDOP' => -91,
			'ANDOP' => -91,
			'UNLESS' => -91,
			'ASSIGNOP' => -91,
			'IF' => -91,
			'FLOWRIGHT' => 56,
			'POWOP' => -91,
			"?" => -91,
			'DOTDOT' => -91,
			'MULOP' => -91,
			'OROP' => -91,
			"=" => -91,
			"(" => 54,
			'OROR' => -91,
			'ANDAND' => -91,
			'INCOP' => -91,
			'RELOP' => -91
		}
	},
	{#State 6
		DEFAULT => -45
	},
	{#State 7
		DEFAULT => -11,
		GOTOS => {
			'@10-1' => 58
		}
	},
	{#State 8
		ACTIONS => {
			'WORD' => 59
		}
	},
	{#State 9
		ACTIONS => {
			"{" => 60
		}
	},
	{#State 10
		ACTIONS => {
			"\@" => 8,
			"\$" => 15
		},
		GOTOS => {
			'vardecl' => 62,
			'scalar' => 61,
			'set' => 63
		}
	},
	{#State 11
		ACTIONS => {
			"(" => 64
		}
	},
	{#State 12
		ACTIONS => {
			"}" => -18,
			":" => -18,
			'DORDOR' => -18,
			'XOROP' => -18,
			"<" => 65,
			";" => -18,
			'FLOWLEFT' => -18,
			'ADDOP' => -18,
			"," => -18,
			'ANDOP' => -18,
			'UNLESS' => -18,
			'ASSIGNOP' => -18,
			'IF' => -18,
			'FLOWRIGHT' => -18,
			")" => -18,
			'POWOP' => -18,
			"?" => -18,
			'DOTDOT' => -18,
			'MULOP' => -18,
			'OROP' => -18,
			"=" => -18,
			'OROR' => -18,
			'ANDAND' => -18,
			'RELOP' => -18,
			'INCOP' => -18
		},
		GOTOS => {
			'unitspec' => 66
		}
	},
	{#State 13
		DEFAULT => -44
	},
	{#State 14
		DEFAULT => -23
	},
	{#State 15
		ACTIONS => {
			'WORD' => 67
		}
	},
	{#State 16
		ACTIONS => {
			"(" => 68
		}
	},
	{#State 17
		DEFAULT => -87
	},
	{#State 18
		ACTIONS => {
			";" => 69
		}
	},
	{#State 19
		DEFAULT => -88
	},
	{#State 20
		DEFAULT => -24
	},
	{#State 21
		ACTIONS => {
			'STR' => 46,
			'NOTOP' => 21,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'expr' => 71,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 34,
			'termunop' => 19
		}
	},
	{#State 22
		DEFAULT => -64
	},
	{#State 23
		ACTIONS => {
			'WORD' => 72
		}
	},
	{#State 24
		ACTIONS => {
			'STR' => 46,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'funcall' => 48,
			'termbinop' => 17,
			'argexpr' => 74,
			'set' => 44,
			'term' => 73,
			'termunop' => 19
		}
	},
	{#State 25
		DEFAULT => -25
	},
	{#State 26
		ACTIONS => {
			"\@" => 8,
			"\$" => 15
		},
		GOTOS => {
			'vardecl' => 75,
			'scalar' => 61,
			'set' => 63
		}
	},
	{#State 27
		ACTIONS => {
			'STR' => 46,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 76,
			'termunop' => 19
		}
	},
	{#State 28
		ACTIONS => {
			'STR' => 46,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 77,
			'termunop' => 19
		}
	},
	{#State 29
		DEFAULT => -32
	},
	{#State 30
		ACTIONS => {
			";" => 78
		}
	},
	{#State 31
		ACTIONS => {
			'STR' => 46,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 79,
			'termunop' => 19
		}
	},
	{#State 32
		DEFAULT => -28
	},
	{#State 33
		ACTIONS => {
			"(" => 80
		}
	},
	{#State 34
		ACTIONS => {
			"}" => -18,
			":" => -18,
			'XOROP' => -18,
			'DORDOR' => 81,
			"<" => 65,
			";" => -18,
			'FLOWLEFT' => -18,
			'ADDOP' => 88,
			"," => -18,
			'ANDOP' => -18,
			'UNLESS' => -18,
			'ASSIGNOP' => 82,
			'IF' => -18,
			'FLOWRIGHT' => -18,
			")" => -18,
			'POWOP' => 83,
			"?" => 89,
			'OROP' => -18,
			'DOTDOT' => 90,
			'MULOP' => 91,
			"=" => 92,
			'ANDAND' => 85,
			'OROR' => 93,
			'RELOP' => 87,
			'INCOP' => 86
		},
		GOTOS => {
			'unitspec' => 84
		}
	},
	{#State 35
		ACTIONS => {
			'WORD' => 94
		},
		GOTOS => {
			'wordlist' => 95
		}
	},
	{#State 36
		ACTIONS => {
			'WORD' => 96
		}
	},
	{#State 37
		ACTIONS => {
			'XOROP' => 97,
			";" => -67,
			'IF' => 100,
			'OROP' => 101,
			'ANDOP' => 98,
			'UNLESS' => 99
		}
	},
	{#State 38
		ACTIONS => {
			'STR' => 46,
			'NOTOP' => 21,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'expr' => 102,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 34,
			'termunop' => 19
		}
	},
	{#State 39
		DEFAULT => -27
	},
	{#State 40
		ACTIONS => {
			'STR' => 46,
			'NOTOP' => 21,
			"%{" => 7,
			'NOT2' => 28,
			"\@" => 8,
			"{" => 49,
			'ADDOP' => 31,
			'PERL' => 9,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'sideff' => 103,
			'funcall' => 48,
			'term' => 34,
			'expr' => 37,
			'termbinop' => 17,
			'block' => 104,
			'termunop' => 19,
			'set' => 44
		}
	},
	{#State 41
		DEFAULT => -26
	},
	{#State 42
		DEFAULT => -43
	},
	{#State 43
		ACTIONS => {
			'WORD' => 105
		}
	},
	{#State 44
		DEFAULT => -92
	},
	{#State 45
		DEFAULT => -29
	},
	{#State 46
		DEFAULT => -94
	},
	{#State 47
		ACTIONS => {
			'WORD' => 106
		}
	},
	{#State 48
		DEFAULT => -95
	},
	{#State 49
		DEFAULT => -22,
		GOTOS => {
			'stmtseq' => 107
		}
	},
	{#State 50
		ACTIONS => {
			"\@" => 8,
			"\$" => 15
		},
		GOTOS => {
			'vardecl' => 108,
			'scalar' => 61,
			'set' => 63
		}
	},
	{#State 51
		DEFAULT => -31
	},
	{#State 52
		DEFAULT => -63
	},
	{#State 53
		DEFAULT => -30
	},
	{#State 54
		ACTIONS => {
			'STR' => 46,
			'NOTOP' => 21,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'expr' => 109,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 34,
			'termunop' => 19
		}
	},
	{#State 55
		ACTIONS => {
			"\$" => 15
		},
		GOTOS => {
			'scalar' => 110
		}
	},
	{#State 56
		ACTIONS => {
			"\$" => 15
		},
		GOTOS => {
			'scalar' => 111
		}
	},
	{#State 57
		ACTIONS => {
			'STR' => 46,
			'NOTOP' => 21,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'expr' => 112,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 34,
			'termunop' => 19
		}
	},
	{#State 58
		DEFAULT => -6,
		GOTOS => {
			'STAR-2' => 113
		}
	},
	{#State 59
		DEFAULT => -112
	},
	{#State 60
		DEFAULT => -9,
		GOTOS => {
			'@8-2' => 114
		}
	},
	{#State 61
		ACTIONS => {
			'TIMESTEP' => -18,
			'STEP' => -18,
			"<" => 65,
			";" => -18,
			'INIT' => -18,
			"[" => 115,
			"=" => -18
		},
		GOTOS => {
			'unitspec' => 116
		}
	},
	{#State 62
		ACTIONS => {
			'TIMESTEP' => 6,
			'STEP' => 13,
			";" => 117,
			'INIT' => 42,
			"=" => -42
		},
		GOTOS => {
			'phase' => 118
		}
	},
	{#State 63
		ACTIONS => {
			'TIMESTEP' => -18,
			'STEP' => -18,
			"<" => 65,
			";" => -18,
			'INIT' => -18,
			"=" => -18
		},
		GOTOS => {
			'unitspec' => 119
		}
	},
	{#State 64
		ACTIONS => {
			'STR' => 46,
			'NOTOP' => 21,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'expr' => 120,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 34,
			'termunop' => 19
		}
	},
	{#State 65
		DEFAULT => -20,
		GOTOS => {
			'unitlist' => 121
		}
	},
	{#State 66
		DEFAULT => -93
	},
	{#State 67
		DEFAULT => -111
	},
	{#State 68
		ACTIONS => {
			'STR' => 46,
			'NOTOP' => 21,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'expr' => 122,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 34,
			'termunop' => 19
		}
	},
	{#State 69
		DEFAULT => -65
	},
	{#State 70
		DEFAULT => -91
	},
	{#State 71
		ACTIONS => {
			"}" => -83,
			":" => -83,
			"<" => -83,
			'DORDOR' => -83,
			'XOROP' => -83,
			";" => -83,
			'FLOWLEFT' => -83,
			'ADDOP' => -83,
			"," => -83,
			'ANDOP' => -83,
			'UNLESS' => -83,
			'ASSIGNOP' => -83,
			'IF' => -83,
			'FLOWRIGHT' => -83,
			")" => -83,
			'POWOP' => -83,
			"?" => -83,
			'DOTDOT' => -83,
			'MULOP' => -83,
			'OROP' => -83,
			"=" => -83,
			'OROR' => -83,
			'ANDAND' => -83,
			'RELOP' => -83,
			'INCOP' => -83
		}
	},
	{#State 72
		ACTIONS => {
			";" => 123
		}
	},
	{#State 73
		ACTIONS => {
			"?" => 89,
			'DORDOR' => 81,
			'MULOP' => 91,
			'DOTDOT' => 90,
			'ADDOP' => 88,
			"," => -79,
			"=" => 92,
			'ASSIGNOP' => 82,
			'OROR' => 93,
			'ANDAND' => 85,
			")" => -79,
			'POWOP' => 83,
			'INCOP' => 86,
			'RELOP' => 87
		}
	},
	{#State 74
		ACTIONS => {
			"," => 124,
			")" => 125
		}
	},
	{#State 75
		ACTIONS => {
			'TIMESTEP' => 6,
			'STEP' => 13,
			";" => 126,
			'INIT' => 42,
			"=" => -42
		},
		GOTOS => {
			'phase' => 127
		}
	},
	{#State 76
		ACTIONS => {
			"}" => -110,
			":" => -110,
			"<" => -110,
			'XOROP' => -110,
			'DORDOR' => -110,
			";" => -110,
			'FLOWLEFT' => -110,
			'ADDOP' => -110,
			"," => -110,
			'ANDOP' => -110,
			'UNLESS' => -110,
			'ASSIGNOP' => -110,
			'IF' => -110,
			'FLOWRIGHT' => -110,
			")" => -110,
			'POWOP' => -110,
			"?" => -110,
			'OROP' => -110,
			'DOTDOT' => -110,
			'MULOP' => -110,
			"=" => -110,
			'ANDAND' => -110,
			'OROR' => -110,
			'RELOP' => -110,
			'INCOP' => undef
		}
	},
	{#State 77
		ACTIONS => {
			"}" => -108,
			":" => -108,
			"<" => -108,
			'XOROP' => -108,
			'DORDOR' => -108,
			";" => -108,
			'FLOWLEFT' => -108,
			'ADDOP' => -108,
			"," => -108,
			'ANDOP' => -108,
			'UNLESS' => -108,
			'ASSIGNOP' => -108,
			'IF' => -108,
			'FLOWRIGHT' => -108,
			")" => -108,
			'POWOP' => 83,
			"?" => -108,
			'OROP' => -108,
			'DOTDOT' => -108,
			'MULOP' => -108,
			"=" => -108,
			'ANDAND' => -108,
			'OROR' => -108,
			'RELOP' => -108,
			'INCOP' => 86
		}
	},
	{#State 78
		DEFAULT => -66
	},
	{#State 79
		ACTIONS => {
			"}" => -107,
			":" => -107,
			"<" => -107,
			'XOROP' => -107,
			'DORDOR' => -107,
			";" => -107,
			'FLOWLEFT' => -107,
			'ADDOP' => -107,
			"," => -107,
			'ANDOP' => -107,
			'UNLESS' => -107,
			'ASSIGNOP' => -107,
			'IF' => -107,
			'FLOWRIGHT' => -107,
			")" => -107,
			'POWOP' => 83,
			"?" => -107,
			'OROP' => -107,
			'DOTDOT' => -107,
			'MULOP' => -107,
			"=" => -107,
			'ANDAND' => -107,
			'OROR' => -107,
			'RELOP' => -107,
			'INCOP' => 86
		}
	},
	{#State 80
		ACTIONS => {
			'STR' => 46,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			")" => -75,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'funcall' => 48,
			'termbinop' => 17,
			'argexpr' => 129,
			'listexpr' => 128,
			'set' => 44,
			'term' => 73,
			'termunop' => 19
		}
	},
	{#State 81
		ACTIONS => {
			'STR' => 46,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 130,
			'termunop' => 19
		}
	},
	{#State 82
		ACTIONS => {
			'STR' => 46,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 131,
			'termunop' => 19
		}
	},
	{#State 83
		ACTIONS => {
			'STR' => 46,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 132,
			'termunop' => 19
		}
	},
	{#State 84
		DEFAULT => -84
	},
	{#State 85
		ACTIONS => {
			'STR' => 46,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 133,
			'termunop' => 19
		}
	},
	{#State 86
		DEFAULT => -109
	},
	{#State 87
		ACTIONS => {
			'STR' => 46,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 134,
			'termunop' => 19
		}
	},
	{#State 88
		ACTIONS => {
			'STR' => 46,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 135,
			'termunop' => 19
		}
	},
	{#State 89
		ACTIONS => {
			'STR' => 46,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 136,
			'termunop' => 19
		}
	},
	{#State 90
		ACTIONS => {
			'STR' => 46,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 137,
			'termunop' => 19
		}
	},
	{#State 91
		ACTIONS => {
			'STR' => 46,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 138,
			'termunop' => 19
		}
	},
	{#State 92
		ACTIONS => {
			'STR' => 46,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 139,
			'termunop' => 19
		}
	},
	{#State 93
		ACTIONS => {
			'STR' => 46,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 140,
			'termunop' => 19
		}
	},
	{#State 94
		DEFAULT => -49
	},
	{#State 95
		ACTIONS => {
			";" => 141,
			"," => 142
		}
	},
	{#State 96
		ACTIONS => {
			"(" => 143,
			"<" => -57,
			"{" => -57
		},
		GOTOS => {
			'funargs' => 144
		}
	},
	{#State 97
		ACTIONS => {
			'STR' => 46,
			'NOTOP' => 21,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'expr' => 145,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 34,
			'termunop' => 19
		}
	},
	{#State 98
		ACTIONS => {
			'STR' => 46,
			'NOTOP' => 21,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'expr' => 146,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 34,
			'termunop' => 19
		}
	},
	{#State 99
		ACTIONS => {
			'STR' => 46,
			'NOTOP' => 21,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'expr' => 147,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 34,
			'termunop' => 19
		}
	},
	{#State 100
		ACTIONS => {
			'STR' => 46,
			'NOTOP' => 21,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'expr' => 148,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 34,
			'termunop' => 19
		}
	},
	{#State 101
		ACTIONS => {
			'STR' => 46,
			'NOTOP' => 21,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'expr' => 149,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 34,
			'termunop' => 19
		}
	},
	{#State 102
		ACTIONS => {
			"}" => -96,
			":" => -96,
			"<" => -96,
			'DORDOR' => -96,
			'XOROP' => 97,
			";" => -96,
			'FLOWLEFT' => -96,
			'ADDOP' => -96,
			"," => -96,
			'ANDOP' => 98,
			'UNLESS' => -96,
			'ASSIGNOP' => -96,
			'IF' => -96,
			'FLOWRIGHT' => -96,
			")" => -96,
			'POWOP' => -96,
			"?" => -96,
			'DOTDOT' => -96,
			'MULOP' => -96,
			'OROP' => 101,
			"=" => -96,
			'OROR' => -96,
			'ANDAND' => -96,
			'RELOP' => -96,
			'INCOP' => -96
		}
	},
	{#State 103
		ACTIONS => {
			";" => 150
		}
	},
	{#State 104
		DEFAULT => -61
	},
	{#State 105
		ACTIONS => {
			"%{" => -57,
			"(" => 143,
			"<" => -57,
			";" => -57,
			"{" => -57,
			'PERL' => -57
		},
		GOTOS => {
			'funargs' => 151
		}
	},
	{#State 106
		ACTIONS => {
			";" => 152
		}
	},
	{#State 107
		ACTIONS => {
			"}" => 153,
			"%{" => 7,
			'TIMESTEP' => 6,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'PERL' => 9,
			'POOL' => 10,
			'FUNC' => 33,
			'UNLESS' => 11,
			'NUM' => 12,
			'UNITS' => 35,
			'EXTERNAL' => 36,
			'STEP' => 13,
			'RETURN' => 38,
			'IF' => 16,
			"\$" => 15,
			'INIT' => 42,
			'FUNCTION' => 43,
			'STR' => 46,
			'NOTOP' => 21,
			'MODULE' => 47,
			"{" => 49,
			'CONST' => 50,
			'INCLUDE' => 23,
			"(" => 24,
			'VAR' => 26,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 5,
			'function' => 29,
			'sideff' => 30,
			'include' => 32,
			'term' => 34,
			'expr' => 37,
			'decl' => 14,
			'pool' => 39,
			'phase' => 40,
			'var' => 41,
			'termbinop' => 17,
			'flow' => 18,
			'module' => 45,
			'set' => 44,
			'termunop' => 19,
			'line' => 20,
			'cond' => 22,
			'funcall' => 48,
			'external' => 51,
			'const' => 25,
			'block' => 52,
			'units' => 53
		}
	},
	{#State 108
		ACTIONS => {
			";" => 154,
			"=" => 155
		}
	},
	{#State 109
		ACTIONS => {
			'XOROP' => 97,
			'OROP' => 101,
			")" => 156,
			'ANDOP' => 98
		}
	},
	{#State 110
		ACTIONS => {
			"(" => 157,
			'MULOP' => 158
		}
	},
	{#State 111
		ACTIONS => {
			"(" => 159,
			'MULOP' => 160
		}
	},
	{#State 112
		ACTIONS => {
			'XOROP' => 97,
			'FLOWLEFT' => 161,
			'OROP' => 101,
			'FLOWRIGHT' => 162,
			'ANDOP' => 98
		}
	},
	{#State 113
		ACTIONS => {
			'PERLPART' => 164,
			"%}" => 163
		}
	},
	{#State 114
		DEFAULT => -4,
		GOTOS => {
			'STAR-1' => 165
		}
	},
	{#State 115
		ACTIONS => {
			"\@" => 8
		},
		GOTOS => {
			'set' => 166
		}
	},
	{#State 116
		DEFAULT => -39
	},
	{#State 117
		DEFAULT => -38
	},
	{#State 118
		ACTIONS => {
			"=" => 167
		}
	},
	{#State 119
		DEFAULT => -41
	},
	{#State 120
		ACTIONS => {
			'XOROP' => 97,
			'OROP' => 101,
			")" => 168,
			'ANDOP' => 98
		}
	},
	{#State 121
		ACTIONS => {
			'UNIT' => 170,
			">" => 169
		}
	},
	{#State 122
		ACTIONS => {
			'XOROP' => 97,
			'OROP' => 101,
			")" => 171,
			'ANDOP' => 98
		}
	},
	{#State 123
		DEFAULT => -46
	},
	{#State 124
		ACTIONS => {
			'STR' => 46,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			"," => -77,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			")" => -77,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 172,
			'termunop' => 19
		}
	},
	{#State 125
		DEFAULT => -90
	},
	{#State 126
		DEFAULT => -36
	},
	{#State 127
		ACTIONS => {
			"=" => 173
		}
	},
	{#State 128
		ACTIONS => {
			")" => 174
		}
	},
	{#State 129
		ACTIONS => {
			"," => 124,
			")" => -76
		}
	},
	{#State 130
		ACTIONS => {
			"}" => -106,
			":" => -106,
			"<" => -106,
			'XOROP' => -106,
			'DORDOR' => -106,
			";" => -106,
			'FLOWLEFT' => -106,
			'ADDOP' => 88,
			"," => -106,
			'ANDOP' => -106,
			'UNLESS' => -106,
			'ASSIGNOP' => -106,
			'IF' => -106,
			'FLOWRIGHT' => -106,
			")" => -106,
			'POWOP' => 83,
			"?" => -106,
			'OROP' => -106,
			'DOTDOT' => -106,
			'MULOP' => 91,
			"=" => -106,
			'ANDAND' => 85,
			'OROR' => -106,
			'RELOP' => 87,
			'INCOP' => 86
		}
	},
	{#State 131
		ACTIONS => {
			"}" => -97,
			":" => -97,
			"<" => -97,
			'XOROP' => -97,
			'DORDOR' => 81,
			";" => -97,
			'FLOWLEFT' => -97,
			'ADDOP' => 88,
			"," => -97,
			'ANDOP' => -97,
			'UNLESS' => -97,
			'ASSIGNOP' => 82,
			'IF' => -97,
			'FLOWRIGHT' => -97,
			")" => -97,
			'POWOP' => 83,
			"?" => 89,
			'OROP' => -97,
			'DOTDOT' => 90,
			'MULOP' => 91,
			"=" => 92,
			'ANDAND' => 85,
			'OROR' => 93,
			'RELOP' => 87,
			'INCOP' => 86
		}
	},
	{#State 132
		ACTIONS => {
			"}" => -101,
			":" => -101,
			"<" => -101,
			'XOROP' => -101,
			'DORDOR' => -101,
			";" => -101,
			'FLOWLEFT' => -101,
			'ADDOP' => -101,
			"," => -101,
			'ANDOP' => -101,
			'UNLESS' => -101,
			'ASSIGNOP' => -101,
			'IF' => -101,
			'FLOWRIGHT' => -101,
			")" => -101,
			'POWOP' => 83,
			"?" => -101,
			'OROP' => -101,
			'DOTDOT' => -101,
			'MULOP' => -101,
			"=" => -101,
			'ANDAND' => -101,
			'OROR' => -101,
			'RELOP' => -101,
			'INCOP' => 86
		}
	},
	{#State 133
		ACTIONS => {
			"}" => -104,
			":" => -104,
			"<" => -104,
			'XOROP' => -104,
			'DORDOR' => -104,
			";" => -104,
			'FLOWLEFT' => -104,
			'ADDOP' => 88,
			"," => -104,
			'ANDOP' => -104,
			'UNLESS' => -104,
			'ASSIGNOP' => -104,
			'IF' => -104,
			'FLOWRIGHT' => -104,
			")" => -104,
			'POWOP' => 83,
			"?" => -104,
			'OROP' => -104,
			'DOTDOT' => -104,
			'MULOP' => 91,
			"=" => -104,
			'ANDAND' => -104,
			'OROR' => -104,
			'RELOP' => 87,
			'INCOP' => 86
		}
	},
	{#State 134
		ACTIONS => {
			"}" => -102,
			":" => -102,
			"<" => -102,
			'XOROP' => -102,
			'DORDOR' => -102,
			";" => -102,
			'FLOWLEFT' => -102,
			'ADDOP' => 88,
			"," => -102,
			'ANDOP' => -102,
			'UNLESS' => -102,
			'ASSIGNOP' => -102,
			'IF' => -102,
			'FLOWRIGHT' => -102,
			")" => -102,
			'POWOP' => 83,
			"?" => -102,
			'OROP' => -102,
			'DOTDOT' => -102,
			'MULOP' => 91,
			"=" => -102,
			'ANDAND' => -102,
			'OROR' => -102,
			'RELOP' => undef,
			'INCOP' => 86
		}
	},
	{#State 135
		ACTIONS => {
			"}" => -99,
			":" => -99,
			"<" => -99,
			'XOROP' => -99,
			'DORDOR' => -99,
			";" => -99,
			'FLOWLEFT' => -99,
			'ADDOP' => -99,
			"," => -99,
			'ANDOP' => -99,
			'UNLESS' => -99,
			'ASSIGNOP' => -99,
			'IF' => -99,
			'FLOWRIGHT' => -99,
			")" => -99,
			'POWOP' => 83,
			"?" => -99,
			'OROP' => -99,
			'DOTDOT' => -99,
			'MULOP' => 91,
			"=" => -99,
			'ANDAND' => -99,
			'OROR' => -99,
			'RELOP' => -99,
			'INCOP' => 86
		}
	},
	{#State 136
		ACTIONS => {
			":" => 175,
			"?" => 89,
			'DORDOR' => 81,
			'MULOP' => 91,
			'DOTDOT' => 90,
			'ADDOP' => 88,
			"=" => 92,
			'ASSIGNOP' => 82,
			'OROR' => 93,
			'ANDAND' => 85,
			'POWOP' => 83,
			'INCOP' => 86,
			'RELOP' => 87
		}
	},
	{#State 137
		ACTIONS => {
			"}" => -103,
			":" => -103,
			"<" => -103,
			'XOROP' => -103,
			'DORDOR' => 81,
			";" => -103,
			'FLOWLEFT' => -103,
			'ADDOP' => 88,
			"," => -103,
			'ANDOP' => -103,
			'UNLESS' => -103,
			'ASSIGNOP' => -103,
			'IF' => -103,
			'FLOWRIGHT' => -103,
			")" => -103,
			'POWOP' => 83,
			"?" => -103,
			'OROP' => -103,
			'DOTDOT' => undef,
			'MULOP' => 91,
			"=" => -103,
			'ANDAND' => 85,
			'OROR' => 93,
			'RELOP' => 87,
			'INCOP' => 86
		}
	},
	{#State 138
		ACTIONS => {
			"}" => -100,
			":" => -100,
			"<" => -100,
			'XOROP' => -100,
			'DORDOR' => -100,
			";" => -100,
			'FLOWLEFT' => -100,
			'ADDOP' => -100,
			"," => -100,
			'ANDOP' => -100,
			'UNLESS' => -100,
			'ASSIGNOP' => -100,
			'IF' => -100,
			'FLOWRIGHT' => -100,
			")" => -100,
			'POWOP' => 83,
			"?" => -100,
			'OROP' => -100,
			'DOTDOT' => -100,
			'MULOP' => -100,
			"=" => -100,
			'ANDAND' => -100,
			'OROR' => -100,
			'RELOP' => -100,
			'INCOP' => 86
		}
	},
	{#State 139
		ACTIONS => {
			"}" => -98,
			":" => -98,
			"<" => -98,
			'XOROP' => -98,
			'DORDOR' => 81,
			";" => -98,
			'FLOWLEFT' => -98,
			'ADDOP' => 88,
			"," => -98,
			'ANDOP' => -98,
			'UNLESS' => -98,
			'ASSIGNOP' => 82,
			'IF' => -98,
			'FLOWRIGHT' => -98,
			")" => -98,
			'POWOP' => 83,
			"?" => 89,
			'OROP' => -98,
			'DOTDOT' => 90,
			'MULOP' => 91,
			"=" => 92,
			'ANDAND' => 85,
			'OROR' => 93,
			'RELOP' => 87,
			'INCOP' => 86
		}
	},
	{#State 140
		ACTIONS => {
			"}" => -105,
			":" => -105,
			"<" => -105,
			'XOROP' => -105,
			'DORDOR' => -105,
			";" => -105,
			'FLOWLEFT' => -105,
			'ADDOP' => 88,
			"," => -105,
			'ANDOP' => -105,
			'UNLESS' => -105,
			'ASSIGNOP' => -105,
			'IF' => -105,
			'FLOWRIGHT' => -105,
			")" => -105,
			'POWOP' => 83,
			"?" => -105,
			'OROP' => -105,
			'DOTDOT' => -105,
			'MULOP' => 91,
			"=" => -105,
			'ANDAND' => 85,
			'OROR' => -105,
			'RELOP' => 87,
			'INCOP' => 86
		}
	},
	{#State 141
		DEFAULT => -48
	},
	{#State 142
		ACTIONS => {
			'WORD' => 176
		}
	},
	{#State 143
		ACTIONS => {
			"\$" => 15,
			")" => -56
		},
		GOTOS => {
			'scalar' => 177,
			'STAR-5' => 178,
			'STAR-6' => 179
		}
	},
	{#State 144
		ACTIONS => {
			"<" => 65,
			"{" => -18
		},
		GOTOS => {
			'unitspec' => 180
		}
	},
	{#State 145
		ACTIONS => {
			"}" => -82,
			":" => -82,
			"<" => -82,
			'DORDOR' => -82,
			'XOROP' => -82,
			";" => -82,
			'FLOWLEFT' => -82,
			'ADDOP' => -82,
			"," => -82,
			'ANDOP' => 98,
			'UNLESS' => -82,
			'ASSIGNOP' => -82,
			'IF' => -82,
			'FLOWRIGHT' => -82,
			")" => -82,
			'POWOP' => -82,
			"?" => -82,
			'DOTDOT' => -82,
			'MULOP' => -82,
			'OROP' => -82,
			"=" => -82,
			'OROR' => -82,
			'ANDAND' => -82,
			'RELOP' => -82,
			'INCOP' => -82
		}
	},
	{#State 146
		ACTIONS => {
			"}" => -80,
			":" => -80,
			"<" => -80,
			'DORDOR' => -80,
			'XOROP' => -80,
			";" => -80,
			'FLOWLEFT' => -80,
			'ADDOP' => -80,
			"," => -80,
			'ANDOP' => -80,
			'UNLESS' => -80,
			'ASSIGNOP' => -80,
			'IF' => -80,
			'FLOWRIGHT' => -80,
			")" => -80,
			'POWOP' => -80,
			"?" => -80,
			'DOTDOT' => -80,
			'MULOP' => -80,
			'OROP' => -80,
			"=" => -80,
			'OROR' => -80,
			'ANDAND' => -80,
			'RELOP' => -80,
			'INCOP' => -80
		}
	},
	{#State 147
		ACTIONS => {
			'XOROP' => 97,
			";" => -69,
			'OROP' => 101,
			'ANDOP' => 98
		}
	},
	{#State 148
		ACTIONS => {
			'XOROP' => 97,
			";" => -68,
			'OROP' => 101,
			'ANDOP' => 98
		}
	},
	{#State 149
		ACTIONS => {
			"}" => -81,
			":" => -81,
			"<" => -81,
			'DORDOR' => -81,
			'XOROP' => -81,
			";" => -81,
			'FLOWLEFT' => -81,
			'ADDOP' => -81,
			"," => -81,
			'ANDOP' => 98,
			'UNLESS' => -81,
			'ASSIGNOP' => -81,
			'IF' => -81,
			'FLOWRIGHT' => -81,
			")" => -81,
			'POWOP' => -81,
			"?" => -81,
			'DOTDOT' => -81,
			'MULOP' => -81,
			'OROP' => -81,
			"=" => -81,
			'OROR' => -81,
			'ANDAND' => -81,
			'RELOP' => -81,
			'INCOP' => -81
		}
	},
	{#State 150
		DEFAULT => -62
	},
	{#State 151
		ACTIONS => {
			"%{" => -18,
			"<" => 65,
			";" => -18,
			"{" => -18,
			'PERL' => -18
		},
		GOTOS => {
			'unitspec' => 181
		}
	},
	{#State 152
		DEFAULT => -47
	},
	{#State 153
		DEFAULT => -7
	},
	{#State 154
		DEFAULT => -34
	},
	{#State 155
		ACTIONS => {
			'STR' => 46,
			'NOTOP' => 21,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'expr' => 182,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 34,
			'termunop' => 19
		}
	},
	{#State 156
		ACTIONS => {
			'FLOWLEFT' => 183,
			'FLOWRIGHT' => 184
		}
	},
	{#State 157
		ACTIONS => {
			'STR' => 46,
			'NOTOP' => 21,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'expr' => 185,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 34,
			'termunop' => 19
		}
	},
	{#State 158
		ACTIONS => {
			'STR' => 46,
			'NOTOP' => 21,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'expr' => 186,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 34,
			'termunop' => 19
		}
	},
	{#State 159
		ACTIONS => {
			'STR' => 46,
			'NOTOP' => 21,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'expr' => 187,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 34,
			'termunop' => 19
		}
	},
	{#State 160
		ACTIONS => {
			'STR' => 46,
			'NOTOP' => 21,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'expr' => 188,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 34,
			'termunop' => 19
		}
	},
	{#State 161
		ACTIONS => {
			"\$" => 15
		},
		GOTOS => {
			'scalar' => 189
		}
	},
	{#State 162
		ACTIONS => {
			"\$" => 15
		},
		GOTOS => {
			'scalar' => 190
		}
	},
	{#State 163
		DEFAULT => -10
	},
	{#State 164
		DEFAULT => -5
	},
	{#State 165
		ACTIONS => {
			"}" => 191,
			'PERLPART' => 192
		}
	},
	{#State 166
		ACTIONS => {
			"]" => 193
		}
	},
	{#State 167
		ACTIONS => {
			'STR' => 46,
			'NOTOP' => 21,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'expr' => 194,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 34,
			'termunop' => 19
		}
	},
	{#State 168
		ACTIONS => {
			"%{" => 7,
			"{" => 49,
			'PERL' => 9
		},
		GOTOS => {
			'block' => 195
		}
	},
	{#State 169
		DEFAULT => -19
	},
	{#State 170
		DEFAULT => -21
	},
	{#State 171
		ACTIONS => {
			"%{" => 7,
			"{" => 49,
			'PERL' => 9
		},
		GOTOS => {
			'block' => 196
		}
	},
	{#State 172
		ACTIONS => {
			"?" => 89,
			'DORDOR' => 81,
			'MULOP' => 91,
			'DOTDOT' => 90,
			'ADDOP' => 88,
			"," => -78,
			"=" => 92,
			'ASSIGNOP' => 82,
			'OROR' => 93,
			'ANDAND' => 85,
			")" => -78,
			'POWOP' => 83,
			'INCOP' => 86,
			'RELOP' => 87
		}
	},
	{#State 173
		ACTIONS => {
			'STR' => 46,
			'NOTOP' => 21,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'expr' => 197,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 34,
			'termunop' => 19
		}
	},
	{#State 174
		ACTIONS => {
			"}" => -85,
			":" => -85,
			"<" => -85,
			'DORDOR' => -85,
			'XOROP' => -85,
			";" => -85,
			'FLOWLEFT' => -85,
			'ADDOP' => -85,
			"," => -85,
			'ANDOP' => -85,
			'UNLESS' => -85,
			'ASSIGNOP' => -85,
			'IF' => -85,
			'FLOWRIGHT' => -85,
			")" => -85,
			'POWOP' => -85,
			"?" => -85,
			'DOT' => 198,
			'DOTDOT' => -85,
			'MULOP' => -85,
			'OROP' => -85,
			"=" => -85,
			'OROR' => -85,
			'ANDAND' => -85,
			'RELOP' => -85,
			'INCOP' => -85
		}
	},
	{#State 175
		ACTIONS => {
			'STR' => 46,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 199,
			'termunop' => 19
		}
	},
	{#State 176
		DEFAULT => -50
	},
	{#State 177
		DEFAULT => -54
	},
	{#State 178
		ACTIONS => {
			"," => 200,
			")" => -55
		}
	},
	{#State 179
		ACTIONS => {
			")" => 201
		}
	},
	{#State 180
		ACTIONS => {
			"{" => 203
		},
		GOTOS => {
			'pairblock' => 202
		}
	},
	{#State 181
		ACTIONS => {
			"%{" => 7,
			";" => 204,
			"{" => 49,
			'PERL' => 9
		},
		GOTOS => {
			'funbody' => 205,
			'block' => 206
		}
	},
	{#State 182
		ACTIONS => {
			'XOROP' => 97,
			";" => 207,
			'OROP' => 101,
			'ANDOP' => 98
		}
	},
	{#State 183
		ACTIONS => {
			"\$" => 15
		},
		GOTOS => {
			'scalar' => 208
		}
	},
	{#State 184
		ACTIONS => {
			"\$" => 15
		},
		GOTOS => {
			'scalar' => 209
		}
	},
	{#State 185
		ACTIONS => {
			'XOROP' => 97,
			'OROP' => 101,
			")" => 210,
			'ANDOP' => 98
		}
	},
	{#State 186
		ACTIONS => {
			'XOROP' => 97,
			";" => -116,
			'OROP' => 101,
			'ANDOP' => 98
		}
	},
	{#State 187
		ACTIONS => {
			'XOROP' => 97,
			'OROP' => 101,
			")" => 211,
			'ANDOP' => 98
		}
	},
	{#State 188
		ACTIONS => {
			'XOROP' => 97,
			";" => -115,
			'OROP' => 101,
			'ANDOP' => 98
		}
	},
	{#State 189
		DEFAULT => -114
	},
	{#State 190
		DEFAULT => -113
	},
	{#State 191
		DEFAULT => -8
	},
	{#State 192
		DEFAULT => -3
	},
	{#State 193
		ACTIONS => {
			'TIMESTEP' => -18,
			'STEP' => -18,
			"<" => 65,
			";" => -18,
			'INIT' => -18,
			"=" => -18
		},
		GOTOS => {
			'unitspec' => 212
		}
	},
	{#State 194
		ACTIONS => {
			'XOROP' => 97,
			";" => 213,
			'OROP' => 101,
			'ANDOP' => 98
		}
	},
	{#State 195
		ACTIONS => {
			'' => -72,
			'TIMESTEP' => -72,
			"%{" => -72,
			"}" => -72,
			'NOT2' => -72,
			"\@" => -72,
			'ADDOP' => -72,
			'PERL' => -72,
			'POOL' => -72,
			'FUNC' => -72,
			'UNLESS' => -72,
			'NUM' => -72,
			'EXTERNAL' => -72,
			'UNITS' => -72,
			'STEP' => -72,
			'RETURN' => -72,
			"\$" => -72,
			'IF' => -72,
			'FUNCTION' => -72,
			'INIT' => -72,
			'STR' => -72,
			'NOTOP' => -72,
			'MODULE' => -72,
			'ELSE' => 214,
			'ELSIF' => 216,
			"{" => -72,
			'CONST' => -72,
			'INCLUDE' => -72,
			"(" => -72,
			'VAR' => -72,
			'INCOP' => -72
		},
		GOTOS => {
			'else' => 215
		}
	},
	{#State 196
		ACTIONS => {
			'' => -72,
			'TIMESTEP' => -72,
			"%{" => -72,
			"}" => -72,
			'NOT2' => -72,
			"\@" => -72,
			'ADDOP' => -72,
			'PERL' => -72,
			'POOL' => -72,
			'FUNC' => -72,
			'UNLESS' => -72,
			'NUM' => -72,
			'EXTERNAL' => -72,
			'UNITS' => -72,
			'STEP' => -72,
			'RETURN' => -72,
			"\$" => -72,
			'IF' => -72,
			'FUNCTION' => -72,
			'INIT' => -72,
			'STR' => -72,
			'NOTOP' => -72,
			'MODULE' => -72,
			'ELSE' => 214,
			'ELSIF' => 216,
			"{" => -72,
			'CONST' => -72,
			'INCLUDE' => -72,
			"(" => -72,
			'VAR' => -72,
			'INCOP' => -72
		},
		GOTOS => {
			'else' => 217
		}
	},
	{#State 197
		ACTIONS => {
			'XOROP' => 97,
			";" => 218,
			'OROP' => 101,
			'ANDOP' => 98
		}
	},
	{#State 198
		ACTIONS => {
			'WORD' => 219
		}
	},
	{#State 199
		ACTIONS => {
			"}" => -89,
			":" => -89,
			"<" => -89,
			'XOROP' => -89,
			'DORDOR' => 81,
			";" => -89,
			'FLOWLEFT' => -89,
			'ADDOP' => 88,
			"," => -89,
			'ANDOP' => -89,
			'UNLESS' => -89,
			'ASSIGNOP' => -89,
			'IF' => -89,
			'FLOWRIGHT' => -89,
			")" => -89,
			'POWOP' => 83,
			"?" => 89,
			'OROP' => -89,
			'DOTDOT' => 90,
			'MULOP' => 91,
			"=" => -89,
			'ANDAND' => 85,
			'OROR' => 93,
			'RELOP' => 87,
			'INCOP' => 86
		}
	},
	{#State 200
		ACTIONS => {
			"\$" => 15
		},
		GOTOS => {
			'scalar' => 220
		}
	},
	{#State 201
		DEFAULT => -58
	},
	{#State 202
		ACTIONS => {
			";" => 221
		}
	},
	{#State 203
		ACTIONS => {
			"}" => -15,
			'WORD' => 222
		},
		GOTOS => {
			'pair' => 223,
			'STAR-3' => 225,
			'STAR-4' => 224
		}
	},
	{#State 204
		DEFAULT => -60
	},
	{#State 205
		DEFAULT => -52
	},
	{#State 206
		DEFAULT => -59
	},
	{#State 207
		DEFAULT => -33
	},
	{#State 208
		DEFAULT => -118
	},
	{#State 209
		DEFAULT => -117
	},
	{#State 210
		DEFAULT => -120
	},
	{#State 211
		DEFAULT => -119
	},
	{#State 212
		DEFAULT => -40
	},
	{#State 213
		DEFAULT => -37
	},
	{#State 214
		ACTIONS => {
			"%{" => 7,
			"{" => 49,
			'PERL' => 9
		},
		GOTOS => {
			'block' => 226
		}
	},
	{#State 215
		DEFAULT => -71
	},
	{#State 216
		ACTIONS => {
			"(" => 227
		}
	},
	{#State 217
		DEFAULT => -70
	},
	{#State 218
		DEFAULT => -35
	},
	{#State 219
		DEFAULT => -86
	},
	{#State 220
		DEFAULT => -53
	},
	{#State 221
		DEFAULT => -51
	},
	{#State 222
		ACTIONS => {
			"=>" => 228
		}
	},
	{#State 223
		DEFAULT => -13
	},
	{#State 224
		ACTIONS => {
			"}" => 229
		}
	},
	{#State 225
		ACTIONS => {
			"}" => -14,
			"," => 230
		}
	},
	{#State 226
		DEFAULT => -73
	},
	{#State 227
		ACTIONS => {
			'STR' => 46,
			'NOTOP' => 21,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'expr' => 231,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 34,
			'termunop' => 19
		}
	},
	{#State 228
		ACTIONS => {
			'STR' => 46,
			'NOTOP' => 21,
			'NOT2' => 28,
			"\@" => 8,
			'ADDOP' => 31,
			'FUNC' => 33,
			'NUM' => 12,
			"(" => 24,
			'RETURN' => 38,
			"\$" => 15,
			'INCOP' => 27
		},
		GOTOS => {
			'scalar' => 70,
			'expr' => 232,
			'funcall' => 48,
			'termbinop' => 17,
			'set' => 44,
			'term' => 34,
			'termunop' => 19
		}
	},
	{#State 229
		DEFAULT => -16
	},
	{#State 230
		ACTIONS => {
			'WORD' => 222
		},
		GOTOS => {
			'pair' => 233
		}
	},
	{#State 231
		ACTIONS => {
			'XOROP' => 97,
			'OROP' => 101,
			")" => 234,
			'ANDOP' => 98
		}
	},
	{#State 232
		ACTIONS => {
			"}" => -17,
			'XOROP' => 97,
			'OROP' => 101,
			"," => -17,
			'ANDOP' => 98
		}
	},
	{#State 233
		DEFAULT => -12
	},
	{#State 234
		ACTIONS => {
			"%{" => 7,
			"{" => 49,
			'PERL' => 9
		},
		GOTOS => {
			'block' => 235
		}
	},
	{#State 235
		ACTIONS => {
			'' => -72,
			'TIMESTEP' => -72,
			"%{" => -72,
			"}" => -72,
			'NOT2' => -72,
			"\@" => -72,
			'ADDOP' => -72,
			'PERL' => -72,
			'POOL' => -72,
			'FUNC' => -72,
			'UNLESS' => -72,
			'NUM' => -72,
			'EXTERNAL' => -72,
			'UNITS' => -72,
			'STEP' => -72,
			'RETURN' => -72,
			"\$" => -72,
			'IF' => -72,
			'FUNCTION' => -72,
			'INIT' => -72,
			'STR' => -72,
			'NOTOP' => -72,
			'MODULE' => -72,
			'ELSE' => 214,
			'ELSIF' => 216,
			"{" => -72,
			'CONST' => -72,
			'INCLUDE' => -72,
			"(" => -72,
			'VAR' => -72,
			'INCOP' => -72
		},
		GOTOS => {
			'else' => 236
		}
	},
	{#State 236
		DEFAULT => -74
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 3058 Mad/Parser.pm
	],
	[#Rule program_1
		 'program', 2,
sub {
#line 47 "Mad/Parser.eyp"
 new_dnode('PROGRAM', $_[2]) }
#line 3065 Mad/Parser.pm
	],
	[#Rule progstart_2
		 'progstart', 0,
sub {
#line 51 "Mad/Parser.eyp"
}
#line 3072 Mad/Parser.pm
	],
	[#Rule _STAR_LIST
		 'STAR-1', 2,
sub {
#line 56 "Mad/Parser.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 3079 Mad/Parser.pm
	],
	[#Rule _STAR_LIST
		 'STAR-1', 0,
sub {
#line 56 "Mad/Parser.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 3086 Mad/Parser.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 2,
sub {
#line 57 "Mad/Parser.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 3093 Mad/Parser.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 0,
sub {
#line 57 "Mad/Parser.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 3100 Mad/Parser.pm
	],
	[#Rule block_7
		 'block', 3,
sub {
#line 55 "Mad/Parser.eyp"
 new_dnode('BLOCK', $_[2]) }
#line 3107 Mad/Parser.pm
	],
	[#Rule block_8
		 'block', 5, undef
#line 3111 Mad/Parser.pm
	],
	[#Rule _CODE
		 '@8-2', 0,
sub {
#line 56 "Mad/Parser.eyp"
 $_[0]->lex_mode('perl') }
#line 3118 Mad/Parser.pm
	],
	[#Rule block_10
		 'block', 4, undef
#line 3122 Mad/Parser.pm
	],
	[#Rule _CODE
		 '@10-1', 0,
sub {
#line 57 "Mad/Parser.eyp"
 $_[0]->lex_mode('pperl') }
#line 3129 Mad/Parser.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 3,
sub {
#line 60 "Mad/Parser.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 3136 Mad/Parser.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 1,
sub {
#line 60 "Mad/Parser.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 3143 Mad/Parser.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 1,
sub {
#line 60 "Mad/Parser.eyp"
 { $_[1] } # optimize 
}
#line 3151 Mad/Parser.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 60 "Mad/Parser.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 3158 Mad/Parser.pm
	],
	[#Rule pairblock_16
		 'pairblock', 3,
sub {
#line 61 "Mad/Parser.eyp"
 new_dnode('PAIRBLOCK', $_[2]) }
#line 3165 Mad/Parser.pm
	],
	[#Rule pair_17
		 'pair', 3,
sub {
#line 65 "Mad/Parser.eyp"
my $left = $_[1]; my $right = $_[3];  new_node('PAIR', $left, $right) }
#line 3172 Mad/Parser.pm
	],
	[#Rule unitspec_18
		 'unitspec', 0,
sub {
#line 69 "Mad/Parser.eyp"
}
#line 3179 Mad/Parser.pm
	],
	[#Rule unitspec_19
		 'unitspec', 3,
sub {
#line 71 "Mad/Parser.eyp"
 merge_units(new_node('UNITSPEC'), $_[2], 1) }
#line 3186 Mad/Parser.pm
	],
	[#Rule unitlist_20
		 'unitlist', 0,
sub {
#line 75 "Mad/Parser.eyp"
 new_node('UNITLIST') }
#line 3193 Mad/Parser.pm
	],
	[#Rule unitlist_21
		 'unitlist', 2,
sub {
#line 78 "Mad/Parser.eyp"

			    my (@u) = $_[0]->validate_unit($_[2]);
			    if ( $u[0] eq 'ERROR' ) {
				$_[0]->YYError();
			    }
			    else {
				add_units($_[1], @u);
			    }
			}
#line 3208 Mad/Parser.pm
	],
	[#Rule stmtseq_22
		 'stmtseq', 0, undef
#line 3212 Mad/Parser.pm
	],
	[#Rule stmtseq_23
		 'stmtseq', 2,
sub {
#line 92 "Mad/Parser.eyp"
 add_child($_[1], $_[2]) }
#line 3219 Mad/Parser.pm
	],
	[#Rule stmtseq_24
		 'stmtseq', 2,
sub {
#line 95 "Mad/Parser.eyp"
 add_child($_[1], $_[2]) }
#line 3226 Mad/Parser.pm
	],
	[#Rule decl_25
		 'decl', 1,
sub {
#line 99 "Mad/Parser.eyp"
 $_[1] }
#line 3233 Mad/Parser.pm
	],
	[#Rule decl_26
		 'decl', 1,
sub {
#line 102 "Mad/Parser.eyp"
 $_[1] }
#line 3240 Mad/Parser.pm
	],
	[#Rule decl_27
		 'decl', 1,
sub {
#line 105 "Mad/Parser.eyp"
 $_[1] }
#line 3247 Mad/Parser.pm
	],
	[#Rule decl_28
		 'decl', 1,
sub {
#line 108 "Mad/Parser.eyp"
 $_[1] }
#line 3254 Mad/Parser.pm
	],
	[#Rule decl_29
		 'decl', 1,
sub {
#line 111 "Mad/Parser.eyp"
 $_[0]->set_module($_[1]); $_[1] }
#line 3261 Mad/Parser.pm
	],
	[#Rule decl_30
		 'decl', 1,
sub {
#line 114 "Mad/Parser.eyp"
 $_[1] }
#line 3268 Mad/Parser.pm
	],
	[#Rule decl_31
		 'decl', 1,
sub {
#line 117 "Mad/Parser.eyp"
 $_[1] }
#line 3275 Mad/Parser.pm
	],
	[#Rule decl_32
		 'decl', 1,
sub {
#line 120 "Mad/Parser.eyp"
 $_[1] }
#line 3282 Mad/Parser.pm
	],
	[#Rule const_33
		 'const', 5,
sub {
#line 125 "Mad/Parser.eyp"
my $e = $_[4]; my $v = $_[2]; 
			    $_[0]->model_var($v, CONST_VAR);
			    new_node('INITSTMT', new_anode('ASSIGN', '=', $v, $e));
			}
#line 3292 Mad/Parser.pm
	],
	[#Rule const_34
		 'const', 3,
sub {
#line 131 "Mad/Parser.eyp"
my $v = $_[2]; 
			    $_[0]->model_var($v, CONST_VAR); undef;
			}
#line 3301 Mad/Parser.pm
	],
	[#Rule var_35
		 'var', 6,
sub {
#line 137 "Mad/Parser.eyp"
my $e = $_[5]; my $p = $_[3]; my $v = $_[2];  
			    $_[0]->model_var($v, PLAIN_VAR);
			    new_node(ref $p || 'STEPSTMT', 
				     new_anode('ASSIGN', '=', $v, $e));
			}
#line 3312 Mad/Parser.pm
	],
	[#Rule var_36
		 'var', 3,
sub {
#line 144 "Mad/Parser.eyp"
my $v = $_[2]; 
			    $_[0]->model_var($v, PLAIN_VAR); undef;
			}
#line 3321 Mad/Parser.pm
	],
	[#Rule pool_37
		 'pool', 6,
sub {
#line 150 "Mad/Parser.eyp"
my $e = $_[5]; my $p = $_[3]; my $v = $_[2]; 
			    $_[0]->model_var($v, POOL_VAR);
			    new_node(ref $p || 'INITSTMT', 
				     new_anode('ASSIGN', '=', $v, $e));
			}
#line 3332 Mad/Parser.pm
	],
	[#Rule pool_38
		 'pool', 3,
sub {
#line 157 "Mad/Parser.eyp"
my $v = $_[2]; 
			    $_[0]->model_var($v, POOL_VAR); undef;
			}
#line 3341 Mad/Parser.pm
	],
	[#Rule vardecl_39
		 'vardecl', 2,
sub {
#line 163 "Mad/Parser.eyp"
my $u = $_[2]; my $v = $_[1]; 
			    merge_units($v, $u);
			}
#line 3350 Mad/Parser.pm
	],
	[#Rule vardecl_40
		 'vardecl', 5,
sub {
#line 168 "Mad/Parser.eyp"
my $l = $_[3]; my $u = $_[5]; my $v = $_[1]; 
			    merge_units(add_child($v, $l), $u);
			}
#line 3359 Mad/Parser.pm
	],
	[#Rule vardecl_41
		 'vardecl', 2,
sub {
#line 173 "Mad/Parser.eyp"
my $u = $_[2]; my $v = $_[1]; 
			    merge_units($v, $u);
			}
#line 3368 Mad/Parser.pm
	],
	[#Rule phase_42
		 'phase', 0,
sub {
#line 179 "Mad/Parser.eyp"
}
#line 3375 Mad/Parser.pm
	],
	[#Rule phase_43
		 'phase', 1,
sub {
#line 181 "Mad/Parser.eyp"
 new_node('INITSTMT') }
#line 3382 Mad/Parser.pm
	],
	[#Rule phase_44
		 'phase', 1,
sub {
#line 183 "Mad/Parser.eyp"
 new_node('STEPSTMT') }
#line 3389 Mad/Parser.pm
	],
	[#Rule phase_45
		 'phase', 1,
sub {
#line 185 "Mad/Parser.eyp"
 new_node('TIMESTMT') }
#line 3396 Mad/Parser.pm
	],
	[#Rule include_46
		 'include', 3,
sub {
#line 189 "Mad/Parser.eyp"

			    $_[0]->parse_input($_[2] . ".mad");
			}
#line 3405 Mad/Parser.pm
	],
	[#Rule module_47
		 'module', 3,
sub {
#line 195 "Mad/Parser.eyp"
 new_anode('MODULE', $_[2]) }
#line 3412 Mad/Parser.pm
	],
	[#Rule units_48
		 'units', 3,
sub {
#line 199 "Mad/Parser.eyp"
 new_dnode('UNITS', $_[2]) }
#line 3419 Mad/Parser.pm
	],
	[#Rule wordlist_49
		 'wordlist', 1,
sub {
#line 203 "Mad/Parser.eyp"
 new_node('LIST', new_anode('STRING', $_[1])) }
#line 3426 Mad/Parser.pm
	],
	[#Rule wordlist_50
		 'wordlist', 3,
sub {
#line 206 "Mad/Parser.eyp"
my $w = $_[3]; my $l = $_[1];  add_child($l, new_anode('STRING', $w)) }
#line 3433 Mad/Parser.pm
	],
	[#Rule external_51
		 'external', 6,
sub {
#line 210 "Mad/Parser.eyp"
my $u = $_[4]; my $b = $_[5]; my $name = $_[2]; my $f = $_[3]; 
			    merge_units(new_anode('EXTERNAL', $name, $f, $b), $u);
			}
#line 3442 Mad/Parser.pm
	],
	[#Rule function_52
		 'function', 5,
sub {
#line 216 "Mad/Parser.eyp"
my $u = $_[4]; my $b = $_[5]; my $name = $_[2]; my $f = $_[3]; 
			    merge_units(new_anode('FUNCTION', $name, $f, $b), $u);
			}
#line 3451 Mad/Parser.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 3,
sub {
#line 222 "Mad/Parser.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 3458 Mad/Parser.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 1,
sub {
#line 222 "Mad/Parser.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 3465 Mad/Parser.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 1,
sub {
#line 222 "Mad/Parser.eyp"
 { $_[1] } # optimize 
}
#line 3473 Mad/Parser.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 222 "Mad/Parser.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 3480 Mad/Parser.pm
	],
	[#Rule funargs_57
		 'funargs', 0, undef
#line 3484 Mad/Parser.pm
	],
	[#Rule funargs_58
		 'funargs', 3,
sub {
#line 223 "Mad/Parser.eyp"

			    new_node('LIST', undef, @{$_[2]->{children}});
			}
#line 3493 Mad/Parser.pm
	],
	[#Rule funbody_59
		 'funbody', 1,
sub {
#line 229 "Mad/Parser.eyp"
 $_[1] }
#line 3500 Mad/Parser.pm
	],
	[#Rule funbody_60
		 'funbody', 1,
sub {
#line 231 "Mad/Parser.eyp"
}
#line 3507 Mad/Parser.pm
	],
	[#Rule line_61
		 'line', 2,
sub {
#line 235 "Mad/Parser.eyp"
my $p = $_[1]; my $b = $_[2];  new_node(ref $p, $b) }
#line 3514 Mad/Parser.pm
	],
	[#Rule line_62
		 'line', 3,
sub {
#line 238 "Mad/Parser.eyp"
my $e = $_[2]; my $p = $_[1];  new_node(ref $p, $b) }
#line 3521 Mad/Parser.pm
	],
	[#Rule line_63
		 'line', 1,
sub {
#line 241 "Mad/Parser.eyp"
 $_[1] }
#line 3528 Mad/Parser.pm
	],
	[#Rule line_64
		 'line', 1,
sub {
#line 244 "Mad/Parser.eyp"
 $_[1] }
#line 3535 Mad/Parser.pm
	],
	[#Rule line_65
		 'line', 2,
sub {
#line 247 "Mad/Parser.eyp"
 $_[1] }
#line 3542 Mad/Parser.pm
	],
	[#Rule line_66
		 'line', 2,
sub {
#line 250 "Mad/Parser.eyp"
 $_[1] }
#line 3549 Mad/Parser.pm
	],
	[#Rule sideff_67
		 'sideff', 1,
sub {
#line 254 "Mad/Parser.eyp"
 $_[1] }
#line 3556 Mad/Parser.pm
	],
	[#Rule sideff_68
		 'sideff', 3,
sub {
#line 257 "Mad/Parser.eyp"
my $l = $_[1]; my $r = $_[3];  new_node('AND', $r, $l) }
#line 3563 Mad/Parser.pm
	],
	[#Rule sideff_69
		 'sideff', 3,
sub {
#line 260 "Mad/Parser.eyp"
my $l = $_[1]; my $r = $_[3];  new_node('OR', $r, $l) }
#line 3570 Mad/Parser.pm
	],
	[#Rule cond_70
		 'cond', 6,
sub {
#line 264 "Mad/Parser.eyp"
my $test = $_[3]; my $else = $_[6]; my $if = $_[5];  new_node('IF', $test, $if, $else) }
#line 3577 Mad/Parser.pm
	],
	[#Rule cond_71
		 'cond', 6,
sub {
#line 267 "Mad/Parser.eyp"
my $test = $_[3]; my $else = $_[6]; my $if = $_[5];  new_node('IF', new_node('NOT', $test), $if, $else) }
#line 3584 Mad/Parser.pm
	],
	[#Rule else_72
		 'else', 0,
sub {
#line 271 "Mad/Parser.eyp"
}
#line 3591 Mad/Parser.pm
	],
	[#Rule else_73
		 'else', 2,
sub {
#line 274 "Mad/Parser.eyp"
my $b = $_[2];  $b }
#line 3598 Mad/Parser.pm
	],
	[#Rule else_74
		 'else', 6,
sub {
#line 277 "Mad/Parser.eyp"
my $test = $_[3]; my $else = $_[6]; my $if = $_[5];  new_node('IF', $test, $if, $else) }
#line 3605 Mad/Parser.pm
	],
	[#Rule listexpr_75
		 'listexpr', 0,
sub {
#line 281 "Mad/Parser.eyp"
}
#line 3612 Mad/Parser.pm
	],
	[#Rule listexpr_76
		 'listexpr', 1,
sub {
#line 284 "Mad/Parser.eyp"
 $_[1] }
#line 3619 Mad/Parser.pm
	],
	[#Rule argexpr_77
		 'argexpr', 2,
sub {
#line 288 "Mad/Parser.eyp"
 $_[1] }
#line 3626 Mad/Parser.pm
	],
	[#Rule argexpr_78
		 'argexpr', 3,
sub {
#line 291 "Mad/Parser.eyp"
my $t = $_[3]; 
			    if ( ref $_[1] eq 'LIST' ) {
				push @{$_[1]->{children}}, $t;
				$_[1];
			    }
			    else {
				new_node('LIST', $_[1], $t);
			    }
			}
#line 3641 Mad/Parser.pm
	],
	[#Rule argexpr_79
		 'argexpr', 1,
sub {
#line 302 "Mad/Parser.eyp"
 $_[1] }
#line 3648 Mad/Parser.pm
	],
	[#Rule expr_80
		 'expr', 3,
sub {
#line 306 "Mad/Parser.eyp"
my $l = $_[1]; my $r = $_[3];  new_node('AND', $l, $r) }
#line 3655 Mad/Parser.pm
	],
	[#Rule expr_81
		 'expr', 3,
sub {
#line 309 "Mad/Parser.eyp"
my $l = $_[1]; my $r = $_[3];  new_node('OR', $l, $r) }
#line 3662 Mad/Parser.pm
	],
	[#Rule expr_82
		 'expr', 3,
sub {
#line 312 "Mad/Parser.eyp"
my $l = $_[1]; my $r = $_[3];  new_node('XOR', $l, $r) }
#line 3669 Mad/Parser.pm
	],
	[#Rule expr_83
		 'expr', 2,
sub {
#line 315 "Mad/Parser.eyp"
my $e = $_[2];  new_node('NOT', $e) }
#line 3676 Mad/Parser.pm
	],
	[#Rule expr_84
		 'expr', 2,
sub {
#line 318 "Mad/Parser.eyp"
my $u = $_[2];  merge_units($_[1], $u) }
#line 3683 Mad/Parser.pm
	],
	[#Rule funcall_85
		 'funcall', 4,
sub {
#line 322 "Mad/Parser.eyp"
my $args = $_[3]; my $fun = $_[1];  new_node('FUNCALL', $fun, @{$args->{children}}) }
#line 3690 Mad/Parser.pm
	],
	[#Rule funcall_86
		 'funcall', 6,
sub {
#line 325 "Mad/Parser.eyp"
my $args = $_[3]; my $fld = $_[6]; my $fun = $_[1];  new_node('DOTFLD', $fld,
				   new_node('FUNCALL', $fun, @{$args->{children}}) ) }
#line 3698 Mad/Parser.pm
	],
	[#Rule term_87
		 'term', 1,
sub {
#line 330 "Mad/Parser.eyp"
 $_[1] }
#line 3705 Mad/Parser.pm
	],
	[#Rule term_88
		 'term', 1,
sub {
#line 333 "Mad/Parser.eyp"
 $_[1] }
#line 3712 Mad/Parser.pm
	],
	[#Rule term_89
		 'term', 5,
sub {
#line 336 "Mad/Parser.eyp"
my $c = $_[5]; my $a = $_[1]; my $b = $_[3];  new_node('TRI', $a, $b, $c) }
#line 3719 Mad/Parser.pm
	],
	[#Rule term_90
		 'term', 3,
sub {
#line 339 "Mad/Parser.eyp"
 $_[2] }
#line 3726 Mad/Parser.pm
	],
	[#Rule term_91
		 'term', 1,
sub {
#line 342 "Mad/Parser.eyp"
 $_[1] }
#line 3733 Mad/Parser.pm
	],
	[#Rule term_92
		 'term', 1,
sub {
#line 345 "Mad/Parser.eyp"
 $_[1] }
#line 3740 Mad/Parser.pm
	],
	[#Rule term_93
		 'term', 2,
sub {
#line 348 "Mad/Parser.eyp"
 new_anode('NUM', $_[1]) }
#line 3747 Mad/Parser.pm
	],
	[#Rule term_94
		 'term', 1,
sub {
#line 351 "Mad/Parser.eyp"
 new_anode('STR', $_[1]) }
#line 3754 Mad/Parser.pm
	],
	[#Rule term_95
		 'term', 1,
sub {
#line 354 "Mad/Parser.eyp"
 $_[1] }
#line 3761 Mad/Parser.pm
	],
	[#Rule term_96
		 'term', 2,
sub {
#line 357 "Mad/Parser.eyp"
my $e = $_[2];  new_node('RETURN', $e) }
#line 3768 Mad/Parser.pm
	],
	[#Rule termbinop_97
		 'termbinop', 3,
sub {
#line 361 "Mad/Parser.eyp"
my $l = $_[1]; my $r = $_[3]; my $op = $_[2];  new_anode('ASSIGN', $op, $l, $r) }
#line 3775 Mad/Parser.pm
	],
	[#Rule termbinop_98
		 'termbinop', 3,
sub {
#line 364 "Mad/Parser.eyp"
my $l = $_[1]; my $r = $_[3];  new_anode('ASSIGN', '=', $l, $r) }
#line 3782 Mad/Parser.pm
	],
	[#Rule termbinop_99
		 'termbinop', 3,
sub {
#line 367 "Mad/Parser.eyp"
my $l = $_[1]; my $r = $_[3]; my $op = $_[2];  new_anode('ADDOP', $op, $l, $r) }
#line 3789 Mad/Parser.pm
	],
	[#Rule termbinop_100
		 'termbinop', 3,
sub {
#line 370 "Mad/Parser.eyp"
my $l = $_[1]; my $r = $_[3]; my $op = $_[2];  new_anode('MULOP', $op, $l, $r) }
#line 3796 Mad/Parser.pm
	],
	[#Rule termbinop_101
		 'termbinop', 3,
sub {
#line 373 "Mad/Parser.eyp"
my $l = $_[1]; my $r = $_[3]; my $op = $_[2];  new_anode('POWOP', $op, $l, $r) }
#line 3803 Mad/Parser.pm
	],
	[#Rule termbinop_102
		 'termbinop', 3,
sub {
#line 376 "Mad/Parser.eyp"
my $l = $_[1]; my $r = $_[3]; my $op = $_[2];  new_anode('RELOP', $op, $l, $r) }
#line 3810 Mad/Parser.pm
	],
	[#Rule termbinop_103
		 'termbinop', 3,
sub {
#line 379 "Mad/Parser.eyp"
my $l = $_[1]; my $r = $_[3];  new_node('DOTDOT', $l, $r) }
#line 3817 Mad/Parser.pm
	],
	[#Rule termbinop_104
		 'termbinop', 3,
sub {
#line 382 "Mad/Parser.eyp"
my $l = $_[1]; my $r = $_[3];  new_node('AND', $l, $r) }
#line 3824 Mad/Parser.pm
	],
	[#Rule termbinop_105
		 'termbinop', 3,
sub {
#line 385 "Mad/Parser.eyp"
my $l = $_[1]; my $r = $_[3];  new_node('OR', $l, $r) }
#line 3831 Mad/Parser.pm
	],
	[#Rule termbinop_106
		 'termbinop', 3,
sub {
#line 388 "Mad/Parser.eyp"
my $l = $_[1]; my $r = $_[3];  new_node('DOR', $l, $r) }
#line 3838 Mad/Parser.pm
	],
	[#Rule termunop_107
		 'termunop', 2,
sub {
#line 394 "Mad/Parser.eyp"
my $t = $_[2]; my $op = $_[1];  $op eq '-' ? new_node('UMINUS', $t) : $t }
#line 3845 Mad/Parser.pm
	],
	[#Rule termunop_108
		 'termunop', 2,
sub {
#line 397 "Mad/Parser.eyp"
my $t = $_[2];  new_node('NOT', $t) }
#line 3852 Mad/Parser.pm
	],
	[#Rule termunop_109
		 'termunop', 2,
sub {
#line 400 "Mad/Parser.eyp"
 $_[1]->{incr} = 'POST'; $_[1]; }
#line 3859 Mad/Parser.pm
	],
	[#Rule termunop_110
		 'termunop', 2,
sub {
#line 403 "Mad/Parser.eyp"
 $_[2]->{incr} = 'PRE'; $_[2]; }
#line 3866 Mad/Parser.pm
	],
	[#Rule scalar_111
		 'scalar', 2,
sub {
#line 407 "Mad/Parser.eyp"
 new_anode('SCALAR', $_[2]) }
#line 3873 Mad/Parser.pm
	],
	[#Rule set_112
		 'set', 2,
sub {
#line 411 "Mad/Parser.eyp"
 new_anode('SET', $_[2]) }
#line 3880 Mad/Parser.pm
	],
	[#Rule flow_113
		 'flow', 5,
sub {
#line 415 "Mad/Parser.eyp"
my $so = $_[1]; my $sn = $_[5]; my $coeff = $_[3]; my $op = $_[2]; 
			    new_node('FLOW', $so, $sn, 
				     new_anode('MULOP', $op, $so, $coeff));
			}
#line 3890 Mad/Parser.pm
	],
	[#Rule flow_114
		 'flow', 5,
sub {
#line 421 "Mad/Parser.eyp"
my $so = $_[5]; my $sn = $_[1]; my $coeff = $_[3]; my $op = $_[2]; 
			    new_node('FLOW', $so, $sn, 
				     new_anode('MULOP', $op, $sn, $coeff));
			}
#line 3900 Mad/Parser.pm
	],
	[#Rule flow_115
		 'flow', 5,
sub {
#line 427 "Mad/Parser.eyp"
my $so = $_[1]; my $sn = $_[3]; my $coeff = $_[5]; my $op = $_[4]; 
			    new_node('FLOW', $so, $sn,
				     new_anode('MULOP', $op, $sn, $coeff));
			}
#line 3910 Mad/Parser.pm
	],
	[#Rule flow_116
		 'flow', 5,
sub {
#line 433 "Mad/Parser.eyp"
my $so = $_[3]; my $sn = $_[1]; my $coeff = $_[5]; my $op = $_[4]; 
			    new_node('FLOW', $so, $sn, 
				     new_anode('MULOP', $op, $so, $coeff));
			}
#line 3920 Mad/Parser.pm
	],
	[#Rule flow_117
		 'flow', 6,
sub {
#line 439 "Mad/Parser.eyp"
my $rate = $_[3]; my $so = $_[1]; my $sn = $_[6]; 
			    new_node('FLOW', $so, $sn, $rate);
			}
#line 3929 Mad/Parser.pm
	],
	[#Rule flow_118
		 'flow', 6,
sub {
#line 444 "Mad/Parser.eyp"
my $so = $_[6]; my $rate = $_[3]; my $sn = $_[1]; 
			    new_node('FLOW', $so, $sn, $rate);
			}
#line 3938 Mad/Parser.pm
	],
	[#Rule flow_119
		 'flow', 6,
sub {
#line 449 "Mad/Parser.eyp"
my $rate = $_[5]; my $so = $_[1]; my $sn = $_[3]; 
			    new_node('FLOW', $so, $sn, $rate);
			}
#line 3947 Mad/Parser.pm
	],
	[#Rule flow_120
		 'flow', 6,
sub {
#line 454 "Mad/Parser.eyp"
my $rate = $_[5]; my $so = $_[3]; my $sn = $_[1]; 
			    new_node('FLOW', $so, $sn, $rate);
			}
#line 3956 Mad/Parser.pm
	]
],
#line 3959 Mad/Parser.pm
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
         'progstart_2', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'block_7', 
         'block_8', 
         '_CODE', 
         'block_10', 
         '_CODE', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'pairblock_16', 
         'pair_17', 
         'unitspec_18', 
         'unitspec_19', 
         'unitlist_20', 
         'unitlist_21', 
         'stmtseq_22', 
         'stmtseq_23', 
         'stmtseq_24', 
         'decl_25', 
         'decl_26', 
         'decl_27', 
         'decl_28', 
         'decl_29', 
         'decl_30', 
         'decl_31', 
         'decl_32', 
         'const_33', 
         'const_34', 
         'var_35', 
         'var_36', 
         'pool_37', 
         'pool_38', 
         'vardecl_39', 
         'vardecl_40', 
         'vardecl_41', 
         'phase_42', 
         'phase_43', 
         'phase_44', 
         'phase_45', 
         'include_46', 
         'module_47', 
         'units_48', 
         'wordlist_49', 
         'wordlist_50', 
         'external_51', 
         'function_52', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'funargs_57', 
         'funargs_58', 
         'funbody_59', 
         'funbody_60', 
         'line_61', 
         'line_62', 
         'line_63', 
         'line_64', 
         'line_65', 
         'line_66', 
         'sideff_67', 
         'sideff_68', 
         'sideff_69', 
         'cond_70', 
         'cond_71', 
         'else_72', 
         'else_73', 
         'else_74', 
         'listexpr_75', 
         'listexpr_76', 
         'argexpr_77', 
         'argexpr_78', 
         'argexpr_79', 
         'expr_80', 
         'expr_81', 
         'expr_82', 
         'expr_83', 
         'expr_84', 
         'funcall_85', 
         'funcall_86', 
         'term_87', 
         'term_88', 
         'term_89', 
         'term_90', 
         'term_91', 
         'term_92', 
         'term_93', 
         'term_94', 
         'term_95', 
         'term_96', 
         'termbinop_97', 
         'termbinop_98', 
         'termbinop_99', 
         'termbinop_100', 
         'termbinop_101', 
         'termbinop_102', 
         'termbinop_103', 
         'termbinop_104', 
         'termbinop_105', 
         'termbinop_106', 
         'termunop_107', 
         'termunop_108', 
         'termunop_109', 
         'termunop_110', 
         'scalar_111', 
         'set_112', 
         'flow_113', 
         'flow_114', 
         'flow_115', 
         'flow_116', 
         'flow_117', 
         'flow_118', 
         'flow_119', 
         'flow_120', );
  $self;
}

#line 459 "Mad/Parser.eyp"


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
# Return the model created by this parser.

sub new_model {

    my ($self) = @_;
    
    # Initialize the parser to parse a new model.
    
    $self->{my_stack} = [];
    $self->{lex_mode} = 'mad';
    
    # Create a new object to hold the model as it is read in.  Return a
    # reference to this object as the function result.
    
    $self->{model} = Mad::Model->new();    
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
    
    if ( defined $input ) {
	
	# Record the name of the file we are reading from, the starting line
	# number (1) and the contents that were read in.
	
	$self->{my_filename} = $filename;
	$self->{my_line} = 1;
	$self->{my_input} = \$input;
	
	# Push this information on the input stack, so that we can come back
	# to it if we need to pause and parse an included file.
	
	unshift @{$self->{my_input_stack}}, {file => $self->{my_filename}, 
					    line => $self->{my_line}, 
					    input => $self->{my_input}};
	
	# Now parse the input, and return the resulting tree (if any).
	
	my $tree = $self->YYParse( yylex => \&my_lexer, yybuildingtree => 1 );
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
    
    # Remove the top record from the input stack
    
    shift @{$self->{my_input_stack}};
    
    # If the stack is now empty, return false.
    
    if ( @{$self->{my_input_stack}} == 0 ) {
	return 0;
    }

    # Otherwise, copy the relevant information from the new top record to the
    # fields my_filename, my_line and my_input, and return true.
    
    else {
	$self->{my_filename} = $self->{my_input_stack}[0]{file};
	$self->{my_line} = $self->{my_input_stack}[0]{line};
	$self->{my_input} = $self->{my_input_stack}[0]{input};
	return 1;
    }
}

# set_module ( $node )
# 
# From here to the end of the current block, all non-dynamic variable names
# will be evaluated in the context specified by $module_name.

sub set_module {

    my ($self, $node) = @_;
    $self->{current_module} = $node->{attr};
}

# model_var ( $node )
# 
# Enter a new variable into the model's symbol table, using the parse tree rooted
# at $node.

sub model_var {

    my ($self, $node) = @_;
    $DB::single = 1;
    my $name = $node->{attr};
}

# Functions for managing parse tree nodes
# ---------------------------------------

# new_node ( $type, @children )
# 
# Create a new parse node, with children given by @children.  This will be
# part of the growing parse tree.  Each of @children should be a reference to
# another node.

sub new_node {
    my ($type, @children) = @_;
    
    my $node = Parse::Eyapp::Node->new($type);
    push @{$node->{children}}, @children if @children > 0;
    return $node;
}

# new_anode ( $type, $attr, @children )
# 
# Similar to new_node, but with the addition of the parameter $attr which is
# used to set the "attr" field of the new node.  This is used to record the
# value of a string or numeric literal, the name of a variable, etc.

sub new_anode {
    my ($type, $attr, @children) = @_;
    
    my $node = Parse::Eyapp::Node->new($type);
    $node->{attr} = $attr if defined $attr;
    push @{$node->{children}}, @children if @children > 0;
    return $node;
}

# add_child ( $node, $child )
# 
# Add $child to the children of an existing node in the parse tree,
# provided that $child is a reference to a node.  If it is not, do nothing.

sub add_child {
    my ($node, $child) = @_;
    
    push @{$node->{children}}, $child if ref $child;
    return $node;
}

# add_units ( $node, @units )
# 
# Modify the parse node $node by adding some units to it.  This is triggered
# by a unit expression such as "<mi/hr>".  This information will then be used
# to make sure that any equations involving the entity declared by $node are
# unit-balanced.

sub add_units {
    my ($node, @units) = @_;
    
    # Make sure that the field "units" exists and points to an array.
    
    unless ( ref $node->{units} eq 'ARRAY' ) {
	$node->{units} = [];
    }
    
    # Add the given units to the array.
    
    push @{$node->{units}}, @units;
    return $node;
}

# merge_units ( $node, $unitnode, $sort_flag )
# 
# Modify the node $node by copying to it the list of units already associated
# with $unitnode.  If $sort_flag is true, sort the units alphabetically first.

sub merge_units {
    my ($node, $unitnode, $sort_flag) = @_;
    
    if ( ref $unitnode ) {
	if ( $sort_flag ) {
	    $node->{units} = [ sort @{$unitnode->{units}} ];
	}
	else {
	    $node->{units} = $unitnode->{units};
	}
    }
    return $node;
}

# new_dnode ( $type, $old_node )
# 
# Create a new node from an existing one.  The new node will have type $type
# and its children, units, and attribute will be the same as those of $old_node.

sub new_dnode {
    my ($type, $old_node) = @_;
    
    my $node = Parse::Eyapp::Node->new($type);
    $node->{attr} = $old_node->{attr} if exists $old_node->{attr};
    $node->{units} = $old_node->{units} if exists $old_node->{units};
    $node->{children} = $old_node->{children} if exists $old_node->{children};
    return $node;
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
# lexical mode returns to 'mad' and we return the token '}'.  Otherwise,
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

sub my_syntax_error {
    my ($self, $msg) = @_;
    die "Syntax error at $self->{my_filename} line $self->{my_line}: $msg\n";
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
	    
	    m{\Gand(?!\w)}gc		and return ('ANDOP', '');
	    m{\Gconst(?!\w)}gc		and return ('CONST', '');
	    m{\Gdo(?!\w)}gc		and return ('DO', '');
	    m{\Gelse(?!\w)}gc		and return ('ELSE', '');
	    m{\Gelsif(?!\w)}gc		and return ('ELSIF', '');
	    m{\Gexternal(?!\w)}gc	and return ('EXTERNAL', '');
	    m{\Gfor(?!\w)}gc		and return ('FOR', '');
	    m{\Gfunction(?!\w)}gc	and return ('FUNCTION', '');
	    m{\Gglobal(?!\w)}gc		and return ('GLOBAL', '');
	    m{\Ginclude(?!\w)}gc	and return ('INCLUDE', '');
	    m{\Gif(?!\w)}gc		and return ('IF', '');
	    m{\Ginit(?!\w)}gc		and return ('INIT', '');
	    m{\Glast(?!\w)}gc		and return ('LAST', '');
	    m{\Gmodule(?!\w)}gc		and return ('MODULE', '');
	    m{\Gnext(?!\w)}gc		and return ('NEXT', '');
	    m{\Gnot(?!\w)}gc		and return ('NOTOP', '');
	    m{\Gor(?!\w)}gc		and return ('OROP', '');
	    m{\Gperl(?!\w)}gc		and return ('PERL', '');
	    m{\Gpool(?!\w)}gc		and return ('POOL', '');
	    m{\Greturn(?!\w)}gc		and return ('RETURN', '');
	    m{\Grun(?!\w)}gc		and return ('RUN', '');
	    m{\Gstep(?!\w)}gc		and return ('STEP', '');
	    m{\Gtimestep(?!\w)}gc	and return ('TIMESTEP', '');
	    m{\Gunits(?!\w)}gc		and return ('UNITS', '');
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
	    #m{\G\.\.\.}gc			and return ('YADAYADA', '');
	    m{\G\.\.}gc				and return ('DOTDOT', '');
	    m{\G\.}gc				and return ('DOT', '');
	    m{\G=>}gc				and return ('=>', '');
	    m{\G,}gc				and return (',', ',');
	    m{\G\|\|}gc				and return ('OROR', '');
	    m{\G\/\/}gc				and return ('DORDOR', '');
	    m{\G&&}gc				and return ('ANDAND', '');
	    #m{\G\|}gc				and return ('BITOROP', '');
	    #m{\G\&}gc				and return ('BITANDOP', '');
	    #m{\G(<<|>>)}gc			and return ('SHIFTOP', $1);
	    m{\G(=~|!~)}gc			and return ('MATCHOP', $1);
	    m{\G(==|!=|<=>|eq|ne|cmp)}gc	and return ('RELOP', $1);
	    m{\G(<=|>=|lt|gt|le|ge)}gc		and return ('RELOP', $1);
	    m{\G(<|>)}gc			and return ('RELOP', $1);
	    m{\G([-+\*\/\^|%]=|\*\*=|&&=|\|\|=)}gc and return ('ASSIGNOP', $1);
	    m{\G(\+\+|--)}gc			and return ('INCOP', $1);
	    m{\G->}gc				and return ('ARROW', '');
	    m{\G\*\*}gc				and return ('POWOP', '');
	    m{\G([\*\/%x])}gc			and return ('MULOP', $1);
	    m{\G([+-])}gc			and return ('ADDOP', $1);
	    m{\G\\}gc				and return ('REFGEN', $1);
	    m{\G!}gc				and return ('NOT2', $1);
	    
	    # Miscellaneous characters
	    
	    m{\G([;=~()\[\]\{\}\$\@])}gc		and return ($1, $1);
	    
	    # If we get here and the current line is not empty, then we've got
	    # an unrecognized character.
	    
	    if ( m{\G(\S)}gc ) {
		$self->my_syntax_error("unrecognized character '$1'");
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


#line 4660 Mad/Parser.pm



1;
