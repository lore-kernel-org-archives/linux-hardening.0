Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375163DEACE
	for <linux-hardening@vger.kernel.org>; Thu,  3 Sep 2026 20:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788466911; cv=pass; b=DPPnGwzom0XF1LPEPKSPOtDdsdN8GcmnC4SIPPaGrsH0yzMOlvwR6Pz6S00+eWuJsi2rFtm8EqqodJHVLJdm7N4wY7BMbE720pfFFJTU8b9Rnt2wZLCSL2yBdYTzaQDprwYtjgGeg5a28uaGKibB58jV/c2O3xoYdK+Xn9Uw2pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788466911; c=relaxed/simple;
	bh=PyUk7dPklxEhkUtcbl82qTDv8pA5zLS1m8QXhpVq89w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SR4G89BuTLVyfBWn90Dih/P2K8NFsyk4L5CMssLKK53kV3/4gpjNsQ9J8NNv8pppM8hAR5zrHweEjyR0tSCbzPENp8B+TIXWL7JgmEIVCubZewMB2gCFNzUpnQco7StYKINVMDAFZV3mc61LEK+3yDPbdA20WWabmRNi2uh9jXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BD3DqlYH; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BD3DqlYH"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-97cad2f51edso126107241.1
        for <linux-hardening@vger.kernel.org>; Thu, 03 Sep 2026 13:21:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788466905; cv=none;
        d=google.com; s=arc-20260327;
        b=ZLZyXlmYWWmEGJrTEOEsgIrPJCt0518iNSTkCMbRN2WjACS4mSjnYBQUYwVGuhWWrY
         AU3Bf/WvWSHSfnIoWdg+38Ly9vuOxHB+YGdZWoY5EZ4OSuAgk7XJhfhy0CqpQFc9C0+w
         RoWgpxFlmitYNgEz+bmLZ7djM5emMThKcyqPwyuMUkGy9J84BBCRyzhG8ktOnmYmTWie
         1IIRjDJSazQhntrt345eoqm1ArIOMelQ6tyi1UzyWaMt9qXanNUdT9ET3seMxYhxJEdN
         wdo1EF4GCfaKleCvgCuKrZ3NbD4MyGH97yAvZJ4NZ+SACH3Te+YP0XZx/+9xm812DMUK
         uAig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vLgvA4QTKZdSCcOzS4gTC8wIW0gAJimEFKqog0B2CCg=;
        fh=AhDyrKJ6RhqlnW5daLd4iGE9Wsk8ajyX+hFwo431g5o=;
        b=R0CMDJthcSXTwDfS4pOLDsDlLFx7mTDrQEaoRkXt23TBI9tfsvRWZ+HuUsvAqQHU0V
         Z8WOzI+bezfPJ9JcFtHvwQwBrbr1+Jf6Si/CsbBWEQkso1ell7OcNk9vUzBUjndeN1cd
         RI83RR2weqixTfXqi14JoC4VtnEeOxBGbowPZRqvWkZmq/VOWH3MQEzjfdBVvFUvUtSL
         AVJpMsrpHzvozebXVmBQ9iZmiTH5wwj7TnGBBZfSQFRwa0/7yBl5h5Rz3WY+5TPy36SO
         4s+QfYTxZBtkJ7y0I9QQxOmTtubKrCFnaHogWI6b5aeOiyr+u9uKdOp55YxWv3cixg45
         ytBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788466905; x=1789071705; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vLgvA4QTKZdSCcOzS4gTC8wIW0gAJimEFKqog0B2CCg=;
        b=BD3DqlYHvGhvFudcKm3AYjuLNBGgwKMPhiaQ3gneX0yeAeGxq6zvHzZylWSjWP9ytU
         06HzkXsKKgvJD2QwwByESi/CjVjT5csJX4z4iwi5SGf9JwW3H6DVpf1LjV/LhqAAmMhb
         cA7kAoGw9PdeKIA6qoroy6sJrzuklLmBV7Jy70xi1VSUUuRPDEO/qvhWhUEChoHEvMGp
         6IKHRKRX76zZGizk+t8a4sBN0vkunjnRYznxndHRX2LQ0VcL0entehs6dnw6DIFzntmF
         CIkOqf3ud4aFBxBQF/J9+4Kdz5EDnOk+gUo2h0xjDExdG2Js7o4X6P5vcJ6TA5Xdz9TL
         pXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788466905; x=1789071705;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vLgvA4QTKZdSCcOzS4gTC8wIW0gAJimEFKqog0B2CCg=;
        b=ifmqX67lXFBj13zXbPbgS9tA+4hva9eyR2W6+rsgf9xqzgTtEaYG3qPHXp6M7CI9PQ
         19x6h8E4Mct7T7t/jQ9WGZoO9436DObvQINdv9w/z0Y3IS4St+A/fMayHXdBeJ1a0XgX
         UF/f77RFq/+QpXBVEmGrFuS9SjzH17R4WGdnYxQzgAfvuXW0/6j48jhjmILEKJw56Uk9
         lKAvMyHpYINIHroOXr66LvrpNybc9qVlraV9ER3o+bxby7bBQmL8gRHR3JhSKSghKCsB
         9z8mlsVQrR9zAgdKKQPmzwaMQaPthTaVm6i86/w1u1IY2gAbmMq3UhYu+oVOIuD5lxJQ
         nXfw==
X-Forwarded-Encrypted: i=1; AKwUvBzCBbak2NEcUiDNr748OPZ6SFSk/mvCaTH/XKX2fmYmCfH1jjHEUpNExo5gZSpClaGXgc7fVEnGYjCB/rj65iw=@vger.kernel.org
X-Gm-Message-State: AFuF++m6qP9Ypm0WzN9wBhKiwGQz6rZnEGIW9f3zySlBoDsKDYXns0v7
	uLAsgdfW9wz1vTDhYFaWaEklzdsCK2/1eKuIMky3v6MaWGbGtscAfoFu4z0gelhGd0kcxg8f+v4
	tn/dplq2LT6Cbu/IV9TXDMLBcP/o+4lsBt5al1AY=
X-Gm-Gg: AYBFou29EMt7/7wGBtt3ez070kLiAl7Pddujdm54DWd/+aSoRhoWrzHBBJU00E6CZ0H
	wgv0i3B7btFQ4zVi/ftIlYumnwHIEPegbZ8ZYmVA23+k9Rmr8fSCQdMuwbRrbICGibMIfIQtAEt
	eAPoLjQM5ZcRAGW9s40gGxhHONAT0HXkiFsfGIT6hDgairOwp3T9ZfW7rtJ+e0KHqTzMhT8cO+U
	I2JO3JxsvaXGU8xrVnajtX0rHKuUcjiLXmi2wVAwmdAnxqPOzb0C1BWE3L+HLfXXKxiMFlF9FRo
	Jz0mLQZeUT1zuK9mO30644wPX5jxGPMiETIAiXZGnPHtMENKE6LDPxJgRK6OycN1yKnkS66WrRO
	AqyBd+ItxCCRhibLwHoEo+Wo=
X-Received: by 2002:a05:6102:f83:b0:784:94dd:5389 with SMTP id
 ada2fe7eead31-78a4a9ae110mr80134137.13.1788466904069; Thu, 03 Sep 2026
 13:21:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823125155.1136740-1-morbo@google.com> <20260826220041.4075333-1-morbo@google.com>
 <20260826220041.4075333-2-morbo@google.com> <20260827152612-d0c71c10-cbe5-49f3-9be0-47eb76cd9b48@linutronix.de>
 <CAGG=3QWPTL5z8MfAxJLpHb0P-3Ah6K+FzgrVHyRRcvRK7-6dSA@mail.gmail.com> <20260831111423-400ed79e-6e52-438c-aa9f-f289e6dbdee5@linutronix.de>
In-Reply-To: <20260831111423-400ed79e-6e52-438c-aa9f-f289e6dbdee5@linutronix.de>
From: Bill Wendling <morbo@google.com>
Date: Thu, 3 Sep 2026 13:21:27 -0700
X-Gm-Features: AcwNN1XP00v4tFGN6klmPHo3hds0yY-HICFv79g9BKD1nI6HXGiJHkhzYnQqYRU
Message-ID: <CAGG=3QUAY4BDiJM64uTX8C1A2WPg6dPRexbgUQZoi4QKkkpP9Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] userns: Add KUnit test suite for uid_gid_map
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Bradley Morgan <brads@mainlining.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
	Douglas Anderson <dianders@chromium.org>, Anand Moon <linux.amoon@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, codemender-patching+linux@google.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Mon, Aug 31, 2026 at 2:22=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Hi Bill,
>
> On Thu, Aug 27, 2026 at 12:27:30PM -0700, Bill Wendling wrote:
> > On Thu, Aug 27, 2026 at 6:37=E2=80=AFAM Thomas Wei=C3=9Fschuh
> > <thomas.weissschuh@linutronix.de> wrote:
>
> (...)
>
> > > > +config USER_NAMESPACE_KUNIT_TEST
> > > > +     bool "Test user namespace map insertion" if !KUNIT_ALL_TESTS
> > > > +     depends on KUNIT=3Dy
> > >
> > > Urgh.
> > >
> > ?? What's wrong? It's identical to the conditional for EXEC_KUNIT_TEST:
>
> Sorry for this non-descript review comment.
>
> > config EXEC_KUNIT_TEST
> >      bool "Build execve tests" if !KUNIT_ALL_TESTS
> >      depends on KUNIT=3Dy
> >      default KUNIT_ALL_TESTS
> >      help
> >           This builds the exec KUnit tests, which tests boundary condit=
ions
> >           of various aspects of the exec internals.
>
> The problem is that KUNIT can be built as module, which would prevent thi=
s
> test from being built. We have include/kunit/visibility.h to export certa=
in
> symbols only to tests and avoid this issue.
> But I can see that some maintaines don't like this pattern, so maybe they=
 can
> chime in at some point.

Bradley commented on this earlier (which is why I mentioned EXEC_KUNIT_TEST=
):

<comment>
The test is #include'd into user_namespace.c, which is builtin (USER_NS
is a bool), so =3Dm here still compiles the suite into vmlinux. With
KUNIT=3Dm that calls kunit symbols that live in a module, and the link
fails. Make it bool and depend on KUNIT=3Dy, like EXEC_KUNIT_TEST:

 bool "KUnit test for user namespace map insertion" if !KUNIT_ALL_TESTS
 depends on USER_NS && KUNIT=3Dy
</comment>

So there's a conflict and, because I'm not a KUnit guru, I'm not sure
which way is "best".

> > > > +     default KUNIT_ALL_TESTS
> > > > +     help
> > > > +       This builds the KUnit test for user namespace uid/gid map i=
nsertion.
> > > > +       It validates map insertion, limits, dynamic allocation of t=
he
> > > > +       extended extents array, and mapping sorting functions.
> > > > +       If unsure, say N.
> > > > +
> > > >  config PID_NS
> > > >       bool "PID Namespaces"
> > > >       default y
> > > > diff --git a/kernel/.kunitconfig b/kernel/.kunitconfig
> > > > new file mode 100644
> > > > index 000000000000..7314dce05dc2
> > > > --- /dev/null
> > > > +++ b/kernel/.kunitconfig
> > > > @@ -0,0 +1,3 @@
> > > > +CONFIG_KUNIT=3Dy
> > > > +CONFIG_USER_NS=3Dy
> > > > +CONFIG_USER_NAMESPACE_KUNIT_TEST=3Dy
> > > > diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> > > > index 786dbf0506ca..0e7373085af9 100644
> > > > --- a/kernel/user_namespace.c
> > > > +++ b/kernel/user_namespace.c
> > > > @@ -1417,3 +1417,7 @@ static __init int user_namespaces_init(void)
> > > >       return 0;
> > > >  }
> > > >  subsys_initcall(user_namespaces_init);
> > > > +
> > > > +#if IS_ENABLED(CONFIG_USER_NAMESPACE_KUNIT_TEST)
> > > > +#include "user_namespace_kunit.c"
> > > > +#endif
> > > > diff --git a/kernel/user_namespace_kunit.c b/kernel/user_namespace_=
kunit.c
> > > > new file mode 100644
> > > > index 000000000000..88467361efdf
> > > > --- /dev/null
> > > > +++ b/kernel/user_namespace_kunit.c
> > > > @@ -0,0 +1,92 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * KUnit test for user namespace map insertion and sorting.
> > > > + */
> > > > +
> > > > +#include <kunit/test.h>
> > > > +#include <linux/user_namespace.h>
> > > > +
> > > > +static void test_user_ns_map_insert_base(struct kunit *test)
> > > > +{
> > > > +     struct uid_gid_map map;
> > > > +     struct uid_gid_extent extent;
> > > > +     int i, ret;
> > > > +
> > > > +     memset(&map, 0, sizeof(map));
> > > > +
> > > > +     /* Insert up to UID_GID_MAP_MAX_BASE_EXTENTS (5) elements */
> > > > +     for (i =3D 0; i < UID_GID_MAP_MAX_BASE_EXTENTS; i++) {
> > > > +             extent.first =3D i * 10;
> > > > +             extent.lower_first =3D i * 100;
> > > > +             extent.count =3D 5;
> > > > +
> > > > +             ret =3D insert_extent(&map, &extent);
> > > > +             KUNIT_ASSERT_EQ(test, ret, 0);
> > > > +             KUNIT_EXPECT_EQ(test, map.nr_extents, i + 1);
> > > > +             KUNIT_EXPECT_EQ(test, map.extent[i].first, i * 10);
> > > > +             KUNIT_EXPECT_EQ(test, map.extent[i].lower_first, i * =
100);
> > > > +             KUNIT_EXPECT_EQ(test, map.extent[i].count, 5);
> > > > +     }
> > > > +}
> > >
> > > The extended test below already tests everything the 'base' one does.
> > > Do we need both?
> > >
> > The one below tests the sorting algorithm.
>
> It *also* tests the insertion, no?
> (Especially if the conditional on UID_GID_MAP_MAX_BASE_EXTENTS is removed=
)
>
Correct. So there are three types of tests we should run here:

1. Insertions and accesses that don't go over the initial extents size.
2. Insertions and accesses that do go over the initial extents size.
3. Accesses outside of the number of entries.

Test (1) is a "smoke" test, where the struct is tested and no
sanitizer code is used. Test (2) makes sure that we can still go over
the UID_GID_MAP_MAX_BASE_EXTENTS size and the sanitizer won't
activate. Test (3) (which I'll add in my next upload) throws a
sanitizer exception.

> > > > +     for (i =3D 0; i < 10; i++) {
> > > > +             int value =3D 9 - i;
> > > > +
> > > > +             extent.first =3D value * 10;
> > > > +             extent.lower_first =3D value * 100;
> > > > +             extent.count =3D 5;
> > > > +
> > > > +             ret =3D insert_extent(&map, &extent);
> > > > +             KUNIT_ASSERT_EQ(test, ret, 0);
> > > > +             KUNIT_EXPECT_EQ(test, map.nr_extents, i + 1);
> > > > +
> > > > +             if (i < UID_GID_MAP_MAX_BASE_EXTENTS) {
> > > > +                     KUNIT_EXPECT_EQ(test, map.extent[i].first, va=
lue * 10);
> > > > +             } else {
> > > > +                     KUNIT_EXPECT_EQ(test, map.forward[i].first, v=
alue * 10);
> > > > +                     KUNIT_EXPECT_EQ(test, map.forward[i].lower_fi=
rst, value  * 100);
> > > > +                     KUNIT_EXPECT_EQ(test, map.forward[i].count, 5=
);
> > > > +             }
> > > > +     }
> > > > +
> > > > +     /* Now sort the map to set up reverse mapping */
> > > > +     ret =3D sort_idmaps(&map);
> > > > +     KUNIT_EXPECT_EQ(test, ret, 0);
> > > > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, map.reverse);
> > > > +
> > > > +     /* Verify sorting is correct */
> > > > +     for (i =3D 0; i < map.nr_extents; i++) {
> > > > +             KUNIT_EXPECT_EQ(test, map.forward[i].first, i * 10);
> > > > +             KUNIT_EXPECT_EQ(test, map.forward[i].lower_first, i *=
 100);
> > > > +             KUNIT_EXPECT_EQ(test, map.forward[i].count, 5);
> > > > +
> > > > +             KUNIT_EXPECT_EQ(test, map.reverse[i].first, i * 10);
> > > > +             KUNIT_EXPECT_EQ(test, map.reverse[i].lower_first, i *=
 100);
> > > > +             KUNIT_EXPECT_EQ(test, map.reverse[i].count, 5);
> > > > +     }
> > >
> > > Isn't this the same as the original order?
> > >
> > No. The original order uses "9 - i" for the base value, so it's not in
> > sorted order (though it's not exactly random either).
>
> Indeed, sorry for missing this.
> If you send a new revision, maybe add a small comment.
>
Ack.

-bw
