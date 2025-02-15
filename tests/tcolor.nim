#[###################### GNU General Public License 3.0 ######################]#
#                                                                              #
#  Copyright (C) 2017─2023 Shuhei Nogawa                                       #
#                                                                              #
#  This program is free software: you can redistribute it and/or modify        #
#  it under the terms of the GNU General Public License as published by        #
#  the Free Software Foundation, either version 3 of the License, or           #
#  (at your option) any later version.                                         #
#                                                                              #
#  This program is distributed in the hope that it will be useful,             #
#  but WITHOUT ANY WARRANTY; without even the implied warranty of              #
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               #
#  GNU General Public License for more details.                                #
#                                                                              #
#  You should have received a copy of the GNU General Public License           #
#  along with this program.  If not, see <https://www.gnu.org/licenses/>.      #
#                                                                              #
#[############################################################################]#

import std/unittest
import pkg/results
import moepkg/[rgb, ui]

import moepkg/color {.all.}

const DarkTheme = ColorTheme.dark

template darkDefaultFg: var Color =
  ColorThemeTable[DarkTheme][EditorColorPairIndex.default].foreground

template darkDefaultBg: var Color =
  ColorThemeTable[DarkTheme][EditorColorPairIndex.default].background

suite "color: Get Rgb from Color":
  test "from Color8":
    assert Color8.default.rgb == TerminalDefaultRgb
    assert Color8.black.rgb == "#000000".hexToRgb.get
    assert Color8.maroon.rgb == "#800000".hexToRgb.get
    assert Color8.green.rgb == "#008000".hexToRgb.get
    assert Color8.olive.rgb == "#808000".hexToRgb.get
    assert Color8.navy.rgb == "#000080".hexToRgb.get
    assert Color8.purple.rgb == "#800080".hexToRgb.get
    assert Color8.teal.rgb == "#008080".hexToRgb.get
    assert Color8.silver.rgb == "#c0c0c0".hexToRgb.get

  test "from Color16":
    assert Color16.default.rgb == TerminalDefaultRgb
    assert Color16.black.rgb == "#000000".hexToRgb.get
    assert Color16.maroon.rgb == "#800000".hexToRgb.get
    assert Color16.green.rgb == "#008000".hexToRgb.get
    assert Color16.olive.rgb == "#808000".hexToRgb.get
    assert Color16.navy.rgb == "#000080".hexToRgb.get
    assert Color16.purple.rgb == "#800080".hexToRgb.get
    assert Color16.teal.rgb == "#008080".hexToRgb.get
    assert Color16.silver.rgb == "#c0c0c0".hexToRgb.get
    assert Color16.gray.rgb == "#808080".hexToRgb.get
    assert Color16.red.rgb == "#ff0000".hexToRgb.get
    assert Color16.lime.rgb == "#00ff00".hexToRgb.get
    assert Color16.yellow.rgb == "#ffff00".hexToRgb.get
    assert Color16.blue.rgb == "#0000ff".hexToRgb.get
    assert Color16.fuchsia.rgb == "#ff00ff".hexToRgb.get
    assert Color16.aqua.rgb == "#00ffff".hexToRgb.get
    assert Color16.white.rgb == "#ffffff".hexToRgb.get

  test "from Color256":
    assert Color256.default.rgb == TerminalDefaultRgb
    assert Color256.black.rgb == "#000000".hexToRgb.get
    assert Color256.maroon.rgb == "#800000".hexToRgb.get
    assert Color256.green.rgb == "#008000".hexToRgb.get
    assert Color256.olive.rgb == "#808000".hexToRgb.get
    assert Color256.navy.rgb == "#000080".hexToRgb.get
    assert Color256.purple1.rgb == "#800080".hexToRgb.get
    assert Color256.teal.rgb == "#008080".hexToRgb.get
    assert Color256.silver.rgb == "#c0c0c0".hexToRgb.get
    assert Color256.gray.rgb == "#808080".hexToRgb.get
    assert Color256.red.rgb == "#ff0000".hexToRgb.get
    assert Color256.lime.rgb == "#00ff00".hexToRgb.get
    assert Color256.yellow.rgb == "#ffff00".hexToRgb.get
    assert Color256.blue.rgb == "#0000ff".hexToRgb.get
    assert Color256.fuchsia.rgb == "#ff00ff".hexToRgb.get
    assert Color256.aqua.rgb == "#00ffff".hexToRgb.get
    assert Color256.white.rgb == "#ffffff".hexToRgb.get
    assert Color256.gray0.rgb == "#000000".hexToRgb.get
    assert Color256.navyBlue.rgb == "#00005f".hexToRgb.get
    assert Color256.darkBlue.rgb == "#000087".hexToRgb.get
    assert Color256.blue31.rgb == "#0000af".hexToRgb.get
    assert Color256.blue32.rgb == "#0000d7".hexToRgb.get
    assert Color256.blue1.rgb == "#0000ff".hexToRgb.get
    assert Color256.darkGreen.rgb == "#005f00".hexToRgb.get
    assert Color256.deepSkyBlue41.rgb == "#005f5f".hexToRgb.get
    assert Color256.deepSkyBlue42.rgb == "#005f87".hexToRgb.get
    assert Color256.deepSkyBlue43.rgb == "#005faf".hexToRgb.get
    assert Color256.dodgerBlue31.rgb == "#005fd7".hexToRgb.get
    assert Color256.dodgerBlue32.rgb == "#005fff".hexToRgb.get
    assert Color256.green4.rgb == "#008700".hexToRgb.get
    assert Color256.springGreen4.rgb == "#00875f".hexToRgb.get
    assert Color256.turquoise4.rgb == "#008787".hexToRgb.get
    assert Color256.deepSkyBlue31.rgb == "#0087af".hexToRgb.get
    assert Color256.deepSkyBlue32.rgb == "#0087d7".hexToRgb.get
    assert Color256.dodgerBlue1.rgb == "#0087ff".hexToRgb.get
    assert Color256.green31.rgb == "#00af00".hexToRgb.get
    assert Color256.springGreen31.rgb == "#00af5f".hexToRgb.get
    assert Color256.darkCyan.rgb == "#00af87".hexToRgb.get
    assert Color256.lightSeaGreen.rgb == "#00afaf".hexToRgb.get
    assert Color256.deepSkyBlue2.rgb == "#00afd7".hexToRgb.get
    assert Color256.deepSkyBlue1.rgb == "#00afff".hexToRgb.get
    assert Color256.green32.rgb == "#00d700".hexToRgb.get
    assert Color256.springGreen33.rgb == "#00d75f".hexToRgb.get
    assert Color256.springGreen21.rgb == "#00d787".hexToRgb.get
    assert Color256.cyan3.rgb == "#00d7af".hexToRgb.get
    assert Color256.darkTurquoise.rgb == "#00d7df".hexToRgb.get
    assert Color256.turquoise2.rgb == "#00d7ff".hexToRgb.get
    assert Color256.green1.rgb == "#00ff00".hexToRgb.get
    assert Color256.springGreen22.rgb == "#00ff5f".hexToRgb.get
    assert Color256.springGreen1.rgb == "#00ff87".hexToRgb.get
    assert Color256.mediumSpringGreen.rgb == "#00ffaf".hexToRgb.get
    assert Color256.cyan2.rgb == "#00ffd7".hexToRgb.get
    assert Color256.cyan1.rgb == "#00ffff".hexToRgb.get
    assert Color256.darkRed1.rgb == "#5f0000".hexToRgb.get
    assert Color256.deepPink41.rgb == "#5f005f".hexToRgb.get
    assert Color256.purple41.rgb == "#5f0087".hexToRgb.get
    assert Color256.purple42.rgb == "#5f00af".hexToRgb.get
    assert Color256.purple3.rgb == "#5f00df".hexToRgb.get
    assert Color256.blueViolet.rgb == "#5f00ff".hexToRgb.get
    assert Color256.orange41.rgb == "#5f5f00".hexToRgb.get
    assert Color256.gray37.rgb == "#5f5f5f".hexToRgb.get
    assert Color256.mediumPurple4.rgb == "#5f5f87".hexToRgb.get
    assert Color256.slateBlue31.rgb == "#5f5faf".hexToRgb.get
    assert Color256.slateBlue32.rgb == "#5f5fd7".hexToRgb.get
    assert Color256.royalBlue1.rgb == "#5f5fff".hexToRgb.get
    assert Color256.chartreuse4.rgb == "#5f8700".hexToRgb.get
    assert Color256.darkSeaGreen41.rgb == "#5f875f".hexToRgb.get
    assert Color256.paleTurquoise4.rgb == "#5f8787".hexToRgb.get
    assert Color256.steelBlue.rgb == "#5f87af".hexToRgb.get
    assert Color256.steelBlue3.rgb == "#5f87d7".hexToRgb.get
    assert Color256.cornflowerBlue.rgb == "#5f87ff".hexToRgb.get
    assert Color256.chartreuse31.rgb == "#5faf00".hexToRgb.get
    assert Color256.darkSeaGreen42.rgb == "#5faf5f".hexToRgb.get
    assert Color256.cadetBlue1.rgb == "#5faf87".hexToRgb.get
    assert Color256.cadetBlue2.rgb == "#5fafaf".hexToRgb.get
    assert Color256.skyBlue3.rgb == "#5fafd7".hexToRgb.get
    assert Color256.steelBlue11.rgb == "#5fafff".hexToRgb.get
    assert Color256.chartreuse32.rgb == "#5fd000".hexToRgb.get
    assert Color256.paleGreen31.rgb == "#5fd75f".hexToRgb.get
    assert Color256.seaGreen3.rgb == "#5fd787".hexToRgb.get
    assert Color256.aquamarine3.rgb == "#5fd7af".hexToRgb.get
    assert Color256.mediumTurquoise.rgb == "#5fd7d7".hexToRgb.get
    assert Color256.steelBlue12.rgb == "#5fd7ff".hexToRgb.get
    assert Color256.chartreuse21.rgb == "#5fff00".hexToRgb.get
    assert Color256.seaGreen2.rgb == "#5fff5f".hexToRgb.get
    assert Color256.seaGreen11.rgb == "#5fff87".hexToRgb.get
    assert Color256.seaGreen12.rgb == "#5fffaf".hexToRgb.get
    assert Color256.aquamarine11.rgb == "#5fffd7".hexToRgb.get
    assert Color256.darkSlateGray2.rgb == "#5fffff".hexToRgb.get
    assert Color256.darkRed2.rgb == "#870000".hexToRgb.get
    assert Color256.deepPink42.rgb == "#87005f".hexToRgb.get
    assert Color256.darkMagenta1.rgb == "#870087".hexToRgb.get
    assert Color256.darkMagenta2.rgb == "#8700af".hexToRgb.get
    assert Color256.darkViolet1.rgb == "#8700d7".hexToRgb.get
    assert Color256.purple2.rgb == "#8700ff".hexToRgb.get
    assert Color256.orange42.rgb == "#875f00".hexToRgb.get
    assert Color256.lightPink4.rgb == "#875f5f".hexToRgb.get
    assert Color256.plum4.rgb == "#875f87".hexToRgb.get
    assert Color256.mediumPurple31.rgb == "#875faf".hexToRgb.get
    assert Color256.mediumPurple32.rgb == "#875fd7".hexToRgb.get
    assert Color256.slateBlue1.rgb == "#875fff".hexToRgb.get
    assert Color256.yellow41.rgb == "#878700".hexToRgb.get
    assert Color256.wheat4.rgb == "#87875f".hexToRgb.get
    assert Color256.gray53.rgb == "#878787".hexToRgb.get
    assert Color256.lightSlategray.rgb == "#8787af".hexToRgb.get
    assert Color256.mediumPurple.rgb == "#8787d7".hexToRgb.get
    assert Color256.lightSlateBlue.rgb == "#8787ff".hexToRgb.get
    assert Color256.yellow42.rgb == "#87af00".hexToRgb.get
    assert Color256.Wheat4.rgb == "#87af5f".hexToRgb.get
    assert Color256.darkSeaGreen.rgb == "#87af87".hexToRgb.get
    assert Color256.lightSkyBlue31.rgb == "#87afaf".hexToRgb.get
    assert Color256.lightSkyBlue32.rgb == "#87afd7".hexToRgb.get
    assert Color256.skyBlue2.rgb == "#87afff".hexToRgb.get
    assert Color256.chartreuse22.rgb == "#87d700".hexToRgb.get
    assert Color256.darkOliveGreen31.rgb == "#87d75f".hexToRgb.get
    assert Color256.paleGreen32.rgb == "#87d787".hexToRgb.get
    assert Color256.darkSeaGreen31.rgb == "#87d7af".hexToRgb.get
    assert Color256.darkSlateGray3.rgb == "#87d7d7".hexToRgb.get
    assert Color256.skyBlue1.rgb == "#87d7ff".hexToRgb.get
    assert Color256.chartreuse1.rgb == "#87ff00".hexToRgb.get
    assert Color256.lightGreen1.rgb == "#87ff5f".hexToRgb.get
    assert Color256.lightGreen2.rgb == "#87ff87".hexToRgb.get
    assert Color256.paleGreen11.rgb == "#87ffaf".hexToRgb.get
    assert Color256.aquamarine12.rgb == "#87ffd7".hexToRgb.get
    assert Color256.darkSlateGray1.rgb == "#87ffff".hexToRgb.get
    assert Color256.red31.rgb == "#af0000".hexToRgb.get
    assert Color256.deepPink4.rgb == "#af005f".hexToRgb.get
    assert Color256.mediumVioletRed.rgb == "#af0087".hexToRgb.get
    assert Color256.magenta3.rgb == "#af00af".hexToRgb.get
    assert Color256.darkViolet2.rgb == "#af00d7".hexToRgb.get
    assert Color256.purple.rgb == "#af00ff".hexToRgb.get
    assert Color256.darkOrange31.rgb == "#af5f00".hexToRgb.get
    assert Color256.indianRed1.rgb == "#af5f5f".hexToRgb.get
    assert Color256.hotPink31.rgb == "#af5f87".hexToRgb.get
    assert Color256.mediumOrchid3.rgb == "#af5faf".hexToRgb.get
    assert Color256.mediumOrchid.rgb == "#af5fd7".hexToRgb.get
    assert Color256.mediumPurple21.rgb == "#af5fff".hexToRgb.get
    assert Color256.darkGoldenrod.rgb == "#af8700".hexToRgb.get
    assert Color256.lightSalmon31.rgb == "#af875f".hexToRgb.get
    assert Color256.rosyBrown.rgb == "#af8787".hexToRgb.get
    assert Color256.gray63.rgb == "#af87af".hexToRgb.get
    assert Color256.mediumPurple22.rgb == "#af87d7".hexToRgb.get
    assert Color256.mediumPurple1.rgb == "#af87ff".hexToRgb.get
    assert Color256.gold31.rgb == "#afaf00".hexToRgb.get
    assert Color256.darkKhaki.rgb == "#afaf5f".hexToRgb.get
    assert Color256.navajoWhite3.rgb == "#afaf87".hexToRgb.get
    assert Color256.gray69.rgb == "#afafaf".hexToRgb.get
    assert Color256.lightSteelBlue3.rgb == "#afafd7".hexToRgb.get
    assert Color256.lightSteelBlue.rgb == "#afafff".hexToRgb.get
    assert Color256.yellow31.rgb == "#afd700".hexToRgb.get
    assert Color256.darkOliveGreen32.rgb == "#afd75f".hexToRgb.get
    assert Color256.darkSeaGreen32.rgb == "#afd787".hexToRgb.get
    assert Color256.darkSeaGreen21.rgb == "#afd7af".hexToRgb.get
    assert Color256.lightCyan3.rgb == "#afafd7".hexToRgb.get
    assert Color256.lightSkyBlue1.rgb == "#afd7ff".hexToRgb.get
    assert Color256.greenYellow.rgb == "#afff00".hexToRgb.get
    assert Color256.darkOliveGreen2.rgb == "#afff5f".hexToRgb.get
    assert Color256.paleGreen12.rgb == "#afff87".hexToRgb.get
    assert Color256.darkSeaGreen22.rgb == "#afffaf".hexToRgb.get
    assert Color256.darkSeaGreen11.rgb == "#afffd7".hexToRgb.get
    assert Color256.paleTurquoise1.rgb == "#afffff".hexToRgb.get
    assert Color256.red32.rgb == "#d70000".hexToRgb.get
    assert Color256.deepPink31.rgb == "#d7005f".hexToRgb.get
    assert Color256.deepPink32.rgb == "#d70087".hexToRgb.get
    assert Color256.magenta31.rgb == "#d700af".hexToRgb.get
    assert Color256.magenta32.rgb == "#d700d7".hexToRgb.get
    assert Color256.magenta21.rgb == "#d700ff".hexToRgb.get
    assert Color256.darkOrange32.rgb == "#d75f00".hexToRgb.get
    assert Color256.indianRed2.rgb == "#d75f5f".hexToRgb.get
    assert Color256.hotPink32.rgb == "#d75f87".hexToRgb.get
    assert Color256.hotPink2.rgb == "#d75faf".hexToRgb.get
    assert Color256.orchid.rgb == "#d75fd7".hexToRgb.get
    assert Color256.mediumOrchid11.rgb == "#d75fff".hexToRgb.get
    assert Color256.orange3.rgb == "#d78700".hexToRgb.get
    assert Color256.lightSalmon32.rgb == "#d7875f".hexToRgb.get
    assert Color256.lightPink3.rgb == "#d78787".hexToRgb.get
    assert Color256.pink3.rgb == "#d787af".hexToRgb.get
    assert Color256.plum3.rgb == "#d787d7".hexToRgb.get
    assert Color256.violet.rgb == "#d787ff".hexToRgb.get
    assert Color256.gold32.rgb == "#d7af00".hexToRgb.get
    assert Color256.lightGoldenrod3.rgb == "#d7af5f".hexToRgb.get
    assert Color256.tan.rgb == "#d7af87".hexToRgb.get
    assert Color256.mistyRose3.rgb == "#d7afaf".hexToRgb.get
    assert Color256.thistle3.rgb == "#d7afd7".hexToRgb.get
    assert Color256.plum2.rgb == "#d7afff".hexToRgb.get
    assert Color256.yellow32.rgb == "#d7d700".hexToRgb.get
    assert Color256.khaki3.rgb == "#d7d75f".hexToRgb.get
    assert Color256.lightGoldenrod2.rgb == "#d7d787".hexToRgb.get
    assert Color256.lightYellow3.rgb == "#d7d7af".hexToRgb.get
    assert Color256.gray84.rgb == "#d7d7d7".hexToRgb.get
    assert Color256.lightSteelBlue1.rgb == "#d7d7ff".hexToRgb.get
    assert Color256.yellow2.rgb == "#d7ff00".hexToRgb.get
    assert Color256.darkOliveGreen11.rgb == "#d7ff5f".hexToRgb.get
    assert Color256.darkOliveGreen12.rgb == "#d7ff87".hexToRgb.get
    assert Color256.darkSeaGreen12.rgb == "#d7ffaf".hexToRgb.get
    assert Color256.honeydew2.rgb == "#d7ffd7".hexToRgb.get
    assert Color256.lightCyan1.rgb == "#d7ffff".hexToRgb.get
    assert Color256.red1.rgb == "#ff0000".hexToRgb.get
    assert Color256.deepPink2.rgb == "#ff005f".hexToRgb.get
    assert Color256.deepPink11.rgb == "#ff0087".hexToRgb.get
    assert Color256.deepPink12.rgb == "#ff00af".hexToRgb.get
    assert Color256.magenta22.rgb == "#ff00d7".hexToRgb.get
    assert Color256.magenta1.rgb == "#ff00ff".hexToRgb.get
    assert Color256.orangeRed1.rgb == "#ff5f00".hexToRgb.get
    assert Color256.indianRed11.rgb == "#ff5f5f".hexToRgb.get
    assert Color256.indianRed12.rgb == "#ff5f87".hexToRgb.get
    assert Color256.hotPink11.rgb == "#ff5faf".hexToRgb.get
    assert Color256.hotPink12.rgb == "#ff5fd7".hexToRgb.get
    assert Color256.mediumOrchid12.rgb == "#ff5fff".hexToRgb.get
    assert Color256.darkOrange.rgb == "#ff8700".hexToRgb.get
    assert Color256.salmon1.rgb == "#ff875f".hexToRgb.get
    assert Color256.lightCoral.rgb == "#ff8787".hexToRgb.get
    assert Color256.paleVioletRed1.rgb == "#ff87af".hexToRgb.get
    assert Color256.orchid2.rgb == "#ff87d7".hexToRgb.get
    assert Color256.orchid1.rgb == "#ff87ff".hexToRgb.get
    assert Color256.orange1.rgb == "#ffaf00".hexToRgb.get
    assert Color256.sandyBrown.rgb == "#ffaf5f".hexToRgb.get
    assert Color256.lightSalmon1.rgb == "#ffaf87".hexToRgb.get
    assert Color256.lightPink1.rgb == "#ffafaf".hexToRgb.get
    assert Color256.pink1.rgb == "#ffafd7".hexToRgb.get
    assert Color256.plum1.rgb == "#ffafff".hexToRgb.get
    assert Color256.gold1.rgb == "#ffd700".hexToRgb.get
    assert Color256.lightGoldenrod21.rgb == "#ffd75f".hexToRgb.get
    assert Color256.lightGoldenrod22.rgb == "#ffd787".hexToRgb.get
    assert Color256.navajoWhite1.rgb == "#ffd7af".hexToRgb.get
    assert Color256.mistyRose1.rgb == "#ffd7d7".hexToRgb.get
    assert Color256.thistle1.rgb == "#ffd7ff".hexToRgb.get
    assert Color256.yellow1.rgb == "#ffff00".hexToRgb.get
    assert Color256.lightGoldenrod1.rgb == "#ffff5f".hexToRgb.get
    assert Color256.khaki1.rgb == "#ffff87".hexToRgb.get
    assert Color256.wheat1.rgb == "#ffffaf".hexToRgb.get
    assert Color256.cornsilk1.rgb == "#ffffd7".hexToRgb.get
    assert Color256.gray100.rgb == "#ffffff".hexToRgb.get
    assert Color256.gray3.rgb == "#080808".hexToRgb.get
    assert Color256.gray7.rgb == "#121212".hexToRgb.get
    assert Color256.gray11.rgb == "#1c1c1c".hexToRgb.get
    assert Color256.gray15.rgb == "#262626".hexToRgb.get
    assert Color256.gray19.rgb == "#303030".hexToRgb.get
    assert Color256.gray23.rgb == "#3a3a3a".hexToRgb.get
    assert Color256.gray27.rgb == "#444444".hexToRgb.get
    assert Color256.gray30.rgb == "#4e4e4e".hexToRgb.get
    assert Color256.gray35.rgb == "#585858".hexToRgb.get
    assert Color256.gray39.rgb == "#626262".hexToRgb.get
    assert Color256.gray42.rgb == "#6c6c6c".hexToRgb.get
    assert Color256.gray46.rgb == "#767676".hexToRgb.get
    assert Color256.gray50.rgb == "#808080".hexToRgb.get
    assert Color256.gray54.rgb == "#8a8a8a".hexToRgb.get
    assert Color256.gray58.rgb == "#949494".hexToRgb.get
    assert Color256.gray62.rgb == "#9e9e9e".hexToRgb.get
    assert Color256.gray66.rgb == "#a8a8a8".hexToRgb.get
    assert Color256.gray70.rgb == "#b2b2b2".hexToRgb.get
    assert Color256.gray74.rgb == "#bcbcbc".hexToRgb.get
    assert Color256.gray78.rgb == "#c6c6c6".hexToRgb.get
    assert Color256.gray82.rgb == "#d0d0d0".hexToRgb.get
    assert Color256.gray85.rgb == "#dadada".hexToRgb.get
    assert Color256.gray89.rgb == "#e4e4e4".hexToRgb.get
    assert Color256.gray93.rgb == "#eeeeee".hexToRgb.get

suite "color: Rgb to Color":
  test "Rgb to Color8":
    assert TerminalDefaultRgb.color8.get == Color8.default
    assert "#000000".hexToRgb.get.color8.get == Color8.black
    assert "#800000".hexToRgb.get.color8.get == Color8.maroon
    assert "#008000".hexToRgb.get.color8.get == Color8.green
    assert "#808000".hexToRgb.get.color8.get == Color8.olive
    assert "#000080".hexToRgb.get.color8.get == Color8.navy
    assert "#800080".hexToRgb.get.color8.get == Color8.purple
    assert "#008080".hexToRgb.get.color8.get == Color8.teal
    assert "#c0c0c0".hexToRgb.get.color8.get == Color8.silver

    assert "#111111".hexToRgb.get.color16.isErr

  test "Rgb to Color16":
    assert TerminalDefaultRgb.color16.get == Color16.default
    assert "#000000".hexToRgb.get.color16.get == Color16.black
    assert "#800000".hexToRgb.get.color16.get == Color16.maroon
    assert "#008000".hexToRgb.get.color16.get == Color16.green
    assert "#808000".hexToRgb.get.color16.get == Color16.olive
    assert "#000080".hexToRgb.get.color16.get == Color16.navy
    assert "#800080".hexToRgb.get.color16.get == Color16.purple
    assert "#008080".hexToRgb.get.color16.get == Color16.teal
    assert "#c0c0c0".hexToRgb.get.color16.get == Color16.silver
    assert "#808080".hexToRgb.get.color16.get == Color16.gray
    assert "#ff0000".hexToRgb.get.color16.get == Color16.red
    assert "#00ff00".hexToRgb.get.color16.get == Color16.lime
    assert "#ffff00".hexToRgb.get.color16.get == Color16.yellow
    assert "#0000ff".hexToRgb.get.color16.get == Color16.blue
    assert "#ff00ff".hexToRgb.get.color16.get == Color16.fuchsia
    assert "#00ffff".hexToRgb.get.color16.get == Color16.aqua
    assert "#ffffff".hexToRgb.get.color16.get == Color16.white

    assert "#111111".hexToRgb.get.color16.isErr

  test "Rgb to Color256":
    assert TerminalDefaultRgb.color16.get == Color16.default
    assert "#000000".hexToRgb.get.color256.get == Color256.black
    assert "#800000".hexToRgb.get.color256.get == Color256.maroon
    assert "#008000".hexToRgb.get.color256.get == Color256.green
    assert "#808000".hexToRgb.get.color256.get == Color256.olive
    assert "#000080".hexToRgb.get.color256.get == Color256.navy
    assert "#800080".hexToRgb.get.color256.get == Color256.purple
    assert "#008080".hexToRgb.get.color256.get == Color256.teal
    assert "#c0c0c0".hexToRgb.get.color256.get == Color256.silver
    assert "#808080".hexToRgb.get.color256.get == Color256.gray
    assert "#ff0000".hexToRgb.get.color256.get == Color256.red
    assert "#00ff00".hexToRgb.get.color256.get == Color256.lime
    assert "#ffff00".hexToRgb.get.color256.get == Color256.yellow
    assert "#0000ff".hexToRgb.get.color256.get == Color256.blue
    assert "#ff00ff".hexToRgb.get.color256.get == Color256.fuchsia
    assert "#00ffff".hexToRgb.get.color256.get == Color256.aqua
    assert "#ffffff".hexToRgb.get.color256.get == Color256.white
    assert "#000000".hexToRgb.get.color256.get == Color256.black # NOTE: black == gray1
    assert "#00005f".hexToRgb.get.color256.get == Color256.navyBlue
    assert "#000087".hexToRgb.get.color256.get == Color256.darkBlue
    assert "#0000af".hexToRgb.get.color256.get == Color256.blue31
    assert "#0000d7".hexToRgb.get.color256.get == Color256.blue32
    assert "#0000ff".hexToRgb.get.color256.get == Color256.blue # NOTE: blue == blue1
    assert "#005f00".hexToRgb.get.color256.get == Color256.darkGreen
    assert "#005f5f".hexToRgb.get.color256.get == Color256.deepSkyBlue41
    assert "#005f87".hexToRgb.get.color256.get == Color256.deepSkyBlue42
    assert "#005faf".hexToRgb.get.color256.get == Color256.deepSkyBlue43
    assert "#005fd7".hexToRgb.get.color256.get == Color256.dodgerBlue31
    assert "#005fff".hexToRgb.get.color256.get == Color256.dodgerBlue32
    assert "#008700".hexToRgb.get.color256.get == Color256.green4
    assert "#00875f".hexToRgb.get.color256.get == Color256.springGreen4
    assert "#008787".hexToRgb.get.color256.get == Color256.turquoise4
    assert "#0087af".hexToRgb.get.color256.get == Color256.deepSkyBlue31
    assert "#0087d7".hexToRgb.get.color256.get == Color256.deepSkyBlue32
    assert "#0087ff".hexToRgb.get.color256.get == Color256.dodgerBlue1
    assert "#00af00".hexToRgb.get.color256.get == Color256.green31
    assert "#00af5f".hexToRgb.get.color256.get == Color256.springGreen31
    assert "#00af87".hexToRgb.get.color256.get == Color256.darkCyan
    assert "#00afaf".hexToRgb.get.color256.get == Color256.lightSeaGreen
    assert "#00afd7".hexToRgb.get.color256.get == Color256.deepSkyBlue2
    assert "#00afff".hexToRgb.get.color256.get == Color256.deepSkyBlue1
    assert "#00d700".hexToRgb.get.color256.get == Color256.green32
    assert "#00d75f".hexToRgb.get.color256.get == Color256.springGreen33
    assert "#00d787".hexToRgb.get.color256.get == Color256.springGreen21
    assert "#00d7af".hexToRgb.get.color256.get == Color256.cyan3
    assert "#00d7df".hexToRgb.get.color256.get == Color256.darkTurquoise
    assert "#00d7ff".hexToRgb.get.color256.get == Color256.turquoise2
    assert "#00ff00".hexToRgb.get.color256.get == Color256.lime # NOTE: lime == green1
    assert "#00ff5f".hexToRgb.get.color256.get == Color256.springGreen22
    assert "#00ff87".hexToRgb.get.color256.get == Color256.springGreen1
    assert "#00ffaf".hexToRgb.get.color256.get == Color256.mediumSpringGreen
    assert "#00ffd7".hexToRgb.get.color256.get == Color256.cyan2
    assert "#00ffff".hexToRgb.get.color256.get == Color256.aqua # NOTE: aqua == cyan1
    assert "#5f0000".hexToRgb.get.color256.get == Color256.darkRed1
    assert "#5f005f".hexToRgb.get.color256.get == Color256.deepPink41
    assert "#5f0087".hexToRgb.get.color256.get == Color256.purple41
    assert "#5f00af".hexToRgb.get.color256.get == Color256.purple42
    assert "#5f00df".hexToRgb.get.color256.get == Color256.purple3
    assert "#5f00ff".hexToRgb.get.color256.get == Color256.blueViolet
    assert "#5f5f00".hexToRgb.get.color256.get == Color256.orange41
    assert "#5f5f5f".hexToRgb.get.color256.get == Color256.gray37
    assert "#5f5f87".hexToRgb.get.color256.get == Color256.mediumPurple4
    assert "#5f5faf".hexToRgb.get.color256.get == Color256.slateBlue31
    assert "#5f5fd7".hexToRgb.get.color256.get == Color256.slateBlue32
    assert "#5f5fff".hexToRgb.get.color256.get == Color256.royalBlue1
    assert "#5f8700".hexToRgb.get.color256.get == Color256.chartreuse4
    assert "#5f875f".hexToRgb.get.color256.get == Color256.darkSeaGreen41
    assert "#5f8787".hexToRgb.get.color256.get == Color256.paleTurquoise4
    assert "#5f87af".hexToRgb.get.color256.get == Color256.steelBlue
    assert "#5f87d7".hexToRgb.get.color256.get == Color256.steelBlue3
    assert "#5f87ff".hexToRgb.get.color256.get == Color256.cornflowerBlue
    assert "#5faf00".hexToRgb.get.color256.get == Color256.chartreuse31
    assert "#5faf5f".hexToRgb.get.color256.get == Color256.darkSeaGreen42
    assert "#5faf87".hexToRgb.get.color256.get == Color256.cadetBlue1
    assert "#5fafaf".hexToRgb.get.color256.get == Color256.cadetBlue2
    assert "#5fafd7".hexToRgb.get.color256.get == Color256.skyBlue3
    assert "#5fafff".hexToRgb.get.color256.get == Color256.steelBlue11
    assert "#5fd000".hexToRgb.get.color256.get == Color256.chartreuse32
    assert "#5fd75f".hexToRgb.get.color256.get == Color256.paleGreen31
    assert "#5fd787".hexToRgb.get.color256.get == Color256.seaGreen3
    assert "#5fd7af".hexToRgb.get.color256.get == Color256.aquamarine3
    assert "#5fd7d7".hexToRgb.get.color256.get == Color256.mediumTurquoise
    assert "#5fd7ff".hexToRgb.get.color256.get == Color256.steelBlue12
    assert "#5fff00".hexToRgb.get.color256.get == Color256.chartreuse21
    assert "#5fff5f".hexToRgb.get.color256.get == Color256.seaGreen2
    assert "#5fff87".hexToRgb.get.color256.get == Color256.seaGreen11
    assert "#5fffaf".hexToRgb.get.color256.get == Color256.seaGreen12
    assert "#5fffd7".hexToRgb.get.color256.get == Color256.aquamarine11
    assert "#5fffff".hexToRgb.get.color256.get == Color256.darkSlateGray2
    assert "#870000".hexToRgb.get.color256.get == Color256.darkRed2
    assert "#87005f".hexToRgb.get.color256.get == Color256.deepPink42
    assert "#870087".hexToRgb.get.color256.get == Color256.darkMagenta1
    assert "#8700af".hexToRgb.get.color256.get == Color256.darkMagenta2
    assert "#8700d7".hexToRgb.get.color256.get == Color256.darkViolet1
    assert "#8700ff".hexToRgb.get.color256.get == Color256.purple2
    assert "#875f00".hexToRgb.get.color256.get == Color256.orange42
    assert "#875f5f".hexToRgb.get.color256.get == Color256.lightPink4
    assert "#875f87".hexToRgb.get.color256.get == Color256.plum4
    assert "#875faf".hexToRgb.get.color256.get == Color256.mediumPurple31
    assert "#875fd7".hexToRgb.get.color256.get == Color256.mediumPurple32
    assert "#875fff".hexToRgb.get.color256.get == Color256.slateBlue1
    assert "#878700".hexToRgb.get.color256.get == Color256.yellow41
    assert "#87875f".hexToRgb.get.color256.get == Color256.wheat4
    assert "#878787".hexToRgb.get.color256.get == Color256.gray53
    assert "#8787af".hexToRgb.get.color256.get == Color256.lightSlategray
    assert "#8787d7".hexToRgb.get.color256.get == Color256.mediumPurple
    assert "#8787ff".hexToRgb.get.color256.get == Color256.lightSlateBlue
    assert "#87af00".hexToRgb.get.color256.get == Color256.yellow42
    assert "#87af5f".hexToRgb.get.color256.get == Color256.Wheat4
    assert "#87af87".hexToRgb.get.color256.get == Color256.darkSeaGreen
    assert "#87afaf".hexToRgb.get.color256.get == Color256.lightSkyBlue31
    assert "#87afd7".hexToRgb.get.color256.get == Color256.lightSkyBlue32
    assert "#87afff".hexToRgb.get.color256.get == Color256.skyBlue2
    assert "#87d700".hexToRgb.get.color256.get == Color256.chartreuse22
    assert "#87d75f".hexToRgb.get.color256.get == Color256.darkOliveGreen31
    assert "#87d787".hexToRgb.get.color256.get == Color256.paleGreen32
    assert "#87d7af".hexToRgb.get.color256.get == Color256.darkSeaGreen31
    assert "#87d7d7".hexToRgb.get.color256.get == Color256.darkSlateGray3
    assert "#87d7ff".hexToRgb.get.color256.get == Color256.skyBlue1
    assert "#87ff00".hexToRgb.get.color256.get == Color256.chartreuse1
    assert "#87ff5f".hexToRgb.get.color256.get == Color256.lightGreen1
    assert "#87ff87".hexToRgb.get.color256.get == Color256.lightGreen2
    assert "#87ffaf".hexToRgb.get.color256.get == Color256.paleGreen11
    assert "#87ffd7".hexToRgb.get.color256.get == Color256.aquamarine12
    assert "#87ffff".hexToRgb.get.color256.get == Color256.darkSlateGray1
    assert "#af0000".hexToRgb.get.color256.get == Color256.red31
    assert "#af005f".hexToRgb.get.color256.get == Color256.deepPink4
    assert "#af0087".hexToRgb.get.color256.get == Color256.mediumVioletRed
    assert "#af00af".hexToRgb.get.color256.get == Color256.magenta3
    assert "#af00d7".hexToRgb.get.color256.get == Color256.darkViolet2
    assert "#af00ff".hexToRgb.get.color256.get == Color256.purple
    assert "#af5f00".hexToRgb.get.color256.get == Color256.darkOrange31
    assert "#af5f5f".hexToRgb.get.color256.get == Color256.indianRed1
    assert "#af5f87".hexToRgb.get.color256.get == Color256.hotPink31
    assert "#af5faf".hexToRgb.get.color256.get == Color256.mediumOrchid3
    assert "#af5fd7".hexToRgb.get.color256.get == Color256.mediumOrchid
    assert "#af5fff".hexToRgb.get.color256.get == Color256.mediumPurple21
    assert "#af8700".hexToRgb.get.color256.get == Color256.darkGoldenrod
    assert "#af875f".hexToRgb.get.color256.get == Color256.lightSalmon31
    assert "#af8787".hexToRgb.get.color256.get == Color256.rosyBrown
    assert "#af87af".hexToRgb.get.color256.get == Color256.gray63
    assert "#af87d7".hexToRgb.get.color256.get == Color256.mediumPurple22
    assert "#af87ff".hexToRgb.get.color256.get == Color256.mediumPurple1
    assert "#afaf00".hexToRgb.get.color256.get == Color256.gold31
    assert "#afaf5f".hexToRgb.get.color256.get == Color256.darkKhaki
    assert "#afaf87".hexToRgb.get.color256.get == Color256.navajoWhite3
    assert "#afafaf".hexToRgb.get.color256.get == Color256.gray69
    assert "#afafd7".hexToRgb.get.color256.get == Color256.lightSteelBlue3
    assert "#afafff".hexToRgb.get.color256.get == Color256.lightSteelBlue
    assert "#afd700".hexToRgb.get.color256.get == Color256.yellow31
    assert "#afd75f".hexToRgb.get.color256.get == Color256.darkOliveGreen32
    assert "#afd787".hexToRgb.get.color256.get == Color256.darkSeaGreen32
    assert "#afd7af".hexToRgb.get.color256.get == Color256.darkSeaGreen21
    assert "#afafd7".hexToRgb.get.color256.get == Color256.lightSteelBlue3 # NOTE: lightSteelBlue3 == lightCyan3
    assert "#afd7ff".hexToRgb.get.color256.get == Color256.lightSkyBlue1
    assert "#afff00".hexToRgb.get.color256.get == Color256.greenYellow
    assert "#afff5f".hexToRgb.get.color256.get == Color256.darkOliveGreen2
    assert "#afff87".hexToRgb.get.color256.get == Color256.paleGreen12
    assert "#afffaf".hexToRgb.get.color256.get == Color256.darkSeaGreen22
    assert "#afffd7".hexToRgb.get.color256.get == Color256.darkSeaGreen11
    assert "#afffff".hexToRgb.get.color256.get == Color256.paleTurquoise1
    assert "#d70000".hexToRgb.get.color256.get == Color256.red32
    assert "#d7005f".hexToRgb.get.color256.get == Color256.deepPink31
    assert "#d70087".hexToRgb.get.color256.get == Color256.deepPink32
    assert "#d700af".hexToRgb.get.color256.get == Color256.magenta31
    assert "#d700d7".hexToRgb.get.color256.get == Color256.magenta32
    assert "#d700ff".hexToRgb.get.color256.get == Color256.magenta21
    assert "#d75f00".hexToRgb.get.color256.get == Color256.darkOrange32
    assert "#d75f5f".hexToRgb.get.color256.get == Color256.indianRed2
    assert "#d75f87".hexToRgb.get.color256.get == Color256.hotPink32
    assert "#d75faf".hexToRgb.get.color256.get == Color256.hotPink2
    assert "#d75fd7".hexToRgb.get.color256.get == Color256.orchid
    assert "#d75fff".hexToRgb.get.color256.get == Color256.mediumOrchid11
    assert "#d78700".hexToRgb.get.color256.get == Color256.orange3
    assert "#d7875f".hexToRgb.get.color256.get == Color256.lightSalmon32
    assert "#d78787".hexToRgb.get.color256.get == Color256.lightPink3
    assert "#d787af".hexToRgb.get.color256.get == Color256.pink3
    assert "#d787d7".hexToRgb.get.color256.get == Color256.plum3
    assert "#d787ff".hexToRgb.get.color256.get == Color256.violet
    assert "#d7af00".hexToRgb.get.color256.get == Color256.gold32
    assert "#d7af5f".hexToRgb.get.color256.get == Color256.lightGoldenrod3
    assert "#d7af87".hexToRgb.get.color256.get == Color256.tan
    assert "#d7afaf".hexToRgb.get.color256.get == Color256.mistyRose3
    assert "#d7afd7".hexToRgb.get.color256.get == Color256.thistle3
    assert "#d7afff".hexToRgb.get.color256.get == Color256.plum2
    assert "#d7d700".hexToRgb.get.color256.get == Color256.yellow32
    assert "#d7d75f".hexToRgb.get.color256.get == Color256.khaki3
    assert "#d7d787".hexToRgb.get.color256.get == Color256.lightGoldenrod2
    assert "#d7d7af".hexToRgb.get.color256.get == Color256.lightYellow3
    assert "#d7d7d7".hexToRgb.get.color256.get == Color256.gray84
    assert "#d7d7ff".hexToRgb.get.color256.get == Color256.lightSteelBlue1
    assert "#d7ff00".hexToRgb.get.color256.get == Color256.yellow2
    assert "#d7ff5f".hexToRgb.get.color256.get == Color256.darkOliveGreen11
    assert "#d7ff87".hexToRgb.get.color256.get == Color256.darkOliveGreen12
    assert "#d7ffaf".hexToRgb.get.color256.get == Color256.darkSeaGreen12
    assert "#d7ffd7".hexToRgb.get.color256.get == Color256.honeydew2
    assert "#d7ffff".hexToRgb.get.color256.get == Color256.lightCyan1
    assert "#ff0000".hexToRgb.get.color256.get == Color256.red # NOTE: red == red1
    assert "#ff005f".hexToRgb.get.color256.get == Color256.deepPink2
    assert "#ff0087".hexToRgb.get.color256.get == Color256.deepPink11
    assert "#ff00af".hexToRgb.get.color256.get == Color256.deepPink12
    assert "#ff00d7".hexToRgb.get.color256.get == Color256.magenta22
    assert "#ff00ff".hexToRgb.get.color256.get == Color256.fuchsia # NOTE: fuchsia == magenta1
    assert "#ff5f00".hexToRgb.get.color256.get == Color256.orangeRed1
    assert "#ff5f5f".hexToRgb.get.color256.get == Color256.indianRed11
    assert "#ff5f87".hexToRgb.get.color256.get == Color256.indianRed12
    assert "#ff5faf".hexToRgb.get.color256.get == Color256.hotPink11
    assert "#ff5fd7".hexToRgb.get.color256.get == Color256.hotPink12
    assert "#ff5fff".hexToRgb.get.color256.get == Color256.mediumOrchid12
    assert "#ff8700".hexToRgb.get.color256.get == Color256.darkOrange
    assert "#ff875f".hexToRgb.get.color256.get == Color256.salmon1
    assert "#ff8787".hexToRgb.get.color256.get == Color256.lightCoral
    assert "#ff87af".hexToRgb.get.color256.get == Color256.paleVioletRed1
    assert "#ff87d7".hexToRgb.get.color256.get == Color256.orchid2
    assert "#ff87ff".hexToRgb.get.color256.get == Color256.orchid1
    assert "#ffaf00".hexToRgb.get.color256.get == Color256.orange1
    assert "#ffaf5f".hexToRgb.get.color256.get == Color256.sandyBrown
    assert "#ffaf87".hexToRgb.get.color256.get == Color256.lightSalmon1
    assert "#ffafaf".hexToRgb.get.color256.get == Color256.lightPink1
    assert "#ffafd7".hexToRgb.get.color256.get == Color256.pink1
    assert "#ffafff".hexToRgb.get.color256.get == Color256.plum1
    assert "#ffd700".hexToRgb.get.color256.get == Color256.gold1
    assert "#ffd75f".hexToRgb.get.color256.get == Color256.lightGoldenrod21
    assert "#ffd787".hexToRgb.get.color256.get == Color256.lightGoldenrod22
    assert "#ffd7af".hexToRgb.get.color256.get == Color256.navajoWhite1
    assert "#ffd7d7".hexToRgb.get.color256.get == Color256.mistyRose1
    assert "#ffd7ff".hexToRgb.get.color256.get == Color256.thistle1
    assert "#ffff00".hexToRgb.get.color256.get == Color256.yellow # NOTE: yellow == yellow1
    assert "#ffff5f".hexToRgb.get.color256.get == Color256.lightGoldenrod1
    assert "#ffff87".hexToRgb.get.color256.get == Color256.khaki1
    assert "#ffffaf".hexToRgb.get.color256.get == Color256.wheat1
    assert "#ffffd7".hexToRgb.get.color256.get == Color256.cornsilk1
    assert "#ffffff".hexToRgb.get.color256.get == Color256.white # NOTE: white == gray100
    assert "#080808".hexToRgb.get.color256.get == Color256.gray3
    assert "#121212".hexToRgb.get.color256.get == Color256.gray7
    assert "#1c1c1c".hexToRgb.get.color256.get == Color256.gray11
    assert "#262626".hexToRgb.get.color256.get == Color256.gray15
    assert "#303030".hexToRgb.get.color256.get == Color256.gray19
    assert "#3a3a3a".hexToRgb.get.color256.get == Color256.gray23
    assert "#444444".hexToRgb.get.color256.get == Color256.gray27
    assert "#4e4e4e".hexToRgb.get.color256.get == Color256.gray30
    assert "#585858".hexToRgb.get.color256.get == Color256.gray35
    assert "#626262".hexToRgb.get.color256.get == Color256.gray39
    assert "#6c6c6c".hexToRgb.get.color256.get == Color256.gray42
    assert "#767676".hexToRgb.get.color256.get == Color256.gray46
    assert "#808080".hexToRgb.get.color256.get == Color256.gray # NOTE: gray == gray50
    assert "#8a8a8A".hexToRgb.get.color256.get == Color256.gray54
    assert "#949494".hexToRgb.get.color256.get == Color256.gray58
    assert "#9e9e9e".hexToRgb.get.color256.get == Color256.gray62
    assert "#a8a8a8".hexToRgb.get.color256.get == Color256.gray66
    assert "#b2b2b2".hexToRgb.get.color256.get == Color256.gray70
    assert "#bcbcbc".hexToRgb.get.color256.get == Color256.gray74
    assert "#c6c6c6".hexToRgb.get.color256.get == Color256.gray78
    assert "#d0d0d0".hexToRgb.get.color256.get == Color256.gray82
    assert "#dadada".hexToRgb.get.color256.get == Color256.gray85
    assert "#e4e4e4".hexToRgb.get.color256.get == Color256.gray89
    assert "#eeeeeE".hexToRgb.get.color256.get == Color256.gray93

    assert "#111111".hexToRgb.get.color16.isErr

suite "color: Get Color from ColorThemeTable":
  test "foregroundRgb":
    darkDefaultFg.rgb = "#111111".hexToRgb.get

    assert darkDefaultFg == Color(
      index: EditorColorIndex.foreground,
      rgb: "#111111".hexToRgb.get)

  test "backgroundRgb":
    darkDefaultBg.rgb = "#111111".hexToRgb.get

    assert darkDefaultBg == Color(
      index: EditorColorIndex.background,
      rgb: "#111111".hexToRgb.get)

  test "rgbPairFromEditorColorPair":
    darkDefaultFg.rgb = "#222222".hexToRgb.get
    darkDefaultBg.rgb = "#222222".hexToRgb.get

    assert DarkTheme.rgbPairFromEditorColorPair(EditorColorPairIndex.default) ==
      RgbPair(
        foreground: Rgb(red: 34, green: 34, blue: 34),
        background: Rgb(red: 34, green: 34, blue: 34))

suite "color: isEditorColorPairIndex":
  test "isEditorColorPairIndex 1":
    for i in EditorColorPairIndex:
      assert isEditorColorPairIndex($i)

  test "isEditorColorPairIndex 2":
    assert not isEditorColorPairIndex("Invalid value")
    assert not isEditorColorPairIndex($(EditorColorPairIndex.high.int + 1))

suite "color: Set index to ColorThemeTable":
  test "setForegroundIndex 1":
    for i in EditorColorIndex:
      DarkTheme.setForegroundIndex(EditorColorPairIndex.default, i)

    for i in EditorColorIndex:
      DarkTheme.setForegroundIndex(EditorColorPairIndex.default, i.int)

  test "setForegroundIndex 2":
    let invalidValue = EditorColorIndex.high.int + 1
    var isErr = false

    try:
      DarkTheme.setForegroundIndex(EditorColorPairIndex.default, invalidValue)
    except RangeDefect:
      isErr = true

    assert isErr

  test "setBackgroundIndex 1":
    for i in EditorColorIndex:
      DarkTheme.setBackgroundIndex(EditorColorPairIndex.default, i)

    for i in EditorColorIndex:
      DarkTheme.setBackgroundIndex(EditorColorPairIndex.default, i.int)

  test "setBackgroundIndex 2":
    let invalidValue = EditorColorIndex.high.int + 1
    var isErr = false

    try:
      DarkTheme.setBackgroundIndex(EditorColorPairIndex.default, invalidValue)
    except RangeDefect:
      isErr = true

    assert isErr

suite "color: Set Rgb to ColorThemeTable":
  test "setForegroundRgb":
    DarkTheme.setForegroundRgb(
      EditorColorPairIndex.default,
      "#333333".hexToRgb.get)

    assert darkDefaultFg.rgb == "#333333".hexToRgb.get

  test "setBackgroundRgb":
    DarkTheme.setBackgroundRgb(
      EditorColorPairIndex.default,
      "#333333".hexToRgb.get)

    assert darkDefaultBg.rgb == "#333333".hexToRgb.get

suite "color: Downgrade":
  test "rgbToColor8":
    assert Color8.maroon == "#800001".hexToRgb.get.rgbToColor8

  test "rgbToColor16":
    assert Color16.maroon == "#800001".hexToRgb.get.rgbToColor16

  test "rgbToColor256":
    assert Color256.maroon == "#800001".hexToRgb.get.rgbToColor256

  test "downgrade rgb to c8 rgb":
    assert Rgb(red: 128, green: 0, blue: 0) ==
      "#800001".hexToRgb.get.downgrade(ColorMode.c8)

  test "downgrade rgb to c16 rgb":
    assert Rgb(red: 128, green: 0, blue: 0) ==
      "#800001".hexToRgb.get.downgrade(ColorMode.c16)

  test "downgrade rgb to c256 rgb":
    assert Rgb(red: 128, green: 0, blue: 0) ==
      "#800001".hexToRgb.get.downgrade(ColorMode.c256)

  test "Do nothing if c24bit":
    assert "#800001".hexToRgb.get ==
      "#800001".hexToRgb.get.downgrade(ColorMode.c24bit)
