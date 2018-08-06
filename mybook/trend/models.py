from django.db import models


# Create your models here.
class TrendSet(models.Model):

    rep = models.TextField()
    des = models.TextField()

    def __str__(self):
        return self.rep