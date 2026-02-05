Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688DB42DFE0
	for <linux-hardening@vger.kernel.org>; Thu,  5 Feb 2026 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307104; cv=pass; b=dxHT7xOrx03RDjqjypGwoVFKMY4v2pXS0faDXCvx40XCIS81qG2Q/c7IpxHS5exlgpbmPxJ1upS6bxebbfKuFey7NguCtTv1P91w0hDGIhUg+UkBx/liB3Dku1gOwJE6NSITNpUMywjhAP5GC7u0MZYTldzjE/NXHahEjG8uhJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307104; c=relaxed/simple;
	bh=mhRjsY9XdiyEWld+ROW1wj+EoQxOZCQ1eVAjPZCgUxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BKIBcBjdKC/kNm+Hymf1xbgi4LiI4MzKMLOx5eHOCvBhm8ot1UREBNFXF0qUAM5Qfngr6+3xiXJ1fRuTzVdWdS46qfIaG5Us/zoAO1xtD6XDA3x5fCb0pcAMWuMZ6YIo0atTOLCCWBbHKldLARtiEhI31xE68Y7U3ktfYoybVWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJIchiKl; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJIchiKl"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so12502005e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 05 Feb 2026 07:58:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770307103; cv=none;
        d=google.com; s=arc-20240605;
        b=O3IuxJXgJ90DLwEl5+5mEoCEA4DZdWW6nnKvZt0pzKsgMudbGr85u+ZMoElT1fOE/Y
         vlKS7KrZl5Vq8gcyI/CGTmOej9ir2bvNVbA3UUBE4y8GZYkaul0hsTZQBlmNrWFDHsUL
         A5EeDsKPTDgHeandzqwL4THaL+qs6yuh1P3NiplYRFjV8/Bp18ioT+q2UQ1AGz80IQaq
         yx1SseKiAMzENzZ7j7Drd30+qyaPhI6TAxh/FjeznpZsxO3/6bpeHr9iuGrpPW4mlLwY
         gYjC2dPXEaseLCKlT/uabG0CAaqkVJ55hlc4V17qLutTKaXCDy1/XeT4E709GMcpG50M
         jKsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lEOIUdssHjNAbAyKETqU9sXnwcXc0uZE8jvop6D9OmU=;
        fh=+3THw5Fi4A/CuEePz9xh5xGU7uH+YiK3NxkFSu8irHw=;
        b=ii8UBUhkVkLzw+1Fmzi3CyaRdLpftrzIbqbK6EqxzkkHdhrylBf+R3Yh1dg2OtW/vR
         cSs14fBaq13A3JURNZdw652JF6Qvoy7urOuKbph6myH+DFhz2gqPi4XENHVKePLC99QR
         Ez93R7f/EMPKdEynMf6BZCwfDNyjq9Swrr8vpwpV5UAclNNtwy9Ti7cl3cLgnclrq9/Z
         nxTGLcoz5cCfCiWjraUjpMrvpcXINVQIg7euZfiUyM7VLwcyxFTHvP3G5R0Nbe6oO5MA
         8pvfNBJtGdnaN4pgP9ii8Sc35JqUK6zdxGqSUQ1CEJFw48RWW/GgcLFN5L6eqPLf5HpG
         ZBSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770307103; x=1770911903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEOIUdssHjNAbAyKETqU9sXnwcXc0uZE8jvop6D9OmU=;
        b=PJIchiKl1VF0HBY71zykBGIw5xRoNXsmZbmffVCnrpESe8KUr3zNHBzax7S3DeGwj8
         4IFbH/1QFdqEKpncdiGoaO4gETSCnu0LMEWSSxa3VFkBnPyB4lxu+SP2jCpuDx41IDfY
         pakpOWde47KJeiEZhL7RrrSl8nCOuWM9qhW13bjw4MypX/QwcK3kkitCzgU058RQ3GHW
         06frYQzP5ozHRW4acrS3QmhuYn/DG3T/Go/0oEdJLbzr2UuHUQyf1iQAVkUhZXGgkYLs
         gCHit5g+lzshmxP/XPZ7VuvBqP5X8CaGpuRVHOu4RnA0354JzCgDI3wHAoI11IMJWWIP
         SUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770307103; x=1770911903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lEOIUdssHjNAbAyKETqU9sXnwcXc0uZE8jvop6D9OmU=;
        b=g7d6kODfwe8nxwUN3JMSxD/Dt+h3SuiQmfG36A8uxoxp4xoMtrbSKolr9NC2KLwrF1
         hcxzOfPabfMo2bjfLjmvfB3FAo/2YvmVY0Us4+0YI8uqaVvTDlHqerNIX1Gk1O2UiM9j
         iPi3AJ4P05DOU8WrkQvPLvnBaFi8oqFUMeEwfWZSWYGJdOO981L1nDGrZLs3dmTZIJip
         3aSdd6RShT/9c7/gaVLTeYjemcCEbuehnU3+b7RSqcPuhvtdkvXImb2ozpYfkAzwWahk
         I2fdqOjNaCRN334cW9uT5X2REMpBl6E0b6sx/QwmVutOOH07qImpe4L1sZ7BOoTKMohv
         j03w==
X-Forwarded-Encrypted: i=1; AJvYcCU8JU222CRraXo6hqS9UfVudZ7NuBqbfmTrWbNDYhd2RA5vlRZ4NNUczc3vYkJxB6ubDlQWPehqqB5RSwgKoXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJYTIauuRbXvhz5tG0ODb2P9pKlFuDwPx4CYwfADSDdpcULv3x
	rdk9/5deJiArAyFiaUZMBWQdSHjHoKHpYeY2QxRvIJONu6JMACDj4T8e/FwCHiHj8op6u5c6PY5
	99kx9DIe8memHPKqM99phCpP5KXdNt1Q=
X-Gm-Gg: AZuq6aJNDwYlVBlptfsxeYJOMjmZukxMehx/idJ8i5NiJdbyGCx8ungd/xyPZD1XWP7
	i2j76fFb512Im+ABA476nIwpVTghYe+vue5r87DxU4DVFzBQejxcrGMlW6yskIdT0GKfGvEcAjD
	h9c5X+s9V5ju8VFmvm+yIFlIqrnlo8tPdfpPn+gzry42V+eh+IoZR6T3ZTLMeyVjiHuorPSQsoB
	mcAgjsnKVo0R0kxZ/bRW1N+bUJkhKGse/Gl7kPFlY9bY4UbclB1estNJ1Pi7/r6d6B+KcLF+ha3
	sAg17GoC4XL0bswAGLiE/udmMnkCIxJolll17IRcu4aI+Z1D1cHFfYaOh55KLL+kSU1JNYx8
X-Received: by 2002:a05:600c:19cd:b0:477:93f7:bbc5 with SMTP id
 5b1f17b1804b1-4830e9402f8mr99700685e9.10.1770307102712; Thu, 05 Feb 2026
 07:58:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204132643.1302967-1-arnd@kernel.org> <aYRapf5K8wFGEO8v@pathway.suse.cz>
 <4637e47c-61b0-43bf-996e-6291f2b49f31@app.fastmail.com>
In-Reply-To: <4637e47c-61b0-43bf-996e-6291f2b49f31@app.fastmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Feb 2026 07:58:10 -0800
X-Gm-Features: AZwV_Qip0-Uod4KA17qrGjY15Db9LSEX5ZZwEFt60DeX3MwvopCq8Ga6SLOClDI
Message-ID: <CAADnVQJ5uHCVm3d_hO35cgrrcoLYBgk9x5iee0rNXBqKkHjj4Q@mail.gmail.com>
Subject: Re: [PATCH] vsnprintf: drop __printf() attributes on binary printing functions
To: Arnd Bergmann <arnd@arndb.de>
Cc: Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@kernel.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, kernel test robot <lkp@intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 2:13=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Feb 5, 2026, at 09:53, Petr Mladek wrote:
> > On Wed 2026-02-04 14:26:23, Arnd Bergmann wrote:
> >> Fixes: 6b2c1e30ad68 ("seq_file: Mark binary printing functions with __=
printf() attribute")
> >> Fixes: 7bf819aa992f ("vsnprintf: Mark binary printing functions with _=
_printf() attribute")
> >
> > From the commit message, it is not obvious why reverting these commits
> > won't bring back the warnings in the modified functions.
> >
> > My understanding is that the warnings won't get back thanks to
> > the commit bd67c1c3c353b6560 ("vsnprintf: Silence false positive
> > GCC warning for va_format()") as explained by the original cover
> > letter, see
> > https://lore.kernel.org/all/20250321144822.324050-1-andriy.shevchenko@l=
inux.intel.com/#t
> >
> > It would be worth to mentionin this in the commit message.
>
> Unfortunately, I have not been able to reproduce the original
> warnings at all. The va_format() warning and the patch to
> silence that look entirely unrelated here, that was just the
> compiler incorrectly identifying a function that does not even
> take a format argument.
>
> I'm sure some other intermediate change managed to shut up
> the warnings, but I don't know which one. My best guess would
> be that 938df695e98d ("vsprintf: associate the format state with
> the format pointer") made gcc no longer warn about bstr_printf(),
> but that predates Andy's patch and I can't easily revert it for
> testing. Checking out a kernel before those patches does have
> the warning on va_format() but not on the other ones.
>
> >> Link: https://lore.kernel.org/all/CAADnVQK3eZp3yp35OUx8j1UBsQFhgsn5-4V=
ReqAJ=3D68PaaKYmg@mail.gmail.com/
> >> Closes: https://lore.kernel.org/oe-kbuild-all/202512061640.9hKTnB8p-lk=
p@intel.com/
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> >> Acked-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >> For reference, three additional patches are required before we can dro=
p
> >> the Makefile.warn line that currently hides these warnings:
> >>
> >> https://lore.kernel.org/lkml/20260203162546.2254900-1-arnd@kernel.org/
> >> https://lore.kernel.org/lkml/20260203163440.2674340-1-arnd@kernel.org/
> >> https://lore.kernel.org/lkml/20260203164545.3174910-1-arnd@kernel.org/
> >>
> >> Tested using randconfig builds on arm/arm64/x86
> >> ---
> >>  include/linux/seq_file.h | 1 -
> >>  include/linux/string.h   | 4 ++--
> >>  2 files changed, 2 insertions(+), 3 deletions(-)
> >
> > Otherwise, the change looks good to me. Feel free to use,
> > ideally with the updated commit message:
> >
> > Acked-by: Petr Mladek <pmladek@suse.com>
> >
> > I wonder who should take this patch. Should it go via
> > printk/bpf/tracing or another tree?
> > Does anyone has any preference, please?
>
> I think your tree makes most sense here, but I have no strong
> preference.

As long as it makes into the upcoming merge window any tree is fine.
Let's go via printk.
