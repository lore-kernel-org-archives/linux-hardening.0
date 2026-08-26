Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C951C31E844;
	Wed, 26 Aug 2026 22:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787783309; cv=none; b=jJD0tXek3MyWtuDpklAwIcHPxXtvoYhIZDlkQcPVJuyIXkpYcTu6APom0i0BgaLyNLFcwj5mHhwxwu6fuFZdMtLYQQtxCIlEqNWvy/XymXSBtwppzuAExsTclecwthSPoL3v3ob3rLzGimfrPpIhIZ/k57aPnVyfuzvA1Gu8dgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787783309; c=relaxed/simple;
	bh=yAt7chsuQ3yUj0A8Qb5ZD6FDTelm93GvYP2mnoEnyOA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=rb5t1EAYpiv92nAVzeOW+pVeeth196foMvC4sK0yxbBFqjT66haZ1ZHb/uovMNCItSnAvejb7YXs7Yq3ovPr2XIA3dTNubeERLs3AvsfjOVzfCdFD5qlalFMbsHmJnaejlIxxZoRgTn6wbF2vzeN62JPYH5Vaa1EvMvqgk2fMmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=aJ2cc0Cj; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=9EFDm23S; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="aJ2cc0Cj";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="9EFDm23S"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787783268; bh=AlE42pFzaC8xw8talHPrPGM
	qxNrKTSb1xbJj5kQD+h4=; b=aJ2cc0CjqpjGIKPb7Lw8z8zf9a3mopKgSLssowxHM86ewIp3Nr
	DXWD5xjuFDWFTRboxdOHKVlcvnyYb13YHx/M1XMUvPT26JeS/6mbNANlEALyuM4oowC0huJcG5R
	3ekYPNYyHFn8USJ3sL5EvQfp8URocjQ9w9nC0tWqhoCR9pVLXZTLYnJs285lLhw+u2eLyeZPtxl
	RmIWg3/LDvCfRRTaDu/ossD27ajR5vTAGsXJk+W6FmrzClfDVE/eRizTFojXdVYoOSAxXWEcHes
	85T5pqik1uSgC0h2JmbI964YqRnJlULqkxk3p/1XguUHeGTi/9N9hT+/ePEe2hVBIFQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787783268; bh=AlE42pFzaC8xw8talHPrPGM
	qxNrKTSb1xbJj5kQD+h4=; b=9EFDm23SxGTvafSh7JjL9abzKSuJmJllEyVAHU6GIk54DZV3Pw
	pvQ3XBy+MU40j8Cx56AyCLR2i7dp0GB4zTAA==;
Date: Wed, 26 Aug 2026 23:27:49 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Bill Wendling <morbo@google.com>
CC: =?ISO-8859-1?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
 Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, Gary Guo <gary@garyguo.net>,
 Alice Ryhl <aliceryhl@google.com>, Douglas Anderson <dianders@chromium.org>,
 Anand Moon <linux.amoon@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 codemender-patching+linux@google.com, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 2/2] userns: Add KUnit test suite for uid_gid_map
In-Reply-To: <20260826220041.4075333-2-morbo@google.com>
References: <20260823125155.1136740-1-morbo@google.com> <20260826220041.4075333-1-morbo@google.com> <20260826220041.4075333-2-morbo@google.com>
Message-ID: <21ED2927-4536-432C-B1E5-B446A04ED230@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 26 August 2026 23:00:35 BST, Bill Wendling <morbo@google.com> wrote:
>Add a KUnit test suite to verify the insertion and sorting of mappings
>in struct uid_gid_map. This test suite validates both base extent
>insertion (<= 5 mappings) and extended extent insertion (> 5 mappings,
>which triggers the allocation of the forward and reverse pointers).
>
>This is especially useful for verifying that the __counted_by_ptr
>attribute added to 'forward' and 'reverse' pointers works correctly
>without causing any runtime bounds-checking panics or traps.
>
>Assisted-by: Gemini:3.1-pro-preview

Now for all the work s/you/your AI done, I've done the tests and they
passed, and they LGTM

Tested-by: Bradley Morgan <brads@mainlining.org>

Reviewed-by: Bradley Morgan <brads@mainlining.org>

Thanks for your patch mate, (pls slow down tho, we can review oh so quick)

>Signed-off-by: Bill Wendling <morbo@google.com>
>---
>v2 - Remove Gerrit tag.
>v3 - s/KUNIT_EXPECT_NOT_ERR_OR_NULL/KUNIT_ASSERT_NOT_ERR_OR_NULL/
>   - Fixed Kconfig tests.
>v4 - Actually test on unsorted data. Corrected the "Assisted-by" tag.
>---
>Cc: Bradley Morgan <brads@mainlining.org>
>Cc: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
>Cc: Kees Cook <kees@kernel.org>
>Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
>Cc: Christian Brauner <brauner@kernel.org>
>Cc: Aleksa Sarai <cyphar@cyphar.com>
>Cc: Jan Kara <jack@suse.cz>
>Cc: Nathan Chancellor <nathan@kernel.org>
>Cc: Miguel Ojeda <ojeda@kernel.org>
>Cc: Thomas Gleixner <tglx@kernel.org>
>Cc: Nicolas Schier <nsc@kernel.org>
>Cc: Gary Guo <gary@garyguo.net>
>Cc: "Thomas Weißschuh" <thomas.weissschuh@linutronix.de>
>Cc: Alice Ryhl <aliceryhl@google.com>
>Cc: Douglas Anderson <dianders@chromium.org>
>Cc: Anand Moon <linux.amoon@gmail.com>
>Cc: Oleg Nesterov <oleg@redhat.com>
>Cc: codemender-patching+linux@google.com
>Cc: linux-kernel@vger.kernel.org
>Cc: linux-hardening@vger.kernel.org
>---
> init/Kconfig                  | 10 ++++
> kernel/.kunitconfig           |  3 ++
> kernel/user_namespace.c       |  4 ++
> kernel/user_namespace_kunit.c | 92 +++++++++++++++++++++++++++++++++++
> 4 files changed, 109 insertions(+)
> create mode 100644 kernel/.kunitconfig
> create mode 100644 kernel/user_namespace_kunit.c
>
>diff --git a/init/Kconfig b/init/Kconfig
>index f63bf5e05e79..d460344539a5 100644
>--- a/init/Kconfig
>+++ b/init/Kconfig
>@@ -1457,6 +1457,16 @@ config USER_NS
> 
> 	  If unsure, say N.
> 
>+config USER_NAMESPACE_KUNIT_TEST
>+	bool "Test user namespace map insertion" if !KUNIT_ALL_TESTS
>+	depends on KUNIT=y
>+	default KUNIT_ALL_TESTS
>+	help
>+	  This builds the KUnit test for user namespace uid/gid map insertion.
>+	  It validates map insertion, limits, dynamic allocation of the
>+	  extended extents array, and mapping sorting functions.
>+	  If unsure, say N.
>+
> config PID_NS
> 	bool "PID Namespaces"
> 	default y
>diff --git a/kernel/.kunitconfig b/kernel/.kunitconfig
>new file mode 100644
>index 000000000000..7314dce05dc2
>--- /dev/null
>+++ b/kernel/.kunitconfig
>@@ -0,0 +1,3 @@
>+CONFIG_KUNIT=y
>+CONFIG_USER_NS=y
>+CONFIG_USER_NAMESPACE_KUNIT_TEST=y
>diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
>index 786dbf0506ca..0e7373085af9 100644
>--- a/kernel/user_namespace.c
>+++ b/kernel/user_namespace.c
>@@ -1417,3 +1417,7 @@ static __init int user_namespaces_init(void)
> 	return 0;
> }
> subsys_initcall(user_namespaces_init);
>+
>+#if IS_ENABLED(CONFIG_USER_NAMESPACE_KUNIT_TEST)
>+#include "user_namespace_kunit.c"
>+#endif
>diff --git a/kernel/user_namespace_kunit.c b/kernel/user_namespace_kunit.c
>new file mode 100644
>index 000000000000..88467361efdf
>--- /dev/null
>+++ b/kernel/user_namespace_kunit.c
>@@ -0,0 +1,92 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/*
>+ * KUnit test for user namespace map insertion and sorting.
>+ */
>+
>+#include <kunit/test.h>
>+#include <linux/user_namespace.h>
>+
>+static void test_user_ns_map_insert_base(struct kunit *test)
>+{
>+	struct uid_gid_map map;
>+	struct uid_gid_extent extent;
>+	int i, ret;
>+
>+	memset(&map, 0, sizeof(map));
>+
>+	/* Insert up to UID_GID_MAP_MAX_BASE_EXTENTS (5) elements */
>+	for (i = 0; i < UID_GID_MAP_MAX_BASE_EXTENTS; i++) {
>+		extent.first = i * 10;
>+		extent.lower_first = i * 100;
>+		extent.count = 5;
>+
>+		ret = insert_extent(&map, &extent);
>+		KUNIT_ASSERT_EQ(test, ret, 0);
>+		KUNIT_EXPECT_EQ(test, map.nr_extents, i + 1);
>+		KUNIT_EXPECT_EQ(test, map.extent[i].first, i * 10);
>+		KUNIT_EXPECT_EQ(test, map.extent[i].lower_first, i * 100);
>+		KUNIT_EXPECT_EQ(test, map.extent[i].count, 5);
>+	}
>+}
>+
>+static void test_user_ns_map_insert_extended(struct kunit *test)
>+{
>+	struct uid_gid_map map;
>+	struct uid_gid_extent extent;
>+	int i, ret;
>+
>+	memset(&map, 0, sizeof(map));
>+
>+	/* Insert more than UID_GID_MAP_MAX_BASE_EXTENTS (e.g., 10) elements */
>+	for (i = 0; i < 10; i++) {
>+		int value = 9 - i;
>+
>+		extent.first = value * 10;
>+		extent.lower_first = value * 100;
>+		extent.count = 5;
>+
>+		ret = insert_extent(&map, &extent);
>+		KUNIT_ASSERT_EQ(test, ret, 0);
>+		KUNIT_EXPECT_EQ(test, map.nr_extents, i + 1);
>+
>+		if (i < UID_GID_MAP_MAX_BASE_EXTENTS) {
>+			KUNIT_EXPECT_EQ(test, map.extent[i].first, value * 10);
>+		} else {
>+			KUNIT_EXPECT_EQ(test, map.forward[i].first, value * 10);
>+			KUNIT_EXPECT_EQ(test, map.forward[i].lower_first, value  * 100);
>+			KUNIT_EXPECT_EQ(test, map.forward[i].count, 5);
>+		}
>+	}
>+
>+	/* Now sort the map to set up reverse mapping */
>+	ret = sort_idmaps(&map);
>+	KUNIT_EXPECT_EQ(test, ret, 0);
>+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, map.reverse);
>+
>+	/* Verify sorting is correct */
>+	for (i = 0; i < map.nr_extents; i++) {
>+		KUNIT_EXPECT_EQ(test, map.forward[i].first, i * 10);
>+		KUNIT_EXPECT_EQ(test, map.forward[i].lower_first, i * 100);
>+		KUNIT_EXPECT_EQ(test, map.forward[i].count, 5);
>+
>+		KUNIT_EXPECT_EQ(test, map.reverse[i].first, i * 10);
>+		KUNIT_EXPECT_EQ(test, map.reverse[i].lower_first, i * 100);
>+		KUNIT_EXPECT_EQ(test, map.reverse[i].count, 5);
>+	}
>+
>+	kfree(map.forward);
>+	kfree(map.reverse);
>+}
>+
>+static struct kunit_case user_ns_map_test_cases[] = {
>+	KUNIT_CASE(test_user_ns_map_insert_base),
>+	KUNIT_CASE(test_user_ns_map_insert_extended),
>+	{}
>+};
>+
>+static struct kunit_suite user_ns_map_test_suite = {
>+	.name = "user_ns_map",
>+	.test_cases = user_ns_map_test_cases,
>+};
>+
>+kunit_test_suite(user_ns_map_test_suite);
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
