Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F4943E07D
	for <linux-hardening@vger.kernel.org>; Thu, 27 Aug 2026 19:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858875; cv=pass; b=ZNGXkzhVBd3s6qkIGODPIwM329weV8NIpTSEVOrI1MVMHqJUnFzu7rnHdu9aTKph56gQPFSvOQ6KqYDxA/G7rJn0LqJA+IiqoYMl8/8CM8MWa1EbGuP8CvRZ3B7tSealVQm0xmhz6QD7SkxLD7GxWqt3LicIFmvJEQtf4tTihXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858875; c=relaxed/simple;
	bh=NdUlHkTDXhyZF/jvCiueksVyJDuLzPdAbNjo8+S5HG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohzpExc916mDHk+AEHIk//nx0o63ufC6kVF5F7+fTWHLwgfpFUdDfY2FYmXS+gsmfDyopjMQvqvkunTFq/LI5Pe1mM6aywLM+ULdEL0mD4clvBEzZgUQ91LN/2lC4Xx/ZvnLhKO00icH3/SaraXKtrXqcf+4bOquzM7nfrm3ytU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZVT7iSiF; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZVT7iSiF"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7850a5bd9a1so68917137.3
        for <linux-hardening@vger.kernel.org>; Thu, 27 Aug 2026 12:27:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787858873; cv=none;
        d=google.com; s=arc-20260327;
        b=f0OuD1SbfeTeZvbZrhWHLvydMkgd2J8HLtHRZK9UVvEpWrlxt7Op/fh3IxdnE+7dNs
         NQ8Oz+7Ik2AJmBhlgEj2Nr6HZOJX67plo7xxA4toODtDfsRc1CbMB+VhztP/LVSERKjE
         9MISL7AurVKnc94u3NKKIETTkD7noOS4HJY+JfvGTCwhok/FiYep1DRbuX7UJMuNOvnR
         lw6jL58ytRCgagzcFINop6gRarNedUDNq61/nlIeMKqAmvxNoDq70byyw62BXHnrlS3H
         JmD5iGwiFmKHwo+2DdCm21KuYKV4emRNdNqU+xSWLrCYTwcaC73Bs6M4RB/bo5svU9/y
         auew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b72u2M+8y+CGho4VPPb79RPEx+HN6SXrYRRxoCIGgqE=;
        fh=uBiB5NDLA5Byx3k14DGCgL/CaULQ+hiVX8Y2EMLAVcc=;
        b=FkKYVr6+UfeB+F4YPo43dHmdSxYm2Fjxcm9FBOqaX+Z4w46rX5DD32eN/CZbs54rnE
         SZ3y+zxrEusKKOynwGmljOHmLVUeBNa6UkN3K8YqgoSYuNoLzVUQScfbbZQwbD4k+0LI
         Umek5pyw/mO0ggKce7J7GISJKv2/Lz+Cx00bXmEJU1nBCOkw083paAKT9ilWWxIbDzLO
         KMT0nU5PbRzT3THX68hIRZ6+fiaSKqpd8P/KSSLSnOOqNTPBQd6pd76gzHWs/V40egLd
         NDYSr9++1ipoAUtXOt9o729dym2nfDb2yg+jNXERSTz6Ho6nKnQ03eigBCgdLyK3Qojs
         EbHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787858873; x=1788463673; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b72u2M+8y+CGho4VPPb79RPEx+HN6SXrYRRxoCIGgqE=;
        b=ZVT7iSiFGn7paAYeZKXovzyo8s9Kpbwlua+PcSoV8Y3khQKp9/ZD1ztonYaBcG0E1t
         jnIK4W3FJWqFvXXb1/b7v5kDfqGs+img8X6YqREnyezD3XNDjRhXLaEFHPCeSoeRyzCy
         4Afvscb9Lvo2su4Qs0oW9FYesjvgVUDVjIFCRBs6R9QhIJHkiF3FXEmbIT2GR/Bhuy0A
         XRZG2nL5CDtduJhum1VaiQYs1J2LmBEOLA0k6EGEdyIpEuaOXKxUq2r5XHSYRv66CL46
         0XA1Tx7+ZtmVPvGBkrLpJbqO1xiLGizy7DC1bDcUl5KAHFQfYqPJt64i0BNQ3uax14qp
         m9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787858873; x=1788463673;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b72u2M+8y+CGho4VPPb79RPEx+HN6SXrYRRxoCIGgqE=;
        b=iSGSD0S6D2nEteodIEeR1Gt92yg+iN2ZEBI2B2w3lqGbSsQLKF2GtplfOmw3OMb7vP
         VZYwSeD8EGXWtXmxVSdGJtUmRMaGU4CNyx5t7O6aO8b+hEppHX5y1qEOr9dvYzXUIW7W
         j7UMwxq80yib2Xn7X4/NqR9uQ2v7hfVl+hoZTDx40eq2a1tnh1ZorUAjJ3dTnWbcOL93
         Cop1DENUie/RVY8GQ3wzsNnxt1qoy2H9UMYnwxSjZjqeZTnNXLKH6bKYvY3PF4iIGtDF
         TaTRRq667h7rA6Z2vPaX01krAC97h0a1gjG6uLYx5FzvS69QfP8QuaBEwjTYlQ/aC5XE
         ANDw==
X-Forwarded-Encrypted: i=1; AHgh+RqDLLdYysIr2M+m8sUO1Lw2ep7P2ksYaEUXIUN8G06RvXLSCWz97X+wz+QNF4g/SHuiLvuGdyqJ9wF3SLzsb7c=@vger.kernel.org
X-Gm-Message-State: AFuF++mH2eeTA3HTT/7d150m04R8T4kBKthCDcPhNKPKjpsjCiS5TlJ/
	PmoTVj7xEvA27kIoGreNQyTZZayax0SwWhz+5p3eVX6DqV/qB+GBkTZ0ym+aSkfNV5T6Esq89xY
	q1pETc5BGUkp8pv6MEQ3jH/2lqnHeODyupi0d7m4=
X-Gm-Gg: AR+sD13I7Ce9EKVcC4xeLWdPSnji92tCuzsmiNL5fn2ukYoQ4w1FnLGDC2fob5jZdKW
	6blFvztjqXCNFU5jC2ybDbNnvonv0uUZhIOYGnvRwpy9Lf/rGOFcKAoY7e01nZMwHumJLlxqfr3
	cB2MacTwE3ttZQHhXMF6nCWqnrOP7SNcacR6sJFyp38gPL6VyQth3kdjax+RP9w0f/bDfohoKbQ
	cS6nU/Xi/+HJtoOTMwo2vzeOq88cJfjYZff7ixRTm7MscL7ZSCQAqbAoZSIwveulYpLfr8VGomg
	cW3vkuJovD7AIF/Sc5UqSjesc69K5d3/tINSgA7+NKE9UmCf6SKJXiy2rmNyWdJG9GnsEClZdTG
	/5IfF2raIYVhx/ytVFHaX9iTtFscIUr7Ke5R2/AJp80rR+/AxTTAa
X-Received: by 2002:a05:6102:50a9:b0:783:79ac:9dc3 with SMTP id
 ada2fe7eead31-7859a49efb7mr213153137.10.1787858867328; Thu, 27 Aug 2026
 12:27:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823125155.1136740-1-morbo@google.com> <20260826220041.4075333-1-morbo@google.com>
 <20260826220041.4075333-2-morbo@google.com> <20260827152612-d0c71c10-cbe5-49f3-9be0-47eb76cd9b48@linutronix.de>
In-Reply-To: <20260827152612-d0c71c10-cbe5-49f3-9be0-47eb76cd9b48@linutronix.de>
From: Bill Wendling <morbo@google.com>
Date: Thu, 27 Aug 2026 12:27:30 -0700
X-Gm-Features: AcwNN1XiOnfT531iWNl0-gc8eQp4_JJ1nwZ_yZ69L-Yg0O1qe56FqF7NVdO22QM
Message-ID: <CAGG=3QWPTL5z8MfAxJLpHb0P-3Ah6K+FzgrVHyRRcvRK7-6dSA@mail.gmail.com>
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

On Thu, Aug 27, 2026 at 6:37=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> On Wed, Aug 26, 2026 at 10:00:35PM +0000, Bill Wendling wrote:
> > Add a KUnit test suite to verify the insertion and sorting of mappings
> > in struct uid_gid_map. This test suite validates both base extent
> > insertion (<=3D 5 mappings) and extended extent insertion (> 5 mappings=
,
> > which triggers the allocation of the forward and reverse pointers).
> >
> > This is especially useful for verifying that the __counted_by_ptr
> > attribute added to 'forward' and 'reverse' pointers works correctly
> > without causing any runtime bounds-checking panics or traps.
> >
> > Assisted-by: Gemini:3.1-pro-preview
> > Signed-off-by: Bill Wendling <morbo@google.com>
> > ---
> > v2 - Remove Gerrit tag.
> > v3 - s/KUNIT_EXPECT_NOT_ERR_OR_NULL/KUNIT_ASSERT_NOT_ERR_OR_NULL/
> >    - Fixed Kconfig tests.
> > v4 - Actually test on unsorted data. Corrected the "Assisted-by" tag.
> > ---
> > Cc: Bradley Morgan <brads@mainlining.org>
> > Cc: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Aleksa Sarai <cyphar@cyphar.com>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Miguel Ojeda <ojeda@kernel.org>
> > Cc: Thomas Gleixner <tglx@kernel.org>
> > Cc: Nicolas Schier <nsc@kernel.org>
> > Cc: Gary Guo <gary@garyguo.net>
> > Cc: "Thomas Wei=C3=9Fschuh" <thomas.weissschuh@linutronix.de>
> > Cc: Alice Ryhl <aliceryhl@google.com>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Anand Moon <linux.amoon@gmail.com>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: codemender-patching+linux@google.com
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-hardening@vger.kernel.org
> > ---
> >  init/Kconfig                  | 10 ++++
> >  kernel/.kunitconfig           |  3 ++
> >  kernel/user_namespace.c       |  4 ++
> >  kernel/user_namespace_kunit.c | 92 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 109 insertions(+)
> >  create mode 100644 kernel/.kunitconfig
> >  create mode 100644 kernel/user_namespace_kunit.c
> >
> > diff --git a/init/Kconfig b/init/Kconfig
> > index f63bf5e05e79..d460344539a5 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1457,6 +1457,16 @@ config USER_NS
> >
> >         If unsure, say N.
> >
> > +config USER_NAMESPACE_KUNIT_TEST
> > +     bool "Test user namespace map insertion" if !KUNIT_ALL_TESTS
> > +     depends on KUNIT=3Dy
>
> Urgh.
>
?? What's wrong? It's identical to the conditional for EXEC_KUNIT_TEST:

config EXEC_KUNIT_TEST
     bool "Build execve tests" if !KUNIT_ALL_TESTS
     depends on KUNIT=3Dy
     default KUNIT_ALL_TESTS
     help
          This builds the exec KUnit tests, which tests boundary conditions
          of various aspects of the exec internals.

> > +     default KUNIT_ALL_TESTS
> > +     help
> > +       This builds the KUnit test for user namespace uid/gid map inser=
tion.
> > +       It validates map insertion, limits, dynamic allocation of the
> > +       extended extents array, and mapping sorting functions.
> > +       If unsure, say N.
> > +
> >  config PID_NS
> >       bool "PID Namespaces"
> >       default y
> > diff --git a/kernel/.kunitconfig b/kernel/.kunitconfig
> > new file mode 100644
> > index 000000000000..7314dce05dc2
> > --- /dev/null
> > +++ b/kernel/.kunitconfig
> > @@ -0,0 +1,3 @@
> > +CONFIG_KUNIT=3Dy
> > +CONFIG_USER_NS=3Dy
> > +CONFIG_USER_NAMESPACE_KUNIT_TEST=3Dy
> > diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> > index 786dbf0506ca..0e7373085af9 100644
> > --- a/kernel/user_namespace.c
> > +++ b/kernel/user_namespace.c
> > @@ -1417,3 +1417,7 @@ static __init int user_namespaces_init(void)
> >       return 0;
> >  }
> >  subsys_initcall(user_namespaces_init);
> > +
> > +#if IS_ENABLED(CONFIG_USER_NAMESPACE_KUNIT_TEST)
> > +#include "user_namespace_kunit.c"
> > +#endif
> > diff --git a/kernel/user_namespace_kunit.c b/kernel/user_namespace_kuni=
t.c
> > new file mode 100644
> > index 000000000000..88467361efdf
> > --- /dev/null
> > +++ b/kernel/user_namespace_kunit.c
> > @@ -0,0 +1,92 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * KUnit test for user namespace map insertion and sorting.
> > + */
> > +
> > +#include <kunit/test.h>
> > +#include <linux/user_namespace.h>
> > +
> > +static void test_user_ns_map_insert_base(struct kunit *test)
> > +{
> > +     struct uid_gid_map map;
> > +     struct uid_gid_extent extent;
> > +     int i, ret;
> > +
> > +     memset(&map, 0, sizeof(map));
> > +
> > +     /* Insert up to UID_GID_MAP_MAX_BASE_EXTENTS (5) elements */
> > +     for (i =3D 0; i < UID_GID_MAP_MAX_BASE_EXTENTS; i++) {
> > +             extent.first =3D i * 10;
> > +             extent.lower_first =3D i * 100;
> > +             extent.count =3D 5;
> > +
> > +             ret =3D insert_extent(&map, &extent);
> > +             KUNIT_ASSERT_EQ(test, ret, 0);
> > +             KUNIT_EXPECT_EQ(test, map.nr_extents, i + 1);
> > +             KUNIT_EXPECT_EQ(test, map.extent[i].first, i * 10);
> > +             KUNIT_EXPECT_EQ(test, map.extent[i].lower_first, i * 100)=
;
> > +             KUNIT_EXPECT_EQ(test, map.extent[i].count, 5);
> > +     }
> > +}
>
> The extended test below already tests everything the 'base' one does.
> Do we need both?
>
The one below tests the sorting algorithm.

> > +
> > +static void test_user_ns_map_insert_extended(struct kunit *test)
> > +{
> > +     struct uid_gid_map map;
> > +     struct uid_gid_extent extent;
> > +     int i, ret;
> > +
> > +     memset(&map, 0, sizeof(map));
> > +
> > +     /* Insert more than UID_GID_MAP_MAX_BASE_EXTENTS (e.g., 10) eleme=
nts */
>
> When UID_GID_MAP_MAX_BASE_EXTENTS is ever increased, this might not be tr=
ue anymore.
> Add an assertion or make the iteration count dynamic.
>
Sure, I can make it something like "UID_GID_MAP_MAX_BASE_EXTENTS + 42"
or something. Let me know about the "Urgh" comment above first.

> > +     for (i =3D 0; i < 10; i++) {
> > +             int value =3D 9 - i;
> > +
> > +             extent.first =3D value * 10;
> > +             extent.lower_first =3D value * 100;
> > +             extent.count =3D 5;
> > +
> > +             ret =3D insert_extent(&map, &extent);
> > +             KUNIT_ASSERT_EQ(test, ret, 0);
> > +             KUNIT_EXPECT_EQ(test, map.nr_extents, i + 1);
> > +
> > +             if (i < UID_GID_MAP_MAX_BASE_EXTENTS) {
> > +                     KUNIT_EXPECT_EQ(test, map.extent[i].first, value =
* 10);
> > +             } else {
> > +                     KUNIT_EXPECT_EQ(test, map.forward[i].first, value=
 * 10);
> > +                     KUNIT_EXPECT_EQ(test, map.forward[i].lower_first,=
 value  * 100);
> > +                     KUNIT_EXPECT_EQ(test, map.forward[i].count, 5);
> > +             }
> > +     }
> > +
> > +     /* Now sort the map to set up reverse mapping */
> > +     ret =3D sort_idmaps(&map);
> > +     KUNIT_EXPECT_EQ(test, ret, 0);
> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, map.reverse);
> > +
> > +     /* Verify sorting is correct */
> > +     for (i =3D 0; i < map.nr_extents; i++) {
> > +             KUNIT_EXPECT_EQ(test, map.forward[i].first, i * 10);
> > +             KUNIT_EXPECT_EQ(test, map.forward[i].lower_first, i * 100=
);
> > +             KUNIT_EXPECT_EQ(test, map.forward[i].count, 5);
> > +
> > +             KUNIT_EXPECT_EQ(test, map.reverse[i].first, i * 10);
> > +             KUNIT_EXPECT_EQ(test, map.reverse[i].lower_first, i * 100=
);
> > +             KUNIT_EXPECT_EQ(test, map.reverse[i].count, 5);
> > +     }
>
> Isn't this the same as the original order?
>
No. The original order uses "9 - i" for the base value, so it's not in
sorted order (though it's not exactly random either).

-bw

> > +
> > +     kfree(map.forward);
> > +     kfree(map.reverse);
> > +}
>
> (...)
