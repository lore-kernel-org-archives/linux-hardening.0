Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB2B3A75B0
	for <linux-hardening@vger.kernel.org>; Fri, 10 Apr 2026 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775843307; cv=pass; b=MB8Bc7q2FhuQxBCZHNK8fGlzoKegsNmXwo7ZKHbpgxrQTFh8nehVhlLTg9zyygg0+r+cjh2xKR6l9KAeqCo2njX7zmsuQ4RcvchcAsMj5ZBP+4iPLQXgBMBxoKiMf+9WsHw18ghPsIu127m5jfgrcj2xPWDCDteod75S6wyNNVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775843307; c=relaxed/simple;
	bh=fP8aWal1X6Qsox11Ia6GNPWsn7HNwxIrcnSxBo1eXxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8isbOW5ZrmtzwwBaTPkAKBMxWMnh6v0iG876rZP86TzerGpVZOjnYw1e+w4vkjCt/juYin94jsHgYTrupWgBD9uFc4QQ6Nf0Wjc8fXoVGHlWQN9M5afCkCHZhPKJkIUi5k1E8WT8Dq3JU2Rs4WOFGUL28SracqmU/SGNRspQCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gSQDBema; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gSQDBema"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-951c5ac6253so757286241.0
        for <linux-hardening@vger.kernel.org>; Fri, 10 Apr 2026 10:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775843305; cv=none;
        d=google.com; s=arc-20240605;
        b=JyNH9FzQm4dOxOIovOduRXKFeCZ359qwdP59Pn4ITwvV4EVTyfuYkpMHDzPXHym363
         GPmn9t9EmTvA813v43HKD2AkBG6eJkelWIgIJhabELw20eQYYzKSCeIwdfVaS8GUd0m/
         NohQeUbBBpCeHpxubc2vuI3hQfd5JJPuqeE+3wrVKMMoYzGRwRpnmvAhf09RO5ATbDpf
         I3PZS/NqUeTLWgFzTc/eE3g0e6OzN9rKDnWbQsu5zYhjumW1/Lavob+J9EGoETzknPHD
         NbOBtUdYA5A/KfUUSlkHdPR79L1MhwOe2AIiQ59KIiRu0G7uMJ8015W758Xi8Johmj4G
         A6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/l4nSTrukrhbCr2YaIjwfXniIaAMtCTR7SdWmyWxQV4=;
        fh=OZ4DtnWMu2Z1wHnio5lPGe7fQftSnmku7rUuKIwDO1g=;
        b=cculQZZ6WcQvhNxlwLEOOfov0xOhCW3FqZtliJGSnHT8IXgHQfeUxoZHz5aUZ31ovx
         n8ZyoDrgrsT+HFx2mi3usHHwa+CFRwYOFzInspjoZBdkedDjeyp0AW3BzBbphpZ+y3Lg
         iqRbTgJKVjtZFYVi6Cm807O7G4M/X230XVXnDjEH8aqMC0KMK2xE3ZAtUSGMTIbvfguc
         0o4iepq3AHUOv3ei9g+xOhxOfcuGPffshJVp9PDE7P9AnYYt1e+G5sanQYJIcvQIGo7o
         okvJLKi1kJtolzVEqB/btiTmCozpRNbDLvt/w1w/tG/kVVxHEgz5l0aeQgfvCXpBrLiE
         +cHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775843305; x=1776448105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/l4nSTrukrhbCr2YaIjwfXniIaAMtCTR7SdWmyWxQV4=;
        b=gSQDBemaBCVuUAhLqAdtcC033WLVaTqXhhUHappsfe6OonnsPA7yp1uQmMHmVhBe2a
         2nt9DT+5/sSX7WwBAHuo9ICl0EstSMIMgeUPgX89Tk6yHm92trgWiK9dXxDj8N+818Wx
         5utmoj6/EC9kT0wzhmWOoVLGwSBQ8O+lkf9Fc1wqV7YY/LFfOBlvjfYblbiQdmkrKQeT
         br5P3wdF2Km3utxoh9CSpR7tXWe0AOEQ4yUnIy7rQafxKmIhJFFzXfgYZqYFxX44FySP
         ocQJbflhiS/n7FgV9vknSUAmp//xB1neCvPwFKx/e6t/APYZgGBLvtJ+jw6hP2nxn8h+
         Za/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775843305; x=1776448105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/l4nSTrukrhbCr2YaIjwfXniIaAMtCTR7SdWmyWxQV4=;
        b=GrY1D3x21e1qClGYUbLzIm9nZ7HueY78wW0aHCd0yYzBYB9gkp89NhPF6F5VPtK1B/
         4PI5oGAr6HN3o3FlInmLf8az4OXoUqsUvQFfs0Telytyh4VnNgk5kz24W4hkNzWaEEVm
         e8IjAKa95t+dJal+jND4qckfIkfe6dsoSs88IPQBCDvoCp9zopqy8O/sHJf0fQau/Itq
         62Y0kDXEhJ2mSy0m0cFG0IYFqwyqrnfdnCCSlt2wVWEoH8B3NVhxq+TKuJF2Rgb9gCLE
         76+mAIBc/shp0aw4ag7lhD6/6+8fRUN9TiIRZgN70Khu7EpO3oe/PxyNSPACiii9Y87s
         eGwg==
X-Forwarded-Encrypted: i=1; AJvYcCWZIacJI5R+4NBZCPUORShplXQIp1Jgc29YYJWe/dbRaB9jgopvBIe6cZxgTXtOwERhr5KzfAzAuYeRbbsEWnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEoG3/aFL4o6YUGUOJqLz4gseeTeTDhF/yLxh1JcVxfkRzxT09
	iudW65EgZmxS+MNfqLz5P+t7QV3yhUz1VAZEj4JL92L5I5EWOJdDqQEUIZZu5mbD9uPv945k8Yj
	g8vtR7M5FDzNQvsrBdbvZSt/J+mtbDHxyyyqxNKed
X-Gm-Gg: AeBDiesC1Mtmv6RsQNbKx+o2VPh3+MmBLyRUREOEvSpbGVMkLiNik4qrsOZ64bE2rKQ
	uB1WIKikqsekQOXoZdxEazqcF9uKzWQ9Ep65hodbdAhjJ8l02MJWfb3RjRqJfx7nwTexJEMBiFW
	xRlHsyoGOk+y1Kacj+UblNjhdRcjALvQWGb3x17UJ3ZL5n655qZje8Fj8jUdntxYRxVmfcB7gpE
	gVfoIG8is740UpNev7lKMIS3hyNm7+OlAEOoGdhKumzHFSU65R6KbUxDslmpBp4zDbWtNGg6oJN
	ZcGbIMMoH+fPvuIuog==
X-Received: by 2002:a67:e7c1:0:b0:607:7991:f02e with SMTP id
 ada2fe7eead31-60a0125a157mr1913972137.26.1775843305006; Fri, 10 Apr 2026
 10:48:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331163716.work.696-kees@kernel.org> <20260331163725.2765789-5-kees@kernel.org>
 <CAHk-=wiJ6Q_qMHSe-hs+QvqKVZphvDZjvFP_gQLw1eaWimv8+w@mail.gmail.com>
 <202603311253.95C54588E@keescook> <CAHk-=wjSOGaausLeTD13yAqso7qM09EnkDFiN7wF15kH0VWmZQ@mail.gmail.com>
 <202603311321.4EE9FEA@keescook> <20260401083137.GT3738786@noisy.programming.kicks-ass.net>
 <202604011328.D3821379@keescook> <20260402053840.GD3254421@noisy.programming.kicks-ass.net>
In-Reply-To: <20260402053840.GD3254421@noisy.programming.kicks-ass.net>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 10 Apr 2026 10:48:13 -0700
X-Gm-Features: AQROBzBa6VKBq4ACJ1_R_EdvKeRsco9AeWVrSeipdWQAbkoYS53l26rCnLm5lXU
Message-ID: <CAFhGd8q_avLPfOsFkOd52eVJ7A50eKZ0HJo8ehqhG9P-s7P4-A@mail.gmail.com>
Subject: Re: [PATCH 5/5] types: Add standard __ob_trap and __ob_wrap scalar types
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <kees@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
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
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 1, 2026 at 10:38=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Apr 01, 2026 at 01:52:26PM -0700, Kees Cook wrote:
>
> > (Though I would note that GCC does _not_ refuse the jump when there is =
a
> > cleanup; it only see the other two uninitialized values.)
>
> Yeah.. I know, but since we also build with clang, any such issue will
> get discovered.
>
> > So that makes it not totally broken, but it does make it a bit fragile.
>
> Right.
>
> > Another concern I have is dealing with older compilers and how to
> > "hide" the label and its code. e.g. if I remove the "goto" from above:
> >
> > ../drivers/misc/lkdtm/bugs.c:1060:1: warning: label 'weird' defined but=
 not used [-Wunused-label]
> >  1060 | weird:
> >       | ^~~~~
> >
> > Oddly, the unreachable code isn't a problem, so we could just wrap the
> > label is some macro like:
> >
> > #define force_label(x) if (0) goto x; x
> >
> > force_label(weird):
> >         pr_info("value: %lu\n", value);
> >         pr_info("outcome: %zu\n", outcome);
> >
>
> __maybe_unused also works on labels. Like:
>
> __overflow: __maybe_unused
>         dead-code-here;
>
>

Completing the loop: Here's the Clang RFC discussing obt label handler
design [1]

[1]: https://discourse.llvm.org/t/rfc-linux-kernel-discusses-overflowbehavi=
ortypes/90486

Jusin
