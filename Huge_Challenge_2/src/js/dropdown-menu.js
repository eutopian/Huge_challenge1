  var addStyleString = function (declaration) {
    var styleNode = document.createElement('style');
    styleNode.innerHTML = declaration;
    document.head.appendChild(styleNode);
  };

  var resetMenu = function () {
    var activeElements = Array.prototype.slice.call(document.querySelectorAll('ul .active'), 0);

    activeElements.forEach(function (elem) {
      elem.classList.remove('active');
    });

    copyright.classList.toggle('active');
  };

  var animate = function (event) {
    var activeListItem = document.querySelector('.primary-item.active'),
        logo = document.querySelector('.mobile-bar > img'),
        target = event.target,
        elements = [logo, target, navBar, body, content];

    elements.forEach(function (elem) {
      elem.classList.toggle('active');
    });

    menuOpen = !!body.classList.contains('active');
    if (activeListItem) {
      resetMenu();
    }
  };

  var hideCurrentSubmenu = function (sibling) {
    if (currentActiveSubmenu && currentActiveSubmenu !== sibling) {
      currentActiveSubmenu.classList.remove('active');
      event.path[1].classList.remove('active');
      resetMenu();
    }
  };

  var fixCopyrightPosition = function () {
    var navBarHeight = document.querySelector('.navbar').clientHeight,
        listHeight = document.querySelector('.primary-nav').clientHeight,
        top = navBarHeight - (listHeight + copyright.clientHeight + 1),
        cssRule = '\n\tli.copyright { top: ' + top + 'px }' +
            '\n\tli.copyright.active { top: 0 }\n';

    addStyleString(cssRule);
  };

  var activeSubmenu = function (sibling, event) {
    hideCurrentSubmenu(sibling);

    event.target.classList.toggle('active');
    sibling.classList.toggle('active');
    event.path[1].classList.toggle('active');
    currentActiveSubmenu = sibling;
  };

  var showSubmenu = function (event) {
    var link = event.target.querySelector('a'),
        nextSibling = event.target.nextSibling;
    if (event.target.tagName === 'LI') {
      event.preventDefault();
      link.click();
      return;
    }

    if (nextSibling) {
      copyright.classList.toggle('active');
      activeSubmenu(nextSibling, event);
    }
  };

  /**
   * The toggleMenu statement controls the event triggered by the hamburger menu
   * on mobile devices.
   * @param event {function}
   */
  var toggleMenu = function (event) {
    if (menuOpen) {
      menuButton.click();
    }
    console.log(getDeviceState());
    copyright.classList.contains('active') && copyright.classList.toggle('active');
    menuOpen = false;
  };

  // Initializer
  var initDropDownMenu = function () {
    var mainList = document.querySelector('.primary-nav');

    menuButton.addEventListener('click', animate, false);
    content.addEventListener('click', toggleMenu, false);
    mainList.addEventListener('click', showSubmenu, false);

    copyright = document.querySelector('.copyright');
    fixCopyrightPosition();
  };