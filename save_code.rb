<% while i < length %>
  <% if (biz_vios[i].date + 60.minutes).utc > (biz_vios[i+1].date + 60.minutes).utc %>
      <% temp = biz_vios[i] %>
      <% biz_vios[i] = biz_vios[i+1] %>
      <% biz_vios[i+1] = temp %>
    <% end %>
  <% i += 1 %>
<% end %>