class CaseNotebook
  include Mongoid::Document

  field :case_id
  embeds_many :notes

end


class Note
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :case_notebook

  field :body, type: String
end
