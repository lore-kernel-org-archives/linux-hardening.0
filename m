Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE8E1CDFD4
	for <linux-hardening@vger.kernel.org>; Fri,  6 Dec 2024 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515696; cv=none; b=ZOFMAL0EEAWSJ94HtP/FmmOq5Jktbg3Cg7b6FjW/hYZDwNQFdawv2ZiRcp4ZlqljRmSku1lxTMIOfxK+dmSVd+L/87hTYCPBfkapAgoySpa6QghhUe02D/KwMgXr7OFnu4zyX4Zv9MqFbh8t+bGbESfgchxJXNvTDVklzKBFdg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515696; c=relaxed/simple;
	bh=z6Wqxq9GQSt08AJI8CDBz7RuSxWl1N8orrd/oG6fcs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4C89MZCi+dNoCWe8BN41Lh9ukWx9V8XfQ1MWWW88efNu19pGwFk+3UT2Ewn9Ev9WGUY1v2vrPvHkHzOWV0xJXdofp6w2rs1o6QXWcp6HjCglU43F9zV+T3fx542gnKwocuZGVplg2D0G9KK1so54xCOzPjtDqfJgvCdm6GGrN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JGFY4GgO; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JGFY4GgO"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71d4d3738a2so618866a34.0
        for <linux-hardening@vger.kernel.org>; Fri, 06 Dec 2024 12:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733515694; x=1734120494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fa40TeoQXNd/EST0klScC6VWGBe0xBrJUCm38PJDQfk=;
        b=JGFY4GgOLiqZSBfIKXbnLqW6QmgiNmw+XnkbwUH+LGodsRlVC3VeQQz5c1d+UBxpSw
         zLYNCOkuqhdhQvzqbKpfYiAKlUzFm1I+dwfrPEf6ninq9ecKuOqMrUpl+TULOsr97Wl+
         LI/i9cUACxVDNCbhIW4mhniAVbxQQp6s5Wv/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733515694; x=1734120494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fa40TeoQXNd/EST0klScC6VWGBe0xBrJUCm38PJDQfk=;
        b=gw+VsprSSE7n3HjUCr9NEsXmHSPH4fCu6PAmo67UB9xjVTaqLKEiYzfKHgy9zF5FfT
         o7CrDu++pAtt9022nrNRlvSK0bIWJPwMAHApPwcoyyAwRqk+CtRnR03rsX+MNMLxKWxO
         91M/XM/FEB5DjzbxrdoUXr5vVcNwUTa7Dliv6L4MTBjq+nr0w6M423dRsq08/TUBibQp
         8Sn/lo66TqK0I+IM5rf2VrNHSqAxIe3GkWy/qhu3O55TtZRS1c0Wa/v6YgHKnmen76Oe
         OKiu8T7GEGomjrropDWkFxmsNie4Q8XpJspUBAdGu+jpVU+gURPEbvcpuXOmr7d3dez6
         kefw==
X-Forwarded-Encrypted: i=1; AJvYcCW/hFy0JtKFXqrP9bUza4ul+7WoZcX4yJDDRk1V3cALEqDoO1pJj8Fn5CP62eppezBrzrTgk/+QEsli5mRHPC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2tzxVPnFrc0FxCByGVI09uhoCO5+zvCugu79bNU+cYlrOKeHQ
	XWDvYdvZE3Ioo0z7jxxL1U+Kr4wAo0xgcEwJNkgcI4g5SjbXV6bTobc2YGgefnELptV2+R6appd
	/RtVA/bU2yHVQnwN3vXr5AvmqLrFvtJZAzMQb
X-Gm-Gg: ASbGnctaMXR0Nq9GVxxRd8xxAIRo5pzjeGqgh2oRsumDvwzHofK7KPqWb4f3KopQTJR
	x/ConAthFmQ4wvsHmI8AuOs0xWKW8VQDzSAkkv/O+w0ZaEPB4Ls5jizjP+yA=
X-Google-Smtp-Source: AGHT+IGnhbchndsxQrpOqmx+L6gEP0mz4KnZxPFnbF3cSlHW3yU9Qu5eUura8Gsl1otfULbbGp1jxsGpXke5kG5WBgg=
X-Received: by 2002:a05:6830:3746:b0:718:ff2:c147 with SMTP id
 46e09a7af769-71dcf56a5f3mr987845a34.7.1733515693797; Fri, 06 Dec 2024
 12:08:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206194839.3030596-1-jeffxu@google.com> <20241206194839.3030596-2-jeffxu@google.com>
 <607a69bb-9b6f-4d0e-83aa-1ec6903c34a5@lucifer.local>
In-Reply-To: <607a69bb-9b6f-4d0e-83aa-1ec6903c34a5@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 6 Dec 2024 12:08:02 -0800
Message-ID: <CABi2SkV2gSx+5p1uS-YZnD90HzV8ZAFkpbsqSUL5usU+EW8HwA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mseal: remove can_do_mseal()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, keescook@chromium.org, 
	pedro.falcato@gmail.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 11:57=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Dec 06, 2024 at 07:48:39PM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > No code logic change.
> >
> > can_do_mseal() is called exclusively by mseal.c, and mseal.c is compile=
d
> > only when CONFIG_64BIT flag is set in makefile.  Therefore, it is
> > unnecessary to have 32 bit stub function in the header file, remove
> > this function and merge the logic into do_mseal().
> >
> > Link: https://lkml.kernel.org/r/20241206013934.2782793-1-jeffxu@google.=
com
Please remove the link field here when applying.
(I pull the mm-unstable and apply my change on top of the existing commit.)


> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
>
> LGTM,
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> > Cc: Jorge Lucangeli Obes <jorgelo@chromium.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: Pedro Falcato <pedro.falcato@gmail.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>
> Not sure you should be submitting a S-o-b for Andrew :P I'm thinking this
> is a copy/paste mistake.
>
I realized where this is coming from after seeing this response.
 Thanks for pointing it out


> > ---
> >  mm/internal.h | 16 ----------------
> >  mm/mseal.c    |  6 +++---
> >  2 files changed, 3 insertions(+), 19 deletions(-)
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
> > index 81d6e980e8a9..c27197ac04e8 100644
> > --- a/mm/mseal.c
> > +++ b/mm/mseal.c
> > @@ -217,9 +217,9 @@ int do_mseal(unsigned long start, size_t len_in, un=
signed long flags)
> >       unsigned long end;
> >       struct mm_struct *mm =3D current->mm;
> >
> > -     ret =3D can_do_mseal(flags);
> > -     if (ret)
> > -             return ret;
> > +     /* Verify flags not set. */
> > +     if (flags)
> > +             return -EINVAL;
> >
> >       start =3D untagged_addr(start);
> >       if (!PAGE_ALIGNED(start))
> > --
> > 2.47.0.338.g60cca15819-goog
> >
