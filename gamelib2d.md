# Beveztés #

Ezen az oldalon a gamelib2d és kapcsolódó cuccokhoz gyűjtjük a tapasztalatokat.

# Copyright #

A **gamelib2d** **Mike Wiering** szellemi terméke, amit felhasználni, pláne módosítani csak a forrás szigorú megjelölésével szabad. Amúgy szabadon felhasználható, módosítható

# Leírása #

Nem kívánok részletes leírást készíteni róla, csak ami hasznos tapasztalatot gyűjtöttünk azt foglaljuk össze a csapat tagjai számára illetve későbbi felhasználás céljából.

## Elemei ##

### Def.hx ###

Ehhez nem kell hozzá nyúlnunk, amíg a **TileStudio**-val generáljuk a map-eket.

### Audio ###

Egy rövid pillantást vetettem bele, de sose próbáltam ki, jelenleg nincs hozzá példaprogramunk. Egyszerűnek tűnik a használata, _ByteArray_-ban kapja a lejátszandó Wave-t és Flash9 Sound objektummá alakítja át.

### GameObject ###

Valószínűleg **Mike Wiering**-re egy oly jellemző ugrálós platformjáték törzse. Tartalmaz saját rajzoló függvényt és bound vizsgálatot is. Nem fogjuk hasznát venni.

### Keys ###

A lenyomott billentyűk állapotát egy 255 elemű tömben tárolja. Ezt jelenleg is használjuk.

### Layer ###

Ez a hagyományos **TileStudio** demóknál szerencsére sokkal többet tudó osztály kezel egy **réteget** (TileStudio-ban **map** a megfelelője). Ez az osztály valósítja meg a a **réteg** elemeinek tárolását, a réteg "kamermozgatását" és a **réteg**látható részének kirajzolását.
Egy Layer további 3 alréteget tartalmaz a **TileStudio**-nak megfelelően.

#### init ####

Megadható a layer ismétlődésének típusa, scale mértéke, scrollozhatóság típusa.
Sajnos a scale utólagos módosítására nincs függvény írva, azt majd meg kell írnunk ha akarunk dinamikus zoomolást játék közben.

#### moveTo ####

Ezzel lehet a "kamerát mozgatni" a layeren belül.

#### update ####

ez csak a saját _timeCounter_ értékét növeli, animációhoz használjuk.

#### setAlpha ####

úgy hiszem hogy ezzel a függvénnyel fogjuk tudni szabályozni a teljes réteg átlátszóságának a szintjét.

#### setBlendMode ####

http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/BlendMode.html

#### setColorTransform ####

http://livedocs.adobe.com/flex/3/langref/flash/geom/ColorTransform.html

#### getCurTile ####

ez hasonlóan a többi demóhoz, a **map** (**layer**) koordinátarendszerben megadja x,y helyen lévő elemet. Ezzel ellenőrizhetjük majd, hogy a játékosunk alatt van-e platform.

#### draw ####

kirajzolja a layer látható részét.

### MapData ###

Ezt örökítik a **TileStudio**-ból származó **map** (**layer**) osztályok.

### TileSet ###

**TileStudio**-ból generált TileSetData kezelése, kirajzolása. Pixel szintű műveleteket is tartalmaz.

### TileSetData ###

Ezt örökítik a **TileStudio**-ból származó **TileSet** osztályok.

### Utils ###

Gondolom néhány flash-ből hiányzó matematikai művelet.