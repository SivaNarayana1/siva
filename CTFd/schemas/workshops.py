from CTFd.models import Workshops,WorkshopChallenges,WorkshopInvitees,ma
from CTFd.utils import string_types


class WorkshopSchema(ma.ModelSchema):
    class Meta:
        model = Workshops
        include_fk = True
        dump_only = ("id",)

    views = {"admin": ["id",
                       "name",
                       "start_date",
                       "end_date",
                       "creator",
                       "email",
                       "invitees",
                       "challenges"]}

    def __init__(self, view=None, *args, **kwargs):
        if view:
            if isinstance(view, string_types):
                kwargs["only"] = self.views[view]
            elif isinstance(view, list):
                kwargs["only"] = view

        super(WorkshopSchema, self).__init__(*args, **kwargs)


class WorkshopChallengeSchema(ma.ModelSchema):
    class Meta:
        model = WorkshopChallenges
        include_fk = True
        dump_only = ("id",)

    views = {"admin": ["id", "challenge_id", "workshop_id"]}

    def __init__(self, view=None, *args, **kwargs):
        if view:
            if isinstance(view, string_types):
                kwargs["only"] = self.views[view]
            elif isinstance(view, list):
                kwargs["only"] = view

        super(WorkshopChallengeSchema, self).__init__(*args, **kwargs)

class WorkshopInviteeSchema(ma.ModelSchema):
    class Meta:
        model = WorkshopInvitees
        include_fk = True
        dump_only = ("id",)

    views = {"admin": ["id", "user_id", "workshop_id"]}

    def __init__(self, view=None, *args, **kwargs):
        if view:
            if isinstance(view, string_types):
                kwargs["only"] = self.views[view]
            elif isinstance(view, list):
                kwargs["only"] = view

        super(WorkshopInviteeSchema, self).__init__(*args, **kwargs)
