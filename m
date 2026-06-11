Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327E225C6EE
	for <linux-hardening@vger.kernel.org>; Thu, 11 Jun 2026 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781175142; cv=pass; b=V3Z5+t8yknHlxUwODtsj/xbA+BwS36qtPmAsVaWtTXWpRky7p+JwK0UZR+HLmTzGMM222WQ/iV908vXcMUQ5MR375g+J18ql1Bwswp22q5jiodvfRSa+csslys2Om9D16QN0Xe3VdCYtfKzzaKybmOWn3wsTwGO4puQQE95pjg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781175142; c=relaxed/simple;
	bh=CoKnhxMO2caWXdLLMnNcKzbbEymDX/LtwNqls/lmxyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sG6BPl13batVmVA4qNRygqiT+wwa2oicFuifmIwWsK4Iv5/OJB9ldjd8OOf2uO23TO1yuAfJyFA6AdwfRm92+lZ2+ymEteiddJvqQOnruWtMucCo8h4gh0MVsNOFxWJ+UvbBOvS5R+/5j0EroBr0y6W940eVvELfoPKAPHuVO7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=Z5N2C9V0; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="Z5N2C9V0"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45efb698ef2so3914368f8f.3
        for <linux-hardening@vger.kernel.org>; Thu, 11 Jun 2026 03:52:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781175139; cv=none;
        d=google.com; s=arc-20240605;
        b=a7XgRlqM5IFLoCQV2Z4H2fBf9LFPhSVyI7RhF6qgyBrRteEApsxiBdZ8yEXRsBees7
         o2Y72ir6EdtYGOWk0A8PpjZpSA/a+Dr8Im0jrRmB6egJJgthlKljI12sbuTuHoX2ReuW
         sUjjTT/qQanLwFPUQXdSR3RI4cVxzkJ13m67bWsSLu5x5iTKVaYQg+kd/iNU3Jy2tMQ6
         czx4I5g0pBI5qWh80TCSGVxcUT55UueX1hlIgv1cY0zfKKYmyTZ3PrDwKi1JLUtdNG78
         8/ox+VIMgiA2Mf0aovFA0PTpLAHs/0opPQb4S28xkHO6y0DwD4zuQ3IdLQUv5nQjwbJ4
         yyTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CoKnhxMO2caWXdLLMnNcKzbbEymDX/LtwNqls/lmxyg=;
        fh=VIImgtqjFaUvjoryJoGfBB8qcWeoXg/kch3tCD3saNk=;
        b=Ip0fwQW7/93CayiSxHLxfJuvYXl/8S0Xcd3rqf7MQhmhGtlLLwvZP8haoIifYpd+yE
         U4ZS7KkDEqyprjkgCL5OwCIM5geEEmfYwmOAdU7ujpx2CDsKJ8sFtqaMwyexsebNneIm
         WCnZLduE1SAhBVM15/iPc5Umpdev1x5pKyUEYSdWYbcxajdHmyR4/rH4Bt51Aw5tr/es
         SuxWtN6W4EsnKSV6mA4DQVSLu/4s7n4CzP2AdWpFj09zRs/cz40eB57V76AoLs6h6Y1C
         uEwGVcgi21knU5O3eXVVrc5PNvNVnD+xJkSZ4doM9VacnbJPogrANuFCbZqRTMWvgt4t
         ftNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1781175139; x=1781779939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoKnhxMO2caWXdLLMnNcKzbbEymDX/LtwNqls/lmxyg=;
        b=Z5N2C9V0apJyhQ4LvfODkjA9X4PIsiXPsft+lENAuGcNkBK+9qvshb9zXJjM1r5iwm
         JR8+avTELUenUQBZvAgOfNr5EStPj34p0fT9gy6SQni+hiGc3JluMsD/nJ4Q/Klsgqm9
         9tbsObkQCQX0+6jKpiEYCXoZHg9jfvqsg64sjGMb+3EOYPb5JOI1ppZmBazfwDal2+9v
         IcX0DU1r59UFZwUTVYDFq0qUAmb+v1FwGZicKXBunncMHFZ2VH8+0wvzTK/3jP1PXJme
         6L/pH1dZFYPyy6Ib8d9lfwj63mYms/MaLfC1moqVXqokW52HXHKMdjjRO7JENd7IicEg
         kHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781175139; x=1781779939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CoKnhxMO2caWXdLLMnNcKzbbEymDX/LtwNqls/lmxyg=;
        b=SUvb3MwJfM5smtOiGVn+BoM/u03VJqKV0CS2u3vdp1PrHLCqivRUMNn8+AzKIp3uPq
         lYp1cnCH53y1A9tXYYHH0KEcD4FgHCxNxvLVPE9TeebTuYrMLbxqaZ/lTjSxPhu7at5p
         Hua1aNqs/2+CsfcKlebEhy0V26Va23IV7KElZ8kjw+LuG4xJJsyqkJEitsfWuBZReWAm
         9AR6zF/gx0QpwmrPe42WMzBRE53t7hoFYEJRXTxAsKqWsXg5rMW0YLXDEnttpkoTyLl9
         muvLa6aNCF0D7Mn/a/7qOdzMtF1nIjK77yNBNGI2VBiWf4B1Au4o8kp7JE9BnhGMZCcP
         upYA==
X-Gm-Message-State: AOJu0YxSpKRYsKq9RlRBLNC4QGs0PNK9EHj0OKqfyin7783VpLmyCW2G
	VRMTG1bJY1xtkydQBJKL9HGXO5sTFqLWq05+JCJ8ALpEmM+248paRVC8TF3PotjDGHudKxZryZw
	IAjF2/OOpaH/Mnb7vUD7iFtu7OYlVQfx/PcisFJP8cssWMnvSZT4A4pyvDlE=
X-Gm-Gg: Acq92OEA3jvxWgJLJ4+LUyoH/fPIN10rkz4RiYFTLt4zcS8y1Fq3G6DGwHfcj34Nyf8
	tzOjMa9r+YDZ8mFkUp+jZiBoNLAtao7pyzt2rLBMko1ZfLh3DzGHnDCoH+No/ginkccgU/XN2nG
	WbYRClEHXV1qqY3PNsfPrdHwQiygCCikpFIGiqE4Mhk/65Zr65nshV3LCoMHY9kNST/gNTezFXO
	KsW9+pXPUnmJHnJeyZAedx909Z2zO9IprPooWU+C9HhDwBs80pvvg+uRMGxqlDF/Es/keDboO98
	GwQLSE96ykWyXSyaanj4msAcPNX6ll5sDSvriWgY86lEwFSnPg==
X-Received: by 2002:a5d:584e:0:b0:45e:da9b:97d6 with SMTP id
 ffacd0b85a97d-460677c1500mr3457025f8f.27.1781175138786; Thu, 11 Jun 2026
 03:52:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605202511.79272-1-yjn@yjn-systems.com> <202606101302.B3C79CFA86@keescook>
In-Reply-To: <202606101302.B3C79CFA86@keescook>
From: Jasper Niebuhr <yjn@yjn-systems.com>
Date: Thu, 11 Jun 2026 12:52:08 +0200
X-Gm-Features: AVVi8Cc-xJRtwl4q8adaoQOTr1yJaXWIidMLwR-5QZRFbe81TxYZ5Mi6jCYYMUo
Message-ID: <CAMjCObtshD-W-rdhS7fMjC_OtXjYLz-nftE0c=dqe1tdJybFyQ@mail.gmail.com>
Subject: Re: [RFC 0/7] Bootpatch-SLR: Randomizing Linux Kernel Structure
 Layouts at Boot
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org, franzen@sec.in.tum.de, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 10:12=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> Thanks for working on this! I asked the Sashiko folks to give this
> series a review, just so you have some more immediate feedback:
> https://sashiko.dev/#/patchset/20260605202511.79272-1-yjn%40yjn-systems.c=
om

Thanks a bunch, there appear to be quite a few useful comments there.

> > The design goal of SPSLR is to eliminate the need for runtime lookup
> > tables or similar indirection mechanisms. Structure access instructions
> > are patched directly to reflect the randomized field offsets before
> > normal kernel execution begins.
>
> The implementation looks very similar to relocation fixups; is it
> possible to create a new relocation type for this so it more naturally
> fits into the ELF image? The .data/.rodata annotations likely need to
> remain a separate section, similar to how existing things like fault
> instrumentation works (i.e. from the sanitizers for things like KCFI,
> UBSAN, etc).

To use relocations, I believe we would have to add a custom relocation type
that does not use some symbol's address but a value from a table which is
generated/populated by the randomizer. Existing relocation types could only
really be reused if the randomizer patched the ELF symbol table at runtime,
which would be possible but awkward.

At the moment, the pinpoint plugin contains what is essentially a
"micro assembler"
which is capable of producing only the x86_64 "mov immediate into
register" gadgets
with labels on the immediates that act as patch sites later. This is
what makes the
current plugin architecture-dependent and considerably more complex
than it probably
needs to be.

In the end, these simple mov gadgets should be folded into the actual memor=
y
access operands that depend on field offsets, for performance reasons.
At that point,
there would be many different kinds of patch sites so the current approach =
would
require a not-so-micro-anymore assembler built in. Hence, a custom
relocation type
might be a lot cleaner and easier to maintain.

How does one typically go about adding a custom relocation type? My
understanding
is that this cannot be done from a GCC plugin alone and would instead
require changes
to both the compiler and assembler.

> > I have also attempted to port BPSLR to v6.18 and later releases. While =
I
> > got the system to build, occasional runtime failures currently prevent
> > successful operation.
>
> I do wonder if getting the plugin merged into Linux's gcc plugin
> infrastructure would solve this (i.e. it would get run/not run at the
> right times, etc). I suppose it's possible it won't help, of course.

Missing some files entirely could of course cause crashes, but I do
not think this
was really the issue here. It was more like the occasional crash, once in a=
 few
boots. If some truly important file was missed entirely, I would expect the
crashes to happen more frequently, but that is just the impression I got wh=
en
running it a few times.

But I will definitely try merging the plugin into the existing infrastructu=
re.

> > In particular, I would be interested in pointers to areas that are
> > likely to require special handling, as well as assumptions made by the
> > kernel that may not be obvious to someone approaching the problem from
> > outside the subsystem in question.
>
> Targeting task_struct is quite a challenge! I wonder if you might want
> to start with a different subset of the __randomize_layout-marked
> structs? I know there are a bunch of filesystem and network structs that
> maybe aren't quite as sensitive to early boot like I imagine task_struct
> is.

The idea was that if it would work for task_struct, it would likely have
encountered most of the special cases. The early-boot argument may
matter though.
IN THEORY, current randomization happens before the second task is created,
so only the init_task exists at that point. Accessing it before and
after SPSLR is
applied should not be an issue, as long as no pointers to fields in
init_task are
created before and used after randomization (they would not be patched). I
absolutely do not know if such pointers exist, I just hope they don't.

That risk could be reduced by moving the randomization and patching to an
earlier point in the boot process. It currently just happens as "late"
because the
early RNG and memblock are available by then, but SPSLR does not really
need the other systems that are initialized during boot.

Anyways, I will see if I can find a few suited structs that are less
involved so early
on and make good candidates for early development.

> What did you need to make exceptions for in the task_struct? I suspect
> that may also be a hint as to why getting this ported to the latest
> kernel isn't easy?

These exceptions are actually not related to crashes. The pinpoint
plugin's first
marking mechanism replaces relevant field offsets with function calls to
__spslr_offsetof(struct id, field offset), simply to reliably track
them at later stages.
This causes expressions to become impossible to evaluate at
compile-time. Because
of this, the fields I had to fix in place caused compiler errors.
Specifically those used
in asm-offsets and the static initializer of the init_task (list head
pointers into the init_task
itself) require field offsets to be known at compile-time.

I am not aware of other marking mechanisms that are available to plugins an=
d
reliably survive IR transformations. There might be better options
available when
porting this directly into the compiler.

Thanks,
Jasper
