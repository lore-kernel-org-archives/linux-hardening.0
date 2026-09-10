Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CAA4A68AA
	for <linux-hardening@vger.kernel.org>; Thu, 10 Sep 2026 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789068688; cv=pass; b=dZQwWtpYvxfDjQ63iuNhKGt2M3kdtsvTGKwZp+lAK2GNWhFhtChGLsZ87TWFfvm9TUmGMxzKa3JaZAAWNo9g63lCAeSaJL52y29jqkKDBekjnTaf3AXtbeggNURIx2txM3m8r6GokvvrFBLsRsn8k5zlXuFElgRJXgmLW43UOBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789068688; c=relaxed/simple;
	bh=KTq9X+5RKd6MevfODoxvkTeUdtyi6rv9KjZTSYh2TKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRtzzIx0lHdDv+gIIbu7oZpYX0LMzGUcMy1TalZhemyVb0GUov/WG69vVyGzV/6hHsh52RxLO/JqpaddHCLlQqLWyrds6NRQsXQU/bKQskSzzYm4bEeaZFJ5m+NMjvH0KUpEb+Alv36vfrixkfmfFwJc2yZPJhRgGCBcRl0h004=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bTyEgftU; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bTyEgftU"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5c663437fe5so170545e0c.3
        for <linux-hardening@vger.kernel.org>; Thu, 10 Sep 2026 12:31:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789068677; cv=none;
        d=google.com; s=arc-20260327;
        b=bbwmdlUHgBDuhCuEhzFQJwwRubICECFCBOm/3Gx5xUkZviUThOHnjn4Mu3gxbk55jV
         QdkePnNq/vkHvgXszAzOON5QboQ7/hkFFShN2uFbBzVOlt/Lt7kK40YIBK2NO7HTiJ7R
         d6tbrRAkIn8QGyDxjGguFU0gavZmt6QD9XwvroRWj89k0Clb7ZUOaWFDW4QhS2BWp1kg
         EF1jqpKY4rUtSRrp98nn/gydhQBDLb8T8WN1UX3mEyiFwV+n6mHl+YzobzYU3RCBrV5x
         ANC6Vn2Y0U7snnzntB5ZBiCqJHm4rr3N2y/7SULbBX+NbqUIg6TIbNg2QzIiqVN17L3w
         ieFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0V/f5lIKQxwY8UDJZpxZzCGcHb+M8Wk6F3+yBI8V0a4=;
        fh=vNhGbl2Lz6lBqA/djJldu8YRf1P0tmOuVZXuoSOpWy0=;
        b=cT5Lg8FQ5OVd1O3QquPnTSbYQCIwtwW2TIY6V6mWnUyE9yQDC/cr/1Qr2gNVA6A1a9
         70zGVQzQLdz3gGlCcnoH9Qgk8zFe/epunMx29XnJeY4eCjrKTMfDG231c7qkyHUamgxc
         uoihljsqdcKvqA5raWK4FF0tXJzqExRT+bd/LHpzIo2NQOv7ZYJJy+OIuDzLTOejfnnm
         C8BawGWf0aic47iu4p1OeDsW5kPQ+GxlmtbFIGv38JWbJrbCRoJNtgd3sSqjuITwlfD/
         Sxun+rprg2t/7+Ou/P6B77JvzYfs0Op5pndUGBHsBkMYKccFcoD8LZI/KjP/h0cLCRkZ
         30IA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789068677; x=1789673477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0V/f5lIKQxwY8UDJZpxZzCGcHb+M8Wk6F3+yBI8V0a4=;
        b=bTyEgftUWKIopOFjcUBu/2KhyIikGf6Tu1DDL0wwWwCBeQuNHF/DSagivn5/pmOxO7
         7U3doG7W3kvzWMO81f7YlZLMiqtOrQn+32PUDrNIvj1XSYRFFssQku8mVpwT4BpPosUh
         fthi9hb+NCnSppkJTfPLCdYDX4XPhZNirMuLoetNJ94VKcUTmcWKEKom5ZrXrnpZWz05
         o7fTBpSEzeel1qee7ZQtEsF70qdoJyYaVODAa9dyKgK/T9kZYZkONNztop09xD3tmWE3
         Wzau4bN9ObZjURUtR5SxNOFmLx8E8KvX4d3FsBh7p2CB6idxd89ebwg7gc+nBHEXwteD
         oVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789068677; x=1789673477;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0V/f5lIKQxwY8UDJZpxZzCGcHb+M8Wk6F3+yBI8V0a4=;
        b=lI2lwK5nbSMYlKAB8g65v9IXXrr6yHGuQUTbDpBYKINZ1K+/y+S4IggoFUeXlPYR2z
         jHRwQPFiNfIerdMQQp8Zp3HHXcfsdY+oO6g3TRXyh1zyjsjq5uelXW+QoBaEBC9SisaJ
         KeWxOlgLCq1qUDdfqy/X7xE9hoUa+XSjkAhwYq6+hgRyVsnfFVSnR3J66XiRrMP5wWND
         m4IyRkvzYDihQhJr9duaiMQmZG9EiBfAqxAiRMwZf71AzqwO/EVt3ZxbkU2ENbrNCqnv
         t43lDGpp6ZKdNEHSfqBmtF7k0Mt+/QW0AqSGUFxOAUNf/mYCWxr+tz74Yx+3jwxYGtop
         qQjw==
X-Forwarded-Encrypted: i=1; AKwUvBz/IW14LE/VmebghlBjNmtSzcEJbvXK9+GRVdAEfxlOkz2PfxTERuD1vMcjnIqPxNUsccJmrkIMnEqoKvCTh18=@vger.kernel.org
X-Gm-Message-State: AFuF++mdrj7GEVgRvC8S0v8iZLMlTrgSA+qNDWJsW91OdbGsip5TEB4J
	6DA+5yL/dw3NgtRuPpAICJkcMG0rzDJIEg3yYUln4Jfmzn0Si661OSgB//1k2uMzDOHhcb0VLt8
	PjDBb3+ZmvenFRxL6RplkomW9vbw1fF8+do+J9ck=
X-Gm-Gg: AYBFou30JBVyyrTT7ae5c5BM8+B1jf7eGtWGFvB/2psQrj67SYGMMSSZRSHXJluUyGM
	ZsxOa6yhryGf+jwYOBYS7WQtvX9MWEyOLt31Qkg2uLO/o+0IDUhOFLs05V64oPj4J52KGgXIbR6
	0cHd8rlprDT1KH2isMZcABVNoto1+XM/GEoK8UEW5JR0bUEQ0wxCEOGMDVkERcw8PxZR+JfVmAV
	QNprnKy9MoUaTnyY0yAT9RzQMGR7EyUikew5cfnCUv/BMZG3gm024urQl80lw8MXiCl/3cJXMwa
	0dl9wJ4lczMnA/UN0B3s3LZ8bGcOy3nl4P5QTvpoMHaLWvli2+Xnd5WjRfk0TLYKmoWx4P5qY+q
	bq2YdqKeHWqjzXgDq1NKDrgFjAwFW/fKc312EwaUAUgly+mr70PCm
X-Received: by 2002:a05:6122:3417:b0:5c8:3122:ac47 with SMTP id
 71dfb90a1353d-5c8462b2288mr1910205e0c.5.1789068676639; Thu, 10 Sep 2026
 12:31:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823123549.1120133-1-morbo@google.com> <20260823123549.1120133-3-morbo@google.com>
 <aosNst7K9zaClFEH@google.com>
In-Reply-To: <aosNst7K9zaClFEH@google.com>
From: Bill Wendling <morbo@google.com>
Date: Thu, 10 Sep 2026 12:30:59 -0700
X-Gm-Features: AcwNN1UAFW8O5KEENv3dVtojFZT_CRKAdk5AOtP2XF5VqSdFHqLVOslXBPVUWeo
Message-ID: <CAGG=3QX5PQSioCK+5kM5wZvtYoa7iKrRFtPuwvX2d06C2kw-iQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib/tests: Add KUnit test for struct stack_trace
 __counted_by_ptr attribute
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Ryota Sakamoto <sakamo.ryota@gmail.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Dmitry Antipov <dmantipov@yandex.ru>, 
	Petr Mladek <pmladek@suse.com>, Kir Chou <note351@hotmail.com>, 
	codemender-patching+linux@google.com, linux-hardening@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kuan-Wei,

On Sun, Aug 23, 2026 at 8:11=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmail.com=
> wrote:
>
> Hi Bill,
>
> On Sun, Aug 23, 2026 at 12:35:33PM +0000, Bill Wendling wrote:
> > Add a custom KUnit test suite 'stacktrace_counted_by' to verify that th=
e
> > __counted_by_ptr annotation on the 'entries' field of 'struct stack_tra=
ce'
> > behaves correctly.
> >
> > The test verifies that 'max_entries' correctly limits and validates acc=
ess
> > to 'entries' when CONFIG_ARCH_STACKWALK is not defined. If it is define=
d,
> > the test is cleanly skipped at runtime to prevent compile-time or runti=
me
> > failures due to 'struct stack_trace' being undefined on modern
> > architectures.
> >
> > Assisted-by: Gemini Next
> > Signed-off-by: Bill Wendling <morbo@google.com>
> > ---
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > Cc: David Gow <david@davidgow.net>
> > Cc: Rae Moar <raemoar63@gmail.com>
> > Cc: Ryota Sakamoto <sakamo.ryota@gmail.com>
> > Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
> > Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Cc: Dmitry Antipov <dmantipov@yandex.ru>
> > Cc: Petr Mladek <pmladek@suse.com>
> > Cc: Kir Chou <note351@hotmail.com>
> > Cc: codemender-patching+linux@google.com
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-hardening@vger.kernel.org
> > Cc: linux-kselftest@vger.kernel.org
> > Cc: kunit-dev@googlegroups.com
> > Cc: linux-hardening@vger.kernel.org
> > ---
> >  lib/Kconfig.debug            | 10 +++++++
> >  lib/kunit/.kunitconfig       |  1 +
> >  lib/tests/Makefile           |  1 +
> >  lib/tests/stacktrace_kunit.c | 51 ++++++++++++++++++++++++++++++++++++
> >  4 files changed, 63 insertions(+)
> >  create mode 100644 lib/tests/stacktrace_kunit.c
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index e97bdf3a42a8..51a6ac1a2461 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2716,6 +2716,16 @@ config BITOPS_KUNIT
> >
> >         If unsure, say N.
> >
> > +config STACKTRACE_KUNIT_TEST
> > +     tristate "KUnit test for stacktrace counted_by attribute" if !KUN=
IT_ALL_TESTS
> > +     depends on KUNIT
> > +     default KUNIT_ALL_TESTS
> > +     help
> > +       This option enables the KUnit test for verifying the __counted_=
by_ptr
> > +       attribute on struct stack_trace.
> > +
> > +       If unsure, say N.
> > +
> >  config BITFIELD_KUNIT
> >       tristate "KUnit test bitfield functions at runtime" if !KUNIT_ALL=
_TESTS
> >       depends on KUNIT
> > diff --git a/lib/kunit/.kunitconfig b/lib/kunit/.kunitconfig
> > index 9235b7d42d38..b3761b41459e 100644
> > --- a/lib/kunit/.kunitconfig
> > +++ b/lib/kunit/.kunitconfig
> > @@ -1,3 +1,4 @@
> >  CONFIG_KUNIT=3Dy
> >  CONFIG_KUNIT_TEST=3Dy
> >  CONFIG_KUNIT_EXAMPLE_TEST=3Dy
> > +CONFIG_STACKTRACE_KUNIT_TEST=3Dy
> > diff --git a/lib/tests/Makefile b/lib/tests/Makefile
> > index 4ead57602eac..40875e729fc8 100644
> > --- a/lib/tests/Makefile
> > +++ b/lib/tests/Makefile
> > @@ -6,6 +6,7 @@
> >  CFLAGS_bitfield_kunit.o :=3D $(DISABLE_STRUCTLEAK_PLUGIN)
> >  obj-$(CONFIG_BASE64_KUNIT) +=3D base64_kunit.o
> >  obj-$(CONFIG_BITOPS_KUNIT) +=3D bitops_kunit.o
> > +obj-$(CONFIG_STACKTRACE_KUNIT_TEST) +=3D stacktrace_kunit.o
> >  obj-$(CONFIG_BITFIELD_KUNIT) +=3D bitfield_kunit.o
> >  obj-$(CONFIG_BITS_TEST) +=3D test_bits.o
> >  obj-$(CONFIG_SHDI3_KUNIT_TEST) +=3D shdi3_kunit.o
> > diff --git a/lib/tests/stacktrace_kunit.c b/lib/tests/stacktrace_kunit.=
c
> > new file mode 100644
> > index 000000000000..7ec48edf84fe
> > --- /dev/null
> > +++ b/lib/tests/stacktrace_kunit.c
> > @@ -0,0 +1,51 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * KUnit test for struct stack_trace counted_by attribute.
> > + */
> > +
> > +#include <kunit/test.h>
> > +#include <linux/stacktrace.h>
> > +
> > +#ifndef CONFIG_ARCH_STACKWALK
> > +static void test_stack_trace_counted_by(struct kunit *test)
> > +{
> > +     unsigned long entries_buf[4];
> > +     struct stack_trace trace =3D {
> > +             .entries =3D entries_buf,
> > +             .max_entries =3D 4,
> > +     };
> > +
> > +     KUNIT_EXPECT_EQ(test, trace.max_entries, 4U);
> > +     KUNIT_EXPECT_PTR_EQ(test, trace.entries, (unsigned long *)entries=
_buf);
> > +
> > +     /* Write to the allocated elements to verify access */
> > +     trace.entries[0] =3D 0xdeadbeef;
> > +     trace.entries[1] =3D 0xbeefcafe;
> > +     trace.entries[2] =3D 0xcafebabe;
> > +     trace.entries[3] =3D 0x12345678;
>
> This only does in bounds array writes.
> To test __counted_by_ptr, I thought we were supposed to intentionally
> trigger an out of bounds access and see if it actually catches the
> error?
>
True. This is testing only that the existing behavior doesn't fail
with the new attribute. It looks like you're not the only one to
comment on this, though...

-bw

> > +
> > +     KUNIT_EXPECT_EQ(test, trace.entries[0], 0xdeadbeefUL);
> > +     KUNIT_EXPECT_EQ(test, trace.entries[1], 0xbeefcafeUL);
> > +     KUNIT_EXPECT_EQ(test, trace.entries[2], 0xcafebabeUL);
> > +     KUNIT_EXPECT_EQ(test, trace.entries[3], 0x12345678UL);
> > +}
> > +#else
> > +static void test_stack_trace_counted_by(struct kunit *test)
> > +{
> > +     kunit_skip(test, "CONFIG_ARCH_STACKWALK is enabled, struct stack_=
trace is not defined");
> > +}
> > +#endif
> > +
> > +static struct kunit_case stacktrace_test_cases[] =3D {
> > +     KUNIT_CASE(test_stack_trace_counted_by),
> > +     {}
> > +};
> > +
> > +static struct kunit_suite stacktrace_test_suite =3D {
> > +     .name =3D "stacktrace_counted_by",
> > +     .test_cases =3D stacktrace_test_cases,
> > +};
> > +
> > +kunit_test_suite(stacktrace_test_suite);
> > +
> > +MODULE_LICENSE("GPL");
> > --
> > 2.55.0.860.g4b6b3295ed-goog
> >
