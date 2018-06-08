from django.db import models

# Create your models here.
class TrendRepo(models.Model):

    repo = models.TextField()
    desc = models.TextField()
    star = models.IntegerField()

    def __str__(self):
        return self.repo
