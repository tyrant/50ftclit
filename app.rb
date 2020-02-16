require 'sinatra'

# Routes is an array of arrays. Each subarray's first entry
# is the shortened URL we're checking for: something like 
# 50ftcl.it/:shortened; and the second entry is the complete
# URL we're redirecting to.
routes = [
  ['abfab', 'https://www.youtube.com/watch?v=ToTBlI1w23o'],
  ['ace-ventura', 'https://www.youtube.com/watch?v=RRy5JJfw-JI'],
  ['addams', 'https://www.youtube.com/watch?v=-Z6STPcw3Ac#t=2m39s'],
  ['angel', 'https://imgur.com/gallery/FkMkZ'],
  ['antechinus', 'https://en.wikipedia.org/wiki/Antechinus'],
  ['ass', 'https://www.youtube.com/watch?v=RXpTXZ2vhPk'],
  ['asshole', 'https://www.youtube.com/watch?v=UrgpZ0fUixs'],
  ['atlas', 'https://www.youtube.com/watch?v=AatcIe1qoT4'],
  ['bailey', 'https://www.youtube.com/watch?v=OoxBMfCCnWM'],
  ['balance', 'https://www.youtube.com/watch?v=PHkbDhzXLV4#t=19m30s'],
  ['barrowman', 'https://www.youtube.com/watch?v=1zY1orxW8Aw#t=45s'],
  ['bedsprings', 'https://www.youtube.com/watch?v=uPxKW7RR7h0#t=29m45s'],
  ['bellamy', 'https://en.wikipedia.org/wiki/Bellamy_salute'],
  ['best-korea', 'https://knowyourmeme.com/photos/65469-best-korea'],
  ['blackadder', 'https://www.youtube.com/watch?v=YLHlP2Vgkx8'],
  ['bloody-colonials', 'https://en.wikipedia.org/wiki/Six_o%27clock_swill'],
  ['blueprint', 'https://www.dancarlin.com/product/hardcore-history-50-blueprint-for-armageddon-i/'],
  ['bond', 'https://www.youtube.com/watch?v=0cjlnnj0gtM#t=3m20s'],
  ['bowie', 'https://www.vogue.co.uk/gallery/david-bowie-style-file-fashion-history-in-pictures'],
  ['boxing-day-poo', 'https://www.youtube.com/watch?v=_500jmNDZMI#t=24m9s'],
  ['buddy', 'https://www.youtube.com/watch?v=6FigprdcBGA'],
  ['butter', 'https://www.youtube.com/watch?v=05Byne839Pg#t=1m16s'],
  #['butterfield-404', 'find that link to his website 404ing'],
  ['catacombs', 'https://en.wikipedia.org/wiki/Catacombs_of_Paris'],
  ['clf3', 'https://blogs.sciencemag.org/pipeline/archives/2008/02/26/sand_wont_save_you_this_time'],
  ['clunge', 'https://www.youtube.com/watch?v=5rx3RwwakAA#t=23m'],
  ['cockney', 'https://www.youtube.com/watch?v=w0aTzevVjqk'],
  ['coke-wank', 'https://www.youtube.com/watch?v=6WLOdXGhJbA'],
  ['comic-sans', 'https://www.achewood.com/index.php?date=07052007'],
  ['concrete', 'https://www.youtube.com/watch?v=2J0oTemjzrY#t=27m05s'],
  ['crack', 'https://www.youtube.com/watch?v=eJW1tzNLwI8'],
  ['cuban-pete', 'https://www.youtube.com/watch?v=qfO_OfmGOl0'],
  ['destroy', 'https://www.amazon.com/OffWorld-Designs-Unisex-Destroy-T-Shirt/dp/B00UCFHU1A'],
  ['diana', 'https://www.youtube.com/watch?v=YrAFqE36anw#t=7m30s'],
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
  ['fix', 'https://www.youtube.com/watch?v=C2s0aOhkjmY'],
  ['fuck-hint', 'https://www.youtube.com/watch?v=h68CfIUkPKs#t=1m47s'],
  ['fuckeulogy', 'https://www.youtube.com/watch?v=AVb84n-FFx4'],
  ['gigantosnatch', 'https://www.verbicidemagazine.com/wp-content/uploads/2011/07/dock.jpg'],
  ['goon', 'http://thegoonshow.net/scripts_show.asp?title=s05e17_china_story'],
  ['great-man', 'https://en.wikipedia.org/wiki/Great_man_theory'],
  ['grond', 'https://www.youtube.com/watch?v=u9BinUHHPv0'],
  ['hogan', 'https://www.youtube.com/watch?v=ypE2oT-8Zag'],
  ['hope', 'https://www.youtube.com/watch?v=wtoHjGWc2s8#t=2m28s'],
  ['horse-roar', 'https://www.youtube.com/watch?v=RiZead-Wl6o'],
  ['hotdog', 'https://www.atlasobscura.com/places/pentagon-hot-dog-stand'],
  ['irish', 'https://www.irishtimes.com/blogs/generationemigration/2013/02/12/when-the-irish-became-white-immigrants-in-mid-19th-century-us/'],
  ['iron-crotch', 'https://www.youtube.com/watch?v=9_sleRlUIsI'],
  ['jackson', 'https://www.youtube.com/watch?v=7lvsBBNV-U4'],
  ['jeans', 'https://www.artofmanliness.com/articles/chuck-norris-action-jeans/'],
  ['kicking-ass', 'https://www.youtube.com/watch?v=00y3gV0dJow'],
  ['king', 'https://www.youtube.com/watch?v=grbSQ6O6kbs#t=1m44s'],
  ['king-lear', 'https://www.shmoop.com/king-lear/family-quotes.html'],
  ['kiosk', 'https://www.youtube.com/watch?v=72Xki72JkpU'],
  ['kneegrow', 'https://www.youtube.com/watch?v=JGzw2ecfkqU'], # account deleted
  ['kowloon-walled-city', 'https://en.wikipedia.org/wiki/Kowloon_Walled_City'],
  ['kray', 'https://www.youtube.com/watch?v=mBL3XB-PhE8'],
  ['kung-pow', 'https://www.youtube.com/watch?v=TEzoZ6tqUjA'],
  ['lead', 'https://www.youtube.com/watch?v=dceB3SKBw9w'],
  ['liger', 'https://www.youtube.com/watch?v=Y5aW6Y4aF0s'],
  ['lobotomobile', 'https://www.thevintagenews.com/2017/01/14/walter-freeman-who-championed-lobotomy-in-the-us-was-touring-with-his-lobotomobile-demonstrating-the-procedure/'],
  ['lobotomobile-myth', 'https://medium.com/@Jack_ElHai/fighting-the-legend-of-the-lobotomobile-1b0acf8a8eb0'],
  ['look-what-happens-when-you-shrink-preproduction-from-three-years-to-three-months-no-seriously-wtf', 'https://www.youtube.com/watch?v=DHQSmJq0nmQ'],
  ['love', 'https://www.youtube.com/watch?v=jKpN8uEEa5c'],
  ['ludicrous', 'https://www.youtube.com/watch?v=mk7VWcuVOf0'],
  ['macho-macho-maaaaan', 'https://pinterest.nz/pin/95349717083017997/'],
  ['man-about-town', 'https://www.youtube.com/watch?v=xMxsLKQidY4'],
  ['matrix', 'https://www.youtube.com/watch?v=2oEnJfZ9joY'],
  ['maui', 'https://www.youtube.com/watch?v=Dadu2KLjMVM'],
  ['mechanic', 'https://mashable.com/2015/04/22/queen-elizabeth-army/'],
  ['metallica', 'https://www.youtube.com/watch?v=-SJJkgc_rNc'],
  ['mirren', 'https://www.youtube.com/watch?v=n_kGkGUAKRw'],
  ['mirthmobile', 'https://www.youtube.com/watch?v=VzUU7SRRsGo'],
  ['moi', 'https://www.youtube.com/watch?v=noK4SBuz_pY'],
  ['mould', 'https://www.youtube.com/watch?v=PD9bVahTGek#t=2m53s'],
  ['naked', 'http://thegoonshow.net/scripts_show.asp?title=s05e11_the_spanish_suitcase'],
  ['nethers', 'https://www.youtube.com/watch?v=dHFuzbeTPew'],
  ['one-three', 'https://www.youtube.com/watch?v=SGMfwYmZ6mQ#t=2m51s'],
  ['penis-pants', 'https://www.messynessychic.com/2013/08/01/the-1970s-political-activist-who-invented-penis-pants/'],
  ['ping', 'https://www.youtube.com/watch?v=NcHdF1eHhgc#t=2m35s'],
  ['powers', 'https://www.youtube.com/watch?v=3C8Slzx-Gpc#t=2m39s'],
  ['preen', 'https://www.oglaf.com/stroke/'],
  ['prude', 'https://en.wikipedia.org/wiki/Napoleon_I_on_His_Imperial_Throne'],
  ['puffin', 'https://www.youtube.com/watch?v=YGnYfps8glA#t=8m20s'],
  ['python', 'https://www.youtube.com/watch?v=n5xuoguHxCg'],
  ['python-origin', 'https://quora.com/How-did-Monty-Python-get-its-name/answer/Jan-Layton'],
  ['republic-of-texas', 'https://en.wikipedia.org/wiki/Republic_of_Texas'],
  ['roar', 'https://www.youtube.com/watch?v=OH0n_Ew2YDM'],
  ['seals', 'https://navyseals.com/nsw/hell-week-0/'],
  ['schlieffen', 'https://en.wikipedia.org/wiki/Schlieffen_Plan'],
  ['shatting', 'https://www.youtube.com/watch?v=yNPBuEwLF1c'],
  ['silly', 'https://www.youtube.com/watch?v=W6xXcoVCKp0#t=55s'],
  ['simmons', 'https://www.youtube.com/watch?v=sRrvPpZtqIU'],
  ['snooze', 'https://www.youtube.com/watch?v=Aatlliinymw'],
  ['snow', 'https://www.youtube.com/watch?v=YH4Xr6GIp4U#t=1m40s'],
  ['spaceballs', 'https://www.youtube.com/watch?v=LMxTFqPET5I'],
  ['speed-cooking-5', 'https://www.youtube.com/watch?v=74ceC7ERsLc'],
  ['strokey-beard', 'https://www.youtube.com/watch?v=-9a_v_RGcTA'],
  ['strong', 'https://www.youtube.com/watch?v=SNw-sqbdkYM'],
  ['swift', 'https://www.youtube.com/watch?v=NfPndEB2ec0'],
  ['tarantara', 'https://www.youtube.com/watch?v=pmBq_xtuOUM'],
  ['tealc', 'https://www.youtube.com/watch?v=FImgqhivLBw'],
  ['tears', 'https://www.youtube.com/watch?v=y9SXqIR-Gos'],
  ['tedious-length', 'https://www.youtube.com/watch?v=D0mYKddn5BE#t=9m1s'],
  ['tetris', 'https://www.youtube.com/watch?v=H2Qo3vDxJBc#t=10m4s'],
  ['the-beauty-the-beauty-ohh-the-beauty', 'https://www.youtube.com/watch?v=tEuT9sePcI4'],
  ['the-traitors-hand', 'https://www.goodreads.com/en/book/show/463988'],
  ['thighs', 'https://www.youtube.com/watch?v=6cDohyRbzeo#t=2m10s'],
  ['torso', 'https://www.pinterest.nz/pin/537406168014706093/'],
  ['tower', 'https://www.youtube.com/watch?v=HdBZ3Pg0-OM'],
  ['tracks', 'https://www.youtube.com/watch?v=KfgifHh5R4Y#t=19m2s'],
  ['trump', 'https://en.wikipedia.org/wiki/Melania_Trump'],
  ['tsiolkovsky', 'https://en.wikipedia.org/wiki/Tsiolkovsky_rocket_equation'],
  ['undies', 'https://www.youtube.com/watch?v=T-ReyfcNWZ8#t=20m5s'], # Video unavailable! :O 
  ['wank', 'https://www.youtube.com/watch?v=u5RjG4-K9Gc'],
  ['warm', 'https://dilbert.com/strip/1995-01-16'],
  ['wellington', 'https://www.youtube.com/watch?v=Bp0NHIH4WoE#t=15m45s'],
  ['whimsical', 'https://articles.aplus.com/a/dudeoir-woodsman-photoshoot-donates-to-charity'],
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
    redirect 'https://imgur.com'
  end
end
