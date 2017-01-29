{include file="time_script.tpl"}

<style>
.not_billable td {
  color: #ff6666;
}
</style>

{$forms.timeRecordForm.open}
<table cellspacing="4" cellpadding="0" border="0">
  <tr>
    <td valign="top">
      <table>
{if $on_behalf_control}
        <tr>
          <td align="right">{$i18n.label.user}:</td>
          <td>{$forms.timeRecordForm.onBehalfUser.control}</td>
        </tr>
{/if}
{if $user->isPluginEnabled('cl')}
        <tr>
          <td align="right">{$i18n.label.client}{if $user->isPluginEnabled('cm')} (*){/if}:</td>
          <td>{$forms.timeRecordForm.client.control}</td>
        </tr>
{/if}
{if $user->isPluginEnabled('iv')}
        <tr>
          <td align="right">&nbsp;</td>
          <td><label>{$forms.timeRecordForm.billable.control}{$i18n.form.time.billable}</label></td>
        </tr>
{/if}
{if ($custom_fields && $custom_fields->fields[0])}
        <tr>
          <td align="right">{$custom_fields->fields[0]['label']|escape}{if $custom_fields->fields[0]['required']} (*){/if}:</td><td>{$forms.timeRecordForm.cf_1.control}</td>
        </tr>
{/if}
{if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
        <tr>
          <td align="right">{$i18n.label.project} (*):</td>
          <td>{$forms.timeRecordForm.project.control}</td>
        </tr>
{/if}
{if ($smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
        <tr>
          <td align="right">{$i18n.label.task}:</td>
          <td>{$forms.timeRecordForm.task.control}</td>
        </tr>
{/if}
{if (($smarty.const.TYPE_START_FINISH == $user->record_type) || ($smarty.const.TYPE_ALL == $user->record_type))}
        <tr>
          <td align="right">{$i18n.label.start}:</td>
          <td>{$forms.timeRecordForm.start.control}&nbsp;<input onclick="setNow('start');" type="button" tabindex="-1" value="{$i18n.button.now}"></td>
        </tr>
        <tr>
          <td align="right">{$i18n.label.finish}:</td>
          <td>{$forms.timeRecordForm.finish.control}&nbsp;<input onclick="setNow('finish');" type="button" tabindex="-1" value="{$i18n.button.now}"></td>
        </tr>
{/if}
{if (($smarty.const.TYPE_DURATION == $user->record_type) || ($smarty.const.TYPE_ALL == $user->record_type))}
        <tr>
          <td align="right">{$i18n.label.duration}:</td>
          <td>{$forms.timeRecordForm.duration.control}&nbsp;{$i18n.form.time.duration_format}</td>
        </tr>
{/if}
      </table>
    </td>
    <td valign="top">
      <table>
        <tr><td>{$forms.timeRecordForm.date.control}</td></tr>
      </table>
    </td>
  </tr>
</table>

<table>
  <tr>
    <td align="right">{$i18n.label.note}:</td>
    <td align="left">{$forms.timeRecordForm.note.control}</td>
  </tr>
  <tr>
    <td align="center" colspan="2">{$forms.timeRecordForm.btn_submit.control}</td>
  </tr>
</table>

<table width="720">
<tr>
  <td valign="top">
{if $time_records}
      <table border="0" cellpadding="3" cellspacing="1" width="100%">
      <tr>
  {if $user->isPluginEnabled('cl')}
        <td width="20%" class="tableHeader">{$i18n.label.client}</td>
  {/if}
  {if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
        <td class="tableHeader">{$i18n.label.project}</td>
  {/if}
  {if ($smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
        <td class="tableHeader">{$i18n.label.task}</td>
  {/if}
  {if (($smarty.const.TYPE_START_FINISH == $user->record_type) || ($smarty.const.TYPE_ALL == $user->record_type))}
        <td width="5%" class="tableHeader" align="right">{$i18n.label.start}</td>
        <td width="5%" class="tableHeader" align="right">{$i18n.label.finish}</td>
  {/if}
        <td width="5%" class="tableHeader">{$i18n.label.duration}</td>
        <td class="tableHeader">{$i18n.label.note}</td>
        <td width="5%" class="tableHeader">{$i18n.label.edit}</td>
      </tr>
  {foreach $time_records as $record}
      <tr bgcolor="{cycle values="#f5f5f5,#ccccce"}" {if !$record.billable} class="not_billable" {/if}>
    {if $user->isPluginEnabled('cl')}
        <td valign="top">{$record.client|escape}</td>
    {/if}
    {if ($smarty.const.MODE_PROJECTS == $user->tracking_mode || $smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
        <td valign="top">{$record.project|escape}</td>
    {/if}
    {if ($smarty.const.MODE_PROJECTS_AND_TASKS == $user->tracking_mode)}
        <td valign="top">{$record.task|escape}</td>
    {/if}
    {if (($smarty.const.TYPE_START_FINISH == $user->record_type) || ($smarty.const.TYPE_ALL == $user->record_type))}
        <td nowrap align="right" valign="top">{if $record.start}{$record.start}{else}&nbsp;{/if}</td>
        <td nowrap align="right" valign="top">{if $record.finish}{$record.finish}{else}&nbsp;{/if}</td>
    {/if}
        <td align="right" valign="top">{if ($record.duration == '0:00' && $record.start <> '')}<font color="#ff0000">{$i18n.form.time.uncompleted}</font>{else}{$record.duration}{/if}</td>
        <td valign="top">{if $record.comment}{$record.comment|escape}{else}&nbsp;{/if}</td>
        <td valign="top" align="center">
    {if $record.invoice_id}
          &nbsp;
    {else}
          <a href="time_edit.php?id={$record.id}">{$i18n.label.edit}</a>
      {if ($record.duration == '0:00' && $record.start <> '')}
          <input type="hidden" name="record_id" value="{$record.id}">
          <input type="hidden" name="browser_date" value="">
          <input type="hidden" name="browser_time" value="">
          <input type="submit" id="btn_stop" name="btn_stop" onclick="browser_date.value=get_date();browser_time.value=get_time()" value="{$i18n.button.stop}">
      {/if}
    {/if}
        </td>
      </tr>
  {/foreach}
    </table>
{/if}
  </td>
</tr>
</table>
{if $time_records}
<table cellpadding="3" cellspacing="1" width="720">
  <tr>
    <td align="left">{$i18n.label.week_total}: {$week_total}</td>
    <td align="right">{$i18n.label.day_total}: {$day_total}</td>
  </tr>
  {if $user->isPluginEnabled('mq')}
  <tr>
    <td align="left">{$i18n.label.month_total}: {$month_total}</td>
    {if $over_quota}
    <td align="right">{$i18n.form.time.over_quota}: <span style="color: green;">{$quota_remaining}</span></td>
    {else}
    <td align="right">{$i18n.form.time.remaining_quota}: <span style="color: red;">{$quota_remaining}</span></td>
    {/if}
  </tr>
  {/if}
</table>
{/if}
{$forms.timeRecordForm.close}
