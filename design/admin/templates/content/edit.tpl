<form name="editform" id="editform" enctype="multipart/form-data" method="post" action={concat( '/content/edit/', $object.id, '/', $edit_version, '/', $edit_language|not|choose( concat( $edit_language, '/' ), '/' ), $is_translating_content|not|choose( concat( $from_language, '/' ), '' ) )|ezurl}>
{*form name="editform" id="editform" enctype="multipart/form-data" method="post" action={concat( '/content/edit/', $object.id, '/', $edit_version, '/', $edit_language|not|choose( concat( $edit_language, '/' ), '/' ), $is_translating_content|not|choose( concat( $from_language, '/' ), '' ) )|ezurl}*}

<div id="leftmenu">
<div id="leftmenu-design">

{include uri='design:content/edit_menu.tpl'}

</div>
</div>

<div id="maincontent"><div id="fix">
<div id="maincontent-design">
<!-- Maincontent START -->

{include uri='design:content/edit_validation.tpl'}

<div class="content-edit">

<div class="context-block">

{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

<h1 class="context-title">{$object.class_identifier|class_icon( normal, $object.class_name )}&nbsp;{'Edit <%object_name> [%class_name]'|i18n( 'design/admin/content/edit',, hash( '%object_name', $object.name, '%class_name', $class.name ) )|wash}</h1>

{* DESIGN: Mainline *}<div class="header-mainline"></div>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Content START *}<div class="box-ml"><div class="box-mr"><div class="box-content">

<div class="context-information">
<p class="translation">
{let language_index=0
     from_language_index=0
     default_translation=$content_version.translation
     other_translation_list=$content_version.translation_list
     translation_list=$other_translation_list|array_prepend($default_translation)}

{section loop=$translation_list}
  {section show=eq( $edit_language, $item.language_code)}
    {set language_index=$:index}
  {/section}
{/section}

{section show=$is_translating_content}

    {section loop=$translation_list}
      {section show=eq( $from_language, $item.language_code)}
        {set from_language_index=$:index}
      {/section}
    {/section}

    {'Translating content from %from_lang to %to_lang'|i18n( 'design/admin/content/edit',, hash( '%from_lang', concat( $translation_list[$from_language_index].locale.intl_language_name, '&nbsp;<img src="', $translation_list[$from_language_index].language_code|flag_icon, '" style="vertical-align: middle;" alt="', $translation_list[$from_language_index].language_code, '" />' ), '%to_lang', concat( $translation_list[$language_index].locale.intl_language_name, '&nbsp;<img src="', $translation_list[$language_index].language_code|flag_icon, '" style="vertical-align: middle;" alt="', $translation_list[$language_index].language_code, '" />' ) ) )}

{section-else}

    {$translation_list[$language_index].locale.intl_language_name}&nbsp;<img src="{$translation_list[$language_index].language_code|flag_icon}" style="vertical-align: middle;" alt="{$translation_list[$language_index].language_code}" />

{/section}

{/let}
</p>
<div class="break"></div>
</div>

{section show=$is_translating_content}
<div class="content-translation">
{/section}

<div class="context-attributes">
    {include uri='design:content/edit_attribute.tpl'}
</div>

{section show=$is_translating_content}
</div>
{/section}

{* DESIGN: Content END *}</div></div></div>
<div class="controlbar">
{* DESIGN: Control bar START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
<div class="block">
    <input class="button" type="submit" name="PublishButton" value="{'Send for publishing'|i18n( 'design/admin/content/edit' )}" title="{'Publish the contents of the draft that is being edited. The draft will thus become the published version of the object.'|i18n( 'design/admin/content/edit' )}" />
    <input class="button" type="submit" name="StoreButton" value="{'Store draft'|i18n( 'design/admin/content/edit' )}" title="{'Store the contents of the draft that is being edited and continue editing. Use this button to periodically save your work while editing.'|i18n( 'design/admin/content/edit' )}" />
    <input class="button" type="submit" name="DiscardButton" value="{'Discard draft'|i18n( 'design/admin/content/edit' )}" onclick="return confirmDiscard( '{'Are you sure that you want to discard the changes?'|i18n( 'design/admin/content/edit' )}' );" title="{'Discard the draft that is being edited. This will also get rid of the translations that belong to the draft (if any).'|i18n( 'design/admin/content/edit' ) }" />
    <input type="hidden" name="DiscardConfirm" value="1" />
</div>
{* DESIGN: Control bar END *}</div></div></div></div></div></div>
</div>

</div>

{* Related objects window. *}
{section show=ne( ezpreference( 'admin_edit_show_relations' ), 0 )|not}
    {include uri='design:content/edit_relations.tpl'}
{/section}


{* Locations window. *}
{* section show=eq( ezini( 'EditSettings', 'EmbedNodeAssignmentHandling', 'content.ini' ), 'enabled' ) *}
{section show=ezpreference( 'admin_edit_show_locations' )}
    {include uri='design:content/edit_locations.tpl'}
{section-else}
    {* This disables all node assignment checking in content/edit *}
    <input type="hidden" name="UseNodeAssigments" value="0" />
{/section}

</div>

<!-- Maincontent END -->
</div>
<div class="break"></div>
</div></div>

</form>




{literal}
<script language="JavaScript" type="text/javascript">
<!--
    window.onload=function()
    {
        with( editform )
        {
            for( var i=0; i<elements.length; i++ )
            {
                if( elements[i].type == 'text' )
                {
                    elements[i].focus();
                    return;
                }
            }
        }
    }

    function confirmDiscard( question )
    {
        // Disable/bypass the reload-based (plain HTML) confirmation interface.
        document.editform.DiscardConfirm.value = "0";

        // Ask user if she really wants do it, return this to the handler.
        return confirm( question );
    }
-->
</script>
{/literal}
