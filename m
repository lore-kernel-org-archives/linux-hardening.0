Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD299221FBF
	for <linux-hardening@vger.kernel.org>; Wed, 22 Oct 2025 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147414; cv=none; b=Mi8DQqkNs/y8KQm8JUBQ8xwebyyZBZql0eju3qMDgIqv6TFJsczdQT1/NL46uA6w6PTz1lbtWdRGU0XalqKNVxkLkFvzhcYoSRQfaHnCoTkFhOcu/hS7LRcsunmSTfnoFB63Lt8dnkGb1ruJEWnw5H9s4MUqxTreX4Jguhc0SJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147414; c=relaxed/simple;
	bh=voJSs7Hw3Wl/EZaQou3RkTgu4VdQyS/EVwb9Mp9QVNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mz07klFj5Ck86ujm1F293XsKOIJDmLcldAtjQUUKRV4lyjgDx/5lFgBqqi3QJZh83hsA178kvdocOzpgesJaZO1k9FIrQR2HunLxYuZ6hvLQngDueL5Z+4BglXnx0gB6hmh9D+jB1bo3hQE9zM2gqbawDMxaBzSq5D/OWlXpbb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=L12t+1rE; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="L12t+1rE"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57e36125e8aso6648620e87.2
        for <linux-hardening@vger.kernel.org>; Wed, 22 Oct 2025 08:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761147406; x=1761752206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRzlJtgmeKcllMySQlFgaimNGUEcv2R+GqjiMHEJzN4=;
        b=L12t+1rE+8f9f2Pii8C/PIdRs9UoviXh9nOuNQfciu+K6ySdJHYZaubI8Ar0qund4h
         87cLYIm2isV0LihywDTjrUE33d2U+F+uSNel4OMVteAUWqf0NhsWuZGk//KVBBzthMBJ
         W4fB8wRsqMKZBHbuNv4Rq3PwYFsdylxTWDHSw9FcnkCog+tqej7kEXIUGk9df1LSVmCO
         srJ/y9tNCneiHfOQ4AUrXz6ZT4gF/cjiyLsErvxX4C2dZlZ/o3e9gTtiaz2Nyi7iuszQ
         VuSLCt8QoP762tAXBhLqvElEO/Tszi67Dds/nmxWBVMdZeiozzYZ7buez5BkpisZTuFA
         9tgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761147406; x=1761752206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRzlJtgmeKcllMySQlFgaimNGUEcv2R+GqjiMHEJzN4=;
        b=WW0YBSm+ycHTCK1lRjWYyAjscCZlOPIVExTPjq1u0XP2Fi21v8ywekVbYMcZy8D10G
         xp0e2ENosRISnWWHoKvedRx8pdtSPpO4piQiuf2o3ahVDoKNYsKyZS4lBq4cJMYvLnQ3
         Kfw0gjagABeTydIHp0kLMowmfrRzKp2bErCC/zDFJvkRC45RhjMbfAQnkmNFOY4YU1cV
         63RTCxU2MjjpzXCInGnlrg1lX6bAFrT+wG5c7vzZlIPHPmCizqUE9kJ0aPRhWSMQsJcb
         V2ZL0m0tYNvBDN6a3EIejY8mwxgAcdJrah7a+C518cmtC3CKSCxLyiY1MQltKOX2iwgp
         uUUg==
X-Forwarded-Encrypted: i=1; AJvYcCUKuv1RZ2UvCiW+amj/SpQuwYdrnlbUP0wIu2w2CwrINIenlItrYpNO6yVUQH4ujPjCp8O/RNguJlWg+gmFUY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTa7puVbdVqVjFE/OZvsxlBfN6gP67CocwYv1mV64VdIxBnYxO
	xSMQloJnhRMQLfOPJ40Td6k/R9GupDpPVVwmStAkRXoIVRLdQ8Sj9VtDRb8Q+yn74Uz3mKJYTXG
	zeAjJM+TgEkpIBQq3YNRFi8wrH/AvCe6zMxL41i8xDg==
X-Gm-Gg: ASbGncsOZchFJ31YPcZAbmCEb9Xbr3teW4DHPj+mB5KrAn8vHq56SlUWM7H/HgCkBG4
	iiWa2UkVwFCdcm6honX7/V/81lCZlcNlN0MIo4O7GQQWC5ZgKFGeixcnVvUinSSzk2I+sQie8FY
	CMyQTbb+/9ppcQcouNWEyMwx8szBrK6eO2WREFCP2ZL+vcC+AqwNq6Rf4v795EXYFKo8gzQsFoj
	2VeNwbhgE56RnCbOx7sHzlGQ1fyXrY7HCIwO1Oq/OpwXfM6skHrKj1eoGlQ3hGj5KR8En952wqw
	gAp5uVkWAAdldxQNpHGSr9jDuls=
X-Google-Smtp-Source: AGHT+IEi/irswdy4VVxLlO1hAN0Zsc9fjvuDKRe+i2ePli5jYREx+Bc29gt/0YVceCmzNFvpblDZjtrVlJp1Cz69730=
X-Received: by 2002:a05:6512:33d5:b0:58b:151:bc12 with SMTP id
 2adb3069b0e04-591d85a4b54mr8169026e87.51.1761147405947; Wed, 22 Oct 2025
 08:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-gpio-shared-v2-0-d34aa1fbdf06@linaro.org>
 <20251022-gpio-shared-v2-1-d34aa1fbdf06@linaro.org> <aPj3fCYj-NQdDSQT@smile.fi.intel.com>
In-Reply-To: <aPj3fCYj-NQdDSQT@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Oct 2025 17:36:33 +0200
X-Gm-Features: AS18NWDr85-ZpXwSC6o2WrSo4j9nQyRJc99PDFWHduyckze-ToGPJ6wk6IRJ840
Message-ID: <CAMRc=MeSFKRo1rHq5ENzKqws+gOAX=-nCsGtw5MXvsOwJr=XpQ@mail.gmail.com>
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

On Wed, Oct 22, 2025 at 5:25=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Oct 22, 2025 at 03:10:40PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Implement a function for checking if a string ends with a different
> > string and add its kunit test cases.
>
> ...
>
> > +static void string_test_strends(struct kunit *test)
> > +{
> > +     KUNIT_EXPECT_TRUE(test, strends("foo-bar", "bar"));
> > +     KUNIT_EXPECT_TRUE(test, strends("foo-bar", "-bar"));
> > +     KUNIT_EXPECT_TRUE(test, strends("foobar", "foobar"));
> > +     KUNIT_EXPECT_TRUE(test, strends("foobar", ""));
> > +     KUNIT_EXPECT_FALSE(test, strends("bar", "foobar"));
> > +     KUNIT_EXPECT_FALSE(test, strends("", "foo"));
> > +     KUNIT_EXPECT_FALSE(test, strends("foobar", "ba"));
> > +     KUNIT_EXPECT_TRUE(test, strends("", ""));
> > +}
>
> Have you checked the binary file? If you want this to be properly impleme=
nted,
> generate the suffix. (Actually making the function static inline makes my=
 point
> really visible)
>

Andy, this is bikeshedding. This is literally the least important
piece of this series. It doesn't matter for the big picture whether
this is inlined or not.

Bartosz
