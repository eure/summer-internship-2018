package TrendView::Controller::Extract;

use Mouse::Role;
use Furl;
use HTML::TreeBuilder;

has furl => (
	is      => 'ro',
	default => sub {
		Furl->new(
			agent 	=> 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.53 Safari/525.19',
			timeout => 10,
		)
	}
);

has tree => (
	is      => 'ro',
	default => sub { HTML::TreeBuilder->new() }
);

sub get_content {
	my $self = shift;
	my $url = shift;

	my $res = $self->furl->get($url);
	unless ($res->is_success) {
		print "Failed to connect to remote HTTP server\n";
		return;
	}
	return $res->decoded_content;
}


1;


