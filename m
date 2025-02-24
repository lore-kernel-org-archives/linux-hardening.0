Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E77C38DE9
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 19:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740425637; cv=none; b=GDGW7B1WAuOxC4C/BPjq4eGh2+20i5j0p7A6YmWVFJaUHqn60Y+s/mUsMdDvztZ+RP1MhHTOtlSUMwpe9hT4G9OuBlAGMnHpTqi7drv2hZ16gjwdtnfaw/46VXYFQmIFbs/b+cxpz/Z+BwFl0tLefvXNuS70ztFt2qyF/J5rpQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740425637; c=relaxed/simple;
	bh=OotrpF0rvaeGp0UXEx4PTFmbFI/xIa0pun0V/TapBT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ScIrXAR5WpIEdsI9fZ+0wd/NCfXygOOXlcObHcmRvMZF1KJoe39vPbvZuT3HfyRf7+bEYyGDcPMxJpdy15iNSg9cqueyTnifqsWxche13W7o5LuD3x1zbMYeSkSq1hdxBRD8w+X8rU4+mzjUsZmc/Q3ZXsYqTsfRZRqRJy8Q7G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UnXsnLN7; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UnXsnLN7"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2b1f2b286f5so123544fac.3
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 11:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740425635; x=1741030435; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnjUGFbaBrwW6kAgXcvKtRWxmUU2D5hodPgXl1k5G+U=;
        b=UnXsnLN7C0hALvk/xFR6UIfsGSSRqKg+wrCo1eshB4osKlUWtITSWw+OW7yJvO1KU9
         wXt7YMoH4twMZNINazEQbvCpeMwMKsvwByVF9V8X7zXFUf6niel6FcuWPxFSJHD7/JZZ
         ACbpN4vuNdP5yxWEBb1aE0VePx9gDrgZrFeFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740425635; x=1741030435;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnjUGFbaBrwW6kAgXcvKtRWxmUU2D5hodPgXl1k5G+U=;
        b=A72Zv5gd5X4L/JWs0XN3n8Is7kdhZNcVYL3GmE+l5j7xaI9KM6+mGJ/Ic5koP42rd1
         tVzEGW0mTMVDZq0owqLN5XZbJhE+W2QfR2+2vEAj5cH71LZnhGL0Qr2unaDHKPpv1OCM
         iHuXn/4r3fSoI6lj2tuThs1Iqf4vWXUHxAbFxUFGZmxAtHcQP5k5e54O6r5mqnDhHfoZ
         hmelmC2FlX/OIIeftQUO5L7KZq3bCMAKrRskmBUWk0s+X3lmykI82yujYGHvtSfncHDR
         2PX/OkuUtKx59uYt4u4HNHr5cyRHRgNdtE+fBrSoWbL3sMfzu6ay9AVAHvGYSfj6awec
         3O5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWatc+s2JJ4aJZNyCnojq55KlBs+RoslX3K03pMUMHHguFzZdh+pMrZbvBeZPmiFmXcXobqFRQJpoRU8FrRjkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGQd1HqCN9R+AUXi/UTACriWG3Y9yeTuFXh4BHngPRDny9YRU6
	6QNqNAzKr0l0PWUZmG1YhsL866HuJVWbQPNzW6uhMrM2ZsvR023mW4/D4SxGhTAniaP5iZ3QXgU
	dw9xRGKzMNMsMxgCfACHAqZTNjRbHypvmNxkH
X-Gm-Gg: ASbGncudZuj80S5IGgviFJBag2L1b8gBSyea/wdP83KXpXkVfHS0q8Do3odE1gW584V
	76U94/ZBrnk8tuT0+2r+oydQ3MMyx2JU3FZFUmqfOslg6sA6F/KeaTORFf/wKmOaHiLUWqiUzFL
	Ms089bgYPtA06xKsUNobUpRx2a9gAIj5MFeMF5
X-Google-Smtp-Source: AGHT+IECBfDc8bF342UbaverJqxNJi+02rwQZrqufXUbn5FURGsu+d5N6F2sRjUe0EB4G3TUt2ZhKvacRWuj2clyLAY=
X-Received: by 2002:a05:6870:6284:b0:29e:32e7:5f0d with SMTP id
 586e51a60fabf-2bd50f74b8fmr3955851fac.10.1740425635255; Mon, 24 Feb 2025
 11:33:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224174513.3600914-1-jeffxu@google.com> <20250224174513.3600914-2-jeffxu@google.com>
 <443992d7-f694-4e46-b120-545350a5d598@intel.com> <CABi2SkVKhjShryG0K-NSjjBvGs0UOVsY-6MQVOuQCkfuph5K8Q@mail.gmail.com>
 <385e1498-2444-4a7a-a1b0-0013b0b8fd68@intel.com> <202502241053.1FF33D5B0@keescook>
 <lvzy3x2tv4uskn7dmatdqwqhhs4xv4vumk5f46thunndxqro6q@egremlepcgo7>
 <CABi2SkVv8+hNt-WjO2jp8zUNOiabncU35vNXApQi8yhBxcf86w@mail.gmail.com> <hnlyeo4bnmxlraihgpdqfucxfpkqu7zmcxs5yqokohudliotpe@ngiv444c2bdp>
In-Reply-To: <hnlyeo4bnmxlraihgpdqfucxfpkqu7zmcxs5yqokohudliotpe@ngiv444c2bdp>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 24 Feb 2025 11:33:44 -0800
X-Gm-Features: AWEUYZnp8EKxv3yJ29ShfwTeO42iLw8jApAg8SH2LEssheFiIXEtzkDSr3kDQfc
Message-ID: <CABi2SkU_-4sZgM8cTaEev_1V=M0QHk3=DK3ZBFr4Le7-d_v+7A@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] mseal, system mappings: kernel config and header change
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@intel.com>, akpm@linux-foundation.org, 
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	avagin@gmail.com, benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 11:32=E2=80=AFAM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Jeff Xu <jeffxu@chromium.org> [250224 14:23]:
> > On Mon, Feb 24, 2025 at 11:11=E2=80=AFAM Liam R. Howlett
> > <Liam.Howlett@oracle.com> wrote:
> > >
> > > * Kees Cook <kees@kernel.org> [250224 13:55]:
> > > > On Mon, Feb 24, 2025 at 10:52:13AM -0800, Dave Hansen wrote:
> > > > > On 2/24/25 10:44, Jeff Xu wrote:
> > > > > > For example:
> > > > > > Consider the case below in src/third_party/kernel/v6.6/fs/proc/=
task_mmu.c,
> > > > > >
> > > > > > #ifdef CONFIG_64BIT
> > > > > > [ilog2(VM_SEALED)] =3D "sl",
> > > > > > #endif
> > > > > >
> > > > > > Redefining VM_SEALED  to VM_NONE for 32 bit won't detect the pr=
oblem
> > > > > > in case that  "#ifdef CONFIG_64BIT" line is missing.
> > > > > >
> > > > > > Please note, this has been like this since the first version of
> > > > > > mseal() RFC patch, and I prefer to keep it this way.
> > > > >
> > > > > That logic is reasonable. But it's different from the _vast_ majo=
rity of
> > > > > other flags.
> > > > >
> > > > > So what justifies VM_SEALED being so different? It's leading to p=
retty
> > > > > objectively ugly code in this series.
> > > >
> > > > Note that VM_SEALED is the "is this VMA sealed?" bit itself. The de=
fine
> > > > for "should we perform system mapping sealing?" is intentionally se=
parate
> > > > here, so that it can be Kconfig and per-arch toggled, etc.
> > > >
> > >
> > > Considering Dave is the second person that did not find the huge comm=
it
> > > message helpful, can we please limit the commit message to be about t=
he
> > > actual code and not the entire series?
> > >
> > > I thought we said that it was worth while making this change in v5?
> > >
> > I include the cover letter's content in the first commit message to
> > clearly communicate the purpose of the entire patch series, saving
> > maintainers' time when accepting the patch.
>
> Having more text than patch for such a patch seems unreasonable.  I'd
> find it more acceptable if it were a complicated race condition, but
> everyone is getting lost in the summary.
>
I will remove the cover letter from the first patch then.

> >
> > Should I still include that, and add what the first patch does, and
> > separate it from the cover letter with  "----"? What do you think?
>
> Here is my v5 answer, I think it was clear about not putting the entire
> summary into the first patch.
>
Thanks.

> [1]. https://lore.kernel.org/all/ml3x5qchmnehdzz2rxsdcdghivaqffojiweuhvpv=
zw45u3l5bh@23sblrom3m36/
>
> Thanks,
> Liam
