"""create workshops challanges

Revision ID: 5d317073e86a
Revises: 870bb443a75a
Create Date: 2022-12-04 13:17:40.412134

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '5d317073e86a'
down_revision = 'ac2bd1d5e624'
branch_labels = None
depends_on = None


def upgrade():
    op.create_table(
        "workshop_challenges",
        sa.Column("id", sa.Integer(), nullable=False),
        sa.Column("challenge_id", sa.Integer(), nullable=False),
        sa.Column("workshop_id", sa.Integer(), nullable=False),
        sa.ForeignKeyConstraint(["challenge_id"], ["challenges.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["workshop_id"], ["workshops.id"], ondelete="CASCADE"),
        sa.PrimaryKeyConstraint("id"),
    )


def downgrade():
    op.drop_table("workshop_challenges")
