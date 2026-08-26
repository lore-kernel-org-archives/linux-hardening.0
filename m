Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DE5483BC2
	for <linux-hardening@vger.kernel.org>; Wed, 26 Aug 2026 22:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787781714; cv=none; b=SyTNyFJGIpFtr3YK9DKTGv8Z/LJV+pVZ/a88bjwpZFlbuKw4o7Idd9STe/DoO5Eoer5kv3PT0eY36lgXkepTx8m6F1BY2YmeRr19WwCWj8REkP+DPwrQXzKqG08gzl9CT1/6rS7RVy/FLaKo6Ejnhe8KTJjWoHm0P+49S9L+jh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787781714; c=relaxed/simple;
	bh=qyA52UAgvN6XlnaWZgTaKoW9C/BTluV651tNUqLWGuk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 Cc:Content-Type; b=L0SXs3e6aMXmz9UXY56ek1bVjLuV1ziEasWTu8HbCHu2QKNdAn+tWCEToUnBVqTlm8OMgjoMo5AGRQYvG4v5lk2NkcTGEWvtH+45VjIwmVatYy7tFAR7LYia4hzJ9TYqpZKyX34gW0hRSCnGtBy0hkHETb1cTUuwFR5k1GOwqRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mA5XrU2f; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mA5XrU2f"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1cb806660so1398363a12.3
        for <linux-hardening@vger.kernel.org>; Wed, 26 Aug 2026 15:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787781712; x=1788386512; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:from:subject:message-id
         :references:mime-version:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/uKfP9EuNi09bpZ97yR8E34CfJ3HCTaYTPb6xg/cB5w=;
        b=mA5XrU2fGOtfOOwsK5iqlVgzLLTdvSe9CvcEXwDRtByghHpqs+8VBRUN3/lgdehqYd
         cJ4Fbh3XGd0SCRb/6flTfYuw/FHam1rk66SKoEQuwIP7fFrMXuhyPxiLQSgeUWGHhb/k
         5qqKF0lcrdDXWJd9PopSOOzqOYgNWlDXTEsaESJiac2nJaen2udnC0iXisSsbnkd2g2G
         uHlBZtv2n8yqwM/T8I3eBDlDC0zk/LhoQ/rvjcF5pGn+DV3z/zvsQqiKAji2WO3/lOC/
         LM8/Is7kra9ZdSKFZc++B3xMhxSHbNy01auF1nNDeHJKvXUGjvtMLvGbgIM9iclI8B81
         /tMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787781712; x=1788386512;
        h=content-transfer-encoding:content-type:cc:from:subject:message-id
         :references:mime-version:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/uKfP9EuNi09bpZ97yR8E34CfJ3HCTaYTPb6xg/cB5w=;
        b=qblvB2xkVHK4KhzT//ezBRHLp3Bq4JqhAczTVDcWQrPsZ5d04YtUWZSjbzYcd8BT0w
         hhXd3j1BtM+L50kGH8OKe6pvJb3dlUmjPWO2WM8O7qR3Z95NPCOfRebf23ViABWlbYsU
         GDmxmtNNL6+aVNBJUp5BBFtKd4iDbAZOCvRX4QxICGw0z42FECHXgJLM6W2rYVbFCAf+
         VWsmWx5yDCypshla6E7JPG8TWSeoSLFTI+18yLHz9p5og3yUTl+1UhddvdL1ODwztpWf
         GdSqGVIvN44Cu9cu25ta5iYHajM+d0HSwEIfVNNnP2EB2GfELVGHM+ohuVYWHZQrb7YJ
         ZMvQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro8fLCGNozVOsCM8bfI0u+fSm+dIsX4ellrwYW89dMKjIYYbnCxvYxAu032chwfFe1HEg0oUcqhHzb//EsNjqI=@vger.kernel.org
X-Gm-Message-State: AFuF++msmEsemwLuQqKWNWgt0MW3Lmyhg09MjORA7gbrNlpLRwfiLPL6
	IiKQnjadQPBqA2iiDXuFD/EGf7vQI1wv4MmkVZhs2Ln5dobRUTBfte/t+VoixRAUC2Lw98L7XYw
	I
X-Received: from pgah16.prod.google.com ([2002:a05:6a02:4e90:b0:cc1:d46e:147a])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:150d:b0:3d1:4225:9bb
 with SMTP id adf61e73a8af0-3d14225161cmr769166637.2.1787781711833; Wed, 26
 Aug 2026 15:01:51 -0700 (PDT)
Date: Wed, 26 Aug 2026 22:00:35 +0000
In-Reply-To: <20260826220041.4075333-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260823125155.1136740-1-morbo@google.com> <20260826220041.4075333-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260826220041.4075333-2-morbo@google.com>
Subject: [PATCH v4 2/2] userns: Add KUnit test suite for uid_gid_map
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

Assisted-by: Gemini:3.1-pro-preview
Signed-off-by: Bill Wendling <morbo@google.com>
---
v2 - Remove Gerrit tag.
v3 - s/KUNIT_EXPECT_NOT_ERR_OR_NULL/KUNIT_ASSERT_NOT_ERR_OR_NULL/
   - Fixed Kconfig tests.
v4 - Actually test on unsorted data. Corrected the "Assisted-by" tag.
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
 kernel/user_namespace_kunit.c | 92 +++++++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+)
 create mode 100644 kernel/.kunitconfig
 create mode 100644 kernel/user_namespace_kunit.c

diff --git a/init/Kconfig b/init/Kconfig
index f63bf5e05e79..d460344539a5 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1457,6 +1457,16 @@ config USER_NS
=20
 	  If unsure, say N.
=20
+config USER_NAMESPACE_KUNIT_TEST
+	bool "Test user namespace map insertion" if !KUNIT_ALL_TESTS
+	depends on KUNIT=3Dy
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
index 786dbf0506ca..0e7373085af9 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1417,3 +1417,7 @@ static __init int user_namespaces_init(void)
 	return 0;
 }
 subsys_initcall(user_namespaces_init);
+
+#if IS_ENABLED(CONFIG_USER_NAMESPACE_KUNIT_TEST)
+#include "user_namespace_kunit.c"
+#endif
diff --git a/kernel/user_namespace_kunit.c b/kernel/user_namespace_kunit.c
new file mode 100644
index 000000000000..88467361efdf
--- /dev/null
+++ b/kernel/user_namespace_kunit.c
@@ -0,0 +1,92 @@
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
+		KUNIT_ASSERT_EQ(test, ret, 0);
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
+		int value =3D 9 - i;
+
+		extent.first =3D value * 10;
+		extent.lower_first =3D value * 100;
+		extent.count =3D 5;
+
+		ret =3D insert_extent(&map, &extent);
+		KUNIT_ASSERT_EQ(test, ret, 0);
+		KUNIT_EXPECT_EQ(test, map.nr_extents, i + 1);
+
+		if (i < UID_GID_MAP_MAX_BASE_EXTENTS) {
+			KUNIT_EXPECT_EQ(test, map.extent[i].first, value * 10);
+		} else {
+			KUNIT_EXPECT_EQ(test, map.forward[i].first, value * 10);
+			KUNIT_EXPECT_EQ(test, map.forward[i].lower_first, value  * 100);
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

