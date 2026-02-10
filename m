Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861332DF3F2
	for <linux-hardening@vger.kernel.org>; Tue, 10 Feb 2026 11:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770721222; cv=pass; b=uk5E5wZytdigTCjx8TsiSjolxUJ3MjopsqOnZqu3uWdcKxAHviFIzBdh9VO4F4+blHmzMU1JGxTuER2IWkRSTLu5CeAgB/d2GHjWJ67nJrmb7PbPZ5Z/vohPw0QgFTXssykvWB+raRLrCTUntLoVmoKD6HYIAPVRjiEUbsgfWkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770721222; c=relaxed/simple;
	bh=7jlgqr3yZphn3pukISYjQ5gwlyu5U7nFrO2FLlQ6AM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DwjOftg+onXowcKRXuoC1QW/sSuulI2pEN8EvDbtlI2/dUzhIGXCMHA2NcbJPgHV8vC+1hQc2c8ISpVrCQsfib5xemoyJz169fxixNYX1jjtpehCrjg9hX6VqbKakvhZzploSfeyJZaUXQLlmEiY0tKFdLPsYn+feB5Zyj6Il2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SefXm3WU; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SefXm3WU"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-948bf40406bso923028241.1
        for <linux-hardening@vger.kernel.org>; Tue, 10 Feb 2026 03:00:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770721220; cv=none;
        d=google.com; s=arc-20240605;
        b=cflwECMH+hJaG/Y4G3DhED78YZAQkP1mGRDhXhWT1eQNccZgPTQ0fHXdVqwaYtlPKh
         AONeNw1VWrCt/M0AlUXGuxH36NOFTtXM5wRKJXVkp/usSGaemlLxJPfPupe+VzgPPQWx
         W1XVniElnY+w6L6UtOhikB+BS20P9+xNEHBBujMqhlRSlHpYZmglQn7D5hvr1JOdcjcM
         lo9pDubzZ9h5+TLS08qekMwqEhtk3JkmcMd63o+NpfAiJrLfHOt2MQJwRM52CC5i1MHT
         puRRxjHLO41Nt7sWnO/s+Q0HTAQdL1pXZLPCxsRqrkQQBKfD0tDBWHAguFhh69Vo1OL/
         9rXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0DJjTOyGvQSzTSy8pu2rJIfOiWHMKOk3wlQ76meFp18=;
        fh=08P3RmaXn8GimwIHnpoTDV6KZR1a4NcVAW7f4a49iiY=;
        b=AClrz1Z9F7oTiOyHV9nq3nd5276JaL/djxYh9MVleHcBInvHi4xPJsrsDLq0f3a8Rb
         eoaGWsxMjOU3rD5zvt3CjJ3BM9yf5SxxeX0A1IrJABIqm2TyRXZlwYzEU/7F5R4xBAlu
         mxA6rJvKWOcJKCNcizYgXHjlMrxqbxhuAKwvgly30A/V5hgFQr3JnP3T+NQqL7ENCzWG
         OD+tckDU70hea1yFpXAiVSFZi3McnWZ/XuhvrdKQ1dFH+j7na3ic0L6yGdZlGKwQdPqb
         gE9rpR14mMDNJW/VgWGL+ccEsFVae74AgUmU6ezhr1QhUD3qDw6ivnbiWcGXJJUfvorg
         cBfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770721220; x=1771326020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DJjTOyGvQSzTSy8pu2rJIfOiWHMKOk3wlQ76meFp18=;
        b=SefXm3WU7CGzJVCvy3qRgoqattKBi6FemShwgC+K6kXg48/zcF0ux/x1YMKcqXoOzI
         JY2E3ivI0hz9CX3UEyfG0EqMfqWMbYXqSZkPIidkGZUNi2koVumq5IMf+xaLECb4nUwJ
         tRzsyjMZNYRcDh6rZrvmUPiv2L7ER+qRjiGG7sB9jP13+X98xQIB8bzawqr6dBZPwYsv
         XL3u6bZ1WwxGM72V8f6aZHhfJftr0z6j7xlDnHR5iovvbRUL3DsP26K5S9v0hjg5DPfM
         nDWdhkrq/Wp3nBwg+Bp/jWklZKJGe5TlFZAYVT3tMnAmn8nQn7PK6vERxAlrzZ8OWEIO
         kM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770721220; x=1771326020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0DJjTOyGvQSzTSy8pu2rJIfOiWHMKOk3wlQ76meFp18=;
        b=kZPrhs5QHMCJX7H923VYtKgi2VxYrxAr5xd3KACk/ANfaSqHkSV027MiYqMjJP8JxB
         mGfAbVrqyv5Q5usZoXX3g0SI8LQPSjpc7qeZFTL/4zhq7i4im8SeDc0kuisHegM+5BAK
         H1PG2+237b4sZ/cl69GbQfwgTUzAwVqPXecCdpdfUptpiqSCIu2dqT7xVadyJvTC87Wg
         Q235mHb/PsArYUtsSM6dgjJqwPxAl6XDBVa33Qbar4Q9ihWm7yrT1dPgmL6qODeWyuSy
         FwCAKpI95pLhOTVMDBC2WtQJSgFmH3iwiRc5oj2mqNEz+AoXmOqkmyZQXvDzaG++Gz/X
         0LWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkinzqQL7QpGT9z5LTdAKdRDehujtfFsSSL6QwzCLjbqbbCEMSJQpem9PNfFP+cNdBSnhY8VJ07ArsPgj3R14=@vger.kernel.org
X-Gm-Message-State: AOJu0YydiFm+hEw4+E9npq/j3eAck/YQ6fIH54JX4xIaeft6s4URXK36
	ScGSvOQu8VtxaLfSPwoj0uBszCblDhe1rJHbnsEY6KivKUMMpPOzPCuNye0HkDBx2q/ccYWjy3i
	e1s8BbHaGmkh0MwX+wjWf3YM9sTTQzkUCGLbuogA=
X-Gm-Gg: AZuq6aKE+h/hIbnBgC10Wl2v1qr9ASDebP7+QRsIVAR4i9NYds+4blniY6csFzXI1IX
	RaHXHNJplq1RT7Ghave7pRN9mS5grVZnhp0Ghf9M1cMOoE0M/g8Zy8L8QRybyHGcHKSr22zFMe0
	3RKm3oC72O77xFTEFDNDogFxTiyRx4cdLCmkd7U4m6Qp4xDOFhp+2CYBbBPkkB4cjGY3brUtJoi
	kz4Yc4lSqlpOl3M59Yxx/lpwsYy+wDrtqFcQSJfv3s5dvd5SLDRdIBdBYDMdj1kUjeqjZwrNEfo
	D2XxP2p90uTsOJUGKNY8/m9YpL0MPTmhGjPRm8QrGonmmp5PwXtk7yOYBHfVDRVL6j6USQ==
X-Received: by 2002:a05:6102:3e81:b0:5ee:9f76:1ab with SMTP id
 ada2fe7eead31-5fae8a167f7mr3666507137.5.1770721218424; Tue, 10 Feb 2026
 03:00:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121193957.1655580-1-morbo@google.com> <20251121193957.1655580-2-morbo@google.com>
 <d29ca795-ade3-454b-816e-46b5815a1444@app.fastmail.com>
In-Reply-To: <d29ca795-ade3-454b-816e-46b5815a1444@app.fastmail.com>
From: Bill Wendling <morbo@google.com>
Date: Tue, 10 Feb 2026 03:00:02 -0800
X-Gm-Features: AZwV_QholJlbosqtF2gd0_fYtoKv2w6FE-QJm9P6K9iICEjFVI1V3YpH6ysZSLk
Message-ID: <CAGG=3QXC7EH18mhJq6egqE6bvo8_KchPD_N4PeZ7Z7tLOv26-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: Add __counted_by_ptr macro
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Justin Stitt <justinstitt@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Marc Herbert <Marc.Herbert@linux.intel.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Jeff Xu <jeffxu@chromium.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	John Stultz <jstultz@google.com>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Brian Gerst <brgerst@gmail.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, Jan Hendrik Farr <kernel@jfarr.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 12:41=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> On Fri, Nov 21, 2025, at 20:39, Bill Wendling wrote:
> >
> > +/*
> > + * Optional: only supported since clang >=3D 21
> > + *
> > + * clang: https://github.com/llvm/llvm-project/pull/137250
> > + */
> > +#ifdef CONFIG_CC_HAS_COUNTED_BY_FOR_POINTER
> > +#define __counted_by_ptr(member)     __attribute__((__counted_by__(mem=
ber)))
> > +#else
> > +#define __counted_by_ptr(member)
> > +#endif
>
> Something changed in recent gcc versions. I had tested gcc-16.0.1
> successfully with CONFIG_CC_HAS_COUNTED_BY_PTR=3Dy, but after upgrading
> to a recent git snapshot, I get this output:
>
> fs/coredump.c:95:15: error: 'counted_by' attribute is not allowed for a n=
on-array field
>    95 |         char *corename __counted_by_ptr(size);
>       |               ^~~~~~~~
> drivers/misc/lkdtm/bugs.c:518:15: error: 'counted_by' attribute is not al=
lowed for a non-array field
>   518 |         char *buf __counted_by_ptr(len);
>       |               ^~~
> drivers/misc/lkdtm/bugs.c:520:29: error: 'counted_by' attribute is not al=
lowed for a non-array field
>   520 |         struct lkdtm_extra *extra __counted_by_ptr(nr_extra);
>       |                             ^~~~~
>
> This is every use of __counted_by_ptr() in linux-next at the moment.
>
I assume it's a git snapshot of GCC. :-) What does
`scripts/cc-version.sh` produce for it?

-bw
