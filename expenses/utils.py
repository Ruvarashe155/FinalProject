from .models import Notification
from .models import AuditLog
from django.contrib.contenttypes.models import ContentType



def notify(user, message):
    Notification.objects.create(user=user, message=message)




def log_action(user, action, record=None, details=""):

    content_type = None
    object_id = None

    # ONLY SET CONTENT TYPE IF RECORD IS A MODEL INSTANCE
    if record:
        content_type = ContentType.objects.get_for_model(record.__class__)
        object_id = record.pk

    AuditLog.objects.create(
        user=user,
        action=action,
        content_type=content_type,
        object_id=object_id,
        details=details
    )
