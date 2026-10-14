Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F783FD955
	for <linux-hardening@vger.kernel.org>; Wed, 14 Oct 2026 20:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792010363; cv=pass; b=ecT5UJj9n1DEVJRZE73cBgKv1yHfsm3dviBcZRlVrE1W62txYqifSTECwVug9bUJ3sn7eRU3DNXC1aOPVtFS7fTw3LgIFBU8FwMEfOY2HlrJEHfNwo+V+1oBHcDCf+lw9QuxvicqaWEJ7z/nWm9eCFTZSEw/jM01XUzPBNrQ4aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792010363; c=relaxed/simple;
	bh=OdczzjFOe89H4x/GfebUN+5WbU+DhmRpAufDeoSczO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVojw4QKIetz1pGK3cplnytPKIXZHC6hbTVIWv//pwb/o1bfLyLBtseKU/m4IlVpLbdk0BHaltGa5ksxXn8aI5B15z+5qMf2f66j2uxShUYYJfxl6lJ0vhbJCxTHHSvLPyJI7xuVzE25XUyev+ml9GOz1XOEbc3ryf1wUCMlYB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h50qG51d; arc=pass smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h50qG51d"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5e9405fbc33so1960536e0c.3
        for <linux-hardening@vger.kernel.org>; Wed, 14 Oct 2026 13:39:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792010361; cv=none;
        d=google.com; s=arc-20260327;
        b=BGUi6hwBUyugUA7OSIfP78SFG4Ycj4Eg+OFfiqUG0+kX4LDmAekRNXwrYE694Jwbj/
         KTyVXlK87sA69Zwzk/B62turvhRV3kMahfzbTdxMXky2omCpxPzGqzefHgk20XwhjCnl
         t5DAV4VIpjBugSQ0nYs+g7/a39nJKs3+jnHEzBbyFiFoCGjGnf2F+LsJsmujcE8wqcPe
         eh8j7n5DTKPSu8KsL6ulod1u3XVKI0JF2Wf+DCp4mFhqG0X5BsHB7KipCWjAIkSI+ggG
         a5pTxR7/CMwd3cPgtGe3cebcDDyOMruvVuEDd8D+GDjl+THWoll6o8LDmmYyVd7yZc5F
         n34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d3BK1k/iiQA4DbuDBW/0r/+HhOk81y4XWGTKDWVnqAs=;
        fh=Pdc585FQvjpDu932eTF6CfxLm1x+wGFj7q8LsGYPpF0=;
        b=WVCeeuA6VwS6HmmADK3HzsfzbysDpgCrpwvRKFbFEFZxS/imBhdvFUV0sVu/ZDSyn+
         q/rbXrt7igheC4bR1VmSGWNeIcoCY8IT7amLQl2Le/yEsEw0BXClqNkq1dV1LtowC1hY
         JHKRtM0SJR1Ubt73tsgQh5TFj1/lcyCLA7/lDBnN9eq1zHC8vJ5lwdJdbJBs/bLYcvBo
         l+gits7qn5PWFPQHWDXCX+D+EhtA/nYhakErUVB46OOUvHIE2DSwxEyA3Z85Jxw0ko5o
         0ZtyIrRQHA6QJpWejpepCLPffYJp4xLZTScrNf6xVFhvcRSUI0zWdaF5F8rckpQOsmf8
         FXyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792010361; x=1792615161; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d3BK1k/iiQA4DbuDBW/0r/+HhOk81y4XWGTKDWVnqAs=;
        b=h50qG51dOshgVXqbWhB8nK8ekNyDXnYwAfHJILpcBI++QQ2DcstMYvfyOTlJthzrNV
         fq1frc9/0MiCTt6WJ3n3AlUVM75eOJipjiGBGy4j8l3qtYhZDLveQ+AJXWw8JhP2Q1fB
         xMfnkxu+VwruIqO3I/J6B6nWV8B1e7EA6a/0QgAvzQXNfhM7bdFJvwrrp4ctnmiaif5m
         EBfskzgjsPWRn4iAGYizGqikxBPiyRGKTi82yizJlLKbN1lKzmlbjjiowFDNqFwAyss7
         sI6irjp+th0Hcqo8T6BtgAMW7OBVdwYXcDvX5NmmWQjQXceyAxHdSNL5hkMgY/fVhVE/
         pxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792010361; x=1792615161;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d3BK1k/iiQA4DbuDBW/0r/+HhOk81y4XWGTKDWVnqAs=;
        b=dt+LSuYfE/AwpUU9YnUnr76cRo3njrqQrSsa3AzCasblhldY4pJP6E5q4Rihn2aCd1
         COQ04FinCgVrumpO3T/u7j6OFKzxVq4YCSWGCvNpktzX5CDsL1TSjp5iz6PuL1GP5HQc
         BiQ7zVqwYGCUkhbpASYy5f+1+qKC0l9OmbnfH7MKvEdNVjOogsSZaKIb7B2hH/uAirSG
         kOuCKb0aE2rPId9jy2fOK6dXwQ8HaniL0BkwKTuw0gr/91leK4quOFgGTZIWnl/p97Xg
         jHzgxnfIHp0SSfZB6xBbhh5AEe7FxEnW8+tBfcdHHqOLmp3ftFm/lziB/2y48E7lfbfl
         ML0g==
X-Forwarded-Encrypted: i=1; AKwUvBwc6KnWk+mqXeEjeHJ7DbXRdd/MfiKP2/QaXfB0UH6nWMIbZ+V3FgNr9LOPZogjujY67pacop02vqROaojCO8U=@vger.kernel.org
X-Gm-Message-State: AFq9FYIw2nrQ41EVHflfuAgidWfU+zLY65W/vefsbxul64RcVpNbijEM
	AUzPE/5NVJ7DzMeCC5N1yexD3aP5LX1785fl3hJMuQuv0p6ric2/uNQ3kbZkd03eqFTLJEiUPdC
	NfD4iRSVmBOBCHczXEWrDpJ8zKUHvnCD+zThocBg=
X-Gm-Gg: AYBFou3qAcdozKFEHqEo9WgrzSjnoID0AJVCuixcZC2PMMyuTxqYDIrzlEEwUAGObrg
	X17n/sDszrV45MA2qtVIx6IFjUz6g9614oA3uo0IfvOVW5GZYNZ/oRTU2x6UHTDrjvjLv9iq+27
	fZ8uS2PY0+xWCWyQ9nacmnJ2p9Be3rhcOtNtd5f0PHqVN5jVo5py50RoW8ZDLWhA/J9EHypLugy
	Yc/CMF00vE/L3bvy8QITzz9tJwLbRpnDzFcArN2ONUkXQzgbewnVum1Xq4wVkB1rzPJEaLxpzn0
	YQw50GTKfRLi9l5oetmkWeiQ5F2RXLOdU5Ny3OCWd9ONw5kjxuZQ2+9umPr2271SlSeq91nhCxn
	Caiw00/LZ1XfWpx7W4L+fl7kKIl0vbaU=
X-Received: by 2002:a05:6102:3714:b0:7a7:ce1f:6b95 with SMTP id
 ada2fe7eead31-7cb36985e42mr4674417137.2.1792010360607; Wed, 14 Oct 2026
 13:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012205919.4012405-1-morbo@google.com> <20261013203146.387344-1-morbo@google.com>
 <20261014133805.47afdb0b@pumpkin>
In-Reply-To: <20261014133805.47afdb0b@pumpkin>
From: Bill Wendling <morbo@google.com>
Date: Wed, 14 Oct 2026 13:39:03 -0700
X-Gm-Features: AclHuK9khqKvMR9m63eVs2GpX7B7OIhzyYA7Leck7nyOJHPtO4-FU7QtoZGX_3s
Message-ID: <CAGG=3QUZna+bi-_nmJh-1aWBBtuURbexQczXCNt0R+jDSb1NMQ@mail.gmail.com>
Subject: Re: [PATCH v2] overflow: Match arithmetic in both parts of __builtin_choose_expr
To: David Laight <david.laight.linux@gmail.com>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 5:38=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
> On Tue, 13 Oct 2026 20:31:46 +0000
> Bill Wendling <morbo@google.com> wrote:
>
> > The two parts of '__builtin_choose_expr()' had different arithmetic
> > expressions. This patch corrects it so that both parts calculate:
> >
> >   COUNT * sizeof(*MEMBER) + __must_be_array(MEMBER)
> >
> > In practice, '__must_be_array' is meant to assert if 'MEMBER' isn't an
> > array and return '0' otherwise. However, symmetry is less prone to
> > subtle errors (and far more satisfying).
> >
> > Signed-off-by: Bill Wendling <morbo@google.com>
> > ---
> > v2: Don't use 'size_add', which just adds more complicated macro cruft =
to the
> >     expression. Instead, just adjust the parentheses.
> > ---
> >  include/linux/overflow.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > index a8cb6319b4fb..d0f04436343e 100644
> > --- a/include/linux/overflow.h
> > +++ b/include/linux/overflow.h
> > @@ -418,7 +418,7 @@ static __always_inline size_t __must_check size_sub=
(size_t minuend, size_t subtr
> >  #define flex_array_size(p, member, count)                            \
> >       __builtin_choose_expr(__is_constexpr(count),                    \
> >               (count) * sizeof(*(p)->member) + __must_be_array((p)->mem=
ber),  \
> > -             size_mul(count, sizeof(*(p)->member) + __must_be_array((p=
)->member)))
> > +             size_mul(count, sizeof(*(p)->member)) + __must_be_array((=
p)->member))
>
> Why does this use __builtin_choose_expr().
> The types of the two expressions are the same so it might as well use ?:
>
It's to emit only one of the expressions rather than both. If the
'count' is a constant expression, then it's possible for the compiler
to perform the calculation without having to hold onto the "false"
path of the ternary operator. So much more efficient in the long-run.

> Also doesn't this optimisation apply to all uses of size_mul() (aka satur=
ating_mul()).
> Presumably relying on the compiler to report the compilation time numeric=
 overflow.

I'm not familiar with saturating_mul(). I'm sure others on here can talk to=
 it.

-bw

> David
>
> >
> >  /**
> >   * struct_size() - Calculate size of structure with trailing flexible =
array.
>
