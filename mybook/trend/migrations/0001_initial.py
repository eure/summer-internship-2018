# Generated by Django 2.0.1 on 2018-08-06 13:42

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='TrendSet',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('rep', models.TextField()),
                ('des', models.TextField()),
            ],
        ),
    ]
