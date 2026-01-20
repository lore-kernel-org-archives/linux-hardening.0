Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A9246AF39
	for <linux-hardening@vger.kernel.org>; Tue, 20 Jan 2026 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768936547; cv=none; b=Py6orKPqQ+0Vfkb/kTb8GDf70cPuO/8UMSfSPYibH/WV284/W1kXnvp049AXHgopoTbs7j9Lpl/KcSN2EFFdAyaWRQk/FYuE4Z35edyu1DTMkGXmgmCQ8iOVKA5tsiZZa4Y2wtjFzVZRpp1XAybYVX82Mi64wWdRLoZsROuH1tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768936547; c=relaxed/simple;
	bh=1N7H+yfpk2NLIOr7BO59rbs9SEWHKeyOlq2YvA8BBU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0wFtBhQQCw2qVANAGFvuLipQIPfTLNR9tL9Er12uJaZRKi9xyjRdsOmY2n0BNuyEiMOme98s01/mHajU2Gsk+bjaCaPRdgWWWZUG5+qWslWyNwSzt7/zC9on335KHqPxR0JllqQVTWaqiR9YS+osomAnmbaeu7WACC0r9PyT8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8XFpMP0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8XFpMP0"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so38278545e9.3
        for <linux-hardening@vger.kernel.org>; Tue, 20 Jan 2026 11:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768936543; x=1769541343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0qoWHj+Pupz+7dBvH/HjJvQAh+/X6Q7iQzogpkXbi8=;
        b=a8XFpMP07xNVWkfxaeWpj5YXch3RTYsxN627l0CQBozCisd2qH4lzpn3k/K7D76qL2
         ndiLURYa5r1Y7sONFTj+MTrr6IllG1TQhfTfmJ0Wsx3i7m+TB+daeFLv2Z/LDwQAiWTX
         Hs2rpO7OwYe67nACT2OwpbXjEQV96LYewDxJbpShDo4/g5QoZKVLzntGB8l7LESa488M
         p108QmWEkC78bwLP+bpyfd/SI2gzhTIO6Awfk0b49Xhn8lQxPuuF8pNPV9SHuENOYDj7
         ig551/XA3aIUjZiiJ7ynSZEHAQloG0Kd3p7fO3VEBzIGpyuLjGfoXIITGy6ebJYfpK1L
         lgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768936543; x=1769541343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C0qoWHj+Pupz+7dBvH/HjJvQAh+/X6Q7iQzogpkXbi8=;
        b=IXV4Tj4RTeiSD07nywlJerQY0UvX6OMOKhz17C3SRFd+fqh5/tkjPhNrIp5/t8NjQB
         YxdC0fD8iksCCkQAyq08LCg7Xl/9KQNIrRg94bK83Hj8YCtMBj2kv5bd1Lqr1OZsP3tJ
         4vTpoQX0R+wtM7DEb40TIj5j8DN5lppL5tfeEYS/XBJZKg2QPY2ZyL0zxtMy79KiUE2j
         Gf2CnbNYpOlkSljcnxC1iZOkf6QxawXejhNIxsW4IlySJ2zvdaBplT9UtwNpHm2THKsQ
         b9FGWj9junHJMtKAhtbLmvbRCRXv9IcTt98pDVAPpJB60xU1vuuivISVCQgkA0C/PCd0
         0deA==
X-Forwarded-Encrypted: i=1; AJvYcCUKudVPe0C4d75+wQ8VL+adE3yhR06bZp0BchqwCJTA5kThgu6ptSXf4yj8DtP0jwFZRP6PIjmodSfHtVwWNRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRG+LFaLSlukeRdO9PBPpEKentGoPz/UXQXlPdZPx74lTX7mXD
	E7FXoBqUxXvBnILXhYeuseyZZ6mP7IfcAcXp70aYOWDjIOCTqy+jjZfB
X-Gm-Gg: AY/fxX5b6KWgHNohaK/ZE/VaEp3nZ4eMaa5lDKmmFenS2E6GiptRusiJGm54sECXV1M
	WMzOFuCc8NjIIlppgS/heJSb+EFDH3NpCszUUvEZ1e0x0dga5R7j27rbI5WLFOyJyeO4lWrWmXM
	f4bMw85mFMan3bd2bda++toPQKE+pqlWIjKeNHgjjh12g8NDOfHAX0lSoPZ33ICivC9nSiYo+Gi
	oWooGZ2SBKMftQOrOMRnZwRIdMPjQ1eHu66c4tnoluDRmX+Ib2e5vt/6Jzn0IO2UZmj9BRlZPdN
	KhXCkOKZ66eBDGqCmMQ6gfqqz1YCk4l++YqBnDafByhAXk8CS5BS1uIb62Vet3Lfev495jGLpGM
	98pJ3NGzYKyxMOXbrO9qcRpMpES1XZtp9FB2ymL4kxkLvyD5DBgXToUjkWM70EuiC9/GAo2isxG
	z/qHkqUrbU056rcH8E7IhvNcZ3fTF2oCd+qc9jPjbDi31FuhZxdao+
X-Received: by 2002:a05:600c:8816:b0:479:1ac2:f9b8 with SMTP id 5b1f17b1804b1-4801e334379mr176102295e9.21.1768936543196;
        Tue, 20 Jan 2026 11:15:43 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48042694e77sm1172165e9.12.2026.01.20.11.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 11:15:42 -0800 (PST)
Date: Tue, 20 Jan 2026 19:15:40 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Justin Stitt
 <justinstitt@google.com>, Miguel Ojeda <ojeda@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Heiko
 Carstens <hca@linux.ibm.com>, Marc Herbert <Marc.Herbert@linux.intel.com>,
 Uros Bizjak <ubizjak@gmail.com>, Tejun Heo <tj@kernel.org>, Jeff Xu
 <jeffxu@chromium.org>, Michal =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <thomas.weissschuh@linutronix.de>, John Stultz <jstultz@google.com>,
 Christian Brauner <brauner@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Brian Gerst <brgerst@gmail.com>, Masahiro Yamada
 <masahiroy@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev, Nicolas Schier
 <nsc@kernel.org>, Tamir Duberstein <tamird@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Naman Jain <namjain@linux.microsoft.com>, Simon
 Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Douglas Anderson <dianders@chromium.org>,
 linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v4 1/2] Compiler Attributes: Add __counted_by_ptr macro
Message-ID: <20260120191540.50a22ba8@pumpkin>
In-Reply-To: <CAGG=3QWeYZqLA8FSMYZFRrJ24LtEKJdmRAq3awkMZj0+qy=4_w@mail.gmail.com>
References: <20260114193716.1740684-1-morbo@google.com>
	<20260116005838.2419118-1-morbo@google.com>
	<20260116095318.46a149fb@pumpkin>
	<202601171106.90E508A9D4@keescook>
	<CAGG=3QWeYZqLA8FSMYZFRrJ24LtEKJdmRAq3awkMZj0+qy=4_w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Jan 2026 10:12:34 -0800
Bill Wendling <morbo@google.com> wrote:

> On Sat, Jan 17, 2026 at 11:07=E2=80=AFAM Kees Cook <kees@kernel.org> wrot=
e:
> >
> > On Fri, Jan 16, 2026 at 09:53:18AM +0000, David Laight wrote: =20
> > > On Fri, 16 Jan 2026 00:57:57 +0000
> > > Bill Wendling <morbo@google.com> wrote:
> > > =20
> > > > Introduce __counted_by_ptr(), which works like __counted_by(), but =
for
> > > > pointer struct members.
> > > >
> > > > struct foo {
> > > >     int a, b, c;
> > > >     char *buffer __counted_by_ptr(bytes);
> > > >     short nr_bars;
> > > >     struct bar *bars __counted_by_ptr(nr_bars);
> > > >     size_t bytes;
> > > > };
> > > >
> > > > Because "counted_by" can only be applied to pointer members in very
> > > > recent compiler versions, its application ends up needing to be dis=
tinct
> > > > from flexibe array "counted_by" annotations, hence a separate macro=
. =20
> > > ... =20
> > > > diff --git a/Makefile b/Makefile
> > > > index 9d38125263fb..6b029f694bc2 100644
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -952,6 +952,12 @@ KBUILD_CFLAGS  +=3D $(CC_AUTO_VAR_INIT_ZERO_EN=
ABLER)
> > > >  endif
> > > >  endif
> > > >
> > > > +ifdef CONFIG_CC_IS_CLANG
> > > > +ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
> > > > +KBUILD_CFLAGS      +=3D -fexperimental-late-parse-attributes
> > > > +endif
> > > > +endif =20
> > >
> > > Will that still be needed for clang 22? =20
> >
> > AFAIK, yes. AIUI, this flag will remain while -fbounds-safety continues
> > to be upstreamed into LLVM.
> > =20
> > > Looks a bit like a temporary flag to avoid regressions.
> > > Probably ought to at least have a comment that it won't be needed
> > > by some future clang version so that it gets tidied up. =20
> >
> > Once it's no longer needed, yes, I will want it removed from the
> > Makefile.
> > =20
> Would it be good to 'fixup' a comment in the Makefile for that?

Wrap with:
# Update version when no longer required
ifneq ($(call clang-min-version, 999999),y)

Although you might one day need the -f option for something entirely differ=
ent.
So perhaps the logic that enables CC_HAS_COUNTER_BY_PTR need to do the
extra version check and set something so that -fexperimental-late-parse-att=
ributes
is added here (so it only added once if needed by multiple things).

	David


