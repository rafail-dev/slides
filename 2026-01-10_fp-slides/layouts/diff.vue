<template>
  <div class="slidev-layout">
    <slot />
    <div class="grid grid-cols-2 gap-4 mb-4">
      <div class="left">
        <slot name="left" />
      </div>
      <div class="right">
        <slot name="right" />
      </div>
    </div>

    <slot name="bottom" />
  </div>
</template>
