Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCF7470EA8
	for <linux-hardening@vger.kernel.org>; Thu,  1 Oct 2026 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790884601; cv=none; b=DH0yT3QZqO2xiJSCxbHNoyfbNxky7TKIOkJMmOKOoJyR3kH+zpqcXVsZrA9gi/Ay6qQl4rW617YIaJeafeH6AOmazDyDhu8gy89beap7QB3R2TuH2C2D90fPl/Piqn3Y9T9LJ9yhaVTAKfJXXuuLviMbuxI+MkhZL/cFq4XRvaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790884601; c=relaxed/simple;
	bh=+TSzO1Oud8M29DYbZ1dSt/XDqgpcjgR0kBmiqzdh85c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvyXbJGMPYKuR6dkA8uTzAgNfnXYAAJtajGmMqbgoAm1LAPdmAYwuw0HJsGd9AjIJRgCaFu4OhIoMIm5FQGGwjE9QICfBBnBf0l+PtiHZqqFao85FrT5Tn2b008E6JSrJMlh5NhjFiOIQ+xsVjtpeuJzBK3/eFnoWYktBOcrOkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSxkjuT5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSxkjuT5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05BF1F0089B
	for <linux-hardening@vger.kernel.org>; Thu,  1 Oct 2026 19:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790884600;
	bh=RqFuQUcoULCnWt4HCqIQWB5CTIYtbfgDUYFNXv+Jrkk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oSxkjuT5L9DOnhqNvik4oLZHTB8vGxF28AlivmFvCjcxelX73QhKYEs+rBxBwoifl
	 ukfCoIGMXTsKtJtdM+lFPES6brPTIOfV8BbFH21dZ0jEqcOhmMTugvKfbn4296Vt1H
	 9X4CeyHQS8+OglSREEpjXOlLqQEOsNRDIuLr8k/KN9PUPblNfaHuEAQssoGkrqmlI9
	 pCtOv3+bOtQ+Dp9eVcyz0dX//k71Q+tNWPD1odEj+lx+FwtDOPBwQaOkoIq1BfC6qf
	 l6Mrs2SONB+Zc8iUOKiWRR6YOq/6JZQrPz0TcTANR815xvwc3WN/S4o4SsboY1ibUZ
	 LenlxxYHLmhmg==
Received: by mail-lr2-f33.google.com with SMTP id 38308e7fff4ca-3a872cadb93so9791201fa.2
        for <linux-hardening@vger.kernel.org>; Thu, 01 Oct 2026 12:56:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwPor5O1ySgVBNs/ztXxmwHCyoHHZS2r9CcHFGSA7AcnGcvA59mLiEYhQdqKYYsm/ZCAwrB3o2epZOcpX37kTc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbdjHGPO2Gv3P8APC9VikYrHa0yGsjqVhbIMevsRZu4PXMqyyG
	eyow16kJd7SEEKmU7wuYx7t/anchH8L2oChdfSUAcIIFbOFeMWR0p6GacXgXamRqSvgC7N0WTEY
	Flvs55Z885OvMMEnj3loVT+pRDu6UTaY=
X-Received: by 2002:a2e:b8c3:0:b0:3a7:d217:3b22 with SMTP id
 38308e7fff4ca-3a8828d87a6mr910541fa.1.1790884598724; Thu, 01 Oct 2026
 12:56:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928063824.1386524-1-morbo@google.com> <CAGG=3QWCmQ+LVvn2dtjEauj5WFwvx=pvg4Q6man_A2imdjRe7A@mail.gmail.com>
In-Reply-To: <CAGG=3QWCmQ+LVvn2dtjEauj5WFwvx=pvg4Q6man_A2imdjRe7A@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 1 Oct 2026 21:56:25 +0200
X-Gmail-Original-Message-ID: <CAD++jLk2pFCpbpGVCQg2AdrwQecpb=wsehhwSuwTbKAXNeyfoQ@mail.gmail.com>
X-Gm-Features: AclHuK8IEImV4NsE_nvLp6iR6ObXgp229xXfDlfrNR7zmTMQOJK4axWXfRI78vU
Message-ID: <CAD++jLk2pFCpbpGVCQg2AdrwQecpb=wsehhwSuwTbKAXNeyfoQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: annotate struct acpi_gpio_mapping with __counted_by_ptr
To: Bill Wendling <morbo@google.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 9:22=E2=80=AFAM Bill Wendling <morbo@google.com> wr=
ote:
> On Sun, Sep 27, 2026 at 11:38=E2=80=AFPM Bill Wendling <morbo@google.com>=
 wrote:
> >
> > The 'data' pointer field in 'struct acpi_gpio_mapping' is associated
> > with the 'size' field, which represents the number of elements of
> > type 'struct acpi_gpio_params' allocated for 'data'.
> >
> > To improve bounds checking via CONFIG_UBSAN_BOUNDS and
> > CONFIG_FORTIFY_SOURCE, annotate 'data' with the __counted_by_ptr
> > attribute.
> >
> > Analysis of allocation, assignment, and access points shows that the
> > pointer is never accessed before the count is set, which guarantees tha=
t
> > this annotation is safe and will not cause runtime panics or
> > false-positive bounds checks.
> >
> > Cc: codemender-patching+linux@google.com
> > Assisted-by: LLM
> > Signed-off-by: Bill Wendling <morbo@google.com>
> > ---
> >  include/linux/gpio/consumer.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consume=
r.h
> > index fceeefd5f893..2b80cf7aa7e7 100644
> > --- a/include/linux/gpio/consumer.h
> > +++ b/include/linux/gpio/consumer.h
> > @@ -667,7 +667,7 @@ struct acpi_gpio_params {
> >
> >  struct acpi_gpio_mapping {
> >         const char *name;
> > -       const struct acpi_gpio_params *data;
> > +       const struct acpi_gpio_params *data __counted_by_ptr(size);
> >         unsigned int size;
> >
> >  /* Ignore IoRestriction field */
>
> There's a problem with 'drivers/firmware/efi/libstub/Makefile'. Clang
> needs a compiler flag to support the "__counted_by_ptr" attribute
> referencing a field *after* the pointer, like in this patch. However,
> the Makefile blasts the flag away for x86 platforms. Below is a hack
> that copies the part of the top-level Makefile that adds the flag. I
> don't think that's a good solution. The comment in the driver's
> Makefile says that the stub code executes before the kernel does,
> which I assume is why a lot of the flags are blown away... In any
> event, I'm not sure how best to address this.

But is this a problem with the current patch?

Does libefistub use <linux/gpio/consumer.h> in any way, shape
or form?

Yours,
Linus Walleij
