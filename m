Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8881F4AB1D0;
	Fri,  2 Oct 2026 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949127; cv=none; b=OYaH490Axl9E+BMJadkScppg8/f13zcBYHPWzMFkl2zyTQ1WH2bDubUwmQDh2km/4wkz/aDQ+j2cAGRXF6/8+fjWlGebEntI0o0FLI92ZqrKMLwo/BSCsYZ73bZ7Bhu/KbpGl/rqjTfwU/+mtFrLIcfYAbiQihEh+/V8fodX0qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949127; c=relaxed/simple;
	bh=vQn/UvxJai8olpk7tjD6vcaqv6ea4A8jc/8qu8mr2j0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JsBx/NdSz32qrfHblpKZxlpz1D1IIVD/OSZwLoXZcrKo5VdYgqObdb6iGvpBZqaSrtNZEEqVdY12xxrFLaQsrXLbcvcPqRrBUvIvO2X0dvF+OBgTYki19ZU3rFJJFkHn79arffLbdSW9aYiFY3/Mt7LYVsxzdwBe0BYD8UAzQUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDwcXx2G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDwcXx2G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1DF1F000FF;
	Fri,  2 Oct 2026 13:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790949126;
	bh=9ajHiX0c3BZlGKVhGi19LA0Q3JMxAbGSQmVWKZD04Kc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=oDwcXx2GLDQvmlZEnFZUok1dadGokJvmlO4QZ0TOXRknYvc2czHs8uDvOszmb4Xtu
	 VM20MJt+mFwj/8U17JF/X7WSUtJZnoC3HLXYs3RGbDLvuJBhd66F8ON0+p6u+EyRmU
	 RrURfaKHEtme/WXTOBBiKw23k7mNp5ZsH1EOsGz9I0cxLmfh/CeojZPxPyL4PoBvyG
	 7gseyg9/grFeEhvq1bffRZHbZbXNEmc6tTO6iovRphr258HMbIdh0mxvl+lGj5xmdA
	 Cr0auWhnno4zdoqpyBkpu6QURrMXnJdsLfInD1uVqC7atB3p48QACk5YHt10WQQVtQ
	 CgAZSTmwcg2LQ==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 8AA41198003A;
	Fri,  2 Oct 2026 09:52:03 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Fri, 02 Oct 2026 09:52:03 -0400
X-ME-Sender: <xms:Abe_avHHQaBIk_Kyd-HZmoQarPXkbP3vcarq6wv32pmNXPA8VyizFg>
    <xme:Abe_anJ7X4FdkGzKv6ldOc0cuvZx2wyQVMWXgukiZBdLFfzNlA9PToYGwLaFWt_oD
    tbyvlVtMFOyy0nbnKL0Fl9vyWOL789cuFA1eFfCBJ98MRdCXMdRIYNG>
X-ME-Proxy-Cause: dmFkZTG2SSBU1HgYU8SrPtS3kHNUyFjkNQvrAXFQxeRX8qWJTtNZLjMsW3FnZ0iC6MYfOy
    rAwjazHrYGy/mElACwfLCAwHkbqCJ2WW4+7xYcCrvqeig1Z0tTUGx7Ss65vbH/rNbwSI2h
    FjuArhUdWk+87U8t0m0mnNLagvIM0sxR7S0VStKZq99NUWfCr0jCWQmtbJM4YmcQpzkj+j
    nEcnidtTdgXVMOGibVaPQjcs+AyO4gRKxc2D2xRt+YG7eL0t9Jl6c6tLmqC6aRj7L/PR3Y
    KqqKvWbUwQywfZrwcGu3+/KzldX6/1pLck64ueEoWz8cMAQWOxHzybeyHLbFdivCglVbBH
    L87AljYz/+Y31wVP4HNEf/N+D3fHik+ZXIG+J0rnmOf2JfOY9COo1zUey8SAY4ZKe4Kj1N
    GAoHhDUTIwjIGk0cb65X7vdeCWquehLOYYc/b3VIRS7qiBrCu1/WBkd0jgeZCOpwt0mgqh
    9wjsCKrDTbyN3A+IlaJSDSd1O/qZNAKPXNAinDNGuNGpaJAqki5CETKNMO2XNnURg+IO1x
    XPZgIiaa/1OrerB8LnOWb7bKYcPS+8vXd2hqcf21ZLoQ7sypj3tm3LgXfZjgBFTvv9ut15
    +EMf/yn+AffDgEwx0WgWQzRiDu+5tVi4GJMBdZUqNbgR6SDp9GoCwG3qWEbQ
X-ME-Proxy: <xmx:A7e_ajrfhb4LSYXmjhYe2Np45yl3qm9DtiRLJPqdjmAgYfCn47p_5Q>
    <xmx:A7e_al04eD3Qs0bFUexXCETGwQuySv7w7YJlzcQQFzLgaqgjfkATjw>
    <xmx:A7e_arxPClRhNYvSdS3J-9nNZivWZH-uJWb-y5UMO2O_C531QSqzsg>
    <xmx:A7e_ahhhz_d1AlIwOBSeFHBheOwQxeLU9t26EexMW6zcB-8t2t3kIg>
    <xmx:A7e_auoq9h3Jg2KeZNLjpX59OARLq7wA8Sg5S5bwlK2xcyAUSxdIZN8z>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id B111DF8008E; Fri,  2 Oct 2026 09:52:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 02 Oct 2026 15:51:40 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Bill Wendling" <morbo@google.com>
Cc: "Linus Walleij" <linusw@kernel.org>, "Jeremy Kerr" <jk@ozlabs.org>,
 "Bartosz Golaszewski" <brgl@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 codemender-patching+linux@google.com
Message-Id: <4c92ca0e-c502-4a63-a2a2-bbf53db5e40f@app.fastmail.com>
In-Reply-To: 
 <CAGG=3QWKEgeggp+OcVsS4QLOX1zxN23HHZp1SfHX0rQVA_7nDQ@mail.gmail.com>
References: <20260928063824.1386524-1-morbo@google.com>
 <CAGG=3QWCmQ+LVvn2dtjEauj5WFwvx=pvg4Q6man_A2imdjRe7A@mail.gmail.com>
 <CAD++jLk2pFCpbpGVCQg2AdrwQecpb=wsehhwSuwTbKAXNeyfoQ@mail.gmail.com>
 <CAGG=3QV2k-nsZHNSuKEixZb+-LcxvhQsG379ghgyOpiDLTJWzw@mail.gmail.com>
 <CAD++jLnOm3ua7hom_L4YQwN5z81M17WmL_VGqx+-ugrAJ-6_Dg@mail.gmail.com>
 <7e847715-6bd5-4f69-a9a6-339788810fec@app.fastmail.com>
 <CAGG=3QWKEgeggp+OcVsS4QLOX1zxN23HHZp1SfHX0rQVA_7nDQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: annotate struct acpi_gpio_mapping with __counted_by_ptr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Fri, 2 Oct 2026, at 14:44, Bill Wendling wrote:
> On Fri, Oct 2, 2026 at 12:38=E2=80=AFAM Ard Biesheuvel <ardb@kernel.or=
g> wrote:
>> On Thu, 1 Oct 2026, at 23:24, Linus Walleij wrote:
>> > On Thu, Oct 1, 2026 at 10:05=E2=80=AFPM Bill Wendling <morbo@google=
.com> wrote:
>> >> On Thu, Oct 1, 2026 at 12:56=E2=80=AFPM Linus Walleij <linusw@kern=
el.org> wrote:
>> >> > On Mon, Sep 28, 2026 at 9:22=E2=80=AFAM Bill Wendling <morbo@goo=
gle.com> wrote:
>> >> > > On Sun, Sep 27, 2026 at 11:38=E2=80=AFPM Bill Wendling <morbo@=
google.com> wrote:
>> >> > > >
>> >> > > > The 'data' pointer field in 'struct acpi_gpio_mapping' is as=
sociated
>> >> > > > with the 'size' field, which represents the number of elemen=
ts of
>> >> > > > type 'struct acpi_gpio_params' allocated for 'data'.
>> >> > > >
>> >> > > > To improve bounds checking via CONFIG_UBSAN_BOUNDS and
>> >> > > > CONFIG_FORTIFY_SOURCE, annotate 'data' with the __counted_by=
_ptr
>> >> > > > attribute.
>> >> > > >
>> >> > > > Analysis of allocation, assignment, and access points shows =
that the
>> >> > > > pointer is never accessed before the count is set, which gua=
rantees that
>> >> > > > this annotation is safe and will not cause runtime panics or
>> >> > > > false-positive bounds checks.
>> >> > > >
>> >> > > > Cc: codemender-patching+linux@google.com
>> >> > > > Assisted-by: LLM
>> >> > > > Signed-off-by: Bill Wendling <morbo@google.com>
>> >> > > > ---
>> >> > > >  include/linux/gpio/consumer.h | 2 +-
>> >> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >> > > >
>> >> > > > diff --git a/include/linux/gpio/consumer.h b/include/linux/g=
pio/consumer.h
>> >> > > > index fceeefd5f893..2b80cf7aa7e7 100644
>> >> > > > --- a/include/linux/gpio/consumer.h
>> >> > > > +++ b/include/linux/gpio/consumer.h
>> >> > > > @@ -667,7 +667,7 @@ struct acpi_gpio_params {
>> >> > > >
>> >> > > >  struct acpi_gpio_mapping {
>> >> > > >         const char *name;
>> >> > > > -       const struct acpi_gpio_params *data;
>> >> > > > +       const struct acpi_gpio_params *data __counted_by_ptr=
(size);
>> >> > > >         unsigned int size;
>> >> > > >
>> >> > > >  /* Ignore IoRestriction field */
>> >> > >
>> >> > > There's a problem with 'drivers/firmware/efi/libstub/Makefile'=
. Clang
>> >> > > needs a compiler flag to support the "__counted_by_ptr" attrib=
ute
>> >> > > referencing a field *after* the pointer, like in this patch. H=
owever,
>> >> > > the Makefile blasts the flag away for x86 platforms. Below is =
a hack
>> >> > > that copies the part of the top-level Makefile that adds the f=
lag. I
>> >> > > don't think that's a good solution. The comment in the driver's
>> >> > > Makefile says that the stub code executes before the kernel do=
es,
>> >> > > which I assume is why a lot of the flags are blown away... In =
any
>> >> > > event, I'm not sure how best to address this.
>> >> >
>> >> > But is this a problem with the current patch?
>> >> >
>> >> > Does libefistub use <linux/gpio/consumer.h> in any way, shape
>> >> > or form?
>> >> >
>> >> It's being #included transitively:
>> >>
>> >> In file included from drivers/firmware/efi/libstub/efi-stub-helper=
.c:12:
>> >> In file included from ./include/linux/efi.h:20:
>> >> In file included from ./include/linux/rtc.h:18:
>> >> In file included from ./include/linux/nvmem-provider.h:16:
>> >> ./include/linux/gpio/consumer.h:670:55: error: use of undeclared
>> >> identifier 'size'; did you
>> >>       mean 'ksize'?
>> >>   670 |         const struct acpi_gpio_params *data __counted_by_p=
tr(size);
>> >>       |                                                           =
   ^~~~
>> >>       |                                                           =
   ksize
>> >> ././include/linux/compiler_types.h:392:64: note: expanded from mac=
ro
>> >> '__counted_by_ptr'
>> >>   392 | #define __counted_by_ptr(member)
>> >> __attribute__((__counted_by__(member)))
>> >>       |
>> >>        ^~~~~~
>> >> ./include/linux/slab.h:602:8: note: 'ksize' declared here
>> >>   602 | size_t ksize(const void *objp);
>> >>       |        ^
>> >
>> > Hm I see.
>> >
>> > Certainly Jeremy or Ard will have an idea about how to solve this,
>> > so paging them in.
>> >
>>
>> libstub code never executes in the context of the kernel, but only in
>> the context of the boot firmware. Generally, we disable instrumentati=
on
>> there that has a significant runtime component, basically because we
>> cannot crash or panic the kernel before we have even booted it.
>>
>> Can we just #define __counted_by_ptr(...) to nothing when building
>> from that Makefile?
>>
> Doing it in the Makefile is tricky, because of how the "c_flags"
> variable is defined and used. I couldn't find a good way to do it.
> Instead, I inserted "#undef __counted_by{_ptr}" at the top of the
> affected files. It's gross. If there's a way I'm missing, please let
> me know.
>

Does that even build?
