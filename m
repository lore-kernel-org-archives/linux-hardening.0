Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2774391E5B
	for <linux-hardening@vger.kernel.org>; Sat,  3 Oct 2026 09:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791018629; cv=none; b=ZI9+HG5On0c25gLRjI+HVibr/dznOJit2wEUlJ68HH7TJ+/gy/Su1w4N5OBE4R0Ka1v+qqx34LUNb4+Gyne+k64J60CNwcucVb0KdY0KoyrPbEJEX5iG91T5n+hiiQjnGpXAS3Q2+YQrEZ8Hy0Eo/uRsBYIDS7P35xYLBWaL0WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791018629; c=relaxed/simple;
	bh=V3DDxben52YB+3AC4H3p4SJSHBjayiswKy/T0MPzYuY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kOfB7cjjfkEnum2aDX5d+hoUhPDYHNrjv2wWufUeYiNNj9pLpkbk/YKPIl0JDXlh2T9rqZmE6PfvNWrz+dZLoH/ldZ5x5VrSLWz4bRW2NMaWyGbxFYwEnSMIX5+PY+07B8cqW20mzaIn6ory6ZadUnlsBU59WnhSsW8UKZdJwh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEmmfL2y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEmmfL2y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338C71F0089D;
	Sat,  3 Oct 2026 09:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791018624;
	bh=40Q+BQhPV/7YJVdU18+bv68+lD9vaTDMHUJymM/7aLQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=KEmmfL2yy2NIQQxxXN88AR/pQ4ACMoBZPI+6rm01SsszkIvJEymsl8qJCC+8NSzyC
	 p2D82uHCaip6GbOdLRn1IZKpXFfGGy4OqTElpvexQQ1RGDtKfmznUPqRXK5O853BZQ
	 PfEUoBcuDJkWxFKcpNywycaNXnGD0vtp06HWvKFj0rwjptOHz6B/v9KAw6slR/tcz0
	 fbJYK9cpbdENIGQJFEFw1AeuD4Lzlkqb6DyZpuxO04eIObbvCWN4w04PGDL1hwDM8l
	 dzGB7LmjrwNyUb2/aYLfrGbSia3gsXMffdSXtwGCiv/7QQemEUJT9kJtqbEjUMU3HQ
	 cX9FzSvKN3WeA==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 7D490198003A;
	Sat,  3 Oct 2026 05:10:22 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Sat, 03 Oct 2026 05:10:22 -0400
X-ME-Sender: <xms:fMbAaruZ1p-31pg-gMtQwhQWuzehRey1eUGN9eWRiyqGs2vNPVpoIw>
    <xme:fMbAanRKcJpno_hJ9lbiRqrpAVrNVDhZoF349jxFfvGwkK6rPsjDcw1xtATfqRFOJ
    0jEiSiRqcUuUGCf7bGP6OBKVmMRUFVBkbfRPFSNgOZJHTJxPMAX85Y>
X-ME-Proxy-Cause: dmFkZTFmKcJLX6AWSkxpp210h4B+6lLradu3bnF4Q01CservSTw0v2jNi6VPk5jhgwelyw
    5jjkZDZlZDrxnh2URU5j3djsIB+gLBfZqjhdGZ+m4Zjf8/+LpwZOYwiXqXEhuGBUDAEVt6
    9NBV7vf3jExfvSSBmlb/NQnvcKN2sRghAAw82nxYZ3Quv+l86FbVe3P19cwahCCCzOCja3
    6Y2CnyXVW/QWDT1lz7g2xapBrOu4HIrF0aHCgrQNVZvejgRCeWD1hRm8e43cmWWBb9De3C
    VD/oS0BmbVwIJs0TbQNbSXNZPdf9Iy7ERRQgTgygSsmwZfwNoadpIf9rWGbBydKyQbmTES
    4b7esYAuBHX7zZMxDcWhBx/EvulexwoBOlqscb9GuHFwTYHrLSwCBiBRNdAIgoDjKNz55m
    GprJWXnd+mxMYJfTgaW66WzmUyIZWUd4ZibaXEX7FSUub9RDEGer3v3I0Lrg+EcR9D9QaA
    CVgFojxP0gPZTVJdnSYP1CiKdBNFhnZMpF6gYdTr6MMu4mI2xrOtmGqpjW0QOjBVLeLDKa
    ajVxZbjKP4BPv8wZqkTHNctSk2lOBr5LQ2UTFE5HqaW6PKx84h86aiO3TKjXEWc+rXgOOW
    xH5EwxE776HhKnNOCj1zYNh3NPFm65stLONF9hSLTI9wA8+CE4Cpg74Exl+A
X-ME-Proxy: <xmx:fsbAaqQ91dKPz1cAUJIEcPPINLOq604fWPMh-6RH3HSysU_M0dDXWg>
    <xmx:fsbAan-nzifUTJGOrBk3-6pb7ZgwpOWo9ziQQAyNuStz4o2RJN-Y4w>
    <xmx:fsbAajYtCLJlOqpcXEvZ66tr-XCaXO05dZ868E8xCucQQYA8SEj_Qw>
    <xmx:fsbAagpKWgpSWG8-VDa4LRVCwEWFOZpBKMi4JElvsarjv7yEdIIyqg>
    <xmx:fsbAavTFfGvmira1W7GbP-0RQBRPX53E92k3I6pbKGh5JFApjvPmwE84>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 40384F80090; Sat,  3 Oct 2026 05:10:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 03 Oct 2026 11:10:00 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Bill Wendling" <morbo@google.com>
Cc: "Linus Walleij" <linusw@kernel.org>, "Jeremy Kerr" <jk@ozlabs.org>,
 "Bartosz Golaszewski" <brgl@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 codemender-patching+linux@google.com
Message-Id: <05f1ea67-e6c1-4660-83a5-89550af259b9@app.fastmail.com>
In-Reply-To: 
 <CAGG=3QXtYajLg-W21R=52FB151wbnAYr7a7rJMJL9krq0-fTyw@mail.gmail.com>
References: <20260928063824.1386524-1-morbo@google.com>
 <CAGG=3QWCmQ+LVvn2dtjEauj5WFwvx=pvg4Q6man_A2imdjRe7A@mail.gmail.com>
 <CAD++jLk2pFCpbpGVCQg2AdrwQecpb=wsehhwSuwTbKAXNeyfoQ@mail.gmail.com>
 <CAGG=3QV2k-nsZHNSuKEixZb+-LcxvhQsG379ghgyOpiDLTJWzw@mail.gmail.com>
 <CAD++jLnOm3ua7hom_L4YQwN5z81M17WmL_VGqx+-ugrAJ-6_Dg@mail.gmail.com>
 <7e847715-6bd5-4f69-a9a6-339788810fec@app.fastmail.com>
 <CAGG=3QWKEgeggp+OcVsS4QLOX1zxN23HHZp1SfHX0rQVA_7nDQ@mail.gmail.com>
 <4c92ca0e-c502-4a63-a2a2-bbf53db5e40f@app.fastmail.com>
 <CAGG=3QXtYajLg-W21R=52FB151wbnAYr7a7rJMJL9krq0-fTyw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: annotate struct acpi_gpio_mapping with __counted_by_ptr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Sat, 3 Oct 2026, at 10:54, Bill Wendling wrote:
> On Fri, Oct 2, 2026 at 6:52=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org=
> wrote:
>> On Fri, 2 Oct 2026, at 14:44, Bill Wendling wrote:
>> > On Fri, Oct 2, 2026 at 12:38=E2=80=AFAM Ard Biesheuvel <ardb@kernel=
.org> wrote:
>> >> On Thu, 1 Oct 2026, at 23:24, Linus Walleij wrote:
>> >> > On Thu, Oct 1, 2026 at 10:05=E2=80=AFPM Bill Wendling <morbo@goo=
gle.com> wrote:
>> >> >> On Thu, Oct 1, 2026 at 12:56=E2=80=AFPM Linus Walleij <linusw@k=
ernel.org> wrote:
>> >> >> > On Mon, Sep 28, 2026 at 9:22=E2=80=AFAM Bill Wendling <morbo@=
google.com> wrote:
>> >> >> > > On Sun, Sep 27, 2026 at 11:38=E2=80=AFPM Bill Wendling <mor=
bo@google.com> wrote:
>> >> >> > > >
>> >> >> > > > The 'data' pointer field in 'struct acpi_gpio_mapping' is=
 associated
>> >> >> > > > with the 'size' field, which represents the number of ele=
ments of
>> >> >> > > > type 'struct acpi_gpio_params' allocated for 'data'.
>> >> >> > > >
>> >> >> > > > To improve bounds checking via CONFIG_UBSAN_BOUNDS and
>> >> >> > > > CONFIG_FORTIFY_SOURCE, annotate 'data' with the __counted=
_by_ptr
>> >> >> > > > attribute.
>> >> >> > > >
>> >> >> > > > Analysis of allocation, assignment, and access points sho=
ws that the
>> >> >> > > > pointer is never accessed before the count is set, which =
guarantees that
>> >> >> > > > this annotation is safe and will not cause runtime panics=
 or
>> >> >> > > > false-positive bounds checks.
>> >> >> > > >
>> >> >> > > > Cc: codemender-patching+linux@google.com
>> >> >> > > > Assisted-by: LLM
>> >> >> > > > Signed-off-by: Bill Wendling <morbo@google.com>
>> >> >> > > > ---
>> >> >> > > >  include/linux/gpio/consumer.h | 2 +-
>> >> >> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >> >> > > >
>> >> >> > > > diff --git a/include/linux/gpio/consumer.h b/include/linu=
x/gpio/consumer.h
>> >> >> > > > index fceeefd5f893..2b80cf7aa7e7 100644
>> >> >> > > > --- a/include/linux/gpio/consumer.h
>> >> >> > > > +++ b/include/linux/gpio/consumer.h
>> >> >> > > > @@ -667,7 +667,7 @@ struct acpi_gpio_params {
>> >> >> > > >
>> >> >> > > >  struct acpi_gpio_mapping {
>> >> >> > > >         const char *name;
>> >> >> > > > -       const struct acpi_gpio_params *data;
>> >> >> > > > +       const struct acpi_gpio_params *data __counted_by_=
ptr(size);
>> >> >> > > >         unsigned int size;
>> >> >> > > >
>> >> >> > > >  /* Ignore IoRestriction field */
>> >> >> > >
>> >> >> > > There's a problem with 'drivers/firmware/efi/libstub/Makefi=
le'. Clang
>> >> >> > > needs a compiler flag to support the "__counted_by_ptr" att=
ribute
>> >> >> > > referencing a field *after* the pointer, like in this patch=
. However,
>> >> >> > > the Makefile blasts the flag away for x86 platforms. Below =
is a hack
>> >> >> > > that copies the part of the top-level Makefile that adds th=
e flag. I
>> >> >> > > don't think that's a good solution. The comment in the driv=
er's
>> >> >> > > Makefile says that the stub code executes before the kernel=
 does,
>> >> >> > > which I assume is why a lot of the flags are blown away... =
In any
>> >> >> > > event, I'm not sure how best to address this.
>> >> >> >
>> >> >> > But is this a problem with the current patch?
>> >> >> >
>> >> >> > Does libefistub use <linux/gpio/consumer.h> in any way, shape
>> >> >> > or form?
>> >> >> >
>> >> >> It's being #included transitively:
>> >> >>
>> >> >> In file included from drivers/firmware/efi/libstub/efi-stub-hel=
per.c:12:
>> >> >> In file included from ./include/linux/efi.h:20:
>> >> >> In file included from ./include/linux/rtc.h:18:
>> >> >> In file included from ./include/linux/nvmem-provider.h:16:
>> >> >> ./include/linux/gpio/consumer.h:670:55: error: use of undeclared
>> >> >> identifier 'size'; did you
>> >> >>       mean 'ksize'?
>> >> >>   670 |         const struct acpi_gpio_params *data __counted_b=
y_ptr(size);
>> >> >>       |                                                        =
      ^~~~
>> >> >>       |                                                        =
      ksize
>> >> >> ././include/linux/compiler_types.h:392:64: note: expanded from =
macro
>> >> >> '__counted_by_ptr'
>> >> >>   392 | #define __counted_by_ptr(member)
>> >> >> __attribute__((__counted_by__(member)))
>> >> >>       |
>> >> >>        ^~~~~~
>> >> >> ./include/linux/slab.h:602:8: note: 'ksize' declared here
>> >> >>   602 | size_t ksize(const void *objp);
>> >> >>       |        ^
>> >> >
>> >> > Hm I see.
>> >> >
>> >> > Certainly Jeremy or Ard will have an idea about how to solve thi=
s,
>> >> > so paging them in.
>> >> >
>> >>
>> >> libstub code never executes in the context of the kernel, but only=
 in
>> >> the context of the boot firmware. Generally, we disable instrument=
ation
>> >> there that has a significant runtime component, basically because =
we
>> >> cannot crash or panic the kernel before we have even booted it.
>> >>
>> >> Can we just #define __counted_by_ptr(...) to nothing when building
>> >> from that Makefile?
>> >>
>> > Doing it in the Makefile is tricky, because of how the "c_flags"
>> > variable is defined and used. I couldn't find a good way to do it.
>> > Instead, I inserted "#undef __counted_by{_ptr}" at the top of the
>> > affected files. It's gross. If there's a way I'm missing, please let
>> > me know.
>> >
>>
>> Does that even build?
>
> It did for me...
>
> Let me look into Sashiko's comments.
>

When you #undef __counted_by(), it is passed straight to the compiler
rather than being turned into whichever __attribute__(()) it is supposed
to resolve to by the preprocessor.

Hence my surprise that it actually builds.

In any case, this should be done in the Makefile or in a header, not in
each individual C source file.



