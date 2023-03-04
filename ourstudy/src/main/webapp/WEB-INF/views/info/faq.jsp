<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>Accessible Accordion</h1>
        
    <!-- Accordion 1 -->
    <section class="accordion" role="tablist" aria-live="polite" data-behavior="accordion">

      <article class="accordion__item js-show-item-default" data-binding="expand-accordion-item">
        <span id="tab1" tabindex="0" class="accordion__title" aria-controls="panel1" role="tab" aria-selected="false" aria-expanded="false" data-binding="expand-accordion-trigger">
          <p>Use the tab key to navigate...</p>
        </span>

        <div id="panel1" class="accordion__content" role="tabpanel" aria-hidden="true" aria-labelledby="tab1" data-binding="expand-accordion-container">
          <div class="accordion__content-inner">
            <p>You can cycle through all the different accordion items through tabbing.</p>
          </div>
        </div>

      </article>

      <article class="accordion__item js-show-item-default" data-binding="expand-accordion-item">
        <span id="tab2" tabindex="0" class="accordion__title" aria-controls="panel2" role="tab" aria-selected="false" aria-expanded="false" data-binding="expand-accordion-trigger">
          <h5>Or, you can use your mouse.</h5>
        </span>

        <div id="panel2" class="accordion__content" role="tabpanel" aria-hidden="true" aria-labelledby="tab2" data-binding="expand-accordion-container">
          <div class="accordion__content-inner">
            <p>This accordion can be used by both mouse and keyboard-only users.</p>
          </div>
        </div>
      </article>
      
      <article class="accordion__item js-show-item-default" data-binding="expand-accordion-item">
        <span id="tab3" tabindex="0" class="accordion__title" aria-controls="panel3" role="tab" aria-selected="false" aria-expanded="false" data-binding="expand-accordion-trigger">
          <h5>Click here to view more</h5>
        </span>

        <div id="panel3" class="accordion__content" role="tabpanel" aria-hidden="true" aria-labelledby="tab3" data-binding="expand-accordion-container">
          <div class="accordion__content-inner">
            <p>You can also use either the space bar or enter key to expand/collapse these panels.</p>
          </div>
        </div>
      </article>
      
      <article class="accordion__item js-show-item-default" data-binding="expand-accordion-item">
        <span id="tab4" tabindex="0" class="accordion__title" aria-controls="panel4" role="tab" aria-selected="false" aria-expanded="false" data-binding="expand-accordion-trigger">
          <h5>ARIA</h5>
        </span>

        <div id="panel4" class="accordion__content" role="tabpanel" aria-hidden="true" aria-labelledby="tab4" data-binding="expand-accordion-container">
          <div class="accordion__content-inner">
            <p>This accordion makes use of ARIA tags which help aid accessibility.</p>
          </div>
        </div>
      </article>

    </section>