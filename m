Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4101D517E
	for <linux-hardening@vger.kernel.org>; Wed, 12 Feb 2025 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739331630; cv=none; b=u1G4fbhK8xuSqdpWMr/6GHD40JquXPZTN7Z18vGD1yN4mQq4PFdlpAAin3AX0ZQ8CmE5/RqHoAau6LI28OMJYmeWqaCHEGoX6CVQTAq0FUID+oxexW3QWKisQEiotqDq0gwyP6zuPVlc5aOzL4PvKM4rrZ09J08KoFhfYC/iHH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739331630; c=relaxed/simple;
	bh=DBCyGV1EF2kVi6SpMZY5bssgMo6tiAe0sntzvUzsdoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=haFg0uJVd5VV53Ypn2X6UlpBbDQl1q6jzKO8QkEzz9tu/PiZZN9ifMsfYxnk6mr2RJK3w9rNaTHn57nxV4PwAwLN00APAQppIYzOsftBO4RD0mSdBWFmiAfefsFiuSKreypGE4/EKwALlFl08u2YlG0NKY2O69mQaTtUjjAB9E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V9264kiS; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V9264kiS"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3f3c2f4ee7fso243851b6e.2
        for <linux-hardening@vger.kernel.org>; Tue, 11 Feb 2025 19:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739331628; x=1739936428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1O1+kqXPDLIzus277gFO2o1Khwx0jyRKEzNJbJfbQ8=;
        b=V9264kiSmq56XVlnlBf4De6kBBSr1YtfnKVHh0GZwBcp/lTYcXSjfuW+w2+VJWqeeh
         iZ96+ARYCTQkOlLtbPTchOOEtsjpmCEniikv2Y7bFVXMA8Srnn6kFUhwerkob4fJIH2g
         g/H+K40JYDbrCNvZs8gnQFYnZAmGzIz4WeGvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739331628; x=1739936428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1O1+kqXPDLIzus277gFO2o1Khwx0jyRKEzNJbJfbQ8=;
        b=ObzbYe5HIH8K5+tZ+cSTuCZH7/fgbWB9WtN8XXbKQhYcUD+qENNLLXxZoKCbNyBpoz
         AKv29qGwkOFzyF9T7z55ct0JjEF929qxcloDLdwOSUKejjoAWPXvW82D+0KTwRGhCMuv
         j5hQ8Pv9qMrC7OI+SDhuHND0ki35rEKwOl1Fzr4Yp3YuCNhxnRlKgrjZS92yyBxTnMyP
         oSU0oW9CzR7SlLqugTpFcsKG0vnNwhxhB9mxSpgiPm1FMUetoced71QNXK7BO5eOpNbo
         LiNFX7tpafC1dErjGadqeskiR3Vh91uNyLq2Em1wdq3+Wvp56YUdK5J5h/UDByjKwOZF
         FBMA==
X-Forwarded-Encrypted: i=1; AJvYcCW6//B5Uj7Grn9w+QD5VJyy9rXOKhJwzA5bpKj6HPofhLIjEnQYyPmaMRj08Xv2bcdkDV0tl2o+Rdd9BPJKBlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygdXVWglvuwaYXOKlCEIXIO5VoIbKQXKpEyrzEm2hTwRmEwf7T
	UZx4h6JXPaNCthb4vOv+iMBZiZNoUXfhMESbnuZ/HDyHj/JBT9aJK9LgVuSqL3fiezqml7TJCup
	e9jfFH6yoQEU8td41oOVQ44twEJ3QgWPZnw5i
X-Gm-Gg: ASbGncvN2ySK4INtt8nW61k8p+1O4xitVb1fZJF+XOzkTIbvg9E/yiyrnnlgIPMhgui
	j6Knn8S0Jq/YZJdRJQvGTrAYfmVuw65ikUGNCALsaCBLJpjt6T8S9OVmbIbYipMLB3JhOBgNhxx
	4g6w7N6XhOHSkK/ChS7/U+2tGl3Mrjrg==
X-Google-Smtp-Source: AGHT+IHS5JwD+Jt0SwmBinJt8SPZp/OeUf8HMOU2PgEZ1F7kG42eaLlTkBqNf1TT9g4dqMBA7NLngUztb2UDdxDdlzk=
X-Received: by 2002:a05:6808:1817:b0:3f3:b2e6:f57d with SMTP id
 5614622812f47-3f3cefd766bmr279476b6e.3.1739331627854; Tue, 11 Feb 2025
 19:40:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212032155.1276806-1-jeffxu@google.com> <20250212032155.1276806-2-jeffxu@google.com>
 <8899161a-573d-4826-a6f8-88c2dd145692@infradead.org>
In-Reply-To: <8899161a-573d-4826-a6f8-88c2dd145692@infradead.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 11 Feb 2025 19:40:16 -0800
X-Gm-Features: AWEUYZmE2X6QlpBPZRLc059M-Bg0dneOqDbOfyqMe-duzNz4oMske6H0kyectqU
Message-ID: <CABi2SkWeTCZ+vfLLvgNe+M98N0Dnyzd+SyhF3Bx8rM5YPMuFhg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 1/7] mseal, system mappings: kernel config and
 header change
To: Randy Dunlap <rdunlap@infradead.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	avagin@gmail.com, benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, davem@davemloft.net, 
	peterx@redhat.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	enh@google.com, rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 7:31=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 2/11/25 7:21 PM, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
>
> > ---
> >  include/linux/userprocess.h | 18 ++++++++++++++++++
> >  init/Kconfig                | 18 ++++++++++++++++++
> >  security/Kconfig            | 18 ++++++++++++++++++
> >  3 files changed, 54 insertions(+)
> >  create mode 100644 include/linux/userprocess.h
> >
>
> > diff --git a/init/Kconfig b/init/Kconfig
> > index d0d021b3fa3b..892d2bcdf397 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1882,6 +1882,24 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
> >  config ARCH_HAS_MEMBARRIER_SYNC_CORE
> >       bool
> >
> > +config ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
> > +     bool
> > +     help
> > +       Control MSEAL_SYSTEM_MAPPINGS access based on architecture.
> > +
> > +       A 64-bit kernel is required for the memory sealing feature.
> > +       No specific hardware features from the CPU are needed.
> > +
> > +       To enable this feature, the architecture needs to update their
> > +       speical mappings calls to include the sealing flag and confirm
>
>           special
>
Ack, will fix.

Thanks !
-Jeff

> > +       that it doesn't unmap/remap system mappings during the life
> > +       time of the process. After the architecture enables this, a
> > +       distribution can set CONFIG_MSEAL_SYSTEM_MAPPING to manage acce=
ss
> > +       to the feature.
> > +
> > +       For complete descriptions of memory sealing, please see
> > +       Documentation/userspace-api/mseal.rst
> > +
> >  config HAVE_PERF_EVENTS
> >       bool
> >       help
>
>
> --
> ~Randy
>
