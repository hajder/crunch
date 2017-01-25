require "./lib/crunch/processor.rb"
require "test/unit"
require "mocha/test_unit"
require "json"

class TestProcessor < Test::Unit::TestCase

  def test_can_process_empty_payload
    result = Crunch::Processor::Facebook.new.process({})
    assert_equal(0, result.length)
  end

  def test_can_process_pages_without_interactions
    file = File.read('test/cases/many_pages_no_interactions.json')
    result = Crunch::Processor::Facebook.new.process(JSON.parse(file))
    assert_equal(0, result.length)
  end

  def test_can_process_pages_with_reactions_and_comments
    file = File.read('test/cases/many_pages_reactions_comments.json')
    result = Crunch::Processor::Facebook.new.process(JSON.parse(file))
    assert_equal(7, result.length)

    assert_equal('194530190999867,305736219467790,1335980433110025,photo,reaction,LIKE', result[0].join(','))
    assert_equal('328013207408214,305736219467790,1335980433110025,photo,reaction,LIKE', result[1].join(','))
    assert_equal('1409411862721793,305736219467790,1335980433110025,photo,comment', result[2].join(','))
    assert_equal('10202962091028162,305736219467790,1335980433110025,photo,comment', result[3].join(','))
    assert_equal('1620750328181751,305736219467790,1335980433110025,photo,comment', result[4].join(','))

    assert_equal('967983879918499,107840939393927,705677142943634,link,reaction,LIKE', result[5].join(','))
    assert_equal('10204536764126610,107840939393927,705677142943634,link,reaction,LIKE', result[6].join(','))
  end

  def test_can_process_large_facebook_response
    file = File.read('test/cases/facebook_response.json')
    result = Crunch::Processor::Facebook.new.process(JSON.parse(file))

    users = result.map {|x| x[0]}.uniq.count
    pages = result.map {|x| x[1]}.uniq.count
    posts = result.map {|x| x[2]}.uniq.count
    photos = result.count {|x| x[3] === 'photo'}
    videos = result.count {|x| x[3] === 'video'}
    links = result.count {|x| x[3] === 'link'}
    reactions = result.count {|x| x[4] === 'reaction'}
    comments =  result.count {|x| x[4] === 'comment'}

    assert_equal(707, users)
    assert_equal(3, pages)
    assert_equal(30, posts)
    assert_equal(707, photos)
    assert_equal(179, videos)
    assert_equal(8, links)
    assert_equal(894, photos + videos + links)
    assert_equal(475, reactions)
    assert_equal(419, comments)
    assert_equal(894, reactions + comments)
  end

end
