Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8366310E5
	for <linux-hardening@vger.kernel.org>; Fri, 28 Feb 2025 00:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740701059; cv=none; b=F6jMrFps1oM2he2WMd2+w4QhjLNMDBpRRlbGk+gyyMphJId1Fr8QIcuZq3gl75vZ7ny10oPjK6T/BkNU/dqSMz4CC3zEYpJCd9a+3KSSRy1hiEe6ur/3q8/1Mo8P06mkv9RUpXBoRDRfg/nEWy604Wyx0e9hC1gwzdvbGyTu3co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740701059; c=relaxed/simple;
	bh=PEcWf1lC0yhjFwXmZ+djf4p4vdM62eIMsikl4LRYCy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bnpMiwS/L4GgY9C+EzfNpqcpp23xyGA8IoG7trjPcMsUqfBwEX89RY9EsEr4+VzUSw04hzMu5yxAx1zNzBK3I0se7MsQb98RFcZndL3CDGnmLyhGun9tEy/0VMY5g3lzOAiCOeC0q2qFrxCwT6p5Kp8ORlz6gnersiV93RfAS94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kvic/EVZ; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kvic/EVZ"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5fc6f75aa8aso81188eaf.1
        for <linux-hardening@vger.kernel.org>; Thu, 27 Feb 2025 16:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740701055; x=1741305855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdAKRoI4MWNZS1p5ikuwofSWZ+m+ABE0cVc0cuX4/8s=;
        b=kvic/EVZUyZ01lsS213y+Wl0oiYKgD0Vo8fZTu7yhfIAMYA5xRc73CCZ9KgNHmlum1
         4XMttEnng3BT+pAKyh4jyoxQ5670+ma1MshtA55Zj86r1O++pRV8ZCe9VGxhyJyRMug3
         oM3cR/g7oqnk4IuEPyEftiTC6GOKs4akHMpZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740701055; x=1741305855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdAKRoI4MWNZS1p5ikuwofSWZ+m+ABE0cVc0cuX4/8s=;
        b=SfSIX/eZ5fB/bPkFqYjNFzCGejANjdIiZVqoZMDloFHN377JEuQrh/RdQ9KNMhKgFl
         v5yRuHzH9mU0LCbAHyaAX0lbBiS9NNkK6yCDnl08V3pezeZzxifYje0bEfA5OH2xEZpI
         Zw0CeLzDk/rwMWKJaclCIKurcm88+z24FUgROXH3CrPTbSmDslfQop45U+H/kDhLWooO
         pmAtt4pslp4ICZA1BlHu9uhVsoCGeRNWoANNkulml52ont1NrhvHuxHLoK1Dya99pSew
         ohk9JLr80Hi7LKOe/8OGtDgVa5x1E26ysYH2E9zdvLMgSmqI7T064XRPnRiZk7113Uep
         JaVw==
X-Forwarded-Encrypted: i=1; AJvYcCUH/S7abK92AED1RcYR8naQWrFcLds9B5YjaQgDXXVJdpCYQbgErZl1i5xj034x2hyf3qFkybFwZGwKJ6lUui0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSZgAsl4W56w3hqW0+txQW8E1pzhNoblAwwdOzvnhINAzEiGtu
	ZFNT5K7No1eQrDtT2Sih1kEBJcucyuIWZt08afxC/SIm6skRX+f/iHgt54xCoEV5Hh+v1kE8on9
	bsYFR2P8EkaoeIKibcgdFb3G9ZqIvI/+EETE8
X-Gm-Gg: ASbGncs8W6TFglm7PInCzkzn3Ls9aG107JXH7GsppvYQfAdztlOFtSV8UXw55BvUkYm
	Rzs7STe4ubRQSv7Je6gau41vnrmpySehC7uzyPKvwnieA5as1GGIvcwwBPbikWa6Vl8orJphzBp
	hnLbbb6+60CuHtCYgvQbfXWiUfUbc2YsTvssiohlX4
X-Google-Smtp-Source: AGHT+IGWuXQs0PIThChSzMMhBYpO8F+O5v1PgymX4okVh9IJ0FU07Sbjp0HW52pAlPT3tSirmglti/FDlIKqYQSJ9pg=
X-Received: by 2002:a05:6830:6c0f:b0:727:2f27:2a5d with SMTP id
 46e09a7af769-728b82f0b63mr269890a34.3.1740701055553; Thu, 27 Feb 2025
 16:04:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <20250224225246.3712295-2-jeffxu@google.com>
 <9abd68d9-3e6d-46a0-b92c-5aee0a90abf3@lucifer.local> <CABi2SkXT0z9YFsEkf3-HH0r_NuXXs_SJid9yzjuu0SwuxxWmZw@mail.gmail.com>
 <b7a38abf-f102-47b4-b085-213298c51aae@lucifer.local>
In-Reply-To: <b7a38abf-f102-47b4-b085-213298c51aae@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 27 Feb 2025 16:04:03 -0800
X-Gm-Features: AQ5f1Jq9-ymrZNzxRItoW5EEM_7nmfT5SZHdmMKzLXHDq-gTSSV1Cci_cu2NaII
Message-ID: <CABi2SkWeXJXmuE8OETJvbmxzGjk1e+5FUT9Gi2ZC35M-TcZWEA@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] mseal, system mappings: kernel config and header change
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
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

On Tue, Feb 25, 2025 at 10:04=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Feb 25, 2025 at 05:33:24PM -0800, Jeff Xu wrote:
> > On Mon, Feb 24, 2025 at 10:05=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > > +config ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
> > > > +     bool
> > > > +     help
> > > > +       Control MSEAL_SYSTEM_MAPPINGS access based on architecture.
> > > > +
> > > > +       A 64-bit kernel is required for the memory sealing feature.
> > > > +       No specific hardware features from the CPU are needed.
> > > > +
> > > > +       To enable this feature, the architecture needs to update th=
eir
> > > > +       special mappings calls to include the sealing flag and conf=
irm
> > > > +       that it doesn't unmap/remap system mappings during the life
> > > > +       time of the process. After the architecture enables this, a
> > > > +       distribution can set CONFIG_MSEAL_SYSTEM_MAPPING to manage =
access
> > > > +       to the feature.
> > >
> > > Architectures also need to be confirmed not to require any form of VD=
SO
> > > relocation, which as discussed in previous series some arches appear =
to
> > > need to do. I'd mention that here.
> > >
> > This might need clarification, the system mapping includes vdso, right
> > ? Why the focus on vdso ?
>
> My mistake, I thought scope was more limited than this when I first
> looked. Please disregard the focus on VDSO here... :)
>
> >
> > The sentence  "... it doesn't unmap/remap system mappings during the
> > lifetime of the process."  already cover what you want here, I think.
> >
>
> Right, I guess it just doesn't quite _emphasise_ it enough for me. Someth=
ing
> like the below would really help bring that out:
>
>         The existing of this flag for an architecture implies that it doe=
s not
>         require the remapping of these system mappings during process lif=
etime,
>         so sealing these mappings is safe from a kernel perspective.
>
I'm not sure I get the difference, but I can add it,  is below OK ?

To enable this feature, the architecture needs to update their
special mappings calls to include the sealing flag and confirm
that it doesn't unmap/remap system mappings during the life
time of the process. The existence of this flag for an architecture
implies that it does not require the remapping of these system
mappings during process lifetime, so sealing these mappings is
safe from a kernel perspective. After the architecture enables this,
a distribution can set CONFIG_MSEAL_SYSTEM_MAPPING to
manage access to the feature.

Thanks
-Jeff
