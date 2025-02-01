---
title: "Specification"
layout: default
toc: true
toc_levels: 1..3 
categories: main-index
---

# Specification

{%- comment -%}
  1. Filter all pages in the specification folder (excluding pages with category "main-index")
{%- endcomment -%}
{% assign spec_pages = "" | split: "" %}
{% for spec in site.pages %}
  {% if spec.path contains 'specification/' and spec.categories contains 'main-index' == false %}
    {% assign spec_pages = spec_pages | push: spec %}
  {% endif %}
{% endfor %}

{%- comment -%}
  2. Separate pages directly in the specification folder (depth 0)
     from pages in subfolders (depth ≥ 1).
     We compute depth by removing "specification/" from the path and splitting on "/".
{%- endcomment -%}
{% assign direct_specs = "" | split: "" %}
{% assign indirect_specs = "" | split: "" %}
{% for spec in spec_pages %}
  {% assign relPath = spec.path | remove: "specification/" %}
  {% assign parts = relPath | split: "/" %}
  {% assign depth = parts | size | minus: 1 %}
  {% if depth == 0 %}
    {% assign direct_specs = direct_specs | push: spec %}
  {% else %}
    {% assign indirect_specs = indirect_specs | push: spec %}
  {% endif %}
{% endfor %}

{%- comment -%}
  3. Sort the direct pages by their path (or use "title" if that suits your needs)
{%- endcomment -%}
{% assign direct_specs = direct_specs | sort:"path" %}

<ul style="list-style: none; padding: 0; margin: 0;">
  {%- comment -%}
    Output the direct (depth-0) pages.
  {%- endcomment -%}
  {% for spec in direct_specs %}
    <li style="margin-left: 0px; padding: 4px 0;">
      <a href="{{ spec.url | relative_url }}">{{ spec.title }}</a>
    </li>
  {% endfor %}

  {%- comment -%}
    4. Group the indirect pages (depth ≥ 1) by their top-level folder.
       For each indirect page, remove the "specification/" prefix and split by "/".
       The first part will be the top-level folder name.
  {%- endcomment -%}
  {% assign groups = indirect_specs | group_by_exp:"item", "item.path | remove: 'specification/' | split: '/' | first" %}
  {%- comment -%}
    (Sort groups alphabetically by folder name.)
  {%- endcomment -%}
  {% assign groups = groups | sort:"name" %}
  {% for group in groups %}
    {%- comment -%}
      Display the group (folder) name as a header.
    {%- endcomment -%}
    <li style="margin-left: 20px; font-weight: bold; padding: 4px 0;">{{ group.name }}</li>
    
    {%- comment -%}
      Within each group, further separate items that are directly in that folder (depth == 1)
      from items in subfolders (depth > 1).
    {%- endcomment -%}
    {% assign direct_in_group = "" | split: "" %}
    {% assign sub_in_group = "" | split: "" %}
    {% for spec in group.items %}
      {% assign relPath = spec.path | remove: "specification/" %}
      {% assign parts = relPath | split: "/" %}
      {% assign depth = parts | size | minus: 1 %}
      {% if depth == 1 %}
        {% assign direct_in_group = direct_in_group | push: spec %}
      {% else %}
        {% assign sub_in_group = sub_in_group | push: spec %}
      {% endif %}
    {% endfor %}
    {%- comment -%}
      Sort the direct_in_group items (they are files directly in the folder).
    {%- endcomment -%}
    {% assign direct_in_group = direct_in_group | sort:"path" %}
    {% for spec in direct_in_group %}
      <li style="margin-left: 40px; padding: 4px 0;">
        <a href="{{ spec.url | relative_url }}">{{ spec.title }}</a>
      </li>
    {% endfor %}
    
    {%- comment -%}
      For subfolder items, we simply output them with indentation based on depth.
      (They may already be sorted reasonably by "path"; adjust as needed.)
    {%- endcomment -%}
    {% assign sub_in_group = sub_in_group | sort:"path" %}
    {% for spec in sub_in_group %}
      {% assign relPath = spec.path | remove: "specification/" %}
      {% assign parts = relPath | split: "/" %}
      {% assign depth = parts | size | minus: 1 %}
      <li style="margin-left: {{ depth | times: 20 }}px; padding: 4px 0;">
        <a href="{{ spec.url | relative_url }}">{{ spec.title }}</a>
      </li>
    {% endfor %}
    
  {% endfor %}
</ul>
