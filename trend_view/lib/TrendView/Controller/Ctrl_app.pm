package TrendView::Controller::Ctrl_app;

use Mojo::Base 'Mojolicious::Controller';

use TrendView::Controller::Extract;
use TrendView::Controller::Extract::Repository;
use TrendView::Controller::Extract::Developers;

# GET '/'
sub title {
	my $self = shift;
	$self->render(
		controller => 'View_repository',
		action     => 'title',
		msg        => 'Trend View'
  );
}

# GET '/trending'
# GET '/trending?since=daily,weekly,monthly&repository=1~25
sub repository {
	my $self = shift;
	my $since = $self->param('since');
	my $detail = $self->param('repository');
	my $repository_num = 0;
	if ( $detail > 0 ) {
		$repository_num = $detail-1;
	}

	my $extract = TrendView::Controller::Extract::Repository->new();
	my $trends = $extract->$since();
	my $repository_info = $trends->[$repository_num];

	if ( defined $detail ) {
		$self->stash(
			trend_info => $repository_info,
		);
		$self->render(
			controller => 'view_repository',
			action     => 'repository_info'
		);
	} else {
		$self->stash(
			extracted  => $trends,
			since      => $since

		);
		$self->render(
			controller => 'view_repository',
			action     => "t_$since",
		);
	}
}

# GET '/trending/developers?since=daily,weekly,monthly
sub developers {
	my $self = shift;
	my $since = $self->param('since');

	my $extract = TrendView::Controller::Extract::Developers->new();
	my $trends = $extract->$since();

		$self->stash(
			extracted  => $trends,
			since      => $since
		);
		$self->render(
			controller => 'view_developer',
			action     => "t_$since"
		);
}

1;
