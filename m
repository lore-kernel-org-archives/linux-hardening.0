Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFA72BDC2F
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 23:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775001042; cv=none; b=QTGALl5m9zXO8w/EtT5RCr3z8/iLPnQDv6BOIqSO4NDbwpYvLKt8/EcnBrZiToM7oKEY1hGSjzg89v4aYHQsNRGdPe2WGIhTNqy4wizWbqRFB3xWavZ/0dfXi6xvWBm4rBLcID+/Y6x9TnKCHeD5f9P0czkwYUtkS5Ov0GzRyM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775001042; c=relaxed/simple;
	bh=hi1MFskNb8DMYSQRnhoouww2qda97qGJwbTEd7MQFUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txbP1Sb0V5qOe4nqBw3NiRtVGvVZ8OI+myYpW1yhMtpdog+YaUgZ3BMJz6tTgiGwlVk/YJp1WkKuj98KHe1QgRjgRm9I2/TTQ529kVYYeTuuM8FubaQ93Y8FO3Z9oCrBsuID12kun27craM9RbeVTLlu2xIaPEV5WOKIDtkE554=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Is9ciocF; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Is9ciocF"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9358dd7f79so109085066b.1
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 16:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1775001039; x=1775605839; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ap740lhReTUh/Tx7odelrkvzzjajL/UYRtgEhV3gotU=;
        b=Is9ciocFd6b8ELtOQOxf/CNDQEeUKi3qiRP/X5IecBSn8KKX6yomYYs5mp5+0uSEBn
         iI3k4WKZFIkU8ZwI5YdnDnntbCuhD0y4LVYQrtQQllOZXYWRc9ofA8D6retEYGDthTkU
         rianVrEcvd5XTyIAkO/f0rYSKKdOJz7pL5IWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775001039; x=1775605839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ap740lhReTUh/Tx7odelrkvzzjajL/UYRtgEhV3gotU=;
        b=iYF0Rl6A/kg38idQI79UN2Emg/HDpFwQkzMi4uQ4iCxbifvr55VHVPluZAPw2LJcYU
         gvnfSyF8GdEz/IEkZUpf/aCfPjoYGfJToLrqrUE5jjWM9CkfhpM0rE9xURucoS9nRm/D
         AZYjKSoqgBRxXfBzWKM4SMBz24LJBG6a3Z+3cHlh4ZqEZ5kMb1spBCX8RKwq3Q2RRiRB
         kViFhY76F9ArN+9A3uY6zxRaK0Q/sxiyX2PPXF6prTnIlPBSXbb0ghQ6g3UcE9zXinSP
         +tX4nKC8w3YyepK6MnnkDgpWyf5/D1pSl3dCO3D40cV+iz8hqIVoL8MaP6JgicvfHRBt
         AjPw==
X-Forwarded-Encrypted: i=1; AJvYcCUPteH4gdhYzJqqV8eoKhXK7N0IZTyn9j5TOSTpmPCMPgqR1UgEN5Fr8TdLr1ERlcpIWar3W+lqo+2rJzkQRwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFfZnWr1YMumqF7t14YCNzp2+HjqPL42Uf/B4zmx6USl8cNXSt
	A0C6R4ikYUTQgAeTi97VCUaIpNQoO9O9sNghXo3kAQTWC8AHOZ50L/68bJ0JSbJ1KcZ7eWhFlLt
	yrDbLosrN5Q==
X-Gm-Gg: ATEYQzyEKJysTDyTfzwinImefJapOVt5aDLlJWf+LkB5ldNj0TP07R71L+AcGPCtnvo
	ml9zqfvkUF5MSMmZasbum5+TTz75DcO+GgNSA892q3Xa6anWU+x4bi+DeTOJHoEnoAaVJq542vA
	vVqGsxAA4O4UoBMa6pmHADAG0CcOabXKPjuoEec5qW5KoZ3CWuDWc7oTz0VGJFQiSkvvUBRUVPs
	B9OjN8e9UirMwytPF/D7hiTgJmIOkrF+ALPOFMP/V/xg4czFQ5J+ZLajz5hldlGg3mXvKRsQaKP
	E5twc+F4hnmvssG9dHZ0kjgNXkLBLChePGaqNzizD+HjOLTJOrRmZz498ciG4JoES+dGlhQZqVW
	oKsjGEc1RXKml3B5d9g+1z/mFnADRKWR3w/k5A3DMkCfNtje5Y8h0VnxwMRn66/my3MJ2Ct7ydn
	wOvakUjeIUvUIW59GPIh8qfh9kWfom/aOyx2lAAzE5SiafyB/+7KWYeAN5Yl++MLag4mlYyGo1
X-Received: by 2002:a17:907:a0d4:b0:b9a:3ecb:51f8 with SMTP id a640c23a62f3a-b9c13790ec6mr100088066b.4.1775001039257;
        Tue, 31 Mar 2026 16:50:39 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c125c4cfbsm47060966b.34.2026.03.31.16.50.38
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 16:50:38 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-66db0cf6a4aso771361a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 16:50:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVM9FZcN2L65uoHZ9Ev72/6SUVepXrtKSCgJUoXHKp8DUrV/v/8QnE5N30DvpcTW6IwvaojmtPP2+0zJu6bfS4=@vger.kernel.org
X-Received: by 2002:a05:6402:13cd:b0:66b:810f:1c4d with SMTP id
 4fb4d7f45d1cf-66db09f03d1mr893296a12.18.1775001037895; Tue, 31 Mar 2026
 16:50:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331163716.work.696-kees@kernel.org> <20260331163725.2765789-5-kees@kernel.org>
 <CAHk-=wiJ6Q_qMHSe-hs+QvqKVZphvDZjvFP_gQLw1eaWimv8+w@mail.gmail.com>
 <202603311253.95C54588E@keescook> <CAHk-=wjSOGaausLeTD13yAqso7qM09EnkDFiN7wF15kH0VWmZQ@mail.gmail.com>
 <202603311321.4EE9FEA@keescook> <CAHk-=wj9pWsgsbrLDOk7ipKnHbz3JvuqsmQ3DhGg-OKgKS9DUA@mail.gmail.com>
 <CAFhGd8rE+ggYghcwUphSRc2ftQMaX7LbKKPwQZzsw43bg9VVmA@mail.gmail.com>
In-Reply-To: <CAFhGd8rE+ggYghcwUphSRc2ftQMaX7LbKKPwQZzsw43bg9VVmA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 31 Mar 2026 16:50:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4j9-=VMdVJZQjn=FEDWpE5JkHtr3CwErQdXVGFfGkXQ@mail.gmail.com>
X-Gm-Features: AQROBzCocASEQv-3sgFpeT7hRsHg1wWGTjTvooh3XWVShxy7lX1Q_VH65yuwsXg
Message-ID: <CAHk-=wj4j9-=VMdVJZQjn=FEDWpE5JkHtr3CwErQdXVGFfGkXQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] types: Add standard __ob_trap and __ob_wrap scalar types
To: Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
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

On Tue, 31 Mar 2026 at 14:50, Justin Stitt <justinstitt@google.com> wrote:
>
> How do we feel about type-defined labels? We can specify sane default
> handlers where we define the types:
>
>         typedef int __attribute__((overflow_behavior(trap, __handle_me)));
>
> ... and define specialized handlers later on

That sounds like an interesting interface, but I think it ends up
being kind of odd, because normally the type definition would be in
some global scope, while the 'handler' would be a local label name.

I think that in some situations - and certainly other projects - it
would make a lot of sense to have the trap handler be a global
function in that situation (ie "abort"), but with that being
explicitly *not* what the kernel would want, it seems a bit odd to
specify the name of a label that then is used in a totally different
context.

So in your example:

> int func()
> {
>         ...
>         u8 __attribute__((overflow_behavior(trap, __BOOOOM))) product = 5;
>         ...
>         product = a * b; // if store is truncated, goto __overflow
>         ...
>         return product;
>
> __BOOOOM:
>         pr_info("%u\n", product); // shows "5"
>         return -1;
> }

The above makes total sense, but imagine instead the code being
something more like this:

Some header file does this:

  typedef unsigned int __attribute__((overflow_behavior(trap,
__BOOOOM))) u32_overflow_t;

  struct some_random_struct {
        u32_overflow_t usage_count;
        ...
  };

The implementation for looking up those structs then looks something like this:

  struct some_random_struct *get_entry(int hashval)
  {
        struct some_random_struct *n;
        spin_lock(&hashlock);
        n = find_entry(hashval);
        if (n)
                n->usage_count++;
        spin_unlock(&hashlock);
        return n;

  __BOOOOM:
        WARN_ON_ONCE("Entry 'n' overflowed\n", n->name);
        spin_unlock(&hashlock);
        return NULL;
   }

does that still make sense?

Now, I'm not *opposed* to this kind of interface - we'd presumably
just use something like "overflow" for the label name anyway - and it
allows people to use whatever label names make sense for a project so
it's clearly a nice feature.

It just feels a bit odd. But maybe it makes perfect sense at a
compiler level as a "it's just declaring the token to be used for the
exception label".

                Linus
