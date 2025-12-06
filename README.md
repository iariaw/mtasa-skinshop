# Skin Shop Resource for MTA:SA

A fully-featured skin shop system for Multi Theft Auto: San Andreas that
allows players to browse, preview, and purchase character skins using
in-game money.

## 📋 About

This resource provides a complete skin shop implementation for MTA:SA
servers. Players can enter a dedicated skin shop interior, browse
through various character skins, preview them on a model, and purchase
them using in-game currency. The system includes both free and paid
skins with proper UI/UX design and server-side validation.

## ✨ Features

-   **Interactive Shop Interior**: Custom skin shop located in an
    interior with proper entry/exit points\
-   **Skin Preview System**: Real-time 3D preview of skins before
    purchase\
-   **Comprehensive Skin Collection**: 50+ different skins with various
    professions and styles\
-   **Dual Pricing System**: Mix of free and paid skins with
    configurable prices\
-   **Responsive UI**: Clean, modern interface with hover effects and
    visual feedback\
-   **Server-Side Validation**: Secure money handling and purchase
    validation\
-   **NPC Shopkeeper**: Interactive ped to enhance immersion\
-   **Wanted Level Check**: Prevents wanted players from entering the
    shop\
-   **Smooth Camera Transitions**: Professional camera movements for
    previewing skins

## 🛠️ Installation

1.  Download the resource files\
2.  Place the `SkinShop` folder in your server's `resources` directory\
3.  Add `start SkinShop` to your `mtaserver.conf` file\
4.  Restart your server

## 🎮 Usage

1.  **Locate the Shop**: Find the skin shop marker at coordinates
    `461.7012, -1500.7793, 31.0455`\
2.  **Enter the Shop**: Walk into the pickup (must have no wanted
    level)\
3.  **Browse Skins**: Use the arrow buttons to navigate through
    available skins\
4.  **Preview**: Each skin is displayed on a preview model in real-time\
5.  **Purchase**: Click **"Select Skin"** to purchase\
6.  **Exit**: Leave through the exit pickup inside the shop

## ⚙️ Configuration

### Skin List

``` lua
{id = SKIN_ID, name = "Skin Name", price = PRICE}
```

### Shop Location

-   `interior.lua`: Entry/exit pickup coordinates\
-   `server.lua`: Shop marker position\
-   `ped.lua`: Shopkeeper NPC position

## 📁 File Structure

-   `meta.xml` --- Resource metadata and file dependencies\
-   `server.lua` --- Server-side logic, skin database, and purchase
    handling\
-   `client.lua` --- Client-side GUI, skin preview, and camera controls\
-   `interior.lua` --- Shop entry/exit system and teleportation logic\
-   `ped.lua` --- Shopkeeper NPC creation and configuration

## 🎨 Customization

### Adding New Skins

1.  Find the skin ID from the MTA skin list\
2.  Add a new entry to the `skinsList` table in `server.lua`\
3.  The skin will automatically appear in the shop interface

### UI Customization

Modify `client.lua` to:\
- Change button colors and styles\
- Adjust window positions and sizes\
- Modify preview camera angles\
- Customize text colors and fonts

## 🔒 Security Features

-   Server-side money validation\
-   Event protection against cheating\
-   Wanted level check before entry\
-   Proper event handling and cleanup

## 📝 Requirements

-   MTA:SA Server 1.5 or higher\
-   Basic understanding of Lua for customization

## 🤝 Support

**Telegram:** @Ariaw\
**Version:** 1.0.0\
**License:** MIT
