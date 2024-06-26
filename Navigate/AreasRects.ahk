#Requires AutoHotkey v2.0

#Include ..\Lib\cRects.ahk

/**
 * Areas panel {cRect} collection (areasareasareasareasareasareas)
 * @memberof module:cRects
 * @property {cRect} LeafTower LeafTower button alignment area
 * @property {cRect} GardenReset Garden reset area
 */
Class cAreasRects {
    ; LeafTower button alignment area
    LeafTower := cRect(1563, 430, 1615, 964)
    ; Garden reset area
    GardenReset := cRect(1240, 5, 1280, 40)
}