package TrendView::Controller::Extract::Repository;

use Moose;
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

sub daily {
	my $self = shift;
	my $url = 'https://github.com/trending?since=daily';

	my $daily_trend = $self->extract_trend($url);
	return $daily_trend;
}

sub weekly {
	my $self = shift;
	my $url = 'https://github.com/trending?since=weekly';

	my $daily_trend = $self->extract_trend($url);
	return $daily_trend;
}

sub monthly {
	my $self = shift;
	my $url = 'https://github.com/trending?since=monthly';

	my $daily_trend = $self->extract_trend($url);
	return $daily_trend;
}
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


sub extract_trend {
	my $self = shift;
	my $url = shift;

	my $content = $self->get_content($url);

	$self->tree->parse_content($content);

	my $trend_list = +[];
	my @titles = $self->tree->look_down('class',qr/col-12 d-block width-full py-4 border-bottom/);
	for my $div (@titles) {
		my $trend_hashref = +{};
		$trend_hashref->{title} = $div->look_down('class',qr/d-inline-block col-9 mb-1/)->as_text_trimmed;

		$trend_hashref->{href} = $div->look_down('class',qr/d-inline-block col-9 mb-1/)->extract_links('a', 'href')->[0]->[0];

		$trend_hashref->{desc} = $div->look_down('class',qr/col-9 d-inline-block text-gray m-0 pr-4/)->as_text_trimmed;

		$trend_hashref->{language} = $div->look_down('class','d-inline-block mr-3')->{_content}->[3]->{_content}->[0] || 'none';
		$trend_hashref->{language} =~ s/\A\s*(.*?)\s*\z/$1/;

		$trend_hashref->{today_star} = $div->look_down('class','d-inline-block float-sm-right')->as_text;
		$trend_hashref->{today_star} =~ s/\A\s*(.*?)\s*\z/$1/;

		my @starfork = $div->look_down('class',qr/muted-link d-inline-block mr-3/);
		$trend_hashref->{star} = $starfork[0]->{_content}->[0];
		$trend_hashref->{star} =~ s/\A\s*(.*?)\s*\z/$1/;
		$trend_hashref->{fork} = $starfork[1]->{_content}->[0];
		$trend_hashref->{fork} =~ s/\A\s*(.*?)\s*\z/$1/;

		push @$trend_list,$trend_hashref;
	}
	return $trend_list;
}

1;

