require 'sinatra'

# Routes is an array of arrays. Each subarray's first entry
# is the shortened URL we're checking for: something like 
# 50ftcl.it/:shortened; and the second entry is the complete
# URL we're redirecting to.
routes = [
  ['abfab', 'https://www.youtube.com/watch?v=ToTBlI1w23o'],
  ['ass', 'https://www.youtube.com/watch?v=RXpTXZ2vhPk'],
  ['atlas', 'https://www.youtube.com/watch?v=AatcIe1qoT4'],
  ['blackadder', 'https://www.youtube.com/watch?v=YLHlP2Vgkx8'],
  ['blueprint', 'https://www.dancarlin.com/product/hardcore-history-50-blueprint-for-armageddon-i/'],
  ['bond', 'https://www.youtube.com/watch?v=0cjlnnj0gtM#t=3m20s'],
  ['boxing-day-poo', 'https://www.youtube.com/watch?v=_500jmNDZMI#t=24m9s'],
  ['buddy', 'https://www.youtube.com/watch?v=6FigprdcBGA'],
  ['butter', 'https://www.youtube.com/watch?v=05Byne839Pg#t=1m16s'],
  ['catacombs', 'https://en.wikipedia.org/wiki/Catacombs_of_Paris'],
  ['clf3', 'https://blogs.sciencemag.org/pipeline/archives/2008/02/26/sand_wont_save_you_this_time'],
  ['coke-wank', 'https://www.youtube.com/watch?v=6WLOdXGhJbA'],
  ['crack', 'https://www.youtube.com/watch?v=eJW1tzNLwI8'],
  ['destroy', 'https://www.amazon.com/OffWorld-Designs-Unisex-Destroy-T-Shirt/dp/B00UCFHU1A'],
  ['dougal', 'https://www.youtube.com/watch?v=nmfLS1hWO94#t=2m37s'],
  ['down', 'https://www.youtube.com/watch?v=gT9xuXQjxMM'],
  ['dressage', 'https://en.wikipedia.org/wiki/Dressage'],
  ['drum', 'https://www.youtube.com/watch?v=8Qi3JERmk9E'],
  ['fab', 'https://www.youtube.com/watch?v=nauGAeTNLko'],
  ['fate', 'https://www.youtube.com/watch?v=XS3gtuczcbU#t=1h18m20s'],
  ['fix', 'https://www.youtube.com/watch?v=C2s0aOhkjmY'],
  ['goon', 'http://thegoonshow.net/scripts_show.asp?title=s05e17_china_story'],
  ['grond', 'https://www.youtube.com/watch?v=u9BinUHHPv0'],
  ['hope', 'https://www.youtube.com/watch?v=wtoHjGWc2s8#t=2m28s'],
  ['horse-roar', 'https://www.youtube.com/watch?v=RiZead-Wl6o'],
  ['hotdog', 'https://www.atlasobscura.com/places/pentagon-hot-dog-stand'],
  ['iron-crotch', 'https://www.youtube.com/watch?v=9_sleRlUIsI'],
  ['king-lear', 'https://www.shmoop.com/king-lear/family-quotes.html'],
  ['kiosk', 'https://www.youtube.com/watch?v=72Xki72JkpU'],
  ['kowloon-walled-city', 'en.wikipedia.org/wiki/Kowloon_Walled_City'],
  ['kray', 'https://www.youtube.com/watch?v=mBL3XB-PhE8'],
  ['matrix', 'https://www.youtube.com/watch?v=2oEnJfZ9joY'],
  ['maui', 'https://www.youtube.com/watch?v=Dadu2KLjMVM'],
  ['naked', 'http://thegoonshow.net/scripts_show.asp?title=s05e11_the_spanish_suitcase'],
  ['preen', 'https://www.oglaf.com/stroke/'],
  ['puffin', 'https://www.youtube.com/watch?v=YGnYfps8glA#t=8m20s'],
  ['republic-of-texas', 'en.wikipedia.org/wiki/Republic_of_Texas'],
  ['roar', 'https://www.youtube.com/watch?v=OH0n_Ew2YDM'],
  ['seals', 'https://navyseals.com/nsw/hell-week-0/'],
  ['schlieffen', 'en.wikipedia.org/wiki/Schlieffen_Plan'],
  ['snooze', 'https://www.youtube.com/watch?v=Aatlliinymw'],
  ['spaceballs', 'https://www.youtube.com/watch?v=LMxTFqPET5I'],
  ['strokey-beard', 'https://www.youtube.com/watch?v=-9a_v_RGcTA'],
  ['tarantara', 'https://www.youtube.com/watch?v=pmBq_xtuOUM'],
  ['tears', 'https://www.youtube.com/watch?v=y9SXqIR-Gos'],
  ['torso', 'https://www.pinterest.nz/pin/537406168014706093/'],
  ['tower', 'https://www.youtube.com/watch?v=HdBZ3Pg0-OM'],
  ['undies', 'https://www.youtube.com/watch?v=T-ReyfcNWZ8#t=20m5s'],
  ['wank', 'https://www.youtube.com/watch?v=u5RjG4-K9Gc'],
  ['whimsical', 'https://articles.aplus.com/a/dudeoir-woodsman-photoshoot-donates-to-charity'],
  ['winnie-the-pooh', 'https://www.youtube.com/watch?v=H_3oXfgB35E'],
  ['yap', 'https://www.youtube.com/watch?v=Z3515_x8R9c'],
  ['yorkshire', 'https://www.youtube.com/watch?v=VKHFZBUTA4k'],
  ['yorkshire2', 'https://www.youtube.com/watch?v=7Lb-2VaJYPw'],
]

get '/:shortened' do
  if route = routes.find {|r| r[0] === params['shortened'] }
    redirect route[1]
  end
end