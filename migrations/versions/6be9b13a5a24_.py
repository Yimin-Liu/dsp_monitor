"""empty message

Revision ID: 6be9b13a5a24
Revises: 3a8b6433716c
Create Date: 2022-05-20 14:26:49.922289

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = '6be9b13a5a24'
down_revision = '3a8b6433716c'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('cameras', sa.Column('ip_addr', sa.String(length=200), nullable=False))
    op.create_unique_constraint(None, 'cameras', ['ip_addr'])
    op.drop_column('cameras', 'ip_add')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('cameras', sa.Column('ip_add', mysql.VARCHAR(length=200), nullable=False))
    op.drop_constraint(None, 'cameras', type_='unique')
    op.drop_column('cameras', 'ip_addr')
    # ### end Alembic commands ###
