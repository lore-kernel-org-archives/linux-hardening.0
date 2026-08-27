Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083CA3783C3;
	Thu, 27 Aug 2026 13:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837825; cv=none; b=M53xbglhUxga8bWRrDaf58tgRdRD4vn7DdV+eXvro1kEPvuzyDJBnW7SeR0IKIN4DsJTz3Gec8RwSLVDbnmYKDpbOVAaa+6KjqFdvvmPVLBJ/WbZMhrbakNnsNCyKeq3meFcWJiZTf86yN59g95GUTwlIPF6452QHql9rGIxTNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837825; c=relaxed/simple;
	bh=7ZFlZ7/9bZPm0qNEHBrmO3XPml3Kv21QLv1We9PSvpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvzga2Z8Ko3VQc0/POZrha0Ot3hxj62Tlt4Z2Nl7SlOMAFT+DImFMWSvxVrDDsmsOWSDAlHHh5lTlu+zN0LENHTLwEE06jPYxCffV6ejHOKsPchYXkTzc3bwFOpFJJ6A0egFSnKaj0X1cSWLWVK9XekR/ErLwIBbkjGlWd0NaVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zPUYnfOI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9c87dMGc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zPUYnfOI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9c87dMGc"
Date: Thu, 27 Aug 2026 15:36:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787837818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ZMa9rg/D1KLgqFxD5i9CA9qSZWYHkOoI9NiTK8ge6g=;
	b=zPUYnfOILuRh2y6RJ8mGfg7w+DBLeVSRA+5ErK1CK+e27o/FcCdM0P74rLCOJN2Zb0z0Q3
	gficTvxWFBDcQHl9zidO9H13DkPEiFQO/PFexRBlG5nQGPvgAIVfPuH+FwxxrceUAPattm
	6O4O1PITsQZ6ZG1suTsTxAe0TOZfwkR9Vs8+x/abaJUDofUeWwnhvRchF3BErd+qjcRPuQ
	cxhHLaYOwowFP50eGNdMx/qrjLKDL5i7nRlkb4TLiLStnUR2gNc+HgK0YwMu+5huZ0LxlH
	IGVwh/8ZQXwy5Dn2EG2kqa6x7s7zB8vF/1mR/c4PQgDSwTSCg7c3CNhY5AewFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787837818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ZMa9rg/D1KLgqFxD5i9CA9qSZWYHkOoI9NiTK8ge6g=;
	b=9c87dMGcle939ISrmqTqf/QPak6s60UbnVOUEVVwbh5GfJiDeXnh2Lfjo2NSLUK+uaBsCi
	rRktT7U9gge/q5AQ==
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
Message-ID: <20260827152612-d0c71c10-cbe5-49f3-9be0-47eb76cd9b48@linutronix.de>
References: <20260823125155.1136740-1-morbo@google.com>
 <20260826220041.4075333-1-morbo@google.com>
 <20260826220041.4075333-2-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260826220041.4075333-2-morbo@google.com>

On Wed, Aug 26, 2026 at 10:00:35PM +0000, Bill Wendling wrote:
> Add a KUnit test suite to verify the insertion and sorting of mappings
> in struct uid_gid_map. This test suite validates both base extent
> insertion (<= 5 mappings) and extended extent insertion (> 5 mappings,
> which triggers the allocation of the forward and reverse pointers).
> 
> This is especially useful for verifying that the __counted_by_ptr
> attribute added to 'forward' and 'reverse' pointers works correctly
> without causing any runtime bounds-checking panics or traps.
> 
> Assisted-by: Gemini:3.1-pro-preview
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
> v2 - Remove Gerrit tag.
> v3 - s/KUNIT_EXPECT_NOT_ERR_OR_NULL/KUNIT_ASSERT_NOT_ERR_OR_NULL/
>    - Fixed Kconfig tests.
> v4 - Actually test on unsorted data. Corrected the "Assisted-by" tag.
> ---
> Cc: Bradley Morgan <brads@mainlining.org>
> Cc: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> Cc: Kees Cook <kees@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Nicolas Schier <nsc@kernel.org>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: "Thomas Weiﬂschuh" <thomas.weissschuh@linutronix.de>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Anand Moon <linux.amoon@gmail.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: codemender-patching+linux@google.com
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> ---
>  init/Kconfig                  | 10 ++++
>  kernel/.kunitconfig           |  3 ++
>  kernel/user_namespace.c       |  4 ++
>  kernel/user_namespace_kunit.c | 92 +++++++++++++++++++++++++++++++++++
>  4 files changed, 109 insertions(+)
>  create mode 100644 kernel/.kunitconfig
>  create mode 100644 kernel/user_namespace_kunit.c
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index f63bf5e05e79..d460344539a5 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1457,6 +1457,16 @@ config USER_NS
>  
>  	  If unsure, say N.
>  
> +config USER_NAMESPACE_KUNIT_TEST
> +	bool "Test user namespace map insertion" if !KUNIT_ALL_TESTS
> +	depends on KUNIT=y

Urgh.

> +	default KUNIT_ALL_TESTS
> +	help
> +	  This builds the KUnit test for user namespace uid/gid map insertion.
> +	  It validates map insertion, limits, dynamic allocation of the
> +	  extended extents array, and mapping sorting functions.
> +	  If unsure, say N.
> +
>  config PID_NS
>  	bool "PID Namespaces"
>  	default y
> diff --git a/kernel/.kunitconfig b/kernel/.kunitconfig
> new file mode 100644
> index 000000000000..7314dce05dc2
> --- /dev/null
> +++ b/kernel/.kunitconfig
> @@ -0,0 +1,3 @@
> +CONFIG_KUNIT=y
> +CONFIG_USER_NS=y
> +CONFIG_USER_NAMESPACE_KUNIT_TEST=y
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 786dbf0506ca..0e7373085af9 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -1417,3 +1417,7 @@ static __init int user_namespaces_init(void)
>  	return 0;
>  }
>  subsys_initcall(user_namespaces_init);
> +
> +#if IS_ENABLED(CONFIG_USER_NAMESPACE_KUNIT_TEST)
> +#include "user_namespace_kunit.c"
> +#endif
> diff --git a/kernel/user_namespace_kunit.c b/kernel/user_namespace_kunit.c
> new file mode 100644
> index 000000000000..88467361efdf
> --- /dev/null
> +++ b/kernel/user_namespace_kunit.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for user namespace map insertion and sorting.
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/user_namespace.h>
> +
> +static void test_user_ns_map_insert_base(struct kunit *test)
> +{
> +	struct uid_gid_map map;
> +	struct uid_gid_extent extent;
> +	int i, ret;
> +
> +	memset(&map, 0, sizeof(map));
> +
> +	/* Insert up to UID_GID_MAP_MAX_BASE_EXTENTS (5) elements */
> +	for (i = 0; i < UID_GID_MAP_MAX_BASE_EXTENTS; i++) {
> +		extent.first = i * 10;
> +		extent.lower_first = i * 100;
> +		extent.count = 5;
> +
> +		ret = insert_extent(&map, &extent);
> +		KUNIT_ASSERT_EQ(test, ret, 0);
> +		KUNIT_EXPECT_EQ(test, map.nr_extents, i + 1);
> +		KUNIT_EXPECT_EQ(test, map.extent[i].first, i * 10);
> +		KUNIT_EXPECT_EQ(test, map.extent[i].lower_first, i * 100);
> +		KUNIT_EXPECT_EQ(test, map.extent[i].count, 5);
> +	}
> +}

The extended test below already tests everything the 'base' one does.
Do we need both?

> +
> +static void test_user_ns_map_insert_extended(struct kunit *test)
> +{
> +	struct uid_gid_map map;
> +	struct uid_gid_extent extent;
> +	int i, ret;
> +
> +	memset(&map, 0, sizeof(map));
> +
> +	/* Insert more than UID_GID_MAP_MAX_BASE_EXTENTS (e.g., 10) elements */

When UID_GID_MAP_MAX_BASE_EXTENTS is ever increased, this might not be true anymore.
Add an assertion or make the iteration count dynamic.

> +	for (i = 0; i < 10; i++) {
> +		int value = 9 - i;
> +
> +		extent.first = value * 10;
> +		extent.lower_first = value * 100;
> +		extent.count = 5;
> +
> +		ret = insert_extent(&map, &extent);
> +		KUNIT_ASSERT_EQ(test, ret, 0);
> +		KUNIT_EXPECT_EQ(test, map.nr_extents, i + 1);
> +
> +		if (i < UID_GID_MAP_MAX_BASE_EXTENTS) {
> +			KUNIT_EXPECT_EQ(test, map.extent[i].first, value * 10);
> +		} else {
> +			KUNIT_EXPECT_EQ(test, map.forward[i].first, value * 10);
> +			KUNIT_EXPECT_EQ(test, map.forward[i].lower_first, value  * 100);
> +			KUNIT_EXPECT_EQ(test, map.forward[i].count, 5);
> +		}
> +	}
> +
> +	/* Now sort the map to set up reverse mapping */
> +	ret = sort_idmaps(&map);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, map.reverse);
> +
> +	/* Verify sorting is correct */
> +	for (i = 0; i < map.nr_extents; i++) {
> +		KUNIT_EXPECT_EQ(test, map.forward[i].first, i * 10);
> +		KUNIT_EXPECT_EQ(test, map.forward[i].lower_first, i * 100);
> +		KUNIT_EXPECT_EQ(test, map.forward[i].count, 5);
> +
> +		KUNIT_EXPECT_EQ(test, map.reverse[i].first, i * 10);
> +		KUNIT_EXPECT_EQ(test, map.reverse[i].lower_first, i * 100);
> +		KUNIT_EXPECT_EQ(test, map.reverse[i].count, 5);
> +	}

Isn't this the same as the original order?

> +
> +	kfree(map.forward);
> +	kfree(map.reverse);
> +}

(...)
