from django.db import models


class GitHubTrend(models.Model):

    name = models.TextField()
    desc = models.TextField()
    today_star = models.IntegerField()
    total_star = models.IntegerField()
    fork = models.IntegerField()
    watch = models.IntegerField()
    detail_desc = models.TextField()

    def __str__(self):
        return self.name
