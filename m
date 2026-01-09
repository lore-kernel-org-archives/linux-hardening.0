Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6B2359F8A
	for <linux-hardening@vger.kernel.org>; Fri,  9 Jan 2026 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767959184; cv=none; b=hs6Q5EGeQ0I9I/6ZEa9kXhPhkEyaokLDfQKEIzgd+JJUmTM1JpkVDnVefI+3ehkaxqwBNLx5Hp0A2uu+lp7HGiQo0yBoY48KQSoic8eUfU1y9XtV2FZofxAiGKJszr+GwxwHvqFZKe+BeJJAAmdbX17ByzvZROhZ/8Tdrz71CV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767959184; c=relaxed/simple;
	bh=ypSd1k1fDdDvkq9MmwX1P7222DKq+jOg+Wtiq0cBRAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pu63bbhk9ZYmwZN64uDE2LX6JsIuBjTyN72iDDtXusOs1QArWSaq67eQcCs3UlM/4efnIa7wc92P1fh7S4kRA2LzjwmiNM7A+QX+AgCO2ob+shgord1/xX7KU19N4JM9Rds8L1nJKdObMMs2AVfs4hUgbqjYDPb2fO0bF+qqCbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmF3aSj2; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmF3aSj2"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5636470c344so619544e0c.2
        for <linux-hardening@vger.kernel.org>; Fri, 09 Jan 2026 03:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767959174; x=1768563974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CojmIQLwgA7YJf0zKqJAw51DsDqgF9KaeELaRdHkqFY=;
        b=YmF3aSj23virv2cXFyc8lBGDhay1dZnvuoHpRuTgfmKXOkUAB9Q0sD8u8xJSmHdov0
         01ozs4mDNwkyS1vCpevg7Y9JHPAiNHXb6p3juasvmsPJAtASScQZmCmpHhRZxWjoNpcX
         glTa3+pNekNQpW4Uf1z6q9+u8KOn8sFyIxvcLC0OKi7dmwPWZSg5d/ZoRrLdPQ2J2Xnb
         kn7wS4m63P7lji4aWkF04gGzgWBWqryZLTCb0jzo9Rim6uxjO7GBYPirHEkW1QSXSYkV
         sMyuGiWEnotqUBM3NVXQwfF9imDw7mk2dEB2s7Q7Avhh7x+EK6lpZL7fiQ+tgOiy+X84
         Nqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767959174; x=1768563974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CojmIQLwgA7YJf0zKqJAw51DsDqgF9KaeELaRdHkqFY=;
        b=J7YHM6NR9AvI6VIhCOgsc1r4u7LW6PCDzTOoA7gAouOwA6iEhya1W4cLD2u962zBF1
         hYhgi9L5+0ETKjp4TlEYR6BEvSWsC7xKc9IqXQevtFVBn+YC+0hGUd9ZphjKq049Gjid
         W74Z8Viy+jElbeU5PsyhJwGHXB1Cs0NTNB5y5fsB2u1VB8ZcG9L/ug4rLITQmX61ZJ9V
         4DCmUgkI7pQkzfUi/OGPCyQGjBBkPmJzVIebp5Mgfxn3ynsOTSgu9EcWB0mCICCTTN2s
         jKnXAjmFS71cosBH7Me1dxsujtm92Caioy8HEzSvI9AXK3a434rIJBPH1w432sVBr6YB
         7DZA==
X-Forwarded-Encrypted: i=1; AJvYcCUW+CMVg6Zo5hgTb9Gy7R5w7SGdG5bKM0VLdapvn9PVU6B2pSG/61Gv5y3x+Fkc0xOJcFNcX8WI9L9W8VEURKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFlsnrVlR+VH+R3HnQw4Ey4z64LltGMvARFww4FK9SElc12GOu
	hjQqhf3/J3SZVgeAB/tEjK1kjo1qeaGt2uSQzJqYba7Y2drM4zyrzr0qnDvrE9GmhZZgE3oxVQO
	wwC84c/NuXAFQyVtzqBYdZFKfRyeFQLdl
X-Gm-Gg: AY/fxX4aRYEa4CW3qhrR2ScfRoR9lMUThOa71JcoJWR4ldassC5DFEfSzeGGNZt4mbs
	gW+zNXH03CW8fnGfY9C23YWqhbp+e1IiKHFAIzRcUwC+0ku6ORWOi5SUhFzDsSR+Cf/hsFLXWgR
	n1A+JRRXcKx/u9aQs4iGsxDGteQzyhchC06Xnv/HZYDZJP1exmZOi0iXuB+7EXZAqwL0+RXZOvn
	+pwupxKK2Kwr7YmFlTY0o3bj/VuegVVpiZq8qI0uFyNxhlVTILQewc9dayohm/L36oG5QucxAug
	DuMvc4Mf8A==
X-Google-Smtp-Source: AGHT+IGS0ILenq5F/qGZHrvPObFvKyR5FK0KFhzsFl1SMvXQnnYX9ydwxHrfntAMMBKMHQsEk28pRZN1Xae/xzXL4tM=
X-Received: by 2002:a05:6102:604b:b0:5ec:bf40:51e9 with SMTP id
 ada2fe7eead31-5ecbf4054a9mr3900904137.29.1767959174516; Fri, 09 Jan 2026
 03:46:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108092526.28586-21-ardb@kernel.org> <20260108092526.28586-36-ardb@kernel.org>
 <CAMzpN2jZDEh2r1UwV2JOqUD+JH65TZo+RQxFOx5Hwd1GC0p+hA@mail.gmail.com> <CAMj1kXGPGjgcoQDBRcUSj7vLrTUC7-n4GXBMb4+D_Szb6rHFfg@mail.gmail.com>
In-Reply-To: <CAMj1kXGPGjgcoQDBRcUSj7vLrTUC7-n4GXBMb4+D_Szb6rHFfg@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Fri, 9 Jan 2026 06:46:02 -0500
X-Gm-Features: AZwV_Qi6owiKvJm-LWDruoXMVFFOanvIsnyglIfQjy-T6QRc_-WBfvKOd1dTlcw
Message-ID: <CAMzpN2iJ8QFuDq+Sov81X103x7q_-ueoO-nJwEjnF3GpKf2W0g@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 15/19] x64/acpi: Use PIC-compatible references in wakeup_64.S
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Uros Bizjak <ubizjak@gmail.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 2:59=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Fri, 9 Jan 2026 at 06:01, Brian Gerst <brgerst@gmail.com> wrote:
> >
> > On Thu, Jan 8, 2026 at 4:28=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org>=
 wrote:
> > >
> > > Use ordinary RIP-relative references to make the code compatible with
> > > running the linker in PIE mode.
> > >
> > > Note that wakeup_long64() runs in the kernel's ordinary virtual mappi=
ng
> > > so there is no need to record the address of .Lresume_point in a glob=
al
> > > variable. And fix the comment while at it.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/x86/kernel/acpi/wakeup_64.S | 11 ++++-------
> > >  1 file changed, 4 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/=
wakeup_64.S
> > > index 04f561f75e99..15233a4e1c95 100644
> > > --- a/arch/x86/kernel/acpi/wakeup_64.S
> > > +++ b/arch/x86/kernel/acpi/wakeup_64.S
> > > @@ -14,7 +14,7 @@
> > >
> > >  .code64
> > >         /*
> > > -        * Hooray, we are in Long 64-bit mode (but still running in l=
ow memory)
> > > +        * Hooray, we are in Long 64-bit mode
> > >          */
> > >  SYM_FUNC_START(wakeup_long64)
> > >         ANNOTATE_NOENDBR
> > > @@ -41,7 +41,7 @@ SYM_FUNC_START(wakeup_long64)
> > >         movq    saved_rsi(%rip), %rsi
> > >         movq    saved_rbp(%rip), %rbp
> > >
> > > -       movq    saved_rip(%rip), %rax
> > > +       leaq    .Lresume_point(%rip), %rax
> > >         ANNOTATE_RETPOLINE_SAFE
> > >         jmp     *%rax
> >
> > If this is already running on the virtual mapping, this can simply be
> > changed to a direct jump.
> >
>
> Indeed, but I couldn't figure out how to do so without making objtool unh=
appy.

I replaced it with a simple "jmp .Lresume_point" and objtool seemed
fine with it on a defconfig build.  What error did you see?
