require "helper"

class PostForm < MiniTest::Unit::TestCase
  def setup
    @agent = Mechanize.new
  end

  def test_post_form
    page = @agent.post("http://localhost/form_post",
                        'gender' => 'female'
                      )
    assert(page.links.find { |l| l.text == "gender:female" },
           "gender field missing")
  end

  def test_post_form_json
    page = @agent.post "http://localhost/form_post",
                       'json' => '["&quot;"]'

    assert page.links.find { |l| l.text == 'json:["""]' }
  end

  def test_post_form_multival
    page = @agent.post("http://localhost/form_post",
                       [ ['gender', 'female'],
                         ['gender', 'male']
                       ]
                      )
    assert(page.links.find { |l| l.text == "gender:female" },
           "gender field missing")

    assert(page.links.find { |l| l.text == "gender:male" },
           "gender field missing")

    assert_equal(2, page.links.length)
  end
end
