Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF7043CEE3;
	Fri,  2 Oct 2026 07:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926712; cv=none; b=j2JLS9cE2u4zdP3txtubBRsYxmaGCM1AW5JjyaPqswTayqCIJDr8ol3eDinzSPzANB4+GY8mk+UH1fevJ9Ppe5Tyg8QtyEL++WY5z5M/0/tqsDmp15UuYywn8vRZq4D9LtcIJQ5CFfK7/kdcBslu8UA6JRPBVIUd931/r2ZcRpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926712; c=relaxed/simple;
	bh=uxpK6vzv53tP4a7NeeHGhYR+8OkiQgrSzeHoa5Cljy4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=O0ZQaOZviJux4nokxy/pPmvAs370lVHA20D2xd9NV94f8HbusHQBywR8qJHhHHEqqKAgrcq+t8HREAtJAKw096zH+H3boQ2PsDRdT8i1sqSSsOhlSvbc2lqm6e5N0sqGiRIn23S43liloy2UFJLKz+9lsVJEev31MPo99c2KrAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K92ZDcGX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K92ZDcGX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535401F00893;
	Fri,  2 Oct 2026 07:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790926711;
	bh=XtSWMODzZRMemFY6O5+w7nKBIt1ojmfxNPujwIIo1pM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=K92ZDcGXpNj2kZ7B7rF76L6o74uWMwVDHLV7RHruKiu5sPyzSaww5VbOy5uQQOSTD
	 EsduIzswJnKxxlAdP3JDCELv9cEf20A1IdGwStTBJYFWfNAjyoURDto43inFoGSzGn
	 jx91um3s8BySk4y6tdNDDn50IYXSVlQnknAseEu+QIy3Dk2DEEJPuWAGQ450zGJBj5
	 uZOEzwYYLV4tvrfYkgxwiFhZ9RfVSDgSe2f0l75647aeAoH6AFRzlntrF9fpC9N8EZ
	 gaoKqwL3AjPWOXHFq8XVPWbeEWAgneTwtix7yB8UHkKkdIf00ML6hukTf06zXFRISS
	 h1D3udUEBJAkQ==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id C080D198003A;
	Fri,  2 Oct 2026 03:38:28 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Fri, 02 Oct 2026 03:38:28 -0400
X-ME-Sender: <xms:c1-_aoMxJIXM9u8qgLYFXh1jD3wmlA1Sp70YqaVBLFjeH0WXCH1U2A>
    <xme:c1-_apyaN0-TmpoZAuWIxhRfTU_PoSLvMmkwDWQ8xfnFBq3Z4lu0h4nyQ5y34ImFk
    A2kPbR5DtCk_l4uH3WHfsnGYyBuAZ2_ObHRtRhZzujPZ3IVGJsmQxVg>
X-ME-Proxy-Cause: dmFkZTFj5SHra/C1CsSY6JjKDNLgrncTSuKCsVZg37Q6vWpK6cQ0urV5rL0EOpMpw74RH0
    v6mXpnl1+qfRY2aOEZ5gc08XjonARkwl3nYAm00P+hNLt6QoQOmYyss2I5et+iz+6GsY4x
    MYJIHbE36C+uLmzYlsDoXyRulQRWj4IsCnwbIGJsA3aX3tzZOR01oRm0QzIMdxf8vIW7kl
    I8qNm6BEyxt/q76vUVI9/St5IIBKXv4F31DoVCsSeCF0q5EEeKU40Y8AeJ56E4oGhqi9tz
    NJBwnnq7DD/nzgeemIai7mErXg1/rt52kINa6mp2Smb3YlgXDP6Jtu8YNhFyhSQ8EaSioa
    O6vR2LZ5WeNxms2YL+D2KtEwAO0u2N1yXjp9JfdalfkDgwSe5AA9EkV9n2cQKoYxruc2MD
    hOIoQKgsZwoMdQa3kOGv2/6i9zBKgIvUlvcBu8CgIL0kMu0M1fSfPP3/bZcXmJ7RiLtiQy
    72VRIFV5T3sAe4X646InkTuYBJPqIlELJR3NMdCvMxPvxYpH51LqCWWOnPNjipF2YH4caz
    VuVjNgKj3mA8EUzR49+IWjXrT4WnKFZXF8Tomns8NYsHSy/2fcK/Z93uHCwJkHbl/toJe0
    zrmNp19pEe8FUJAPDr3+pW/Tp2GNcL1C+dhLx0SG1nPHQx2cqIVtYtfUwvlw
X-ME-Proxy: <xmx:dF-_auwRaVuocg_eq8roLK1nmoQMTq0XZbJZgLsD8Vr7qCMtAJNQKw>
    <xmx:dF-_aie62EG-HBNmU39K6joMXustf7BxZvNZXO-O9e8jaZTptoZVeA>
    <xmx:dF-_ar4O9bcO-pnCqLopyJHtkA6_hh-E9dBvj-D-KMp3jlcG2DnfIw>
    <xmx:dF-_avKANjwW3ItwfDM7kWOwzDN1vaUjpKufblGRReVc5Bi0FJpnJA>
    <xmx:dF-_aryWdE2Z6djpuv_k0hHdhpuW9ab9YEn3Bgl4TeKlzz3ysBxj-qXJ>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id E7824F80084; Fri,  2 Oct 2026 03:38:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 02 Oct 2026 09:38:05 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Linus Walleij" <linusw@kernel.org>, "Bill Wendling" <morbo@google.com>,
 "Jeremy Kerr" <jk@ozlabs.org>
Cc: "Bartosz Golaszewski" <brgl@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 codemender-patching+linux@google.com
Message-Id: <7e847715-6bd5-4f69-a9a6-339788810fec@app.fastmail.com>
In-Reply-To: 
 <CAD++jLnOm3ua7hom_L4YQwN5z81M17WmL_VGqx+-ugrAJ-6_Dg@mail.gmail.com>
References: <20260928063824.1386524-1-morbo@google.com>
 <CAGG=3QWCmQ+LVvn2dtjEauj5WFwvx=pvg4Q6man_A2imdjRe7A@mail.gmail.com>
 <CAD++jLk2pFCpbpGVCQg2AdrwQecpb=wsehhwSuwTbKAXNeyfoQ@mail.gmail.com>
 <CAGG=3QV2k-nsZHNSuKEixZb+-LcxvhQsG379ghgyOpiDLTJWzw@mail.gmail.com>
 <CAD++jLnOm3ua7hom_L4YQwN5z81M17WmL_VGqx+-ugrAJ-6_Dg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: annotate struct acpi_gpio_mapping with __counted_by_ptr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Thu, 1 Oct 2026, at 23:24, Linus Walleij wrote:
> On Thu, Oct 1, 2026 at 10:05=E2=80=AFPM Bill Wendling <morbo@google.co=
m> wrote:
>> On Thu, Oct 1, 2026 at 12:56=E2=80=AFPM Linus Walleij <linusw@kernel.=
org> wrote:
>> > On Mon, Sep 28, 2026 at 9:22=E2=80=AFAM Bill Wendling <morbo@google=
.com> wrote:
>> > > On Sun, Sep 27, 2026 at 11:38=E2=80=AFPM Bill Wendling <morbo@goo=
gle.com> wrote:
>> > > >
>> > > > The 'data' pointer field in 'struct acpi_gpio_mapping' is assoc=
iated
>> > > > with the 'size' field, which represents the number of elements =
of
>> > > > type 'struct acpi_gpio_params' allocated for 'data'.
>> > > >
>> > > > To improve bounds checking via CONFIG_UBSAN_BOUNDS and
>> > > > CONFIG_FORTIFY_SOURCE, annotate 'data' with the __counted_by_ptr
>> > > > attribute.
>> > > >
>> > > > Analysis of allocation, assignment, and access points shows tha=
t the
>> > > > pointer is never accessed before the count is set, which guaran=
tees that
>> > > > this annotation is safe and will not cause runtime panics or
>> > > > false-positive bounds checks.
>> > > >
>> > > > Cc: codemender-patching+linux@google.com
>> > > > Assisted-by: LLM
>> > > > Signed-off-by: Bill Wendling <morbo@google.com>
>> > > > ---
>> > > >  include/linux/gpio/consumer.h | 2 +-
>> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > > >
>> > > > diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio=
/consumer.h
>> > > > index fceeefd5f893..2b80cf7aa7e7 100644
>> > > > --- a/include/linux/gpio/consumer.h
>> > > > +++ b/include/linux/gpio/consumer.h
>> > > > @@ -667,7 +667,7 @@ struct acpi_gpio_params {
>> > > >
>> > > >  struct acpi_gpio_mapping {
>> > > >         const char *name;
>> > > > -       const struct acpi_gpio_params *data;
>> > > > +       const struct acpi_gpio_params *data __counted_by_ptr(si=
ze);
>> > > >         unsigned int size;
>> > > >
>> > > >  /* Ignore IoRestriction field */
>> > >
>> > > There's a problem with 'drivers/firmware/efi/libstub/Makefile'. C=
lang
>> > > needs a compiler flag to support the "__counted_by_ptr" attribute
>> > > referencing a field *after* the pointer, like in this patch. Howe=
ver,
>> > > the Makefile blasts the flag away for x86 platforms. Below is a h=
ack
>> > > that copies the part of the top-level Makefile that adds the flag=
. I
>> > > don't think that's a good solution. The comment in the driver's
>> > > Makefile says that the stub code executes before the kernel does,
>> > > which I assume is why a lot of the flags are blown away... In any
>> > > event, I'm not sure how best to address this.
>> >
>> > But is this a problem with the current patch?
>> >
>> > Does libefistub use <linux/gpio/consumer.h> in any way, shape
>> > or form?
>> >
>> It's being #included transitively:
>>
>> In file included from drivers/firmware/efi/libstub/efi-stub-helper.c:=
12:
>> In file included from ./include/linux/efi.h:20:
>> In file included from ./include/linux/rtc.h:18:
>> In file included from ./include/linux/nvmem-provider.h:16:
>> ./include/linux/gpio/consumer.h:670:55: error: use of undeclared
>> identifier 'size'; did you
>>       mean 'ksize'?
>>   670 |         const struct acpi_gpio_params *data __counted_by_ptr(=
size);
>>       |                                                              =
^~~~
>>       |                                                              =
ksize
>> ././include/linux/compiler_types.h:392:64: note: expanded from macro
>> '__counted_by_ptr'
>>   392 | #define __counted_by_ptr(member)
>> __attribute__((__counted_by__(member)))
>>       |
>>        ^~~~~~
>> ./include/linux/slab.h:602:8: note: 'ksize' declared here
>>   602 | size_t ksize(const void *objp);
>>       |        ^
>
> Hm I see.
>
> Certainly Jeremy or Ard will have an idea about how to solve this,
> so paging them in.
>

libstub code never executes in the context of the kernel, but only in
the context of the boot firmware. Generally, we disable instrumentation
there that has a significant runtime component, basically because we
cannot crash or panic the kernel before we have even booted it.

Can we just #define __counted_by_ptr(...) to nothing when building
from that Makefile?

