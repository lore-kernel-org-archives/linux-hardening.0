Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB761388
	for <linux-hardening@vger.kernel.org>; Thu, 25 Jan 2024 02:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706148281; cv=none; b=sFF0KRVf5ONauWE857u3LNsqQ2uXlIX1znfBcnaldfQiC39uKuj3NWHrueTRK9jdWEeESvgqi63bEwx4EHZw6nW5zUD2XzC0vthzo/EuqaD6WBv2dP22fskM5FwqPIPmC3ilA1xyE8kiKKTiayy8GPdoOv/yJ+XZEtnByIjhQgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706148281; c=relaxed/simple;
	bh=x+wQbWdcVMPUodjzXD4SxE6xh1+yMDdy02y2PjiYLDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ZHZBP6G818drvJIMPzujJNdDttjZu4F6HlsqgAkMlNjxECjgRVYbYxQO0pqfk/hn3MDm0q4rtp3mlU5f3eciRCwsFFt3EruvYDBMjISLuNau71syjXPZnirIlDIUOQAnddiRDNJiTJqKurPxl7KhJR2KYb6/s4WWsvSzPABVJZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W1FBNt3P; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W1FBNt3P"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e0f43074edso1790505a34.1
        for <linux-hardening@vger.kernel.org>; Wed, 24 Jan 2024 18:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706148279; x=1706753079; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXSbpxldRQwJaZgTsF93EIsC+O+YAl5Fx9J2K59JChI=;
        b=W1FBNt3PElSYMwZujslmnPNk4xLXEy2d8Yx9shFMJ3n2EPg350uOdeJ9It6aF498Un
         uxN+Nozn7NxOuHPQKwjVUVfqWhqsoQ3IpAjTHSNc7ufaAPXKV745Alz9Lubi+0WpdFXA
         HtLNskxWuhqWaxO+CAvWWMGwpjddZN5+2qxYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706148279; x=1706753079;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXSbpxldRQwJaZgTsF93EIsC+O+YAl5Fx9J2K59JChI=;
        b=Xr/nlipn3M+a1ATsLj/vKHmKtl/et9TwXaAQl57yXN4h+cQ14FMWf5LXPzgJKBppW7
         KMov5ynjeEzDkm9vBfNlVhsGL0iAtNhQ/yoNoNI4K3PZYe1l5IanmAtaeh29EcpUeTRg
         6CzoSQY6sgSIqwcedVgE1ncj0MERgBYAtXhcSEwDjSE9nLZ9pDYC2anqmH1c2OMuHuRK
         mLwMZM0XpxpStLaIlPEE6CgnPbvCL4gfQhO3q3bFwnTKZjnFaGE1DDsbqzuHGbXWfimc
         spusGLylHqsHeZviqS1KAsMeeJSqeu5eaP6NYB5Et8sj7d+UzV86WbGoinFAvbB22gXn
         ay4Q==
X-Gm-Message-State: AOJu0YwWtXeOXKPbmqbnvS+p5Y1mp3hPkVYSxQkiDk/UBTNYiKGQ7vp/
	lfgqH2EwabMyKrMyCbjScEZTw+AJZLmr/hThjv7z0QZM7U7yW7TaTMOk0kAuspOYgPV6oEs/JVb
	eB0sb8gZaWdwctFMy3a9eEHKLhplASVU2yb7F
X-Google-Smtp-Source: AGHT+IHlTe+z1MODYDADlbQ3RXk9t245ULpG2fW9+wJpOLVUAgr4K32ziK9o41eRX3/hO23gIpgTK9SNAOqnz8yLzS4=
X-Received: by 2002:a05:6871:551:b0:210:b3fe:67a2 with SMTP id
 t17-20020a056871055100b00210b3fe67a2mr140629oal.66.1706148277276; Wed, 24 Jan
 2024 18:04:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122152905.2220849-1-jeffxu@chromium.org> <20240122152905.2220849-3-jeffxu@chromium.org>
 <20240123181457.idckaydk7dt7q2qy@revolver> <CABi2SkX=wKnHmooxXzBnJxxmtfSjvfgYabN1Wh1LxFYjtFoFaQ@mail.gmail.com>
 <20240124200628.ti327diy7arb7byb@revolver> <CABi2SkV1MgPZvxdE52VSTGA7yxnv9-fZYfWe76xFd27cDyy_8w@mail.gmail.com>
In-Reply-To: <CABi2SkV1MgPZvxdE52VSTGA7yxnv9-fZYfWe76xFd27cDyy_8w@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 24 Jan 2024 18:04:24 -0800
Message-ID: <CABi2SkUxDJXEGVa7gTSPMroX6_Mx8f6HEhp_xBM3PDq6nnt7vw@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] mseal: add mseal syscall
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, 
	rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 2:49=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote=
:
>
> On Wed, Jan 24, 2024 at 12:06=E2=80=AFPM Liam R. Howlett
> <Liam.Howlett@oracle.com> wrote:
> >
> > > Considering this is the MAP_FIXED case, and maybe that is not used
> > > that often in practice, I think this is acceptable performance-wise,
> > > unless you know another solution to help this.
> >
> > Okay, sure, I haven't been yelled at on the ML for a few weeks.  Here
> > goes:
> >
> > do_mmap() will call get_unmapped_area(), which will return an empty are=
a
> > (no need to check mseal, I hope - or we have larger issues here) or a
> > MAP_FIXED address.
> >
> > do_mmap() will pass the address along to mmap_region()
> >
> > mmap_region() will then call do_vmi_munmap() - which will either remove
> > the VMA(s) in the way, or do nothing... or error.
> >
> > mmap_region() will return -ENOMEM in the case of an error returned from
> > do_vmi_munmap() today.  Change that to return the error code, and let
> > do_vmi_munmap() do the mseal check.  If mseal check fails then the erro=
r
> > is propagated the same way -ENOMEM is propagated today.
> >
> > This relies on the fact that we only really need to check the mseal
> > status of existing VMAs and we can only really map over existing VMAs b=
y
> > first munmapping them.
> >
> > It does move your error return to much later in the call stack, but it
> > removes duplicate work and less code.  Considering this should be a rar=
e
> > event, I don't think that's of concern.
> >
> I think that is a great idea, I will try to implement it and get back
> to you on this.
>
I confirm this works. I will add that in the next version. Thanks for
the suggestion.

-Jeff
