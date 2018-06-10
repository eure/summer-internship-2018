from django.core.management.base import BaseCommand
from app.models import TrendRepo
from .api import get_trend

class Command(BaseCommand):

    def handle(self, *args, **options):
        TrendRepo.objects.all().delete()
        for repo,desc,star,detail_desc,total_star,fork,watch in get_trend():
            TrendRepo.objects.create(repo=repo,desc=desc,star=star,detail_desc=detail_desc,total_star=total_star,fork=fork,watch=watch)
