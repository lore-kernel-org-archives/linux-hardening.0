Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6F144E651
	for <linux-hardening@vger.kernel.org>; Wed, 26 Aug 2026 20:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787777010; cv=none; b=ijyfzQLkhx3QnHAeA4787dLPz22FhbCHapuu1Uk9VVr4aHo3l50QaqCwvza3azllp4zJRKp4tJm7MQigd03Q7TeuAWPSCo71piHWieotE5BMDhcp4Pp+TEnRlNGsqF/qAuoCcQe0VjRdE8Ym/njeXAPMx4WQpGjwmtkPO0rRcGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787777010; c=relaxed/simple;
	bh=+wvIFJde0eGzV7xbbKkkI48jk0bMcja36Ofn4X9f18g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 Cc:Content-Type; b=uD+un7KF8zPL+caJk0Ip7XAPnJpc3LS5X22SYyIAEE3yOtXpKvQnUxYOy4IZcCulaeep7gmcwuWzXw6xWA0bPf2f+6L+FJUW9Z+v6jQbX6uW/sCc4aR1GVqMTy2bMUdXk56A/9asdicBu2LtTnAfQvgQScQYVrI7BszDcctFRMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mVCjMB5/; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mVCjMB5/"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ce8a76df2dso27480205ad.2
        for <linux-hardening@vger.kernel.org>; Wed, 26 Aug 2026 13:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787777008; x=1788381808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:from:subject:message-id
         :references:mime-version:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B3rNRO0DQLiTL2MF3mmKESEPiAVFJRAni21Ahkz6nEM=;
        b=mVCjMB5/eBwAKBmeJaTjc1lagBfcqOnvl59ZCt7ZudOWa09bgHFJuYMK82iJbh3rhM
         296scy+vEjXWcYwn9c7Rat1NtakblsHcllUlEii+nQdSvf3JFE7PtENgQ6MUzsmMzCs/
         c02BY3NVCTy+zrACqcz+zNKLKXM8fLFOTd6UT+i7RDyQjHfNpyqcJlytBs9wvdphVxWo
         vj78B2fTWhGMn/ldLJIcg+IzoVOBTglZiweWqSJzzGeXalOcf4q2RW5Y0H/jLPwXz1/D
         uN6Z9hAPMIu3mL0A/Ye7QFCK1T3u3/AFyRCHfL486JEN/iAPhsU2sHX8B9+28Xatelhm
         6GKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787777008; x=1788381808;
        h=content-transfer-encoding:content-type:cc:from:subject:message-id
         :references:mime-version:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=B3rNRO0DQLiTL2MF3mmKESEPiAVFJRAni21Ahkz6nEM=;
        b=aKNuvCODlKlsTY9mrM6MFan7Fc3zDK0/jpsYYuSu8UyD+6+EbAg9e9cAh6Ya6q6wbF
         LRTVWSi6Rr4L2sJXuruBqkP+vLwHp7ydl8+tFXc41J9QsnjCUQk0F/DOeVvUz9KPOjRy
         kR7M8kvaGAlq5nBDyofOfBcpx8rfF1ejcHvvyAbueQSXz427GkoMGp5Bxk9VkTfeA1F4
         ypT5ZoETGZAVzG6yV4WlFpoALFh795GNVSMcnBM9o72GZ7pFUpiJGyZMAK30SS6sXxsK
         HcdTt6AxwQVbrrBtvavhxWXMPf2MalHuIj1rgBCEtIR7UTU+pIoKH6AjrZgYdijpwtkC
         gJRg==
X-Forwarded-Encrypted: i=1; AHgh+RoPwI7npLckjKYEXyvdwTodS8PaaRpjuw1QBrxe2NpWs3XZ5OrY79fAnDVGaTnhblwNxL18rKJ2DgBl8P4ttTo=@vger.kernel.org
X-Gm-Message-State: AFuF++mu/XbJWc+Y85+g9AAXJgMTy+u/2D/sAMkzPJy3ismGEt3PIeAP
	V+eKtVrJTJoBt1vZNHZnUUIjKW5zp9f7p8c8IsnBSsmGLJy3ROxzJWKIWHLYt8XLC+O2lOWULOG
	w
X-Received: from plblc14.prod.google.com ([2002:a17:902:fa8e:b0:2d5:62cd:db79])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19ed:b0:2d7:107c:917b
 with SMTP id d9443c01a7336-2d7107c934fmr150202705ad.0.1787777008081; Wed, 26
 Aug 2026 13:43:28 -0700 (PDT)
Date: Wed, 26 Aug 2026 20:43:17 +0000
In-Reply-To: <20260823125348.1138649-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260823125348.1138649-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260826204323.3974187-1-morbo@google.com>
Subject: [PATCH v3 2/2] userns: Add KUnit test suite for uid_gid_map
From: Bill Wendling <morbo@google.com>
Cc: Bill Wendling <morbo@google.com>, Bradley Morgan <brads@mainlining.org>, 
	"=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?=" <thomas.weissschuh@linutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
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
v3 - s/KUNIT_EXPECT_NOT_ERR_OR_NULL/KUNIT_ASSERT_NOT_ERR_OR_NULL/
   - Fixed Kconfig tests.
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
 init/Kconfig                  | 10 ++++
 kernel/.kunitconfig           |  3 ++
 kernel/user_namespace.c       |  4 ++
 kernel/user_namespace_kunit.c | 91 +++++++++++++++++++++++++++++++++++
 4 files changed, 108 insertions(+)
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
+	bool "KUnit test for user namespace map insertion" if !KUNIT_ALL_TESTS
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
index 000000000000..d97dbac65e50
--- /dev/null
+++ b/kernel/user_namespace_kunit.c
@@ -0,0 +1,91 @@
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
+			KUNIT_ASSERT_NOT_ERR_OR_NULL(test, map.forward);
+			KUNIT_EXPECT_EQ(test, map.forward[i].first, i * 10);
+			KUNIT_EXPECT_EQ(test, map.forward[i].lower_first, i * 100);
+			KUNIT_EXPECT_EQ(test, map.forward[i].count, 5);
+		}
+	}
+
+	/* Now sort the map to set up reverse mapping */
+	ret =3D sort_idmaps(&map);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, map.reverse);
+
+	/* Verify sorting is correct */
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
2.55.0.897.gb25b4bd76c-goog

