Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85BD3C1D7C;
	Mon, 31 Aug 2026 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168154; cv=none; b=m11cwLMdz2T8NLX8HW8xCwhfl21Pps6+tW7n54jl/pBp4xZS22EwfOgf95HN1HJWG+j2IOLiT9/8WE88wSo7CHfWArhKuVGbW4vNTnyGrIKhuJkbZkTuktiwDnePjqNJALrwwY9z3CnJcKNLRNVnwMs7dGNtHQOeUhpWho1kWxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168154; c=relaxed/simple;
	bh=ucZIBPy4M6sARQuTVbLdTuiTdAe4dKfS5/FNm3+jTII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCooi8cJge0T5/ozrtUF0Vl/awtW0z4H97Ig12JkhDBAD0ANMN4yeaTxIElgGcEyjE9LFGn9rc5lZQAW5OitFcbCKnJMwKQLIhsB1C/gFQ5tcDEvtZgsNC81h8WQrMmhR1XBezwac/Fmvp5lVVaTAtWPDSK/jdkOTcdDiNGcxh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nYqg3D2M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GmR90Pjz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nYqg3D2M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GmR90Pjz"
Date: Mon, 31 Aug 2026 11:22:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788168150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aPXgf1i/zG7AODG6tl1GNMhmF4xisHPp5K4YZ4E1r2g=;
	b=nYqg3D2MzDEH8Z29KM1Q+fUCDNQbYGtq3hq/pdLVEsTb9dX9Vz3AAt/TJZ3T0ArLtVQQhW
	t0yOzCwAzLAmHk6YIkc+7EvNqSk9SlWv6HAzeOzkYSJMvFDrOOKbGz3W4jA1nBOD7wrxnO
	RND08QZqVejAMY25oVb7AEUK9lpMImRLBekwBY5ukWP9AckUt1pTP63LtB3LlE33YbgCHY
	I0oPIrq9yd3TeZS9RMngt2XauFPa4tjmtilVEPvb1tj/Gni/QfaHyddQdImQzR8EBXo8FC
	Jt2SVYPYTLkag+kaSCw4zxj+2KzJdBK2t2SURXRl6yFGWu01EXIsog/IYWM0Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788168150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aPXgf1i/zG7AODG6tl1GNMhmF4xisHPp5K4YZ4E1r2g=;
	b=GmR90PjzgYSx5DrbjafN9H137SZVhKI/pTDUU/Gq/9MtDNMKqSt6F3OUvc0VWO3pwbsZQJ
	t7o1grxoGdW4Z9Bg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Bill Wendling <morbo@google.com>
Cc: Bradley Morgan <brads@mainlining.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
	Douglas Anderson <dianders@chromium.org>, Anand Moon <linux.amoon@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, codemender-patching+linux@google.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 2/2] userns: Add KUnit test suite for uid_gid_map
Message-ID: <20260831111423-400ed79e-6e52-438c-aa9f-f289e6dbdee5@linutronix.de>
References: <20260823125155.1136740-1-morbo@google.com>
 <20260826220041.4075333-1-morbo@google.com>
 <20260826220041.4075333-2-morbo@google.com>
 <20260827152612-d0c71c10-cbe5-49f3-9be0-47eb76cd9b48@linutronix.de>
 <CAGG=3QWPTL5z8MfAxJLpHb0P-3Ah6K+FzgrVHyRRcvRK7-6dSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGG=3QWPTL5z8MfAxJLpHb0P-3Ah6K+FzgrVHyRRcvRK7-6dSA@mail.gmail.com>

Hi Bill,

On Thu, Aug 27, 2026 at 12:27:30PM -0700, Bill Wendling wrote:
> On Thu, Aug 27, 2026 at 6:37 AM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:

(...)

> > > +config USER_NAMESPACE_KUNIT_TEST
> > > +     bool "Test user namespace map insertion" if !KUNIT_ALL_TESTS
> > > +     depends on KUNIT=y
> >
> > Urgh.
> >
> ?? What's wrong? It's identical to the conditional for EXEC_KUNIT_TEST:

Sorry for this non-descript review comment.

> config EXEC_KUNIT_TEST
>      bool "Build execve tests" if !KUNIT_ALL_TESTS
>      depends on KUNIT=y
>      default KUNIT_ALL_TESTS
>      help
>           This builds the exec KUnit tests, which tests boundary conditions
>           of various aspects of the exec internals.

The problem is that KUNIT can be built as module, which would prevent this
test from being built. We have include/kunit/visibility.h to export certain
symbols only to tests and avoid this issue.
But I can see that some maintaines don't like this pattern, so maybe they can
chime in at some point.

> > > +     default KUNIT_ALL_TESTS
> > > +     help
> > > +       This builds the KUnit test for user namespace uid/gid map insertion.
> > > +       It validates map insertion, limits, dynamic allocation of the
> > > +       extended extents array, and mapping sorting functions.
> > > +       If unsure, say N.
> > > +
> > >  config PID_NS
> > >       bool "PID Namespaces"
> > >       default y
> > > diff --git a/kernel/.kunitconfig b/kernel/.kunitconfig
> > > new file mode 100644
> > > index 000000000000..7314dce05dc2
> > > --- /dev/null
> > > +++ b/kernel/.kunitconfig
> > > @@ -0,0 +1,3 @@
> > > +CONFIG_KUNIT=y
> > > +CONFIG_USER_NS=y
> > > +CONFIG_USER_NAMESPACE_KUNIT_TEST=y
> > > diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> > > index 786dbf0506ca..0e7373085af9 100644
> > > --- a/kernel/user_namespace.c
> > > +++ b/kernel/user_namespace.c
> > > @@ -1417,3 +1417,7 @@ static __init int user_namespaces_init(void)
> > >       return 0;
> > >  }
> > >  subsys_initcall(user_namespaces_init);
> > > +
> > > +#if IS_ENABLED(CONFIG_USER_NAMESPACE_KUNIT_TEST)
> > > +#include "user_namespace_kunit.c"
> > > +#endif
> > > diff --git a/kernel/user_namespace_kunit.c b/kernel/user_namespace_kunit.c
> > > new file mode 100644
> > > index 000000000000..88467361efdf
> > > --- /dev/null
> > > +++ b/kernel/user_namespace_kunit.c
> > > @@ -0,0 +1,92 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * KUnit test for user namespace map insertion and sorting.
> > > + */
> > > +
> > > +#include <kunit/test.h>
> > > +#include <linux/user_namespace.h>
> > > +
> > > +static void test_user_ns_map_insert_base(struct kunit *test)
> > > +{
> > > +     struct uid_gid_map map;
> > > +     struct uid_gid_extent extent;
> > > +     int i, ret;
> > > +
> > > +     memset(&map, 0, sizeof(map));
> > > +
> > > +     /* Insert up to UID_GID_MAP_MAX_BASE_EXTENTS (5) elements */
> > > +     for (i = 0; i < UID_GID_MAP_MAX_BASE_EXTENTS; i++) {
> > > +             extent.first = i * 10;
> > > +             extent.lower_first = i * 100;
> > > +             extent.count = 5;
> > > +
> > > +             ret = insert_extent(&map, &extent);
> > > +             KUNIT_ASSERT_EQ(test, ret, 0);
> > > +             KUNIT_EXPECT_EQ(test, map.nr_extents, i + 1);
> > > +             KUNIT_EXPECT_EQ(test, map.extent[i].first, i * 10);
> > > +             KUNIT_EXPECT_EQ(test, map.extent[i].lower_first, i * 100);
> > > +             KUNIT_EXPECT_EQ(test, map.extent[i].count, 5);
> > > +     }
> > > +}
> >
> > The extended test below already tests everything the 'base' one does.
> > Do we need both?
> >
> The one below tests the sorting algorithm.

It *also* tests the insertion, no?
(Especially if the conditional on UID_GID_MAP_MAX_BASE_EXTENTS is removed)

> > > +
> > > +static void test_user_ns_map_insert_extended(struct kunit *test)
> > > +{
> > > +     struct uid_gid_map map;
> > > +     struct uid_gid_extent extent;
> > > +     int i, ret;
> > > +
> > > +     memset(&map, 0, sizeof(map));
> > > +
> > > +     /* Insert more than UID_GID_MAP_MAX_BASE_EXTENTS (e.g., 10) elements */
> >
> > When UID_GID_MAP_MAX_BASE_EXTENTS is ever increased, this might not be true anymore.
> > Add an assertion or make the iteration count dynamic.
> >
> Sure, I can make it something like "UID_GID_MAP_MAX_BASE_EXTENTS + 42"
> or something.

That sounds good.

> > > +     for (i = 0; i < 10; i++) {
> > > +             int value = 9 - i;
> > > +
> > > +             extent.first = value * 10;
> > > +             extent.lower_first = value * 100;
> > > +             extent.count = 5;
> > > +
> > > +             ret = insert_extent(&map, &extent);
> > > +             KUNIT_ASSERT_EQ(test, ret, 0);
> > > +             KUNIT_EXPECT_EQ(test, map.nr_extents, i + 1);
> > > +
> > > +             if (i < UID_GID_MAP_MAX_BASE_EXTENTS) {
> > > +                     KUNIT_EXPECT_EQ(test, map.extent[i].first, value * 10);
> > > +             } else {
> > > +                     KUNIT_EXPECT_EQ(test, map.forward[i].first, value * 10);
> > > +                     KUNIT_EXPECT_EQ(test, map.forward[i].lower_first, value  * 100);
> > > +                     KUNIT_EXPECT_EQ(test, map.forward[i].count, 5);
> > > +             }
> > > +     }
> > > +
> > > +     /* Now sort the map to set up reverse mapping */
> > > +     ret = sort_idmaps(&map);
> > > +     KUNIT_EXPECT_EQ(test, ret, 0);
> > > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, map.reverse);
> > > +
> > > +     /* Verify sorting is correct */
> > > +     for (i = 0; i < map.nr_extents; i++) {
> > > +             KUNIT_EXPECT_EQ(test, map.forward[i].first, i * 10);
> > > +             KUNIT_EXPECT_EQ(test, map.forward[i].lower_first, i * 100);
> > > +             KUNIT_EXPECT_EQ(test, map.forward[i].count, 5);
> > > +
> > > +             KUNIT_EXPECT_EQ(test, map.reverse[i].first, i * 10);
> > > +             KUNIT_EXPECT_EQ(test, map.reverse[i].lower_first, i * 100);
> > > +             KUNIT_EXPECT_EQ(test, map.reverse[i].count, 5);
> > > +     }
> >
> > Isn't this the same as the original order?
> >
> No. The original order uses "9 - i" for the base value, so it's not in
> sorted order (though it's not exactly random either).

Indeed, sorry for missing this.
If you send a new revision, maybe add a small comment.


Thomas
