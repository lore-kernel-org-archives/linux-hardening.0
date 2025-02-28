Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5741F4C90
	for <linux-hardening@vger.kernel.org>; Fri, 28 Feb 2025 17:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763465; cv=none; b=gwOdZK7NHrGuOs63+Mw11Z0QdDeiOCW7B4uMYDVg/xUsYY2Bx4eqh/XuWf7YUGdaJzCgQVX5T13GMia0irDAYes7pe38MyIEV8/XVwIna9SbX1Q6T/1067RclCvQXeWDZeUdenbEYUJ3tUL+K77Ex9RDZ/raZZGVTqve7HLptW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763465; c=relaxed/simple;
	bh=ANOo4RVFpT8QOOZI1F7Uzjr/rClfRnYnXuqCw+UeYBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKQ/dbGGzs6BDmfvt9QLIHan4nnan8FJnMzYpRJjpdvixyQ43tqtejYpt8MRsCPwDHo0Ju1GbtOFaCzLZqhN56dTLVqfo5jtX59MmxupIGPMSy3uGlTh47gUzrxP2+ey75+221bjcGXrCVrsmjQ+WXOM/rtdyvhTb/4CI1P2Ur0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j00hy+Z0; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j00hy+Z0"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5fcde6cdd8bso136124eaf.3
        for <linux-hardening@vger.kernel.org>; Fri, 28 Feb 2025 09:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740763463; x=1741368263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEwvlNxw2Xxs+TAyoZXFHjuOJ7HCWPZTchi8vXriEjI=;
        b=j00hy+Z0uetbOjPebqhsTHCIMW3MKA8WD6Yrh+ilWJ+z2YAfpOIRbaPZyRmhwcB4GT
         mMybHSgHDeqdMSnjhSXbbXbtkNhFSP59ed+WyFPgmVJxNd54fOysWnJ5GKiXb0nGyLHy
         kPJEkPr8KAkTTJ8kMa7G189NSZiixJSFXZ4BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740763463; x=1741368263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEwvlNxw2Xxs+TAyoZXFHjuOJ7HCWPZTchi8vXriEjI=;
        b=xGkYyGGcK3U+QB23U2UZqsTtePXws9y9ByPlT+FtXnYyFXaNe/Ao7duuQYdb93tZsy
         0d0sXiNEVucdCQEHuLFLp30FNfQT7B4t1O+5KckemJaKGasIPIlFpC1eBijDsfW0CBoK
         KPGmU5t0Dq4A6Ddu+9nAFrXewWrPARDDui6wVg0o9OnB6P3mNCFRPgZvnDptkQ1VUseA
         bTRTRP4g5jpRwHMlkERCmON2hkyEqLFPZnxYiG1+DJZPwknK0RlsyLkEjFlb/QaX/ivY
         ll+kdrAApR53S5VpwclbT3S/00T3wrBaI/RwptGr/MyS8So5K+I740Cr55fft+txvv5B
         2Xhg==
X-Forwarded-Encrypted: i=1; AJvYcCVJTxyC2tPJV5FkNBgf4HyyZGp6I4yfWlikUbV3NkRdNvBpv0XhqbbXXxmGLgWDTj7rArGrzPWUGj0+XikYLt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYpsbjPcbij9RLhZzTzxsvd3DWlIRAF8lEj7b/9FmKZjWQeKhC
	1hItg9Bv7jNxpxN3ZZZtxxIBpnHBwVXEf1dRpRcWzbRwXc4aMp4xOVHVFK7uKAPlR2LhhiGEy8w
	/NLx0oSiX82e5uiLrcdwpObIGqN9wBgWF2aOZ
X-Gm-Gg: ASbGncv7ehm6IEizw3nFZ6QMpYRCDtd5PfpebT3dHAWDiGj71eKJ2Tfygsd5DffS5fL
	qPHuVjzdg7DP1IPPxFUyHKeplsHJNMtsjzC1Dv3ZJ4PMoefeoTYgXtIGGG9ANGjV1FuxsGsQhfG
	HPhKq5i5jTs3tMHLKg77OkM5QJWEqfq8fnAPjR
X-Google-Smtp-Source: AGHT+IELmIZtfBk1UK9h8+WtL5wpgAYYMKF9e2oSSIxoQJia0xhiHJ8VA3Nret0YY6RTyQeg0N3QCQfgbJs/+4ZoALk=
X-Received: by 2002:a05:6808:4490:b0:3f4:17fa:8b25 with SMTP id
 5614622812f47-3f5585f76a9mr1063932b6e.5.1740763462729; Fri, 28 Feb 2025
 09:24:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <e697ee1d-6075-4f24-8365-32aa4bc84d7e@lucifer.local>
 <CABi2SkXcgB1Zjztqc1W4M-5j9z_wMCRaEtK-wLL3x9_qC1aGHQ@mail.gmail.com>
 <f65bd1bf-4e81-454a-afaa-f84c13cc6227@lucifer.local> <CABi2SkV2_-LYGjROm3cs8nHrzBiw7pjpe0i7QGNPsPKHSeajog@mail.gmail.com>
 <60f5b979-2969-4cb0-ad3d-262908869c5f@lucifer.local>
In-Reply-To: <60f5b979-2969-4cb0-ad3d-262908869c5f@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 28 Feb 2025 09:24:11 -0800
X-Gm-Features: AQ5f1JrKoMI7MAoJt_s4VBjawQ2oE7qOjznd7nZIAKK-HcNxZUPVPRG1COgivdw
Message-ID: <CABi2SkX8QM7W0uCUBPFhjrC3psr1HDHLe2i-9hzh81UyKsBuQA@mail.gmail.com>
Subject: Re: your mail
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	Jann Horn <jannh@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, Oleg Nesterov <oleg@redhat.com>, 
	Andrei Vagin <avagin@gmail.com>, Benjamin Berg <benjamin@sipsolutions.net>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, linux-mm@kvack.org, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	"hch@lst.de" <hch@lst.de>, "ojeda@kernel.org" <ojeda@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	"adobriyan@gmail.com" <adobriyan@gmail.com>, 
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>, Pedro Falcato <pedro.falcato@gmail.com>, 
	"hca@linux.ibm.com" <hca@linux.ibm.com>, Matthew Wilcox <willy@infradead.org>, 
	"anna-maria@linutronix.de" <anna-maria@linutronix.de>, "mark.rutland@arm.com" <mark.rutland@arm.com>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "Jason@zx2c4.com" <Jason@zx2c4.com>, Helge Deller <deller@gmx.de>, 
	Randy Dunlap <rdunlap@infradead.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	Peter Xu <peterx@redhat.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, 
	"gerg@kernel.org" <gerg@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, 
	"ardb@kernel.org" <ardb@kernel.org>, "mhocko@suse.com" <mhocko@suse.com>, 
	"42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"ardb@google.com" <ardb@google.com>, Elliott Hughes <enh@google.com>, 
	"rientjes@google.com" <rientjes@google.com>, Guenter Roeck <groeck@chromium.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
	Mike Rapoport <mike.rapoport@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 1:35=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Feb 27, 2025 at 04:55:06PM -0800, Jeff Xu wrote:
> > Hi Lorenzo,
> >
> > On Tue, Feb 25, 2025, 9:43=E2=80=AFPM Lorenzo Stoakes
> > >
> > > > > 2. Tests - could you please add some tests to assert that mremap(=
) fails
> > > > >    for VDSO for instance? You've edited an existing test for VDSO=
 in x86 to
> > > > >    skip the test should this be enabled, but this is not the same=
 as a self
> > > > >    test. And obviously doesn't cover arm64.
> > > > >
> > > > >    This should be relatively strightforward right? You already ha=
ve code
> > > > >    for finding out whether VDSO is msealed, so just use that to s=
ee if you
> > > > >    skip, then attempt mremap(), mmap() over etc. + assert it fail=
s.
> > > > >
> > > > >    Ideally these tests would cover all the cases you've changed.
> > > > >
> > > > It is not as easy.
> > > >
> > > > The config is disabled by default. And I don't know a way to detect
> > > > KCONFIG  from selftest itself. Without this, I can't reasonably
> > > > determine the test result.
> > >
> > > Please in future let's try to get this kind of response at the point =
of the
> > > request being made :) makes life much easier.
> > >
> > There might be miscommunication ?
> > This version is the first time you ask about adding a self test.
>
> Yeah I thought I'd been clear but this might _very well_ have been me not
> having been, so apologies if so.
>
> I mean 'make sure it's tested' is an overloaded term right? So fact you'v=
e
> tested on android, chromeos, etc. implies 'tested', but also self
> tests/kunit/whatever.
>
> >
> > IIRC, you had comments about providing the details of what tests I did,=
 in V4.
> > As a follow-up, I added a test-info section in the cover letter of V5
>
> Thanks. Appreciate that! And this really does point towards a
> miscommunication on my part, will try to be super explicit in future.
>
> >
> > Though I have thought about adding a selftest since the beginning,
> > there are two problems:
> > 1> This config is by default disabled,
> > 2> No good pattern to check KCONFIG from selftest.
>
> Yeah agreed, it's a TOTAL pain.
>
> I wish we had a better way of doing this. Maybe a self-volunteering
> exercise (*goes to write on writeboard :P*)
>
> >
> > >
> > > So I think it is easy actually. As I say here (perhaps you missed it?=
) you
> > > literally already have code you added to the x86 test to prevent test
> > > failure.
> > >
> > > So you essentially look for [vdso] or whatever, then you look up to s=
ee if
> > > it is sealed, ensure an mremap() fails.
> > >
> > This suggestion doesn't test the core change of this series, which is
> > to enable mseal for vdso.
>
> Right, and thinking about it, what does this test? Just that mseal works
> right?
>
> It's sort of implicit that, if a VMA is sealed, the seal should work (or
> rather, tested in mseal tests themselves, rather than mseal system
> settings).
>
> >
> > When the vdso is marked with "sl", mremap() will fail, that's part of
> > the mseal() business logic and belongs in mseal_test. The mseal_test
> > already covers the mseal, and this series doesn't change mseal.
> >
> > As for the "sl", as I responded in the "refactor mseal_test" [1] , it
> > will be part of the verifying step:
> >
> > [1] https://lore.kernel.org/all/CABi2SkUv_1gsuGh86AON-xRLAggCvDqJMHxT17=
mGy-XutSTAwg@mail.gmail.com/
>
> OK cool thanks. I will look at this when I can, I'm just snowed under
> pre-LSF and have been sick so backlog, backlog as discussed off-list. But
> it's not been forgotten (whiteboard etc. etc.)
>
Ya, no worry about that review, please take time to recover, I will wait.
And appreciate your time and take priority for reviewing this series.

> >
> > > Of course this doesn't check to see if it _should_ be enabled or not.=
 I'm
> > > being nice by not _insisting_ we export a way for you to determine wh=
ether
> > > this config option is enabled or not for the sake of a test (since I =
don't
> > > want to hold up this series).
> > >
> > > But that'd be nice! Maybe in a
> > > /sys/kernel/security endpoint...
> > >
> > >
> > > ...but I think we can potentially add this later on so we don't hold =
things
> > > up here/add yet more to the series. I suspect you and Kees alike woul=
d
> > > prioritise getting _this series_ in at this point :)
> > >
> > > You could, if you wanted to, check to see if /proc/config.gz exists a=
nd
> > > zgrep it (only there if CONFIG_IKCONFIG_PROC is set) and assert based=
 on
> > > that, but you know kinda hacky.
> >
> > Ya, it is hacky. None of the existing selftest uses this pattern, and
> > I'm not sure /proc/config.gz is enabled in the default kernel config.
>
> Yeah and I'm not sure I even like my hacky suggestion here, I mean let's =
be
> honest, it sucks.
>
> >
> > One option is to have ChromeOS or Android to maintain an out-of-tree
> > test, since the configuration will be enabled there.
>
> Nah haha, though of course you can do what you want. Really want somethin=
g
> upstream.
>
> >
> > Option two is to create a new path:
> > tools/testing/selftests/sealsysmap. Then, add
> > CONFIG_SEAL_SYSTEM_MAPPING=3Dy to the config file and add a selftest to
> > this path. This seems to be the preferred way by selftest, but we need
> > a new dir for that.
>
> OK I like option 2 let's do this.
>
> But let's call it mseal_system_mappings (yes I"m being nitty again :) I
> really want to try to _explicitly_ say 'mseal' because we have other form=
s
> of sealing.
>
Sure.

If long path names aren't a problem, I will use mseal_system_mappings,
otherwise mseal_sysmap.

> Not your fault, but we overload terms like _crazy_ in mm and need to be
> cautious as not to confuse vs. e.g. memfd seals.
>
>
> >
> > Option three is to add a self-test when we have a process-level opt-in
> > solution. This would allow the test to deterministically know whether
> > the vdso should be sealed or not.
>
> Yeah one for future.
>
> >
> > >
> > > But anyway, FWIW I think it'd be useful to assert that mremap() or mu=
nmap()
> > > fails here for system mappings for the sake of it. I guess this is, i=
n
> > > effect, only checking mseal-ing works right? But it at least asserts =
the
> > > existence of the thing, and that it behaves.
> > >
> > > Later on, when you add some way of observing that it's enabled or not=
, you
> > > can extend the test to check this.
> >
> > I think it is best that we don't add a test that doesn't actually
> > check the code change. Do you think one of the above three options
> > works ? maybe the second option (with a new path) ?
>
> Yeah I actually agree on reflection. And yes agreed option 2 is great,
> thanks!
>
> >
> > In any case, I think the risk is low, and the code changes are quite
> > simple, and fully tested.
>
> Yeah indeed, but I'd really like _something_ if possible. If option 2 is
> relatively quick let's get that sorted out!
>
Great ! I will work on option 2.

Thanks
-Jeff
