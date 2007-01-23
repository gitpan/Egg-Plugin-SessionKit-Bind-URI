package Egg::Plugin::SessionKit::Bind::URI;

use strict;
use Error;
use NEXT;
use HTML::StickyQuery;

our $VERSION= '0.01';

sub startup {
	my($class, $e, $conf)= @_;
#	$conf->{bind}->{uri_param} ||= 'ss';
	$class->NEXT::startup($e, $conf);
}


sub get_bind_data {
	my $ss = shift;
	my $key= shift;
	my $session_id = $ss->e->req->params->{$key} || return 0;
	$ss->e->encode_entities($session_id) || 0;
}

sub set_bind_data { 

    my($ss, $key, $id) = @_;

    if(ref($ss->e->session) eq "HASH"){
        my $hidden = sprintf "<input type=\"hidden\" name=\"%s\" value=\"%s\" />", $key, $id;
        my $body = $ss->e->res->body;
        my $s = HTML::StickyQuery->new( abs => 0, keep_original => 1 );
        my $newbody = $s->sticky( scalarref => $body, param => { $ss->{param_name} => $ss->session_id } );
#        $newbody =~ s#(<form\s*.*?>)#$1\n$hidden#isg;
        $newbody =~ s#(<form\s*([^<>])+>)#$1\n$hidden#isg;
        $ss->e->res->body(\$newbody);
    }
}

sub close {

    my($ss) = @_;
    $ss->NEXT::close;
    $ss->output_session_id if !$ss->new_entry;
}


1;

__END__

=head1 NAME

Egg::Plugin::SessionKit::Bind::URI - Session ID is handed over by query string

=head1 VERSION

0.01

=head1 SYNOPSIS

Configuration.

  plugin_session=> {
    bind=> {
      name=> 'URI',
      },
    },

=head1 CONFIGURATION

$e->config->{plugin_session}{bind} becomes setup of this module.

=head2 name

Please always specify 'B<URI>' if you use this module.

=head2 NOTES

This plug-in obtains a large hint from Egg::Plugin::SessionKit::Bind::Cookie of Egg Web Application Framework URL:http://egg.bomcity.com .

=head1 SEE ALSO

L<Egg::Plugin::SessionKit>,
L<Egg::Plugin::SessionKit::Bind::Cookie>
L<Egg::Release>
L<Error>
L<HTML::StickyQuery>
L<NEXT>

=head1 AUTHOR

Akira Horimoto <emperor.kurt@gmail.com>

=head1 COPYRIGHT

Copyright (C) 2007 Akira Horimoto

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.6 or,
at your option, any later version of Perl 5 you may have available.

=cut
