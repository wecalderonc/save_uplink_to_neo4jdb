class ForceCreateBaseModelUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :BaseModel, :uuid, force: true
  end

  def down
    drop_constraint :BaseModel, :uuid
  end
end
