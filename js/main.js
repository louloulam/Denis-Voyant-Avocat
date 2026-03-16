// ================================================================
// MAÎTRE DENIS VOYANT — AVOCAT — main.js
// ================================================================

document.addEventListener('DOMContentLoaded', () => {

  // ---- PAGE LOADER ----
  const loader = document.getElementById('pageLoader');
  window.addEventListener('load', () => {
    setTimeout(() => loader.classList.add('hidden'), 800);
  });
  setTimeout(() => loader.classList.add('hidden'), 2500);

  // ---- CUSTOM CURSOR ----
  const dot  = document.getElementById('cursorDot');
  const ring = document.getElementById('cursorRing');
  if (dot && ring) {
    let mouseX = 0, mouseY = 0;
    let ringX = 0, ringY = 0;

    document.addEventListener('mousemove', e => {
      mouseX = e.clientX;
      mouseY = e.clientY;
      dot.style.left  = mouseX + 'px';
      dot.style.top   = mouseY + 'px';
    });

    function animateRing() {
      ringX += (mouseX - ringX) * 0.12;
      ringY += (mouseY - ringY) * 0.12;
      ring.style.left = ringX + 'px';
      ring.style.top  = ringY + 'px';
      requestAnimationFrame(animateRing);
    }
    animateRing();

    document.querySelectorAll('a, button, .exp-card, .ccard').forEach(el => {
      el.addEventListener('mouseenter', () => ring.classList.add('hover'));
      el.addEventListener('mouseleave', () => ring.classList.remove('hover'));
    });
  }

  // ---- NAVBAR SCROLL ----
  const navbar = document.getElementById('navbar');
  const handleScroll = () => {
    navbar.classList.toggle('scrolled', window.scrollY > 60);
  };
  window.addEventListener('scroll', handleScroll, { passive: true });

  // ---- BURGER MENU ----
  const burger   = document.getElementById('navBurger');
  const navLinks = document.getElementById('navLinks');
  burger.addEventListener('click', () => {
    const isOpen = navLinks.classList.toggle('open');
    document.body.style.overflow = isOpen ? 'hidden' : '';
    burger.querySelectorAll('.burger-line').forEach((line, i) => {
      if (isOpen) {
        if (i === 0) line.style.transform = 'rotate(45deg) translate(4.5px, 4.5px)';
        if (i === 1) line.style.opacity = '0';
        if (i === 2) line.style.transform = 'rotate(-45deg) translate(4.5px, -4.5px)';
      } else {
        line.style.transform = '';
        line.style.opacity   = '';
      }
    });
  });
  navLinks.querySelectorAll('a').forEach(a => {
    a.addEventListener('click', () => {
      navLinks.classList.remove('open');
      document.body.style.overflow = '';
      burger.querySelectorAll('.burger-line').forEach(l => { l.style.transform = ''; l.style.opacity = ''; });
    });
  });

  // ---- SCROLL REVEAL ----
  const revealEls = document.querySelectorAll(
    '.exp-card, .hon-card, .ccard, .section-tag, .section-title, .section-sub, ' +
    '.cabinet-bio, .cabinet-valeurs, .citation-text, .aide-juridictionnelle, .cabinet-visual, .cabinet-info'
  );
  revealEls.forEach((el, i) => {
    el.classList.add('reveal');
    if (i % 3 === 1) el.classList.add('reveal-delay-1');
    if (i % 3 === 2) el.classList.add('reveal-delay-2');
  });

  const revealObs = new IntersectionObserver(entries => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
        revealObs.unobserve(entry.target);
      }
    });
  }, { threshold: 0.1, rootMargin: '0px 0px -50px 0px' });

  document.querySelectorAll('.reveal, .reveal-left, .reveal-right').forEach(el => revealObs.observe(el));

  // ---- COUNTER ANIMATION ----
  const counters = document.querySelectorAll('.hstat-num[data-target]');
  const counterObs = new IntersectionObserver(entries => {
    entries.forEach(entry => {
      if (!entry.isIntersecting) return;
      const el     = entry.target;
      const target = parseInt(el.getAttribute('data-target'));
      const duration = 1800;
      const start    = performance.now();

      const update = (now) => {
        const elapsed  = now - start;
        const progress = Math.min(elapsed / duration, 1);
        const ease     = 1 - Math.pow(1 - progress, 3);
        el.textContent = Math.floor(target * ease);
        if (progress < 1) requestAnimationFrame(update);
        else el.textContent = target;
      };
      requestAnimationFrame(update);
      counterObs.unobserve(el);
    });
  }, { threshold: 0.5 });
  counters.forEach(el => counterObs.observe(el));

  // ---- ACTIVE NAV LINK ----
  const sections   = document.querySelectorAll('section[id]');
  const navAnchors = document.querySelectorAll('.nav-item');
  const sectionObs = new IntersectionObserver(entries => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const id = entry.target.id;
        navAnchors.forEach(a => {
          const active = a.getAttribute('href') === `#${id}`;
          a.style.color = active ? 'var(--or)' : '';
        });
      }
    });
  }, { threshold: 0.4 });
  sections.forEach(s => sectionObs.observe(s));

  // ---- SMOOTH SCROLL ----
  document.querySelectorAll('a[href^="#"]').forEach(a => {
    a.addEventListener('click', e => {
      const href = a.getAttribute('href');
      if (href === '#') return;
      const target = document.querySelector(href);
      if (target) {
        e.preventDefault();
        const offset = 80;
        window.scrollTo({ top: target.getBoundingClientRect().top + window.scrollY - offset, behavior: 'smooth' });
      }
    });
  });

  // ---- CONTACT FORM (Netlify) ----
  const form       = document.getElementById('contactForm');
  const successMsg = document.getElementById('formSuccess');
  const submitBtn  = document.getElementById('submitBtn');
  if (form) {
    form.addEventListener('submit', async e => {
      e.preventDefault();
      const btnText = submitBtn.querySelector('.btn-submit-text');
      btnText.textContent = 'Envoi en cours…';
      submitBtn.disabled = true;

      try {
        const res = await fetch('/', {
          method: 'POST',
          headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
          body: new URLSearchParams(new FormData(form)).toString()
        });
        if (res.ok) {
          successMsg.style.display = 'flex';
          form.reset();
          setTimeout(() => { successMsg.style.display = 'none'; }, 8000);
        } else {
          alert('Une erreur est survenue. Veuillez appeler le 04 32 74 02 71.');
        }
      } catch {
        alert('Erreur de connexion. Veuillez appeler le 04 32 74 02 71.');
      } finally {
        btnText.textContent = 'Envoyer ma demande';
        submitBtn.disabled = false;
      }
    });
  }

  // ---- PARALLAX HERO SYMBOLS ----
  const syms = document.querySelectorAll('.sym');
  window.addEventListener('scroll', () => {
    const y = window.scrollY;
    syms.forEach((sym, i) => {
      const speed = 0.03 + i * 0.01;
      sym.style.transform = `translateY(${y * speed}px)`;
    });
  }, { passive: true });

});
