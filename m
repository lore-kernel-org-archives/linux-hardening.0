Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAF22F7F02
	for <linux-hardening@vger.kernel.org>; Fri, 17 Jul 2026 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305066; cv=none; b=aOzhr9zLRCQ44/6VKZ+dslHUuwkEauUT/hC7B1Awyh9ZKzshhYrJiKdvxw84DGAA8lPggkwuIxrmtXNm0CZn88Jj1Yu0VeorS6x5nKYESJMxGECSPdkfhoS27B6Y4JYyOIeeDCuI13IsSyMMxrjD0PwNXaO0tpcJq0PfNu9ek3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305066; c=relaxed/simple;
	bh=hr2P2MH+R0IBzQgkI7o5io3mlFSLxg3GRQF7CqDV6i8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WkJnQYVC6GPn1IdK/g5wPs7VjuU+OuFp/OiM1L+w8pQ68fl898NbhrUmmYCiOqWN2u/7uJqIoQxCl+ww9VKGTsmryeRLs8L5NhIkBPDfn3O/6Y2+cLWx3biyF+P+X0u+5a/8tznCliyHBOhes0a7KIvB8R0ShTCcsmpV7+ABr9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X7KJ9OZV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7KJ9OZV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784305063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YXT11wOAqu0oxYNTZs56G73VylOJLbfiDeKc8PzTMns=;
	b=X7KJ9OZVzdosexJHsJb7tDRq3F7Gv91M34wc5cHin2g6+XeuPrhEFJsQWznhnf+1hJOnMt
	M4CZ/xEgporDtVhzPy2nfVVEqdScpPnASOJKaz+2m3EPH9ijXdLuiptNKJgzUTvXNxrdTI
	nNk/qSvkEOvppcRZGZF4zl7Lg0EdWEw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-oZsWmFGwMuqHRPdr8rc6jA-1; Fri, 17 Jul 2026 12:17:42 -0400
X-MC-Unique: oZsWmFGwMuqHRPdr8rc6jA-1
X-Mimecast-MFC-AGG-ID: oZsWmFGwMuqHRPdr8rc6jA_1784305061
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4954c2d4081so5061845e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 17 Jul 2026 09:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784305061; x=1784909861;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YXT11wOAqu0oxYNTZs56G73VylOJLbfiDeKc8PzTMns=;
        b=F0p/ixZuBzewWv+HcZnDbxvjTzd1gFpiMcf7eOdTYXZkwowV4+87IbgSZ48dKLupEv
         ApR1j1H2OUGzI8MGrPYOx6SlmlLPkPlOV19Vmuynu5ChALsgl7uZxeR5pEAMNJxopyrZ
         jcVvCwOaDCVAJ3NR7PDIpJnTHtHQFaesbZOwIeJZ4R/GRXTt/MSWktzPHTQIqog6c/FK
         8I+m2WwUdckiUCATR3J0ClPk1mlyxb2frf7aHfymB+YLW+ipPKd58cmv8XpvSM/+OrDf
         tJB58L4Qk8Y35yIs0iYfYesm/g/TH4i7f2pErjTUWXgahrjxmCcnXHvzwNF/OXPzP5wC
         Jqgw==
X-Forwarded-Encrypted: i=1; AHgh+RqUsoTRxYhahgKq8Wuv7EGPOJH2T/g+qpApbPFV9tDP5++zMmJntugkpxXrt0r4gr8/WgmY8if1ffC3gZkdTUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhGvSZQ8kmVbdrL1wAHswAuT2uyK13su7UAkW2wZ5mzUznowLd
	DvZVOIpm2I41sgnRw5wZypU6c8yEiTrG1KiKo2BQeDfxz8JMemxbZD1PKAYKh+/L038xQOM2KKE
	UffB8mPbbENHU0Ry8+PJAVmtGXCCBpXU6nkPUtPrF4nNbWCs+Pj+jTqyI7NIqjajz+fpeLc2oOU
	YrbX6vowF9dc6ops0Wslfbh08SZN93pYVZZIjHr+fAFvSt4aGe8Vx9VrU=
X-Gm-Gg: AfdE7cmh+V++muoG9ufnIGfBr9B3ydcIqRhb1KRXiP7Fzg0aMXURWObS8HehY3FhShu
	6BhofoW/wUZOEY09a4TjXaHT8xFvYAi/WMlb0RuGltCHdJtF9if3DAOZ9Rxmfn4ZDmxN1pUCY9R
	rZ+A6QAZXEOsaxXoF+S0Z8B+4jSHo0oGyGJ0Uml12bNPg6/VsoCRAf+/fK6UsvsyN1me7dnV5/o
	CG0OAs+a5Jwlig=
X-Received: by 2002:a05:600c:1f8e:b0:493:f639:9b2f with SMTP id 5b1f17b1804b1-4954a513f80mr40741175e9.39.1784305061426;
        Fri, 17 Jul 2026 09:17:41 -0700 (PDT)
X-Received: by 2002:a05:600c:1f8e:b0:493:f639:9b2f with SMTP id
 5b1f17b1804b1-4954a513f80mr40740785e9.39.1784305061013; Fri, 17 Jul 2026
 09:17:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714151818.538869-1-jtaubepe@redhat.com> <202607150906.33F01B40@keescook>
In-Reply-To: <202607150906.33F01B40@keescook>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Fri, 17 Jul 2026 12:17:30 -0400
X-Gm-Features: AUfX_myHiwbSFnZA7pykG4S2FdrSIoimOaEtOBf23z7uaiU33r0-xSVZLcdcRTY
Message-ID: <CADRr4bfXHAHhOwnxaFFTJ7CWFE6PAReqnCWPAqQQuPAmU3d-SA@mail.gmail.com>
Subject: Re: [RFC PATCH] overflow: Add DECLARE_SIZED_FLEX() helper family
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Christoph Hellwig <hch@infradead.org>, John Meneghini <jmeneghi@redhat.com>, Chris Leech <cleech@redhat.com>, 
	Jesse Taube <mr.bossman075@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UMcZ-i67AKs2VcmhMRg1Zo4qIpS_3ALMVoPOSFmrp-8_1784305061
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 12:12=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Jul 14, 2026 at 11:18:18AM -0400, Jesse Taube wrote:
> > Add new DECLARE_SIZED_FLEX() helper to set the default size of a
> > flexible-array member. The code is identical to the declaration in
> > __DEFINE_FLEX() which has also been changed to use DECLARE_SIZED_FLEX()=
.
> >
> > Add DECLARE_COUNTED_FLEX_ARRAY() helper which is a variant of
> > DECLARE_FLEX_ARRAY() with a counted-by attribute.
> >
> > Also add default sized variants of
> > DECLARE_FLEX_ARRAY(), DECLARE_SIZED_FLEX(), and
> > DECLARE_COUNTED_FLEX_ARRAY(), DECLARE_COUNTED_SIZED_FLEX().
>
> Where do you want to use these new helpers?
>
> > Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
> > ---
> >  include/linux/overflow.h | 58 +++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 54 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > index a8cb6319b4fb..a3384cae49e5 100644
> > --- a/include/linux/overflow.h
> > +++ b/include/linux/overflow.h
> > @@ -464,6 +464,59 @@ static __always_inline size_t __must_check size_su=
b(size_t minuend, size_t subtr
> >   */
> >  #define struct_offset(p, member) (offsetof(typeof(*(p)), member))
> >
> > +/**
> > + * __DECLARE_SIZED_FLEX() - helper macro for DECLARE_SIZED_FLEX() fami=
ly.
> > + * Allows for easily declaring a structure with a trailing flexible ar=
ray member
> > + * to have a specific size.
> > + *
> > + * @obj: object to be given a specific size
> > + * @name: Name of the array member.
> > + * @count: Number of elements in the array; must be compile-time const=
.
> > + */
> > +#define __DECLARE_SIZED_FLEX(obj, name, count)       \
> > +     _Static_assert(__builtin_constant_p(count),             \
> > +                    "default sized flex array members require compile-=
time const count");    \
> > +     union {                                                 \
> > +             u8 bytes[struct_size_t(obj, name, count)];      \
> > +             obj;                                            \
> > +     }
> > +
> > +/**
> > + * DECLARE_COUNTED_FLEX_ARRAY() - Declare a counted flexible array
> > + *
> > + * @type: Type name.
> > + * @name: Name of the array member.
> > + * @counter: Name of the __counted_by member.
> > + */
> > +#define DECLARE_COUNTED_FLEX_ARRAY(type, name, counter)\
> > +     struct { \
> > +             size_t counter; \
> > +             type name[] __counted_by(counter); \
> > +     }
> > +
> > +/**
> > + * DECLARE_SIZED_FLEX() - Declare a structure with a trailing flexible=
 array
> > + * member with a default size.
> > + *
> > + * @type: Type name.
> > + * @name: Name of the array member.
> > + * @count: Number of elements in the array; must be compile-time const=
.
> > + */
> > +#define DECLARE_SIZED_FLEX(type, name, count)        \
> > +     __DECLARE_SIZED_FLEX(type name[], name, count)
> > +
> > +/**
> > + * DECLARE_COUNTED_SIZED_FLEX() - Declare a structure with a trailing =
flexible
> > + * array member counted by count, with a default size.
> > + *
> > + * @type: Type name.
> > + * @name: Name of the array member.
> > + * @counter: Name of the __counted_by member.
> > + * @count: Number of elements in the array; must be compile-time const=
.
> > + */
> > +#define DECLARE_COUNTED_SIZED_FLEX(type, name, counter, count)       \
> > +     __DECLARE_SIZED_FLEX(DECLARE_COUNTED_FLEX_ARRAY(type, name, count=
er), name, count)
>
> I ask about where these will be used because one of the things I want to
> keep tied together is the "counter" and "count", which usually means the
> declaration should be combined with an initializer in some way so that
> the counter gets assigned, as DEFINE_FLEX() ultimately does.
>
> I'm worried that extracting the internal construction of __DEFINE_FLEX
> means we may run the risk of increasing the risk of losing that tie.

We can add a comment to make sure to set count, or use DEFINE_FLEX
to allocate it. Im not sure if there is a way for this to be a compile time
error though.

> So, I'd love to understand how you want to use this, as that would help
> my understanding and potentially shape the design so we can keep counter
> and count strongly associated.

Basically, I want to use `DECLARE_COUNTED_SIZED_FLEX` for a version of
this patch that
uses `__counted_by`
https://lore.kernel.org/linux-scsi/97526d45-ec7d-48a0-bdc6-659f75839f53@emb=
eddedor.com/
I have checked that it does always set the `counter` variable correctly.

As for `DECLARE_COUNTED_FLEX_ARRAY` there is already `DECLARE_FLEX_ARRAY` a=
nd
the counted variant is already used in a few places. A good example is
`struct max77759_maxq_response` which subsiqently gets allocated with
`DEFINE_FLEX`
https://elixir.bootlin.com/linux/v7.2-rc1/source/include/linux/mfd/max77759=
.h#L253

I assume you are ok with adding `__DECLARE_SIZED_FLEX` and
`DECLARE_SIZED_FLEX` as
they are usefull in cases where keeping structure offsets is
important, similar to
TRAILING_OVERLAP. An example of where `__DECLARE_SIZED_FLEX` could be used =
is:
https://lore.kernel.org/all/20260714185621.610105-1-jtaubepe@redhat.com/

Thanks,
Jesse Taube

>
> > +
> >  /**
> >   * __DEFINE_FLEX() - helper macro for DEFINE_FLEX() family.
> >   * Enables caller macro to pass arbitrary trailing expressions
> > @@ -477,10 +530,7 @@ static __always_inline size_t __must_check size_su=
b(size_t minuend, size_t subtr
> >  #define __DEFINE_FLEX(type, name, member, count, trailer...)          =
       \
> >       _Static_assert(__builtin_constant_p(count),                      =
       \
> >                      "onstack flex array members require compile-time c=
onst count"); \
> > -     union {                                                          =
       \
> > -             u8 bytes[struct_size_t(type, member, count)];            =
       \
> > -             type obj;                                                =
       \
> > -     } name##_u trailer;                                              =
       \
> > +     __DECLARE_SIZED_FLEX(type obj, member, count) name##_u trailer;  =
       \
> >       type *name =3D (type *)&name##_u
>
> -Kees
>
> --
> Kees Cook
>

