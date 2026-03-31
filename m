Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD2738B15F
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774981981; cv=none; b=sxSduoiB5ANZH5PPrm+3wKdqmvfTaD23yj/QCOvEyOWoifYuLynwdjzwGsrtrnfN7LQUp1u+olhD8aMAKEkH5lvezCzy19a5G2KTkA6WF8mfC+6ZOctDrVkoQTfpmSmMSiR1a+q4WGBkNuNVGn+j2OKg+slXVqNSXdHLON784IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774981981; c=relaxed/simple;
	bh=ox6OjjUW3Qe6xBaqwUnJk6bmk2llYCPNtvoc4SxKSSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxVrgPUYvDZYUqfx/nFsoor7fP6rZf8XYFLlpFwMF/5iIqEpK+kD1AT7nM+fkXORy6geDOfJ87ZvSiT2GO335SXj1t+7XJM5i1dWs2GVLRNPnKs286lLpDIbw0zLvmzUJ5dfqTPClcqORha4TBHPTNeYX+lx38orknK/F+Se08o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EZokQMO8; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EZokQMO8"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38cb8e42d1dso6975581fa.0
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 11:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1774981977; x=1775586777; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ag9HU1BRKwZOnlae6UtSCfLk/g8PIJV9tSPEI30VDdc=;
        b=EZokQMO8rtA1RyJmnQexX2tXna9QnvUBiaXpg7oexcvavnwtbvS/ImsuJ1Nvls3he4
         0ORnSgrcCLpnyB3vx1SKMcPYSlG1fpw54fJTQ4xzI6XWEUPT84J+lTqgKoXl4goF1mC2
         h9s4p/F+SDpdGtzvb01KwaL5bdC6RtUHRLjBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774981977; x=1775586777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ag9HU1BRKwZOnlae6UtSCfLk/g8PIJV9tSPEI30VDdc=;
        b=Ffv4MFj0D2OhjCeY7GS2wGOm0HAY/63B69Vc6Axsrb5/VVJvmYgcRgUoT+gDovgfxT
         EUEefcW1N2kk9Tf54zfAlcXyISfPMxm4BTu0O0J33+AvKivURtywSNjjidiswVdlN/gk
         A6MB5scAU0wqWKlVYjmDYDDtciRP4rhhI69uPRtYl1yY+imG9paSd41kUQLxzpAwiO34
         GdYENXbwQmUeHXj+5vFxI2mA4x++sjTsSy4QKZoMwzcwTd4BymdnkUyGxEkTiT2GnRAm
         fD/0o4+t9s1R9D6ptnPG9cTxgKzjPPcSDMU7AZv0ciLk267ONerEiX0EDMfY45Wd0BIW
         pZ7w==
X-Forwarded-Encrypted: i=1; AJvYcCWBRyNwJ3dGJH3UTn2nQfUMzgiG7n9IwarLo2KUyeLwBQ0hP77Ihiot6T5J+PZbWTqUAZBK8Z1jf7Twc3J49TU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEc9a632wb27zbt8mki/TbE+LaXBbMOkRzBbO7gatbZOyAGBSm
	bCxCoHOT9QI8DhFeMrNY1I8qyrpBFPkFeuOX/Ydm0BWTim1kJ1iCtlBWD7bjFs1/NuA5tKaLP/r
	7v5W7SD71kw==
X-Gm-Gg: ATEYQzzjYjNSkyXK+iqeMnxGqXVFCWd6Mk8SdMzq1WjCXp7hC0JsziDcJoV45SZ3f0K
	7IiRuJ82nbe8k2DD+2XWrqe/F7SsBC4m9moJSeLKeAlvP1VcAAwo6JBYLYj908zkQfV6E+WUGeR
	GaBijUOEvfsJom34HEdikmXrVSenhdlQoMKATKrXfsWwU9D3WOZ9QTQ0S9Rj40eSjbbtI6w+r0B
	ObmUK2FhMtBaBp0f0xAqwLrJIk7p/Xdd9/sNDRXg1d3i/rvRQSoWDkN7Lhn7lU8I0lIPn1fzyIG
	RyE84luRdVc5AT54h2xN2At53Exudfz2rbsM3Cyyp1Ty9n0bL6OxdtKCCKGhsJTnrPiRy27oBTg
	yJ04feOLmZ/OWsIgOwu0k8x5gaVzmfpSAFt41hAnco/p/PBAJBm0O5iTDqyb/ON+huu6Sn3cBgX
	0QLVyqS5Cxgf8Y2t2WLrSZeXFPhbzjb0Wy3k0TqWzVElF1x3g7u+MeI888FT158bAmgLRW8b3Z
X-Received: by 2002:a05:651c:2354:20b0:38c:6979:f75d with SMTP id 38308e7fff4ca-38cc31102bbmr982021fa.34.1774981977301;
        Tue, 31 Mar 2026 11:32:57 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38c8389202asm23542241fa.24.2026.03.31.11.32.56
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 11:32:56 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a27b5ad832so6931299e87.2
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 11:32:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWLwuSxuBGWjjlb7eXf5PZ0HNcE/nGMEIYy+eOoDOwpR0ukM7H+g86PzIYV6y/ETttW3EmIuIsV/xJv0Re9L4=@vger.kernel.org
X-Received: by 2002:a17:907:8b8a:b0:b98:51d6:8843 with SMTP id
 a640c23a62f3a-b9c13b17382mr46677666b.28.1774981536085; Tue, 31 Mar 2026
 11:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331163716.work.696-kees@kernel.org> <20260331163725.2765789-5-kees@kernel.org>
 <CAHk-=wiJ6Q_qMHSe-hs+QvqKVZphvDZjvFP_gQLw1eaWimv8+w@mail.gmail.com>
 <CANiq72kL3rTKyDNYmD7wXiKCVJSfa1bnp2L8NShXU7OPmWjJ4w@mail.gmail.com> <CAHk-=whjwHjmB0_2yXsOjDa7Mi_yFSx3AMd3vGk5r70WocvZZg@mail.gmail.com>
In-Reply-To: <CAHk-=whjwHjmB0_2yXsOjDa7Mi_yFSx3AMd3vGk5r70WocvZZg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 31 Mar 2026 11:25:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgKB5f3MM40FGGUWUm_9eyESe2PAqCa6uZ=YTi0CdPwDg@mail.gmail.com>
X-Gm-Features: AQROBzBMzOVzd6q58CfNv9Gmf6_GDcPc6oKe55iXDcY89snM0DHbCtfJXA4J_DE
Message-ID: <CAHk-=wgKB5f3MM40FGGUWUm_9eyESe2PAqCa6uZ=YTi0CdPwDg@mail.gmail.com>
Subject: Re: [PATCH 5/5] types: Add standard __ob_trap and __ob_wrap scalar types
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Justin Stitt <justinstitt@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, 
	Mark Rutland <mark.rutland@arm.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, Finn Thain <fthain@linux-m68k.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	llvm@lists.linux.dev, Marco Elver <elver@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Nicolas Schier <nsc@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 31 Mar 2026 at 11:02, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The other is saying "overflow needs special handling"

Btw, this is why I also completely despise the current overflow builtins.

Yes, they handle overflow. But they don't treat it as some *special*
thing. They are garbage that forces code that uses them to be garbage.

If you want to use the overflow builtins (or our wrappers aorund
them), you can't just do the math. You have to do crazy crap like

     int end;
     if (check_add_overflow(start, len, &end))
        ... handle overflow ...
     do_something(start, end);

which obviously no sane person will do, when they can just write

   do_something(start, start+len);

instead (particularly since usually that "start+len" is just a tiny
detail in the code anyway).

Notice how it breaks up the code logic, and also requires you to add
random intermediate variables etc. It's bad, it makes the code look
bad, and people don't use it as a result.

The reason people like exception handling is that you can make the
fixup be done elsewhere, and you *don't* have to deal with it at the
point where you just want to use the result and with silly
intermediate variables etc.

IOW, exception handling means that you can continue to use the normal
flow of code for the normal case, and you deal with errors separately.

That is good. Much better than the "check_sub_overflow()" kind of crazy thing.

So I very much understand why all modern languages do it - but at the
same time most exception handling is complete garbage, because almost
everybody ends up thinking that it should nest syntactically, which is
completely wrong.

Error handling does not nest: it exits. If you have two different
exceptional cases in the same expression or statement, they have no
inherent nesting, and the order isn't even someting you should care
about. But they can cause different error codes or different fixups,
and they need *separate* handling.

This is why the kernel user space exception handling ended up with a
"label" model the moment the compilers could deal with it (in fact, I
very much asked for that interface, and compilers finally gave it to
me after years).

It means that you can move the exception handling out of line, without
having to interrupt the actual normal code flow. And youc an do it
without the bogus nesting that makes no sense.

So I think overflow handling should do the same. Instead of the bad
"check_sub_overflow()" model we have now, we should have

     res = add_overflow(a,b,label);

and now you can use a trapping operation *without* having to break the
normal flow of code, ie you can do

      do_something(start, add_overflow(start, len, overflow))
      ...
  overflow:
      // Maybe needs to release locks, who knows
      return -EINVAL;

notice?

Wrapping does not need this kind of thing. Wrapping is literally a "I
know I don't need to care", while trapping is a "I know I need to
handle it".

It's just that handling the trapping should not need to be done right
where the operation is done.

And in C, that means "goto". And I actualyl will claim that "goto" is
superior to most crazy language models with some "try()" block that
nests.

Language designers have been corrupted by "things must nest". BS.

             Linus
