Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CBB2F83CC
	for <linux-hardening@vger.kernel.org>; Mon, 24 Nov 2025 23:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764027514; cv=none; b=gvgm0iwvBXxZpWgE7aViwucTy2tuYtpIdNK4C5GZYz+JpnAwKXQsceEzsnhlavsLlV+AFfa+PFNk5zaflEgOKOJUIBdXOoXQ7rcJ6QAZ5x+gXex2EK3UHCKe/vmViwUzmj1r4hQI/cW/qxYfx6Qwx4hfeOcF4epDw7xi+P8xsmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764027514; c=relaxed/simple;
	bh=UGDTE1zIjgVXgb2udlm6bjj0SaXznJcoEb+UkIEWurc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ge65T7HzEFP84R41mbMqYCTJ3oxCqvUWJFAGFKOqC/JSuaQD6fVDpwNVGpvHjqma1f5rmxk9xzmQ/GqfWfMlzExKWREPPsa8Tfe+qc4riM1Lw/jBTPI9F5jDMP1p3d+0iYx7anGvWQAvnstsS8EK7kDwzKLOOnzQVxJmXYdjyUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ENXnxU5S; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ENXnxU5S"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7370698a8eso636171666b.0
        for <linux-hardening@vger.kernel.org>; Mon, 24 Nov 2025 15:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764027508; x=1764632308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlci1y7yuwyEjVyvyPpVVR5+2jh2b1xf5fgy6sXkeBg=;
        b=ENXnxU5SRt5OgK9zuprOWH6vdJhvefqUK3PEPKe5tilun595Ky2CAiF1NiwYRSQriA
         1YHS51irQpdCWzigJhQAg9OtNPDVuAofSBzlidR9mGYm+UeMfUZtbF/httJpujgQCZxW
         5FBClmmDvXYi7kDi3FscMhMuISpo0cWJ4MKzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764027508; x=1764632308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rlci1y7yuwyEjVyvyPpVVR5+2jh2b1xf5fgy6sXkeBg=;
        b=m62OdFP1qp2hAsOx0RMilHWol0pcIXNdSbLJfF4eahEVdEcKqU4QPFy6C1YKbh4e9Q
         kC78LovNNtl+bU8idhzUhsrWGDWSNz5p4r6nanQDZIh8l6ekC8gMBGLnYRAYFo4M7rSq
         fLC6/ZC8VZfElEreQH4++3iiFlNowTsVTgpzwDDUhte2cMuwpPyjtMwrJ7JXMa9dCGiq
         Upis/xpUj1OP1N6bY+h9I7ayX5fp0qAQZTKmWKAVdekBMOgwB2AXlyk7MfUa+mTXAq08
         9V6SZA0bhfOx+LY63PQrUMUkNppZoiqeyxoJFndHVZOOjdk7xTxxp1GlXJupHPQdMlOq
         EKNg==
X-Forwarded-Encrypted: i=1; AJvYcCVHYKUaJL01/W3GKftccj2Ji/p/Qdf2bg+vvpkHLRVcrgdPkY44yxYL2tDtdpL2VgC8EXruk6OWYn4NyAybJEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0KPOtksTh1fSYkLCAKKrh2WivjFaz9Z6YGFYgNKqqQDheiTP0
	AFKQbYJo/aOLDRpgYFE3f9hV3l66hQ3mKuJM+2pnrdbAVYHgFVvJf99cHvvASRI5uQiaaZu+KLF
	+22oDYiE=
X-Gm-Gg: ASbGncsM0qcn6FV9XiQ65eawDCUp0uraRi7HdkqdvVy/lX00az3YFUVovVDyyCbMF76
	+Z4Gxy231enTpBTwEWGdRj/AxyxLq4oPdaq8OyQr3+/2C4iV4laVYOkjnxulnhKzIZHWlqX/0Gq
	W2J0g3H35bXVMKyXaKCoYHycPhVS6/HL3/ogXblocRCrYayqf8w+4fceqMrTrAtJY+7Vj0Ph33p
	Ic9NJmLE29yXH1q+zmnvshRfyEs8ioqP1V7BEE/Zzi7n6s+BWnduBGb/zQPjT0kOub8e3/OPT8o
	1mA7mtpjZkTMkHiNhTjlWY3RPsUvEfllo6ne/gTQq4OBqpf17sSlAoDSCJ1AGCxM9USuED7aNoW
	Muk+R68p4pCZ0cN/Scb6X3FXTIRgkh3k/XqTah0DwFelIzAiE3jlkCTWgwB7p6gwwVIzGoT/AGf
	k8Wv22FRKrSTkdvTUwAAVuCCNaqclF5DD7eK7nJDPnTutjma8id6hZ3fF6p9Su
X-Google-Smtp-Source: AGHT+IG5TGINuI4mRa3C8mdjqQw+4Om8zbQa8L+cu7P40BlenJRXxaCAE207F28WYU5k7I/M93qnWA==
X-Received: by 2002:a17:907:2da9:b0:b73:210a:44e with SMTP id a640c23a62f3a-b7671703d9fmr1290079766b.30.1764027508106;
        Mon, 24 Nov 2025 15:38:28 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d73430sm1439439466b.24.2025.11.24.15.38.26
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 15:38:27 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7633027cb2so888844466b.1
        for <linux-hardening@vger.kernel.org>; Mon, 24 Nov 2025 15:38:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX66VO6F24rVCm7Yarp3/FdNj6CzlRhBb86ie9zUhI6d7Iyq52A4KriC7GkltS14VpzhI2528wlISmS03v70Ec=@vger.kernel.org
X-Received: by 2002:a05:6402:278b:b0:640:cdad:d2c0 with SMTP id
 4fb4d7f45d1cf-6455468d57fmr11542593a12.25.1764027035833; Mon, 24 Nov 2025
 15:30:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122014258.do.018-kees@kernel.org> <20251122014304.3417954-2-kees@kernel.org>
 <CAHk-=wiNnECns4B3qxRsCykkHwzovT+3wG738fUhq5E+3Lxxbg@mail.gmail.com>
 <202511241119.C547DEF80@keescook> <aSTKLsRNiEKtDqPI@casper.infradead.org>
 <202511241317.516BDE7B@keescook> <aSTRsIUPeT5EC5An@casper.infradead.org>
In-Reply-To: <aSTRsIUPeT5EC5An@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 24 Nov 2025 15:30:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgn-2ieKtaHAXLLge1UFckLKa88vo3XOdLz+fP+DLpHGA@mail.gmail.com>
X-Gm-Features: AWmQ_bkk3_N4a125249CnpAkBAwWzpKOgurGjUm33RHuFAzjc01J9LWjmJhIWds
Message-ID: <CAHk-=wgn-2ieKtaHAXLLge1UFckLKa88vo3XOdLz+fP+DLpHGA@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] slab: Introduce kmalloc_obj() and family
To: Matthew Wilcox <willy@infradead.org>
Cc: Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Marco Elver <elver@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org, 
	Randy Dunlap <rdunlap@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Vegard Nossum <vegard.nossum@oracle.com>, Harry Yoo <harry.yoo@oracle.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jakub Kicinski <kuba@kernel.org>, Yafang Shao <laoar.shao@gmail.com>, 
	Tony Ambardar <tony.ambardar@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Alexander Potapenko <glider@google.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Nov 2025 at 13:44, Matthew Wilcox <willy@infradead.org> wrote:
>
> This third one is interesting.

Why?

> include/linux/jump_label.h:126:44: error: conversion to =E2=80=98long uns=
igned int=E2=80=99 from =E2=80=98s32=E2=80=99 {aka =E2=80=98int=E2=80=99} m=
ay change the sign of the result [-Werror=3Dsign-conversion]
>   126 |         return (unsigned long)&entry->code + entry->code;
>
> static inline unsigned long jump_entry_code(const struct jump_entry *entr=
y)
> {
>         return (unsigned long)&entry->code + entry->code;
> }

I'm not seeing the confusion. 'entry->code' is a signed 32-bit entry,
and we're adding it to the address of the entry itself (well, the
address of the 'code' member of the entry, but it's the first thing in
that struct, so same thing in this case).

The next function in that file (which uses "target", which is *not*
the first entry in the struct) then makes it clear that we actually do
all these relative offsets relative to the address of the relative
offset itself, not the base address of the struct.

But that's actually just a random implementation decision.

That all a very standard thing in assembly programming, which this is
all about. 'entry' is a signed offset from its own address.

And yes, the exact thing you are relative to may differ. When looking
at instruction sets, sometimes the relative address is relative to the
beginning of the current instruction (I think m68k did that), and
sometimes it's relative to the *end* of the instruction (I think x86
does that).  It could even be relative to the actual byte *inside* the
instruction, although I can't think of an example of that.

Sometimes it's relative with a shift (basically all fixed-size
instruction CPU's do that since instructions are all mutually
aligned).

So that's whole "exactly what is it relative to, what are the sizes
involved, and are there maybe shifts" etc just a design choice.

The whole "offset is relative to its own address" that this code uses
is probably the simplest form it can have.

> The warning is ... not the best phrased, but in terms of divining the
> programmer's intent, I genuinely don't know if this code is supposed
> to zero-extend or sign-extend the s32 to unsigned long.

What?

A signed value gets sign-extended when cast to a larger type. That's
how all of this always works. Casting a signed value to 'unsigned
long' will set the high bits in the result.

That's pretty much the *definition* of a signed value. It gets
sign-extended when used, and then obviously it becomes a large
unsigned value, but this is how two's complement addition
fundamentally works.

This is bog-standard and happens all over the place. We have things like

        unsigned long xyz =3D -1;

in various places, this is not some kind of unclear area of the standard.

And for all the same reasons, the programmers intent is obvious too.
'code' is s32 and is signed for a reason - so that you have a +-2GB
relative offset. And this is not some kind of unusual pattern when
we're talking about relative branch targets.

Now, if you don't know about things like relative branch targets in
low-level assembly, maybe this is code you have to look over several
times, but this code is literally ABOUT re-writing branches in
assembly language, and this kind of pattern where you use relative
offsets is traditional.

And yes, the offsets are literally smaller than the address space, and
the signed offsets get sign-extended as part of this all: that's very
traditional too.

Basically no 64-bit CPU has 64-bit branch offsets (and few 32-bit
CPU's have full 32-bit branch offsets - x86 happens to do it, but most
RISC CPU's tend to have branch offsets that are in the ~20 bit range
and if you have big relative branches you need to do those with a
separate constant section or something like that).

So honestly, what's the problem with this code?

The warning makes no sense, and is garbage. Are we not allowed to add
signed integers to unsigned 64-bit values now, because that addition
involves that cast of a signed 32-bit entry to an unsigned 64-bit one?

There is NO WAY that warning is valid, it's; not *ever* something we
should enable, and the fact that you people are discussing it as such
is just crazy.

That code would not be improved at all by adding another cast (to
first cast that s32 to 'long', in order to then add it to 'unsigned
long').

Imagine how many other places you add integers to 'unsigned long'.
EVERY SINGLE ONE of those places involves sign-extending the integer
and then doing arithmetic in unsigned.

                 Linus
