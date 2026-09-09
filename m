Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60F156510E;
	Wed,  9 Sep 2026 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788968237; cv=none; b=iTcaIWses7xh4sMZZwe+X29fnk20+oNwd86bsjqr9PmoSdQG5M0mivnY0SH/GMtVYYvj3YXpWHkRIvPCt6HlijC73liTW7jexzlisyyLbEvuURPkMHX52Il28JTZxyJawIGHlsQyLyuSks1J6SeMeCbSwpTw78xR4uyCkJHhTMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788968237; c=relaxed/simple;
	bh=luQVRUXy09UsxsSG4VuBiLocK41frDwj1A+LRi22K5M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=MMDdtQ+mSjYxpRrkHMPSZfrZdBQlKDZDgm0wzPevKsjEmRBIK9zbN4DkxKPzoQwL1NEhKIlJNNPwItFdb5rrWFNfe0msQGh8pE/vGvYenBv+rWm1HKvzcS6OAzB3LQ5my+YlsjHRLkpexwKomcg3IxGP7vjCv5Pt5x/nfVG0jDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=qr58ZPVv; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=i4GG0YOh; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="qr58ZPVv";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="i4GG0YOh"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788968210; bh=fkFSCvdo5LuLSf4z3fmclGB
	fz86uj6dQWp9LPZ/W2Cc=; b=qr58ZPVvmSgO7ouudvb9sgozM1OhTDQHmoyq9tLnlyOcg/9IZw
	bzWRnyrFtuxAYFXRwClGWmLdnkYenedlyqYk8iRGVf5c/KjrkRP3DMTb6mAyFIMOqjZPvaOTlFE
	w8ncjbttLVj4BeaiBvO6YmZZbUP3VpI8SvC42xV4y3sZQb2qUNFV13vhO8O1g2exPGBXMhV1NPr
	iZs3eEUcGnYPvVOBCpcVPYZ/jv0sVcyqlqf82IsjcTnPu2qn3WlBbwEOGq5Qipl/6gXBGaw958j
	1r9sB7fHM8agdNQXnrXgvU49UItbL/UlLP9d1Q/6ZUrR8jP4hHGJh4Mn/2QTqF+3caQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788968210; bh=fkFSCvdo5LuLSf4z3fmclGB
	fz86uj6dQWp9LPZ/W2Cc=; b=i4GG0YOhB54yf77Rqasf/C5eiqMaIWC2PVXaz+F7qafpWLRZJu
	IKQqOoayQG0TEV8AQg78HSScL6oRwAtz1/AQ==;
Date: Wed, 09 Sep 2026 16:36:49 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Bill Wendling <morbo@google.com>, Christian Brauner <brauner@kernel.org>
CC: =?ISO-8859-1?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>,
 Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>,
 Douglas Anderson <dianders@chromium.org>, Anand Moon <linux.amoon@gmail.com>,
 Oleg Nesterov <oleg@redhat.com>, codemender-patching+linux@google.com,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 2/2] userns: Add KUnit test suite for uid_gid_map
In-Reply-To: <20260908222734.3048684-2-morbo@google.com>
References: <20260823125155.1136740-3-morbo@google.com> <20260908222734.3048684-1-morbo@google.com> <20260908222734.3048684-2-morbo@google.com>
Message-ID: <76DEB9F0-5263-4AB0-816F-71A57F3B67BB@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 8 September 2026 23:27:30 BST, Bill Wendling <morbo@google.com> wrote:
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
>Signed-off-by: Bill Wendling <morbo@google.com>
>Tested-by: Bradley Morgan <brads@mainlining.org>
>Reviewed-by: Bradley Morgan <brads@mainlining.org>
>---
>v2 - Remove Gerrit tag.
>v3 - s/KUNIT_EXPECT_NOT_ERR_OR_NULL/KUNIT_ASSERT_NOT_ERR_OR_NULL/
>   - Fixed Kconfig tests.
>v4 - Actually test on unsorted data. Corrected the "Assisted-by" tag.
>v5 - Convert the KUnit test to a format that follows the KUnit style
>     guild more closely. This includes some renameing and using macros
>     in the "visibility.h" header. We no longer #include the test file
>     into the implementation file. This should be much cleaner.
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
> include/linux/user_namespace.h   |  6 ++
> init/Kconfig                     | 11 ++++
> kernel/Makefile                  |  1 +
> kernel/tests/.kunitconfig        |  4 ++
> kernel/tests/user_ns_map_kunit.c | 98 ++++++++++++++++++++++++++++++++
> kernel/user_namespace.c          |  8 ++-
> 6 files changed, 126 insertions(+), 2 deletions(-)
> create mode 100644 kernel/tests/.kunitconfig
> create mode 100644 kernel/tests/user_ns_map_kunit.c
>
>diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
>index 2962256eddf7..633157781edc 100644
>--- a/include/linux/user_namespace.h
>+++ b/include/linux/user_namespace.h
>@@ -207,6 +207,12 @@ extern bool in_userns(const struct user_namespace *ancestor,
> 		       const struct user_namespace *child);
> extern bool current_in_userns(const struct user_namespace *target_ns);
> struct ns_common *ns_get_owner(struct ns_common *ns);
>+
>+#if IS_ENABLED(CONFIG_USER_NS_MAP_KUNIT_TEST)
>+extern int insert_extent(struct uid_gid_map *map, struct uid_gid_extent *extent);
>+extern int sort_idmaps(struct uid_gid_map *map);
>+#endif /* CONFIG_USER_NS_MAP_KUNIT_TEST */
>+
> #else
> 
> static inline struct user_namespace *get_user_ns(struct user_namespace
> *ns)
>diff --git a/init/Kconfig b/init/Kconfig
>index 8583d9f06c52..27c1ffc675bf 100644
>--- a/init/Kconfig
>+++ b/init/Kconfig
>@@ -1457,6 +1457,17 @@ config USER_NS
> 
> 	  If unsure, say N.
> 
>+config USER_NS_MAP_KUNIT_TEST
>+	tristate "KUint test for user

Hmm! s/KUint/KUnit

 namespace map insertion" if !KUNIT_ALL_TESTS
>+	depends on USER_NS && KUNIT
>+	default KUNIT_ALL_TESTS
>+	help
>+	  This builds the KUnit test for user namespace uid/gid map insertion.
>+	  It validates map insertion, limits, dynamic allocation of the
>+	  extended extents array, and mapping sorting functions.
>+
>+	  If unsure, say N.
>+
> config PID_NS
> 	bool "PID Namespaces"
> 	default y
>diff --git a/kernel/Makefile b/kernel/Makefile
>index 1e1a31673577..2a64282749b8 100644
>--- a/kernel/Makefile
>+++ b/kernel/Makefile
>@@ -141,6 +141,7 @@ obj-$(CONFIG_WATCH_QUEUE) += watch_queue.o
> 
> obj-$(CONFIG_RESOURCE_KUNIT_TEST) += resource_kunit.o
> obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
>+obj-$(CONFIG_USER_NS_MAP_KUNIT_TEST) += tests/user_ns_map_kunit.o
> 
> CFLAGS_kstack_erase.o += $(DISABLE_KSTACK_ERASE)
> CFLAGS_kstack_erase.o += $(call cc-option,-mgeneral-regs-only)
>diff --git a/kernel/tests/.kunitconfig b/kernel/tests/.kunitconfig
>new file mode 100644
>index 000000000000..b3d1206fd81a
>--- /dev/null
>+++ b/kernel/tests/.kunitconfig
>@@ -0,0 +1,4 @@
>+CONFIG_KUNIT=y
>+CONFIG_NAMESPACES=y
>+CONFIG_USER_NS=y
>+CONFIG_USER_NS_MAP_KUNIT_TEST=y
>diff --git a/kernel/tests/user_ns_map_kunit.c b/kernel/tests/user_ns_map_kunit.c
>new file mode 100644
>index 000000000000..24c21e43a36c
>--- /dev/null
>+++ b/kernel/tests/user_ns_map_kunit.c
>@@ -0,0 +1,98 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/*
>+ * KUnit test for user namespace map insertion and sorting.
>+ */
>+
>+#define pr_fmt(fmt) "user_namespace: " fmt
>+
>+#include <kunit/test.h>
>+#include <linux/user_namespace.h>
>+
>+#define NR_EXTENTS (UID_GID_MAP_MAX_BASE_EXTENTS + 5)
>+
>+static void user_ns_map_insert(struct kunit *test)
>+{
>+	struct uid_gid_map map;
>+	struct uid_gid_extent extent;
>+	int i, ret;
>+
>+	memset(&map, 0, sizeof(map));
>+
>+	/* Insert up to UID_GID_MAP_MAX_BASE_EXTENTS elements */
>+	for (i = 0; i < UID_GID_MAP_MAX_BASE_EXTENTS; i++) {
>+		extent.first = i * 10;
>+		extent.lower_first = i * 100;
>+		extent.count = 5;
>+
>+		ret = insert_extent(&map, &extent);
>+		KUNIT_ASSERT_EQ(test, ret, 0);
>+	}
>+
>+	KUNIT_EXPECT_EQ(test, map.nr_extents, UID_GID_MAP_MAX_BASE_EXTENTS);
>+
>+	/* Verify the elements ended up in the 'extent' array */
>+	for (i = 0; i < UID_GID_MAP_MAX_BASE_EXTENTS; i++) {
>+		KUNIT_EXPECT_EQ(test, map.extent[i].first, i * 10);
>+		KUNIT_EXPECT_EQ(test, map.extent[i].lower_first, i * 100);
>+		KUNIT_EXPECT_EQ(test, map.extent[i].count, 5);
>+	}
>+}
>+
>+static void user_ns_map_insert_extended(struct kunit *test)
>+{
>+	struct uid_gid_map map;
>+	struct uid_gid_extent extent;
>+	int i, ret;
>+
>+	memset(&map, 0, sizeof(map));
>+
>+	/* Insert more than UID_GID_MAP_MAX_BASE_EXTENTS elements */
>+	for (i = 0; i < NR_EXTENTS; i++) {
>+		int value = 9 - i;
>+
>+		extent.first = value * 10;
>+		extent.lower_first = value * 100;
>+		extent.count = 5;
>+
>+		ret = insert_extent(&map, &extent);
>+		KUNIT_ASSERT_EQ(test, ret, 0);
>+	}
>+
>+	KUNIT_EXPECT_EQ(test, map.nr_extents, NR_EXTENTS);
>+
>+	/* Now sort the map to set up reverse mapping */
>+	ret = sort_idmaps(&map);
>+	KUNIT_ASSERT_EQ(test, ret, 0);
>+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, map.reverse);
>+
>+	/* Verify the elements are in 'forward' and that sorting is correct */
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
>+	KUNIT_CASE(user_ns_map_insert),
>+	KUNIT_CASE(user_ns_map_insert_extended),
>+	{}
>+};
>+
>+static struct kunit_suite user_ns_map_test_suite = {
>+	.name = "user_ns_map",
>+	.test_cases = user_ns_map_test_cases,
>+};
>+
>+kunit_test_suite(user_ns_map_test_suite);
>+
>+MODULE_LICENSE("GPL");
>+MODULE_DESCRIPTION("KUnit test for user namespace map insertion");
>+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
>diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
>index 786dbf0506ca..d8cbefd36598 100644
>--- a/kernel/user_namespace.c
>+++ b/kernel/user_namespace.c
>@@ -1,5 +1,6 @@
> // SPDX-License-Identifier: GPL-2.0-only
> 
>+#include <kunit/visibility.h>
> #include <linux/export.h>
> #include <linux/nsproxy.h>
> #include <linux/slab.h>
>@@ -786,7 +787,8 @@ static bool mappings_overlap(struct uid_gid_map *new_map,
>  * Takes care to allocate a 4K block of memory if the number of mappings exceeds
>  * UID_GID_MAP_MAX_BASE_EXTENTS.
>  */
>-static int insert_extent(struct uid_gid_map *map, struct uid_gid_extent *extent)
>+VISIBLE_IF_KUNIT int insert_extent(struct uid_gid_map *map,
>+				   struct uid_gid_extent *extent)
> {
> 	struct uid_gid_extent *dest;
> 
>@@ -822,6 +824,7 @@ static int insert_extent(struct uid_gid_map *map, struct uid_gid_extent *extent)
> 	*dest = *extent;
> 	return 0;
> }
>+EXPORT_SYMBOL_IF_KUNIT(insert_extent);
> 
> /* cmp function to sort() forward mappings */
> static int cmp_extents_forward(const void *a, const void *b)
>@@ -857,7 +860,7 @@ static int cmp_extents_reverse(const void *a, const void *b)
>  * sort_idmaps - Sorts an array of idmap entries.
>  * Can only be called if number of mappings exceeds UID_GID_MAP_MAX_BASE_EXTENTS.
>  */
>-static int sort_idmaps(struct uid_gid_map *map)
>+VISIBLE_IF_KUNIT int sort_idmaps(struct uid_gid_map *map)
> {
> 	if (map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
> 		return 0;
>@@ -878,6 +881,7 @@ static int sort_idmaps(struct uid_gid_map *map)
> 
> 	return 0;
> }
>+EXPORT_SYMBOL_IF_KUNIT(sort_idmaps);
> 
> /**
>  * verify_root_map() - check the uid 0 mapping
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
