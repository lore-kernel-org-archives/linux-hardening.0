Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D382212FAA
	for <linux-hardening@vger.kernel.org>; Tue, 18 Mar 2025 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318498; cv=none; b=AOwmHeAmNBrlocaXagrIloXS9ki7uSlQX7NEkcBMlel4L7YVzxELCQwUibkCbf6JnXisFnXsrmG8c5J31QFyFXUEThwM9/JxRuKiAQAwj9f2bQZHY0+mwDfRMhNVJ34twquz/IOEnorpnkh98ASIt/rQl/03N81iK/T1J4Jagz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318498; c=relaxed/simple;
	bh=6nkANdaVG7IayPoAi6liKaZChcd4niM0WV300kXmOwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Goipdu3MuuRTNZu9PbfzTcZtOsJjAz6IU8fnpZlnsqaqYv6RjWs5DW3fgMf/+ZIbOQI4g5Crcm97uOboSi0MSIdVUpzk6ZZlQ0yKEkRBGp8h0uc8bhBjrfDUXa2aWoAExf87ZcCf2RHlguzGL9r82BbtIY/qyQWskVAVIobAblc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nrM8p/Oa; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nrM8p/Oa"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2b2806d5b61so220945fac.3
        for <linux-hardening@vger.kernel.org>; Tue, 18 Mar 2025 10:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742318496; x=1742923296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YTuIFIQ1RBKziTG64pV4QoQGQt4itwRwA2JcwE5F4U=;
        b=nrM8p/OakNE55mMw9RyGNl78PWiOHBjlVct8RjZQkoL5FSZSRcmknKT9WoRYFFxYx7
         mJGV0M0/kXjraQkkS65bVIfoWN4sb71mfAMUS1DhRda77VhYRQA7zuDTDBcORDzlYvRH
         BP18wMBUsM3uj5dxYSH3lNWz45J6vU6R2DyDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742318496; x=1742923296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YTuIFIQ1RBKziTG64pV4QoQGQt4itwRwA2JcwE5F4U=;
        b=bhmtHDQhhb98PWsyR4Wx3iucHoSVQuWPtbqgAzZWUOHsKDa7yn5QYvrA/Pd2YVt0Bu
         oua83Z3NC9SZE3cvV7YMu0ZOvbaC7l8GNCvhxYglzhxAHyfryEfPONt3ZZV4ok7PeveS
         bileVN24IokZXQOCqZLTT4m+VUA1N9IITUlC1cI/uj9fGbWyn0pE9tQCIoOQL/bNfXcu
         qaPlDydrp5sbQLfqnuS9oHPOtis7qOFa4LY2VDEjpsxger6G/icIlBmRCmfe+g6txqH8
         GIcGAopPerivhkAYdYb4KkO0mvHI78767lqwYkl22wYFvTI5y/aVZhiUASxOILHq2tNq
         Zpsg==
X-Forwarded-Encrypted: i=1; AJvYcCXbd/YhECzX0HOcAtfMGX9bJQdIv5wAGXfi4u3FmAlbSzwZt1kH41QeBIAPj77u5oaU1haAJlIEacXILQoyUVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2D5k5WRjvwsidnGcOaJu9vxs21B0JJJFrBFzBT3mouZ9YSn+j
	WGpznMR5yAqyVRp8kXQvNd00ZvbeMce+yRfFxtSzOeqneNIGeqmX9l5MUf+ovsHvSFla3TWZIVT
	aOPIIRJnrjqus/MLDwAb76A+/TvAHy3s+7RKw
X-Gm-Gg: ASbGncuRI6A1XGgFBma2Qvhdt0scfdxXSdWVqzAVhUgyOetYx6meo3q5cTMCWv8ipI+
	8Jtsx+wu8dS5jfXHnRzDbEHvp3+0pZW3Wfj8tvaZkHEB3RLyPPS/RPrA0VTgP5hiRHE6TK4cPda
	LgrbMTd1TnSRkJOdOxLnvYaRhnhn7d301siJLHGFzigMylFrwGxhRrGMBYfNjKJ7Xjsw==
X-Google-Smtp-Source: AGHT+IEA9vu4VLhY8SzQ5C5fLE3cuDbaXAtONvPGEXdN9PbXXBPEIkkr42m3jqwSpjbVyqbyqTeMXJB8Z5YFyBGFIpc=
X-Received: by 2002:a05:6870:d629:b0:2c1:aed2:abc4 with SMTP id
 586e51a60fabf-2c691117783mr3251144fac.8.1742318496170; Tue, 18 Mar 2025
 10:21:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313000623.3192896-1-jeffxu@google.com> <1bbce89c-1efe-40cf-9085-ec4ec16f7996@lucifer.local>
 <CABi2SkVKxyX0uDabg+wHiq_vTBFbUST-nRdur7cCPB2myhCWhg@mail.gmail.com>
 <CAMuHMdWLjX-OavON-rj50kZyvV5+Pf0x34WJbcdKsCgAQA7TwQ@mail.gmail.com>
 <CABi2SkWU6orm-wBFKVt9rsSpYURHPb7fjHRzkOiPGd=Lh-DdkA@mail.gmail.com>
 <CABi2SkWmxwM-MbfmRCZvBYek8KpmOKPMsFmb=-eZTgKfp3AN6w@mail.gmail.com> <CAMuHMdWUHwRXR1VHEVJm36Dp0B_H6SNwtWHAW1dMQ-iM4ORUWQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWUHwRXR1VHEVJm36Dp0B_H6SNwtWHAW1dMQ-iM4ORUWQ@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 18 Mar 2025 10:21:25 -0700
X-Gm-Features: AQ5f1JoBLvo5ksTh4tDs9xdewPkyUsD-KtLmDytrGzKKunZXfDz1Qx0ABMtNmGY
Message-ID: <CABi2SkVndMyOUpRR8z7f0J-r7chkVNZ17-kaEcBje1kBjk-1iw@mail.gmail.com>
Subject: Re: [PATCH] mseal sysmap: add arch-support txt
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, kees@kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, svens@linux.ibm.com, thomas.weissschuh@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Mon, Mar 17, 2025 at 12:14=E2=80=AFPM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Jeff,
>
> On Mon, 17 Mar 2025 at 20:02, Jeff Xu <jeffxu@chromium.org> wrote:
> > On Mon, Mar 17, 2025 at 11:14=E2=80=AFAM Jeff Xu <jeffxu@chromium.org> =
wrote:
> > > On Fri, Mar 14, 2025 at 3:41=E2=80=AFAM Geert Uytterhoeven <geert@lin=
ux-m68k.org> wrote:
> > > > On Thu, 13 Mar 2025 at 23:26, Jeff Xu <jeffxu@chromium.org> wrote:
> > > > > On Wed, Mar 12, 2025 at 10:21=E2=80=AFPM Lorenzo Stoakes
> > > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > > On Thu, Mar 13, 2025 at 12:06:23AM +0000, jeffxu@chromium.org w=
rote:
> > > > > > > From: Jeff Xu <jeffxu@chromium.org>
> > > > > > > Add Documentation/features/core/mseal_sys_mappings/arch-suppo=
rt.txt
> > > > > > >
> > > > > > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > >
> > > > Thanks for your patch!
> >
> > I used "find * |xargs grep -i  CONFIG_64BIT" to look for CONFIG_64BIT
> > under arch/, and together with internet search/wiki page, and below is
> > the proposed update.
>
> That way you only find users of the symbol, not where it is defined.
>
> You can use
>
>     git grep -W "config\s*64BIT" -- arch/
>
> to find out which architectures are 32-bit, 64-bit, or support both.
>
Good to know, thanks!

> > > > > > > --- /dev/null
> > > > > > > +++ b/Documentation/features/core/mseal_sys_mappings/arch-sup=
port.txt
> > > > > > > @@ -0,0 +1,30 @@
> > > > > > > +#
> > > > > > > +# Feature name:          mseal-system-mappings
> > > > > > > +#         Kconfig:       ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> > > > > > > +#         description:   arch supports mseal system mappings
> > > > > > > +#
> > > > > > > +    -----------------------
> > > > > > > +    |         arch |status|
> > > > > > > +    -----------------------
> > > > > > > +    |       alpha: | TODO |
> > No CONFIG_64BIT found under arch/alpha, but search results show alpha
> > supports 64 bits. Keep as TODO.
>
> Alpha is 64-bit only. So the code under arch/alpha/ does not need to chec=
k for
> CONFIG_64BIT, hence you didn't find it;-)
>
> > > > > > > +    |         arc: | TODO |
> > > > > > > +    |         arm: |  N/A |
> > > > > > > +    |       arm64: |  ok  |
> > > > > > > +    |        csky: | TODO |
> > (N/A)
> >
> > > > > > > +    |     hexagon: | TODO |
> > No CONFIG_64BIT found under arch/hexagon, but search results show
> > hexagon supports 64 bits. Keep as TODO.
>
> 32-bit only on Linux.
>
Ok. Thank you for correcting this.

Thanks
-Jeff

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
