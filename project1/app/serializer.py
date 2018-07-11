from rest_framework import serializers

from .models import GitHubTrend


class TrendSerializer(serializers.ModelSerializer):
    class Meta:
        model = GitHubTrend
        fields = ('name', 'desc', 'today_star', 'total_star', 'fork', 'watch', 'detail_desc')
