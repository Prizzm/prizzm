require 'helper'
require 'tmpdir'

class TestMechanizeCookieJar < MiniTest::Unit::TestCase

  def setup
    @jar = Mechanize::CookieJar.new
    @tmpdir = Dir.mktmpdir

    @orig_dir = Dir.pwd
    Dir.chdir @tmpdir
  end

  def teardown
    Dir.chdir @orig_dir
    FileUtils.remove_entry_secure @tmpdir
  end

  def cookie_values(options = {})
    {
      :name     => 'Foo',
      :value    => 'Bar',
      :path     => '/',
      :expires  => Time.now + (10 * 86400),
      :domain   => 'rubyforge.org'
   }.merge(options)
  end

  def cookie_from_hash(hash)
    c = Mechanize::Cookie.new(hash[:name], hash[:value])
    hash.each { |k,v|
      next if k == :name || k == :value
      c.send("#{k}=", v)
    }
    c
  end

  def test_two_cookies_same_domain_and_name_different_paths
    url = URI.parse('http://rubyforge.org/')

    cookie = cookie_from_hash(cookie_values)
    @jar.add(url, cookie)
    @jar.add(url, cookie_from_hash(cookie_values(:path => '/onetwo')))

    assert_equal(1, @jar.cookies(url).length)
    assert_equal 2, @jar.cookies(URI.parse('http://rubyforge.org/onetwo')).length
  end

  def test_domain_case
    url = URI.parse('http://rubyforge.org/')

    # Add one cookie with an expiration date in the future
    cookie = cookie_from_hash(cookie_values)
    @jar.add(url, cookie)
    assert_equal(1, @jar.cookies(url).length)

    @jar.add(url, cookie_from_hash(
        cookie_values(:domain => 'RuByForge.Org', :name   => 'aaron')))

    assert_equal(2, @jar.cookies(url).length)

    url2 = URI.parse('http://RuByFoRgE.oRg/')
    assert_equal(2, @jar.cookies(url2).length)
  end

  def test_empty_value
    values = cookie_values(:value => "")
    url = URI.parse('http://rubyforge.org/')

    # Add one cookie with an expiration date in the future
    cookie = cookie_from_hash(values)
    @jar.add(url, cookie)
    assert_equal(1, @jar.cookies(url).length)

    @jar.add(url, cookie_from_hash( values.merge(  :domain => 'RuByForge.Org',
                                                  :name   => 'aaron'
                                               ) ) )

    assert_equal(2, @jar.cookies(url).length)

    url2 = URI.parse('http://RuByFoRgE.oRg/')
    assert_equal(2, @jar.cookies(url2).length)
  end

  def test_add_future_cookies
    url = URI.parse('http://rubyforge.org/')

    # Add one cookie with an expiration date in the future
    cookie = cookie_from_hash(cookie_values)
    @jar.add(url, cookie)
    assert_equal(1, @jar.cookies(url).length)

    # Add the same cookie, and we should still only have one
    @jar.add(url, cookie_from_hash(cookie_values))
    assert_equal(1, @jar.cookies(url).length)

    # Make sure we can get the cookie from different paths
    assert_equal(1, @jar.cookies(URI.parse('http://rubyforge.org/login')).length)

    # Make sure we can't get the cookie from different domains
    assert_equal(0, @jar.cookies(URI.parse('http://google.com/')).length)
  end

  def test_add_multiple_cookies
    url = URI.parse('http://rubyforge.org/')

    # Add one cookie with an expiration date in the future
    cookie = cookie_from_hash(cookie_values)
    @jar.add(url, cookie)
    assert_equal(1, @jar.cookies(url).length)

    # Add the same cookie, and we should still only have one
    @jar.add(url, cookie_from_hash(cookie_values(:name => 'Baz')))
    assert_equal(2, @jar.cookies(url).length)

    # Make sure we can get the cookie from different paths
    assert_equal(2, @jar.cookies(URI.parse('http://rubyforge.org/login')).length)

    # Make sure we can't get the cookie from different domains
    assert_equal(0, @jar.cookies(URI.parse('http://google.com/')).length)
  end

  def test_add_rejects_cookies_that_do_not_contain_an_embedded_dot
    url = URI.parse('http://rubyforge.org/')

    tld_cookie = cookie_from_hash(cookie_values(:domain => '.org'))
    @jar.add(url, tld_cookie)
    single_dot_cookie = cookie_from_hash(cookie_values(:domain => '.'))
    @jar.add(url, single_dot_cookie)

    assert_equal(0, @jar.cookies(url).length)
  end

  def test_add_makes_exception_for_local_tld
    url = URI.parse('http://example.local')

    tld_cookie = cookie_from_hash(cookie_values(:domain => '.local'))
    @jar.add(url, tld_cookie)

    assert_equal(1, @jar.cookies(url).length)
  end

  def test_add_makes_exception_for_localhost
    url = URI.parse('http://localhost')

    tld_cookie = cookie_from_hash(cookie_values(:domain => 'localhost'))
    @jar.add(url, tld_cookie)

    assert_equal(1, @jar.cookies(url).length)
  end

  def test_add_cookie_for_the_parent_domain
    url = URI.parse('http://x.foo.com')

    cookie = cookie_from_hash(cookie_values(:domain => '.foo.com'))
    @jar.add(url, cookie)

    assert_equal(1, @jar.cookies(url).length)
  end

  def test_add_rejects_cookies_from_a_nested_subdomain
    url = URI.parse('http://y.x.foo.com')

    cookie = cookie_from_hash(cookie_values(:domain => '.foo.com'))
    @jar.add(url, cookie)

    assert_equal(0, @jar.cookies(url).length)
  end

  def test_cookie_without_leading_dot_does_not_match_subdomains
    url = URI.parse('http://admin.rubyforge.org/')

    cookie = cookie_from_hash(cookie_values(:domain => 'rubyforge.org'))
    @jar.add(url, cookie)

    assert_equal(0, @jar.cookies(url).length)
  end

  def test_cookies_with_leading_dot_match_subdomains
    url = URI.parse('http://admin.rubyforge.org/')

    @jar.add(url, cookie_from_hash(cookie_values(:domain => '.rubyforge.org')))

    assert_equal(1, @jar.cookies(url).length)
  end

  def test_cookies_dot
    url = URI.parse('http://www.host.example/')

    @jar.add(url,
             cookie_from_hash(cookie_values(:domain => 'www.host.example')))

    url = URI.parse('http://wwwxhost.example/')
    assert_equal(0, @jar.cookies(url).length)
  end

  def test_clear_bang
    url = URI.parse('http://rubyforge.org/')

    # Add one cookie with an expiration date in the future
    cookie = cookie_from_hash(cookie_values)
    @jar.add(url, cookie)
    @jar.add(url, cookie_from_hash(cookie_values(:name => 'Baz')))
    assert_equal(2, @jar.cookies(url).length)

    @jar.clear!

    assert_equal(0, @jar.cookies(url).length)
  end

  def test_save_cookies_yaml
    url = URI.parse('http://rubyforge.org/')

    # Add one cookie with an expiration date in the future
    cookie = cookie_from_hash(cookie_values)
    s_cookie = cookie_from_hash(cookie_values(:name => 'Bar',
                                              :expires => nil,
                                              :session => true))

    @jar.add(url, cookie)
    @jar.add(url, s_cookie)
    @jar.add(url, cookie_from_hash(cookie_values(:name => 'Baz')))

    assert_equal(3, @jar.cookies(url).length)

    @jar.save_as("cookies.yml")

    jar = Mechanize::CookieJar.new
    jar.load("cookies.yml")
    assert_equal(2, jar.cookies(url).length)

    assert_equal(3, @jar.cookies(url).length)
  end

  def test_save_cookies_cookiestxt
    url = URI.parse('http://rubyforge.org/')

    # Add one cookie with an expiration date in the future
    cookie = cookie_from_hash(cookie_values)
    s_cookie = cookie_from_hash(cookie_values(:name => 'Bar',
                                              :expires => nil,
                                              :session => true))

    @jar.add(url, cookie)
    @jar.add(url, s_cookie)
    @jar.add(url, cookie_from_hash(cookie_values(:name => 'Baz')))

    assert_equal(3, @jar.cookies(url).length)

    @jar.save_as("cookies.txt", :cookiestxt)

    jar = Mechanize::CookieJar.new
    jar.load("cookies.txt", :cookiestxt) # HACK test the format
    assert_equal(2, jar.cookies(url).length)

    assert_equal(3, @jar.cookies(url).length)
  end

  def test_expire_cookies
    url = URI.parse('http://rubyforge.org/')

    # Add one cookie with an expiration date in the future
    cookie = cookie_from_hash(cookie_values)
    @jar.add(url, cookie)
    assert_equal(1, @jar.cookies(url).length)

    # Add a second cookie
    @jar.add(url, cookie_from_hash(cookie_values(:name => 'Baz')))
    assert_equal(2, @jar.cookies(url).length)

    # Make sure we can get the cookie from different paths
    assert_equal(2, @jar.cookies(URI.parse('http://rubyforge.org/login')).length)

    # Expire the first cookie
    @jar.add(url, cookie_from_hash(
        cookie_values(:expires => Time.now - (10 * 86400))))
    assert_equal(1, @jar.cookies(url).length)

    # Expire the second cookie
    @jar.add(url, cookie_from_hash(
        cookie_values( :name => 'Baz', :expires => Time.now - (10 * 86400))))
    assert_equal(0, @jar.cookies(url).length)
  end

  def test_session_cookies
    values = cookie_values(:expires => nil)
    url = URI.parse('http://rubyforge.org/')

    # Add one cookie with an expiration date in the future
    cookie = cookie_from_hash(values)
    @jar.add(url, cookie)
    assert_equal(1, @jar.cookies(url).length)

    # Add a second cookie
    @jar.add(url, cookie_from_hash(values.merge(:name => 'Baz')))
    assert_equal(2, @jar.cookies(url).length)

    # Make sure we can get the cookie from different paths
    assert_equal(2, @jar.cookies(URI.parse('http://rubyforge.org/login')).length)

    # Expire the first cookie
    @jar.add(url, cookie_from_hash(values.merge(:expires => Time.now - (10 * 86400))))
    assert_equal(1, @jar.cookies(url).length)

    # Expire the second cookie
    @jar.add(url, cookie_from_hash(
        values.merge(:name => 'Baz', :expires => Time.now - (10 * 86400))))
    assert_equal(0, @jar.cookies(url).length)

    # When given a URI with a blank path, CookieJar#cookies should return
    # cookies with the path '/':
    url = URI.parse('http://rubyforge.org')
    assert_equal '', url.path
    assert_equal(0, @jar.cookies(url).length)
    # Now add a cookie with the path set to '/':
    @jar.add(url, cookie_from_hash(values.merge( :name => 'has_root_path',
                                          :path => '/')))
    assert_equal(1, @jar.cookies(url).length)
  end

  def test_paths
    values = cookie_values(:path => "/login", :expires => nil)
    url = URI.parse('http://rubyforge.org/login')

    # Add one cookie with an expiration date in the future
    cookie = cookie_from_hash(values)
    @jar.add(url, cookie)
    assert_equal(1, @jar.cookies(url).length)

    # Add a second cookie
    @jar.add(url, cookie_from_hash(values.merge( :name => 'Baz' )))
    assert_equal(2, @jar.cookies(url).length)

    # Make sure we don't get the cookie in a different path
    assert_equal(0, @jar.cookies(URI.parse('http://rubyforge.org/hello')).length)
    assert_equal(0, @jar.cookies(URI.parse('http://rubyforge.org/')).length)

    # Expire the first cookie
    @jar.add(url, cookie_from_hash(values.merge( :expires => Time.now - (10 * 86400))))
    assert_equal(1, @jar.cookies(url).length)

    # Expire the second cookie
    @jar.add(url, cookie_from_hash(values.merge( :name => 'Baz',
                                          :expires => Time.now - (10 * 86400))))
    assert_equal(0, @jar.cookies(url).length)
  end

  def test_save_and_read_cookiestxt
    url = URI.parse('http://rubyforge.org/')

    # Add one cookie with an expiration date in the future
    cookie = cookie_from_hash(cookie_values)
    @jar.add(url, cookie)
    @jar.add(url, cookie_from_hash(cookie_values(:name => 'Baz')))
    assert_equal(2, @jar.cookies(url).length)

    @jar.save_as("cookies.txt", :cookiestxt)
    @jar.clear!

    @jar.load("cookies.txt", :cookiestxt)
    assert_equal(2, @jar.cookies(url).length)
  end

  def test_save_and_read_cookiestxt_with_session_cookies
    url = URI.parse('http://rubyforge.org/')

    @jar.add(url, cookie_from_hash(cookie_values(:expires => nil)))
    @jar.save_as("cookies.txt", :cookiestxt)
    @jar.clear!

    @jar.load("cookies.txt", :cookiestxt)
    assert_equal(1, @jar.cookies(url).length)
    assert_nil @jar.cookies(url).first.expires
  end

  def test_save_and_read_expired_cookies
    url = URI.parse('http://rubyforge.org/')

    @jar.jar['rubyforge.org'] = {}


    @jar.add url, cookie_from_hash(cookie_values)

    # HACK no asertion
  end

  def test_ssl_cookies
    # thanks to michal "ocher" ochman for reporting the bug responsible for this test.
    values = cookie_values(:expires => nil)
    values_ssl = values.merge(:domain => "#{values[:domain]}:443")
    url = URI.parse('https://rubyforge.org/login')

    cookie = cookie_from_hash(values)
    @jar.add(url, cookie)
    assert_equal(1, @jar.cookies(url).length, "did not handle SSL cookie")

    cookie = cookie_from_hash(values_ssl)
    @jar.add(url, cookie)
    assert_equal(2, @jar.cookies(url).length, "did not handle SSL cookie with :443")
  end
end
