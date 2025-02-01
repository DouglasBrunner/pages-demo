---
title: "Specification"
layout: default
toc: true
toc_levels: 1..3 
categories: main-index
---

# Specification

<ul style="list-style: none; padding: 0; margin: 0;">
  {% for spec in site.pages %}
    {% if spec.path contains 'specification/' %}
      {% unless spec.categories contains 'main-index' %}
        {%- assign relativePath = spec.path | remove: 'specification/' -%}
        {%- assign parts = relativePath | split: '/' -%}
        {%- assign depth = parts | size | minus: 1 -%}
        <li style="margin-left: {{ depth | times: 20 }}px; padding: 5px 0;">
          <a href="{{ spec.url | relative_url }}">{{ spec.title }}</a>
        </li>
      {% endunless %}
    {% endif %}
  {% endfor %}
</ul>
