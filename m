Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CE244E64A
	for <linux-hardening@vger.kernel.org>; Thu,  1 Oct 2026 21:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889912; cv=none; b=lVhVdR/+Hx4pwnDwcohXSnLb8mUfIJApoVbI4IPm/XEes52eEtlqNyIvm0bkt1CPxQ/B7qfSOrnje4vjzOfAvAxVAq4MjrbaaoOfxPoPRMBcofsUERKShdzeKiCSSiByHt5kVG9UdazAfKrDfQAUVDiyFFS9bT2mZZ1rmDfjNME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889912; c=relaxed/simple;
	bh=H56gwjziJywH3m5Bz2P+G9ZTWG7bfHpXRO40aJaL4hA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqhC8EE6fIm2Sj7PTGvnFPm4pwahPWvUsaBD+bCcUqVScrbZCOep6dMi0kf7c7VLdmph0n/MNYeYrG3UxfXMvRkeLYkxWb3ZFaIe5PuMkcu/CY5TXsVJahnSQ2tU9YFcWcJSbb4NDn3l95zMr2flu6v6/j6+xokGhKLmauJZEbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSR6adbr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSR6adbr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898F51F00898
	for <linux-hardening@vger.kernel.org>; Thu,  1 Oct 2026 21:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790889910;
	bh=Tvs6fkP3/Le/Tutf9udarKKG9JiN4dlqSpw4nvMlQag=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JSR6adbr+/D+zLJm/9W+9CMYKU6h73aJ5gKupkKP9hpTDpJD6RsQKbYMmu9euWDGJ
	 h15Sa90syJKnJwFC5PAemEmtRcuIHbVUEUFb7DqnitfRmAFm5WiTzH2tygsnFcWURR
	 esinUCy9eT24BclYaO9HOVjvmBc+ifETiwk+LEumVDifx9mh8ECOJriOs5wNzLhObq
	 uXpMcZ9YEboKTbijNPZDdmjZxHScAizu4O66PsDW+irDMf2p/MIJ39Y6hGYqTG6TZU
	 Z1/JX4EK5Z8hxWKWWbmVmO/1DshMw199ZMxnqPw9C9x99Vp0o7nu7kHdxDRt01e2WZ
	 4KEd5PQbqMyfQ==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba3feee1d2so1967799e87.2
        for <linux-hardening@vger.kernel.org>; Thu, 01 Oct 2026 14:25:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwTIj4rxovAw/2oWcDPob7+rYdxjl+v+a30Nam4FjJ0+LrIakwM7AoGdXz8EK4bYoATiPy83mUqLA5yTuQQMZM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQ+XzEr/VXeoY1oEsFHmfX3htZRx+iFAQOGWyvlOvKu6cZ4Tm7
	pHEgQsL270nrV4ZdzxlAW8U2DhzCGYM5/6m1pf3JP5DJmk0Mf/ysUyJ0s/5heI8+RoU8LiEXfyN
	O0VOo88bcaRDWOqew+l+QnCkhaiZHEu8=
X-Received: by 2002:ac2:4898:0:b0:5b6:4ad:77b3 with SMTP id
 2adb3069b0e04-5bb9bb0c0d4mr124079e87.27.1790889909323; Thu, 01 Oct 2026
 14:25:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928063824.1386524-1-morbo@google.com> <CAGG=3QWCmQ+LVvn2dtjEauj5WFwvx=pvg4Q6man_A2imdjRe7A@mail.gmail.com>
 <CAD++jLk2pFCpbpGVCQg2AdrwQecpb=wsehhwSuwTbKAXNeyfoQ@mail.gmail.com> <CAGG=3QV2k-nsZHNSuKEixZb+-LcxvhQsG379ghgyOpiDLTJWzw@mail.gmail.com>
In-Reply-To: <CAGG=3QV2k-nsZHNSuKEixZb+-LcxvhQsG379ghgyOpiDLTJWzw@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 1 Oct 2026 23:24:56 +0200
X-Gmail-Original-Message-ID: <CAD++jLnOm3ua7hom_L4YQwN5z81M17WmL_VGqx+-ugrAJ-6_Dg@mail.gmail.com>
X-Gm-Features: AclHuK_3CuY_lvP3v92lNOvBLIMvkbfO2hErlC_rqJvappsJIFQnzmPZMMVY-s8
Message-ID: <CAD++jLnOm3ua7hom_L4YQwN5z81M17WmL_VGqx+-ugrAJ-6_Dg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: annotate struct acpi_gpio_mapping with __counted_by_ptr
To: Bill Wendling <morbo@google.com>, Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 10:05=E2=80=AFPM Bill Wendling <morbo@google.com> wr=
ote:
> On Thu, Oct 1, 2026 at 12:56=E2=80=AFPM Linus Walleij <linusw@kernel.org>=
 wrote:
> > On Mon, Sep 28, 2026 at 9:22=E2=80=AFAM Bill Wendling <morbo@google.com=
> wrote:
> > > On Sun, Sep 27, 2026 at 11:38=E2=80=AFPM Bill Wendling <morbo@google.=
com> wrote:
> > > >
> > > > The 'data' pointer field in 'struct acpi_gpio_mapping' is associate=
d
> > > > with the 'size' field, which represents the number of elements of
> > > > type 'struct acpi_gpio_params' allocated for 'data'.
> > > >
> > > > To improve bounds checking via CONFIG_UBSAN_BOUNDS and
> > > > CONFIG_FORTIFY_SOURCE, annotate 'data' with the __counted_by_ptr
> > > > attribute.
> > > >
> > > > Analysis of allocation, assignment, and access points shows that th=
e
> > > > pointer is never accessed before the count is set, which guarantees=
 that
> > > > this annotation is safe and will not cause runtime panics or
> > > > false-positive bounds checks.
> > > >
> > > > Cc: codemender-patching+linux@google.com
> > > > Assisted-by: LLM
> > > > Signed-off-by: Bill Wendling <morbo@google.com>
> > > > ---
> > > >  include/linux/gpio/consumer.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/con=
sumer.h
> > > > index fceeefd5f893..2b80cf7aa7e7 100644
> > > > --- a/include/linux/gpio/consumer.h
> > > > +++ b/include/linux/gpio/consumer.h
> > > > @@ -667,7 +667,7 @@ struct acpi_gpio_params {
> > > >
> > > >  struct acpi_gpio_mapping {
> > > >         const char *name;
> > > > -       const struct acpi_gpio_params *data;
> > > > +       const struct acpi_gpio_params *data __counted_by_ptr(size);
> > > >         unsigned int size;
> > > >
> > > >  /* Ignore IoRestriction field */
> > >
> > > There's a problem with 'drivers/firmware/efi/libstub/Makefile'. Clang
> > > needs a compiler flag to support the "__counted_by_ptr" attribute
> > > referencing a field *after* the pointer, like in this patch. However,
> > > the Makefile blasts the flag away for x86 platforms. Below is a hack
> > > that copies the part of the top-level Makefile that adds the flag. I
> > > don't think that's a good solution. The comment in the driver's
> > > Makefile says that the stub code executes before the kernel does,
> > > which I assume is why a lot of the flags are blown away... In any
> > > event, I'm not sure how best to address this.
> >
> > But is this a problem with the current patch?
> >
> > Does libefistub use <linux/gpio/consumer.h> in any way, shape
> > or form?
> >
> It's being #included transitively:
>
> In file included from drivers/firmware/efi/libstub/efi-stub-helper.c:12:
> In file included from ./include/linux/efi.h:20:
> In file included from ./include/linux/rtc.h:18:
> In file included from ./include/linux/nvmem-provider.h:16:
> ./include/linux/gpio/consumer.h:670:55: error: use of undeclared
> identifier 'size'; did you
>       mean 'ksize'?
>   670 |         const struct acpi_gpio_params *data __counted_by_ptr(size=
);
>       |                                                              ^~~~
>       |                                                              ksiz=
e
> ././include/linux/compiler_types.h:392:64: note: expanded from macro
> '__counted_by_ptr'
>   392 | #define __counted_by_ptr(member)
> __attribute__((__counted_by__(member)))
>       |
>        ^~~~~~
> ./include/linux/slab.h:602:8: note: 'ksize' declared here
>   602 | size_t ksize(const void *objp);
>       |        ^

Hm I see.

Certainly Jeremy or Ard will have an idea about how to solve this,
so paging them in.

Yours,
Linus Walleij
