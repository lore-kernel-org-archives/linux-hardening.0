Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EA335950
	for <linux-hardening@vger.kernel.org>; Thu,  1 Oct 2026 20:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790885109; cv=pass; b=CmlFXK/VWeafOFXUt/OgOBpToE0sDO9arNF1tuHc03lx/5pbc3Sm6GjdI30X2bPPyii7+MglWBBydAmVYjJr+/Q/nj5DYGfNj9xTRyIeA1NDfSVumgihrIOOHNv/D4uGF/nYAURm4AtU5ssKwiGXH6Bwb65H+/8xyf/7mCdS2dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790885109; c=relaxed/simple;
	bh=D5b2njgM22Yn9YX8W7fqgN5Wxt0Lao05fQOXJfkjPyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isMTrZxGOfA0JktRYwWAozNnpLu2PXTh6P6gOviKGuhEy+P8PlHHL5kNSTkCAs8+vPcqyxMkwevg2u4amBWz6W2U5jDiN87jycRUbG/e1DWjfzVlGTlWIs6aOgv7WVHvWZbxeac5QDljOum40pO8nzSdUYezM1f1m9Flot1nfOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l3Z2gU4K; arc=pass smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l3Z2gU4K"
Received: by mail-vs2-f41.google.com with SMTP id 71dfb90a1353d-5c963a787c9so2783702e0c.2
        for <linux-hardening@vger.kernel.org>; Thu, 01 Oct 2026 13:05:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790885107; cv=none;
        d=google.com; s=arc-20260327;
        b=hV1VkeqrQk07heUJ3hyp0EodDP5qr4bbmAP3M/vV2UJI4BzvsLr9T72PIs2Tl5ZzvF
         WL6fDL4IBmjSZROsbLW+xT7ojMBjmXuhOm+E0ev07DLVLwFyu1A37ejUEy3iwADzV3cc
         5rgMcrg8/OiyWYE+ajRQPXKFKIJ5k2PBo9DrvPTOGqmfbvL7rul1LIaEviyCc8bZptCi
         /KqEBKkmHKdFEgL7Vg9uImxQTmBILTSDFsenDsDZBD851RSi3Sl1y2OXD546UvP7Z8wT
         NtMsVtMGBwX4TUmuq7gX/dnv95gz7FUEy23zzyFWacMZYD/NJEO0mbN9vDD1PGsRmulC
         Qb7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pp6TH4DCeYfMYH0YGkv0J3I5da3ZUSWKwlkhgwd0Jrw=;
        fh=CIG8DGbZAmblNUTmnfTKsadx9qxukqKDXSX4UR3b0YM=;
        b=mOmDrmrg4Vjyx9WNiszenrO/00PNeE/z6Q0f2ZbyaH3CpjWYbnDOo/gnkCpETBf9M3
         UHaB7xer+rS0VZG9UTiRRyYgWys+HwO+lfiA8ia00JaaYgsyTgd1RujRpeB2fXsMXvOR
         PgAbbkwosXhMJiICjY5JzwF71O8xZ/B3fVsk8BbpfUzOuXVZ7sS/zY0mBe2bngr0lABW
         phTnXiHI6lakT6wYLq8CzKiyM3Wv/tHdGfhpktEJ8kdgUHe9xy8slGktZntujgywdsrw
         el3DwG/IAhwFkPHFoH5WxYuH6tE5zCfTMvUq5QXdJHOctw6PKiLOSK7p43RfWFNxFuBn
         xwcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790885107; x=1791489907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pp6TH4DCeYfMYH0YGkv0J3I5da3ZUSWKwlkhgwd0Jrw=;
        b=l3Z2gU4KhQsMA9YMXinRcvYtpIzGgk14S1IBSJSBq88U6VP4ZfVP7SfjnJb5Hn8bHt
         vpFLO7zpgaG2A9PTX3UWagVDwSf1+SErtRlpB8euAO9ZwZKStPk+ZKWyTRqG7ZWIvDO9
         4LXgoJX8+tmkJtycYfGzSfgilHCoQFe0+VI2J2QsunWjNpU4CxFL4wtH+gD6hmjavlVR
         1mwGzZki5ISbcCTB30CxtMfxZiko8bLZo2MpFAQEobUxVt3d0kno5VXzh6Nec3uclkWz
         OiVK7oTvDOrKUGzJL/RWni7KQtAZZe/+ERoQG5CcxyNOZ9enG5HTGFytiGfY3NIJ/KF2
         FA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790885107; x=1791489907;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pp6TH4DCeYfMYH0YGkv0J3I5da3ZUSWKwlkhgwd0Jrw=;
        b=FOq7oQgvrkyyE+819MTNt0HUTnK6uq9EXC7ol0g/T/NxFfVmP2ygXm4cBy3WncviNs
         pIz9m7inLrJ8TcnH7Knz851Ub5AbMp+NZL/pgOQ/At/Q5TSGllq+sKvCm/pFj9UVPNRv
         vw+DHXdHGZ0Pa6o1422sncr/NAeZ40My+EvOXopa9SPkdbSKfavRaXc+xAGLgTOeka4p
         ERr/tRhlE27dcFLTP2s+rQiQ96ohuAIV3f11llhEXs2M8x8G0OA+UYaF6Nc3kh9wYNag
         8AG3NJkdcudPvFTO2aRDWFBi67YDdr+yHUEGOdZwZoKNgDCm7o4Q36ubZBUJao6ZZ7An
         kX5w==
X-Forwarded-Encrypted: i=1; AKwUvBw6roc27ojIqewjmJIygZb0gjZR2Crri1S2xTVbnbplSdcq650hqmlFQgOIIz79okFwVrI3JOM6ZIlKBqWAYXg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLXvsYfzxTJWjrNWpe0Aj8UOPf2k+sQewMjcqcHHEPwdZBARYD/
	YpW2Y/mGMFJL7nCw2s11K04gUPpg9FiGMP9wGSHKHS7H1Ok68m8NFMsjz11YGbhXue/XAeA9nC+
	DA6CiBvV6KLmOdYimRvU9tqNnb+CHqelTKGlJJP8=
X-Gm-Gg: AYBFou3QNlzkt4zV2J8nbkiugsywo/Gd4uKGDvMNw0ZfOaq+PFETBOl1ghP7XSfjPaK
	tAI+NCMg8BszxFWiSftvhqAJ8N0ie/J+NQD7PZLk2M4lP7pDCuySn8dTbzLKKuQAfqBfWuX+3TY
	LtsKPapmKVS046i6dYnPo6CePSK6Wm6dI09BOjHB+c5CNjYSuxYJxh/oHA4fwHOARCrsCVind88
	fkUpaLSC9T80nxAv+Fcu1PCqVrJIWfaQoGaVAa4qzGdM/hlxK99s1thmsbnfmgkUxlZx1yfSSnV
	aJ1aY3LDSrwfIvDQUILaYBXZfE8tKj1dWk9rrUMhEFdX71bRbo0TiY9x0adlfsf1h7j4Wdsm4GY
	JMqNWsUWByzjlP22IuZaH
X-Received: by 2002:a05:6102:162c:b0:7a8:6ffc:1c25 with SMTP id
 ada2fe7eead31-7c0f48951dcmr137774137.18.1790885104867; Thu, 01 Oct 2026
 13:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928063824.1386524-1-morbo@google.com> <CAGG=3QWCmQ+LVvn2dtjEauj5WFwvx=pvg4Q6man_A2imdjRe7A@mail.gmail.com>
 <CAD++jLk2pFCpbpGVCQg2AdrwQecpb=wsehhwSuwTbKAXNeyfoQ@mail.gmail.com>
In-Reply-To: <CAD++jLk2pFCpbpGVCQg2AdrwQecpb=wsehhwSuwTbKAXNeyfoQ@mail.gmail.com>
From: Bill Wendling <morbo@google.com>
Date: Thu, 1 Oct 2026 13:04:47 -0700
X-Gm-Features: AclHuK_OsmZsgIWlUXnGIOeGgxR5RkcvYLN5aGCG1e6Tds9_TT0UwWgbTocjZcw
Message-ID: <CAGG=3QV2k-nsZHNSuKEixZb+-LcxvhQsG379ghgyOpiDLTJWzw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: annotate struct acpi_gpio_mapping with __counted_by_ptr
To: Linus Walleij <linusw@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 12:56=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:
> On Mon, Sep 28, 2026 at 9:22=E2=80=AFAM Bill Wendling <morbo@google.com> =
wrote:
> > On Sun, Sep 27, 2026 at 11:38=E2=80=AFPM Bill Wendling <morbo@google.co=
m> wrote:
> > >
> > > The 'data' pointer field in 'struct acpi_gpio_mapping' is associated
> > > with the 'size' field, which represents the number of elements of
> > > type 'struct acpi_gpio_params' allocated for 'data'.
> > >
> > > To improve bounds checking via CONFIG_UBSAN_BOUNDS and
> > > CONFIG_FORTIFY_SOURCE, annotate 'data' with the __counted_by_ptr
> > > attribute.
> > >
> > > Analysis of allocation, assignment, and access points shows that the
> > > pointer is never accessed before the count is set, which guarantees t=
hat
> > > this annotation is safe and will not cause runtime panics or
> > > false-positive bounds checks.
> > >
> > > Cc: codemender-patching+linux@google.com
> > > Assisted-by: LLM
> > > Signed-off-by: Bill Wendling <morbo@google.com>
> > > ---
> > >  include/linux/gpio/consumer.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consu=
mer.h
> > > index fceeefd5f893..2b80cf7aa7e7 100644
> > > --- a/include/linux/gpio/consumer.h
> > > +++ b/include/linux/gpio/consumer.h
> > > @@ -667,7 +667,7 @@ struct acpi_gpio_params {
> > >
> > >  struct acpi_gpio_mapping {
> > >         const char *name;
> > > -       const struct acpi_gpio_params *data;
> > > +       const struct acpi_gpio_params *data __counted_by_ptr(size);
> > >         unsigned int size;
> > >
> > >  /* Ignore IoRestriction field */
> >
> > There's a problem with 'drivers/firmware/efi/libstub/Makefile'. Clang
> > needs a compiler flag to support the "__counted_by_ptr" attribute
> > referencing a field *after* the pointer, like in this patch. However,
> > the Makefile blasts the flag away for x86 platforms. Below is a hack
> > that copies the part of the top-level Makefile that adds the flag. I
> > don't think that's a good solution. The comment in the driver's
> > Makefile says that the stub code executes before the kernel does,
> > which I assume is why a lot of the flags are blown away... In any
> > event, I'm not sure how best to address this.
>
> But is this a problem with the current patch?
>
> Does libefistub use <linux/gpio/consumer.h> in any way, shape
> or form?
>
It's being #included transitively:

In file included from drivers/firmware/efi/libstub/efi-stub-helper.c:12:
In file included from ./include/linux/efi.h:20:
In file included from ./include/linux/rtc.h:18:
In file included from ./include/linux/nvmem-provider.h:16:
./include/linux/gpio/consumer.h:670:55: error: use of undeclared
identifier 'size'; did you
      mean 'ksize'?
  670 |         const struct acpi_gpio_params *data __counted_by_ptr(size);
      |                                                              ^~~~
      |                                                              ksize
././include/linux/compiler_types.h:392:64: note: expanded from macro
'__counted_by_ptr'
  392 | #define __counted_by_ptr(member)
__attribute__((__counted_by__(member)))
      |
       ^~~~~~
./include/linux/slab.h:602:8: note: 'ksize' declared here
  602 | size_t ksize(const void *objp);
      |        ^

> Yours,
> Linus Walleij
