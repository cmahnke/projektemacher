const SELECTOR = '[data-collapse-toggle]';

const runningTransitions = new WeakMap<HTMLElement, () => void>();

function targetOf(trigger: HTMLElement): HTMLElement | null {
  const href = trigger.getAttribute('href');
  return href === null ? null : document.querySelector<HTMLElement>(href);
}

function transitionDuration(target: HTMLElement): number {
  return Number.parseFloat(window.getComputedStyle(target).transitionDuration);
}

function isShown(target: HTMLElement): boolean {
  return target.classList.contains('show');
}

function applyTriggerState(trigger: HTMLElement, expanded: boolean): void {
  trigger.setAttribute('aria-expanded', expanded ? 'true' : 'false');
  trigger.classList.toggle('collapsed', !expanded);
}

function afterHeightTransition(target: HTMLElement, finalize: () => void): void {
  const duration = transitionDuration(target);
  if (Number.isNaN(duration) || duration <= 0) {
    finalize();
    return;
  }
  const listener = (event: TransitionEvent): void => {
    if (event.target !== target || event.propertyName !== 'height') {
      return;
    }
    target.removeEventListener('transitionend', listener);
    runningTransitions.delete(target);
    finalize();
  };
  runningTransitions.set(target, () => {
    target.removeEventListener('transitionend', listener);
    runningTransitions.delete(target);
  });
  target.addEventListener('transitionend', listener);
}

function expand(trigger: HTMLElement, target: HTMLElement): void {
  runningTransitions.get(target)?.();
  applyTriggerState(trigger, true);
  target.classList.remove('collapse', 'show');
  target.classList.add('collapsing');
  target.style.height = '0px';
  void target.offsetHeight;
  target.style.height = `${target.scrollHeight}px`;
  afterHeightTransition(target, () => {
    target.classList.remove('collapsing');
    target.classList.add('collapse', 'show');
    target.style.height = '';
  });
}

function collapse(trigger: HTMLElement, target: HTMLElement): void {
  runningTransitions.get(target)?.();
  applyTriggerState(trigger, false);
  target.style.height = `${target.getBoundingClientRect().height}px`;
  void target.offsetHeight;
  target.classList.remove('collapse', 'show');
  target.classList.add('collapsing');
  target.style.height = '0px';
  afterHeightTransition(target, () => {
    target.classList.remove('collapsing');
    target.classList.add('collapse');
    target.style.height = '';
  });
}

function toggle(trigger: HTMLElement): void {
  const target = targetOf(trigger);
  if (target === null) {
    return;
  }
  if (isShown(target)) {
    collapse(trigger, target);
  } else {
    expand(trigger, target);
  }
}

function syncTrigger(trigger: HTMLElement): void {
  const target = targetOf(trigger);
  if (target !== null) {
    applyTriggerState(trigger, isShown(target));
  }
}

function syncAll(): void {
  document.querySelectorAll<HTMLElement>(SELECTOR).forEach(syncTrigger);
}

document.addEventListener('click', (event) => {
  if (!(event.target instanceof Element)) {
    return;
  }
  const trigger = event.target.closest<HTMLElement>(SELECTOR);
  if (trigger === null) {
    return;
  }
  event.preventDefault();
  toggle(trigger);
});

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', syncAll);
} else {
  syncAll();
}
