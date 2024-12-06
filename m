Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAD8198E86
	for <linux-hardening@vger.kernel.org>; Fri,  6 Dec 2024 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501498; cv=none; b=OiijQkqYa0/cjQsmF5k0kO0IxfMx441VieKZ41cnWxBjI8Sw40wzo9C5Pmow0GERUsMNtQLRy93txxJafuK8gUCVyQUPQEtu6s335vMZYiEhZn9tK0gDXr2FTfDuelRHwQmU7GVc5YhFDI5WF6XSlk7zJHhbBfyJwoaV2t8xEDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501498; c=relaxed/simple;
	bh=VWYNgE9pKVhQ5OgZIZ9+/rpckIIqRtpv6qJvrXEStuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=HTOybdPy6rBwQIQDMcONNtXUOTcJHrEfECkDYHRkhJGcOOyKwJqMqjxV/t+D+GlcaeZ/lXuehmvztzcUWxF+h45oGK4odT9w7oYbq9IwZ/EIN4658g9DXXr1MYXoxr3XXe+/34J/TlxKmhXxIzzo3sgPjtJuEwVOLOusoniBMgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G0WD0QjZ; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G0WD0QjZ"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5f1d660655fso59836eaf.0
        for <linux-hardening@vger.kernel.org>; Fri, 06 Dec 2024 08:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733501496; x=1734106296; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA+yFZiEQVvPrNXcoRRU+QeTGgabAJXB1krFWBWZtOw=;
        b=G0WD0QjZiRTtuNDBfMrilEyOhizZFGDnIPQfhHfikTX3y7e0BNtwd/cY+Le7EhOE8F
         ApD0tIZz6HO4I9FvfQaaLz/skscuOjo7+Xo4rjtNEkYYkpLYSbkDO4pnYEa7CUwM6hrD
         UwOOkFSAHWj6heI0xmNktbuD3YCQDk6lMZc94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733501496; x=1734106296;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XA+yFZiEQVvPrNXcoRRU+QeTGgabAJXB1krFWBWZtOw=;
        b=fX273180nSin39bO/vCgEQ2DjS+MAqez7BZmomXR5+MUwWISSxSz0RajVAL8dVTV6T
         xRpw8+X9IqaOZPSAX9peLz0lzYd7o6iZqd6kVUxDTE6q1vj86b9bFV0wGi1Uhml4Qamz
         6zsrmbHNY9VtYf27G/DpDulA0KsadKt3sWL12SGwjJ0NEixHBdCCgiM8QrZ/q0xZpan3
         YRMkN7KcxdcC6/zY9u3Tqx3Bvt97Bb1TysOwdHpWk7ElQrM3Fnv5bjqFTy3vl+QbX957
         9YUorvHsYHCNULHR3EkwEdkXO29lGIXVg+Ls0dvcUmzR/kpmIZzVXLDqiVo1Nl+SPeLg
         x0WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcY0VkWny0Czrzvgv2AOlAWfPN3vdnIKOEkGahYK43MeenjUwb0VQSvRysQTCLWDP7C83K4HFE2lm2ptf91hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY2r9QqesNKRiKGAdGOXthvw/14Mx8IQQciT0FPbYzLrA2E+iQ
	J2W+8Yl6t3CECMJROZ/8/bM7jsR2wR71G5gI0hTO+RfBH2oxrsdHccPAlakUVt9R6Ju07X9eIV0
	1ojFCi2d/3LphCcSu1Bc0P+LQksMsgUo+om1u
X-Gm-Gg: ASbGncshQSfyJSn74TlbobtT0i2DrJVWmUuo9pyAw0LEw0WoJopiex3I72inwc5SPjz
	NuHfhISzmyc1OVSLSZmWYJ1p1xlSeAwQ4OUEEBxipEyvvZJh9bI5zOuMPAG3qZmy9
X-Google-Smtp-Source: AGHT+IHaYff3JMPT81zyBSEM23QKqUx/UbkJQeJCV7Wp12IwDITkCTMpge+kUaz3qXTSTl0EJTZtDpiCttRvnyLy0H8=
X-Received: by 2002:a4a:eb19:0:b0:5e3:b1fe:b1a with SMTP id
 006d021491bc7-5f28700e98amr559652eaf.2.1733501495628; Fri, 06 Dec 2024
 08:11:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206013934.2782793-1-jeffxu@google.com> <2m3zmlehfigs5r7rptwcoft3j4fipfkgfxmdrdttpf76hwhwae@vclfa5ulcmv2>
In-Reply-To: <2m3zmlehfigs5r7rptwcoft3j4fipfkgfxmdrdttpf76hwhwae@vclfa5ulcmv2>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 6 Dec 2024 08:11:23 -0800
Message-ID: <CABi2SkUxcgKf1Z_zYNP+LOK8w=uUEKyq3fUpjJNcavhts2g0TA@mail.gmail.com>
Subject: Re: [PATCH v1] mseal: move can_do_mseal to mseal.c
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, jeffxu@chromium.org, akpm@linux-foundation.org, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	keescook@chromium.org, pedro.falcato@gmail.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 8:25=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
>
> * jeffxu@chromium.org <jeffxu@chromium.org> [241205 20:39]:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > No code logic change.
> >
> > can_do_mseal is called exclusively by mseal.c,
> > and mseal.c is compiled only when CONFIG_64BIT flag is
> > set in makefile. Therefore, it is unnecessary to have
> > 32 bit stub function in the header file.
>
> There is no reason to keep this function at all; it is used in one
> place, and that place uses three lines of code as well.
>
Sure

> In fact, having it separate from the comment about flags being reserved
> makes the function very puzzling.
>
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  mm/internal.h | 16 ----------------
> >  mm/mseal.c    |  8 ++++++++
> >  2 files changed, 8 insertions(+), 16 deletions(-)
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 74dc1c48fa31..5e4ef5ce9c0a 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -1457,22 +1457,6 @@ void __meminit __init_single_page(struct page *p=
age, unsigned long pfn,
> >  unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *=
memcg,
> >                         int priority);
> >
> > -#ifdef CONFIG_64BIT
> > -static inline int can_do_mseal(unsigned long flags)
> > -{
> > -     if (flags)
> > -             return -EINVAL;
> > -
> > -     return 0;
> > -}
> > -
> > -#else
> > -static inline int can_do_mseal(unsigned long flags)
> > -{
> > -     return -EPERM;
> > -}
> > -#endif
> > -
> >  #ifdef CONFIG_SHRINKER_DEBUG
> >  static inline __printf(2, 0) int shrinker_debugfs_name_alloc(
> >                       struct shrinker *shrinker, const char *fmt, va_li=
st ap)
> > diff --git a/mm/mseal.c b/mm/mseal.c
> > index 81d6e980e8a9..e167220a0bf0 100644
> > --- a/mm/mseal.c
> > +++ b/mm/mseal.c
> > @@ -158,6 +158,14 @@ static int apply_mm_seal(unsigned long start, unsi=
gned long end)
> >       return 0;
> >  }
> >
> > +static inline int can_do_mseal(unsigned long flags)
> > +{
> > +     if (flags)
> > +             return -EINVAL;
> > +
> > +     return 0;
> > +}
> > +
> >  /*
> >   * mseal(2) seals the VM's meta data from
> >   * selected syscalls.
> > --
> > 2.47.0.338.g60cca15819-goog
> >
