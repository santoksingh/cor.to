puts 'SEEDING DEFAULT USER'
user = User.find_or_create_by_email(
  :email                 => ENV['ADMIN_EMAIL'].dup,
  :password              => ENV['ADMIN_PASSWORD'].dup,
  :password_confirmation => ENV['ADMIN_PASSWORD'].dup,
  :confirmed_at          => DateTime.now)
puts 'email    : ' << user.email
puts 'password : ' << user.password

puts 'SEEDING LINKS TO DEFAULT USER...'
user.links.new(
  :title       => 'Faitic',
  :description => 'Proporciona as ferramentas e os recursos necesarios para o
  desenvolvemento da teleformación na Universidade de Vigo. Programas,
  novidades e recursos.',
  :out_url     => 'http://faitic.uvigo.es'
).save
puts 'Faitic'
user.links.new(
  :title       => 'Lorem Ipsum',
  :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.
  Vivamus et ligula nec erat congue fermentum. Ut commodo eros vel congue
  pulvinar. Curabitur porttitor mauris sit amet fringilla bibendum. Maecenas
  vel molestie elit, ut sodales massa. Quisque et tellus nulla. Nam in nulla
  sed lectus volutpat consequat et quis lacus. Mauris congue lectus vel ante
  hendrerit, eget euismod lorem luctus. Vestibulum risus nibh, blandit pulvinar
  ante vel, consequat pharetra felis. Etiam justo sapien, pharetra et orci nec,
    placerat placerat magna. Vivamus ligula urna, vehicula at auctor in,
    malesuada nec ligula. Suspendisse potenti. In sit amet sem porta, fermentum
  lorem quis, molestie enim. In nec justo dapibus, elementum magna vitae,
    ullamcorper mauris. Aliquam a diam vitae massa laoreet dictum non non
  mauris. Quisque auctor, augue eget mattis rutrum, mi dolor consectetur dui,
    eu dapibus lectus est at libero. Fusce condimentum nec ligula ut
  hendrerit.',
  :out_url     => 'http://www.lipsum.com'
).save
puts 'Lorem Ipsum'
user.links.new(
  :title       => 'Hacker News',
  :description => 'Why [popular technology] is [unexpected opinion]. Why I have
  decided to stop using [tried and true web dev environment] and start using
  Meteor. Why [obscure framework] is the next [industry standard framework].
    Ask HN: Why is nobody using [obscure niche technology from the 80s]?. Can
  the NSA blow up your PC remotely?. Why you shouldn\'t store your files
  locally, but in the cloud. Why it\'s impossible to use [PHP|Java] even though
  millions of people are doing great things with it. Some blog post about
  scalability... blog crashes after posting link to HN and /r/programming. Show
  /hn/: I ripped off an existing product and added Bootstrap to it. Hacker,
    entrepreneur, genius, lifestyle blogger, CEO of Whoof! Pastebin for dog
  owners and pixel.io image-resizing service made entirely in Go. How I teached
  my 6 year old daughter how to do high algorithm trading in Haskell',
  :out_url     => 'https://news.ycombinator.com'
).save
puts 'Hacker News'
user.links.new(
  :title       => 'Proggit - /r/programming',
  :description => '@see HackerNews#description',
  :out_url     => 'http://www.reddit.com/r/programming/'
).save
puts 'Proggit - /r/programming'
user.links.new(
  :title       => 'ESEI',
  :description => 'A Escola Superior de Enxeñaría Informática (en diante, ESEI)
  é, dende o curso 1991/1992, o Centro da Universidade de Vigo que ten a
  responsabilidade de impartir os ensinos universitarios relacionadas co ámbito
  da enxeñaría informática. Atópase situada no Edificio Politécnico do Campus
  de Ourense.',
  :out_url     => 'http://esei.uvigo.es/'
).save
puts 'ESEI'
user.links.new(
  :title       => 'Developing Android Apps with Scala and Scaloid',
  :description => 'Scaloid is an open-source library that enables Scala
  developers to create Android apps without having to migrate to Java. Scaloid
  takes full advantage of many of Scala\'s features, such as the efficient way
  of creating Domain Specific Languages (DSLs), implicit conversions, pattern
  matching, and type safety. Scaloid proposes a novel method of developing
  Android apps, which is worth a second look. In this lead article of a
  two-part series on Scaloid, I explain some of its most interesting
  features.',
  :out_url     => 'http://www.drdobbs.com/mobile/developing-android-apps-with-scala-and-s/240161584'
).save
puts 'Developing Android Apps with Scala and Scaloid'
user.links.new(
  :title       => 'PHP The Right Way',
  :description => 'There’s a lot of outdated information on the Web that leads
  new PHP users astray, propagating bad practices and insecure code. PHP: The
  Right Way is an easy-to-read, quick reference for PHP popular coding
  standards, links to authoritative tutorials around the Web and what the
  contributors consider to be best practices at the present time.',
  :out_url     => 'http://www.phptherightway.com/',
  :favorited   => true
).save
puts 'PHP The Right Way'
user.links.new(
  :title       => 'Dwarf Fortress in 2013',
  :description => 'The 30-year plan',
  :out_url     => 'http://gamasutra.com/view/feature/195148/dwarf_fortress_in_2013.php'
).save
puts 'Dwarf Fortress in 2013'
user.links.new(
  :title       => 'Game Programming Patterns',
  :description => 'Welcome to Game Programming Patterns, a book on
  architectural patterns in game code. If you ever struggle with the complexity
  of your game\'s codebase, this book will help. The complete text (that I\'ve
  written so far) is available online for free, and will always be. Follow the
  table of contents below to start your journey!',
  :out_url     => 'http://gameprogrammingpatterns.com/',
  :favorited   => true
).save
puts 'Game Programming Patterns'
user.links.new(
  :title       => 'Automating Card Games Using OpenCV and Python',
  :description => '',
  :out_url     => 'http://arnab.org/blog/so-i-suck-24-automating-card-games-using-opencv-and-python'
).save
puts 'Automating Card Games Using OpenCV and Python'
user.links.new(
  :title       => 'Logic Programming is Underrated',
  :description => '',
  :out_url     => 'http://swannodette.github.io/2013/03/09/logic-programming-is-underrated/'
).save
puts 'Logic Programming is Uderrated'
user.links.new(
  :title       => 'Golang heap corruption during garbage collection',
  :description => 'The bug is a variable overwrite during garbage collection
  (see patch): in some weird situation, n (length of the block to garbage
  collect) is rewritten with channel capacity because reusing the same variable
  name. We can use that to break the memory safety: have the garbage collector
  mark some used blocks as free so we can overwrite them and use them in an
  unexpected way. We can also think of it as a use after free (wrong free by
  the garbage collector).',
  :out_url     => 'http://blog.stalkr.net/2013/06/golang-heap-corruption-during-garbage.html'
).save
puts 'Golang heap corruption during garbage collection'
user.links.new(
  :title       => 'Tetris Printer Algorithm',
  :description => 'By rotating, positioning and dropping a predetermined
  sequence of pieces, the Tetris Printer Algorithm exploits the mechanics of
  Tetris to generate arbitrary bitmap images.',
  :out_url     => 'http://meatfighter.com/tetrisprinteralgorithm/',
  :favorited   => true
).save
puts 'Tetris Printer Algorithm'
user.links.new(
  :title       => 'How far can you overhang blocks?',
  :description => '',
  :out_url     => 'http://www.datagenetics.com/blog/may32013/index.html'
).save
puts 'How far can you overhang blocks?'

puts "SEEDING RANDOM CLICKS TO LINKS..."
BROWSERS = ['Chrome', 'Firefox', 'Internet Explorer', 'Safari', 'Opera', 'Konqueror', 'uzbl', 'w3m']
REFERERS = ['twitter.com', 'facebook.com', 'google.com', 'esei.uvigo.es', 'gmail.com', 'meneame.net', 'reddit.com', 'feedly.com']
Link.all.each do |l|
  # 120 clicks aleatorios por cada link
  (1..120).each do |i|
    randIp      = IPAddr.new(rand(2**32), Socket::AF_INET).to_s
    randBrowser = BROWSERS.sample
    geocode     = Geocoder.search(randIp)
    country     = geocode.empty? ? 'Reserved' : geocode.first.country
    referer     = REFERERS.sample

    click = l.clicks.new(:ip => randIp, :browser => randBrowser, :country => country, :referer => referer)
    click.created_at = rand(i <= 100 ? 2**9 : 6).days.ago  # aseugra 20 clicks en ultima semana
    click.save
  end
end
