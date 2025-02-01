---
title: "Specification"
layout: default
toc: true
toc_levels: 1..3 
categories: main-index
---

# Specification

<ul>
  {% for spec in site.pages %}
    {% if spec.path contains 'specification/' %}
      {% unless spec.categories contains 'main-index' %}
        <li style="display: inline-block; margin: 0 10px;">
          <a href="{{ spec.url | relative_url }}">{{ spec.title }}</a>
        </li>
      {% endunless %}
    {% endif %}
  {% endfor %}
</ul>