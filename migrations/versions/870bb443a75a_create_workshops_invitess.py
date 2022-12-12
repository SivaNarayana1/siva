"""create workshops invitess

Revision ID: 870bb443a75a
Revises:
Create Date: 2022-12-04 13:17:29.867217

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '870bb443a75a'
down_revision = '5d317073e86a'
branch_labels = None
depends_on = None


def upgrade():
    op.create_table(
        "workshop_invitees",
        sa.Column("id", sa.Integer(), nullable=False),
        sa.Column("user_id", sa.Integer(), nullable=False),
        sa.Column("workshop_id", sa.Integer(), nullable=False),
        sa.ForeignKeyConstraint(["user_id"], ["users.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["workshop_id"], ["workshops.id"], ondelete="CASCADE"),
        sa.PrimaryKeyConstraint("id"),
    )


def downgrade():
    op.drop_table("workshop_invitees")
