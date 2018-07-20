package TrendView::Controller::Ctrl_app;

use Mojo::Base 'Mojolicious::Controller';

sub title {
	my $self = shift;
	$self->render(
		controller => 'View_app',
		action     => 'title',
		msg        => 'Trend View'
  );
}

1;
