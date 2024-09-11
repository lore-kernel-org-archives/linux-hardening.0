Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46198F6C;
	Wed, 11 Sep 2024 04:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726029964; cv=none; b=BOd3JrgBAtwsXDroSTbopCNEKvR4U44iYrnGzDqGsPys7bZSPEq0YH4yoUQ3JH7KTp4SgAjTfaR1Q3MBrrD/B+TZDR24/E11huvrRDRgPe06vhnWHkmF0QfvBhkaOAElukMiLpOttsG37uAqTTCm8t0JxF6axhybPtFgp7k7hi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726029964; c=relaxed/simple;
	bh=Lq1oXz0gkmgIU1u6krv/9+X0gSEq95JULA+kVd5E14I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHx7HX8yLQa3soIZf+1m0WvfWeC1oAtnbBlnTEmZn7/zb4GFtkjNAOEIsmpySagluBAe48VfbHvGmEcTAKcOQ4iK2MyDufS95XnbFhfiUE0MXOELh2S5qTEYvdIjzaffl654RnJEGY99kx7XCFHNWD2DbpohFdedfG5IgLfNdRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7c3ebba7fbbso5297776a12.1;
        Tue, 10 Sep 2024 21:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726029962; x=1726634762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUz8ozbOx96dq0NpB/mix4VjJOdTobXha/wl0Htocfk=;
        b=XKRz0IdDEuPNCmQp8QNQiwv/zUs95YJ/6QTzLb4CgkiWqlJwhdS90pzEkPSM40lHmR
         h3gmPKC1qU9C0Jg9MdOlux0QMTIZxOmbxxBvnxb/lGJVZ2Kko7VF9fCpkiST1nxmIJxK
         boRpaP6I5Ri3JRYP4khA/o/DSLF3zRCLjxjOJWw+hoLgNoOjiO7uorK/AM5TB0N92hXo
         6AnXALOwHPo/c4DoEVj+va87rDTkd4f2Dk9PhX5xyMFKcHNiKOIWkbNmhtjSriNM0DhK
         2CGVinllzpC/cl7G5i65h+VAeJ8m5J1hGSkeFV5lA6Q0oK6kukZ7O4HAggiAdya4VKI9
         dD+w==
X-Forwarded-Encrypted: i=1; AJvYcCUhMXUm+DKl/pHKp8JVYpr2rg4QCBaa7pjchrdajIs1DJcLkUBFFTh2lnp9UEGKRGa+LbaA9I/ppXs0Sk63@vger.kernel.org, AJvYcCUuYKY8/uRzJYAYfddwU8qq39l1EoCJP8cRC8bbXyhDsPT2S36qhEPsjA4i01qfjG+G96r8dn9V0fXvryGfYy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3mdGZU3QM1KhXTub/lGt+Jgw/pr3zobwjz8cpO3iMnkYejWFX
	3Oa4S/iY+aMjRI0kVwp7wCGKKx04bc4jJapLthYeJCs+aqnx59dwAxz+hy1VGz0aONPn++CpxKB
	mrxNPtmaKVeT+qJIBGrOJUZn6RuVgBQbC
X-Google-Smtp-Source: AGHT+IHQsP68oyoc64PQVzm920uafjXEnHkFGRdl+sDX53OEec/wkjt5bPatoI2rtQXfUx+AmXmZwIPMLF9MLe86q/4=
X-Received: by 2002:a17:902:d4c2:b0:207:1828:3570 with SMTP id
 d9443c01a7336-2074c379fe2mr39716155ad.0.1726029961878; Tue, 10 Sep 2024
 21:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910024952.1590207-1-mailhol.vincent@wanadoo.fr> <202409101729.C242EEC@keescook>
In-Reply-To: <202409101729.C242EEC@keescook>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Wed, 11 Sep 2024 13:45:50 +0900
Message-ID: <CAMZ6RqJ1N9E=yqJLcreVsqk5xtoHWQghBaezB+=TzjC3ChxxGA@mail.gmail.com>
Subject: Re: [PATCH v2] overflow: optimize struct_size() calculation
To: Kees Cook <kees@kernel.org>
Cc: David Laight <David.Laight@aculab.com>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed. 11 Sep. 2024 at 09:36, Kees Cook <kees@kernel.org> wrote:
> On Tue, Sep 10, 2024 at 11:49:52AM +0900, Vincent Mailhol wrote:
> > If the offsetof() of a given flexible array member (fam) is smaller
> > than the sizeof() of the containing struct, then the struct_size()
> > macro reports a size which is too big.
> >
> > This occurs when the two conditions below are met:
> >
> >   - there are padding bytes after the penultimate member (the member
> >     preceding the fam)
> >   - the alignment of the fam is less than or equal to the penultimate
> >     member's alignment
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
> > the safer max() otherwise.
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
>
> Yeah, this "over-estimation" has come up before, and my thinking as been
> that while the above situation is certainly possible (but unlikely),
> I've worried that the reverse situation (after this patch) is
> potentially worse, where we allocate very precisely, but then manually
> index too far:
>
>         struct s *s =3D kmalloc(struct_size(s, fam, count), gfp);
>         typeof(*s->fam) *element;
>         element =3D (void *)s + sizeof(*s);
>         for (i =3D 0; i < count; i++)
>                 element[i] =3D ...;

To me, this pointer arithmetic is just a bug. Anyone in his right mind
would write:

        typeof(*s->fam) *element =3D s->fam;

When I compare your example to my example, I think that both are
convoluted and unrealistic but with the *huge* difference that:

 - in my example, the code logic is correct and the thing breaks
   because of the current overestimation in struct_size(). See the
   clang documentation:

      https://clang.llvm.org/docs/AttributeReference.html#counted-by

    The clang guys are using the same calculation as in my patch. So I
    can think of a world in which someone with good intent would copy
    this example, and then (for example because of a collaborative
    work), someone else would use the struct_size() to do a copy or a
    memset resulting in an out of bound as illustrated  in my example.

 - in your example, the code is incorrect. If we start to apply that
   "what if users do random pointer arithmetic" reasoning, then
   anything can be proven to be a security risk.

To repeat, I think that my example was convoluted, but I see yours as
even more convoluted.

So, with this said, what do you think is the good trade-off? Return
the exact size so that code with correct logic works as intended or
keep the extra bytes in case someone does some crazy pointer
arithmetic?

> And for a max 7 byte savings, I'm concerned we can get bit much worse in
> the above situation. It *should* be unlikely, but I've especially seen a
> lot of manually calculated games especially for structs that have
> effectively multiple trailing flexible arrays (wifi likes to do this,
> for example).

How does a struct with "multiple trailing flexible arrays" look like? By
the C standard, structures can only have one single fam, so this isn't
something I am aware of.

Would the struct_size() macro still be relevant for those "multiple
fam" structures or would the structure size also be hand calculated?
Isn't this argument out of scope of this patch discussion?

> So while I don't have very concrete evidence, my sensation is that we're
> in a more defensive position leaving it over-estimated.

So far, I think that my example is more concrete than your pointer
arithmetic argument. Not by a lot, and this is why I just put that
security argument at the end after the --- cutter.


Yours sincerely,
Vincent Mailhol
