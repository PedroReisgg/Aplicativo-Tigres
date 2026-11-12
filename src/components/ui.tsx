"use client";

import { forwardRef, useEffect, useId, useRef, type ReactNode } from "react";
import { createPortal } from "react-dom";
import { Loader2, Search, X } from "lucide-react";
import { initials } from "@/lib/format";

export function cn(...c: (string | false | null | undefined)[]) {
  return c.filter(Boolean).join(" ");
}

type BtnVariant = "primary" | "secondary" | "ghost" | "danger" | "dark";
const BTN: Record<BtnVariant, string> = {
  primary:
    "bg-tiger-500 text-white hover:bg-tiger-600 active:bg-tiger-700 shadow-[0_1px_0_rgba(255,255,255,.25)_inset,0_1px_2px_rgba(180,66,16,.4)]",
  secondary: "bg-white text-ink-800 border border-ink-200 hover:bg-ink-50 hover:border-ink-300",
  ghost: "text-ink-700 hover:bg-ink-100",
  danger: "bg-red-600 text-white hover:bg-red-700",
  dark: "bg-ink-900 text-white hover:bg-ink-800",
};

export const Button = forwardRef<
  HTMLButtonElement,
  React.ButtonHTMLAttributes<HTMLButtonElement> & {
    variant?: BtnVariant;
    size?: "sm" | "md" | "lg";
    loading?: boolean;
    icon?: ReactNode;
  }
>(function Button({ variant = "primary", size = "md", loading, icon, className, children, disabled, ...p }, ref) {
  const sz = size === "sm" ? "h-9 px-3 text-sm gap-1.5" : size === "lg" ? "h-12 px-5 text-base gap-2" : "h-11 px-4 text-sm gap-2";
  return (
    <button
      ref={ref}
      disabled={disabled || loading}
      className={cn(
        "inline-flex items-center justify-center rounded-xl font-semibold transition-colors duration-150 select-none",
        "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-tiger-500 focus-visible:ring-offset-2",
        "disabled:opacity-55 disabled:cursor-not-allowed",
        BTN[variant],
        sz,
        className
      )}
      {...p}
    >
      {loading ? <Loader2 className="size-4 animate-spin" aria-hidden /> : icon}
      {children}
    </button>
  );
});

export function Field({
  label,
  hint,
  error,
  children,
  htmlFor,
  required,
}: {
  label: string;
  hint?: ReactNode;
  error?: string | null;
  children: ReactNode;
  htmlFor?: string;
  required?: boolean;
}) {
  return (
    <div className="flex flex-col gap-1.5">
      <label htmlFor={htmlFor} className="text-sm font-medium text-ink-800">
        {label}
        {required && <span className="text-tiger-600"> *</span>}
      </label>
      {children}
      {error ? (
        <p className="text-[13px] text-red-600" role="alert">
          {error}
        </p>
      ) : hint ? (
        <p className="text-[13px] text-ink-500">{hint}</p>
      ) : null}
    </div>
  );
}

const inputBase =
  "w-full rounded-xl border bg-white px-3.5 text-[15px] text-ink-900 placeholder:text-ink-400 transition-colors " +
  "focus:outline-none focus:ring-2 focus:ring-tiger-500/35 focus:border-tiger-500 disabled:bg-ink-50 disabled:text-ink-500";

export const Input = forwardRef<
  HTMLInputElement,
  React.InputHTMLAttributes<HTMLInputElement> & { label?: string; error?: string | null; hint?: ReactNode }
>(function Input({ label, error, hint, className, id, required, ...p }, ref) {
  const auto = useId();
  const iid = id || auto;
  const el = (
    <input
      ref={ref}
      id={iid}
      aria-invalid={!!error}
      required={required}
      className={cn(inputBase, "h-11", error ? "border-red-400" : "border-ink-200", className)}
      {...p}
    />
  );
  if (!label) return el;
  return (
    <Field label={label} error={error} hint={hint} htmlFor={iid} required={required}>
      {el}
    </Field>
  );
});

export const Textarea = forwardRef<
  HTMLTextAreaElement,
  React.TextareaHTMLAttributes<HTMLTextAreaElement> & { label?: string; error?: string | null; hint?: ReactNode }
>(function Textarea({ label, error, hint, className, id, ...p }, ref) {
  const auto = useId();
  const iid = id || auto;
  const el = (
    <textarea
      ref={ref}
      id={iid}
      className={cn(inputBase, "min-h-[96px] py-2.5", error ? "border-red-400" : "border-ink-200", className)}
      {...p}
    />
  );
  if (!label) return el;
  return (
    <Field label={label} error={error} hint={hint} htmlFor={iid}>
      {el}
    </Field>
  );
});

export const Select = forwardRef<
  HTMLSelectElement,
  React.SelectHTMLAttributes<HTMLSelectElement> & { label?: string; error?: string | null; hint?: ReactNode }
>(function Select({ label, error, hint, className, id, children, required, ...p }, ref) {
  const auto = useId();
  const iid = id || auto;
  const el = (
    <select
      ref={ref}
      id={iid}
      required={required}
      className={cn(inputBase, "h-11 pr-9 appearance-none bg-no-repeat bg-[right_.75rem_center] bg-[length:16px]", error ? "border-red-400" : "border-ink-200", className)}
      style={{
        backgroundImage:
          "url(\"data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%237A6656' stroke-width='2'%3E%3Cpath d='m6 9 6 6 6-6'/%3E%3C/svg%3E\")",
      }}
      {...p}
    >
      {children}
    </select>
  );
  if (!label) return el;
  return (
    <Field label={label} error={error} hint={hint} htmlFor={iid} required={required}>
      {el}
    </Field>
  );
});

export function SearchInput({
  value,
  onChange,
  placeholder = "Buscar…",
  className,
}: {
  value: string;
  onChange: (v: string) => void;
  placeholder?: string;
  className?: string;
}) {
  return (
    <div className={cn("relative", className)}>
      <Search className="pointer-events-none absolute left-3.5 top-1/2 size-[18px] -translate-y-1/2 text-ink-400" aria-hidden />
      <input
        type="search"
        value={value}
        onChange={(e) => onChange(e.target.value)}
        placeholder={placeholder}
        aria-label={placeholder}
        className={cn(inputBase, "h-11 border-ink-200 pl-10 pr-9")}
      />
      {value && (
        <button
          type="button"
          onClick={() => onChange("")}
          className="absolute right-2 top-1/2 -translate-y-1/2 rounded-lg p-1.5 text-ink-400 hover:bg-ink-100 hover:text-ink-700"
          aria-label="Limpar busca"
        >
          <X className="size-4" />
        </button>
      )}
    </div>
  );
}

export function Card({ className, children, ...p }: React.HTMLAttributes<HTMLDivElement>) {
  return (
    <div className={cn("rounded-2xl border border-ink-200/80 bg-white shadow-card", className)} {...p}>
      {children}
    </div>
  );
}

export function Badge({
  children,
  tone = "neutral",
  className,
}: {
  children: ReactNode;
  tone?: "neutral" | "tiger" | "green" | "red" | "amber" | "blue";
  className?: string;
}) {
  const t = {
    neutral: "bg-ink-100 text-ink-700",
    tiger: "bg-tiger-100 text-tiger-800",
    green: "bg-emerald-100 text-emerald-800",
    red: "bg-red-100 text-red-700",
    amber: "bg-amber-100 text-amber-800",
    blue: "bg-sky-100 text-sky-800",
  }[tone];
  return (
    <span className={cn("inline-flex items-center gap-1 rounded-full px-2 py-0.5 text-xs font-semibold", t, className)}>
      {children}
    </span>
  );
}

export function Avatar({ nome, color, size = 40 }: { nome?: string | null; color?: string | null; size?: number }) {
  return (
    <span
      className="inline-grid shrink-0 place-items-center rounded-full font-semibold text-white"
      style={{ width: size, height: size, fontSize: size * 0.38, background: color || "#3B2A1F" }}
      aria-hidden
    >
      {initials(nome)}
    </span>
  );
}

export function PageHeader({
  title,
  eyebrow,
  description,
  actions,
}: {
  title: ReactNode;
  eyebrow?: ReactNode;
  description?: ReactNode;
  actions?: ReactNode;
}) {
  return (
    <div className="mb-6 flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
      <div className="min-w-0">
        {eyebrow && <div className="mb-1 text-xs font-semibold uppercase tracking-[.14em] text-tiger-600">{eyebrow}</div>}
        <h1 className="font-display text-[28px] font-semibold uppercase leading-tight tracking-wide text-ink-900 sm:text-[34px]">
          {title}
        </h1>
        {description && <p className="mt-1.5 max-w-2xl text-[15px] text-ink-500">{description}</p>}
      </div>
      {actions && <div className="flex shrink-0 flex-wrap gap-2">{actions}</div>}
    </div>
  );
}

export function EmptyState({
  icon,
  title,
  description,
  action,
}: {
  icon?: ReactNode;
  title: string;
  description?: ReactNode;
  action?: ReactNode;
}) {
  return (
    <div className="flex flex-col items-center justify-center rounded-2xl border border-dashed border-ink-200 bg-white/60 px-6 py-12 text-center">
      {icon && <div className="mb-3 grid size-12 place-items-center rounded-2xl bg-tiger-50 text-tiger-600">{icon}</div>}
      <h3 className="text-base font-semibold text-ink-900">{title}</h3>
      {description && <p className="mt-1 max-w-sm text-sm text-ink-500">{description}</p>}
      {action && <div className="mt-4">{action}</div>}
    </div>
  );
}

export function Skeleton({ className }: { className?: string }) {
  return <div className={cn("animate-pulse rounded-xl bg-ink-100", className)} />;
}

export function Spinner({ label = "Carregando…" }: { label?: string }) {
  return (
    <div className="flex items-center justify-center gap-2 py-16 text-sm text-ink-500" role="status">
      <Loader2 className="size-5 animate-spin text-tiger-500" aria-hidden />
      {label}
    </div>
  );
}

/** Painel lateral (desktop) / folha inferior (celular) com foco preso. */
export function Sheet({
  open,
  onClose,
  title,
  description,
  children,
  footer,
  wide,
}: {
  open: boolean;
  onClose: () => void;
  title: string;
  description?: ReactNode;
  children: ReactNode;
  footer?: ReactNode;
  wide?: boolean;
}) {
  const ref = useRef<HTMLDivElement>(null);
  const last = useRef<Element | null>(null);
  useEffect(() => {
    if (!open) return;
    last.current = document.activeElement;
    const el = ref.current;
    const focusables = () =>
      el ? [...el.querySelectorAll<HTMLElement>("button,[href],input,select,textarea,[tabindex]:not([tabindex='-1'])")].filter((x) => !x.hasAttribute("disabled")) : [];
    setTimeout(() => {
      const first = el?.querySelector<HTMLElement>("input,select,textarea") || focusables()[0];
      first?.focus();
    }, 30);
    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") onClose();
      if (e.key === "Tab") {
        const f = focusables();
        if (!f.length) return;
        if (e.shiftKey && document.activeElement === f[0]) {
          e.preventDefault();
          f[f.length - 1].focus();
        } else if (!e.shiftKey && document.activeElement === f[f.length - 1]) {
          e.preventDefault();
          f[0].focus();
        }
      }
    };
    document.addEventListener("keydown", onKey);
    const prev = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    return () => {
      document.removeEventListener("keydown", onKey);
      document.body.style.overflow = prev;
      (last.current as HTMLElement | null)?.focus?.();
    };
  }, [open, onClose]);

  if (!open) return null;
  // portal no body: assim o painel cobre a tela toda, mesmo dentro de elementos animados
  return createPortal(
    <div className="fixed inset-0 z-[60]" role="dialog" aria-modal="true" aria-label={title}>
      <div className="absolute inset-0 bg-ink-900/45 animate-[fade-up_.2s_ease_both]" onClick={onClose} />
      <div
        ref={ref}
        className={cn(
          "absolute inset-x-0 bottom-0 flex max-h-[92dvh] flex-col rounded-t-3xl bg-white shadow-lift animate-fade-up",
          "sm:inset-y-0 sm:left-auto sm:right-0 sm:max-h-none sm:rounded-none sm:rounded-l-3xl",
          wide ? "sm:w-[640px]" : "sm:w-[480px]"
        )}
      >
        <div className="mx-auto mt-2 h-1.5 w-10 rounded-full bg-ink-200 sm:hidden" />
        <div className="flex items-start justify-between gap-3 border-b border-ink-100 px-5 py-4">
          <div className="min-w-0">
            <h2 className="font-display text-xl font-semibold uppercase tracking-wide text-ink-900">{title}</h2>
            {description && <p className="mt-0.5 text-sm text-ink-500">{description}</p>}
          </div>
          <button onClick={onClose} className="rounded-xl p-2 text-ink-500 hover:bg-ink-100" aria-label="Fechar">
            <X className="size-5" />
          </button>
        </div>
        <div className="flex-1 overflow-y-auto px-5 py-5">{children}</div>
        {footer && <div className="flex flex-wrap justify-end gap-2 border-t border-ink-100 px-5 py-4 pb-[max(1rem,env(safe-area-inset-bottom))]">{footer}</div>}
      </div>
    </div>,
    document.body
  );
}

export function Confirm({
  open,
  title,
  message,
  confirmLabel,
  danger,
  loading,
  onConfirm,
  onClose,
}: {
  open: boolean;
  title: string;
  message: ReactNode;
  confirmLabel: string;
  danger?: boolean;
  loading?: boolean;
  onConfirm: () => void;
  onClose: () => void;
}) {
  if (!open) return null;
  return createPortal(
    <div className="fixed inset-0 z-[70] grid place-items-center p-4" role="alertdialog" aria-modal="true" aria-label={title}>
      <div className="absolute inset-0 bg-ink-900/45" onClick={onClose} />
      <div className="relative w-full max-w-sm rounded-2xl bg-white p-5 shadow-lift animate-fade-up">
        <h2 className="text-lg font-semibold text-ink-900">{title}</h2>
        <div className="mt-2 text-sm text-ink-600">{message}</div>
        <div className="mt-5 flex justify-end gap-2">
          <Button variant="secondary" onClick={onClose} autoFocus>
            Cancelar
          </Button>
          <Button variant={danger ? "danger" : "primary"} loading={loading} onClick={onConfirm}>
            {confirmLabel}
          </Button>
        </div>
      </div>
    </div>,
    document.body
  );
}

export function Tabs<T extends string>({
  value,
  onChange,
  items,
}: {
  value: T;
  onChange: (v: T) => void;
  items: { value: T; label: string; count?: number }[];
}) {
  return (
    <div className="-mx-4 overflow-x-auto px-4 sm:mx-0 sm:px-0">
      <div
        role="tablist"
        className={cn(
          "gap-1 rounded-2xl bg-ink-100 p-1 sm:inline-flex sm:min-w-0",
          items.length > 3 ? "grid grid-cols-2" : "inline-flex min-w-full"
        )}
      >
        {items.map((it) => (
          <button
            key={it.value}
            role="tab"
            aria-selected={value === it.value}
            onClick={() => onChange(it.value)}
            className={cn(
              "flex h-10 flex-1 items-center justify-center gap-1.5 whitespace-nowrap rounded-xl px-3 text-sm font-semibold transition-colors sm:flex-none sm:px-4",
              value === it.value ? "bg-white text-ink-900 shadow-card" : "text-ink-500 hover:text-ink-800"
            )}
          >
            {it.label}
            {typeof it.count === "number" && (
              <span className={cn("rounded-full px-1.5 text-xs", value === it.value ? "bg-tiger-100 text-tiger-800" : "bg-ink-200 text-ink-600")}>
                {it.count}
              </span>
            )}
          </button>
        ))}
      </div>
    </div>
  );
}

export function ProgressBar({ value, color }: { value: number; color?: string }) {
  const v = Math.max(0, Math.min(100, Math.round(value)));
  return (
    <div className="h-2 w-full overflow-hidden rounded-full bg-ink-100" role="progressbar" aria-valuenow={v} aria-valuemin={0} aria-valuemax={100}>
      <div className="h-full rounded-full transition-[width] duration-500" style={{ width: `${v}%`, background: color || "#F26B1D" }} />
    </div>
  );
}

export function Checkbox({
  checked,
  onChange,
  label,
  disabled,
  tone,
}: {
  checked: boolean;
  onChange: (v: boolean) => void;
  label?: ReactNode;
  disabled?: boolean;
  tone?: "refazer";
}) {
  return (
    <label className={cn("inline-flex cursor-pointer items-center gap-2.5", disabled && "cursor-not-allowed opacity-60")}>
      <span className="relative inline-grid place-items-center">
        <input
          type="checkbox"
          className="peer size-[22px] cursor-pointer appearance-none rounded-md border-2 border-ink-300 bg-white transition-colors checked:border-tiger-500 checked:bg-tiger-500 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-tiger-500 focus-visible:ring-offset-1 disabled:cursor-not-allowed"
          style={tone === "refazer" ? { borderColor: "#DC2626", background: "#FEE2E2" } : undefined}
          checked={checked}
          disabled={disabled}
          onChange={(e) => onChange(e.target.checked)}
        />
        <svg className="pointer-events-none absolute size-3.5 text-white opacity-0 peer-checked:opacity-100" viewBox="0 0 16 16" fill="none" stroke="currentColor" strokeWidth="2.6">
          <path d="M3 8.5l3.2 3L13 4.5" strokeLinecap="round" strokeLinejoin="round" />
        </svg>
      </span>
      {label && <span className="text-sm text-ink-800">{label}</span>}
    </label>
  );
}

/** Marca de garras do tigre (decorativa). */
export function ClawMarks({ className }: { className?: string }) {
  return (
    <svg viewBox="0 0 200 200" className={className} aria-hidden fill="currentColor">
      <path d="M40 10c8 0 10 6 9 12L30 190c-1 6-9 7-11 1L12 30C10 20 28 10 40 10z" />
      <path d="M100 0c8 0 10 6 9 12l-14 186c-1 6-9 7-11 1L72 22C70 12 88 0 100 0z" />
      <path d="M160 14c8 0 10 6 9 12l-16 160c-1 6-9 7-11 1l-10-157c-2-10 16-16 28-16z" />
    </svg>
  );
}
