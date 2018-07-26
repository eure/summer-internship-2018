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

	my $extract = TrendView::Controller::Extract::Repository->new();
	my $trends = $extract->$since();

		$self->stash(
			extracted  => $trends,
			since      => $since

		);
		$self->render(
			controller => 'view_repository',
			action     => "t_$since",
		);
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

# GET '/trending/detail?developer=google&repository_name=go-cloud
sub detail {
	my $self = shift;
	my $trend_info = +{};
	$trend_info->{developer} = $self->param('developer');
	$trend_info->{repository_name} = $self->param('repository_name');

	my $readme_url = 'https://github.com/'.$trend_info->{developer}.'/'.$trend_info->{repository_name};
	my $extract = TrendView::Controller::Extract::Repository->new();
	$trend_info->{readme_html} = $extract->extract_readme($readme_url);

		$self->stash(
			trend_info 		=> $trend_info
		);
		$self->render(
			controller => 'view_repository',
			action     => 'repository_info'
		);
}

1;
