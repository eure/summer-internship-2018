package TrendView::Controller::Extract::Developers;

=pod
	TrendView/Controller/Extract/Developers.pm
	- Github Trend に載っているデベロッパー一覧を取得するモジュール
=cut

use Mouse;
with 'TrendView::Controller::Extract';
use HTML::TreeBuilder;

sub daily {
	my $self = shift;
	my $url = 'https://github.com/trending/developers?since=daily';

	my $daily_trend = $self->extract_trend($url);
	return $daily_trend;
}

sub weekly {
	my $self = shift;
	my $url = 'https://github.com/trending/developers?since=weekly';

	my $daily_trend = $self->extract_trend($url);
	return $daily_trend;
}

sub monthly {
	my $self = shift;
	my $url = 'https://github.com/trending/developers?since=monthly';

	my $daily_trend = $self->extract_trend($url);
	return $daily_trend;
}

sub extract_trend {
	my $self = shift;
	my $url = shift;

	my $content = $self->get_content($url);

	$self->tree->parse_content($content);

	my $trend_of_day = +[];
	my @titles = $self->tree->look_down('class',qr/d-sm-flex flex-justify-between border-bottom border-gray-light py-3/);

	for my $div (@titles) {
		my $trend_hashref = +{};

		my $img_src =  $div->look_down('class','mx-2');
		$img_src->look_down('class',qr/rounded-1/);
		$trend_hashref->{img_src} = $img_src->extract_links()->[1]->[0];

		my $developer = $div->look_down('class',qr/f3 text-normal/)->extract_links->[0]->[0];
		$developer =~ s/\///g;
		$trend_hashref->{developer} = $developer;

		push @$trend_of_day,$trend_hashref;
	}
	return $trend_of_day;
}

__PACKAGE__->meta->make_immutable;

1;

