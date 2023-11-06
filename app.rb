require 'sinatra'

# Routes is an array of arrays. Each subarray's first entry is the shortened URL
# we're checking for, something like 50ftcl.it/:shortened; and the second entry
# is the complete URL we're redirecting to.
routes = [
  ['30-odd-foot-of-grunts', 'https://www.youtube.com/watch?v=dEUAGWEbco0'],
  ['abfab', 'https://www.youtube.com/watch?v=ToTBlI1w23o'],
  ['ace-ventura', 'https://www.youtube.com/watch?v=RRy5JJfw-JI'],
  ['addams', 'https://www.youtube.com/watch?v=-Z6STPcw3Ac#t=2m39s'],
  ['all-you-can-eat', 'https://www.youtube.com/watch?v=E2dmfnSarDI#t=2m6s'],
  ['angel', 'https://imgur.com/gallery/FkMkZ'],
  ['anarchy', 'https://www.youtube.com/watch?v=na7A3-UCCYE'],
  ['angry-flower', 'http://www.angryflower.com/308.html'],
  ['antechinus', 'https://en.wikipedia.org/wiki/Antechinus'],
  ['ass', 'https://www.youtube.com/watch?v=RXpTXZ2vhPk'],
  ['asshole', 'https://www.youtube.com/watch?v=UrgpZ0fUixs'],
  ['atlas', 'https://www.youtube.com/watch?v=AatcIe1qoT4'],
  ['baby-poo', 'https://www.youtube.com/watch?v=qkyvE5t6JYc'],
  ['bailey', 'https://www.youtube.com/watch?v=OoxBMfCCnWM'],
  ['balance', 'https://www.youtube.com/watch?v=PHkbDhzXLV4#t=19m30s'],
  ['barrowman', 'https://www.youtube.com/watch?v=1zY1orxW8Aw#t=45s'],
  ['bastard', 'https://www.youtube.com/watch?v=AR9tGikzKx0'],
  ['beautiful-bastard', 'https://www.google.com/search?q=melkor+fanart&tbm=isch&ved=2ahUKEwi0_6izj57yAhVDFHIKHbjKADMQ2-cCegQIABAA&oq=melkor+fanart&gs_lcp=CgNpbWcQAzIFCAAQgAQyBggAEAcQHjIGCAAQBxAeMgYIABAHEB4yBggAEAcQHjIGCAAQBxAeMgYIABAHEB4yBggAEAcQHjIGCAAQBxAeMgYIABAHEB5Q-UlYrVBgplFoAHAAeACAAfQBiAH4B5IBBTAuMy4ymAEAoAEBqgELZ3dzLXdpei1pbWfAAQE&sclient=img&ei=RxIOYfS_GcOoyAO4lYOYAw&bih=1066&biw=1395&hl=en'],
  ['bedsprings', 'https://www.youtube.com/watch?v=uPxKW7RR7h0#t=29m45s'],
  ['bee-gees', 'https://www.youtube.com/watch?v=TsE-Dqok5mY'],
  ['bellamy', 'https://en.wikipedia.org/wiki/Bellamy_salute'],
  ['bernard-black', 'https://www.youtube.com/watch?v=j0yAYPedrSI'],
  ['best-korea', 'https://knowyourmeme.com/photos/65469-best-korea'],
  ['big-talk-god', 'https://www.youtube.com/watch?v=EUbjpwyesk0'],
  ['blackadder', 'https://www.youtube.com/watch?v=YLHlP2Vgkx8'],
  ['bloody-colonials', 'https://en.wikipedia.org/wiki/Six_o%27clock_swill'],
  ['blueprint', 'https://www.dancarlin.com/product/hardcore-history-50-blueprint-for-armageddon-i/'],
  ['bond', 'https://www.youtube.com/watch?v=0cjlnnj0gtM#t=3m20s'],
  ['boulder', 'https://www.youtube.com/watch?v=c6XHLe94SJA&t=11s'],
  ['bowie', 'https://www.vogue.co.uk/gallery/david-bowie-style-file-fashion-history-in-pictures'],
  ['boxing-day-poo', 'https://www.youtube.com/watch?v=_500jmNDZMI#t=24m9s'],
  ['brain-bra', 'https://www.flickr.com/photos/53014884@N00/238554737'],
  ['buddy', 'https://www.youtube.com/watch?v=6FigprdcBGA'],
  ['burn-baby-burn', 'https://www.youtube.com/watch?v=u5lSeYd_riw'],
  ['burns-20-takes', 'https://www.youtube.com/watch?v=pqIGAspuZSM&ab_channel=casodisperato88'],
  ['business-time', 'https://www.youtube.com/watch?v=WGOohBytKTU#t=1m55s'],
  ['butter', 'https://www.youtube.com/watch?v=05Byne839Pg#t=1m16s'],
  #['butterfield-404', 'find that link to his website 404ing'],
  ['carolina-reaper', 'https://www.chilipeppermadness.com/chili-pepper-types/superhot-chili-peppers/carolina-reaper/'],
  ['catacombs', 'https://en.wikipedia.org/wiki/Catacombs_of_Paris'],
  ['challenge', 'https://www.amazon.com/Doc-Johnson-Classic-American-Challenge/dp/B002E9I0F2'],
  ['champagne', 'https://www.youtube.com/watch?v=NIDabDkcS8o#t=2m'],
  ['chaos', 'https://www.youtube.com/watch?v=dDU2JsgLpm4&ab_channel=WojciechMo'],
  ['chicken-head', 'https://www.youtube.com/watch?v=_dPlkFPowCc&ab_channel=SmarterEveryDay'],
  ['clf3', 'https://blogs.sciencemag.org/pipeline/archives/2008/02/26/sand_wont_save_you_this_time'],
  ['clunge', 'https://www.youtube.com/watch?v=5rx3RwwakAA#t=23m'],
  ['cockney', 'https://www.youtube.com/watch?v=w0aTzevVjqk'],
  ['code-fi', 'https://www.youtube.com/watch?v=f02mOEt11OQ&ab_channel=TheAMPChannel'],
  ['coke-wank', 'https://www.youtube.com/watch?v=6WLOdXGhJbA'],
  ['comic-sans', 'https://www.achewood.com/index.php?date=07052007'],
  ['concrete', 'https://www.youtube.com/watch?v=2J0oTemjzrY#t=27m05s'],
  ['crack', 'https://www.youtube.com/watch?v=eJW1tzNLwI8'],
  ['cricket', 'https://www.youtube.com/watch?v=KdxoPPuAdic'],
  ['crimson-fists', 'https://1d4chan.org/wiki/Pretty_Marines'],
  ['cuban-pete', 'https://www.youtube.com/watch?v=qfO_OfmGOl0'],
  ['cute-redhead', 'https://www.youtube.com/watch?v=IQew6ZWJtfI&lc=UgzNn3ZIdzmENaYOzr94AaABAg'],
  ['darien', 'https://en.wikipedia.org/wiki/Darien_scheme'],
  ['destroy', 'https://www.amazon.com/OffWorld-Designs-Unisex-Destroy-T-Shirt/dp/B00UCFHU1A'],
  ['diana', 'https://www.youtube.com/watch?v=YrAFqE36anw#t=7m30s'],
  ['double-barrel', 'https://www.quora.com/Why-are-double-barrelled-tanks-not-common'],
  ['doubledickdude', 'https://reddit.com/u/doubledickdude'],
  ['dougal', 'https://www.youtube.com/watch?v=nmfLS1hWO94#t=2m37s'],
  ['down', 'https://www.youtube.com/watch?v=gT9xuXQjxMM'],
  ['dracula', 'https://www.youtube.com/watch?v=oXcJTbgt1N8'],
  ['dressage', 'https://en.wikipedia.org/wiki/Dressage'],
  ['drum', 'https://www.youtube.com/watch?v=8Qi3JERmk9E'],
  ['durteh', 'https://www.youtube.com/watch?v=cVe3fTL1cPM'],
  ['epicanthal', 'https://en.wikipedia.org/wiki/Epicanthic_fold'],
  ['fab', 'https://www.youtube.com/watch?v=nauGAeTNLko'],
  ['f1-tyres', 'https://www.youtube.com/watch?v=pKb2Bt5eC7M#t=4m41s'],
  ['fate', 'https://www.youtube.com/watch?v=XS3gtuczcbU#t=1h18m20s'],
  ['faux-sweater', 'https://www.amazon.com/Faux-Real-Sublimated-Christmas-T-Shirt/dp/B07K95W5CG?fbclid=IwAR2Oyt30S0AY47ktoILH7cz1M0fFjLm3cYJ5X6FGQilGp0WRcumZjLmILfE'],
  ['fire', 'https://www.youtube.com/watch?v=0jgrCKhxE1s&ab_channel=DragonForce'],
  ['fix', 'https://www.youtube.com/watch?v=C2s0aOhkjmY'],
  ['for-the-emperor', 'https://www.goodreads.com/book/show/709611.For_the_Emperor'],
  ['fridge', 'https://www.youtube.com/watch?v=JVJvURqC8iY#t=1m15s'],
  ['frog', 'https://english.stackexchange.com/questions/430492/why-are-the-french-pejoratively-referred-to-as-frogs'],
  ['fry-laurie-duel', 'https://www.youtube.com/watch?v=sDsn-RRmDXU'],
  ['fuck-hint', 'https://www.youtube.com/watch?v=h68CfIUkPKs'],
  ['fuckeulogy', 'https://www.youtube.com/watch?v=AVb84n-FFx4'],
  ['fuckeulogy-the-second', 'https://www.youtube.com/watch?v=7q6PclNhbac'],
  ['gigantosnatch', 'https://www.verbicidemagazine.com/wp-content/uploads/2011/07/dock.jpg'],
  ['goon', 'http://thegoonshow.net/scripts_show.asp?title=s05e17_china_story'],
  ['gorgeous', 'https://www.youtube.com/watch?v=kzTTO6abhVo'],
  ['great-man', 'https://en.wikipedia.org/wiki/Great_man_theory'],
  ['great-red-spot', 'https://www.youtube.com/watch?v=TltVr2uUebs'],
  ['grond', 'https://www.youtube.com/watch?v=u9BinUHHPv0&lc=Ugxfok9Fq3Msz3i5cVd4AaABAg'],
  ['haka', 'https://www.youtube.com/watch?v=lt6GRghrmaU'],
  ['high', 'https://en.wikipedia.org/wiki/Explosive#High_explosives'],
  ['hogan', 'https://www.youtube.com/watch?v=ypE2oT-8Zag'],
  ['hope', 'https://www.youtube.com/watch?v=wtoHjGWc2s8#t=2m28s'],
  ['horse-roar', 'https://www.youtube.com/watch?v=RiZead-Wl6o'],
  ['hotdog', 'https://www.atlasobscura.com/places/pentagon-hot-dog-stand'],
  ['i-long-to-nestle-between-your-lordships-thighs', 'https://www.youtube.com/watch?v=SVRODdXVI3Q'],
  ['irish', 'https://www.irishtimes.com/blogs/generationemigration/2013/02/12/when-the-irish-became-white-immigrants-in-mid-19th-century-us/'],
  ['iron-crotch', 'https://www.youtube.com/watch?v=O5mTH_YtH50'],
  ['i-vow-to-thee', 'https://www.youtube.com/watch?v=87Xkr8z3lEo'],
  ['jackson', 'https://www.youtube.com/watch?v=7lvsBBNV-U4'],
  ['jeans', 'https://www.artofmanliness.com/articles/chuck-norris-action-jeans/'],
  ['jedward', 'https://www.youtube.com/watch?v=VEuWW2IaNfM'],
  ['kicking-ass', 'https://www.youtube.com/watch?v=00y3gV0dJow'],
  ['king', 'https://www.youtube.com/watch?v=grbSQ6O6kbs#t=1m44s'],
  ['king-lear', 'https://www.shmoop.com/king-lear/family-quotes.html'],
  ['kiosk', 'https://www.youtube.com/watch?v=72Xki72JkpU'],
  ['kitchen-gun', 'https://www.youtube.com/watch?v=6-7NDP8V-6A'],
  ['kneegrow', 'https://www.youtube.com/watch?v=JGzw2ecfkqU'], # account deleted
  ['kowloon-walled-city', 'https://en.wikipedia.org/wiki/Kowloon_Walled_City'],
  ['kray', 'https://www.youtube.com/watch?v=mBL3XB-PhE8'],
  ['kung-pow', 'https://www.youtube.com/watch?v=TEzoZ6tqUjA'],
  ['lead', 'https://www.youtube.com/watch?v=dceB3SKBw9w'],
  ['lesbian', 'https://www.theguardian.com/books/2015/nov/04/ian-fleming-bond-cured-pussy-galore-psycho-pathological-malady-lesbian'],
  ['lesbos', 'https://en.wikipedia.org/wiki/Lesbos'],
  ['liger', 'https://www.youtube.com/watch?v=Y5aW6Y4aF0s'],
  ['lobotomobile', 'https://www.thevintagenews.com/2017/01/14/walter-freeman-who-championed-lobotomy-in-the-us-was-touring-with-his-lobotomobile-demonstrating-the-procedure/'],
  ['lobotomobile-myth', 'https://medium.com/@Jack_ElHai/fighting-the-legend-of-the-lobotomobile-1b0acf8a8eb0'],
  ['look-what-happens-when-you-shrink-preproduction-from-three-years-to-three-months-no-seriously-wtf', 'https://www.youtube.com/watch?v=DHQSmJq0nmQ'],
  ['love', 'https://www.youtube.com/watch?v=jKpN8uEEa5c'],
  ['ludicrous', 'https://www.youtube.com/watch?v=mk7VWcuVOf0'],
  ['macho-macho-maaaaan', 'https://pinterest.nz/pin/95349717083017997/'],
  ['man-about-town', 'https://www.youtube.com/watch?v=xMxsLKQidY4'],
  ['manual-automatic', 'https://www.youtube.com/watch?v=OChmy2oAH7c&ab_channel=WavesForTheMasses'],
  ['matrix', 'https://www.youtube.com/watch?v=2oEnJfZ9joY'],
  ['maui', 'https://www.youtube.com/watch?v=Dadu2KLjMVM'],
  ['macrae-tartan', 'https://www.scotclans.com/blogs/clan-mn/macrae-tartans'],
  ['meats-back-on-the-menu-boys', 'https://www.youtube.com/watch?v=ufFOghMt1yI&t=59s'],
  ['mechanic', 'https://mashable.com/2015/04/22/queen-elizabeth-army/'],
  ['mel-b', 'https://www.youtube.com/watch?v=g58CIZYeRFE#t=37m4s'],
  ['mesmer', 'https://en.wikipedia.org/wiki/Animal_magnetism'],
  ['metallica', 'https://www.youtube.com/watch?v=-SJJkgc_rNc'],
  ['mirren', 'https://www.youtube.com/watch?v=n_kGkGUAKRw'],
  ['mirthmobile', 'https://www.youtube.com/watch?v=VzUU7SRRsGo'],
  ['moi', 'https://www.youtube.com/watch?v=noK4SBuz_pY'],
  ['mongrel-mob', 'https://abcnews.go.com/Lifestyle/photos/stunning-portraits-members-mighty-mongrel-mob-31796749/image-31804491'],
  ['mould', 'https://www.youtube.com/watch?v=PD9bVahTGek#t=2m53s'],
  ['naked', 'http://thegoonshow.net/scripts_show.asp?title=s05e11_the_spanish_suitcase'],
  ['nethers', 'https://www.youtube.com/watch?v=dHFuzbeTPew'],
  ['one-three', 'https://www.youtube.com/watch?v=SGMfwYmZ6mQ#t=2m51s'], # VIDEO UNAVAILABLE :O 
  ['particle', 'https://www.youtube.com/watch?v=mD4J5VUwiAs'],
  ['penis-pants', 'https://www.messynessychic.com/2013/08/01/the-1970s-political-activist-who-invented-penis-pants/'],
  ['phantom-zone', 'https://www.youtube.com/watch?v=2u3eQc_rx54&t=60s'],
  ['pierre', 'https://www.youtube.com/watch?v=PIMhizumUnw&t=78s&ab_channel=Swalka1991'],
  ['ping', 'https://www.youtube.com/watch?v=NcHdF1eHhgc#t=2m35s'],
  ['poo-poo', 'https://www.youtube.com/watch?v=df2hO0rhX6o#t=4m43s'],
  ['powers', 'https://www.youtube.com/watch?v=3C8Slzx-Gpc#t=2m39s'],
  ['preen', 'https://www.oglaf.com/stroke/'],
  ['protanomaly', 'https://www.healthline.com/health/eye-health/protan-color-blindness#overview'],
  ['prude', 'https://en.wikipedia.org/wiki/Napoleon_I_on_His_Imperial_Throne'],
  ['puffin', 'https://www.youtube.com/watch?v=YGnYfps8glA#t=8m20s'],
  ['pykrete', 'https://medium.com/predict/the-story-of-pykrete-that-time-the-navy-built-a-ship-out-of-ice-and-sawdust-be8de5ab5a00'],
  ['python', 'https://www.youtube.com/watch?v=n5xuoguHxCg'],
  ['python-origin', 'https://quora.com/How-did-Monty-Python-get-its-name/answer/Jan-Layton'],
  ['republic-of-texas', 'https://en.wikipedia.org/wiki/Republic_of_Texas'],
  ['roar', 'https://www.youtube.com/watch?v=OH0n_Ew2YDM'],
  ['rosbif', 'https://www.urbandictionary.com/define.php?term=rosbif'],
  ['salute', 'https://www.youtube.com/watch?v=iPGqfmLMWyo'],
  ['seals', 'https://navyseals.com/nsw/hell-week-0/'],
  ['schlieffen', 'https://en.wikipedia.org/wiki/Schlieffen_Plan'],
  ['scholars-cradle', 'https://www.youtube.com/watch?v=gpqfZJuZRNY'],
  ['secretariat', 'https://www.youtube.com/watch?v=kifHFK3VIMo'],
  ['sex-tetris', 'https://www.youtube.com/watch?v=mDrqAA-EpI0#t=16m34s'],
  ['shatting', 'https://www.youtube.com/watch?v=yNPBuEwLF1c'],
  ['sikh-tartan', 'https://medium.com/@TRVL/sikh-and-you-ll-find-a-tartan-33ba046314a5'],
  ['silly', 'https://www.youtube.com/watch?v=W6xXcoVCKp0#t=55s'],
  ['silver', 'https://www.youtube.com/watch?v=QT4fm0f2lZY&lc=UgxODQ8Isf5_jbACalh4AaABAg'],
  ['simmons', 'https://www.youtube.com/watch?v=sRrvPpZtqIU'],
  ['snooze', 'https://www.youtube.com/watch?v=Aatlliinymw'],
  ['snow', 'https://www.youtube.com/watch?v=YH4Xr6GIp4U#t=1m40s'],
  ['spaceballs', 'https://www.youtube.com/watch?v=LMxTFqPET5I'],
  ['speed-cooking-5', 'https://www.youtube.com/watch?v=74ceC7ERsLc'],
  ['splice-mainbrace', 'https://navymuseum.co.nz/explore/by-themes/customs-and-traditions/splice-the-mainbrace/'],
  ['stereo-smell', 'https://www.youtube.com/watch?v=oGkg1zyTf5Q'],
  ['strewth', 'https://www.express.co.uk/comment/expresscomment/532608/Cor-blimey-and-gee-whiz-Origin-of-bizarre-exclamations-revealed'],
  ['strokey-beard', 'https://www.youtube.com/watch?v=-9a_v_RGcTA'],
  ['strong', 'https://www.youtube.com/watch?v=SNw-sqbdkYM'],
  ['sweetest-wheels-in-christendom', 'https://www.youtube.com/watch?v=zvILGIIVsMU&ab_channel=AbileneWatchdogs'],
  ['swift', 'https://www.youtube.com/watch?v=NfPndEB2ec0'],
  ['taking-the-piss', 'https://en.wikipedia.org/wiki/Taking_the_piss'],
  ['tarantara', 'https://www.youtube.com/watch?v=pmBq_xtuOUM'],
  ['tarmac', 'https://www.youtube.com/watch?v=Fp-LTffUbG8'],
  ['tealc', 'https://www.youtube.com/watch?v=FImgqhivLBw'],
  ['tears', 'https://www.youtube.com/watch?v=y9SXqIR-Gos'],
  ['tedious-length', 'https://www.youtube.com/watch?v=D0mYKddn5BE#t=9m1s'],
  ['terrorists', 'https://www.youtube.com/watch?v=BGc3zFOFI-s'],
  ['tetris', 'https://www.youtube.com/watch?v=H2Qo3vDxJBc#t=10m4s'],
  ['the-beauty-the-beauty-ohh-the-beauty', 'https://www.youtube.com/watch?v=tEuT9sePcI4'],
  ['the-traitors-hand', 'https://www.goodreads.com/en/book/show/463988'],
  ['thighs', 'https://www.youtube.com/watch?v=6cDohyRbzeo#t=2m10s'],
  ['this-bloke', 'https://www.youtube.com/watch?v=jTifRi3qDkU'],
  ['thunderscreech', 'https://www.youtube.com/watch?v=bx2F9PZlCqY'],
  ['thx', 'https://www.youtube.com/watch?v=nu0R96OZy6w'],
  ['tom-baker', 'https://www.youtube.com/watch?v=C-v85qklHqw#t=26m55s'],
  ['torso', 'https://www.pinterest.nz/pin/537406168014706093/'],
  ['tower', 'https://www.youtube.com/watch?v=HdBZ3Pg0-OM'],
  ['tracks', 'https://www.youtube.com/watch?v=KfgifHh5R4Y#t=19m2s'],
  ['trump', 'https://en.wikipedia.org/wiki/Melania_Trump'],
  ['tsiolkovsky', 'https://en.wikipedia.org/wiki/Tsiolkovsky_rocket_equation'],
  ['undies', 'https://www.youtube.com/watch?v=T-ReyfcNWZ8#t=20m5s'], # Video unavailable! :O 
  ['wank', 'https://www.youtube.com/watch?v=u5RjG4-K9Gc'],
  ['wanker', 'https://www.youtube.com/watch?v=o8qM7KwwMaw#t=10m35s'],
  ['warm', 'https://dilbert.com/strip/1995-01-16'],
  ['wellington', 'https://www.youtube.com/watch?v=Bp0NHIH4WoE#t=15m45s'],
  ['what-a-mistake-a-to-make-a', 'https://www.youtube.com/watch?v=n-PEUuzMlWg'],
  ['whimsical', 'https://www.instagram.com/the_whimsical_woodsman/'],
  ['winnie-the-pooh', 'https://www.youtube.com/watch?v=H_3oXfgB35E'],
  ['worm', 'https://www.youtube.com/watch?v=LPf9oJV_qDw'],
  ['yap', 'https://www.youtube.com/watch?v=Z3515_x8R9c'],
  ['yorkshire', 'https://www.youtube.com/watch?v=VKHFZBUTA4k'],
  ['yorkshire2', 'https://www.youtube.com/watch?v=7Lb-2VaJYPw'],
]

get '/:shortened' do
  if route = routes.find {|r| r[0] === params['shortened'] }
    redirect route[1]
  else
    # It'd actually be neat to keep a log of incorrect URL shortening attempts. Do so here?
    redirect 'https://imgur.com'
  end
end