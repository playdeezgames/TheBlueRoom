GDPC                                                                               <   res://.import/dude.png-fb4e14cb83845e5914adbc9d4566a289.stexp      \       �(�}�?�����e@   res://.import/floor.png-d43f03cb7a8f42941311ed90ed2021b9.stex   �      B       ��ڌ�c1��S;΍H�<   res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex�      r       T@x�΄T8ޟ�`��@   res://.import/solid.png-2f68e1a72743244ae201bebc8da36e49.stex   �      D       �R��00D�!�{�S�   res://Characters.tres   P            �te�B�
;"������   res://Main.gd.remap �             �(@Er�#��K�F�[   res://Main.gdc  `      �      �f��\����_w%R   res://Main.tscn       o      k�X7'`��o�<,�!�   res://Terrain.tres  �      �      ��HK�x����n!��   res://dude.png.import   �      �      �&�gԁ���f�   res://floor.png.import  �      �      �[ltP���R
�Vl>   res://icon.png  �            g_mɖUG�j�b��:_   res://icon.png.import          �      ��fe��6�B��^ U�   res://project.binary�              u24-�<�b�Q$   res://solid.png.import         �      ������~l6_�(�[gd_resource type="TileSet" load_steps=2 format=2]

[ext_resource path="res://dude.png" type="Texture" id=1]

[resource]
0/name = "dude.png 0"
0/texture = ExtResource( 1 )
0/tex_offset = Vector2( 0, 0 )
0/modulate = Color( 1, 1, 1, 1 )
0/region = Rect2( 0, 0, 32, 32 )
0/tile_mode = 0
0/occluder_offset = Vector2( 0, 0 )
0/navigation_offset = Vector2( 0, 0 )
0/shape_offset = Vector2( 0, 0 )
0/shape_transform = Transform2D( 1, 0, 0, 1, 0, 0 )
0/shape_one_way = false
0/shape_one_way_margin = 0.0
0/shapes = [  ]
0/z_index = 0
 GDSC      
   8   <     ���ӄ�   ������������嶶�   ���������嶶   �����ض�   ����   ������������������Ŷ   ����Ҷ��   ��������Ӷ��   �����Ŷ�   �������ڶ���   �������Ӷ���   ��������������Ҷ   ζ��   ϶��   ����Ҷ��   �����϶�   �������Ӷ���   �����   �����ﶶ   ����������ض   ������������   ������ض   �������ڶ���   ���������Ķ�   �����¶�   ����¶��   ����������������Ҷ��                                            ui_up         ui_down       ui_left       ui_right                                                    	      
          $      '      )      -      /      1      2      8      D      E      K      X      Y      _      h      q      �      �      �      �      �       �   !   �   "   �   #   �   $   �   %   �   &   �   '   �   (   �   )   �   *   �   +   �   ,   �   -   �   .   �   /      0     1     2     3   !  4   )  5   2  6   9  7   :  8   3YY:�  Y:�  YY;�  �  Y;�  �  YY;�  L�  N�  �  �  �  OR�  N�  �  �  �  OYMYY0�  PQV�  W�  T�	  P�  R�  R�  Q�  Y0�
  PQV�  W�  T�	  P�  R�  R�  Q�  Y0�  PQV�  )�  �K  P�  QV�  )�  �K  P�  QV�  W�  T�	  P�  R�  R�  &�  �  �  �  �  �  �  �  �  �  (�  Q�  Y0�  PQV�  �  PQ�  �  PQ�  Y0�  P�  R�  QV�  �
  PQ�  ;�  �  �  �  ;�  �  �  �  ;�  W�  T�  P�  R�  Q�  ;�  �  L�  M�  &P�  T�  QV�  �  �  �  �  �  �  �  �  �  �  �  �  �  PQYY0�  P�  QV�  &�  T�  P�  QV�  �  P�  R�  Q�  &�  T�  P�  QV�  �  P�  R�  Q�  &�  T�  P�  QV�  �  P�  R�  Q�  &�  T�  P�	  QV�  �  P�  R�  Q�  Y` [gd_scene load_steps=4 format=2]

[ext_resource path="res://Main.gd" type="Script" id=1]
[ext_resource path="res://Terrain.tres" type="TileSet" id=2]
[ext_resource path="res://Characters.tres" type="TileSet" id=3]

[node name="Main" type="Node2D"]
script = ExtResource( 1 )

[node name="Board" type="TileMap" parent="."]
tile_set = ExtResource( 2 )
cell_size = Vector2( 32, 32 )
cell_custom_transform = Transform2D( 32, 0, 0, 32, 0, 0 )
format = 1

[node name="Pieces" type="TileMap" parent="."]
tile_set = ExtResource( 3 )
cell_size = Vector2( 32, 32 )
cell_custom_transform = Transform2D( 32, 0, 0, 32, 0, 0 )
format = 1
 [gd_resource type="TileSet" load_steps=3 format=2]

[ext_resource path="res://floor.png" type="Texture" id=1]
[ext_resource path="res://solid.png" type="Texture" id=2]

[resource]
0/name = "floor.png 0"
0/texture = ExtResource( 1 )
0/tex_offset = Vector2( 0, 0 )
0/modulate = Color( 1, 1, 1, 1 )
0/region = Rect2( 0, 0, 32, 32 )
0/tile_mode = 0
0/occluder_offset = Vector2( 0, 0 )
0/navigation_offset = Vector2( 0, 0 )
0/shape_offset = Vector2( 0, 0 )
0/shape_transform = Transform2D( 1, 0, 0, 1, 0, 0 )
0/shape_one_way = false
0/shape_one_way_margin = 0.0
0/shapes = [  ]
0/z_index = 0
1/name = "solid.png 1"
1/texture = ExtResource( 2 )
1/tex_offset = Vector2( 0, 0 )
1/modulate = Color( 1, 1, 1, 1 )
1/region = Rect2( 0, 0, 32, 32 )
1/tile_mode = 0
1/occluder_offset = Vector2( 0, 0 )
1/navigation_offset = Vector2( 0, 0 )
1/shape_offset = Vector2( 0, 0 )
1/shape_transform = Transform2D( 1, 0, 0, 1, 0, 0 )
1/shape_one_way = false
1/shape_one_way_margin = 0.0
1/shapes = [  ]
1/z_index = 0
              GDST                 @   WEBPRIFF4   WEBPVP8L'   /�0��:��� 0� ��5���O��~5>1�у~     [remap]

importer="texture"
type="StreamTexture"
path="res://.import/dude.png-fb4e14cb83845e5914adbc9d4566a289.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://dude.png"
dest_files=[ "res://.import/dude.png-fb4e14cb83845e5914adbc9d4566a289.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
process/normal_map_invert_y=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
              GDST                 &   WEBPRIFF   WEBPVP8L   /� �DD�              [remap]

importer="texture"
type="StreamTexture"
path="res://.import/floor.png-d43f03cb7a8f42941311ed90ed2021b9.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://floor.png"
dest_files=[ "res://.import/floor.png-d43f03cb7a8f42941311ed90ed2021b9.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
process/normal_map_invert_y=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
           GDST@   @            V   WEBPRIFFJ   WEBPVP8L>   /?�0��:��pEm#9C2$���������~��������GIG���గC�ӈ�              [remap]

importer="texture"
type="StreamTexture"
path="res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://icon.png"
dest_files=[ "res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
process/normal_map_invert_y=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
              GDST                 (   WEBPRIFF   WEBPVP8L   /� ���"��             [remap]

importer="texture"
type="StreamTexture"
path="res://.import/solid.png-2f68e1a72743244ae201bebc8da36e49.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://solid.png"
dest_files=[ "res://.import/solid.png-2f68e1a72743244ae201bebc8da36e49.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
process/normal_map_invert_y=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
           [remap]

path="res://Main.gdc"
 �PNG

   IHDR   @   @   ����   sRGB ���   gAMA  ���a   PLTE���   ��   tRNS� �0J   	pHYs  �  ��o�d   �IDATXG�ױ�@@~���,B	�uX�Wi��Kfk��c�q�?��<p�Y�_x`��{��2�H-Ӌ�2�H-Ӌ�2�H-Ӌ�2�H�~��q�]��q�]��q�]�������C1�����Xkm�~�vA    IEND�B`�               ECFG      application/config/name         TheBlueRoom    application/run/main_scene         res://Main.tscn    application/config/icon         res://icon.png  +   gui/common/drop_mouse_on_gui_input_disabled         )   physics/common/enable_pause_aware_picking         