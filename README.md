# WeatherNOW

Homework for Flutter class

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

## Bejelentkezés és regisztráció

Az alkalmazás használatához felhasználói fiókkal kell bejelentkezni. 

#### Bejelentkezés

A bejelentkezés a `felhasználónév` `jelszó` párossal történik.
Jelenleg az alkalmazásba két használható fiók van regisztrálva amelyek szabadon használhatóak.

| Felhasználónév        | Jelszó           | E-mail            | Szerep  |
| -------------         |------------------| ------------------|---------|
| TestAdminUser         | wasd123          | admin@test.hu     | admin   |
| TestSimpleUser        | 555555           |  simple@user.com  |   alap  |

A fenti felhasználókon kívül szabadon regisztrálhatunk új fiókokat is. Ezt a `Regisztráció` oldalon tehetjük meg.

#### Regisztráció

A regisztrációhoz a következő feltételeknek kell teljesülnie:
- Felhasználónév megadása ami még nem foglalt
- Jelszó megadása ami minimum 6 karakter hosszú
- Jelszó megismétlése
- Érvényes formátumú email megadása

Ezután (a könnyű tesztelés érdekében) lehetőség van megadni, hogy a felhasználó alapként vagy adminként legyen létrehozva.
Amennyiben a feltételek teljesültek visszajelzést kapunk arról, hogy sikeres volt-e a regisztráció. Sikeres regisztráció esetén egyből be is léptet az alkalmazás.
A megadott e-mail címnek csak formátum követelménye van nem kell hogy valós legyen mivel az e-mail hitelesítés és jelszó visszaállítás a levélszemetelés megelőzése érdekében ki van kapcsolva. :)

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
=======

