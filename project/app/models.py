from django.db import models

# Create your models here.
class TrendRepo(models.Model):

    repo = models.TextField()
    desc = models.TextField()
    star = models.IntegerField()
    detail_desc = models.TextField()
    total_star = models.IntegerField()
    fork = models.IntegerField()
    watch = models.IntegerField()

    def __str__(self):
        return self.repo
