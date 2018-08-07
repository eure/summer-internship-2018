from django.core.management.base import BaseCommand
from trend.models import TrendSet
from .api import get_trend

class Command(BaseCommand):

    def handle(self, *args, **options):
        TrendSet.objects.all().delete()
        for repo,desc,detail_desc in get_trend():
            TrendSet.objects.create(rep=repo,des=detail_desc)
