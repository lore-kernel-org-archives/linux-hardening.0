Received: from mail-ua2-f32.google.com (mail-ua2-f32.google.com [74.125.226.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EFC2D8762
	for <linux-hardening@vger.kernel.org>; Tue, 29 Sep 2026 06:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.224
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664807; cv=pass; b=pAUOcrFjP7cITBmiBxSypBYR/DeGpWR5E2Zd3g+iesHlGnRo516bgx3WeOelLkSzYtafBXQBZNjessJwPumDbiey8+fJwUUmhbWHToldIYTK3BI9NdBCrE3N0xbBuQoJrnbu3Ml36tXxW9h6Jb9ZdTYqYIo4oyDJaBvRZ5HbAVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664807; c=relaxed/simple;
	bh=EfP/d5Y49xviNaxKDhrOQcTd1OI9sI7yXtVqUJTZqNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISiDCXAHnMLvvaGe/4A5xZRXrv/pb08ZG8APIamNVSjB7DM2UIB6X8xVuzUSWWzs+58j1oYq4cBaTwBXcCHrOGhgJoSvtvdwAyD5RXWcGteM2mBb4JA9KtdRPLt3PBprb0AoUpPQKT90dZK6aM6y0G5FzPMUR8NVv+jYi3XkYzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RA51Z3Dp; arc=pass smtp.client-ip=74.125.226.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RA51Z3Dp"
Received: by mail-ua2-f32.google.com with SMTP id a1e0cc1a2514c-97e97e2c7d4so2148247241.1
        for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 23:53:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790664805; cv=none;
        d=google.com; s=arc-20260327;
        b=q8TrVDuq9NZ48nuKU726fvIsUB7gCieK8usm/xYQi8JYAfeaift9+YE2tdIvyzqRSr
         3YYJeGPpwqJVmk/7D7tfXr6tAZ0b5bThMTZ6nJoYvtFdoOwg/WG3aAzh5kTMhdctN3V9
         PzeU67JUdH1Pb+9H4asvqqIav9D7s4u2hjZntgtkxXKJse2+BIOcuKb1vuZVcOOwbain
         hCz9Krm4ATuNLwQhJ59QoZ3vzYwtXUyqKLBEUDS2S5KShPSHrvzG7tx+v7nlQYt4dFSn
         iNTrb/2Yg6h2PiTDepvYedCcKaLVCXB3N/Vle8TWuhTnFGbIszYERHLaykKgwTgf0TIi
         G6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dXZNNhcaPyXqA+zSRw2siBSAi+AcqonBzV+S3T5CpzY=;
        fh=5FJFOxm6aeLRMpcot6fJFJhuVvrEwajOHDp12TUccPY=;
        b=ZuzCEgDHpvoASIJPNbh5VNuxoQkzZ4VCf/3Ia5nWZy4GxkGlhupk52UVobGX9TnbfW
         ZviAAnHBIc2iEhq5nSKqdbZ2XdO+vAYMb/com2OLD6TwQrUVOSRPavo0wDtbaas2kZ6G
         C+7nKb/VHGCdatcIilvAHtOkE1ZSfTPZBos0/PU8EAcJAdVTFjt8XRrugCY8cVsHglw3
         Gn7yl4dh8F+xcDv8XHCMKTueY0fTQnXcAzd0CJNly1+y/8p+76FUbz0vPYL86a3ip1TU
         Bz17Z0chOvAISb4t1McX+tey9yfKjH93diXrJ1SPnhKU76+qvIXlnlt4mNKnz8239oen
         qN1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790664805; x=1791269605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dXZNNhcaPyXqA+zSRw2siBSAi+AcqonBzV+S3T5CpzY=;
        b=RA51Z3Dpl6NjuuVdtHkqh2HWesiJrEA0riCy61M+YOqGqvmRkUyWhsbfMktlAs0Jxq
         qyeJeEaVOkM6bgvFPCm8u6uKpJ3RHtXC0ydcXNC6oGXDevwfMHOrXjg1fGphllqiSgL4
         N270MKMB/EPXi6QVTLiJXsaK+5RF0WaSKIxqVpePATVT2OAzsEv0wrHmYfYTkGuAZxw+
         7AFo3akJcH3Bma5SvDH+y4LaBaKTluSk38Xbflvnkk+w12Q0xp8s7nC7hVGL7DQru2Tg
         yVPIRv8UfO6rxh4z1lT4C5h4KYUxwZO8CNEzFVq+Im+gfOsB4ksnMLBwg/twg0S1t7ql
         mCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790664805; x=1791269605;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dXZNNhcaPyXqA+zSRw2siBSAi+AcqonBzV+S3T5CpzY=;
        b=kzSsQEBrdK2aFWWjTeyiM6A1WbtD+RHZ3qSIJcbhGF5clTElS9/bs+a5MbyEARENCu
         vgg+LXk7B1UfPQo8kqW4HHbtJaNPvGxhsK4rhTY21yvgVzpoWGRc/xzqh+HJDNbTppJB
         NPGEPBKhKeaJVyys0hqOSoukKKDvwh2X1fUPWjyQ2LZiRlt3XIHhPNylPt1NjDg/HvjD
         0NowYZTr1CPa4amc7NVO/kB9GAePmwL4U1PfS60k2fKB/a3KJzRByKxGUdV5clwttTRp
         wwGxpgF9cbU3SavSrbC1zwhylCvr24j/EIme5QSj89+/e7uQI7MCNl6Sfen6+zU21D3m
         zbBQ==
X-Forwarded-Encrypted: i=1; AKwUvBwVTJ5zJbHJMD88k9Q+JbZjHjS7r34vY7mVOOrA3L8l8IHFQsskLgyf+tF+Mk8Bxg3DJQOUQaUslmBR8lp5QWo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKrmTuaSLPEQIaezREf2xiZKUfCC/4Q8+MUouiTHg9B+0bZfRr
	q7RIl2OtkW7gMN06MNeUVg5apJod/Rs6UjogAzAlYOiehIqBT5OrSTBlKpZQ7aZwR4Gyk487qMj
	lQpBINouiQipRKJcHpXZRReSQNW78Q7QcafRIJG/XSdbIg+pRFd5QdTeJ9Q==
X-Gm-Gg: AYBFou2WN79GGz43RSvCtrYof+dBiRuXDBuW7cuAwDNPK37pYVp2RjGk6K0RwWNMXTe
	i+86Z/be+hU26G2f4NjtEIX+FR0tkVETC8EwStvTinpuouAuw3BiU5CnkKudi1dVMG01ReiVkmu
	lo4XjUxIrdtTAMtPvKniiWSxm/s4YIQQaTdmiGKNelbRRUHKIdxNm0+eyUCmTCrsWlZkye85xmQ
	mgsjm9kXN2k/t7KusfHQ/K/+QNT0JIEeagounm4xFVoMyNAQDcsc3/SU0Ip9tJ26m9ySDk/zG6O
	npX4sVlhk2/UI88RUAA/2oGp6eoulfQhoTrT8k+JZ25EdRfE1CnSXZFpYWOp2ypouAIJioSIBED
	bWgacB6Im77RK4rdBl518
X-Received: by 2002:a05:6102:5346:b0:79b:f57e:ea17 with SMTP id
 ada2fe7eead31-7af1c6921f0mr6195643137.3.1790664804262; Mon, 28 Sep 2026
 23:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928231737.2092716-1-morbo@google.com> <20260929010031.2186255-1-morbo@google.com>
 <20260929074930-f1e4add2-f8ca-43db-85fd-83be0e40c676@linutronix.de>
In-Reply-To: <20260929074930-f1e4add2-f8ca-43db-85fd-83be0e40c676@linutronix.de>
From: Bill Wendling <morbo@google.com>
Date: Mon, 28 Sep 2026 23:53:08 -0700
X-Gm-Features: AclHuK95_Ji_ujgZlHwbCN-2G8mT4XgLFj2k80q5CXF5eM05CshEFI-U1oGuQxM
Message-ID: <CAGG=3QXAb954ib3eGqci5NNs7pE3VEFgUBocRObqRSa4Z8sn_A@mail.gmail.com>
Subject: Re: [PATCH] fortify: add KUnit tests for __counted_by and __counted_by_ptr
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Mon, Sep 28, 2026 at 11:23=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Hi Bill,
>
> this looks much better. Thanks for the rework.
>
> On Tue, Sep 29, 2026 at 01:00:31AM +0000, Bill Wendling wrote:
> > The '__counted_by' and '__counted_by_ptr' attributes associate a
> > flexible array member or pointer member with a struct field that holds
> > its element count. Supporting compilers use these annotations to
> > compute dynamic object sizes via '__builtin_dynamic_object_size()' for
> > runtime bounds checking with CONFIG_FORTIFY_SOURCE.
> >
> > Add KUnit tests ('fortify_test_counted_by_flex' and
> > 'fortify_test_counted_by_ptr', guarded by CONFIG_CC_HAS_COUNTED_BY and
> > CONFIG_CC_HAS_COUNTED_BY_PTR respectively) to verify that:
> >
> >  - '__builtin_dynamic_object_size()' (both types 0 and 1) returns the
> >    expected logical byte size for annotated flexible array and pointer
> >    members.
> >  - Fortified operations ('memset()' and 'memchr()') succeed within the
> >    logical bounds and detect out-of-bounds read and write accesses
> >    beyond the annotated count.
> >
> > Allocate the test buffers with extra physical capacity (2 * size) in
> > 'noinline' helpers and hide the returned pointers with
> > OPTIMIZER_HIDE_VAR() so allocation-size attributes, physical slab
> > bounds, and compiler optimizations do not mask the '__counted_by' and
> > '__counted_by_ptr' checks.
> >
> > Signed-off-by: Bill Wendling <morbo@google.com>
> > ---
> > v2: Move tests to the 'fortify' KUnit tests. It uses UBSAN, which is
> >     what gets triggered by 'counted_by'.
>
> v2 is missing in subject.
>
Doh!

> > ---
> >  lib/tests/fortify_kunit.c | 119 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 119 insertions(+)
> >
> > diff --git a/lib/tests/fortify_kunit.c b/lib/tests/fortify_kunit.c
> > index 413cdbf3dc0d..2335171f84d8 100644
> > --- a/lib/tests/fortify_kunit.c
> > +++ b/lib/tests/fortify_kunit.c
> > @@ -1011,6 +1011,119 @@ static void fortify_test_kmemdup(struct kunit *=
test)
> >       kfree(copy);
> >  }
> >
> > +#ifdef CONFIG_CC_HAS_COUNTED_BY
>
> The ugly ifdeffery can be replaced by IS_ENABLED():
>
> if (!IS_ENABLED(CONFIG_FOO))
>         kunit_skip(test, "Not built with CONFIG_FOO=3Dy");
>
> It makes the code cleaner and gives some useful feedback at runtime.
>
Ah yes! This is much nicer. It'll also fix up the #ifdef stuff at the
end as well.

> > +struct counted_by_flex_struct {
> > +     size_t size;
> > +     int array[] __counted_by(size);
> > +};
> > +
> > +/*
> > + * Allocate the struct out-of-line with extra physical capacity so tha=
t
> > + * __alloc_size() and physical slab bounds do not mask the __counted_b=
y()
> > + * logical bounds check.
> > + */
> > +static noinline struct counted_by_flex_struct *
> > +alloc_counted_by_flex_struct(struct kunit *test, size_t size)
> > +{
> > +     struct counted_by_flex_struct *s;
> > +
> > +     s =3D kzalloc(sizeof(*s) + 2 * size * sizeof(s->array[0]), GFP_KE=
RNEL);
>
> kunit_kzalloc() to automatically free the allocation again.
> struct_size() for the size calculation.
>
Oh cool! done.

> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, s);
> > +
> > +     s->size =3D size;
> > +     return s;
> > +}
> > +
> > +static void fortify_test_counted_by_flex(struct kunit *test)
> > +{
> > +     size_t size =3D 128;
> > +     struct counted_by_flex_struct *s;
> > +     size_t elem_bytes =3D size * sizeof(s->array[0]);
> > +
> > +     s =3D alloc_counted_by_flex_struct(test, size);
> > +
> > +     OPTIMIZER_HIDE_VAR(s);
> > +     OPTIMIZER_HIDE_VAR(elem_bytes);
> > +
> > +     /* __builtin_dynamic_object_size() should return the logical leng=
th. */
> > +     KUNIT_EXPECT_EQ(test, elem_bytes,
> > +                     __builtin_dynamic_object_size(s->array, 0));
> > +     KUNIT_EXPECT_EQ(test, elem_bytes,
> > +                     __builtin_dynamic_object_size(s->array, 1));
> > +
> > +     /* Within-bounds write and read succeed. */
> > +     memset(s->array, 0x42, elem_bytes);
> > +     KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
> > +     KUNIT_EXPECT_NOT_NULL(test, memchr(s->array, 0x42, elem_bytes));
> > +     KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
> > +
> > +     /* Out-of-bounds write and read past logical size are caught. */
> > +     memset(s->array, 0x42, elem_bytes + 1);
> > +     KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
> > +     KUNIT_EXPECT_NULL(test, memchr(s->array, 0x42, elem_bytes + 1));
> > +     KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
> > +
> > +     kfree(s);
> > +}
> > +
> > +#ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
> > +struct counted_by_ptr_struct {
> > +     char *ptr __counted_by_ptr(size);
> > +     size_t size;
> > +};
>
> In the other structure the arguments where swapped, intentional?
>
Yes. It's a minor test to make sure that the attribute can refer to a
field that's defined after the pointer.

> > +
> > +/*
> > + * Allocate the struct out-of-line with extra physical capacity so tha=
t
> > + * __alloc_size() and physical slab bounds do not mask the __counted_b=
y_ptr()
> > + * logical bounds check.
> > + */
> > +static noinline struct counted_by_ptr_struct *
> > +alloc_counted_by_ptr_struct(struct kunit *test, size_t size)
> > +{
> > +     struct counted_by_ptr_struct *s;
> > +
> > +     s =3D kmalloc_obj(struct counted_by_ptr_struct);
>
> We should probably also get kunit_kmalloc_obj() at some point.
>
> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, s);
> > +
> > +     s->size =3D size;
> > +     s->ptr =3D kzalloc(2 * size, GFP_KERNEL);
> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, s->ptr);
> > +
> > +     return s;
> > +}
> > +
> > +static void fortify_test_counted_by_ptr(struct kunit *test)
> > +{
> > +     size_t size =3D 128;
> > +     struct counted_by_ptr_struct *s;
> > +
> > +     s =3D alloc_counted_by_ptr_struct(test, size);
> > +
> > +     OPTIMIZER_HIDE_VAR(s);
> > +     OPTIMIZER_HIDE_VAR(size);
> > +
> > +     /* __builtin_dynamic_object_size() should return the logical leng=
th. */
> > +     KUNIT_EXPECT_EQ(test, size, __builtin_dynamic_object_size(s->ptr,=
 0));
> > +     KUNIT_EXPECT_EQ(test, size, __builtin_dynamic_object_size(s->ptr,=
 1));
>
> Is this builtin guaranteed to be available?
> We have a wrapper KUNIT_EXPECT_BDOS() above.
>
I suppose not. I'll use the macros instead.

> > +
> > +     /* Within-bounds write and read succeed. */
> > +     memset(s->ptr, 0x42, size);
> > +     KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
> > +     KUNIT_EXPECT_NOT_NULL(test, memchr(s->ptr, 0x42, size));
> > +     KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
> > +
> > +     /* Out-of-bounds write and read past logical size are caught. */
> > +     memset(s->ptr, 0x42, size + 1);
> > +     KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
> > +     KUNIT_EXPECT_NULL(test, memchr(s->ptr, 0x42, size + 1));
> > +     KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
> > +
> > +     kfree(s->ptr);
> > +     kfree(s);
> > +}
> > +#endif /* CONFIG_CC_HAS_COUNTED_BY_PTR */
> > +#endif /* CONFIG_CC_HAS_COUNTED_BY */
> > +
> >  static int fortify_test_init(struct kunit *test)
> >  {
> >       if (!IS_ENABLED(CONFIG_FORTIFY_SOURCE))
> > @@ -1054,6 +1167,12 @@ static struct kunit_case fortify_test_cases[] =
=3D {
> >       KUNIT_CASE(fortify_test_memchr_inv),
> >       KUNIT_CASE(fortify_test_memcmp),
> >       KUNIT_CASE(fortify_test_kmemdup),
> > +#ifdef CONFIG_CC_HAS_COUNTED_BY
> > +     KUNIT_CASE(fortify_test_counted_by_flex),
> > +#ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
>
> The nesting of these conditionals looks unnecessary.
>

-bw

> > +     KUNIT_CASE(fortify_test_counted_by_ptr),
> > +#endif /* CONFIG_CC_HAS_COUNTED_BY_PTR */
> > +#endif /* CONFIG_CC_HAS_COUNTED_BY */
> >       {}
> >  };
> >
> > --
> > 2.56.0.rc1.315.gc6ed9934b7-goog
> >
