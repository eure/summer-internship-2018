from django.core.management.base import BaseCommand
from app.models import TrendRepo
from .api import get_trend

class Command(BaseCommand):

    def handle(self, *args, **options):
        TrendRepo.objects.all().delete()
        for repo in get_trend():
            TrendRepo.objects.create(repo=repo)
