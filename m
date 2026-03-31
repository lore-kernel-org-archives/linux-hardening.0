Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAA33BE653
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 18:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774980593; cv=none; b=fSjPxAMz6bUWettlZjZkZWtGVdaOSCOU/8vw2wE+UNZnkXiOgt9tXqZ1As22pZMm+nCH2OYGJcu+KIBoXEPwvecgSuu6vFFvpSeYKr3KmGeQnomelXmZcEt7BRRpe0J7whUaj7XPYRPFe7Cz6yQYtFrnuJT+MdIVAiZ+j4QlN6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774980593; c=relaxed/simple;
	bh=yYwYSvStBtvkzXPBpl2nWuw/hu56cAHxTk2a5c8/rgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dsZoB+OH/UzFw82iIdEngz29cOvG8RC8yEulGKHTl/OaPTZx0C+ICGRSpzEuHYeDyskyFHAoNUdXM7qwBQrcu0ciCu6e0euguauAgsig47txbAu2oNfnMn/vMik7DxOfx6FY0tdoBFdeOgCm9mun8KbuvCTufU1G9RQtda9No5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hnf1izPU; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hnf1izPU"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9a0762ed5fso26463266b.1
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 11:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1774980590; x=1775585390; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TkZ5G8hekNnh++59TEnIGYyFMs6NypLCJp05Fo+wpQo=;
        b=hnf1izPUzhCo7tVw0xLRj0XfbB30Hyo54o7x6cUeWplnch1ukCdrQEo0ASs3vJvLuI
         wb/EwKdKE3gCznkiI9j+bJfw19dkW2mCsoMnW+zf7g5a8o29MBZPtAoV8ier2no79UX7
         vPT9A6XlH4I7vN56rtyTbK6AErjmfW86LL8F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774980590; x=1775585390;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkZ5G8hekNnh++59TEnIGYyFMs6NypLCJp05Fo+wpQo=;
        b=gG3rYZHVyT4FLunJc81gWK50uAIEXGC3jckxVeT1K4e3kEIdmz/yNrNWJAwsu43gut
         oCObV3ecPBs+MQ8EMYIAZhGfFDSfR0W9E/rw5SBdkeLjcHh8ACZOzGCGy/kgLPO9vj8n
         5C/mfxWHxtMGD4JgkugdNAlM6vKZ/FyQnwd/KPvVw+JOrSQqp5r+MhLXw7Ituc8DuoT+
         8/wQ5Zio1isQUlmRaO5RPpTfRC23nzG3J//+NpWoSopvvN1xFPre50swgLwSLHDhPCw3
         bvLH8UDMiUP83xKsKuSC8Pc7fPdIu4/0xYjbyCGJO8Jg6zg5pblnTt2g8Y+IlNnMLx0O
         eS/w==
X-Forwarded-Encrypted: i=1; AJvYcCXhbBo86H3tW4tZxSs2aUZZioRNY4IU6JOvTin/JOcGNUETrqatGWbB6eK5TpSzhtN+CIJHaWtb/DhWayYoZpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3sf4xTLwnw9UwEFghtEma/rDZtUPYD7z8QEqrNnM1KCSKs6/n
	HpbUmS/WbEHl6YJC7rrwNtN8T0UoOoLs/dLUMmDpc1qSpNFlbhcDe8dvn59pKT8ev0eowx4L/e+
	iPAWwYGW18g==
X-Gm-Gg: ATEYQzxTYp4hXK9HlcOtc5wP6SQ5e1qvxdRUBG25bx0yxLV5j7d2wwEW2f3tYG3u+9d
	1iTbFfGDDQ9wLu0a7CDMWu19QE+py7bcML94H5UIFHk+6k58fGcSfs7cE34QIUezTK8fM1/trs1
	EBZgnK49fHSDHGd1uoq2tvPUVS7hkmuTUy81/mKdi4v6SI/Dlg/PyyDzughjzojJH1RXArtqjx/
	3jsq3PNqDdDveWVaWAQeWHXrO1qgXh+5loNVa3DJ3i6CVBux7ewmx8aEMellr7H/Qvlfh8TeJdY
	9yAzFU3dT90ddnNLJwM9iMCVwmhtIRFYLgT/aUhadXhWUmhTgUOdXZs6N3jDDi/u3Mp3SiCa2mS
	Dc6XShTiDTRjKxEG9WmWYzRV+sPVBZNODeobQI6BxLe9tKPCto/PplFJHTpTysFBMFm+QLsGg/Q
	+AVmck7+EsgMmAoiohhPOY9VCezZEPaQrK4gG5bezKpkaE8cPm10pSqo/Su50G2pX3wFcnn66Q
X-Received: by 2002:a17:906:fe0e:b0:b96:f4f6:2a02 with SMTP id a640c23a62f3a-b9be88c3498mr248295966b.25.1774980589867;
        Tue, 31 Mar 2026 11:09:49 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66bf3e16f80sm2270531a12.25.2026.03.31.11.09.49
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 11:09:49 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66d65646c65so342795a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 11:09:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUpGOxPLmioMjZJb360qoEsTI/POVntWLm9pt7Kw37aw5ZHVXw3PEQ1bgRS3Qp1x0lRSc41zQOg/L5u+QszoEU=@vger.kernel.org
X-Received: by 2002:a17:907:984:b0:b9b:9e51:ec9a with SMTP id
 a640c23a62f3a-b9be8355c7bmr264682966b.7.1774980139544; Tue, 31 Mar 2026
 11:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331163716.work.696-kees@kernel.org> <20260331163725.2765789-5-kees@kernel.org>
 <CAHk-=wiJ6Q_qMHSe-hs+QvqKVZphvDZjvFP_gQLw1eaWimv8+w@mail.gmail.com> <CANiq72kL3rTKyDNYmD7wXiKCVJSfa1bnp2L8NShXU7OPmWjJ4w@mail.gmail.com>
In-Reply-To: <CANiq72kL3rTKyDNYmD7wXiKCVJSfa1bnp2L8NShXU7OPmWjJ4w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 31 Mar 2026 11:02:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjwHjmB0_2yXsOjDa7Mi_yFSx3AMd3vGk5r70WocvZZg@mail.gmail.com>
X-Gm-Features: AQROBzAduh7vXF0_QXfzo1P8tgp-mw59vEL4E4A0ltej3_oceWZyw3iWH8NeT84
Message-ID: <CAHk-=whjwHjmB0_2yXsOjDa7Mi_yFSx3AMd3vGk5r70WocvZZg@mail.gmail.com>
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

On Tue, 31 Mar 2026 at 10:48, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> In the Rust side, even if those "explicit" types like the
> `wrapping_u32` you suggest exist, we generally use the methods on the
> normal integers instead, e.g.

In that case the types in question should always be very much opaque,
and not usable as-is by existing compilers that don't have attributes.

My feeling is that that will discourage use enormously for when people
want to just say "yes, I know this wraps, and it's ok".

That said, for the *trapping* types, I do think that we likely need an
opaque type, because I really feel like using

   trapping_u32 x;
   ...
   x++;

is a complete and utter mis-design. It makes the "x++' have random behavior that

 (a) cannot be recovered from (maybe we're holding random locks)

 (b) is completely invisible in the context of the code, because the
type may be somewhere very different

and I think both of those are fundamental design mistakes.

And no, "dead machine" is *still* not an acceptable form of "that's
not random behavior".

So I think wrapping and trapping are fundamentally very different. The
words may look the same. The semantics may often be discussed
together. But one is explicitly marking something as "overflow is safe
and expected", and that's the actual real SAFE case.

The other is saying "overflow needs special handling". And the key
here is that we need to have some way to *state* what said special
handling is, and we need to do it at the point where that special
handling is needed. Not some generic exception handler that has to
figure things out from some unknown context.

Very very different things, and they need very very different
interfaces and very very different infrastructure.

Anything that says "these are two faces of the same coin and are just
different attributes on the type" is simply broken by design.

                 Linus
