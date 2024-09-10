Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470E41DA4C;
	Tue, 10 Sep 2024 01:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725932908; cv=none; b=af3SfVl/+QP8pLYazSFfxl5EQXSl9y/jLpSSCQHz4nizH+xstYoB7Xql5EIsTa0n+ezXMxRIflhYdxYWJAey4b6uCufbt1OMkP3NmbVkKoT5HrVRIIXm23uaNmpOnbCX+c6IE+ILeItp4tDOD6bRsLORjTFGZ6kfQRQUp94a4yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725932908; c=relaxed/simple;
	bh=ZypM3/zht80i56kW35QLeNJJdC5wB81rwkURzr3u7Ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VaLkTMVU+Zz4RU0UyWyvhGFlrGe4+WO7S7qLnmyKi2Ir9AHpctekezC91hTWgSAxCKdU3UCYbAqaD0HKsz6UytVe7bDJgRmg1Z7/zSCIaewb58w5rZBXPxOVLY0w4TNrmZN4WN2PCWr+KywpA/RDrX02zXmoLbLRADL4R75F41c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2055136b612so60084215ad.0;
        Mon, 09 Sep 2024 18:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725932905; x=1726537705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HODmoCst8rl2FQalNg6i6Q2z8m5IFyVmU0pEjYjJs9s=;
        b=cy5DFxJEVW+9JjRWLPhkakNUyVnm/WQVzFdcDQ1GSLH3rh19/pip2aTwNvZtR5PCGj
         lT+nG1fL5cy5U3ymYo35dmVENozVsZcGlRgoZf73q9hMsSzryovlNmGQUmOvTff1B2sF
         yNrzUnDgWYHtqlrcS/Yy61pcl1j8jOUV5ZgCxTtAIbm5DLnUF3CPm8C33dHwLQ7CQ//M
         2ml2zTRU0jaHfRB1f7G9kwylM+/VXnC0Xq1UKpuBapWo4x8iph5HdCW3qqqlERvEXm5M
         ZWV6biK0UNtGQKGjBlHpMJW1Fm6u7ECO/p1AcErujtqfaqF5/bIRfp+MUMuwVhNMfQox
         z/4g==
X-Forwarded-Encrypted: i=1; AJvYcCUy7p7qXQY3GEIO8m0AtqEn6CZFfTrgzYi3kZ2ZizgY2EAVQRxICKYYIHRfYzdtPYqZ1LNvSAVOe35JcfqH@vger.kernel.org, AJvYcCXFHfZExh8C0vB7VvnTw5vW8S+jikxGLJYXisAMsO/EKOQ4NptMdlEjRmnnWt6N9E1RT1pZTYWAPHfOUEBSTSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSkd6VhqHn2vZE0QglzKf6nuIQ4RXR/vXSjDMUJzEYkZ0QrrmX
	6sSLy4b096qeDXrdeDPmS5Kz2HdT8dkNS03ibpxaAOm4AKD97RFcQcLWabcGMrNU8foHnoypffz
	YS1EEpNLASHYwC/zN4dybWGQ4Yjc1DV3X
X-Google-Smtp-Source: AGHT+IFbHRPwN5Mp1j3S4DCIh4rMQL3pr/K9GlptHf6PoOIaTwx3taGg+iPWHA1UsUVm2i2/GFdCeZzVJu/U2ma/XZ0=
X-Received: by 2002:a17:902:ecc2:b0:202:100f:7b99 with SMTP id
 d9443c01a7336-206f0529ea9mr211295685ad.22.1725932905454; Mon, 09 Sep 2024
 18:48:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909115221.1298010-1-mailhol.vincent@wanadoo.fr> <20d6a62f083d47828b3d5f49000d5e2b@AcuMS.aculab.com>
In-Reply-To: <20d6a62f083d47828b3d5f49000d5e2b@AcuMS.aculab.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Tue, 10 Sep 2024 10:48:17 +0900
Message-ID: <CAMZ6RqKaSm3EDCAu=ttmZf+Qb-PjsMjo7OYoLzoaNOq_=XK0-Q@mail.gmail.com>
Subject: Re: [PATCH] overflow: optimize struct_size() calculation
To: David Laight <David.Laight@aculab.com>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue. 10 Sept. 2024 at 01:19, David Laight <David.Laight@aculab.com> wrot=
e:
> From: Vincent Mailhol
> > Sent: 09 September 2024 12:52
> >
> > If the offsetof() of a given flexible array member (fam) is smaller
> > than the sizeof() of the containing struct, then the struct_size()
> > macro reports a size which is too big.
> >
> > This occurs when the two conditions below are met:
> >
> >   - there are padding bytes after the penultimate member (the member
> >     preceding the fam)
> >   - the alignment of the fam is less than the penultimate member's
> >     alignment
> >
> > In that case, the fam overlaps with the padding bytes of the
> > penultimate member. This behaviour is not captured in the current
> > struct_size() macro, potentially resulting in an overestimated size.
> >
> > Below example illustrates the issue:
> >
> >   struct s {
> >       u64 foo;
> >       u32 count;
> >       u8 fam[] __counted_by(count);
> >   };
> >
> > Assuming a 64 bits architecture:
> >
> >   - there are 4 bytes of padding after s.count (the penultimate
> >     member)
> >   - sizeof(struct s) is 16 bytes
> >   - the offset of s.fam is 12 bytes
> >   - the alignment of s.fam is 1 byte
> >
> > The sizes are as below:
> >
> >    s.count    current struct_size()   actual size
> >   ---------------------------------------------------------------------=
--
> >    0          16                      16
> >    1          17                      16
> >    2          18                      16
> >    3          19                      16
> >    4          20                      16
> >    5          21                      17
> >    .          .                       .
> >    .          .                       .
> >    .          .                       .
> >    n          sizeof(struct s) + n    max(sizeof(struct s),
> >                                           offsetof(struct s, fam) + n)
>
> I actually suspect that it matters so infrequently it isn't worth the eff=
ort.
> Not only do you need a structure with 'tail padding'

There are a significant number of these. For example, this:

  $ git grep -E "(u8|char).*\[\] __counted_by.*;"

lists a couple dozen cases (a few of which are false positives, but
you get the idea). And that simple grep did not catch the full list
for sure.

Yes, it is not thousands, but in my view this isn't something I will
qualify as infrequent either.

> but you also need
> the size to go from one kmalloc() bucket to another.

I think that kmalloc() is only one example. Here, we can also
consider, for example, the memset() or the memcpy() operations.

This patch is not meant to revolutionise things for sure. It is more
of a "save the bytes" thing. Is it worth the effort? I would still say
yes (else I wouldn't have sent the patch), and now that this effort is
done, it is up to you guys.

> >
> > Change struct_size() from this pseudo code logic:
> >
> >   sizeof(struct s) + sizeof(*s.fam) * s.count
> >
> > to that pseudo code logic:
> >
> >   max(sizeof(struct s), offsetof(struct s, fam) + sizeof(*s.fam) * s.co=
unt)
> >
> > Here, the lowercase max*() macros can cause struct_size() to return a
> > non constant integer expression which would break the DEFINE_FLEX()
> > macro by making it declare a variable length array. Because of that,
> > use the unsafe MAX() macro only if the expression is constant and use
> > the safer max_t() otherwise.
> >
> > Reference: ISO/IEC 9899:2018 =C2=A76.7.2.1 "Structure and union specifi=
ers" =C2=B618
> >
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> >
> > I also tried to think of whether the current struct_size() macro could
> > be a security issue.
> >
> > The only example I can think of is if someone manually allocates the
> > exact size but then use the current struct_size() macro.
> >
> > For example (reusing the struct s from above):
> >
> >   u32 count =3D 5;
> >   struct s *s =3D kalloc(offsetof(typeof(*s), fam) + count);
> >   s->count =3D count;
> >   memset(s, 0, struct_size(s, fam, count)); /* 4 bytes buffer overflow =
*/
> >
> > If we have concerns that above pattern may actually exist, then this
> > patch should also go to stable. I personally think that the above is a
> > bit convoluted and, as such, I only suggest this patch to go to next.
> > ---
> >  include/linux/overflow.h | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > index 0c7e3dcfe867..1384887f3684 100644
> > --- a/include/linux/overflow.h
> > +++ b/include/linux/overflow.h
> > @@ -5,6 +5,7 @@
> >  #include <linux/compiler.h>
> >  #include <linux/limits.h>
> >  #include <linux/const.h>
> > +#include <linux/minmax.h>
> >
> >  /*
> >   * We need to compute the minimum and maximum values representable in =
a given
> > @@ -369,8 +370,12 @@ static inline size_t __must_check size_sub(size_t =
minuend, size_t subtrahend)
> >   */
> >  #define struct_size(p, member, count)                                 =
       \
> >       __builtin_choose_expr(__is_constexpr(count),                    \
> > -             sizeof(*(p)) + flex_array_size(p, member, count),       \
> > -             size_add(sizeof(*(p)), flex_array_size(p, member, count))=
)
> > +             MAX(sizeof(*(p)),                                       \
> > +                 offsetof(typeof(*(p)), member) +                    \
> > +                     flex_array_size(p, member, count)),             \
> > +             max_t(size_t, sizeof(*(p)),                             \
> > +                   size_add(offsetof(typeof(*(p)), member),          \
> > +                            flex_array_size(p, member, count))))
>
> I don't think you need max_t() here, a plain max() should suffice.

Ack. I will send a v2 with max() instead of max_t().


Yours sincerely,
Vincent Mailhol
