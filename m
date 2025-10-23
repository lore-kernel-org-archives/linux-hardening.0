Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADF9A59
	for <linux-hardening@vger.kernel.org>; Thu, 23 Oct 2025 18:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245044; cv=none; b=Z+UwmJ6ngHu6ZB9Ou00QGyEoqks39RvTf88NldSOCf0le+wc5KacfsOldNo9k6g9duo9yL1dr1IXZr0yD9PO5q/yb50T9SRswXn4Xp7ycbToYmFLElHAB7w71QYY91AHl0Ds50hZjSMhv1FN3CkEgHkWOEwmhM4ZXY0Xb/D+wZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245044; c=relaxed/simple;
	bh=PYp52JdL1zIXM3tFl6ymQmTmBEsgbvGo+/rL6L5cfGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LuKZx41SvJdprYgcWejQm14IVZiIBfbqqCArTfgU0cP+p3MZoCcQAVyejRmk5ow3IjWSdBm3lRFjVEsBCvzLo7INurSEcxO0VJlm3fD1zL4DOfsEbN6X78oxkR1LVOxvpNVZ6AE6t6y8l5s0ajZRcBCHJiPupnIWbzzXtNyzdS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=s0yNVa/e; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="s0yNVa/e"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-592f3d2d068so1091846e87.3
        for <linux-hardening@vger.kernel.org>; Thu, 23 Oct 2025 11:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761245041; x=1761849841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FILWuJP7z4ne8yyln1112yG3l4Q4g1VKcs5bhTHsJnM=;
        b=s0yNVa/eJZhfoD3bMLT1xWtZBJPc1t8A/Zn2xYvJEgb/5MtqNO0u6wsuFrM8+isO8U
         a8RqaMEzvq4KU+ucS1pGmFbO1lJkh200XIxtI+uKBrtnG6LYvmZhKlbST26f1dgZKE1G
         dOKkExTkR8MKfeKYs7aXi148bX5ANT4YL2UKuU8MsQpC5zW3VrySCfAv6AqUxxr4U7+w
         YLQx0lhCkihrCpKURL10BMLreCwmNrK2c+SVDNma9CEgKoPeWpeXS4Dtfjcr7DRXw/5I
         R22ChlayhU94emhkIFIMNElmKGF4HJbaff2HtFXiz2ZXhy5tspL9shNNfuFjMpURLrzh
         TvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761245041; x=1761849841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FILWuJP7z4ne8yyln1112yG3l4Q4g1VKcs5bhTHsJnM=;
        b=L0HZJmyQi/hIPaiDO3Yc8QUAbstr9DgBioarJ/sOLk2yQOHew5znpBD7QKK2FdKGm/
         gKS8aHVy1ghCHXTUZiHnz4BPlDPGD8/yRryf7ht8OvaASH1XdoOe6vmZCFDJMN82CB9j
         4mY3JIouEvjyqT6vKdxcRWKjx3VFnkGqtAaVLQGsJGt2aly5dLJnMj8SKoEx3lYmrRt3
         zaCu0yophnPKUXKiMuFeijSfERG2HfiaLc1nRsZBzP498Zkq/t+3/xK/4MbXMI+fKCFv
         7TXILCkJsVACODvYrRWq/bMYO6OES1KfbWlB8f10J89zgEfLB4JbszGN1PH2+sG1/nLU
         7C/A==
X-Forwarded-Encrypted: i=1; AJvYcCUv6Ue2I979lqzSdVpmWB9XMCjpKEM+CKl/V3nCH53A5YUSlM9FmnXDt2sVj9VxxCH37SadU3x8gcnX52k+Z60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo9R6Tc3rlJPD6kmSJxlUCNHHYkyr+POp7TNkOWLk7yjQt8bRK
	kWUg+jXy+vSfh+DFOrAd4TJwhzNn0HAOMQknLFUKqXHLffbXZfdA7M46xWA5URPpxWk7/o2CJKT
	VTLDDFneFddSavbUnxGyRz4F6P1veqwJQXx9hU07ynQ==
X-Gm-Gg: ASbGncsfMdaxSI9NH59s2tD8bhNafoF3nt0fFwK6dHFuSUPhIN1NLhxNDtyz3+OJRta
	Jqodc/14nJTwTaZqt2ju+ylbIKNUS9WT3sXVffcVa7EzV5Er8xbHRfSR2yTHcLTBR+zDlfIUEwn
	i/DoIJwEFl6d041PpruUwLn/5+UUtV21g/qAr1gI+b6Y/H6zTPz6tzSpZ465IUQQNjyUzN9ObWR
	vtP4hudpNlhM2FJ7pyPcd5k323TO5cRMmATaxuTySMd5pOkh59SNL1laQwcCimrcq8QKfNvNeyG
	9bsoxBrD6M3e+Q/RLSYLVKmraA==
X-Google-Smtp-Source: AGHT+IHraJus61bT3Hr2N07s+Ur3YCVMAET0C9pakpGhymtxfywdhGOWwy5gv3wy+GpPvNZ0Z7OpA/pQbI51BbDb264=
X-Received: by 2002:a05:6512:3b1e:b0:58a:fc55:883a with SMTP id
 2adb3069b0e04-591d84eb531mr9214189e87.4.1761245040819; Thu, 23 Oct 2025
 11:44:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-gpio-shared-v2-0-d34aa1fbdf06@linaro.org>
 <20251022-gpio-shared-v2-1-d34aa1fbdf06@linaro.org> <aPj3fCYj-NQdDSQT@smile.fi.intel.com>
 <CAMRc=MeSFKRo1rHq5ENzKqws+gOAX=-nCsGtw5MXvsOwJr=XpQ@mail.gmail.com> <aPkQi_Zn-17JKG0s@smile.fi.intel.com>
In-Reply-To: <aPkQi_Zn-17JKG0s@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 23 Oct 2025 20:43:47 +0200
X-Gm-Features: AS18NWCf9BHk3M78U-yTtMgDQhhnI1g2CI7k-KfJvPnPOvApY9tkkzNXTL8vud4
Message-ID: <CAMRc=Mdah6ve68h=d93VHXGij7KAQiGWuOGtzX_7VSPsCi=bbQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] string: provide strends()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 7:12=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Oct 22, 2025 at 05:36:33PM +0200, Bartosz Golaszewski wrote:
> > On Wed, Oct 22, 2025 at 5:25=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Wed, Oct 22, 2025 at 03:10:40PM +0200, Bartosz Golaszewski wrote:
>
> ...
>
> > > > +static void string_test_strends(struct kunit *test)
> > > > +{
> > > > +     KUNIT_EXPECT_TRUE(test, strends("foo-bar", "bar"));
> > > > +     KUNIT_EXPECT_TRUE(test, strends("foo-bar", "-bar"));
> > > > +     KUNIT_EXPECT_TRUE(test, strends("foobar", "foobar"));
> > > > +     KUNIT_EXPECT_TRUE(test, strends("foobar", ""));
> > > > +     KUNIT_EXPECT_FALSE(test, strends("bar", "foobar"));
> > > > +     KUNIT_EXPECT_FALSE(test, strends("", "foo"));
> > > > +     KUNIT_EXPECT_FALSE(test, strends("foobar", "ba"));
> > > > +     KUNIT_EXPECT_TRUE(test, strends("", ""));
> > > > +}
> > >
> > > Have you checked the binary file? If you want this to be properly imp=
lemented,
> > > generate the suffix. (Actually making the function static inline make=
s my point
> > > really visible)
> >
> > Andy, this is bikeshedding. This is literally the least important
> > piece of this series. It doesn't matter for the big picture whether
> > this is inlined or not.
>
> It's definitely not a bikeshedding. I try to keep a bit consistency here =
and
> I don't see the point of bloating a kernel (binary as well) for the funct=
ion
> that just a couple of lines with simple basic calls.
>
> Also note that with inlined version strlen() for string literals will be
> calculated at _compile-time_! This is clear benefit.
>
> Really, library code is not as simple as dropping something to somewhere.=
..
>

Ok, whatever I'll make it static inline.

Bart
