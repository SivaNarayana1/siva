from flask import Blueprint, render_template, request, url_for
from sqlalchemy.orm import subqueryload
from CTFd.models import Users
from CTFd.models import Challenges,Workshops,Solves,Teams
from CTFd.utils.decorators import admins_only,authed_only
from CTFd.plugins.challenges import CHALLENGE_CLASSES, get_chal_class
from CTFd.utils.scores import get_standings

workshops = Blueprint("workshops", __name__)


@workshops.route("/workshops")
@authed_only
@admins_only
def index():

    return render_template(
        "workshops/index.html",
    )

@workshops.route("/workshops/all")
@authed_only
@admins_only
def all():
    workshops = Workshops.query.options(subqueryload('invitees').subqueryload('user')).options(subqueryload('challenges').subqueryload('challenge')).all()
    return render_template(
        "workshops/all.html",
        workshops=workshops
    )

@workshops.route("/workshops/createworkshops")
@authed_only
@admins_only
def create():
    filters = []
    query = Challenges.query.filter(*filters).order_by(Challenges.id.asc())
    challenges = query.all()
    users = (
        Users.query.filter_by(banned=False, hidden=False, type="user")
            .filter(*filters)
            .order_by(Users.id.asc())
    )
    return render_template(
        "workshops/create.html",
        challenges=challenges,
        users=users
    )

@workshops.route("/workshops/<int:workshop_id>")
@authed_only
def public(workshop_id):
    query = Workshops.query.filter_by(id=workshop_id)
    workshop = query.first_or_404()
    return render_template(
        "workshops/show.html",
        workshop=workshop,
    )

@workshops.route("/workshops/<int:workshop_id>/challenges")
@authed_only
def challenges(workshop_id):
    workshop = Workshops.query.filter_by(id=workshop_id).options(subqueryload('invitees').subqueryload('user')).options(subqueryload('challenges').subqueryload('challenge')).first_or_404()
    challenges =[]
    for t in workshop.challenges:
        challenges.append(
            t
        )
    return render_template(
        "workshops/challenges.html",
        workshop=workshop,
        challenges=challenges
    )

@workshops.route("/workshops/<int:workshop_id>/challenges/<int:challenge_id>")
@authed_only
def challenge(workshop_id,challenge_id):
    workshop = Workshops.query.filter_by(id=workshop_id).options(subqueryload('invitees').subqueryload('user')).options(subqueryload('challenges').subqueryload('challenge')).first_or_404()
    solves=Solves.query.filter_by(challenge_id=challenge_id).order_by(Solves.date.asc()).all()
    challenge=Challenges.query.filter_by(id=challenge_id).all()
    return render_template(
        "workshops/challenge.html",
        workshop=workshop,
        solves=solves,
        challenge=challenge
    )

@workshops.route("/workshops/<int:workshop_id>/challenges/add")
@authed_only
@admins_only
def add_challenge(workshop_id):
    workshop = Workshops.query.filter_by(id=workshop_id).options(subqueryload('invitees').subqueryload('user')).options(subqueryload('challenges').subqueryload('challenge')).first_or_404()
    challenges = Challenges.query.order_by(Challenges.id.asc()).all()
    challenge_ids=[]
    for t in workshop.challenges:
        challenge_ids.append(
            t.challenge.id
        )
    print(challenge_ids)
    return render_template(
        "workshops/add_challenge.html",
        workshop=workshop,
        challenges=challenges,
        challenge_ids=challenge_ids
    )

@workshops.route("/workshops/<int:workshop_id>/challenges/users")
@authed_only
@admins_only
def add_user(workshop_id):
    workshop = Workshops.query.filter_by(id=workshop_id).options(subqueryload('invitees').subqueryload('user')).options(subqueryload('challenges').subqueryload('challenge')).first_or_404()
    users = (
        Users.query.filter_by(banned=False, hidden=False, type="user")
            .order_by(Users.id.asc())
    )
    user_ids = []
    for t in workshop.invitees:
        user_ids.append(
            t.user.id
        )
    return render_template(
        "workshops/add_users.html",
        workshop=workshop,
        users=users,
        user_ids=user_ids
    )

@workshops.route("/workshops/<int:workshop_id>/challenges/new")
@authed_only
@admins_only
def challenges_new(workshop_id):
    types = CHALLENGE_CLASSES.keys()
    return render_template("admin/challenges/new.html", types=types,workshop_id= workshop_id)

@workshops.route("/workshops/<int:workshop_id>/score")
@authed_only
def score(workshop_id):
    workshop = Workshops.query.filter_by(id=workshop_id).options(subqueryload('invitees').subqueryload('user')).options(subqueryload('challenges').subqueryload('challenge')).first_or_404()
    user_ids = []
    for t in workshop.invitees:
        user_ids.append(
            t.user.id
        )
    teams = (
        Teams.query.filter_by(hidden=False, banned=False)
            .filter(Teams.members.any(Users.id.in_(user_ids)))
            .order_by(Teams.id.asc())
            .all()
    )
    team_ids = []

    for t in teams:
        team_ids.append(
            t.id
        )
    standings = get_standings()
    filtered_standings=[]
    for s in standings:
        if s.account_id in team_ids:
            filtered_standings.append(
                s
            )
    return render_template("workshops/scoreboard.html",workshop_id= workshop_id,team_ids=team_ids,standings=filtered_standings)
