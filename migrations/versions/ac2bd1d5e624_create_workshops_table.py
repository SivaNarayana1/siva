"""create workshops table

Revision ID: ac2bd1d5e624
Revises:
Create Date: 2022-12-03 17:28:38.563995

"""
import sqlalchemy as sa
from alembic import op


# revision identifiers, used by Alembic.
revision = 'ac2bd1d5e624'
down_revision = '46a278193a94'
branch_labels = None
depends_on = None


def upgrade():
    op.create_table(
        "workshops",
        sa.Column("id", sa.Integer(), nullable=False),
        sa.Column("name", sa.String(length=32), nullable=True),
        sa.Column("start_date", sa.DateTime(), nullable=True),
        sa.Column("end_date", sa.DateTime(), nullable=True),
        sa.Column("creator", sa.String(length=128), nullable=True),
        sa.Column("email", sa.String(length=128), nullable=True),
        sa.PrimaryKeyConstraint("id"),
    )


def downgrade():
    op.drop_table("workshops")
