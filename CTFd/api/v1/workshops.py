from typing import List

from flask import request
from flask_restx import Namespace, Resource

from CTFd.api.v1.helpers.schemas import sqlalchemy_to_pydantic
from CTFd.api.v1.schemas import APIDetailedSuccessResponse, APIListSuccessResponse
from CTFd.models import Workshops,WorkshopChallenges,WorkshopInvitees,db
from CTFd.utils.decorators import public
from CTFd.schemas.workshops import WorkshopSchema,WorkshopChallengeSchema,WorkshopInviteeSchema
import datetime
from sqlalchemy.orm import subqueryload

workshops_namespace = Namespace("workshops", description="Endpoint to retrieve workshops")

WorkshopModel = sqlalchemy_to_pydantic(Workshops)


class WorkshopDetailedSuccessResponse(APIDetailedSuccessResponse):
    data: WorkshopModel


class WorkshopListSuccessResponse(APIListSuccessResponse):
    data: List[WorkshopModel]


workshops_namespace.schema_model(
    "WorkshopDetailedSuccessResponse", WorkshopDetailedSuccessResponse.apidoc()
)

workshops_namespace.schema_model(
    "WorkshopListSuccessResponse", WorkshopListSuccessResponse.apidoc()
)


@workshops_namespace.route("")
class WorkshopPublic(Resource):
    @public
    @workshops_namespace.doc(
        description="Endpoint to create a Workshop object",
        responses={
            200: ("Success", "WorkshopDetailedSuccessResponse"),
            400: (
                    "An error occured processing the provided or stored data",
                    "APISimpleErrorResponse",
            ),
        },
    )
    def get(self):
        return {"success": True, "data": ""}
    @public
    @workshops_namespace.doc(
        description="Endpoint to create a Workshop object",
        responses={
            200: ("Success", "WorkshopDetailedSuccessResponse"),
            400: (
                    "An error occured processing the provided or stored data",
                    "APISimpleErrorResponse",
            ),
        },
    )
    def post(self):
        req = request.get_json()
        req['start_date']= datetime.datetime.strptime(req['start_date'], '%Y-%m-%d').strftime('%Y-%m-%dT%H:%M:%S.%f')
        req['end_date']= datetime.datetime.strptime(req['end_date'], '%Y-%m-%d').strftime('%Y-%m-%dT%H:%M:%S.%f')
        schema = WorkshopSchema("admin")
        response = schema.load(req)
        if response.errors:
            return {"success": False, "errors": response.errors}, 400
        try:
            db.session.add(response.data)
            db.session.commit()
        except:
            db.session.rollback()
            raise
        else:
            db.session.commit()
        workshop = Workshops.query.filter_by(id=response.data.id).options(subqueryload('invitees').subqueryload('user')).options(subqueryload('challenges').subqueryload('challenge')).first_or_404()
        response = []
        for t in workshop.invitees:
            response.append(
                 t.user.email
            )
        # response = schema.dump(workshop)
        print(response)
        return {"success": True, "data": {"id": workshop.id, "emails": response}}

@workshops_namespace.route("/add")
class WorkshopList(Resource):
    @public
    @workshops_namespace.doc(
        description="Endpoint to create a Workshop object",
        responses={
            200: ("Success", "WorkshopDetailedSuccessResponse"),
            400: (
                    "An error occured processing the provided or stored data",
                    "APISimpleErrorResponse",
            ),
        },
    )
    def post(self):
        req = request.get_json()
        print(req)
        schema = WorkshopChallengeSchema("admin")
        print(schema)
        print(req['challenges'])
        response= []
        for ch in req['challenges']:
            print(schema.load(ch).data)
            response.append(schema.load(ch).data)
        print(response)
        try:
            db.session.query(WorkshopChallenges).filter_by(workshop_id=req['workshop_id']).delete()
            db.session.commit()
            db.session.add_all(response)
            db.session.commit()
        except:
            db.session.rollback()
            raise
        else:
            db.session.commit()
        return {"success": True, "data": {}}

@workshops_namespace.route("/add_user")
class WorkshopUser(Resource):
    @public
    @workshops_namespace.doc(
        description="Endpoint to create a Workshop object",
        responses={
            200: ("Success", "WorkshopDetailedSuccessResponse"),
            400: (
                    "An error occured processing the provided or stored data",
                    "APISimpleErrorResponse",
            ),
        },
    )
    def post(self):
        req = request.get_json()
        print(req)
        schema = WorkshopInviteeSchema("admin")
        print(schema)
        print(req['invitees'])
        response= []
        for ch in req['invitees']:
            print(schema.load(ch).data)
            response.append(schema.load(ch).data)
        print(response)
        try:
            db.session.query(WorkshopInvitees).filter_by(workshop_id=req['workshop_id']).delete()
            db.session.commit()
            db.session.add_all(response)
            db.session.commit()
        except:
            db.session.rollback()
            raise
        else:
            db.session.commit()
        workshop = Workshops.query.filter_by(id=req['workshop_id']).options(subqueryload('invitees').subqueryload('user')).options(subqueryload('challenges').subqueryload('challenge')).first_or_404()
        response = []
        for t in workshop.invitees:
            response.append(
                t.user.email
            )
        # response = schema.dump(workshop)
        print(response)
        return {"success": True, "data": {"id": workshop.id, "emails": response}}
