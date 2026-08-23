Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1029D38CFE8
	for <linux-hardening@vger.kernel.org>; Sun, 23 Aug 2026 12:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787489521; cv=none; b=gvpA7HyEp+yjwuCGzfV2Ou4BVyWm9Mp4+WoHs4BZuUBhl9/tSp8GJYvSwzA5B3ZWIu5ZxCjrNt/QjbSNb2Ea+i29ya3aF5Gh4KOuzrUdssng3pJX+kVoCEdhtpy1OjMYhcPPQsbpPfd1uaqLbIN77sC7Mq2elrhnfoDkSAQs/Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787489521; c=relaxed/simple;
	bh=hT53fJ/77VLdIobcjfLUB2EbnU5TUGJsfyHBZ7/PypE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KwXhBpseDGTHfLz39GwtvJdPR03gXtXDnhKHj3GZujaH/CyZXYgIcrymKGIFbS9/Ky5F2oEtMV2sHpqfwCZYxCHIafiU6HilmMx837GhGnEdjzFWvz/m0BDzEQfA+QuMy0oC/oLQ5MuD95bxBCYhVodInCgs6lBa4YtQbL9E5R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j5Prqecx; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j5Prqecx"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cccfa32670so41180405ad.2
        for <linux-hardening@vger.kernel.org>; Sun, 23 Aug 2026 05:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787489519; x=1788094319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/6GuAAUwAMI1WHNA8K+fgQT1FDdUgoWfjJ9wdukQyWY=;
        b=j5PrqecxXxFt2SRcA1YcMS9AH66O/FD5diukC6yVFNcikl01xCmmEmUGc3OuJUaZE1
         shDQOPNMZA0HnAgV6BC15mAZZtB1A/T0D1D2xapdRmz+Mbl/y8U+ZB58gtXXY+lDETk9
         Jblyy+KuCSMoeAQWqVdLqkF8gxDeIAKRPCH94gsP5IWS/TwCeEBMq3M2cynkTbQLr/40
         IEhb6YtBY9G7AiCcXTjaZO+JaqgM/u54GkcRbM1sdn2zAEhCORu+6tatlOMwZpoZU4HB
         oJKBtAju1K/Pj4LPuCxDJ23teErBzW123X/831wR5saR6J4y1oVEllVwKDavU4DaSPPy
         QZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787489519; x=1788094319;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/6GuAAUwAMI1WHNA8K+fgQT1FDdUgoWfjJ9wdukQyWY=;
        b=TK7JXZXcVvc4AzV2TRk0ofKhxgWLrKFS0ZhxE1IyJJ1jJTqkWQ4k0JUksCOgrrPc7K
         xbwUxg0ZCBWHpGBW7iz+r8J/vZNHqPPmYEkB93c4B+Whp3b/iZr8ewYbijt5tolvihkS
         5f9rNiAUo9rm4Jqi4GPAquEOVNqfOLE3MNb7K3TfzQqqk833Bxg85Oq9VH7qIub1dQxW
         AkUMBwaL2itlxhyZdy/6Fi+GUkUuQ7gFq+8IgiYSFa8cI5VfDSrPi+e9peHa8EYuvRfd
         OeKQnX5apBjKuqR9abPZdk6XjqOCld77JIWTkg/WMx33TR2+Ctm+X/uqyYCx8SxZcSes
         RBIQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq0G+lz9ICu9GBzIKGOeZb6zgW5dCdiXKji14Cy+KQTMFOoMXqpDuFdwPVrG+DnzMYNzEMTM0NgUArt1c7ZUZM=@vger.kernel.org
X-Gm-Message-State: AFuF++kx5gkar3Pe/cX9RJcsp1HKJM7Sw+oPO1pRyvtewvIB+RlhnP/M
	d61Jaq/VE8M4uJGjChDoIINrs5F7MT19VYkE8WCnvdg7N+1pqLK84/EEUSom5xgJ+gu8MidmNpk
	A
X-Received: from pltk5.prod.google.com ([2002:a17:902:6945:b0:2d5:9dd2:5fc6])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:fa6:b0:2d6:5beb:8692
 with SMTP id d9443c01a7336-2d670bb5042mr219445355ad.6.1787489519251; Sun, 23
 Aug 2026 05:51:59 -0700 (PDT)
Date: Sun, 23 Aug 2026 12:51:48 +0000
In-Reply-To: <20260823125155.1136740-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260823125155.1136740-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260823125155.1136740-3-morbo@google.com>
Subject: [PATCH 2/2] userns: Add KUnit test suite for uid_gid_map
From: Bill Wendling <morbo@google.com>
To: linux-kernel@vger.kernel.org
Cc: Bill Wendling <morbo@google.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?=" <thomas.weissschuh@linutronix.de>, Alice Ryhl <aliceryhl@google.com>, 
	Douglas Anderson <dianders@chromium.org>, Anand Moon <linux.amoon@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, codemender-patching+linux@google.com, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add a KUnit test suite to verify the insertion and sorting of mappings
in struct uid_gid_map. This test suite validates both base extent
insertion (<=3D 5 mappings) and extended extent insertion (> 5 mappings,
which triggers the allocation of the forward and reverse pointers).

This is especially useful for verifying that the __counted_by_ptr
attribute added to 'forward' and 'reverse' pointers works correctly
without causing any runtime bounds-checking panics or traps.

Assisted-by: Gemini Next
Change-Id: If0c2c197a35cd7429cf0d2d6e3b33f0d9f0be66c
Signed-off-by: Bill Wendling <morbo@google.com>
---
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
 init/Kconfig                  | 10 ++++
 kernel/.kunitconfig           |  3 ++
 kernel/user_namespace.c       |  4 ++
 kernel/user_namespace_kunit.c | 87 +++++++++++++++++++++++++++++++++++
 4 files changed, 104 insertions(+)
 create mode 100644 kernel/.kunitconfig
 create mode 100644 kernel/user_namespace_kunit.c

diff --git a/init/Kconfig b/init/Kconfig
index f63bf5e05e79..ba6a40b7315a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1457,6 +1457,16 @@ config USER_NS
=20
 	  If unsure, say N.
=20
+config USER_NAMESPACE_KUNIT_TEST
+	tristate "KUnit test for user namespace map insertion" if !KUNIT_ALL_TEST=
S
+	depends on USER_NS && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the KUnit test for user namespace uid/gid map insertion.
+	  It validates map insertion, limits, dynamic allocation of the
+	  extended extents array, and mapping sorting functions.
+	  If unsure, say N.
+
 config PID_NS
 	bool "PID Namespaces"
 	default y
diff --git a/kernel/.kunitconfig b/kernel/.kunitconfig
new file mode 100644
index 000000000000..7314dce05dc2
--- /dev/null
+++ b/kernel/.kunitconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=3Dy
+CONFIG_USER_NS=3Dy
+CONFIG_USER_NAMESPACE_KUNIT_TEST=3Dy
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 7e5371d8f515..64c64e1028e8 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1413,3 +1413,7 @@ static __init int user_namespaces_init(void)
 	return 0;
 }
 subsys_initcall(user_namespaces_init);
+
+#if IS_ENABLED(CONFIG_USER_NAMESPACE_KUNIT_TEST)
+#include "user_namespace_kunit.c"
+#endif
diff --git a/kernel/user_namespace_kunit.c b/kernel/user_namespace_kunit.c
new file mode 100644
index 000000000000..6d7662ef1916
--- /dev/null
+++ b/kernel/user_namespace_kunit.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for user namespace map insertion and sorting.
+ */
+
+#include <kunit/test.h>
+#include <linux/user_namespace.h>
+
+static void test_user_ns_map_insert_base(struct kunit *test)
+{
+	struct uid_gid_map map;
+	struct uid_gid_extent extent;
+	int i, ret;
+
+	memset(&map, 0, sizeof(map));
+
+	/* Insert up to UID_GID_MAP_MAX_BASE_EXTENTS (5) elements */
+	for (i =3D 0; i < UID_GID_MAP_MAX_BASE_EXTENTS; i++) {
+		extent.first =3D i * 10;
+		extent.lower_first =3D i * 100;
+		extent.count =3D 5;
+
+		ret =3D insert_extent(&map, &extent);
+		KUNIT_EXPECT_EQ(test, ret, 0);
+		KUNIT_EXPECT_EQ(test, map.nr_extents, i + 1);
+		KUNIT_EXPECT_EQ(test, map.extent[i].first, i * 10);
+		KUNIT_EXPECT_EQ(test, map.extent[i].lower_first, i * 100);
+		KUNIT_EXPECT_EQ(test, map.extent[i].count, 5);
+	}
+}
+
+static void test_user_ns_map_insert_extended(struct kunit *test)
+{
+	struct uid_gid_map map;
+	struct uid_gid_extent extent;
+	int i, ret;
+
+	memset(&map, 0, sizeof(map));
+
+	/* Insert more than UID_GID_MAP_MAX_BASE_EXTENTS (e.g., 10) elements */
+	for (i =3D 0; i < 10; i++) {
+		extent.first =3D i * 10;
+		extent.lower_first =3D i * 100;
+		extent.count =3D 5;
+
+		ret =3D insert_extent(&map, &extent);
+		KUNIT_EXPECT_EQ(test, ret, 0);
+		KUNIT_EXPECT_EQ(test, map.nr_extents, i + 1);
+
+		if (i < UID_GID_MAP_MAX_BASE_EXTENTS) {
+			KUNIT_EXPECT_EQ(test, map.extent[i].first, i * 10);
+		} else {
+			KUNIT_EXPECT_NOT_ERR_OR_NULL(test, map.forward);
+			KUNIT_EXPECT_EQ(test, map.forward[i].first, i * 10);
+			KUNIT_EXPECT_EQ(test, map.forward[i].lower_first, i * 100);
+			KUNIT_EXPECT_EQ(test, map.forward[i].count, 5);
+		}
+	}
+
+	/* Now sort the map to set up reverse mapping */
+	ret =3D sort_idmaps(&map);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, map.reverse);
+
+	/* Verify sorting is correct */
+	for (i =3D 0; i < map.nr_extents; i++) {
+		KUNIT_EXPECT_EQ(test, map.forward[i].count, 5);
+		KUNIT_EXPECT_EQ(test, map.reverse[i].count, 5);
+	}
+
+	/* Clean up allocations to avoid leaks */
+	kfree(map.forward);
+	kfree(map.reverse);
+}
+
+static struct kunit_case user_ns_map_test_cases[] =3D {
+	KUNIT_CASE(test_user_ns_map_insert_base),
+	KUNIT_CASE(test_user_ns_map_insert_extended),
+	{}
+};
+
+static struct kunit_suite user_ns_map_test_suite =3D {
+	.name =3D "user_ns_map",
+	.test_cases =3D user_ns_map_test_cases,
+};
+
+kunit_test_suite(user_ns_map_test_suite);
--=20
2.55.0.860.g4b6b3295ed-goog

