Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23573BB9E3
	for <linux-hardening@vger.kernel.org>; Sun, 23 Aug 2026 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787489639; cv=none; b=MQlNOc4p7P8NVcg0iN+BDm7+8tdAjA68FfuNsTbV02GbRk4AIajZo5Y3iT7wIoFKBVI8bM29+BNr2mW4pS+T1kfnMh0dzIDgc+RDIqxjJN9EkXeOz8kgbiU0pF+OFRI4TXFOE8qECBKjglC79kPpZnmUIdmn62iAwQxt5i/p3xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787489639; c=relaxed/simple;
	bh=pfDE5ilD9/MtOD5boSCr08GTdZALEQjop9G7ZZhYAOo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 Cc:Content-Type; b=GeZklDCwjajPKcQpU6w9x380CGep0TK14m0gsZyvr3i12OBXh3bZjaEG1uY7fExSjGnWA0R34wGFyg247JCC+mDS4GaF0pXnNqQ4GSvZV8aLHRLPBRB6PIjjh7Zu7tD3yXFbyhwBIzjGQjUjL3C1l8tJoIpprpIBAVSX1Ui2PW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vv3UMmuU; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vv3UMmuU"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cacf17c7e0so40674125ad.0
        for <linux-hardening@vger.kernel.org>; Sun, 23 Aug 2026 05:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787489635; x=1788094435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:from:subject:message-id
         :references:mime-version:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2j+jEL9TnE7Z2fsNxTUFdS1e1dXzn2rwQVASjQh/j0E=;
        b=vv3UMmuUprsAZJFH9ENRpdUM/mkwoeOjTY0i6gTGz8BOnplqaDwnY9l99Hhv/NwR+n
         Bl0J71+NtlyKTiq19H4O98KfrcF/XnOPiwm9ZvtHZrpROOLMzKQgj5d+IooAO15YcGb1
         PexWEp1u6edE4WG1IBaFHWegCZZLVW+iJChay9wTJ6V+c/wQrWh3KmCNobuqwxhfvqhL
         +j5H7Ph7Jl7xbF8vbRMDopcpD/odWOvRG6oQIXmwo32HG90BFTCJJi1Iz2l+ZRqadsiI
         P5AbPaNGsZDoBzvKnocGtiQpAx7mAH9yBdV5uF368gqMIEA9/bdjK2tsdnwUEX5XozEr
         ulJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787489635; x=1788094435;
        h=content-transfer-encoding:content-type:cc:from:subject:message-id
         :references:mime-version:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2j+jEL9TnE7Z2fsNxTUFdS1e1dXzn2rwQVASjQh/j0E=;
        b=nif9SnnZzXzREej2hyMaXFjGhBPp5y7PTm5vUGzjbgoCUg0HQMeeyDGQJXzb7SB+mS
         d1xSIbatOeVsmo80ABdO0/rcU/uRt0gfGfg5Ze4j0Jx9/81GZlkA5PqKYI5AT462ksDb
         nHw5yN3mADzImTbnQMoQCsnSM9O8cMTw5nkO9qd2SUaRrR8o6p01eQICP84z6CahNrcq
         0xOyrNccqyYbBOYk9DuZ5Tt7A2jxYNB/+PQGMjDnQwztYXvFE4hsxJEjApVhUxKqX0ik
         MIIyHr1OWhiF7S51Bj+MzM1M4MLHhcSYlOM/50iJV5Yw2u9VaVV02jokuV9FAUXGWivT
         ZQaw==
X-Forwarded-Encrypted: i=1; AHgh+RofznzXetzqi+oWW1k8Vfs50Ra/J4aT0N2w4ocPLmaAj6YaZyYZH4XBVbpnmkcoI9RngHj9MsdtL5glSxYlGBY=@vger.kernel.org
X-Gm-Message-State: AFuF++m4auXyzHUC0zvkHSCLzyHLeoKlBa+scv5I35LO5mAwQPuO2qWe
	PoWK5Rsq0u20eNyLQJ3YYWVn/R7kKiRZuAfeI/ZdCjQnqD73+UH54sAWImd4Vcr1ToJjnuSkjAD
	e
X-Received: from plk19.prod.google.com ([2002:a17:902:e9d3:b0:2d1:1cf0:2039])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec87:b0:2cf:9347:f445
 with SMTP id d9443c01a7336-2d64b024c86mr319174525ad.10.1787489635107; Sun, 23
 Aug 2026 05:53:55 -0700 (PDT)
Date: Sun, 23 Aug 2026 12:53:44 +0000
In-Reply-To: <20260823125155.1136740-3-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260823125155.1136740-3-morbo@google.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260823125348.1138649-1-morbo@google.com>
Subject: [PATCH 2/2] userns: Add KUnit test suite for uid_gid_map
From: Bill Wendling <morbo@google.com>
Cc: Bill Wendling <morbo@google.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?=" <thomas.weissschuh@linutronix.de>, Alice Ryhl <aliceryhl@google.com>, 
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

Assisted-by: Gemini Next
Signed-off-by: Bill Wendling <morbo@google.com>
---
v2 - Remove Gerrit tag.
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

