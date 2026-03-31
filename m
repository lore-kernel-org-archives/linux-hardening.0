Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5409A3590A9
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 20:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774988732; cv=none; b=TdQedAUFBWNJQFATocAmbjBow8XlZpTsc/ihzujCjrH9IyjTlAhZzhHC61UOXq93lsOTSMXoT9QVIX4rw0yyOvq2KJbP7JMoErtKayIZQjEFD/MQHnc1Et6pS7qS9Qu1DT5KdMxh/wHVvU+ZQTBA6K4OOaj2MshQXmBisxWoGuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774988732; c=relaxed/simple;
	bh=MXnPS0QnV07SSDgjwdHCBKIla0I+UMjxd6c/XOBUKPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9t1LNy4Wx+VsNSkNAgnXFJHpG52rZFFCLjZoDuoAJSE4lFU1pW+Q55thpPP5hyZVGPocN+vLUVctuyPDh9W4GTwnorOXcbCdD23LmiSvTwLqINlveJ8I8S/8oynGTgxPVGGGmFIsa91tlxUl/75+cjSyIRpsUVFBKmkF47jv44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Sf1RKmpR; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Sf1RKmpR"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b93698bb57aso51798166b.0
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 13:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1774988730; x=1775593530; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c2ktyrPBG7CFlGMbOR9QYSgdZ9nvYimpNIw5oGP8BII=;
        b=Sf1RKmpRQOVM+6UzuYYIeIv17Df1yGkdt+TOs7gewuJkaYYNTbz9pwfVMpSom+7pYJ
         dX8SX+wEBRrOK1jHvu2rjHi8LUOfsXpSzdO8hEZQn7Ch9oaWohrxoaqsmPf9LNCXZaKp
         BuBK5Bw1iGTgy42SjaWUUmxZKEm+Xl5tkJj+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774988730; x=1775593530;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2ktyrPBG7CFlGMbOR9QYSgdZ9nvYimpNIw5oGP8BII=;
        b=L8LOTvCkKuv2Qbepc378nKYkBk41t44OCYQTta/W0md8f8e7i9GvZimwxpj1sqQiGo
         65nJs+h1ef8/qAzBIB3v468b0ufuSJWSjgegzJUo1f1pdl7I2W+Pzh+8Ca2YuUA3yZ4G
         7W5/iuOI+kMA6nzK7EaqbcaJFUV6zbO+HHmT0+XHmlqLJlFUWh/zHnC6MwZ90KH/Yw/d
         zotUJdKkCYgGN6fPGh6FrdS9DBCDQ5WrD742irumRDji8BWf1mUN6R34RRNw+4aVq3nV
         cK4OsK5PyGlKXdpnedlFTJzSgKXcCewgOLjk2yJC0bAgrKozMuBlTbWMVHgCnwv7lweZ
         EeiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxDd3yHhRIaXI5Zkc3eJ6Jknhl0y+nmVhrJCFA0uqFp1fhekaToa5G3RpcFi8nLVWqCNK4Xv9c+wdqHXJYIX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAGr5WdT9y7RwydHLIqVwjAQEqBL8Y0/Kk6tsqumuupSbxOCpk
	wyeP3LzY0Yss+6vkMNkb1CJmYGDsXB7aDg8C+XczaS0wd3kp3WAqEAFrXhvcCHbB+2mEcPTtB2h
	PHRV+db7zCQ==
X-Gm-Gg: ATEYQzyEvcTYrtSvcG07D78c5DrYd1wStKEvJhd0qsXhRnYUwSlgnrT4HFUGE5z4Lx3
	oYrCX+RkoWi/PI8f9gRxfJ+EZgVLuMH4g/PInBvEUTMGjnorY9PIpjc+/lEBBvof3LGT/UeTeJ7
	8ZQjj0ZxN6uMovb/cZInMBxc39aYZCF4yDiPwPqShZ77iBvT6STsdOnGYZuDKxV4Oz872kDYyMy
	mjQhAf8LVszbSJ46eMgNtcKiIewY8mNp2V3LgvtWKx7bkWN6e19jRl3yfDC93vuskzqAfbGqBIv
	XkGIzFDG8LsuZlrjFNUeNRUPvsReA+mkpfIoVq1BSdg1y2opzu6IxF/7C+Vxwn6rn5WLxYKGSOl
	W7KMHeCHTt1uxDZeQSTVmFqjGlGhVHkLIzqjyEC3F2q+MkiaFsHsFXgwKcgws9m7+V/P1YVfnLh
	gcAiWcYFeH+nIAM6/eBscpWl56AIPW4tdIjM46HRxopn1NMQZISDRk0uFVKjLjcdM8CifHym9p
X-Received: by 2002:a17:907:1b11:b0:b93:61c7:4f09 with SMTP id a640c23a62f3a-b9c15938067mr47181966b.20.1774988729537;
        Tue, 31 Mar 2026 13:25:29 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7b225b9fsm451909066b.62.2026.03.31.13.25.29
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 13:25:29 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-66d65646c65so599817a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 13:25:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV79mExkj1zc2SPeplVZFcB55p68pEjQiUX+/e0d3QMmNBN8rPjXuSGdKQo0bNWkYjhBnYspghwEjp88h0WCik=@vger.kernel.org
X-Received: by 2002:a05:6402:4489:b0:667:f151:2efa with SMTP id
 4fb4d7f45d1cf-66c338618b1mr3066306a12.12.1774988323206; Tue, 31 Mar 2026
 13:18:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331163716.work.696-kees@kernel.org> <20260331163725.2765789-5-kees@kernel.org>
 <CAHk-=wiJ6Q_qMHSe-hs+QvqKVZphvDZjvFP_gQLw1eaWimv8+w@mail.gmail.com>
 <202603311253.95C54588E@keescook> <CAHk-=wjSOGaausLeTD13yAqso7qM09EnkDFiN7wF15kH0VWmZQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjSOGaausLeTD13yAqso7qM09EnkDFiN7wF15kH0VWmZQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 31 Mar 2026 13:18:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjo0gB6jVdRKj310atcM9jmmyr3t3VDut=FW0S9+v467A@mail.gmail.com>
X-Gm-Features: AQROBzAUONdaqkEjwnLXeyVn7Wp-adEWlZELPlH8sCIkK0YvCJHIOwC67Ju1r6A
Message-ID: <CAHk-=wjo0gB6jVdRKj310atcM9jmmyr3t3VDut=FW0S9+v467A@mail.gmail.com>
Subject: Re: [PATCH 5/5] types: Add standard __ob_trap and __ob_wrap scalar types
To: Kees Cook <kees@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Justin Stitt <justinstitt@google.com>, 
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

On Tue, 31 Mar 2026 at 13:11, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> We have a few years of experience with "unsafe_get_user()" and
> friends, and a few hundred places that use it, and while it's common
> to have several cases in one function, I can't think of a single case
> where we actually had more than one error target.
>
> I tried a quick grep, and nothing jumped out at me.

And the *moment* I sent that reply, I went "Wait a minute", and looked
at strncpy_from_user().

So we do actually have at least one case of multiple exception labels:
the first one in that function handles the "potentially unaligned word
access causes page fault, fall back to byte-at-a-time" while the
second one is final and fatal and results in -EFAULT.

But that case could have been written with the byte-at-a-time case as
a separate inline function, so it would all have worked fine even
without explicitly named exception entries.

In some situations, the explicit names may be very useful just to
document things: in that case the 'byte_at_a_time" label does do that,
but I don't think it's a very big issue.

And it's likely even less of an issue for arithmetic overflows than it
is for user space accesses.

So yeah, with better compiler support, I think that whole trapping
behavior would be great.

               Linus
