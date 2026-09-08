Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDD15540AA
	for <linux-hardening@vger.kernel.org>; Tue,  8 Sep 2026 22:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788906462; cv=none; b=e0nqy0776dC2joEaIHNKAmCUczDEt12rBafZm3Dq48udUNZcKE54qXhyX+GgNb/BGxzASZiIrTHhCzNjNCztyaR+OCJowi3rz4+xVn1Q840009VZKphSNIc3z4VMfzkZUYmUvleJ+3rfRHRrbBM1qAJMcdb03JhAzZoVy2pYTRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788906462; c=relaxed/simple;
	bh=C4xiPELUUN/LrEC5SkEQL4F3H+Ve1wBm0xHrnXTrymo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gbE+vncpnYkIwuZVUCy+qi0yzSijzxWN8HByBTr8gUUtxQlangSv1nWSCF9+s4K1he4BNZXeFvDNwp3Rckys8zrzViaqDLxsVZrGlZ4G4rFtf+8PxixMWLIJD9t7AJVYG1YQbfXeRa23WLXyllibz5A8fp1LXGCpuGhLOW0o3lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l0AFLSKG; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l0AFLSKG"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-396638f9a18so3962127a91.2
        for <linux-hardening@vger.kernel.org>; Tue, 08 Sep 2026 15:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788906460; x=1789511260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nTuIH8OjxKE5LUxJdbHjI+lQJl8fzp7MVhkB9JprYA4=;
        b=l0AFLSKGRgeZHmtlcluHFmQMAqWI2zL6TVONpykmfjHCDMZg3OxSLJmCocBu20cc1H
         4275Sc0K0DaxCQHlxRpNGh852UtOTbMYoeXo8pXyQLACWIEQqEK6tJUbIwp3DH07iO8+
         5sAFy7nuQIBvHR622KrF/0fHRItUlurg0YIs6GxjfVCBJxObTBqsoZjDfQfovG0+J4a6
         rZSie2Nej5qkKxdWI496L/64QpdbmGMJdGEMqbbL5T5kHP5Uy0biiS4XOvB7UMuOiKvD
         K7ul2e81D6fqZ+vdBUJSIu4en5xXzorU9hsRoEhuNchQ4fHspxIhYk58PmNQgZY/ZiPd
         uUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788906460; x=1789511260;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nTuIH8OjxKE5LUxJdbHjI+lQJl8fzp7MVhkB9JprYA4=;
        b=q+CkFFDZa0AIH+K7/eGr7GrNaEAMubgkfpvXKy1XigbvNgZH73VAiZVJ0YzU6z8Hme
         1uXbryMkePrS+yU/PGDYwd0bCEa5yFhOYBTiF4JLHoTkFb/fAw9JwAN4pYEjJ1FiLPjp
         OENos0M/lOTt3HZnx4RpR9YMcaLGZG4jQ+tC4n127+aXx1v7iqoJBk2ssWwTSYF0NoEN
         flGV3vogfchrqXBCAutyxnuac/hmMalB1FSQEpKxL49vZaxCqo63dgj8S1k8jSXDG0pT
         ypzluH7JM3QVe0GnRRUbW23sck4iYy9kmRjmjyzjZ5/6PknoZrtLVuipR6wSd0cQSkFg
         zauA==
X-Forwarded-Encrypted: i=1; AKwUvBwFodfY22SQncZprINJnY82XU8NcSF6zPPv8Qf5nROP1Zx5lwQvi+4sw5WO82Qi0MXY0YxyF7dQi+nPiy7LXd0=@vger.kernel.org
X-Gm-Message-State: AFuF++nqUkNx10SQxqcUZ00Im+v03U6NF4okivq6tr3e/qkBR6PAlIJS
	Mg+Uklm76JYjEhfLZCpmzoUbarFpCn6ha5sF6nYyNhbCiurp8/H3s3FfTkPXA08XRFc9YmINKNX
	2
X-Received: from pjye21.prod.google.com ([2002:a17:90a:ee15:b0:39b:97df:9ed8])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:538c:b0:38e:b400:a860
 with SMTP id 98e67ed59e1d1-39b26204a3emr49106042a91.13.1788906460047; Tue, 08
 Sep 2026 15:27:40 -0700 (PDT)
Date: Tue,  8 Sep 2026 22:27:30 +0000
In-Reply-To: <20260908222734.3048684-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260823125155.1136740-3-morbo@google.com> <20260908222734.3048684-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908222734.3048684-2-morbo@google.com>
Subject: [PATCH v5 2/2] userns: Add KUnit test suite for uid_gid_map
From: Bill Wendling <morbo@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Bill Wendling <morbo@google.com>, Bradley Morgan <brads@mainlining.org>, 
	"=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?=" <thomas.weissschuh@linutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
	Douglas Anderson <dianders@chromium.org>, Anand Moon <linux.amoon@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, codemender-patching+linux@google.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add a KUnit test suite to verify the insertion and sorting of mappings
in struct uid_gid_map. This test suite validates both base extent
insertion (<=3D 5 mappings) and extended extent insertion (> 5 mappings,
which triggers the allocation of the forward and reverse pointers).

This is especially useful for verifying that the __counted_by_ptr
attribute added to 'forward' and 'reverse' pointers works correctly
without causing any runtime bounds-checking panics or traps.

Assisted-by: Gemini:3.1-pro-preview
Signed-off-by: Bill Wendling <morbo@google.com>
Tested-by: Bradley Morgan <brads@mainlining.org>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
---
v2 - Remove Gerrit tag.
v3 - s/KUNIT_EXPECT_NOT_ERR_OR_NULL/KUNIT_ASSERT_NOT_ERR_OR_NULL/
   - Fixed Kconfig tests.
v4 - Actually test on unsorted data. Corrected the "Assisted-by" tag.
v5 - Convert the KUnit test to a format that follows the KUnit style
     guild more closely. This includes some renameing and using macros
     in the "visibility.h" header. We no longer #include the test file
     into the implementation file. This should be much cleaner.
---
Cc: Bradley Morgan <brads@mainlining.org>
Cc: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Cc: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>
Cc: Gary Guo <gary@garyguo.net>
Cc: "Thomas Wei=C3=9Fschuh" <thomas.weissschuh@linutronix.de>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Anand Moon <linux.amoon@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: codemender-patching+linux@google.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
---
 include/linux/user_namespace.h   |  6 ++
 init/Kconfig                     | 11 ++++
 kernel/Makefile                  |  1 +
 kernel/tests/.kunitconfig        |  4 ++
 kernel/tests/user_ns_map_kunit.c | 98 ++++++++++++++++++++++++++++++++
 kernel/user_namespace.c          |  8 ++-
 6 files changed, 126 insertions(+), 2 deletions(-)
 create mode 100644 kernel/tests/.kunitconfig
 create mode 100644 kernel/tests/user_ns_map_kunit.c

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.=
h
index 2962256eddf7..633157781edc 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -207,6 +207,12 @@ extern bool in_userns(const struct user_namespace *anc=
estor,
 		       const struct user_namespace *child);
 extern bool current_in_userns(const struct user_namespace *target_ns);
 struct ns_common *ns_get_owner(struct ns_common *ns);
+
+#if IS_ENABLED(CONFIG_USER_NS_MAP_KUNIT_TEST)
+extern int insert_extent(struct uid_gid_map *map, struct uid_gid_extent *e=
xtent);
+extern int sort_idmaps(struct uid_gid_map *map);
+#endif /* CONFIG_USER_NS_MAP_KUNIT_TEST */
+
 #else
=20
 static inline struct user_namespace *get_user_ns(struct user_namespace *ns=
)
diff --git a/init/Kconfig b/init/Kconfig
index 8583d9f06c52..27c1ffc675bf 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1457,6 +1457,17 @@ config USER_NS
=20
 	  If unsure, say N.
=20
+config USER_NS_MAP_KUNIT_TEST
+	tristate "KUint test for user namespace map insertion" if !KUNIT_ALL_TEST=
S
+	depends on USER_NS && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the KUnit test for user namespace uid/gid map insertion.
+	  It validates map insertion, limits, dynamic allocation of the
+	  extended extents array, and mapping sorting functions.
+
+	  If unsure, say N.
+
 config PID_NS
 	bool "PID Namespaces"
 	default y
diff --git a/kernel/Makefile b/kernel/Makefile
index 1e1a31673577..2a64282749b8 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -141,6 +141,7 @@ obj-$(CONFIG_WATCH_QUEUE) +=3D watch_queue.o
=20
 obj-$(CONFIG_RESOURCE_KUNIT_TEST) +=3D resource_kunit.o
 obj-$(CONFIG_SYSCTL_KUNIT_TEST) +=3D sysctl-test.o
+obj-$(CONFIG_USER_NS_MAP_KUNIT_TEST) +=3D tests/user_ns_map_kunit.o
=20
 CFLAGS_kstack_erase.o +=3D $(DISABLE_KSTACK_ERASE)
 CFLAGS_kstack_erase.o +=3D $(call cc-option,-mgeneral-regs-only)
diff --git a/kernel/tests/.kunitconfig b/kernel/tests/.kunitconfig
new file mode 100644
index 000000000000..b3d1206fd81a
--- /dev/null
+++ b/kernel/tests/.kunitconfig
@@ -0,0 +1,4 @@
+CONFIG_KUNIT=3Dy
+CONFIG_NAMESPACES=3Dy
+CONFIG_USER_NS=3Dy
+CONFIG_USER_NS_MAP_KUNIT_TEST=3Dy
diff --git a/kernel/tests/user_ns_map_kunit.c b/kernel/tests/user_ns_map_ku=
nit.c
new file mode 100644
index 000000000000..24c21e43a36c
--- /dev/null
+++ b/kernel/tests/user_ns_map_kunit.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for user namespace map insertion and sorting.
+ */
+
+#define pr_fmt(fmt) "user_namespace: " fmt
+
+#include <kunit/test.h>
+#include <linux/user_namespace.h>
+
+#define NR_EXTENTS (UID_GID_MAP_MAX_BASE_EXTENTS + 5)
+
+static void user_ns_map_insert(struct kunit *test)
+{
+	struct uid_gid_map map;
+	struct uid_gid_extent extent;
+	int i, ret;
+
+	memset(&map, 0, sizeof(map));
+
+	/* Insert up to UID_GID_MAP_MAX_BASE_EXTENTS elements */
+	for (i =3D 0; i < UID_GID_MAP_MAX_BASE_EXTENTS; i++) {
+		extent.first =3D i * 10;
+		extent.lower_first =3D i * 100;
+		extent.count =3D 5;
+
+		ret =3D insert_extent(&map, &extent);
+		KUNIT_ASSERT_EQ(test, ret, 0);
+	}
+
+	KUNIT_EXPECT_EQ(test, map.nr_extents, UID_GID_MAP_MAX_BASE_EXTENTS);
+
+	/* Verify the elements ended up in the 'extent' array */
+	for (i =3D 0; i < UID_GID_MAP_MAX_BASE_EXTENTS; i++) {
+		KUNIT_EXPECT_EQ(test, map.extent[i].first, i * 10);
+		KUNIT_EXPECT_EQ(test, map.extent[i].lower_first, i * 100);
+		KUNIT_EXPECT_EQ(test, map.extent[i].count, 5);
+	}
+}
+
+static void user_ns_map_insert_extended(struct kunit *test)
+{
+	struct uid_gid_map map;
+	struct uid_gid_extent extent;
+	int i, ret;
+
+	memset(&map, 0, sizeof(map));
+
+	/* Insert more than UID_GID_MAP_MAX_BASE_EXTENTS elements */
+	for (i =3D 0; i < NR_EXTENTS; i++) {
+		int value =3D 9 - i;
+
+		extent.first =3D value * 10;
+		extent.lower_first =3D value * 100;
+		extent.count =3D 5;
+
+		ret =3D insert_extent(&map, &extent);
+		KUNIT_ASSERT_EQ(test, ret, 0);
+	}
+
+	KUNIT_EXPECT_EQ(test, map.nr_extents, NR_EXTENTS);
+
+	/* Now sort the map to set up reverse mapping */
+	ret =3D sort_idmaps(&map);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, map.reverse);
+
+	/* Verify the elements are in 'forward' and that sorting is correct */
+	for (i =3D 0; i < map.nr_extents; i++) {
+		KUNIT_EXPECT_EQ(test, map.forward[i].first, i * 10);
+		KUNIT_EXPECT_EQ(test, map.forward[i].lower_first, i * 100);
+		KUNIT_EXPECT_EQ(test, map.forward[i].count, 5);
+
+		KUNIT_EXPECT_EQ(test, map.reverse[i].first, i * 10);
+		KUNIT_EXPECT_EQ(test, map.reverse[i].lower_first, i * 100);
+		KUNIT_EXPECT_EQ(test, map.reverse[i].count, 5);
+	}
+
+	kfree(map.forward);
+	kfree(map.reverse);
+}
+
+static struct kunit_case user_ns_map_test_cases[] =3D {
+	KUNIT_CASE(user_ns_map_insert),
+	KUNIT_CASE(user_ns_map_insert_extended),
+	{}
+};
+
+static struct kunit_suite user_ns_map_test_suite =3D {
+	.name =3D "user_ns_map",
+	.test_cases =3D user_ns_map_test_cases,
+};
+
+kunit_test_suite(user_ns_map_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit test for user namespace map insertion");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 786dbf0506ca..d8cbefd36598 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
=20
+#include <kunit/visibility.h>
 #include <linux/export.h>
 #include <linux/nsproxy.h>
 #include <linux/slab.h>
@@ -786,7 +787,8 @@ static bool mappings_overlap(struct uid_gid_map *new_ma=
p,
  * Takes care to allocate a 4K block of memory if the number of mappings e=
xceeds
  * UID_GID_MAP_MAX_BASE_EXTENTS.
  */
-static int insert_extent(struct uid_gid_map *map, struct uid_gid_extent *e=
xtent)
+VISIBLE_IF_KUNIT int insert_extent(struct uid_gid_map *map,
+				   struct uid_gid_extent *extent)
 {
 	struct uid_gid_extent *dest;
=20
@@ -822,6 +824,7 @@ static int insert_extent(struct uid_gid_map *map, struc=
t uid_gid_extent *extent)
 	*dest =3D *extent;
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(insert_extent);
=20
 /* cmp function to sort() forward mappings */
 static int cmp_extents_forward(const void *a, const void *b)
@@ -857,7 +860,7 @@ static int cmp_extents_reverse(const void *a, const voi=
d *b)
  * sort_idmaps - Sorts an array of idmap entries.
  * Can only be called if number of mappings exceeds UID_GID_MAP_MAX_BASE_E=
XTENTS.
  */
-static int sort_idmaps(struct uid_gid_map *map)
+VISIBLE_IF_KUNIT int sort_idmaps(struct uid_gid_map *map)
 {
 	if (map->nr_extents <=3D UID_GID_MAP_MAX_BASE_EXTENTS)
 		return 0;
@@ -878,6 +881,7 @@ static int sort_idmaps(struct uid_gid_map *map)
=20
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(sort_idmaps);
=20
 /**
  * verify_root_map() - check the uid 0 mapping
--=20
2.55.0.979.g7e5102b832-goog

