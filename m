Received: from mail-vs2-f37.google.com (mail-vs2-f37.google.com [74.125.227.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909C347ACC4
	for <linux-hardening@vger.kernel.org>; Fri,  2 Oct 2026 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945097; cv=pass; b=qrtYvqTVdOhvHaNU3VZswIcQ83pMiVKZrG0nuISMXy+rHgu8m+rrg4tVjhu5FzFsGnI0hLMUpOrL4CL39RuPVis81ZWMpjdm/tgxB9a4gYP55DpQazEbFA0VcZOBxFYd8m54IwEr/EC2FEeWw9zWkSDp5qFfEG4PZ3/jHmrK0Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945097; c=relaxed/simple;
	bh=g9QfHi8EzjRCWHnUBkrwS8yo0cu4ylZ5SZytJAxSQ9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QU62WWouGcvxaAHBaZIlQBu+WNhAyMpVdOMVtE8jhG6FSdqeI7mSbVQQURPCDiReyRPAHJLRVV+KzNSfebNN2XkYdGMvyHf4rkTNyeLjFgKqlTfLslTsFb6riKH2ud+ChLDzq8uaIwHYySjIelevoVwcgPwKT9gyttbrPZNJvI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t1/SzPtT; arc=pass smtp.client-ip=74.125.227.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t1/SzPtT"
Received: by mail-vs2-f37.google.com with SMTP id ada2fe7eead31-7ba698eb7cfso1500619137.1
        for <linux-hardening@vger.kernel.org>; Fri, 02 Oct 2026 05:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790945086; cv=none;
        d=google.com; s=arc-20260327;
        b=suAzgsQGyCpHhFaidsvlr8QxiZvrgwpinGqmcuM1EOeHSNL1L+t8o6qGGmVa002KVs
         uyVC8OAK4954kIbOagF7GwMNxcxlPqmpsdnHxGnzqqtjx14j6zf59GJ9bwh6A9ehHDqw
         zxViA3d8GIMzYAjN13ODgNu2CqGZmfO3NvDb7BKi1tqR5fIj/mlEz5hyV+T2Akr2BA3c
         SX+fSvesxVQYGM1TJxSOfLqHhBuhsHU1amd1is6BNvUjf5zSmvC/KOWcT8JV1YnvAD2d
         jlmKuIPi9AtfAKIa57H50r6Cs5tf3WO7GvMsZkmQQlvlzcRxICewBVokhXcKYQUeTxG+
         yWqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ErdmA/wWdWdz3Q1T8+D4rKzpmGRrXQnnjgGThiMrKlY=;
        fh=yKME9VNIY2n5q+Hsbk1cyAN9FGyNtrlS5NiWBPtD5Rs=;
        b=DHPkx2YMjNU6DU6dQ3l0PksvhoQvQDiJ+dmrN5P2KPFMGDOL/OE2XM3kiWNeKUGgZz
         48/xY7Mt81dowpXoYBZNiHU+p7fHp05TKc5aPqdSaq3IR1K5d2liCvyqUnpc6UcC8cGv
         QusIMaRLQfNGvRa2xv7YjI0iIH40uyEBUwKXI+pGMBId7wwbI73i9I3kJhH8agyRajv6
         AFFYyqTJxCE84nKJFgI5RZovMIOiSm841yLQ75hjYuyHiDVNHPYdFlVdAG1b0O1U1ihF
         eZEY4WiCuQlNycFUHP2oSPIc9Vdcjrwfne9uzErNvSPMvc7zoleVEIxCBFzlG3z2C6UD
         MU5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790945086; x=1791549886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ErdmA/wWdWdz3Q1T8+D4rKzpmGRrXQnnjgGThiMrKlY=;
        b=t1/SzPtTPzxep1BpfG4ZxuzMwcZhlOV8lonbOZJjpLt8BIkNabFrrClCPnLuwm9wgX
         7b/Q54+InRgujDMldIQbuRpNEDEVdVrEaIKduFeWASu+EqbCP303a5W9V/Q0FqcwVtQW
         MjpoT6nfFsYXna6FGQRm7AZgduLyS1RLFtondxXTYTiZJBIQ2efi/ngcgfyKq5gIzH0V
         f49/V/UMDn5+6u/BtcDgXrqEtYNuJZI1ANmnKd8usg8guJ9VsGjhzfGqUmnMojWYT+2i
         3r9ln59xaOjxoedKcXKTtjnRlnp5BdRkeLRKzbwaBqt+1zItyOIoTGq7JtRVel5L7fPn
         XM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790945086; x=1791549886;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ErdmA/wWdWdz3Q1T8+D4rKzpmGRrXQnnjgGThiMrKlY=;
        b=cfYC4NFfcrytP7dXUxXFYBAwKFkxvCk+GG3hcKaSnz+O3hTdO80/VGeeQu8u6VSi2Z
         7S1W9DE7DYXqEekFR9J4H9pANSzhyIvy/RvAvFWMcMdb7YYwYxs0ZLhupivmfzAoLJMB
         5GTo6ljWmwSufbTsnROe7wpMNXxuG93HnEeJ0dkHCASN/H6MCpo+rxxsBgETpVynWIEa
         FaS3IxSvCFIbQBUNlxXtSVOFDGWHkpFD/n7rfefPXPS+aIhlGIBnuUYa8RteTgRw1p01
         Pmhfpj6YkeUG54s1kfRAA/wqDXyExS//HhvN4B4aNkO4YQb5wroIsPotSnlJA/f1WCHE
         Wf9A==
X-Forwarded-Encrypted: i=1; AKwUvBwIwMxu7+IljGTwpss6DTg5uRYAz74wR26ThtggSjmB9qNSZfRRH2bUm3C0u7k8TXEUJCtU6F8+3zpcfTf79+c=@vger.kernel.org
X-Gm-Message-State: AFq9FYKO8kCbc40yPMspjBBEkjsk4WaPve0pAROZ/4zFGWn8zvmTkfQA
	yNJtoL8SE9Ff5Ob7SodQsQYwhubY1+Ci5eEjk3TlWZTRr3gqB9QA4IXs96RSYxcI7vBlyni4MCJ
	nA7p7pQ6vMWP1sJ++dWjYaVeeIdIrwJlUdMX+Gu4=
X-Gm-Gg: AYBFou2ydyTVC9dWPmkKkjShswESZgf1IF0YQuaKj3WtwCH1L6sfqMa9pVuu05E8xIX
	mQIxTJGeOyuTMkcuX5p3WysBxxHbUs/hyFzbNn9/Ur+gmJjWxM8DL5+gPPCs+eUeLmxngGGiwh/
	JBse+G24QIAs6kOwKZdPUS71yfq//5cxIvYUvYakuzgU/Ufmixy2Xt2TIndCZRQW7AA2XHjc/HT
	OEskCegP2DR+CdZuV8RakxnUWUJjGbVTQryw4u46sIpTg6FFJbPKKy0qkd7loRqPiw7ejpxjv32
	do5XfHMrBJ116HdfpvT4d+kyEEEBhxYsOjYyi5LlSRammT0zLbw/BwQPeGd01745fBl6WeDJ/I9
	cHMw5gGTUOMCrBqG35/v9
X-Received: by 2002:a05:6102:1627:b0:779:5049:87b2 with SMTP id
 ada2fe7eead31-7c0ef026e4fmr542712137.0.1790945085222; Fri, 02 Oct 2026
 05:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928063824.1386524-1-morbo@google.com> <CAGG=3QWCmQ+LVvn2dtjEauj5WFwvx=pvg4Q6man_A2imdjRe7A@mail.gmail.com>
 <CAD++jLk2pFCpbpGVCQg2AdrwQecpb=wsehhwSuwTbKAXNeyfoQ@mail.gmail.com>
 <CAGG=3QV2k-nsZHNSuKEixZb+-LcxvhQsG379ghgyOpiDLTJWzw@mail.gmail.com>
 <CAD++jLnOm3ua7hom_L4YQwN5z81M17WmL_VGqx+-ugrAJ-6_Dg@mail.gmail.com> <7e847715-6bd5-4f69-a9a6-339788810fec@app.fastmail.com>
In-Reply-To: <7e847715-6bd5-4f69-a9a6-339788810fec@app.fastmail.com>
From: Bill Wendling <morbo@google.com>
Date: Fri, 2 Oct 2026 05:44:28 -0700
X-Gm-Features: AclHuK_2BHsoBwbSP1Le028scX0dX0GO_oD4fcefHQV9KFQAl-gpbu7HNCV6U34
Message-ID: <CAGG=3QWKEgeggp+OcVsS4QLOX1zxN23HHZp1SfHX0rQVA_7nDQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: annotate struct acpi_gpio_mapping with __counted_by_ptr
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Jeremy Kerr <jk@ozlabs.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 12:38=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
> On Thu, 1 Oct 2026, at 23:24, Linus Walleij wrote:
> > On Thu, Oct 1, 2026 at 10:05=E2=80=AFPM Bill Wendling <morbo@google.com=
> wrote:
> >> On Thu, Oct 1, 2026 at 12:56=E2=80=AFPM Linus Walleij <linusw@kernel.o=
rg> wrote:
> >> > On Mon, Sep 28, 2026 at 9:22=E2=80=AFAM Bill Wendling <morbo@google.=
com> wrote:
> >> > > On Sun, Sep 27, 2026 at 11:38=E2=80=AFPM Bill Wendling <morbo@goog=
le.com> wrote:
> >> > > >
> >> > > > The 'data' pointer field in 'struct acpi_gpio_mapping' is associ=
ated
> >> > > > with the 'size' field, which represents the number of elements o=
f
> >> > > > type 'struct acpi_gpio_params' allocated for 'data'.
> >> > > >
> >> > > > To improve bounds checking via CONFIG_UBSAN_BOUNDS and
> >> > > > CONFIG_FORTIFY_SOURCE, annotate 'data' with the __counted_by_ptr
> >> > > > attribute.
> >> > > >
> >> > > > Analysis of allocation, assignment, and access points shows that=
 the
> >> > > > pointer is never accessed before the count is set, which guarant=
ees that
> >> > > > this annotation is safe and will not cause runtime panics or
> >> > > > false-positive bounds checks.
> >> > > >
> >> > > > Cc: codemender-patching+linux@google.com
> >> > > > Assisted-by: LLM
> >> > > > Signed-off-by: Bill Wendling <morbo@google.com>
> >> > > > ---
> >> > > >  include/linux/gpio/consumer.h | 2 +-
> >> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> > > >
> >> > > > diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/=
consumer.h
> >> > > > index fceeefd5f893..2b80cf7aa7e7 100644
> >> > > > --- a/include/linux/gpio/consumer.h
> >> > > > +++ b/include/linux/gpio/consumer.h
> >> > > > @@ -667,7 +667,7 @@ struct acpi_gpio_params {
> >> > > >
> >> > > >  struct acpi_gpio_mapping {
> >> > > >         const char *name;
> >> > > > -       const struct acpi_gpio_params *data;
> >> > > > +       const struct acpi_gpio_params *data __counted_by_ptr(siz=
e);
> >> > > >         unsigned int size;
> >> > > >
> >> > > >  /* Ignore IoRestriction field */
> >> > >
> >> > > There's a problem with 'drivers/firmware/efi/libstub/Makefile'. Cl=
ang
> >> > > needs a compiler flag to support the "__counted_by_ptr" attribute
> >> > > referencing a field *after* the pointer, like in this patch. Howev=
er,
> >> > > the Makefile blasts the flag away for x86 platforms. Below is a ha=
ck
> >> > > that copies the part of the top-level Makefile that adds the flag.=
 I
> >> > > don't think that's a good solution. The comment in the driver's
> >> > > Makefile says that the stub code executes before the kernel does,
> >> > > which I assume is why a lot of the flags are blown away... In any
> >> > > event, I'm not sure how best to address this.
> >> >
> >> > But is this a problem with the current patch?
> >> >
> >> > Does libefistub use <linux/gpio/consumer.h> in any way, shape
> >> > or form?
> >> >
> >> It's being #included transitively:
> >>
> >> In file included from drivers/firmware/efi/libstub/efi-stub-helper.c:1=
2:
> >> In file included from ./include/linux/efi.h:20:
> >> In file included from ./include/linux/rtc.h:18:
> >> In file included from ./include/linux/nvmem-provider.h:16:
> >> ./include/linux/gpio/consumer.h:670:55: error: use of undeclared
> >> identifier 'size'; did you
> >>       mean 'ksize'?
> >>   670 |         const struct acpi_gpio_params *data __counted_by_ptr(s=
ize);
> >>       |                                                              ^=
~~~
> >>       |                                                              k=
size
> >> ././include/linux/compiler_types.h:392:64: note: expanded from macro
> >> '__counted_by_ptr'
> >>   392 | #define __counted_by_ptr(member)
> >> __attribute__((__counted_by__(member)))
> >>       |
> >>        ^~~~~~
> >> ./include/linux/slab.h:602:8: note: 'ksize' declared here
> >>   602 | size_t ksize(const void *objp);
> >>       |        ^
> >
> > Hm I see.
> >
> > Certainly Jeremy or Ard will have an idea about how to solve this,
> > so paging them in.
> >
>
> libstub code never executes in the context of the kernel, but only in
> the context of the boot firmware. Generally, we disable instrumentation
> there that has a significant runtime component, basically because we
> cannot crash or panic the kernel before we have even booted it.
>
> Can we just #define __counted_by_ptr(...) to nothing when building
> from that Makefile?
>
Doing it in the Makefile is tricky, because of how the "c_flags"
variable is defined and used. I couldn't find a good way to do it.
Instead, I inserted "#undef __counted_by{_ptr}" at the top of the
affected files. It's gross. If there's a way I'm missing, please let
me know.

-bw
