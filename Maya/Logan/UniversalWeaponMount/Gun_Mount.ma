//Maya ASCII 2018 scene
//Name: Gun_Mount.ma
//Last modified: Wed, Aug 28, 2019 10:50:26 AM
//Codeset: 1252
requires maya "2018";
requires "stereoCamera" "10.0";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya 2018";
fileInfo "version" "2018";
fileInfo "cutIdentifier" "201706261615-f9658c4cfc";
fileInfo "osv" "Microsoft Windows 8 Home Premium Edition, 64-bit  (Build 9200)\n";
fileInfo "license" "student";
createNode transform -s -n "persp";
	rename -uid "41039E9A-4395-0480-3723-67A78D502746";
	setAttr ".v" no;
	setAttr ".t" -type "double3" -1.6800727927639909 -0.69565123550314434 0.8376712694090287 ;
	setAttr ".r" -type "double3" 413.06164694480225 10726.599999998016 1.1132951301878186e-14 ;
	setAttr ".rp" -type "double3" 0 -1.1102230246251565e-16 0 ;
	setAttr ".rpt" -type "double3" -6.2413659532223335e-18 3.9864116471597235e-17 8.4991232263087729e-17 ;
createNode camera -s -n "perspShape" -p "persp";
	rename -uid "66185E6D-4D5E-AEB1-9488-5DB5F5C75574";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999979;
	setAttr ".coi" 3.2915363396744741;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".tp" -type "double3" -0.012086489484173901 1.405057028992015 0.32293134825742192 ;
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode transform -s -n "top";
	rename -uid "0DD495CB-4CDF-D552-60F2-4DAA83C6DB11";
	setAttr ".v" no;
	setAttr ".t" -type "double3" -0.23553621890492571 1000.9241089210296 0.27689117377610317 ;
	setAttr ".r" -type "double3" -90 90 0 ;
createNode camera -s -n "topShape" -p "top";
	rename -uid "A4A2F224-4505-2A8D-7AFD-2B9797075AA0";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 997.47176616024171;
	setAttr ".ow" 3.458205693113126;
	setAttr ".imn" -type "string" "top";
	setAttr ".den" -type "string" "top_depth";
	setAttr ".man" -type "string" "top_mask";
	setAttr ".tp" -type "double3" 0.096647252488996194 3.4523427607879258 -0.66471996540759826 ;
	setAttr ".hc" -type "string" "viewSet -t %camera";
	setAttr ".o" yes;
createNode transform -s -n "front";
	rename -uid "0920B99D-437D-8437-A928-F6957C89790B";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0.10413182488932586 1.8196371162439242 1000.2701472000001 ;
createNode camera -s -n "frontShape" -p "front";
	rename -uid "F606B5A9-40A9-A9F9-AC65-259DBFF17C0B";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 1000.2701472000001;
	setAttr ".ow" 4.1526315789473678;
	setAttr ".imn" -type "string" "front";
	setAttr ".den" -type "string" "front_depth";
	setAttr ".man" -type "string" "front_mask";
	setAttr ".tp" -type "double3" 0 0.9309299511348893 0 ;
	setAttr ".hc" -type "string" "viewSet -f %camera";
	setAttr ".o" yes;
createNode transform -s -n "side";
	rename -uid "AD1633A5-4F5B-0708-AC51-609D86EC5D40";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 1001.1284128382676 1.9588570598613166 0.23230429775539657 ;
	setAttr ".r" -type "double3" 0 89.999999999999986 0 ;
createNode camera -s -n "sideShape" -p "side";
	rename -uid "82292973-4DAC-495E-B0BB-EC88D77815C1";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 1001.6357016933513;
	setAttr ".ow" 3.5065839200595006;
	setAttr ".imn" -type "string" "side";
	setAttr ".den" -type "string" "side_depth";
	setAttr ".man" -type "string" "side_mask";
	setAttr ".tp" -type "double3" -0.507288855083598 1.1823400600155991 0.50170355385785737 ;
	setAttr ".hc" -type "string" "viewSet -s %camera";
	setAttr ".o" yes;
createNode transform -n "pCube1";
	rename -uid "6164B523-4BD7-FA3B-11E0-C4B3FF931611";
	setAttr ".t" -type "double3" 0 -0.03114639197878824 0 ;
	setAttr ".s" -type "double3" 1.2446111220701241 0.16814318430746406 1.2446111220701241 ;
createNode mesh -n "pCubeShape1" -p "pCube1";
	rename -uid "0B727D80-40BE-7ACE-A1B0-9BB7BF6D817F";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".pv" -type "double2" 0.375 0.37500002980232239 ;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".dr" 1;
createNode transform -n "pCylinder2";
	rename -uid "6FF47FC0-4E9F-55CB-0C8E-0BB5E273F020";
	setAttr ".t" -type "double3" 0 0.39188329496492968 0 ;
	setAttr ".s" -type "double3" 0.33909203376689617 0.33909203376689617 0.33909203376689617 ;
createNode mesh -n "pCylinderShape2" -p "pCylinder2";
	rename -uid "4C34B8FA-4BA0-3EAC-8DEE-2AAFE7E50530";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
createNode transform -n "pCube3";
	rename -uid "5209E768-4879-AE39-A997-D4A410B7247D";
	setAttr ".t" -type "double3" -0.3664484248442153 1.0414996255788445 0.15824781906313978 ;
	setAttr ".s" -type "double3" 0.28168086047876545 0.28168086047876545 0.069350405555212977 ;
createNode mesh -n "pCubeShape3" -p "pCube3";
	rename -uid "9030EF7F-46F8-0211-C8AE-2887E44E031C";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".pv" -type "double2" 0.25 0.375 ;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 2 ".pt[2:3]" -type "float3"  0 -9.032269e-05 3.9202204 
		0 9.0325251e-05 3.9202199;
createNode transform -n "pCube4";
	rename -uid "6C2C7892-4180-A351-6E21-5297EA146ADB";
	setAttr ".t" -type "double3" -0.3664484248442153 1.0414996255788445 -0.16075332176409046 ;
	setAttr ".s" -type "double3" 0.28168086047876545 0.28168086047876545 0.069350405555212977 ;
createNode mesh -n "pCubeShape4" -p "pCube4";
	rename -uid "A679A2B6-41D4-E64A-B767-C0B3065F4816";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".pv" -type "double2" 0.25 0.375 ;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 10 ".uvst[0].uvsp[0:9]" -type "float2" 0.375 0 0.63087559
		 0.13033658 0.375 0.25 0.375 0.5 0.62499368 0.62824577 0.375 0.75 0.375 1 0.62498593
		 0.96954894 0.125 0 0.125 0.25;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 2 ".pt[2:3]" -type "float3"  0 -9.032269e-05 3.9202204 
		0 9.0325251e-05 3.9202199;
	setAttr -s 6 ".vt[0:5]"  -0.5 -0.5 0.5 0.5 -0.5 0.5 -0.5 0.5 0.5 -0.5 0.5 -0.5
		 0.5 -0.5 -0.5 -0.5 -0.5 -0.5;
	setAttr -s 9 ".ed[0:8]"  0 1 0 2 1 0 3 4 0 5 4 0 0 2 0 2 3 0 3 5 0
		 5 0 0 4 1 0;
	setAttr -s 5 -ch 18 ".fc[0:4]" -type "polyFaces" 
		f 3 0 -2 -5
		mu 0 3 0 1 2
		f 4 1 -9 -3 -6
		mu 0 4 2 1 4 3
		f 3 2 -4 -7
		mu 0 3 3 4 5
		f 4 3 8 -1 -8
		mu 0 4 5 4 7 6
		f 4 7 4 5 6
		mu 0 4 8 0 2 9;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".pd[0]" -type "dataPolyComponent" Index_Data UV 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
createNode transform -n "pCylinder3";
	rename -uid "E3BF1C96-407C-BF9C-A7B5-62AAEFDB4923";
	setAttr ".t" -type "double3" 0 0.9309299511348893 0 ;
	setAttr ".s" -type "double3" 0.21529263454385142 0.030574907029218924 0.21529263454385142 ;
createNode mesh -n "pCylinderShape3" -p "pCylinder3";
	rename -uid "B7A6AA86-46D3-EF05-F512-21AD5B46477F";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".pv" -type "double2" 0.5 0.84375 ;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
createNode mesh -n "polySurfaceShape1" -p "pCylinder3";
	rename -uid "464B83FB-4662-6D6D-F1E7-3A898FF06C9E";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".pv" -type "double2" 0.5 0.84375 ;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 52 ".uvst[0].uvsp[0:51]" -type "float2" 0.63531649 0.078125
		 0.578125 0.020933539 0.5 0 0.421875 0.020933539 0.36468354 0.078125 0.34375 0.15625
		 0.36468354 0.234375 0.421875 0.29156646 0.5 0.3125 0.578125 0.29156646 0.63531649
		 0.234375 0.65625 0.15625 0.375 0.3125 0.39583334 0.3125 0.41666669 0.3125 0.43750003
		 0.3125 0.45833337 0.3125 0.47916672 0.3125 0.50000006 0.3125 0.52083337 0.3125 0.54166669
		 0.3125 0.5625 0.3125 0.58333331 0.3125 0.60416663 0.3125 0.62499994 0.3125 0.375
		 0.68843985 0.39583334 0.68843985 0.41666669 0.68843985 0.43750003 0.68843985 0.45833337
		 0.68843985 0.47916672 0.68843985 0.50000006 0.68843985 0.52083337 0.68843985 0.54166669
		 0.68843985 0.5625 0.68843985 0.58333331 0.68843985 0.60416663 0.68843985 0.62499994
		 0.68843985 0.63531649 0.765625 0.578125 0.70843351 0.5 0.6875 0.421875 0.70843351
		 0.36468354 0.765625 0.34375 0.84375 0.36468354 0.921875 0.421875 0.97906649 0.5 1
		 0.578125 0.97906649 0.63531649 0.921875 0.65625 0.84375 0.5 0.15000001 0.5 0.83749998;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 26 ".vt[0:25]"  0.86602539 -1 -0.5 0.5 -1 -0.86602539 0 -1 -1
		 -0.5 -1 -0.86602539 -0.86602539 -1 -0.5 -1 -1 0 -0.86602539 -1 0.5 -0.5 -1 0.86602539
		 0 -1 1 0.5 -1 0.86602539 0.86602539 -1 0.5 1 -1 0 0.86602539 1 -0.5 0.5 1 -0.86602539
		 0 1 -1 -0.5 1 -0.86602539 -0.86602539 1 -0.5 -1 1 0 -0.86602539 1 0.5 -0.5 1 0.86602539
		 0 1 1 0.5 1 0.86602539 0.86602539 1 0.5 1 1 0 0 -1 0 0 1 0;
	setAttr -s 60 ".ed[0:59]"  0 1 0 1 2 0 2 3 0 3 4 0 4 5 0 5 6 0 6 7 0
		 7 8 0 8 9 0 9 10 0 10 11 0 11 0 0 12 13 0 13 14 0 14 15 0 15 16 0 16 17 0 17 18 0
		 18 19 0 19 20 0 20 21 0 21 22 0 22 23 0 23 12 0 0 12 0 1 13 0 2 14 0 3 15 0 4 16 0
		 5 17 0 6 18 0 7 19 0 8 20 0 9 21 0 10 22 0 11 23 0 24 0 1 24 1 1 24 2 1 24 3 1 24 4 1
		 24 5 1 24 6 1 24 7 1 24 8 1 24 9 1 24 10 1 24 11 1 12 25 1 13 25 1 14 25 1 15 25 1
		 16 25 1 17 25 1 18 25 1 19 25 1 20 25 1 21 25 1 22 25 1 23 25 1;
	setAttr -s 36 -ch 120 ".fc[0:35]" -type "polyFaces" 
		f 4 0 25 -13 -25
		mu 0 4 12 13 26 25
		f 4 1 26 -14 -26
		mu 0 4 13 14 27 26
		f 4 2 27 -15 -27
		mu 0 4 14 15 28 27
		f 4 3 28 -16 -28
		mu 0 4 15 16 29 28
		f 4 4 29 -17 -29
		mu 0 4 16 17 30 29
		f 4 5 30 -18 -30
		mu 0 4 17 18 31 30
		f 4 6 31 -19 -31
		mu 0 4 18 19 32 31
		f 4 7 32 -20 -32
		mu 0 4 19 20 33 32
		f 4 8 33 -21 -33
		mu 0 4 20 21 34 33
		f 4 9 34 -22 -34
		mu 0 4 21 22 35 34
		f 4 10 35 -23 -35
		mu 0 4 22 23 36 35
		f 4 11 24 -24 -36
		mu 0 4 23 24 37 36
		f 3 -1 -37 37
		mu 0 3 1 0 50
		f 3 -2 -38 38
		mu 0 3 2 1 50
		f 3 -3 -39 39
		mu 0 3 3 2 50
		f 3 -4 -40 40
		mu 0 3 4 3 50
		f 3 -5 -41 41
		mu 0 3 5 4 50
		f 3 -6 -42 42
		mu 0 3 6 5 50
		f 3 -7 -43 43
		mu 0 3 7 6 50
		f 3 -8 -44 44
		mu 0 3 8 7 50
		f 3 -9 -45 45
		mu 0 3 9 8 50
		f 3 -10 -46 46
		mu 0 3 10 9 50
		f 3 -11 -47 47
		mu 0 3 11 10 50
		f 3 -12 -48 36
		mu 0 3 0 11 50
		f 3 12 49 -49
		mu 0 3 48 47 51
		f 3 13 50 -50
		mu 0 3 47 46 51
		f 3 14 51 -51
		mu 0 3 46 45 51
		f 3 15 52 -52
		mu 0 3 45 44 51
		f 3 16 53 -53
		mu 0 3 44 43 51
		f 3 17 54 -54
		mu 0 3 43 42 51
		f 3 18 55 -55
		mu 0 3 42 41 51
		f 3 19 56 -56
		mu 0 3 41 40 51
		f 3 20 57 -57
		mu 0 3 40 39 51
		f 3 21 58 -58
		mu 0 3 39 38 51
		f 3 22 59 -59
		mu 0 3 38 49 51
		f 3 23 48 -60
		mu 0 3 49 48 51;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".pd[0]" -type "dataPolyComponent" Index_Data UV 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
createNode lightLinker -s -n "lightLinker1";
	rename -uid "C17A5128-4CF3-303E-76F2-DA9458E49F00";
	setAttr -s 23 ".lnk";
	setAttr -s 23 ".slnk";
createNode shapeEditorManager -n "shapeEditorManager";
	rename -uid "2EF2A776-42AD-D173-ABC2-F996CE366F72";
createNode poseInterpolatorManager -n "poseInterpolatorManager";
	rename -uid "641A204C-4CAF-6799-CC2A-86BE9598FDE4";
createNode displayLayerManager -n "layerManager";
	rename -uid "4C536A6A-4719-9B71-8136-82A8962CB5BB";
	setAttr ".cdl" 1;
	setAttr -s 2 ".dli[1]"  1;
	setAttr -s 2 ".dli";
createNode displayLayer -n "defaultLayer";
	rename -uid "CAA9C305-47B6-D8DB-E5AE-ACBACF7D9FD4";
createNode renderLayerManager -n "renderLayerManager";
	rename -uid "878DB412-454A-F594-901E-4CBB0EDCFB46";
createNode renderLayer -n "defaultRenderLayer";
	rename -uid "D8427A5A-4EC4-6437-B9BE-7C9FBDA54C72";
	setAttr ".g" yes;
createNode script -n "uiConfigurationScriptNode";
	rename -uid "CD81CCB6-4346-0233-3028-78943855666D";
	setAttr ".b" -type "string" (
		"// Maya Mel UI Configuration File.\n//\n//  This script is machine generated.  Edit at your own risk.\n//\n//\n\nglobal string $gMainPane;\nif (`paneLayout -exists $gMainPane`) {\n\n\tglobal int $gUseScenePanelConfig;\n\tint    $useSceneConfig = $gUseScenePanelConfig;\n\tint    $menusOkayInPanels = `optionVar -q allowMenusInPanels`;\tint    $nVisPanes = `paneLayout -q -nvp $gMainPane`;\n\tint    $nPanes = 0;\n\tstring $editorName;\n\tstring $panelName;\n\tstring $itemFilterName;\n\tstring $panelConfig;\n\n\t//\n\t//  get current state of the UI\n\t//\n\tsceneUIReplacement -update $gMainPane;\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Top View\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Top View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"top\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"wireframe\" \n            -activeOnly 0\n"
		+ "            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -holdOuts 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 0\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 1\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 32768\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -depthOfFieldPreview 1\n            -maxConstantTransparency 1\n            -rendererName \"vp2Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n"
		+ "            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -controllers 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -particleInstancers 1\n            -fluids 1\n"
		+ "            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            -captureSequenceNumber -1\n            -width 639\n            -height 322\n            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Side View\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Side View\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"side\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"wireframe\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -holdOuts 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 0\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 32768\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n"
		+ "            -depthOfFieldPreview 1\n            -maxConstantTransparency 1\n            -rendererName \"vp2Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -controllers 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n"
		+ "            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -particleInstancers 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            -captureSequenceNumber -1\n            -width 638\n            -height 322\n            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Front View\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Front View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"front\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"wireframe\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -holdOuts 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 0\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n"
		+ "            -textureDisplay \"modulate\" \n            -textureMaxSize 32768\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -depthOfFieldPreview 1\n            -maxConstantTransparency 1\n            -rendererName \"vp2Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n"
		+ "            -sortTransparent 1\n            -controllers 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -particleInstancers 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            -captureSequenceNumber -1\n            -width 639\n            -height 322\n"
		+ "            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Persp View\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Persp View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"persp\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -holdOuts 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 0\n            -backfaceCulling 0\n"
		+ "            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 32768\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -depthOfFieldPreview 1\n            -maxConstantTransparency 1\n            -rendererName \"vp2Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n"
		+ "            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -controllers 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -particleInstancers 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n"
		+ "            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            -captureSequenceNumber -1\n            -width 1284\n            -height 688\n            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"outlinerPanel\" (localizedPanelLabel(\"ToggledOutliner\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\toutlinerPanel -edit -l (localizedPanelLabel(\"ToggledOutliner\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        outlinerEditor -e \n            -docTag \"isolOutln_fromSeln\" \n            -showShapes 0\n            -showAssignedMaterials 0\n            -showTimeEditor 1\n            -showReferenceNodes 1\n            -showReferenceMembers 1\n"
		+ "            -showAttributes 0\n            -showConnected 0\n            -showAnimCurvesOnly 0\n            -showMuteInfo 0\n            -organizeByLayer 1\n            -organizeByClip 1\n            -showAnimLayerWeight 1\n            -autoExpandLayers 1\n            -autoExpand 0\n            -showDagOnly 1\n            -showAssets 1\n            -showContainedOnly 1\n            -showPublishedAsConnected 0\n            -showParentContainers 0\n            -showContainerContents 1\n            -ignoreDagHierarchy 0\n            -expandConnections 0\n            -showUpstreamCurves 1\n            -showUnitlessCurves 1\n            -showCompounds 1\n            -showLeafs 1\n            -showNumericAttrsOnly 0\n            -highlightActive 1\n            -autoSelectNewObjects 0\n            -doNotSelectNewObjects 0\n            -dropIsParent 1\n            -transmitFilters 0\n            -setFilter \"defaultSetFilter\" \n            -showSetMembers 1\n            -allowMultiSelection 1\n            -alwaysToggleSelect 0\n            -directSelect 0\n"
		+ "            -isSet 0\n            -isSetMember 0\n            -displayMode \"DAG\" \n            -expandObjects 0\n            -setsIgnoreFilters 1\n            -containersIgnoreFilters 0\n            -editAttrName 0\n            -showAttrValues 0\n            -highlightSecondary 0\n            -showUVAttrsOnly 0\n            -showTextureNodesOnly 0\n            -attrAlphaOrder \"default\" \n            -animLayerFilterOptions \"allAffecting\" \n            -sortOrder \"none\" \n            -longNames 0\n            -niceNames 1\n            -showNamespace 1\n            -showPinIcons 0\n            -mapMotionTrails 0\n            -ignoreHiddenAttribute 0\n            -ignoreOutlinerColor 0\n            -renderFilterVisible 0\n            -renderFilterIndex 0\n            -selectionOrder \"chronological\" \n            -expandAttribute 0\n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"outlinerPanel\" (localizedPanelLabel(\"Outliner\")) `;\n\tif (\"\" != $panelName) {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n\t\toutlinerPanel -edit -l (localizedPanelLabel(\"Outliner\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        outlinerEditor -e \n            -docTag \"isolOutln_fromSeln\" \n            -showShapes 0\n            -showAssignedMaterials 0\n            -showTimeEditor 1\n            -showReferenceNodes 0\n            -showReferenceMembers 0\n            -showAttributes 0\n            -showConnected 0\n            -showAnimCurvesOnly 0\n            -showMuteInfo 0\n            -organizeByLayer 1\n            -organizeByClip 1\n            -showAnimLayerWeight 1\n            -autoExpandLayers 1\n            -autoExpand 0\n            -showDagOnly 0\n            -showAssets 1\n            -showContainedOnly 1\n            -showPublishedAsConnected 0\n            -showParentContainers 0\n            -showContainerContents 1\n            -ignoreDagHierarchy 0\n            -expandConnections 0\n            -showUpstreamCurves 1\n            -showUnitlessCurves 1\n            -showCompounds 1\n"
		+ "            -showLeafs 1\n            -showNumericAttrsOnly 0\n            -highlightActive 1\n            -autoSelectNewObjects 0\n            -doNotSelectNewObjects 0\n            -dropIsParent 1\n            -transmitFilters 0\n            -setFilter \"defaultSetFilter\" \n            -showSetMembers 1\n            -allowMultiSelection 1\n            -alwaysToggleSelect 0\n            -directSelect 0\n            -displayMode \"DAG\" \n            -expandObjects 0\n            -setsIgnoreFilters 1\n            -containersIgnoreFilters 0\n            -editAttrName 0\n            -showAttrValues 0\n            -highlightSecondary 0\n            -showUVAttrsOnly 0\n            -showTextureNodesOnly 0\n            -attrAlphaOrder \"default\" \n            -animLayerFilterOptions \"allAffecting\" \n            -sortOrder \"none\" \n            -longNames 0\n            -niceNames 1\n            -showNamespace 1\n            -showPinIcons 0\n            -mapMotionTrails 0\n            -ignoreHiddenAttribute 0\n            -ignoreOutlinerColor 0\n            -renderFilterVisible 0\n"
		+ "            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"graphEditor\" (localizedPanelLabel(\"Graph Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Graph Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showAssignedMaterials 0\n                -showTimeEditor 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -organizeByClip 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 1\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n"
		+ "                -showPublishedAsConnected 0\n                -showParentContainers 1\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 1\n                -showCompounds 0\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 1\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 1\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n"
		+ "                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 1\n                -mapMotionTrails 1\n                -ignoreHiddenAttribute 0\n                -ignoreOutlinerColor 0\n                -renderFilterVisible 0\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"GraphEd\");\n            animCurveEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 1\n                -displayInfinities 0\n                -displayValues 0\n                -autoFit 1\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -showResults \"off\" \n                -showBufferCurves \"off\" \n                -smoothness \"fine\" \n                -resultSamples 1\n                -resultScreenSamples 0\n                -resultUpdate \"delayed\" \n"
		+ "                -showUpstreamCurves 1\n                -showCurveNames 0\n                -showActiveCurveNames 0\n                -stackedCurves 0\n                -stackedCurvesMin -1\n                -stackedCurvesMax 1\n                -stackedCurvesSpace 0.2\n                -displayNormalized 0\n                -preSelectionHighlight 0\n                -constrainDrag 0\n                -classicMode 1\n                -valueLinesToggle 1\n                -outliner \"graphEditor1OutlineEd\" \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dopeSheetPanel\" (localizedPanelLabel(\"Dope Sheet\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Dope Sheet\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showAssignedMaterials 0\n                -showTimeEditor 1\n"
		+ "                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -organizeByClip 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 0\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showParentContainers 1\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 0\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 1\n                -dropIsParent 1\n                -transmitFilters 0\n"
		+ "                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 0\n                -mapMotionTrails 1\n                -ignoreHiddenAttribute 0\n                -ignoreOutlinerColor 0\n                -renderFilterVisible 0\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"DopeSheetEd\");\n            dopeSheetEditor -e \n                -displayKeys 1\n"
		+ "                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -displayValues 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -outliner \"dopeSheetPanel1OutlineEd\" \n                -showSummary 1\n                -showScene 0\n                -hierarchyBelow 0\n                -showTicks 1\n                -selectionWindow 0 0 0 0 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"timeEditorPanel\" (localizedPanelLabel(\"Time Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Time Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"clipEditorPanel\" (localizedPanelLabel(\"Trax Editor\")) `;\n"
		+ "\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Trax Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = clipEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -displayValues 0\n                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -initialized 0\n                -manageSequencer 0 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"sequenceEditorPanel\" (localizedPanelLabel(\"Camera Sequencer\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Camera Sequencer\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = sequenceEditorNameFromPanel($panelName);\n"
		+ "            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -displayValues 0\n                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -initialized 0\n                -manageSequencer 1 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperGraphPanel\" (localizedPanelLabel(\"Hypergraph Hierarchy\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Hypergraph Hierarchy\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"HyperGraphEd\");\n            hyperGraph -e \n                -graphLayoutStyle \"hierarchicalLayout\" \n                -orientation \"horiz\" \n                -mergeConnections 0\n                -zoom 1\n"
		+ "                -animateTransition 0\n                -showRelationships 1\n                -showShapes 0\n                -showDeformers 0\n                -showExpressions 0\n                -showConstraints 0\n                -showConnectionFromSelected 0\n                -showConnectionToSelected 0\n                -showConstraintLabels 0\n                -showUnderworld 0\n                -showInvisible 0\n                -transitionFrames 1\n                -opaqueContainers 0\n                -freeform 0\n                -imagePosition 0 0 \n                -imageScale 1\n                -imageEnabled 0\n                -graphType \"DAG\" \n                -heatMapDisplay 0\n                -updateSelection 1\n                -updateNodeAdded 1\n                -useDrawOverrideColor 0\n                -limitGraphTraversal -1\n                -range 0 0 \n                -iconSize \"smallIcons\" \n                -showCachedConnections 0\n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n"
		+ "\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperShadePanel\" (localizedPanelLabel(\"Hypershade\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Hypershade\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"visorPanel\" (localizedPanelLabel(\"Visor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Visor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"createNodePanel\" (localizedPanelLabel(\"Create Node\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Create Node\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n"
		+ "\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"polyTexturePlacementPanel\" (localizedPanelLabel(\"UV Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"UV Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"renderWindowPanel\" (localizedPanelLabel(\"Render View\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Render View\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"shapePanel\" (localizedPanelLabel(\"Shape Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tshapePanel -edit -l (localizedPanelLabel(\"Shape Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"posePanel\" (localizedPanelLabel(\"Pose Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tposePanel -edit -l (localizedPanelLabel(\"Pose Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynRelEdPanel\" (localizedPanelLabel(\"Dynamic Relationships\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Dynamic Relationships\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"relationshipPanel\" (localizedPanelLabel(\"Relationship Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Relationship Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"referenceEditorPanel\" (localizedPanelLabel(\"Reference Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Reference Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"componentEditorPanel\" (localizedPanelLabel(\"Component Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Component Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynPaintScriptedPanelType\" (localizedPanelLabel(\"Paint Effects\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Paint Effects\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"scriptEditorPanel\" (localizedPanelLabel(\"Script Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Script Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"profilerPanel\" (localizedPanelLabel(\"Profiler Tool\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Profiler Tool\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"contentBrowserPanel\" (localizedPanelLabel(\"Content Browser\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Content Browser\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"Stereo\" (localizedPanelLabel(\"Stereo\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Stereo\")) -mbv $menusOkayInPanels  $panelName;\nstring $editorName = ($panelName+\"Editor\");\n            stereoCameraView -e \n                -camera \"persp\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"wireframe\" \n                -activeOnly 0\n                -ignorePanZoom 0\n                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -holdOuts 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 1\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n                -displayTextures 0\n"
		+ "                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 32768\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -depthOfFieldPreview 1\n                -maxConstantTransparency 1\n                -objectFilterShowInHUD 1\n                -isFiltered 0\n                -colorResolution 4 4 \n                -bumpResolution 4 4 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 0\n                -occlusionCulling 0\n                -shadingModel 0\n"
		+ "                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -controllers 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -imagePlane 1\n                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -particleInstancers 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n"
		+ "                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                -captureSequenceNumber -1\n                -width 0\n                -height 0\n                -sceneRenderFilter 0\n                -displayMode \"centerEye\" \n                -viewColor 0 0 0 1 \n                -useCustomBackground 1\n                $editorName;\n            stereoCameraView -e -viewSelected 0 $editorName;\n            stereoCameraView -e \n                -pluginObjects \"gpuCacheDisplayFilter\" 1 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"nodeEditorPanel\" (localizedPanelLabel(\"Node Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Node Editor\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\n\t\t\t$editorName = ($panelName+\"NodeEditorEd\");\n            nodeEditor -e \n                -allAttributes 0\n                -allNodes 0\n                -autoSizeNodes 1\n                -consistentNameSize 1\n                -createNodeCommand \"nodeEdCreateNodeCommand\" \n                -connectNodeOnCreation 0\n                -connectOnDrop 0\n                -highlightConnections 0\n                -copyConnectionsOnPaste 0\n                -defaultPinnedState 0\n                -additiveGraphingMode 0\n                -settingsChangedCallback \"nodeEdSyncControls\" \n                -traversalDepthLimit -1\n                -keyPressCommand \"nodeEdKeyPressCommand\" \n                -nodeTitleMode \"name\" \n                -gridSnap 0\n                -gridVisibility 1\n                -crosshairOnEdgeDragging 0\n                -popupMenuScript \"nodeEdBuildPanelMenus\" \n                -showNamespace 1\n                -showShapes 1\n                -showSGShapes 0\n                -showTransforms 1\n                -useAssets 1\n                -syncedSelection 1\n"
		+ "                -extendToShapes 1\n                -activeTab -1\n                -editorMode \"default\" \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\tif ($useSceneConfig) {\n        string $configName = `getPanel -cwl (localizedPanelLabel(\"Current Layout\"))`;\n        if (\"\" != $configName) {\n\t\t\tpanelConfiguration -edit -label (localizedPanelLabel(\"Current Layout\")) \n\t\t\t\t-userCreated false\n\t\t\t\t-defaultImage \"vacantCell.xP:/\"\n\t\t\t\t-image \"\"\n\t\t\t\t-sc false\n\t\t\t\t-configString \"global string $gMainPane; paneLayout -e -cn \\\"single\\\" -ps 1 100 100 $gMainPane;\"\n\t\t\t\t-removeAllPanels\n\t\t\t\t-ap false\n\t\t\t\t\t(localizedPanelLabel(\"Persp View\")) \n\t\t\t\t\t\"modelPanel\"\n"
		+ "\t\t\t\t\t\"$panelName = `modelPanel -unParent -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels `;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -holdOuts 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 0\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 32768\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -depthOfFieldPreview 1\\n    -maxConstantTransparency 1\\n    -rendererName \\\"vp2Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -controllers 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -particleInstancers 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -greasePencils 1\\n    -shadows 0\\n    -captureSequenceNumber -1\\n    -width 1284\\n    -height 688\\n    -sceneRenderFilter 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName;\\nmodelEditor -e \\n    -pluginObjects \\\"gpuCacheDisplayFilter\\\" 1 \\n    $editorName\"\n"
		+ "\t\t\t\t\t\"modelPanel -edit -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels  $panelName;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -holdOuts 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 0\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 32768\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -depthOfFieldPreview 1\\n    -maxConstantTransparency 1\\n    -rendererName \\\"vp2Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -controllers 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -particleInstancers 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -greasePencils 1\\n    -shadows 0\\n    -captureSequenceNumber -1\\n    -width 1284\\n    -height 688\\n    -sceneRenderFilter 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName;\\nmodelEditor -e \\n    -pluginObjects \\\"gpuCacheDisplayFilter\\\" 1 \\n    $editorName\"\n"
		+ "\t\t\t\t$configName;\n\n            setNamedPanelLayout (localizedPanelLabel(\"Current Layout\"));\n        }\n\n        panelHistory -e -clear mainPanelHistory;\n        sceneUIReplacement -clear;\n\t}\n\n\ngrid -spacing 5 -size 12 -divisions 5 -displayAxes yes -displayGridLines yes -displayDivisionLines yes -displayPerspectiveLabels no -displayOrthographicLabels no -displayAxesBold yes -perspectiveLabelPosition axis -orthographicLabelPosition edge;\nviewManip -drawCompass 0 -compassAngle 0 -frontParameters \"\" -homeParameters \"\" -selectionLockParameters \"\";\n}\n");
	setAttr ".st" 3;
createNode script -n "sceneConfigurationScriptNode";
	rename -uid "A643D20C-42BA-CF73-6D85-AF929B2C3C43";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 120 -ast 1 -aet 200 ";
	setAttr ".st" 6;
createNode displayLayer -n "RefLayer";
	rename -uid "162AB4B2-4944-0550-BF03-BE8C4E91885D";
	setAttr ".dt" 2;
	setAttr ".do" 1;
createNode renderLayerManager -n "M134_MiniGun:renderLayerManager";
	rename -uid "D0696F2D-4EB5-B235-594D-65B6536AA415";
createNode renderLayer -n "M134_MiniGun:defaultRenderLayer";
	rename -uid "EFFC8B3D-473F-A3D7-72F9-189CD7C640E0";
	setAttr ".g" yes;
createNode lambert -n "lambert2";
	rename -uid "D5B0240E-4B15-EFB8-A715-08B6FE83F8A3";
	setAttr ".c" -type "float3" 0.15093599 0.24169724 0.331 ;
createNode shadingEngine -n "lambert2SG";
	rename -uid "9881C183-4CDD-DE74-91B1-EC9CDBAEEDFA";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo1";
	rename -uid "04279FD5-4BB1-3FDE-9530-019F9E5407B7";
createNode lambert -n "lambert3";
	rename -uid "410334E8-4165-2FFB-5961-76A1716DCC9A";
	setAttr ".c" -type "float3" 0.76700002 0.61553031 0 ;
createNode shadingEngine -n "lambert3SG";
	rename -uid "08A09736-4CF8-F855-03DD-3296B7C79707";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo2";
	rename -uid "2DBC6173-4A91-FDDB-F0B2-60812E2012C4";
createNode lambert -n "lambert4";
	rename -uid "B46528AA-4494-8306-8706-51A5BBD27FDA";
	setAttr ".c" -type "float3" 0.064000003 0.064000003 0.064000003 ;
createNode shadingEngine -n "lambert4SG";
	rename -uid "D419CBA2-4B07-AEC7-B1EC-B1BE709ACCDC";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo3";
	rename -uid "41EDC1D6-4E4C-6BAA-5C99-94A73D88301E";
createNode lambert -n "lambert5";
	rename -uid "074FAEDA-427E-5D46-2232-7981495D3225";
	setAttr ".c" -type "float3" 0.73400003 0.67748201 0.67748201 ;
createNode shadingEngine -n "lambert5SG";
	rename -uid "398C5B23-4CCD-345B-A043-26A945A6107B";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo4";
	rename -uid "EBD462BB-4FA2-26E3-CB0C-77ABEBE79B8F";
createNode lambert -n "lambert6";
	rename -uid "010C623B-4C75-FFC1-7DC2-E48CDEE0DACB";
	setAttr ".c" -type "float3" 0.21325786 0.31200001 0.18969601 ;
createNode shadingEngine -n "lambert6SG";
	rename -uid "6E4781BB-4F0A-E951-1DF6-00B3F9E9E689";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo5";
	rename -uid "71CB7E91-4FA6-7A43-23E2-6DABDC9EE6A2";
createNode lambert -n "lambert7";
	rename -uid "0E808F39-4C65-1574-7CA8-DAB24685D383";
	setAttr ".c" -type "float3" 0.1999 0.21510001 0.228 ;
createNode shadingEngine -n "lambert7SG";
	rename -uid "76537D1C-444A-6797-3138-2D98AC29AC6E";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo6";
	rename -uid "93832FD0-4DAA-CD73-9803-5085186CA10B";
createNode lambert -n "lambert8";
	rename -uid "717B8F16-430D-C67A-9D69-2EABE9B8933B";
	setAttr ".c" -type "float3" 0.23454787 0.25015786 0.254152 ;
createNode shadingEngine -n "lambert8SG";
	rename -uid "E78F2B7D-4277-A8A3-40BA-D7A1A621342C";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo7";
	rename -uid "603EDDDD-4549-C2D3-40EE-F2AA08A74D67";
createNode lambert -n "lambert9";
	rename -uid "97F06BC3-4176-8347-7B23-2F90964F6E4C";
	setAttr ".c" -type "float3" 0.4166036 0.43200001 0.241056 ;
createNode shadingEngine -n "lambert9SG";
	rename -uid "9D2AC2E7-4E7F-3F54-508F-16AC64E2F60F";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo8";
	rename -uid "20108E75-4820-0D5C-EF63-C38DC4446487";
createNode lambert -n "lambert10";
	rename -uid "FA7AFD95-4B48-8932-1B65-80ADBAB58F8F";
	setAttr ".c" -type "float3" 0.049706705 0.049706705 0.051269881 ;
createNode shadingEngine -n "lambert10SG";
	rename -uid "2E6AC9DD-4E21-60C6-79A4-D5A36B593B2C";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo9";
	rename -uid "8FD6D433-49E0-C667-7242-7595A4FF2AE1";
createNode lambert -n "lambert11";
	rename -uid "401F2BE3-40E6-B982-CF91-5B9527AF0D96";
	setAttr ".c" -type "float3" 0.66500002 0.18753001 0.18930452 ;
createNode shadingEngine -n "lambert11SG";
	rename -uid "BE560282-4977-A25C-1435-5D89EE7A273D";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo10";
	rename -uid "4A7B11D4-4DC3-4854-778C-E39D2BAE44F6";
createNode lambert -n "lambert12";
	rename -uid "D6EB8FE5-4F73-2BFD-F9CD-698BC86C5518";
	setAttr ".c" -type "float3" 0.249798 0.38952166 0.52700001 ;
createNode shadingEngine -n "lambert12SG";
	rename -uid "648DB9CA-45E0-B354-4794-F0BB25DBCC17";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo11";
	rename -uid "D15412BB-4B72-79C4-F300-68920D50D897";
createNode lambert -n "lambert13";
	rename -uid "19C529C7-44FA-15C5-FEAA-C4BCF8F13C7E";
	setAttr ".c" -type "float3" 0.27000001 0.26190001 0.26593167 ;
createNode shadingEngine -n "lambert13SG";
	rename -uid "2519E9A7-4D73-DF78-F55A-CCBAF40DEAE0";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo12";
	rename -uid "68886627-4F8E-6E62-B9C2-03BC06DED34B";
createNode lambert -n "lambert14";
	rename -uid "467A22A5-42BE-E04B-D5B0-2AA8471A0B9F";
	setAttr ".c" -type "float3" 0.31400001 0.0012560026 0.0012560026 ;
createNode shadingEngine -n "lambert14SG";
	rename -uid "04A6B362-4B1C-B8C9-5FAC-0B84899996DB";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo13";
	rename -uid "8FBFA1EE-4D63-EFA4-8BB2-F6A86FD83BCD";
createNode lambert -n "lambert15";
	rename -uid "972F28BD-444F-A177-EA01-65B90FC44054";
	setAttr ".c" -type "float3" 0.11172401 0.52700001 0.25828868 ;
createNode shadingEngine -n "lambert15SG";
	rename -uid "9887F77B-4398-8398-0ED5-54B15B31E44B";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo14";
	rename -uid "3675A0B3-458F-229D-D809-97BB6862DBBD";
createNode lambert -n "lambert16";
	rename -uid "6A12CC6F-4F7B-6DEC-9F13-5A84D44B5659";
	setAttr ".c" -type "float3" 0 0.96153331 1 ;
createNode shadingEngine -n "lambert16SG";
	rename -uid "4C31A2E1-4176-5259-439E-5D8897E766A4";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo15";
	rename -uid "ECC704A5-45DE-8C6A-C754-75AFA9F81B00";
createNode nodeGraphEditorInfo -n "hyperShadePrimaryNodeEditorSavedTabsInfo";
	rename -uid "9743BDE1-444C-6815-E2B5-2FBB18B5F590";
	setAttr ".tgi[0].tn" -type "string" "Untitled_1";
	setAttr ".tgi[0].vl" -type "double2" -911.27344565905889 -934.49428353057908 ;
	setAttr ".tgi[0].vh" -type "double2" 451.4132629711425 326.16097437023933 ;
	setAttr -s 24 ".tgi[0].ni";
	setAttr ".tgi[0].ni[0].x" -134.28572082519531;
	setAttr ".tgi[0].ni[0].y" -631.4285888671875;
	setAttr ".tgi[0].ni[0].nvs" 1923;
	setAttr ".tgi[0].ni[1].x" 172.85714721679688;
	setAttr ".tgi[0].ni[1].y" -631.4285888671875;
	setAttr ".tgi[0].ni[1].nvs" 1923;
	setAttr ".tgi[0].ni[2].x" -422.85714721679688;
	setAttr ".tgi[0].ni[2].y" 141.42857360839844;
	setAttr ".tgi[0].ni[2].nvs" 1923;
	setAttr ".tgi[0].ni[3].x" -131.42857360839844;
	setAttr ".tgi[0].ni[3].y" -164.28572082519531;
	setAttr ".tgi[0].ni[3].nvs" 1923;
	setAttr ".tgi[0].ni[4].x" -422.85714721679688;
	setAttr ".tgi[0].ni[4].y" -164.28572082519531;
	setAttr ".tgi[0].ni[4].nvs" 1923;
	setAttr ".tgi[0].ni[5].x" -438.57144165039063;
	setAttr ".tgi[0].ni[5].y" -160;
	setAttr ".tgi[0].ni[5].nvs" 1923;
	setAttr ".tgi[0].ni[6].x" -131.42857360839844;
	setAttr ".tgi[0].ni[6].y" -164.28572082519531;
	setAttr ".tgi[0].ni[6].nvs" 1923;
	setAttr ".tgi[0].ni[7].x" -438.57144165039063;
	setAttr ".tgi[0].ni[7].y" -160;
	setAttr ".tgi[0].ni[7].nvs" 1923;
	setAttr ".tgi[0].ni[8].x" -131.42857360839844;
	setAttr ".tgi[0].ni[8].y" -160;
	setAttr ".tgi[0].ni[8].nvs" 1923;
	setAttr ".tgi[0].ni[9].x" -422.85714721679688;
	setAttr ".tgi[0].ni[9].y" -164.28572082519531;
	setAttr ".tgi[0].ni[9].nvs" 1923;
	setAttr ".tgi[0].ni[10].x" -131.42857360839844;
	setAttr ".tgi[0].ni[10].y" -160;
	setAttr ".tgi[0].ni[10].nvs" 1923;
	setAttr ".tgi[0].ni[11].x" -115.71428680419922;
	setAttr ".tgi[0].ni[11].y" -164.28572082519531;
	setAttr ".tgi[0].ni[11].nvs" 1923;
	setAttr ".tgi[0].ni[12].x" -131.42857360839844;
	setAttr ".tgi[0].ni[12].y" -160;
	setAttr ".tgi[0].ni[12].nvs" 1923;
	setAttr ".tgi[0].ni[13].x" -438.57144165039063;
	setAttr ".tgi[0].ni[13].y" -164.28572082519531;
	setAttr ".tgi[0].ni[13].nvs" 1923;
	setAttr ".tgi[0].ni[14].x" -115.71428680419922;
	setAttr ".tgi[0].ni[14].y" -164.28572082519531;
	setAttr ".tgi[0].ni[14].nvs" 1923;
	setAttr ".tgi[0].ni[15].x" -115.71428680419922;
	setAttr ".tgi[0].ni[15].y" 141.42857360839844;
	setAttr ".tgi[0].ni[15].nvs" 1923;
	setAttr ".tgi[0].ni[16].x" -115.71428680419922;
	setAttr ".tgi[0].ni[16].y" -164.28572082519531;
	setAttr ".tgi[0].ni[16].nvs" 1923;
	setAttr ".tgi[0].ni[17].x" -422.85714721679688;
	setAttr ".tgi[0].ni[17].y" -164.28572082519531;
	setAttr ".tgi[0].ni[17].nvs" 1923;
	setAttr ".tgi[0].ni[18].x" -422.85714721679688;
	setAttr ".tgi[0].ni[18].y" -465.71429443359375;
	setAttr ".tgi[0].ni[18].nvs" 1923;
	setAttr ".tgi[0].ni[19].x" -438.57144165039063;
	setAttr ".tgi[0].ni[19].y" -164.28572082519531;
	setAttr ".tgi[0].ni[19].nvs" 1923;
	setAttr ".tgi[0].ni[20].x" -115.71428680419922;
	setAttr ".tgi[0].ni[20].y" -465.71429443359375;
	setAttr ".tgi[0].ni[20].nvs" 1923;
	setAttr ".tgi[0].ni[21].x" -438.57144165039063;
	setAttr ".tgi[0].ni[21].y" -160;
	setAttr ".tgi[0].ni[21].nvs" 1923;
	setAttr ".tgi[0].ni[22].x" -438.57144165039063;
	setAttr ".tgi[0].ni[22].y" -164.28572082519531;
	setAttr ".tgi[0].ni[22].nvs" 1923;
	setAttr ".tgi[0].ni[23].x" -131.42857360839844;
	setAttr ".tgi[0].ni[23].y" -164.28572082519531;
	setAttr ".tgi[0].ni[23].nvs" 1923;
createNode polyCube -n "polyCube1";
	rename -uid "27FE5672-4F53-15CC-949F-5C9F97479868";
	setAttr ".cuv" 4;
createNode polySubdFace -n "polySubdFace1";
	rename -uid "70819B2E-45C0-AFFD-A902-3DB2A587BDAA";
	setAttr ".ics" -type "componentList" 1 "f[*]";
	setAttr ".duv" 2;
	setAttr ".sbm" 1;
createNode polyExtrudeFace -n "polyExtrudeFace1";
	rename -uid "32AE2439-48CE-5AC8-C59B-9984C0798151";
	setAttr ".ics" -type "componentList" 1 "f[1]";
	setAttr ".ix" -type "matrix" 1 0 0 0 0 0.13509696428535561 0 0 0 0 1 0 0 0 0 1;
	setAttr ".ws" yes;
	setAttr ".pvt" -type "float3" -0.41142118 0.067548484 0 ;
	setAttr ".rs" 51936;
	setAttr ".c[0]"  0 1 1;
	setAttr ".cbn" -type "double3" -0.5 0.067548482142677807 -0.5 ;
	setAttr ".cbx" -type "double3" -0.32284238934516907 0.067548482142677807 0.5 ;
	setAttr ".raf" no;
createNode polyTweak -n "polyTweak1";
	rename -uid "78335209-4B9F-C9C7-2655-23A31EAAC815";
	setAttr ".uopa" yes;
	setAttr -s 6 ".tk";
	setAttr ".tk[8]" -type "float3" -0.32284239 0 0 ;
	setAttr ".tk[9]" -type "float3" -0.32284239 0 0 ;
	setAttr ".tk[10]" -type "float3" -0.32284239 0 0 ;
	setAttr ".tk[11]" -type "float3" -0.32284239 0 0 ;
createNode polyExtrudeFace -n "polyExtrudeFace2";
	rename -uid "AA851749-4CD1-65D0-F771-809FFEFD0E1C";
	setAttr ".ics" -type "componentList" 1 "f[1]";
	setAttr ".ix" -type "matrix" 1 0 0 0 0 0.13509696428535561 0 0 0 0 1 0 0 0 0 1;
	setAttr ".ws" yes;
	setAttr ".pvt" -type "float3" -0.41142118 0.19388069 0 ;
	setAttr ".rs" 40574;
	setAttr ".c[0]"  0 1 1;
	setAttr ".cbn" -type "double3" -0.5 0.19388069176707565 -0.5 ;
	setAttr ".cbx" -type "double3" -0.32284238934516907 0.19388069176707565 0.5 ;
	setAttr ".raf" no;
createNode polyTweak -n "polyTweak2";
	rename -uid "FC9D890E-4A33-EF2D-F9D5-A7B05EEF1C5A";
	setAttr ".uopa" yes;
	setAttr -s 5 ".tk";
	setAttr ".tk[12]" -type "float3" 0 0.93512249 0 ;
	setAttr ".tk[13]" -type "float3" 0 0.93512249 0 ;
	setAttr ".tk[14]" -type "float3" 0 0.93512249 0 ;
	setAttr ".tk[15]" -type "float3" 0 0.93512249 0 ;
createNode polyExtrudeFace -n "polyExtrudeFace3";
	rename -uid "7D1FBFC9-4F16-1842-6CB9-B8B19F6D1E53";
	setAttr ".ics" -type "componentList" 1 "f[1]";
	setAttr ".ix" -type "matrix" 1 0 0 0 0 0.13509696428535561 0 0 0 0 1 0 0 0 0 1;
	setAttr ".ws" yes;
	setAttr ".pvt" -type "float3" -0.41142118 1.2210166 1.0297979 ;
	setAttr ".rs" 46849;
	setAttr ".c[0]"  0 1 1;
	setAttr ".cbn" -type "double3" -0.5 1.2210166847213617 0.52979791164398193 ;
	setAttr ".cbx" -type "double3" -0.32284238934516907 1.2210166847213617 1.5297979116439819 ;
	setAttr ".raf" no;
createNode polyTweak -n "polyTweak3";
	rename -uid "DA43447D-4E77-DE94-EE9F-C8A835C194D1";
	setAttr ".uopa" yes;
	setAttr -s 5 ".tk";
	setAttr ".tk[16]" -type "float3" 0 7.6029534 1.0297979 ;
	setAttr ".tk[17]" -type "float3" 0 7.6029534 1.0297979 ;
	setAttr ".tk[18]" -type "float3" 0 7.6029534 1.0297979 ;
	setAttr ".tk[19]" -type "float3" 0 7.6029534 1.0297979 ;
createNode polyExtrudeFace -n "polyExtrudeFace4";
	rename -uid "C0F1D41C-4EDC-F4C9-E8BD-2BAD8BC28FAA";
	setAttr ".ics" -type "componentList" 1 "f[1]";
	setAttr ".ix" -type "matrix" 1 0 0 0 0 0.13509696428535561 0 0 0 0 1 0 0 0 0 1;
	setAttr ".ws" yes;
	setAttr ".pvt" -type "float3" -0.41142118 2.3833957 1.0297979 ;
	setAttr ".rs" 34837;
	setAttr ".c[0]"  0 1 1;
	setAttr ".cbn" -type "double3" -0.5 2.38339561598724 0.52979791164398193 ;
	setAttr ".cbx" -type "double3" -0.32284238934516907 2.38339561598724 1.5297979116439819 ;
	setAttr ".raf" no;
createNode polyTweak -n "polyTweak4";
	rename -uid "BACC2F9E-4526-A07B-9464-17BE07D65D70";
	setAttr ".uopa" yes;
	setAttr -s 5 ".tk";
	setAttr ".tk[20]" -type "float3" 0 8.6040335 0 ;
	setAttr ".tk[21]" -type "float3" 0 8.6040335 0 ;
	setAttr ".tk[22]" -type "float3" 0 8.6040335 0 ;
	setAttr ".tk[23]" -type "float3" 0 8.6040335 0 ;
createNode polyExtrudeFace -n "polyExtrudeFace5";
	rename -uid "E7BACEFD-468D-2B20-4D72-7A83B8B3A1A5";
	setAttr ".ics" -type "componentList" 1 "f[23]";
	setAttr ".ix" -type "matrix" 1 0 0 0 0 0.13509696428535561 0 0 0 0 1 0 0 0 0 1;
	setAttr ".ws" yes;
	setAttr ".pvt" -type "float3" -0.32284239 2.469583 1.0297979 ;
	setAttr ".rs" 39175;
	setAttr ".c[0]"  0 1 1;
	setAttr ".cbn" -type "double3" -0.32284238934516907 2.38339561598724 0.52979791164398193 ;
	setAttr ".cbx" -type "double3" -0.32284238934516907 2.5557704556506287 1.5297979116439819 ;
	setAttr ".raf" no;
createNode polyTweak -n "polyTweak5";
	rename -uid "EDE70A3F-4FF0-27F5-6001-D890E823ADDF";
	setAttr ".uopa" yes;
	setAttr -s 6 ".tk";
	setAttr ".tk[24]" -type "float3" 0 1.2759336 0 ;
	setAttr ".tk[25]" -type "float3" 0 1.2759336 0 ;
	setAttr ".tk[26]" -type "float3" 0 1.2759336 0 ;
	setAttr ".tk[27]" -type "float3" 0 1.2759336 0 ;
createNode polySubdFace -n "polySubdFace2";
	rename -uid "D0B7AC37-49BB-7789-541D-20BCDFD86F7D";
	setAttr ".ics" -type "componentList" 1 "f[26:29]";
	setAttr ".dvv" 2;
	setAttr ".sbm" 1;
createNode polyTweak -n "polyTweak6";
	rename -uid "9FADFD0C-492B-81C0-B73C-6DA0531DD8C3";
	setAttr ".uopa" yes;
	setAttr -s 10 ".tk";
	setAttr ".tk[16]" -type "float3" -0.1623874 1.7763568e-15 0 ;
	setAttr ".tk[17]" -type "float3" -0.1623874 1.7763568e-15 0 ;
	setAttr ".tk[18]" -type "float3" -0.1623874 1.7763568e-15 0 ;
	setAttr ".tk[19]" -type "float3" -0.1623874 1.7763568e-15 0 ;
	setAttr ".tk[28]" -type "float3" 0.88745201 7.1054274e-15 0 ;
	setAttr ".tk[29]" -type "float3" 0.88745201 7.1054274e-15 0 ;
	setAttr ".tk[30]" -type "float3" 0.88745201 7.1054274e-15 0 ;
	setAttr ".tk[31]" -type "float3" 0.88745201 7.1054274e-15 0 ;
createNode polyDelEdge -n "polyDelEdge1";
	rename -uid "4730FCC5-4567-4733-D5D6-E2AFAA28A56E";
	setAttr ".ics" -type "componentList" 1 "e[65]";
	setAttr ".cv" yes;
createNode polySplit -n "polySplit1";
	rename -uid "45B9F116-43BC-C378-FC6E-E38436ECFEC6";
	setAttr -s 2 ".e[0:1]"  0 1;
	setAttr -s 2 ".d[0:1]"  -2147483587 -2147483596;
	setAttr ".sma" 180;
	setAttr ".m2015" yes;
createNode polyExtrudeFace -n "polyExtrudeFace6";
	rename -uid "6468078D-485E-5709-651F-98AAA962BD6E";
	setAttr ".ics" -type "componentList" 1 "f[32]";
	setAttr ".ix" -type "matrix" 1.2446111220701241 0 0 0 0 0.16814318430746406 0 0 0 0 1.2446111220701241 0
		 0 0 0 1;
	setAttr ".ws" yes;
	setAttr ".pvt" -type "float3" 0.58800608 2.9664006 1.281698 ;
	setAttr ".rs" 47720;
	setAttr ".c[0]"  0 1 1;
	setAttr ".cbn" -type "double3" 0.47329265359878359 2.9664006919508958 0.65939237328162481 ;
	setAttr ".cbx" -type "double3" 0.70271944603185488 2.9664006919508958 1.9040034953517491 ;
	setAttr ".raf" no;
createNode polyTweak -n "polyTweak7";
	rename -uid "08B54DCC-485F-EC73-FE15-29A08FFA1087";
	setAttr ".uopa" yes;
	setAttr -s 11 ".tk";
	setAttr ".tk[16]" -type "float3" 0.16204908 1.7763568e-15 0 ;
	setAttr ".tk[17]" -type "float3" 0.16204908 1.7763568e-15 0 ;
	setAttr ".tk[18]" -type "float3" 0.16204908 1.7763568e-15 0 ;
	setAttr ".tk[19]" -type "float3" 0.16204908 1.7763568e-15 0 ;
	setAttr ".tk[33]" -type "float3" 0.25938991 0 0 ;
	setAttr ".tk[34]" -type "float3" 0.25938991 0 0 ;
	setAttr ".tk[35]" -type "float3" 0.25938991 0 0 ;
	setAttr ".tk[36]" -type "float3" 0.25938991 0 0 ;
createNode polyExtrudeFace -n "polyExtrudeFace7";
	rename -uid "50A23A19-418E-80FD-03EC-D0ABCF2EE010";
	setAttr ".ics" -type "componentList" 5 "f[0]" "f[2]" "f[4:5]" "f[7]" "f[9]";
	setAttr ".ix" -type "matrix" 1.2446111220701241 0 0 0 0 0.16814318430746406 0 0 0 0 1.2446111220701241 0
		 0 0 0 1;
	setAttr ".ws" yes;
	setAttr ".rs" 39049;
	setAttr ".c[0]"  0 1 1;
	setAttr ".cbn" -type "double3" -0.62230556103506207 -0.084071592153732028 -0.62230556103506207 ;
	setAttr ".cbx" -type "double3" 0.62230556103506207 0.084071592153732028 0.62230556103506207 ;
	setAttr ".raf" no;
createNode polyTweak -n "polyTweak8";
	rename -uid "8205BCBE-4203-7EA1-EF50-50AA7EEBF919";
	setAttr ".uopa" yes;
	setAttr -s 7 ".tk";
	setAttr ".tk[37]" -type "float3" 0 -4.8714561 0 ;
	setAttr ".tk[38]" -type "float3" 0 -4.8714561 0 ;
	setAttr ".tk[39]" -type "float3" 0 -4.8714561 0 ;
	setAttr ".tk[40]" -type "float3" 0 -4.8714561 0 ;
createNode polyExtrudeFace -n "polyExtrudeFace8";
	rename -uid "B8F0ACC5-4E8A-0134-BBB6-70B0508BDE90";
	setAttr ".ics" -type "componentList" 2 "f[1]" "f[14:37]";
	setAttr ".ix" -type "matrix" 1.2446111220701241 0 0 0 0 0.16814318430746406 0 0 0 0 1.2446111220701241 0
		 0 0 0 1;
	setAttr ".ws" yes;
	setAttr ".pvt" -type "float3" 0.039996445 1.7111233 0.64084899 ;
	setAttr ".rs" 40036;
	setAttr ".c[0]"  0 1 1;
	setAttr ".cbn" -type "double3" -0.62272663284631313 0.24130608537218162 -0.62230556103506207 ;
	setAttr ".cbx" -type "double3" 0.70271952021645867 3.1809406552686763 1.9040034953517491 ;
	setAttr ".raf" no;
createNode polyTweak -n "polyTweak9";
	rename -uid "0E47A574-43E1-87E9-3741-689C4E816167";
	setAttr ".uopa" yes;
	setAttr -s 40 ".tk";
	setAttr ".tk[28]" -type "float3" 5.9604645e-08 0 0 ;
	setAttr ".tk[29]" -type "float3" 5.9604645e-08 0 0 ;
	setAttr ".tk[30]" -type "float3" 5.9604645e-08 0 0 ;
	setAttr ".tk[31]" -type "float3" 5.9604645e-08 0 0 ;
	setAttr ".tk[32]" -type "float3" 5.9604645e-08 0 0 ;
	setAttr ".tk[33]" -type "float3" 5.9604645e-08 0 0 ;
	setAttr ".tk[34]" -type "float3" 5.9604645e-08 0 0 ;
	setAttr ".tk[35]" -type "float3" 5.9604645e-08 0 0 ;
	setAttr ".tk[36]" -type "float3" 5.9604645e-08 0 0 ;
	setAttr ".tk[37]" -type "float3" 5.9604645e-08 0 0 ;
	setAttr ".tk[38]" -type "float3" 5.9604645e-08 0 0 ;
	setAttr ".tk[39]" -type "float3" 5.9604645e-08 0 0 ;
	setAttr ".tk[40]" -type "float3" 5.9604645e-08 0 0 ;
	setAttr ".tk[41]" -type "float3" -0.27648193 0 0.37065643 ;
	setAttr ".tk[42]" -type "float3" -0.00028209412 0 0.37065643 ;
	setAttr ".tk[43]" -type "float3" -0.00028209412 0 0.37065643 ;
	setAttr ".tk[44]" -type "float3" -0.27648193 0 0.37065643 ;
	setAttr ".tk[45]" -type "float3" -0.27648193 0 -0.37065643 ;
	setAttr ".tk[46]" -type "float3" -0.00028209412 0 -0.37065643 ;
	setAttr ".tk[47]" -type "float3" -0.00028209412 0 -0.37065643 ;
	setAttr ".tk[48]" -type "float3" -0.27648193 0 -0.37065643 ;
	setAttr ".tk[49]" -type "float3" 0.27648193 0 -0.37065643 ;
	setAttr ".tk[50]" -type "float3" 0.27648193 0 0.37065643 ;
	setAttr ".tk[51]" -type "float3" 0.27648193 0 -0.37065643 ;
	setAttr ".tk[52]" -type "float3" 0.27648193 0 0.37065643 ;
createNode polyTweak -n "polyTweak10";
	rename -uid "27534828-40C3-6B58-332C-00816574641D";
	setAttr ".uopa" yes;
	setAttr -s 30 ".tk";
	setAttr ".tk[28]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[29]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[30]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[31]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[32]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[33]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[34]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[35]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[36]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[37]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[38]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[39]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[40]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[41]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[42]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[43]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[44]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[45]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[46]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[47]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[48]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[49]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[50]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[51]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[52]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[53]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[54]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[55]" -type "float3" 0 2.5830371 0 ;
	setAttr ".tk[56]" -type "float3" 0 2.5830371 0 ;
createNode deleteComponent -n "deleteComponent1";
	rename -uid "96860140-455D-C2D4-8409-A6A3ED698B71";
	setAttr ".dc" -type "componentList" 1 "f[50:53]";
createNode polyCloseBorder -n "polyCloseBorder1";
	rename -uid "8E6EF879-403E-1455-038A-909788378252";
	setAttr ".ics" -type "componentList" 3 "e[16]" "e[18]" "e[20:21]";
createNode polyExtrudeFace -n "polyExtrudeFace9";
	rename -uid "9FEF585A-4DC2-1404-1AEB-C5B2B3A822DD";
	setAttr ".ics" -type "componentList" 1 "f[50]";
	setAttr ".ix" -type "matrix" 1.2446111220701241 0 0 0 0 0.16814318430746406 0 0 0 0 1.2446111220701241 0
		 0 0 0 1;
	setAttr ".ws" yes;
	setAttr ".pvt" -type "float3" -0.51205939 0.24130608 0 ;
	setAttr ".rs" 55828;
	setAttr ".c[0]"  0 1 1;
	setAttr ".cbn" -type "double3" -0.62230556103506207 0.24130608537218162 -0.62230556103506207 ;
	setAttr ".cbx" -type "double3" -0.40181322845469075 0.24130608537218162 0.62230556103506207 ;
	setAttr ".raf" no;
createNode polyExtrudeFace -n "polyExtrudeFace10";
	rename -uid "4F6B714F-464A-B05A-307B-1190AD0BCD17";
	setAttr ".ics" -type "componentList" 1 "f[53]";
	setAttr ".ix" -type "matrix" 1.2446111220701241 0 0 0 0 0.16814318430746406 0 0 0 0 1.2446111220701241 0
		 0 0 0 1;
	setAttr ".ws" yes;
	setAttr ".pvt" -type "float3" -0.62230557 0.33107516 0 ;
	setAttr ".rs" 38756;
	setAttr ".c[0]"  0 1 1;
	setAttr ".cbn" -type "double3" -0.62230556103506207 0.24130608537218162 -0.62230556103506207 ;
	setAttr ".cbx" -type "double3" -0.62230556103506207 0.42084423377739999 0.62230556103506207 ;
	setAttr ".raf" no;
createNode polyTweak -n "polyTweak11";
	rename -uid "AB81556A-4F6C-C5F4-11BD-FA9CD85194CE";
	setAttr ".uopa" yes;
	setAttr -s 8 ".tk";
	setAttr ".tk[12]" -type "float3" 0 2.9802322e-08 0 ;
	setAttr ".tk[13]" -type "float3" 0 2.9802322e-08 0 ;
	setAttr ".tk[14]" -type "float3" 0 2.9802322e-08 0 ;
	setAttr ".tk[15]" -type "float3" 0 2.9802322e-08 0 ;
	setAttr ".tk[57]" -type "float3" 0 1.0677695 0 ;
	setAttr ".tk[58]" -type "float3" 0 1.0677695 0 ;
	setAttr ".tk[59]" -type "float3" 0 1.0677695 0 ;
	setAttr ".tk[60]" -type "float3" 0 1.0677695 0 ;
createNode polyExtrudeFace -n "polyExtrudeFace11";
	rename -uid "EB7E9A2D-47DD-173F-A29F-94AC5DC37019";
	setAttr ".ics" -type "componentList" 1 "f[53]";
	setAttr ".ix" -type "matrix" 1.2446111220701241 0 0 0 0 0.16814318430746406 0 0 0 0 1.2446111220701241 0
		 0 0 0 1;
	setAttr ".ws" yes;
	setAttr ".pvt" -type "float3" -1.0506239 0.33107516 0 ;
	setAttr ".rs" 37119;
	setAttr ".c[0]"  0 1 1;
	setAttr ".cbn" -type "double3" -1.0506238727559147 0.24130608537218162 -0.62230556103506207 ;
	setAttr ".cbx" -type "double3" -1.0506238727559147 0.42084423377739999 0.62230556103506207 ;
	setAttr ".raf" no;
createNode polyTweak -n "polyTweak12";
	rename -uid "24F902D9-4DF2-EAD9-D8A3-4C96B037C49D";
	setAttr ".uopa" yes;
	setAttr -s 5 ".tk";
	setAttr ".tk[61]" -type "float3" -0.34413829 -6.6613381e-16 0 ;
	setAttr ".tk[62]" -type "float3" -0.34413829 -6.6613381e-16 0 ;
	setAttr ".tk[63]" -type "float3" -0.34413829 -4.4408921e-16 0 ;
	setAttr ".tk[64]" -type "float3" -0.34413829 -4.4408921e-16 0 ;
createNode polyTweakUV -n "polyTweakUV1";
	rename -uid "EE73E2B9-4B68-3DFC-85B4-3AAD3D0B4DD1";
	setAttr ".uopa" yes;
	setAttr -s 3 ".uvtk";
	setAttr ".uvtk[3]" -type "float2" -0.067570649 0.033399705 ;
	setAttr ".uvtk[16]" -type "float2" 0.034027491 0.027902802 ;
createNode polyMergeVert -n "polyMergeVert1";
	rename -uid "A9FF7B9D-4F46-AAD2-D246-5FB5092F66F2";
	setAttr ".ics" -type "componentList" 2 "vtx[3]" "vtx[10]";
	setAttr ".ix" -type "matrix" 1.2446111220701241 0 0 0 0 0.16814318430746406 0 0 0 0 1.2446111220701241 0
		 0 0 0 1;
	setAttr ".d" 1e-06;
createNode polyTweak -n "polyTweak13";
	rename -uid "E3F239C3-4CB4-EF23-090D-55B30C439DB3";
	setAttr ".uopa" yes;
	setAttr -s 51 ".tk";
	setAttr ".tk[3]" -type "float3" -0.011738211 0 0 ;
	setAttr ".tk[8]" -type "float3" 0.81110418 -6.6613381e-16 0 ;
	setAttr ".tk[9]" -type "float3" 0.81110418 -6.6613381e-16 0 ;
	setAttr ".tk[10]" -type "float3" 0.81110418 -6.6613381e-16 0 ;
	setAttr ".tk[11]" -type "float3" 0.81110418 -6.6613381e-16 0 ;
	setAttr ".tk[13]" -type "float3" 0.81110418 -4.4408921e-16 0 ;
	setAttr ".tk[14]" -type "float3" 0.81110418 -4.4408921e-16 0 ;
	setAttr ".tk[17]" -type "float3" 0.81110418 -6.6613381e-16 0 ;
	setAttr ".tk[18]" -type "float3" 0.81110418 -6.6613381e-16 0 ;
	setAttr ".tk[21]" -type "float3" 0.81110418 -6.6613381e-16 0 ;
	setAttr ".tk[22]" -type "float3" 0.81110418 -6.6613381e-16 0 ;
	setAttr ".tk[28]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[29]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[30]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[31]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[32]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[33]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[34]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[35]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[36]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[37]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[38]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[39]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[40]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[41]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[42]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[43]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[44]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[45]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[46]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[47]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[48]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[49]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[50]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[51]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[52]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[53]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[54]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[55]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[56]" -type "float3" -0.51771581 -1.4559805 0 ;
	setAttr ".tk[57]" -type "float3" 0.81110418 -8.8817842e-16 0 ;
	setAttr ".tk[58]" -type "float3" 0.81110418 -8.8817842e-16 0 ;
	setAttr ".tk[61]" -type "float3" 0.003727457 6.6613381e-16 0 ;
	setAttr ".tk[62]" -type "float3" 0.003727457 6.6613381e-16 0 ;
	setAttr ".tk[63]" -type "float3" 0.003727457 8.8817842e-16 0 ;
	setAttr ".tk[64]" -type "float3" 0.003727457 8.8817842e-16 0 ;
	setAttr ".tk[65]" -type "float3" -0.17384557 -1.3322676e-15 0 ;
	setAttr ".tk[66]" -type "float3" -0.17384557 -1.3322676e-15 0 ;
	setAttr ".tk[67]" -type "float3" -0.17384557 -1.3322676e-15 0 ;
	setAttr ".tk[68]" -type "float3" -0.17384557 -1.3322676e-15 0 ;
createNode polyTweakUV -n "polyTweakUV2";
	rename -uid "B972E03F-42E0-D688-9B50-D197A8BF1910";
	setAttr ".uopa" yes;
	setAttr -s 4 ".uvtk";
	setAttr ".uvtk[5]" -type "float2" -0.079766452 -0.016992757 ;
	setAttr ".uvtk[11]" -type "float2" -0.072340533 0.012158749 ;
	setAttr ".uvtk[15]" -type "float2" 0.034278929 -0.0236708 ;
createNode polyMergeVert -n "polyMergeVert2";
	rename -uid "7C3DB26F-42A2-88E5-1F02-47B4CDB32DDE";
	setAttr ".ics" -type "componentList" 2 "vtx[5]" "vtx[9]";
	setAttr ".ix" -type "matrix" 1.2446111220701241 0 0 0 0 0.16814318430746406 0 0 0 0 1.2446111220701241 0
		 0 0 0 1;
	setAttr ".d" 1e-06;
createNode polyTweak -n "polyTweak14";
	rename -uid "FC1AD665-42AB-B3DF-5FE9-6F89AEECABE4";
	setAttr ".uopa" yes;
	setAttr -s 2 ".tk";
	setAttr ".tk[5]" -type "float3" -0.011738211 0 0 ;
createNode polyTweakUV -n "polyTweakUV3";
	rename -uid "6AE1A94C-4C6C-FCC3-38A5-EEB4BE87F268";
	setAttr ".uopa" yes;
	setAttr -s 8 ".uvtk";
	setAttr ".uvtk[1]" -type "float2" -0.026682822 0 ;
	setAttr ".uvtk[7]" -type "float2" -0.081407756 0.020266306 ;
	setAttr ".uvtk[9]" -type "float2" -0.098715819 -1.2498748e-05 ;
	setAttr ".uvtk[10]" -type "float2" -0.051479615 0 ;
	setAttr ".uvtk[14]" -type "float2" 0.03723881 0.030564304 ;
	setAttr ".uvtk[15]" -type "float2" 0.035696756 0 ;
	setAttr ".uvtk[16]" -type "float2" 0.04132491 -6.2496874e-06 ;
createNode polyMergeVert -n "polyMergeVert3";
	rename -uid "E05D2BE5-421F-D8D1-726D-1FBE23342B18";
	setAttr ".ics" -type "componentList" 1 "vtx[7:8]";
	setAttr ".ix" -type "matrix" 1.2446111220701241 0 0 0 0 0.16814318430746406 0 0 0 0 1.2446111220701241 0
		 0 0 0 1;
	setAttr ".d" 1e-06;
createNode polyTweak -n "polyTweak15";
	rename -uid "730765C6-470E-1B51-A92E-93AD38142317";
	setAttr ".uopa" yes;
	setAttr -s 4 ".tk";
	setAttr ".tk[1]" -type "float3" -0.011738211 0 0 ;
	setAttr ".tk[7]" -type "float3" -0.011738211 0 0 ;
createNode polyDelEdge -n "polyDelEdge2";
	rename -uid "AF222E83-4FAE-07B3-71D4-D39A2CFC05B8";
	setAttr ".ics" -type "componentList" 4 "e[19]" "e[21:22]" "e[27]" "e[29:30]";
	setAttr ".cv" yes;
createNode polyTweak -n "polyTweak16";
	rename -uid "C58B4442-4A44-050E-FE83-C4ACBB414C0D";
	setAttr ".uopa" yes;
	setAttr -s 46 ".tk";
	setAttr ".tk[9]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[10]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[11]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[12]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[21]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[22]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[23]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[24]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[25]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[26]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[27]" -type "float3" 0 3.0347793 0 ;
	setAttr ".tk[28]" -type "float3" 0 3.0347793 0 ;
	setAttr ".tk[29]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[30]" -type "float3" 0 3.0347793 0 ;
	setAttr ".tk[31]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[32]" -type "float3" 0 3.0347793 0 ;
	setAttr ".tk[33]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[34]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[35]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[36]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[37]" -type "float3" 1.0285288 3.0347798 0 ;
	setAttr ".tk[38]" -type "float3" 1.0285288 3.0347798 0 ;
	setAttr ".tk[39]" -type "float3" 1.0285288 3.0347798 0 ;
	setAttr ".tk[40]" -type "float3" 1.0285288 3.0347798 0 ;
	setAttr ".tk[41]" -type "float3" 1.0285288 3.0347798 0 ;
	setAttr ".tk[42]" -type "float3" 1.0285288 3.0347798 0 ;
	setAttr ".tk[43]" -type "float3" 1.0285288 3.0347798 0 ;
	setAttr ".tk[44]" -type "float3" 1.0285288 3.0347798 0 ;
	setAttr ".tk[45]" -type "float3" 1.0285288 3.0347798 0 ;
	setAttr ".tk[46]" -type "float3" 1.0285288 -0.72663641 0 ;
	setAttr ".tk[47]" -type "float3" 1.0285288 -0.72663641 0 ;
	setAttr ".tk[48]" -type "float3" 1.0285288 -0.72663641 0 ;
	setAttr ".tk[49]" -type "float3" 1.0285288 -0.72663641 0 ;
	setAttr ".tk[50]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[51]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[52]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[53]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[54]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[55]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[56]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[57]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[58]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[59]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[60]" -type "float3" 0 3.0347798 0 ;
	setAttr ".tk[61]" -type "float3" 0 3.0347798 0 ;
createNode deleteComponent -n "deleteComponent2";
	rename -uid "D568DBAC-4695-25FC-B56C-F6BB9534922A";
	setAttr ".dc" -type "componentList" 1 "f[54]";
createNode polyTweakUV -n "polyTweakUV4";
	rename -uid "72E3EF11-46E3-8DB9-1707-B88C7A5B792F";
	setAttr ".uopa" yes;
	setAttr -s 3 ".uvtk";
	setAttr ".uvtk[59]" -type "float2" 3.325182e-06 -0.0020136787 ;
	setAttr ".uvtk[68]" -type "float2" -5.1625371e-15 -3.735242e-06 ;
createNode polyMergeVert -n "polyMergeVert4";
	rename -uid "FAE1655F-46C6-8523-3364-97A96FB20549";
	setAttr ".ics" -type "componentList" 2 "vtx[29]" "vtx[57]";
	setAttr ".ix" -type "matrix" 1.2446111220701241 0 0 0 0 0.16814318430746406 0 0 0 0 1.2446111220701241 0
		 0 0 0 1;
	setAttr ".d" 1e-06;
createNode polyTweak -n "polyTweak17";
	rename -uid "04C233BE-44EB-CDE7-7374-10825EA87CAF";
	setAttr ".uopa" yes;
	setAttr -s 2 ".tk";
	setAttr ".tk[29]" -type "float3" 0.00014734268 -0.059287548 0 ;
createNode polyTweakUV -n "polyTweakUV5";
	rename -uid "88F0C01E-43E2-7F1A-F3CD-DEA0A7060D21";
	setAttr ".uopa" yes;
	setAttr -s 3 ".uvtk";
	setAttr ".uvtk[60]" -type "float2" -0.0001043303 -0.0020144731 ;
	setAttr ".uvtk[72]" -type "float2" 1.9151347e-14 -6.7117026e-06 ;
createNode polyMergeVert -n "polyMergeVert5";
	rename -uid "DEB56109-4DE2-8C45-DD9A-01960D67F3EF";
	setAttr ".ics" -type "componentList" 2 "vtx[31]" "vtx[60]";
	setAttr ".ix" -type "matrix" 1.2446111220701241 0 0 0 0 0.16814318430746406 0 0 0 0 1.2446111220701241 0
		 0 0 0 1;
	setAttr ".d" 1e-06;
createNode polyTweak -n "polyTweak18";
	rename -uid "82384334-4E87-974A-89F2-07A092EAF90A";
	setAttr ".uopa" yes;
	setAttr -s 2 ".tk";
	setAttr ".tk[31]" -type "float3" -0.00026798248 -0.059287548 0 ;
createNode polyTweakUV -n "polyTweakUV6";
	rename -uid "9290F2F2-4A14-2E8A-E823-0483AB2106F0";
	setAttr ".uopa" yes;
	setAttr -s 3 ".uvtk";
	setAttr ".uvtk[58]" -type "float2" -1.0465043e-05 -0.0020016781 ;
	setAttr ".uvtk[67]" -type "float2" -5.1625371e-15 3.6085603e-06 ;
createNode polyMergeVert -n "polyMergeVert6";
	rename -uid "AEC93C70-413A-EB07-F4CB-858C5C62BF1D";
	setAttr ".ics" -type "componentList" 2 "vtx[26]" "vtx[56]";
	setAttr ".ix" -type "matrix" 1.2446111220701241 0 0 0 0 0.16814318430746406 0 0 0 0 1.2446111220701241 0
		 0 0 0 1;
	setAttr ".d" 1e-06;
createNode polyTweak -n "polyTweak19";
	rename -uid "589C3414-4D0C-3C1B-2500-E4BAFE2D3859";
	setAttr ".uopa" yes;
	setAttr -s 2 ".tk";
	setAttr ".tk[26]" -type "float3" 0.00014734268 -0.059287548 0 ;
createNode polyTweakUV -n "polyTweakUV7";
	rename -uid "2C8F6FB6-485A-4F82-510B-44BFAD94E215";
	setAttr ".uopa" yes;
	setAttr -s 3 ".uvtk";
	setAttr ".uvtk[57]" -type "float2" -9.3334726e-05 -0.0020010364 ;
	setAttr ".uvtk[71]" -type "float2" 1.9151347e-14 5.8585174e-06 ;
createNode polyMergeVert -n "polyMergeVert7";
	rename -uid "556AA6FA-489F-D125-E1DF-84B46480A139";
	setAttr ".ics" -type "componentList" 2 "vtx[25]" "vtx[58]";
	setAttr ".ix" -type "matrix" 1.2446111220701241 0 0 0 0 0.16814318430746406 0 0 0 0 1.2446111220701241 0
		 0 0 0 1;
	setAttr ".d" 1e-06;
createNode polyTweak -n "polyTweak20";
	rename -uid "8D87316B-4C54-3954-F98B-15A36E0A8CFF";
	setAttr ".uopa" yes;
	setAttr -s 2 ".tk";
	setAttr ".tk[25]" -type "float3" -0.00026798248 -0.059287548 0 ;
createNode polyTweak -n "polyTweak21";
	rename -uid "CB631426-445E-BB20-2979-7B9CFDC69153";
	setAttr ".uopa" yes;
	setAttr -s 58 ".tk[0:57]" -type "float3"  0.12979981 0.010121921 -0.13134144
		 -0.12979972 0.010121921 -0.13134144 0.12979981 0.001061935 -0.13134144 -0.12979972
		 0.001061935 -0.13134144 0.12979981 0.001061935 0.13134144 -0.12979972 0.001061935
		 0.13134144 0.12979981 0.010121921 0.13134144 -0.12979972 0.010121921 0.13134144 -0.12979972
		 0.010121921 -0.13134144 0.12979978 -0.0010255445 -0.1313414 -0.12979977 -0.0010255445
		 -0.1313414 -0.12979977 -0.0010255445 0.1313414 0.12979978 -0.0010255445 0.1313414
		 -0.30818796 0.011084162 0.34556559 -0.30818796 -0.011084162 0.34556559 -0.30818796
		 -0.011084162 -0.34556559 -0.30818796 0.011084162 -0.34556559 0.30818796 0.011084162
		 -0.34556559 0.30818796 0.011084162 0.34556559 0.30818796 -0.011084162 -0.34556559
		 0.30818796 -0.011084162 0.34556559 0.30519944 -2.933146 -0.14738421 0.28795105 -2.933146
		 -0.14738421 0.28795105 -2.933146 0.1473842 0.30519944 -2.933146 0.1473842 0.30745065
		 -4.7683716e-07 -0.13333334 0.2896983 -4.7683716e-07 -0.13333334 0.28806359 0.00027861074
		 -0.14738421 0.30531174 0.00027861074 -0.14738421 0.2896983 -4.7683716e-07 0.13333334
		 0.28806359 0.00027861074 0.1473842 0.30745065 -4.7683716e-07 0.13333334 0.30531174
		 0.00027861074 0.1473842 0.28795105 -2.44772315 -0.14738421 0.30519944 -2.44772315
		 -0.14738421 0.28795105 -2.44772315 0.1473842 0.30519944 -2.44772315 0.1473842 -0.34675038
		 -2.44772315 -0.14738421 -0.34675038 -2.44772315 0.1473842 -0.34675038 -2.933146 0.1473842
		 -0.34675038 -2.933146 -0.14738421 -0.34675038 -2.58307838 -0.14738421 -0.28568563
		 -2.44772315 0.1473842 -0.28568563 -2.44772315 -0.14738421 -0.28568563 -2.933146 0.1473842
		 -0.28568563 -2.933146 -0.14738421 -0.28568563 0.016104328 0.1473842 -0.28568563 0.016104328
		 -0.14738421 -0.34675038 0.016104328 0.1473842 -0.34675038 0.016104328 -0.14738421
		 -0.12979977 -0.001587946 -0.1313414 -0.12979977 -0.001587946 0.1313414 0.12979978
		 -0.001587946 0.1313414 0.12979978 -0.001587946 -0.1313414 0.2896983 4.7683716e-07
		 -0.13333334 0.2896983 4.7683716e-07 0.13333334 0.30745065 4.7683716e-07 -0.13333334
		 0.30745065 4.7683716e-07 0.13333334;
createNode deleteComponent -n "deleteComponent3";
	rename -uid "9D7A2ED2-4954-97E4-AA20-3F835565DF52";
	setAttr ".dc" -type "componentList" 1 "vtx[41]";
createNode polyTweak -n "polyTweak22";
	rename -uid "6F7ED3A0-44A5-78C7-A605-8793FB054758";
	setAttr ".uopa" yes;
	setAttr -s 49 ".tk";
	setAttr ".tk[0]" -type "float3" 0.071015336 -0.0056571774 -0.071858838 ;
	setAttr ".tk[1]" -type "float3" -0.071015343 -0.0056571774 -0.071858838 ;
	setAttr ".tk[2]" -type "float3" 0.071015336 -0.0037965216 -0.071858838 ;
	setAttr ".tk[3]" -type "float3" -0.071015343 -0.0037965216 -0.071858838 ;
	setAttr ".tk[4]" -type "float3" 0.071015336 -0.0037965216 0.071858838 ;
	setAttr ".tk[5]" -type "float3" -0.071015343 -0.0037965216 0.071858838 ;
	setAttr ".tk[6]" -type "float3" 0.071015336 -0.0056571774 0.071858838 ;
	setAttr ".tk[7]" -type "float3" -0.071015343 -0.0056571774 0.071858838 ;
	setAttr ".tk[8]" -type "float3" -0.071015343 -0.0056571774 -0.071858838 ;
	setAttr ".tk[9]" -type "float3" 0.071015343 0.0036533736 -0.071858861 ;
	setAttr ".tk[10]" -type "float3" -0.071015336 0.0036533736 -0.071858861 ;
	setAttr ".tk[11]" -type "float3" -0.071015336 0.0036533736 0.071858861 ;
	setAttr ".tk[12]" -type "float3" 0.071015343 0.0036533736 0.071858861 ;
	setAttr ".tk[21]" -type "float3" 0.12246552 -3.5628526 -0.56668669 ;
	setAttr ".tk[22]" -type "float3" 0.10646528 -3.5628526 -0.56668669 ;
	setAttr ".tk[23]" -type "float3" 0.10646528 -3.5628526 -0.45698401 ;
	setAttr ".tk[24]" -type "float3" 0.12246552 -3.5628526 -0.45698401 ;
	setAttr ".tk[25]" -type "float3" 0.12206885 3.5527137e-15 -0.073333338 ;
	setAttr ".tk[26]" -type "float3" 0.10608634 0 -0.073333338 ;
	setAttr ".tk[27]" -type "float3" 0.10651042 -3.7994478 -0.56668669 ;
	setAttr ".tk[28]" -type "float3" 0.12251073 -3.7994478 -0.56668669 ;
	setAttr ".tk[29]" -type "float3" 0.10608634 0 0.073333338 ;
	setAttr ".tk[30]" -type "float3" 0.10651042 -3.7994478 -0.45698401 ;
	setAttr ".tk[31]" -type "float3" 0.12206885 3.5527137e-15 0.073333338 ;
	setAttr ".tk[32]" -type "float3" 0.12251073 -3.7994478 -0.45698401 ;
	setAttr ".tk[33]" -type "float3" 0.10646528 -3.7994478 -0.56668669 ;
	setAttr ".tk[34]" -type "float3" 0.12246552 -3.7994478 -0.56668669 ;
	setAttr ".tk[35]" -type "float3" 0.10646528 -3.7994478 -0.45698401 ;
	setAttr ".tk[36]" -type "float3" 0.12246552 -3.7994478 -0.45698401 ;
	setAttr ".tk[37]" -type "float3" -0.17500687 -3.7994478 -0.56668669 ;
	setAttr ".tk[38]" -type "float3" -0.17500687 -3.7994478 -0.45698401 ;
	setAttr ".tk[39]" -type "float3" -0.17500687 -3.5628526 -0.45698401 ;
	setAttr ".tk[40]" -type "float3" -0.17500687 -3.5628526 -0.56668669 ;
	setAttr ".tk[41]" -type "float3" -0.17032956 -3.7994478 -0.45698401 ;
	setAttr ".tk[42]" -type "float3" -0.17032956 -3.7994478 -0.56668669 ;
	setAttr ".tk[43]" -type "float3" -0.17032956 -3.5628526 -0.45698401 ;
	setAttr ".tk[44]" -type "float3" -0.17032956 -3.5628526 -0.56668669 ;
	setAttr ".tk[45]" -type "float3" -0.17032956 -3.7994478 -0.45698401 ;
	setAttr ".tk[46]" -type "float3" -0.17032956 -3.7994478 -0.56668669 ;
	setAttr ".tk[47]" -type "float3" -0.17500687 -3.7994478 -0.45698401 ;
	setAttr ".tk[48]" -type "float3" -0.17500687 -3.7994478 -0.56668669 ;
	setAttr ".tk[49]" -type "float3" -0.071015336 0.0056571774 -0.071858861 ;
	setAttr ".tk[50]" -type "float3" -0.071015336 0.0056571774 0.071858861 ;
	setAttr ".tk[51]" -type "float3" 0.071015343 0.0056571774 0.071858861 ;
	setAttr ".tk[52]" -type "float3" 0.071015343 0.0056571774 -0.071858861 ;
	setAttr ".tk[53]" -type "float3" 0.10608634 0 -0.073333338 ;
	setAttr ".tk[54]" -type "float3" 0.10608634 0 0.073333338 ;
	setAttr ".tk[55]" -type "float3" 0.12206885 3.5527137e-15 -0.073333338 ;
	setAttr ".tk[56]" -type "float3" 0.12206885 3.5527137e-15 0.073333338 ;
createNode deleteComponent -n "deleteComponent4";
	rename -uid "75E97D3E-42A6-8B0F-9272-CEA58B3EC107";
	setAttr ".dc" -type "componentList" 3 "f[0]" "f[2:10]" "f[35:42]";
createNode polyCloseBorder -n "polyCloseBorder2";
	rename -uid "FB477BEB-43CF-7F96-CD81-C0807FD35955";
	setAttr ".ics" -type "componentList" 1 "e[0:3]";
createNode polyCylinder -n "polyCylinder2";
	rename -uid "BE119283-4D88-0AF2-D511-DA8B207EBC69";
	setAttr ".sa" 12;
	setAttr ".sc" 1;
	setAttr ".cuv" 3;
createNode polyCube -n "polyCube3";
	rename -uid "1A5AFFB6-42EC-E51C-2A4C-8EB83486FD9E";
	setAttr ".cuv" 4;
createNode polyTweakUV -n "polyTweakUV8";
	rename -uid "F195CCCF-4586-2DCC-5CAC-0196873AAF34";
	setAttr ".uopa" yes;
	setAttr -s 5 ".uvtk";
	setAttr ".uvtk[5]" -type "float2" -6.8351073e-06 0.077837192 ;
	setAttr ".uvtk[7]" -type "float2" -5.823832e-06 -0.07134562 ;
	setAttr ".uvtk[10]" -type "float2" -1.249875e-05 0.015295162 ;
	setAttr ".uvtk[11]" -type "float2" -1.249875e-05 -0.23470484 ;
createNode polyMergeVert -n "polyMergeVert8";
	rename -uid "3C0752DF-43F0-546E-C7B4-BBB9DE5EC511";
	setAttr ".ics" -type "componentList" 2 "vtx[5]" "vtx[7]";
	setAttr ".ix" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 1.8083691537890398 0 0 1;
	setAttr ".d" 1e-06;
createNode polyTweak -n "polyTweak23";
	rename -uid "C8D6B260-4D40-9A73-90D1-05A7FFEC8F4A";
	setAttr ".uopa" yes;
	setAttr -s 3 ".tk";
	setAttr ".tk[3]" -type "float3" 0 -0.97321844 0 ;
	setAttr ".tk[5]" -type "float3" 0 -1 0 ;
createNode polyTweakUV -n "polyTweakUV9";
	rename -uid "BB6B2EFE-4FEC-F1B5-C642-DFB31680D72F";
	setAttr ".uopa" yes;
	setAttr -s 4 ".uvtk";
	setAttr ".uvtk[1]" -type "float2" 3.3385967e-07 0.12147306 ;
	setAttr ".uvtk[3]" -type "float2" 0.011750855 -0.11079992 ;
	setAttr ".uvtk[8]" -type "float2" -1.4078273e-05 -0.030451056 ;
createNode polyMergeVert -n "polyMergeVert9";
	rename -uid "CE3D958A-4168-DA8E-3651-CD9CD1FDF20E";
	setAttr ".ics" -type "componentList" 2 "vtx[1]" "vtx[3]";
	setAttr ".ix" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 1.8083691537890398 0 0 1;
	setAttr ".d" 1e-06;
createNode polyTweak -n "polyTweak24";
	rename -uid "272030DA-4878-9E64-FD84-A5AE517BE89E";
	setAttr ".uopa" yes;
	setAttr -s 2 ".tk";
	setAttr ".tk[3]" -type "float3" 0 -0.026781559 0 ;
createNode polyBevel3 -n "polyBevel1";
	rename -uid "375ADF3C-4BEB-68A2-5BB1-3389297CE18A";
	setAttr ".uopa" yes;
	setAttr ".ics" -type "componentList" 24 "e[0:4]" "e[6:7]" "e[9]" "e[11]" "e[13]" "e[16]" "e[20]" "e[22:23]" "e[25]" "e[29]" "e[31]" "e[33:34]" "e[36]" "e[38:39]" "e[41]" "e[43]" "e[46]" "e[49:58]" "e[60]" "e[63:65]" "e[67]" "e[69]" "e[71:72]" "e[74:75]";
	setAttr ".ix" -type "matrix" 1.2446111220701241 0 0 0 0 0.16814318430746406 0 0 0 0 1.2446111220701241 0
		 0 -0.03114639197878824 0 1;
	setAttr ".ws" yes;
	setAttr ".oaf" yes;
	setAttr ".f" 0.3;
	setAttr ".at" 180;
	setAttr ".sn" yes;
	setAttr ".mv" yes;
	setAttr ".mvt" 0.0001;
	setAttr ".sa" 30;
createNode polyTweak -n "polyTweak25";
	rename -uid "E9DEF668-46F3-8155-B625-0B9AD9CD6C87";
	setAttr ".uopa" yes;
	setAttr -s 33 ".tk";
	setAttr ".tk[4]" -type "float3" 0.0508238 0 0 ;
	setAttr ".tk[5]" -type "float3" 0.038031891 0 0 ;
	setAttr ".tk[6]" -type "float3" 0.038031891 0 0 ;
	setAttr ".tk[7]" -type "float3" 0.0508238 0 0 ;
	setAttr ".tk[8]" -type "float3" 0.050682776 0 0 ;
	setAttr ".tk[9]" -type "float3" 0.037897166 0 0 ;
	setAttr ".tk[10]" -type "float3" 0.038047943 0 0 ;
	setAttr ".tk[11]" -type "float3" 0.050839871 0 0 ;
	setAttr ".tk[12]" -type "float3" 0.037897166 0 0 ;
	setAttr ".tk[13]" -type "float3" 0.038047943 0 0 ;
	setAttr ".tk[14]" -type "float3" 0.050682776 0 0 ;
	setAttr ".tk[15]" -type "float3" 0.050839871 0 0 ;
	setAttr ".tk[16]" -type "float3" 0.038031891 0 0 ;
	setAttr ".tk[17]" -type "float3" 0.0508238 0 0 ;
	setAttr ".tk[18]" -type "float3" 0.038031891 0 0 ;
	setAttr ".tk[19]" -type "float3" 0.0508238 0 0 ;
	setAttr ".tk[20]" -type "float3" -0.033697505 -3.5527137e-15 0 ;
	setAttr ".tk[21]" -type "float3" -0.033697505 -3.5527137e-15 0 ;
	setAttr ".tk[22]" -type "float3" -0.033697505 -7.1054274e-15 0 ;
	setAttr ".tk[23]" -type "float3" -0.033697505 -7.1054274e-15 0 ;
	setAttr ".tk[24]" -type "float3" -0.046811014 0 0 ;
	setAttr ".tk[25]" -type "float3" -0.046811014 0 0 ;
	setAttr ".tk[26]" -type "float3" -0.046811014 0 0 ;
	setAttr ".tk[27]" -type "float3" -0.046811014 0 0 ;
	setAttr ".tk[28]" -type "float3" -0.046811014 0 0 ;
	setAttr ".tk[29]" -type "float3" -0.046811014 0 0 ;
	setAttr ".tk[30]" -type "float3" -0.033697505 -3.5527137e-15 0 ;
	setAttr ".tk[31]" -type "float3" -0.033697505 -3.5527137e-15 0 ;
	setAttr ".tk[36]" -type "float3" 0.037897166 0 0 ;
	setAttr ".tk[37]" -type "float3" 0.037897166 0 0 ;
	setAttr ".tk[38]" -type "float3" 0.050682776 0 0 ;
	setAttr ".tk[39]" -type "float3" 0.050682776 0 0 ;
createNode renderLayerManager -n "Railgun_Cannon:renderLayerManager";
	rename -uid "2A296AA3-4D10-CAC9-B2CA-B498AC742564";
createNode renderLayer -n "Railgun_Cannon:defaultRenderLayer";
	rename -uid "28E79D53-4666-CD58-C617-DAB08C1BDBB9";
	setAttr ".g" yes;
createNode groupId -n "Railgun_Cannon:groupId12";
	rename -uid "3B12D2F3-4DA1-BBE6-CA1A-5AA66A0D08A7";
	setAttr ".ihi" 0;
createNode groupId -n "Railgun_Cannon:groupId15";
	rename -uid "A24A9E09-418A-A1A3-07F2-DAA798CFAB66";
	setAttr ".ihi" 0;
createNode lambert -n "Railgun_Cannon:lambert2";
	rename -uid "29FD13BA-497B-71B0-1617-A28E1362721F";
	setAttr ".c" -type "float3" 0.77999997 0.77999997 0.77999997 ;
createNode shadingEngine -n "Railgun_Cannon:lambert2SG";
	rename -uid "DEEB6743-4346-DEEE-659E-A1AD39C9FEE8";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "Railgun_Cannon:materialInfo1";
	rename -uid "484764F2-413D-B33A-46E7-12A95E4CE68C";
createNode lambert -n "Railgun_Cannon:lambert3";
	rename -uid "32794AE9-4EC8-6130-EB5A-ABB5C4252D84";
	setAttr ".c" -type "float3" 0.23100001 0.23100001 0.23100001 ;
createNode shadingEngine -n "Railgun_Cannon:lambert3SG";
	rename -uid "21873B63-465C-D2F7-22C2-85B92F5A4FE7";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "Railgun_Cannon:materialInfo2";
	rename -uid "B0FA861E-467D-6ACB-C64D-8199903AE62A";
createNode lambert -n "Railgun_Cannon:lambert4";
	rename -uid "172AB788-48B9-9417-CAEE-1D91A3A1372C";
	setAttr ".c" -type "float3" 0.34099999 0.34099999 0.34099999 ;
createNode shadingEngine -n "Railgun_Cannon:lambert4SG";
	rename -uid "409C594F-4C9B-5FC7-B3B1-7E987A73CB9C";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "Railgun_Cannon:materialInfo3";
	rename -uid "A4F4F041-4CF6-4C26-8C3B-E78A74444B7B";
createNode renderLayerManager -n "Railgun_Cannon:M134_MiniGun:renderLayerManager";
	rename -uid "FA2F8232-43BB-DB68-0743-7C8A2D3C3F05";
createNode renderLayer -n "Railgun_Cannon:M134_MiniGun:defaultRenderLayer";
	rename -uid "50067A49-40C6-253F-2945-9F9ADD18BEAA";
	setAttr ".g" yes;
createNode polyBevel3 -n "polyBevel2";
	rename -uid "C81A26A7-48B4-ADA1-52BC-5BB2815E86E1";
	setAttr ".uopa" yes;
	setAttr ".ics" -type "componentList" 1 "e[167]";
	setAttr ".ix" -type "matrix" 1.2446111220701241 0 0 0 0 0.16814318430746406 0 0 0 0 1.2446111220701241 0
		 0 -0.03114639197878824 0 1;
	setAttr ".ws" yes;
	setAttr ".oaf" yes;
	setAttr ".f" 0.3;
	setAttr ".at" 180;
	setAttr ".sn" yes;
	setAttr ".mv" yes;
	setAttr ".mvt" 0.0001;
	setAttr ".sa" 30;
createNode polyTweak -n "polyTweak26";
	rename -uid "0A0DDDF2-4BF3-D197-9713-75858E02A9B7";
	setAttr ".uopa" yes;
	setAttr -s 26 ".tk";
	setAttr ".tk[17]" -type "float3" 0 1.0658141e-14 0.076210126 ;
	setAttr ".tk[18]" -type "float3" 0 1.0658141e-14 0.076210126 ;
	setAttr ".tk[19]" -type "float3" 0 1.0658141e-14 0.076210126 ;
	setAttr ".tk[20]" -type "float3" 0 1.0658141e-14 0.076210126 ;
	setAttr ".tk[21]" -type "float3" 0 1.0658141e-14 0.076210126 ;
	setAttr ".tk[33]" -type "float3" 0 1.5987212e-14 0.076210126 ;
	setAttr ".tk[34]" -type "float3" 0 1.5987212e-14 0.076210126 ;
	setAttr ".tk[37]" -type "float3" 0 1.5987212e-14 0.076210126 ;
	setAttr ".tk[38]" -type "float3" 0 1.5987212e-14 0.076210126 ;
	setAttr ".tk[43]" -type "float3" 0 1.5987212e-14 0.076210126 ;
	setAttr ".tk[44]" -type "float3" 0 1.5987212e-14 0.076210126 ;
	setAttr ".tk[45]" -type "float3" 0 1.5987212e-14 0.076210126 ;
	setAttr ".tk[46]" -type "float3" 0 1.5987212e-14 0.076210126 ;
	setAttr ".tk[47]" -type "float3" 0 1.5987212e-14 0.076210126 ;
	setAttr ".tk[48]" -type "float3" 0 1.5987212e-14 0.076210126 ;
	setAttr ".tk[49]" -type "float3" 0 1.0658141e-14 0.076210126 ;
	setAttr ".tk[50]" -type "float3" 0 1.0658141e-14 0.076210126 ;
	setAttr ".tk[55]" -type "float3" 0 1.5987212e-14 0.076210126 ;
	setAttr ".tk[56]" -type "float3" 0 1.5987212e-14 0.076210126 ;
	setAttr ".tk[59]" -type "float3" 0 1.0658141e-14 0.076210126 ;
	setAttr ".tk[60]" -type "float3" 0 1.0658141e-14 0.076210126 ;
	setAttr ".tk[63]" -type "float3" 0 1.5987212e-14 0.076210126 ;
	setAttr ".tk[64]" -type "float3" 0 1.5987212e-14 0.076210126 ;
	setAttr ".tk[65]" -type "float3" 0 1.5987212e-14 0.076210126 ;
	setAttr ".tk[66]" -type "float3" 0 1.5987212e-14 0.076210126 ;
	setAttr ".tk[67]" -type "float3" 0 1.5987212e-14 0.076210126 ;
createNode polyTweakUV -n "polyTweakUV10";
	rename -uid "2B243003-4A8A-AB90-5AE0-EABC05A12A38";
	setAttr ".uopa" yes;
	setAttr -s 3 ".uvtk";
	setAttr ".uvtk[94]" -type "float2" -1.7541524e-14 -0.00041138701 ;
	setAttr ".uvtk[102]" -type "float2" 4.3187676e-14 0.0051758667 ;
createNode polyMergeVert -n "polyMergeVert10";
	rename -uid "46D725AA-4B93-223E-13D9-8E8C77989AA1";
	setAttr ".ics" -type "componentList" 2 "vtx[49]" "vtx[90]";
	setAttr ".ix" -type "matrix" 1.2446111220701241 0 0 0 0 0.16814318430746406 0 0 0 0 1.2446111220701241 0
		 0 -0.03114639197878824 0 1;
	setAttr ".d" 1e-06;
createNode polyTweak -n "polyTweak27";
	rename -uid "B6FBBD91-4421-6056-7AF5-5384509C7AE6";
	setAttr ".uopa" yes;
	setAttr -s 2 ".tk";
	setAttr ".tk[90]" -type "float3" -0.013757229 -0.10183144 -0.013757288 ;
createNode polyTweakUV -n "polyTweakUV11";
	rename -uid "118D9FF7-49B5-7956-DD48-5C9929B42A89";
	setAttr ".uopa" yes;
	setAttr -s 3 ".uvtk";
	setAttr ".uvtk[95]" -type "float2" -9.4424468e-14 0.00041150948 ;
	setAttr ".uvtk[103]" -type "float2" -2.9048985e-13 -0.0051760725 ;
createNode polyMergeVert -n "polyMergeVert11";
	rename -uid "CA5C9604-4E4D-DC6F-8F99-3D92B83FE394";
	setAttr ".ics" -type "componentList" 2 "vtx[52]" "vtx[92]";
	setAttr ".ix" -type "matrix" 1.2446111220701241 0 0 0 0 0.16814318430746406 0 0 0 0 1.2446111220701241 0
		 0 -0.03114639197878824 0 1;
	setAttr ".d" 1e-06;
createNode polyTweak -n "polyTweak28";
	rename -uid "0ED4D705-4655-D54F-E834-ABB1F5A40A77";
	setAttr ".uopa" yes;
	setAttr -s 2 ".tk";
	setAttr ".tk[92]" -type "float3" -0.013757229 -0.10183144 0.013757288 ;
createNode polyBevel3 -n "polyBevel3";
	rename -uid "0A441DAB-4640-B5A2-EACB-7998D80C04E6";
	setAttr ".uopa" yes;
	setAttr ".ics" -type "componentList" 1 "e[173]";
	setAttr ".ix" -type "matrix" 1.2446111220701241 0 0 0 0 0.16814318430746406 0 0 0 0 1.2446111220701241 0
		 0 -0.03114639197878824 0 1;
	setAttr ".ws" yes;
	setAttr ".oaf" yes;
	setAttr ".f" 0.3;
	setAttr ".at" 180;
	setAttr ".sn" yes;
	setAttr ".mv" yes;
	setAttr ".mvt" 0.0001;
	setAttr ".sa" 30;
createNode polyTweakUV -n "polyTweakUV12";
	rename -uid "0FC179C7-46D4-94A8-CCA2-6DB76601DF10";
	setAttr ".uopa" yes;
	setAttr -s 3 ".uvtk";
	setAttr ".uvtk[97]" -type "float2" 1.4926949e-13 -0.00042215374 ;
	setAttr ".uvtk[106]" -type "float2" -4.6240789e-14 0.0052473559 ;
createNode polyMergeVert -n "polyMergeVert12";
	rename -uid "6029C663-4243-83B8-DB46-CC88483D02A1";
	setAttr ".ics" -type "componentList" 2 "vtx[86]" "vtx[95]";
	setAttr ".ix" -type "matrix" 1.2446111220701241 0 0 0 0 0.16814318430746406 0 0 0 0 1.2446111220701241 0
		 0 -0.03114639197878824 0 1;
	setAttr ".d" 1e-06;
createNode polyTweak -n "polyTweak29";
	rename -uid "C8222203-4B35-F16B-BE6B-F2817A083DD4";
	setAttr ".uopa" yes;
	setAttr -s 3 ".tk";
	setAttr ".tk[95]" -type "float3" 0.013757288 0.10183239 -0.013757259 ;
createNode polyTweakUV -n "polyTweakUV13";
	rename -uid "1119F7C3-462D-5339-A6F8-748953A08D9D";
	setAttr ".uopa" yes;
	setAttr -s 3 ".uvtk";
	setAttr ".uvtk[95]" -type "float2" 6.4368906e-09 0.00045254891 ;
	setAttr ".uvtk[104]" -type "float2" -2.0338295e-08 -0.0052111899 ;
createNode polyMergeVert -n "polyMergeVert13";
	rename -uid "7D9C33B1-4E11-26D5-2BBF-ECA30E4DB8E5";
	setAttr ".ics" -type "componentList" 2 "vtx[85]" "vtx[92]";
	setAttr ".ix" -type "matrix" 1.2446111220701241 0 0 0 0 0.16814318430746406 0 0 0 0 1.2446111220701241 0
		 0 -0.03114639197878824 0 1;
	setAttr ".d" 1e-06;
createNode polyTweak -n "polyTweak30";
	rename -uid "3912425D-4020-9834-C06D-A88A2A0A8424";
	setAttr ".uopa" yes;
	setAttr -s 2 ".tk";
	setAttr ".tk[92]" -type "float3" 0.013757288 0.10183239 0.013757259 ;
createNode renderLayerManager -n "Railgun_Cannon1:renderLayerManager";
	rename -uid "8F1CB5E0-45BB-966B-0F75-F7A65F5D9659";
createNode renderLayer -n "Railgun_Cannon1:defaultRenderLayer";
	rename -uid "3C064C64-42EB-AA3D-C7AB-DC88BE51E2E8";
	setAttr ".g" yes;
createNode groupId -n "Railgun_Cannon1:groupId12";
	rename -uid "DDDB4CBF-4176-0308-C0CC-AB8659ECCA47";
	setAttr ".ihi" 0;
createNode groupId -n "Railgun_Cannon1:groupId15";
	rename -uid "58FD2D85-45A0-19F2-EDC4-A2A639FDDE5F";
	setAttr ".ihi" 0;
createNode lambert -n "Railgun_Cannon1:lambert2";
	rename -uid "9544B89D-4337-0164-297C-F0A048246EF9";
	setAttr ".c" -type "float3" 0.77999997 0.77999997 0.77999997 ;
createNode shadingEngine -n "Railgun_Cannon1:lambert2SG";
	rename -uid "29DB4FD3-4D17-F4ED-50C4-129102B6A9B0";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "Railgun_Cannon1:materialInfo1";
	rename -uid "95D4A4BB-463B-FD42-2DCF-118E09646F45";
createNode lambert -n "Railgun_Cannon1:lambert3";
	rename -uid "5DE2BE55-419A-4857-064D-0B83C032F8E2";
	setAttr ".c" -type "float3" 0.23100001 0.23100001 0.23100001 ;
createNode shadingEngine -n "Railgun_Cannon1:lambert3SG";
	rename -uid "3678A328-4E37-C1DE-9107-179594F8A5DB";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "Railgun_Cannon1:materialInfo2";
	rename -uid "67EBB5B0-4229-1B13-7D30-B2976FDC40DA";
createNode lambert -n "Railgun_Cannon1:lambert4";
	rename -uid "C8BF3D01-4722-8287-60FB-1E96E590E2B6";
	setAttr ".c" -type "float3" 0.34099999 0.34099999 0.34099999 ;
createNode shadingEngine -n "Railgun_Cannon1:lambert4SG";
	rename -uid "CFF76FA1-4B6F-109D-4E68-D39D7994E56A";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "Railgun_Cannon1:materialInfo3";
	rename -uid "956EFFB4-470D-BBF0-020D-938E0FE410AF";
createNode renderLayerManager -n "Railgun_Cannon1:M134_MiniGun:renderLayerManager";
	rename -uid "94D19ECF-4103-5B59-D746-148761755597";
createNode renderLayer -n "Railgun_Cannon1:M134_MiniGun:defaultRenderLayer";
	rename -uid "B30DCFD9-412A-C46B-6C9F-FC8892E9775D";
	setAttr ".g" yes;
createNode polyBevel3 -n "polyBevel4";
	rename -uid "1FB99418-40E3-D7EE-EEE3-009D80753379";
	setAttr ".uopa" yes;
	setAttr ".ics" -type "componentList" 1 "e[12:23]";
	setAttr ".ix" -type "matrix" 0.21529263454385142 0 0 0 0 0.030574907029218924 0 0
		 0 0 0.21529263454385142 0 0 0.9309299511348893 0 1;
	setAttr ".ws" yes;
	setAttr ".oaf" yes;
	setAttr ".f" 0.19999999999999996;
	setAttr ".at" 180;
	setAttr ".sn" yes;
	setAttr ".mv" yes;
	setAttr ".mvt" 0.0001;
	setAttr ".sa" 30;
select -ne :time1;
	setAttr ".o" 1;
	setAttr ".unw" 1;
select -ne :hardwareRenderingGlobals;
	setAttr ".otfna" -type "stringArray" 22 "NURBS Curves" "NURBS Surfaces" "Polygons" "Subdiv Surface" "Particles" "Particle Instance" "Fluids" "Strokes" "Image Planes" "UI" "Lights" "Cameras" "Locators" "Joints" "IK Handles" "Deformers" "Motion Trails" "Components" "Hair Systems" "Follicles" "Misc. UI" "Ornaments"  ;
	setAttr ".otfva" -type "Int32Array" 22 0 1 1 1 1 1
		 1 1 1 0 0 0 0 0 0 0 0 0
		 0 0 0 0 ;
	setAttr ".etmr" no;
	setAttr ".tmr" 4096;
	setAttr ".fprt" yes;
select -ne :renderPartition;
	setAttr -s 23 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 25 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderingList1;
	setAttr -s 6 ".r";
select -ne :initialShadingGroup;
	setAttr -s 5 ".dsm";
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultResolution;
	setAttr ".pa" 1;
select -ne :hardwareRenderGlobals;
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
connectAttr "polyMergeVert13.out" "pCubeShape1.i";
connectAttr "polyTweakUV13.uvtk[0]" "pCubeShape1.uvst[0].uvtw";
connectAttr "polyCylinder2.out" "pCylinderShape2.i";
connectAttr "polyMergeVert9.out" "pCubeShape3.i";
connectAttr "polyTweakUV9.uvtk[0]" "pCubeShape3.uvst[0].uvtw";
connectAttr "polyBevel4.out" "pCylinderShape3.i";
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "lambert2SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "lambert3SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "lambert4SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "lambert5SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "lambert6SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "lambert7SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "lambert8SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "lambert9SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "lambert10SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "lambert11SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "lambert12SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "lambert13SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "lambert14SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "lambert15SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "lambert16SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "Railgun_Cannon:lambert2SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "Railgun_Cannon:lambert3SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "Railgun_Cannon:lambert4SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "Railgun_Cannon1:lambert2SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "Railgun_Cannon1:lambert3SG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "Railgun_Cannon1:lambert4SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "lambert2SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "lambert3SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "lambert4SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "lambert5SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "lambert6SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "lambert7SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "lambert8SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "lambert9SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "lambert10SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "lambert11SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "lambert12SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "lambert13SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "lambert14SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "lambert15SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "lambert16SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "Railgun_Cannon:lambert2SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "Railgun_Cannon:lambert3SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "Railgun_Cannon:lambert4SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "Railgun_Cannon1:lambert2SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "Railgun_Cannon1:lambert3SG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "Railgun_Cannon1:lambert4SG.message" ":defaultLightSet.message";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "layerManager.dli[1]" "RefLayer.id";
connectAttr "M134_MiniGun:renderLayerManager.rlmi[0]" "M134_MiniGun:defaultRenderLayer.rlid"
		;
connectAttr "lambert2.oc" "lambert2SG.ss";
connectAttr "lambert2SG.msg" "materialInfo1.sg";
connectAttr "lambert2.msg" "materialInfo1.m";
connectAttr "lambert3.oc" "lambert3SG.ss";
connectAttr "lambert3SG.msg" "materialInfo2.sg";
connectAttr "lambert3.msg" "materialInfo2.m";
connectAttr "lambert4.oc" "lambert4SG.ss";
connectAttr "lambert4SG.msg" "materialInfo3.sg";
connectAttr "lambert4.msg" "materialInfo3.m";
connectAttr "lambert5.oc" "lambert5SG.ss";
connectAttr "lambert5SG.msg" "materialInfo4.sg";
connectAttr "lambert5.msg" "materialInfo4.m";
connectAttr "lambert6.oc" "lambert6SG.ss";
connectAttr "lambert6SG.msg" "materialInfo5.sg";
connectAttr "lambert6.msg" "materialInfo5.m";
connectAttr "lambert7.oc" "lambert7SG.ss";
connectAttr "lambert7SG.msg" "materialInfo6.sg";
connectAttr "lambert7.msg" "materialInfo6.m";
connectAttr "lambert8.oc" "lambert8SG.ss";
connectAttr "lambert8SG.msg" "materialInfo7.sg";
connectAttr "lambert8.msg" "materialInfo7.m";
connectAttr "lambert9.oc" "lambert9SG.ss";
connectAttr "lambert9SG.msg" "materialInfo8.sg";
connectAttr "lambert9.msg" "materialInfo8.m";
connectAttr "lambert10.oc" "lambert10SG.ss";
connectAttr "lambert10SG.msg" "materialInfo9.sg";
connectAttr "lambert10.msg" "materialInfo9.m";
connectAttr "lambert11.oc" "lambert11SG.ss";
connectAttr "lambert11SG.msg" "materialInfo10.sg";
connectAttr "lambert11.msg" "materialInfo10.m";
connectAttr "lambert12.oc" "lambert12SG.ss";
connectAttr "lambert12SG.msg" "materialInfo11.sg";
connectAttr "lambert12.msg" "materialInfo11.m";
connectAttr "lambert13.oc" "lambert13SG.ss";
connectAttr "lambert13SG.msg" "materialInfo12.sg";
connectAttr "lambert13.msg" "materialInfo12.m";
connectAttr "lambert14.oc" "lambert14SG.ss";
connectAttr "lambert14SG.msg" "materialInfo13.sg";
connectAttr "lambert14.msg" "materialInfo13.m";
connectAttr "lambert15.oc" "lambert15SG.ss";
connectAttr "lambert15SG.msg" "materialInfo14.sg";
connectAttr "lambert15.msg" "materialInfo14.m";
connectAttr "lambert16.oc" "lambert16SG.ss";
connectAttr "lambert16SG.msg" "materialInfo15.sg";
connectAttr "lambert16.msg" "materialInfo15.m";
connectAttr "lambert8.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[2].dn"
		;
connectAttr "lambert13SG.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[3].dn"
		;
connectAttr "lambert9.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[4].dn"
		;
connectAttr "lambert15.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[5].dn"
		;
connectAttr "lambert14SG.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[6].dn"
		;
connectAttr "lambert12.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[7].dn"
		;
connectAttr "lambert16SG.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[8].dn"
		;
connectAttr "lambert10.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[9].dn"
		;
connectAttr "lambert12SG.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[10].dn"
		;
connectAttr "lambert6SG.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[11].dn"
		;
connectAttr "lambert15SG.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[12].dn"
		;
connectAttr "lambert11.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[13].dn"
		;
connectAttr "lambert9SG.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[14].dn"
		;
connectAttr "lambert8SG.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[15].dn"
		;
connectAttr "lambert10SG.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[16].dn"
		;
connectAttr "lambert6.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[17].dn"
		;
connectAttr "lambert7.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[18].dn"
		;
connectAttr "lambert13.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[19].dn"
		;
connectAttr "lambert7SG.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[20].dn"
		;
connectAttr "lambert16.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[21].dn"
		;
connectAttr "lambert14.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[22].dn"
		;
connectAttr "lambert11SG.msg" "hyperShadePrimaryNodeEditorSavedTabsInfo.tgi[0].ni[23].dn"
		;
connectAttr "polyCube1.out" "polySubdFace1.ip";
connectAttr "polyTweak1.out" "polyExtrudeFace1.ip";
connectAttr "pCubeShape1.wm" "polyExtrudeFace1.mp";
connectAttr "polySubdFace1.out" "polyTweak1.ip";
connectAttr "polyTweak2.out" "polyExtrudeFace2.ip";
connectAttr "pCubeShape1.wm" "polyExtrudeFace2.mp";
connectAttr "polyExtrudeFace1.out" "polyTweak2.ip";
connectAttr "polyTweak3.out" "polyExtrudeFace3.ip";
connectAttr "pCubeShape1.wm" "polyExtrudeFace3.mp";
connectAttr "polyExtrudeFace2.out" "polyTweak3.ip";
connectAttr "polyTweak4.out" "polyExtrudeFace4.ip";
connectAttr "pCubeShape1.wm" "polyExtrudeFace4.mp";
connectAttr "polyExtrudeFace3.out" "polyTweak4.ip";
connectAttr "polyTweak5.out" "polyExtrudeFace5.ip";
connectAttr "pCubeShape1.wm" "polyExtrudeFace5.mp";
connectAttr "polyExtrudeFace4.out" "polyTweak5.ip";
connectAttr "polyTweak6.out" "polySubdFace2.ip";
connectAttr "polyExtrudeFace5.out" "polyTweak6.ip";
connectAttr "polySubdFace2.out" "polyDelEdge1.ip";
connectAttr "polyDelEdge1.out" "polySplit1.ip";
connectAttr "polyTweak7.out" "polyExtrudeFace6.ip";
connectAttr "pCubeShape1.wm" "polyExtrudeFace6.mp";
connectAttr "polySplit1.out" "polyTweak7.ip";
connectAttr "polyTweak8.out" "polyExtrudeFace7.ip";
connectAttr "pCubeShape1.wm" "polyExtrudeFace7.mp";
connectAttr "polyExtrudeFace6.out" "polyTweak8.ip";
connectAttr "polyTweak9.out" "polyExtrudeFace8.ip";
connectAttr "pCubeShape1.wm" "polyExtrudeFace8.mp";
connectAttr "polyExtrudeFace7.out" "polyTweak9.ip";
connectAttr "polyExtrudeFace8.out" "polyTweak10.ip";
connectAttr "polyTweak10.out" "deleteComponent1.ig";
connectAttr "deleteComponent1.og" "polyCloseBorder1.ip";
connectAttr "polyCloseBorder1.out" "polyExtrudeFace9.ip";
connectAttr "pCubeShape1.wm" "polyExtrudeFace9.mp";
connectAttr "polyTweak11.out" "polyExtrudeFace10.ip";
connectAttr "pCubeShape1.wm" "polyExtrudeFace10.mp";
connectAttr "polyExtrudeFace9.out" "polyTweak11.ip";
connectAttr "polyTweak12.out" "polyExtrudeFace11.ip";
connectAttr "pCubeShape1.wm" "polyExtrudeFace11.mp";
connectAttr "polyExtrudeFace10.out" "polyTweak12.ip";
connectAttr "polyExtrudeFace11.out" "polyTweakUV1.ip";
connectAttr "polyTweak13.out" "polyMergeVert1.ip";
connectAttr "pCubeShape1.wm" "polyMergeVert1.mp";
connectAttr "polyTweakUV1.out" "polyTweak13.ip";
connectAttr "polyMergeVert1.out" "polyTweakUV2.ip";
connectAttr "polyTweak14.out" "polyMergeVert2.ip";
connectAttr "pCubeShape1.wm" "polyMergeVert2.mp";
connectAttr "polyTweakUV2.out" "polyTweak14.ip";
connectAttr "polyMergeVert2.out" "polyTweakUV3.ip";
connectAttr "polyTweak15.out" "polyMergeVert3.ip";
connectAttr "pCubeShape1.wm" "polyMergeVert3.mp";
connectAttr "polyTweakUV3.out" "polyTweak15.ip";
connectAttr "polyMergeVert3.out" "polyDelEdge2.ip";
connectAttr "polyDelEdge2.out" "polyTweak16.ip";
connectAttr "polyTweak16.out" "deleteComponent2.ig";
connectAttr "deleteComponent2.og" "polyTweakUV4.ip";
connectAttr "polyTweak17.out" "polyMergeVert4.ip";
connectAttr "pCubeShape1.wm" "polyMergeVert4.mp";
connectAttr "polyTweakUV4.out" "polyTweak17.ip";
connectAttr "polyMergeVert4.out" "polyTweakUV5.ip";
connectAttr "polyTweak18.out" "polyMergeVert5.ip";
connectAttr "pCubeShape1.wm" "polyMergeVert5.mp";
connectAttr "polyTweakUV5.out" "polyTweak18.ip";
connectAttr "polyMergeVert5.out" "polyTweakUV6.ip";
connectAttr "polyTweak19.out" "polyMergeVert6.ip";
connectAttr "pCubeShape1.wm" "polyMergeVert6.mp";
connectAttr "polyTweakUV6.out" "polyTweak19.ip";
connectAttr "polyMergeVert6.out" "polyTweakUV7.ip";
connectAttr "polyTweak20.out" "polyMergeVert7.ip";
connectAttr "pCubeShape1.wm" "polyMergeVert7.mp";
connectAttr "polyTweakUV7.out" "polyTweak20.ip";
connectAttr "polyMergeVert7.out" "polyTweak21.ip";
connectAttr "polyTweak21.out" "deleteComponent3.ig";
connectAttr "deleteComponent3.og" "polyTweak22.ip";
connectAttr "polyTweak22.out" "deleteComponent4.ig";
connectAttr "deleteComponent4.og" "polyCloseBorder2.ip";
connectAttr "polyCube3.out" "polyTweakUV8.ip";
connectAttr "polyTweak23.out" "polyMergeVert8.ip";
connectAttr "pCubeShape3.wm" "polyMergeVert8.mp";
connectAttr "polyTweakUV8.out" "polyTweak23.ip";
connectAttr "polyMergeVert8.out" "polyTweakUV9.ip";
connectAttr "polyTweak24.out" "polyMergeVert9.ip";
connectAttr "pCubeShape3.wm" "polyMergeVert9.mp";
connectAttr "polyTweakUV9.out" "polyTweak24.ip";
connectAttr "polyTweak25.out" "polyBevel1.ip";
connectAttr "pCubeShape1.wm" "polyBevel1.mp";
connectAttr "polyCloseBorder2.out" "polyTweak25.ip";
connectAttr "Railgun_Cannon:renderLayerManager.rlmi[0]" "Railgun_Cannon:defaultRenderLayer.rlid"
		;
connectAttr "Railgun_Cannon:lambert2.oc" "Railgun_Cannon:lambert2SG.ss";
connectAttr "Railgun_Cannon:lambert2SG.msg" "Railgun_Cannon:materialInfo1.sg";
connectAttr "Railgun_Cannon:lambert2.msg" "Railgun_Cannon:materialInfo1.m";
connectAttr "Railgun_Cannon:lambert3.oc" "Railgun_Cannon:lambert3SG.ss";
connectAttr "Railgun_Cannon:lambert3SG.msg" "Railgun_Cannon:materialInfo2.sg";
connectAttr "Railgun_Cannon:lambert3.msg" "Railgun_Cannon:materialInfo2.m";
connectAttr "Railgun_Cannon:lambert4.oc" "Railgun_Cannon:lambert4SG.ss";
connectAttr "Railgun_Cannon:lambert4SG.msg" "Railgun_Cannon:materialInfo3.sg";
connectAttr "Railgun_Cannon:lambert4.msg" "Railgun_Cannon:materialInfo3.m";
connectAttr "Railgun_Cannon:M134_MiniGun:renderLayerManager.rlmi[0]" "Railgun_Cannon:M134_MiniGun:defaultRenderLayer.rlid"
		;
connectAttr "polyTweak26.out" "polyBevel2.ip";
connectAttr "pCubeShape1.wm" "polyBevel2.mp";
connectAttr "polyBevel1.out" "polyTweak26.ip";
connectAttr "polyBevel2.out" "polyTweakUV10.ip";
connectAttr "polyTweak27.out" "polyMergeVert10.ip";
connectAttr "pCubeShape1.wm" "polyMergeVert10.mp";
connectAttr "polyTweakUV10.out" "polyTweak27.ip";
connectAttr "polyMergeVert10.out" "polyTweakUV11.ip";
connectAttr "polyTweak28.out" "polyMergeVert11.ip";
connectAttr "pCubeShape1.wm" "polyMergeVert11.mp";
connectAttr "polyTweakUV11.out" "polyTweak28.ip";
connectAttr "polyMergeVert11.out" "polyBevel3.ip";
connectAttr "pCubeShape1.wm" "polyBevel3.mp";
connectAttr "polyBevel3.out" "polyTweakUV12.ip";
connectAttr "polyTweak29.out" "polyMergeVert12.ip";
connectAttr "pCubeShape1.wm" "polyMergeVert12.mp";
connectAttr "polyTweakUV12.out" "polyTweak29.ip";
connectAttr "polyMergeVert12.out" "polyTweakUV13.ip";
connectAttr "polyTweak30.out" "polyMergeVert13.ip";
connectAttr "pCubeShape1.wm" "polyMergeVert13.mp";
connectAttr "polyTweakUV13.out" "polyTweak30.ip";
connectAttr "Railgun_Cannon1:renderLayerManager.rlmi[0]" "Railgun_Cannon1:defaultRenderLayer.rlid"
		;
connectAttr "Railgun_Cannon1:lambert2.oc" "Railgun_Cannon1:lambert2SG.ss";
connectAttr "Railgun_Cannon1:lambert2SG.msg" "Railgun_Cannon1:materialInfo1.sg";
connectAttr "Railgun_Cannon1:lambert2.msg" "Railgun_Cannon1:materialInfo1.m";
connectAttr "Railgun_Cannon1:lambert3.oc" "Railgun_Cannon1:lambert3SG.ss";
connectAttr "Railgun_Cannon1:lambert3SG.msg" "Railgun_Cannon1:materialInfo2.sg";
connectAttr "Railgun_Cannon1:lambert3.msg" "Railgun_Cannon1:materialInfo2.m";
connectAttr "Railgun_Cannon1:lambert4.oc" "Railgun_Cannon1:lambert4SG.ss";
connectAttr "Railgun_Cannon1:lambert4SG.msg" "Railgun_Cannon1:materialInfo3.sg";
connectAttr "Railgun_Cannon1:lambert4.msg" "Railgun_Cannon1:materialInfo3.m";
connectAttr "Railgun_Cannon1:M134_MiniGun:renderLayerManager.rlmi[0]" "Railgun_Cannon1:M134_MiniGun:defaultRenderLayer.rlid"
		;
connectAttr "polySurfaceShape1.o" "polyBevel4.ip";
connectAttr "pCylinderShape3.wm" "polyBevel4.mp";
connectAttr "lambert2SG.pa" ":renderPartition.st" -na;
connectAttr "lambert3SG.pa" ":renderPartition.st" -na;
connectAttr "lambert4SG.pa" ":renderPartition.st" -na;
connectAttr "lambert5SG.pa" ":renderPartition.st" -na;
connectAttr "lambert6SG.pa" ":renderPartition.st" -na;
connectAttr "lambert7SG.pa" ":renderPartition.st" -na;
connectAttr "lambert8SG.pa" ":renderPartition.st" -na;
connectAttr "lambert9SG.pa" ":renderPartition.st" -na;
connectAttr "lambert10SG.pa" ":renderPartition.st" -na;
connectAttr "lambert11SG.pa" ":renderPartition.st" -na;
connectAttr "lambert12SG.pa" ":renderPartition.st" -na;
connectAttr "lambert13SG.pa" ":renderPartition.st" -na;
connectAttr "lambert14SG.pa" ":renderPartition.st" -na;
connectAttr "lambert15SG.pa" ":renderPartition.st" -na;
connectAttr "lambert16SG.pa" ":renderPartition.st" -na;
connectAttr "Railgun_Cannon:lambert2SG.pa" ":renderPartition.st" -na;
connectAttr "Railgun_Cannon:lambert3SG.pa" ":renderPartition.st" -na;
connectAttr "Railgun_Cannon:lambert4SG.pa" ":renderPartition.st" -na;
connectAttr "Railgun_Cannon1:lambert2SG.pa" ":renderPartition.st" -na;
connectAttr "Railgun_Cannon1:lambert3SG.pa" ":renderPartition.st" -na;
connectAttr "Railgun_Cannon1:lambert4SG.pa" ":renderPartition.st" -na;
connectAttr "lambert2.msg" ":defaultShaderList1.s" -na;
connectAttr "lambert3.msg" ":defaultShaderList1.s" -na;
connectAttr "lambert4.msg" ":defaultShaderList1.s" -na;
connectAttr "lambert5.msg" ":defaultShaderList1.s" -na;
connectAttr "lambert6.msg" ":defaultShaderList1.s" -na;
connectAttr "lambert7.msg" ":defaultShaderList1.s" -na;
connectAttr "lambert8.msg" ":defaultShaderList1.s" -na;
connectAttr "lambert9.msg" ":defaultShaderList1.s" -na;
connectAttr "lambert10.msg" ":defaultShaderList1.s" -na;
connectAttr "lambert11.msg" ":defaultShaderList1.s" -na;
connectAttr "lambert12.msg" ":defaultShaderList1.s" -na;
connectAttr "lambert13.msg" ":defaultShaderList1.s" -na;
connectAttr "lambert14.msg" ":defaultShaderList1.s" -na;
connectAttr "lambert15.msg" ":defaultShaderList1.s" -na;
connectAttr "lambert16.msg" ":defaultShaderList1.s" -na;
connectAttr "Railgun_Cannon:lambert2.msg" ":defaultShaderList1.s" -na;
connectAttr "Railgun_Cannon:lambert3.msg" ":defaultShaderList1.s" -na;
connectAttr "Railgun_Cannon:lambert4.msg" ":defaultShaderList1.s" -na;
connectAttr "Railgun_Cannon1:lambert2.msg" ":defaultShaderList1.s" -na;
connectAttr "Railgun_Cannon1:lambert3.msg" ":defaultShaderList1.s" -na;
connectAttr "Railgun_Cannon1:lambert4.msg" ":defaultShaderList1.s" -na;
connectAttr "defaultRenderLayer.msg" ":defaultRenderingList1.r" -na;
connectAttr "M134_MiniGun:defaultRenderLayer.msg" ":defaultRenderingList1.r" -na
		;
connectAttr "Railgun_Cannon:defaultRenderLayer.msg" ":defaultRenderingList1.r" -na
		;
connectAttr "Railgun_Cannon:M134_MiniGun:defaultRenderLayer.msg" ":defaultRenderingList1.r"
		 -na;
connectAttr "Railgun_Cannon1:defaultRenderLayer.msg" ":defaultRenderingList1.r" 
		-na;
connectAttr "Railgun_Cannon1:M134_MiniGun:defaultRenderLayer.msg" ":defaultRenderingList1.r"
		 -na;
connectAttr "pCubeShape1.iog" ":initialShadingGroup.dsm" -na;
connectAttr "pCylinderShape2.iog" ":initialShadingGroup.dsm" -na;
connectAttr "pCubeShape3.iog" ":initialShadingGroup.dsm" -na;
connectAttr "pCubeShape4.iog" ":initialShadingGroup.dsm" -na;
connectAttr "pCylinderShape3.iog" ":initialShadingGroup.dsm" -na;
// End of Gun_Mount.ma
