Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09B131A069
	for <linux-hardening@vger.kernel.org>; Fri,  9 Jan 2026 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963085; cv=none; b=l475HA/HVEJpm9WVkhfXF66aXCl0g8AFxynVNidECsp/HNv54EJpuk+33haA7fIe/DtXtNakSeoYc03Y2w1n/B6TXQUu4pLn1JRRreKzF92LvUkdrGbAHGkurjDPmVOPyV2TkGL4ZA39hg5qNxuyt113wRRXCFAf23OKKFdw0vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963085; c=relaxed/simple;
	bh=LfFKNMWxgWSxtU6kV5hMnkuezWO0CV0MDfQnm14RkRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXcKUmTTHdbG+W/Ui1eJOjxoeiKVXagED/C+4te0o7J9+tUy5vwT4do2jImTBmXAYzHQitr9J2thpp82EG96YO4a23SibI7eJixpVZF1psAZ0LH6B5Mey8+mn8qFGQGrcpcYALHH8Uzorj+9Uhh/vnVMaNn5MeC39h9qwp0F+Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MP2KG7dx; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MP2KG7dx"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5ed065f1007so1926741137.1
        for <linux-hardening@vger.kernel.org>; Fri, 09 Jan 2026 04:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767963083; x=1768567883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rl+yXuqzqV/6U5pHYvYQ5YfdNJptOVgFZ79ft6q1eWM=;
        b=MP2KG7dxne0xXFBfbzu0v1RjTu7kNMfDy6Uq690SA9n8bi+TdqhD0I+z73j4gCpDMS
         e6NvJvYtpJYrgNfprU7PCLslXpORT3p0XZQvkWMKLWMqMQ0v8n6mFNjnhwgFrc9uw9KS
         khSe4uO5gLguCUun4RP133f0X5Dr6aAckt1F61oVwJnYPx9LlDYCDTa7YvbD5M2edU44
         2aJs47Q+wpJA1DqsmG0yUBhNLU5FhQhw/VFgc7n2Y6Ke/O+ZBuH2WU6jOfcwgOac6+Cr
         sBJWHuYCq4Ag8tUq9NAFB5QGpqAgq6cZMEeaRPXqJXKdLwkZPNs3jDV482PmntIqHpQq
         6UcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767963083; x=1768567883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rl+yXuqzqV/6U5pHYvYQ5YfdNJptOVgFZ79ft6q1eWM=;
        b=qx9EvNhsO1YXOKVNZKv33+5WACk82YKYglCRHfbX75F8RViXlwNinYSB5iFYxst8Sx
         vV2ZljSwsA+iJ2JUSv6S1yk6Z51rqfMQegFMl6bUg85je9LnGPeFiRR6tt5zlGQNSfPH
         YMSWPwxL/4zB4mHPMp4LdMlrHwa4LCXXolmDQg2jXypuYy0JuyVyXCUaeXqgBtjIbk7a
         UA8Nj0s/dgoYh8frM4Pjc4x+x4CHqpHi2RglMmvByKCN8GU/teXB2WC2kkuS5QCrwEnD
         X3vCf9fPPuJgFgTA6gI6d+qYBDtQrBqnnOHzYEuz8ZGE1M7+K0TBhbFQ0zy1LeK87kWp
         WKtg==
X-Forwarded-Encrypted: i=1; AJvYcCWRBuoPGocJgr5ucH71YvslVjUADg/GgZci59wyuusM+SMpErkqCTZKh/LXHHeaDPBxnh3D5tKNZmFNn3fgtuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+BlPCPloG/rd+4yXftAxHtISyEGp5dhSd1iubuW03/5S0lN4M
	s+l4M8VinBCj2xp8In0t4KzuB5UCSLGWAlL3nJSq7ZaWRmqqAmr9gse/YbelMqW+7+PoWWCt+sX
	FY7v7SCE7J7ALylDXBsXlhhBaLxLOnw==
X-Gm-Gg: AY/fxX6R9hHyIit3hGt8sVU0fDPe9OrSKMDzufrGhAGGqLDZ/edKNhUNeoroqC+CuMQ
	PBQzmoKsz+y7SPFsiQfS01MCagocDZ8Pa1BJ6og3XL5uJ4KifVzOTnptROuyZNVD9YET9I7JUOM
	lOD3XY4oNTUSwKfNOyPVqrVBVx485ZA26+3KLypeXQtPwl3KPZQePHRObzltpWgXDGH3n5sWgI/
	bErA7PURggwlXl7B3u/Fxhztdg0jqWWMmkAeJhOemWXuAbJsiaAjFN6gjtZxY7bXdazhd2llII/
	Xyc3ShWwxg==
X-Google-Smtp-Source: AGHT+IG7L85PkQ0U6+cfyqejfbsA/Zdr7vcKO4pxoAIJ9GcnxqH/erasJIsbHJ6/lpvFcGBepZg4t6oTBu17nP/LqU4=
X-Received: by 2002:a05:6102:e0b:b0:5df:aa69:beab with SMTP id
 ada2fe7eead31-5ecb6962646mr4195729137.29.1767963081279; Fri, 09 Jan 2026
 04:51:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108092526.28586-21-ardb@kernel.org> <20260108092526.28586-36-ardb@kernel.org>
 <CAMzpN2jZDEh2r1UwV2JOqUD+JH65TZo+RQxFOx5Hwd1GC0p+hA@mail.gmail.com>
 <CAMj1kXGPGjgcoQDBRcUSj7vLrTUC7-n4GXBMb4+D_Szb6rHFfg@mail.gmail.com>
 <CAMzpN2iJ8QFuDq+Sov81X103x7q_-ueoO-nJwEjnF3GpKf2W0g@mail.gmail.com>
 <CAMj1kXHzdG9mypXYRDxACrO0ZoScT8x1Cz+cxcKcAvSeNrET4g@mail.gmail.com> <CAMj1kXE59iJd-GGq4w0oZ99Lf7MswdOUSf11UASrqqWUUwW+zg@mail.gmail.com>
In-Reply-To: <CAMj1kXE59iJd-GGq4w0oZ99Lf7MswdOUSf11UASrqqWUUwW+zg@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Fri, 9 Jan 2026 07:51:09 -0500
X-Gm-Features: AZwV_Qii7-dcbBqeOnQ8meM0nK_qiiGbnA8iYYNL-EM95-1eWIGhpjKZm8O3W8U
Message-ID: <CAMzpN2h_iEPXFqFtSatjZJZgKOa-r8JfG+4iGQFioOvT-Dms=Q@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 15/19] x64/acpi: Use PIC-compatible references in wakeup_64.S
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Uros Bizjak <ubizjak@gmail.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 7:10=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Fri, 9 Jan 2026 at 13:09, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 9 Jan 2026 at 12:46, Brian Gerst <brgerst@gmail.com> wrote:
> > >
> > > On Fri, Jan 9, 2026 at 2:59=E2=80=AFAM Ard Biesheuvel <ardb@kernel.or=
g> wrote:
> > > >
> > > > On Fri, 9 Jan 2026 at 06:01, Brian Gerst <brgerst@gmail.com> wrote:
> > > > >
> > > > > On Thu, Jan 8, 2026 at 4:28=E2=80=AFAM Ard Biesheuvel <ardb@kerne=
l.org> wrote:
> > > > > >
> > > > > > Use ordinary RIP-relative references to make the code compatibl=
e with
> > > > > > running the linker in PIE mode.
> > > > > >
> > > > > > Note that wakeup_long64() runs in the kernel's ordinary virtual=
 mapping
> > > > > > so there is no need to record the address of .Lresume_point in =
a global
> > > > > > variable. And fix the comment while at it.
> > > > > >
> > > > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > > > ---
> > > > > >  arch/x86/kernel/acpi/wakeup_64.S | 11 ++++-------
> > > > > >  1 file changed, 4 insertions(+), 7 deletions(-)
> > > > > >
> > > > > > diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel=
/acpi/wakeup_64.S
> > > > > > index 04f561f75e99..15233a4e1c95 100644
> > > > > > --- a/arch/x86/kernel/acpi/wakeup_64.S
> > > > > > +++ b/arch/x86/kernel/acpi/wakeup_64.S
> > > > > > @@ -14,7 +14,7 @@
> > > > > >
> > > > > >  .code64
> > > > > >         /*
> > > > > > -        * Hooray, we are in Long 64-bit mode (but still runnin=
g in low memory)
> > > > > > +        * Hooray, we are in Long 64-bit mode
> > > > > >          */
> > > > > >  SYM_FUNC_START(wakeup_long64)
> > > > > >         ANNOTATE_NOENDBR
> > > > > > @@ -41,7 +41,7 @@ SYM_FUNC_START(wakeup_long64)
> > > > > >         movq    saved_rsi(%rip), %rsi
> > > > > >         movq    saved_rbp(%rip), %rbp
> > > > > >
> > > > > > -       movq    saved_rip(%rip), %rax
> > > > > > +       leaq    .Lresume_point(%rip), %rax
> > > > > >         ANNOTATE_RETPOLINE_SAFE
> > > > > >         jmp     *%rax
> > > > >
> > > > > If this is already running on the virtual mapping, this can simpl=
y be
> > > > > changed to a direct jump.
> > > > >
> > > >
> > > > Indeed, but I couldn't figure out how to do so without making objto=
ol unhappy.
> > >
> > > I replaced it with a simple "jmp .Lresume_point" and objtool seemed
> > > fine with it on a defconfig build.  What error did you see?
> >
> > arch/x86/kernel/acpi/wakeup_64.o: warning: objtool: wakeup_long64()
> > falls through to next function do_suspend_lowlevel()
>
> Note that this is x86_64_defconfig with CONFIG_X86_KERNEL_IBT disabled.

I do see the error now.  I had missed it when building the .o file and
thought it would show when linking vmlinux.

I was able to make objtool happy by embedding wakeup_long64() into
do_suspend_lowlevel() and using SYM_INNER_LABEL_ALIGN().
