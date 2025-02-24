Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747D11A23AA
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740425660; cv=none; b=XrZoktlWUsgzYUgmqYkipoTC9nrP17rkBeHj0pD3nmKTtmgIw1Pzmed4mgLctVjbCvygdFQTA++LryLU53EsPo0WkNzHGdeg1qKqQgP0DC1p58sxAWBvfCy2pRcDm8TSfTYQWNyz5G94QvrneQBsINYiD4ozPQBJHvwjjqgyroM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740425660; c=relaxed/simple;
	bh=ZNAJBzjfq6uYqRLXpoJyrh8DGBBLa5628qhsEzaSUHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yh23L9+qfYl9uwhEhgG7gK36JgjTHCUrevfwEHT5OHdwylBSyrhsjK5G21UnbinXSdQ8Mct8OCm4cRcfzPZ8nsEgiCDQ9HbKdVhL1xJA4nMUHzxRo+mkwa/Ja3z4CfbujKZPRAo22ivGZcrhOgLur95DYOdng0uCNyF6WDOjSLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NaH9T0ST; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NaH9T0ST"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3f401d3b7a2so106283b6e.2
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 11:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740425657; x=1741030457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQY6dOosAcucIiRDQdMzsS+fL5tcNzoRGW55wAAQqwA=;
        b=NaH9T0ST7thZR1yZpBqvdhLxdmbViMCj731Q2fRcrVKvJACCSZOU5vYFEKIf8OLd+Z
         +hvGSqU4qeZX/PA5YZzfblp4aFfbU9V9yNDjRS41EKj3ndOQzJUwTRjgz0hq8+CGy6yX
         Hm3rhtL7EShD9xpeO4GEHQHGd2k6s92bpbOYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740425657; x=1741030457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQY6dOosAcucIiRDQdMzsS+fL5tcNzoRGW55wAAQqwA=;
        b=oOvEdEv8Avkw7ZeA+OfRmkcQKOjhf9OE//v7KY9x/Mpg+8Ja4dSToPVxT+nEAULbR0
         ytYQCEJhpD/9zyuBlCYuD/4xIgFLKMKn2oZvi/qZJoaCSeXpoPpZoQ3IqnMb/9DVquYy
         d72qPW30Ibq0wbTLpetGfwAIY2KJb+kpbaCg8gLgTKVOfVA8p6sxSQmX7IrFDqTGV4J1
         Jt4j+saq/JZ4l+QkOq82w+3H3lNYgffrdwHvqrWOdtoL6T93wyHlXUTvhsyvvvb15Z37
         5FNzhi5mxhHlOQts5wsj1HxzQwthxLmCkLC/imGWSC2lWEHHiCljJGEc7cgSIvRKqS9u
         6MHw==
X-Forwarded-Encrypted: i=1; AJvYcCVx+At14FytracPhjskqwdl0bFWf0Id5ceKFBOAP/BXfc6K4T8GYI41FN3awwFnLo2elYBkbTnH1z8LGmxu6Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7neGKpcAjPiNqSyv859zE1VhtmkeyFWfba6U6x85n84GcZvFw
	27A9Pi1zQ2pAHPpi1gr2dklsZVVGr3ah1OghdUVwS94noUnWPbZTeCBxNspD13msW+IrzTiBNcp
	Lw2wH70rAt7rXBaNY74BAHJ6aLYmgNjDSuFBe
X-Gm-Gg: ASbGncsn6MBsypZqA8IkGccWPOqY2ZZH+XKn9j2akDXCTCawBIBcoTmx4T4VGEFYwcO
	5SUORpKx1L+A64amE56+rPlVcg0RKgPCH6jqT4099EmlZD6j5qVRTvKzzQBm+2/Gm62ueRJO4Hq
	3AygQZ++T5jtiKRBFnBYlr6q0JJZpHRvxMoIfh
X-Google-Smtp-Source: AGHT+IFsKQI/wA+4sHfEV/I1olQBkEfue3loUdNFzmEYTOMnz4MZXEFiZGBxlenlf0rK5hXvgVztHBZRVg4eMn9wabc=
X-Received: by 2002:a05:6808:178a:b0:3f4:cf:5d7d with SMTP id
 5614622812f47-3f4247c0d9emr4328678b6e.7.1740425655952; Mon, 24 Feb 2025
 11:34:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224174513.3600914-1-jeffxu@google.com> <20250224174513.3600914-2-jeffxu@google.com>
 <443992d7-f694-4e46-b120-545350a5d598@intel.com> <CABi2SkVKhjShryG0K-NSjjBvGs0UOVsY-6MQVOuQCkfuph5K8Q@mail.gmail.com>
 <385e1498-2444-4a7a-a1b0-0013b0b8fd68@intel.com> <202502241053.1FF33D5B0@keescook>
 <lvzy3x2tv4uskn7dmatdqwqhhs4xv4vumk5f46thunndxqro6q@egremlepcgo7> <202502241125.75EF4FC783@keescook>
In-Reply-To: <202502241125.75EF4FC783@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 24 Feb 2025 11:34:05 -0800
X-Gm-Features: AWEUYZlICjQ_BKj7NOI18C7IZh1axQsiUlF463h-YGPwCWcvEopchlkyDHgqfEE
Message-ID: <CABi2SkXLFnfMkZ8xjxiu6Evcvk_yqNt3Yw9Xm0GXbTKMdi2mrQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] mseal, system mappings: kernel config and header change
To: Kees Cook <kees@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Dave Hansen <dave.hansen@intel.com>, 
	akpm@linux-foundation.org, jannh@google.com, torvalds@linux-foundation.org, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, 
	oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, hch@lst.de, 
	ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
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

On Mon, Feb 24, 2025 at 11:26=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Mon, Feb 24, 2025 at 02:10:58PM -0500, Liam R. Howlett wrote:
> > * Kees Cook <kees@kernel.org> [250224 13:55]:
> > > On Mon, Feb 24, 2025 at 10:52:13AM -0800, Dave Hansen wrote:
> > > > On 2/24/25 10:44, Jeff Xu wrote:
> > > > > For example:
> > > > > Consider the case below in src/third_party/kernel/v6.6/fs/proc/ta=
sk_mmu.c,
> > > > >
> > > > > #ifdef CONFIG_64BIT
> > > > > [ilog2(VM_SEALED)] =3D "sl",
> > > > > #endif
> > > > >
> > > > > Redefining VM_SEALED  to VM_NONE for 32 bit won't detect the prob=
lem
> > > > > in case that  "#ifdef CONFIG_64BIT" line is missing.
> > > > >
> > > > > Please note, this has been like this since the first version of
> > > > > mseal() RFC patch, and I prefer to keep it this way.
> > > >
> > > > That logic is reasonable. But it's different from the _vast_ majori=
ty of
> > > > other flags.
> > > >
> > > > So what justifies VM_SEALED being so different? It's leading to pre=
tty
> > > > objectively ugly code in this series.
> > >
> > > Note that VM_SEALED is the "is this VMA sealed?" bit itself. The defi=
ne
> > > for "should we perform system mapping sealing?" is intentionally sepa=
rate
> > > here, so that it can be Kconfig and per-arch toggled, etc.
> > >
> >
> > Considering Dave is the second person that did not find the huge commit
> > message helpful, can we please limit the commit message to be about the
> > actual code and not the entire series?
> >
> > I thought we said that it was worth while making this change in v5?
>
> Right, please minimize patch #1's commit log to just what it is doing,
> etc, and leave the rest of the rationale in the 0/N cover letter.
>
Sure.

> --
> Kees Cook
