Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EE63DCD99;
	Fri,  4 Sep 2026 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508956; cv=none; b=FesiVnB0AvAyVbdsXyJMMkrHuSHhCSSDnEbHr0XDEOObJ+X4vIy62FGm7QBqSuTBMSfOcK7E77fXrmy6WAHQFLIHQllAn9HPbnAMPhl3F68gzJh7ZkyddEzcSkwnVbSPLZCyukSfWtaTwp42cpyb8cMXw5z03VASAE/eFLhE1P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508956; c=relaxed/simple;
	bh=zC6P/8Dw+9qonHYZoXWrLn0M+/iwJNffZUmsckbNTq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lT9EWbZguIjJvypDySMkidhph/yPSvUdCGktSsNUPShSmqoKv3uqhGQ8Cq4QHKoX6tM+O7fQ+dMkkDv6Cs93EOaRJ3D+XG6kKBaxeVFx2yLYacM/Qtm/hOdnb8fw48gHqb+et8O+xVeOxubecdcpAJ5Jdo9ukB85aPR1REVLY4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0GDk6LZq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y5q+DdC2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0GDk6LZq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y5q+DdC2"
Date: Fri, 4 Sep 2026 10:02:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788508951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XmtmmMFkXoL9UT0a4IJENsFGSfG0aElL5AXlIL2jrr8=;
	b=0GDk6LZqvxsakm0ZA+iquU5CnSMZMC2f2eM1RGqDs1VFBsC/mOAdYzUWL1Om4bi5loHVjH
	GLHlUGvi7GL7Sd4E6b5Nu1DbzJDpYKvmLhhtMqL0N5uwERv2oJx8l6Jz0Ew9hLl6BYLA9P
	QxwOxj/lD5HgNFwl7COeZaxbkFEk3udV1JOaiTi+YmxhsuuiOmaLYTvNDkOWf/VxkzEaTA
	IPENlOPim6DFPX/4DC+r2OOz1Zrd6+1/qlePbZSYEPq7QtC9PskO8uzPlXtXq8Eu8iFyHG
	zf3y86FJ/GyCFsraMLlwgvsNcmFhGV3G5NhYWW/HUUevxJWiJ2yO3KBmLwI+uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788508951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XmtmmMFkXoL9UT0a4IJENsFGSfG0aElL5AXlIL2jrr8=;
	b=y5q+DdC2xpe7mtuds2iZT3VOB56N9CVSyqx/m2ogDceA2uBIb9WZvkzkSdY222kQ2hTVoe
	/J3Q2ACIO+3an1DA==
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
Message-ID: <20260904091410-3a87d211-edf8-4ead-8b91-004a4a96a161@linutronix.de>
References: <20260823125155.1136740-1-morbo@google.com>
 <20260826220041.4075333-1-morbo@google.com>
 <20260826220041.4075333-2-morbo@google.com>
 <20260827152612-d0c71c10-cbe5-49f3-9be0-47eb76cd9b48@linutronix.de>
 <CAGG=3QWPTL5z8MfAxJLpHb0P-3Ah6K+FzgrVHyRRcvRK7-6dSA@mail.gmail.com>
 <20260831111423-400ed79e-6e52-438c-aa9f-f289e6dbdee5@linutronix.de>
 <CAGG=3QUAY4BDiJM64uTX8C1A2WPg6dPRexbgUQZoi4QKkkpP9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGG=3QUAY4BDiJM64uTX8C1A2WPg6dPRexbgUQZoi4QKkkpP9Q@mail.gmail.com>

On Thu, Sep 03, 2026 at 01:21:27PM -0700, Bill Wendling wrote:
> On Mon, Aug 31, 2026 at 2:22 AM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> > On Thu, Aug 27, 2026 at 12:27:30PM -0700, Bill Wendling wrote:
> > > On Thu, Aug 27, 2026 at 6:37 AM Thomas Weißschuh
> > > <thomas.weissschuh@linutronix.de> wrote:
> >
> > (...)
> >
> > > > > +config USER_NAMESPACE_KUNIT_TEST
> > > > > +     bool "Test user namespace map insertion" if !KUNIT_ALL_TESTS
> > > > > +     depends on KUNIT=y
> > > >
> > > > Urgh.
> > > >
> > > ?? What's wrong? It's identical to the conditional for EXEC_KUNIT_TEST:
> >
> > Sorry for this non-descript review comment.
> >
> > > config EXEC_KUNIT_TEST
> > >      bool "Build execve tests" if !KUNIT_ALL_TESTS
> > >      depends on KUNIT=y
> > >      default KUNIT_ALL_TESTS
> > >      help
> > >           This builds the exec KUnit tests, which tests boundary conditions
> > >           of various aspects of the exec internals.
> >
> > The problem is that KUNIT can be built as module, which would prevent this
> > test from being built. We have include/kunit/visibility.h to export certain
> > symbols only to tests and avoid this issue.
> > But I can see that some maintaines don't like this pattern, so maybe they can
> > chime in at some point.
> 
> Bradley commented on this earlier (which is why I mentioned EXEC_KUNIT_TEST):
> 
> <comment>
> The test is #include'd into user_namespace.c, which is builtin (USER_NS
> is a bool), so =m here still compiles the suite into vmlinux. With
> KUNIT=m that calls kunit symbols that live in a module, and the link
> fails. Make it bool and depend on KUNIT=y, like EXEC_KUNIT_TEST:
> 
>  bool "KUnit test for user namespace map insertion" if !KUNIT_ALL_TESTS
>  depends on USER_NS && KUNIT=y
> </comment>
> 
> So there's a conflict and, because I'm not a KUnit guru, I'm not sure
> which way is "best".

It's subjective. So as mentioned before, the preference of the maintainers
should go into it. The aproach I prefer requires a bit more setup boilerplate
but make the tests usable in more circumstances.

> > > > > +     default KUNIT_ALL_TESTS
> > > > > +     help
> > > > > +       This builds the KUnit test for user namespace uid/gid map insertion.
> > > > > +       It validates map insertion, limits, dynamic allocation of the
> > > > > +       extended extents array, and mapping sorting functions.
> > > > > +       If unsure, say N.
> > > > > +
> > > > >  config PID_NS
> > > > >       bool "PID Namespaces"
> > > > >       default y
> > > > > diff --git a/kernel/.kunitconfig b/kernel/.kunitconfig
> > > > > new file mode 100644
> > > > > index 000000000000..7314dce05dc2
> > > > > --- /dev/null
> > > > > +++ b/kernel/.kunitconfig
> > > > > @@ -0,0 +1,3 @@
> > > > > +CONFIG_KUNIT=y
> > > > > +CONFIG_USER_NS=y
> > > > > +CONFIG_USER_NAMESPACE_KUNIT_TEST=y
> > > > > diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> > > > > index 786dbf0506ca..0e7373085af9 100644
> > > > > --- a/kernel/user_namespace.c
> > > > > +++ b/kernel/user_namespace.c
> > > > > @@ -1417,3 +1417,7 @@ static __init int user_namespaces_init(void)
> > > > >       return 0;
> > > > >  }
> > > > >  subsys_initcall(user_namespaces_init);
> > > > > +
> > > > > +#if IS_ENABLED(CONFIG_USER_NAMESPACE_KUNIT_TEST)
> > > > > +#include "user_namespace_kunit.c"
> > > > > +#endif
> > > > > diff --git a/kernel/user_namespace_kunit.c b/kernel/user_namespace_kunit.c
> > > > > new file mode 100644
> > > > > index 000000000000..88467361efdf
> > > > > --- /dev/null
> > > > > +++ b/kernel/user_namespace_kunit.c
> > > > > @@ -0,0 +1,92 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * KUnit test for user namespace map insertion and sorting.
> > > > > + */
> > > > > +
> > > > > +#include <kunit/test.h>
> > > > > +#include <linux/user_namespace.h>
> > > > > +
> > > > > +static void test_user_ns_map_insert_base(struct kunit *test)
> > > > > +{
> > > > > +     struct uid_gid_map map;
> > > > > +     struct uid_gid_extent extent;
> > > > > +     int i, ret;
> > > > > +
> > > > > +     memset(&map, 0, sizeof(map));
> > > > > +
> > > > > +     /* Insert up to UID_GID_MAP_MAX_BASE_EXTENTS (5) elements */
> > > > > +     for (i = 0; i < UID_GID_MAP_MAX_BASE_EXTENTS; i++) {
> > > > > +             extent.first = i * 10;
> > > > > +             extent.lower_first = i * 100;
> > > > > +             extent.count = 5;
> > > > > +
> > > > > +             ret = insert_extent(&map, &extent);
> > > > > +             KUNIT_ASSERT_EQ(test, ret, 0);
> > > > > +             KUNIT_EXPECT_EQ(test, map.nr_extents, i + 1);
> > > > > +             KUNIT_EXPECT_EQ(test, map.extent[i].first, i * 10);
> > > > > +             KUNIT_EXPECT_EQ(test, map.extent[i].lower_first, i * 100);
> > > > > +             KUNIT_EXPECT_EQ(test, map.extent[i].count, 5);
> > > > > +     }
> > > > > +}
> > > >
> > > > The extended test below already tests everything the 'base' one does.
> > > > Do we need both?
> > > >
> > > The one below tests the sorting algorithm.
> >
> > It *also* tests the insertion, no?
> > (Especially if the conditional on UID_GID_MAP_MAX_BASE_EXTENTS is removed)
> >
> Correct. So there are three types of tests we should run here:
> 
> 1. Insertions and accesses that don't go over the initial extents size.
> 2. Insertions and accesses that do go over the initial extents size.
> 3. Accesses outside of the number of entries.
> 
> Test (1) is a "smoke" test, where the struct is tested and no
> sanitizer code is used.

A "smoke" test is useful when the more complete tests can not be run regularly.
But here both test cases will always run right after each other. Test (2) is
just as cheap as this one.

*Not* testing the overflow checking here sounds also weird. Test (2) will
excercise the same code, which is not using the checking, anyways.

> Test (2) makes sure that we can still go over
> the UID_GID_MAP_MAX_BASE_EXTENTS size and the sanitizer won't
> activate.

Nice.

> Test (3) (which I'll add in my next upload) throws a sanitizer exception.

What is the point of testing this specifically for user namespaces?
Normally we expect a used subsystem to work as advertised.
It is that used subsystem's responsibility to test that it does so.
If there is currently no test that validates __counted_by then it surely
should be created. But not here.


Thomas
