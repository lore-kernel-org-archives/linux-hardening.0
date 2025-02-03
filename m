Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95198201116;
	Mon,  3 Feb 2025 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738578542; cv=none; b=uCcCMEICsCYQW1+wTXRHp4l9Aam0+w8SVAtyb3oOdSKNpW1dcI/rXvHzLjnREKin3R22V6xJzsiCC9RtuwQTTUunmdj0ueLkSckvx9CfJqAbGd+5eak1PzUlgZbXk8/s3BW5erlr9E+BtKhpgeONDrautz71Fdi7HoWbYc+47ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738578542; c=relaxed/simple;
	bh=yEdNOIPpD7/j1H5I4Ox6cnx7ti57tChBlnF+bbJo9kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnpoXW4JpiWzbwZgu5iplhqDxM4u/NUbzLmbFhlTlhC8v84RN+D4Gi12/rR6UhOizV2sD+/JJVWctGAg3S/OsP6sMi05kEYQujl9LUTgwevalRHW0BUzCG1NaJWScXuVHBrd9PsTMjZmxRX+61MkDpbj4ZKLY+1Mqr6ypBlcqBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5909D1BCA;
	Mon,  3 Feb 2025 02:29:24 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AE363F7BD;
	Mon,  3 Feb 2025 02:28:56 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Howells <dhowells@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@chromium.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Kees Cook <kees@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	Quentin Perret <qperret@google.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [RFC PATCH 8/8] mm: Add basic tests for kpkeys_hardened_cred
Date: Mon,  3 Feb 2025 10:28:09 +0000
Message-ID: <20250203102809.1223255-9-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250203102809.1223255-1-kevin.brodsky@arm.com>
References: <20250203102809.1223255-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic tests for the kpkeys_hardened_pgtables feature: try to
perform a direct write to current->{cred,real_cred} and ensure it
fails.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 mm/Makefile                    |  1 +
 mm/kpkeys_hardened_cred_test.c | 42 ++++++++++++++++++++++++++++++++++
 security/Kconfig.hardening     | 11 +++++++++
 3 files changed, 54 insertions(+)
 create mode 100644 mm/kpkeys_hardened_cred_test.c

diff --git a/mm/Makefile b/mm/Makefile
index f7263b7f45b8..2024226902d4 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -149,3 +149,4 @@ obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
 obj-$(CONFIG_PT_RECLAIM) += pt_reclaim.o
 obj-$(CONFIG_KPKEYS_HARDENED_PGTABLES) += kpkeys_hardened_pgtables.o
 obj-$(CONFIG_KPKEYS_HARDENED_PGTABLES_TEST) += kpkeys_hardened_pgtables_test.o
+obj-$(CONFIG_KPKEYS_HARDENED_CRED_TEST) += kpkeys_hardened_cred_test.o
diff --git a/mm/kpkeys_hardened_cred_test.c b/mm/kpkeys_hardened_cred_test.c
new file mode 100644
index 000000000000..46048098f99d
--- /dev/null
+++ b/mm/kpkeys_hardened_cred_test.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <kunit/test.h>
+#include <linux/sched.h>
+
+static void write_cred(struct kunit *test)
+{
+	long zero = 0;
+	int ret;
+
+	ret = copy_to_kernel_nofault((unsigned long *)current->cred, &zero, sizeof(zero));
+	KUNIT_EXPECT_EQ_MSG(test, ret, -EFAULT,
+			    "Write to current->cred wasn't prevented");
+
+	ret = copy_to_kernel_nofault((unsigned long *)current->real_cred, &zero, sizeof(zero));
+	KUNIT_EXPECT_EQ_MSG(test, ret, -EFAULT,
+			    "Write to current->real_cred wasn't prevented");
+}
+
+static int kpkeys_hardened_cred_suite_init(struct kunit_suite *suite)
+{
+	if (!arch_kpkeys_enabled()) {
+		pr_err("Cannot run kpkeys_hardened_cred tests: kpkeys are not supported\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+static struct kunit_case kpkeys_hardened_cred_test_cases[] = {
+	KUNIT_CASE(write_cred),
+	{}
+};
+
+static struct kunit_suite kpkeys_hardened_cred_test_suite = {
+	.name = "Hardened credentials using kpkeys",
+	.test_cases = kpkeys_hardened_cred_test_cases,
+	.suite_init = kpkeys_hardened_cred_suite_init,
+};
+kunit_test_suite(kpkeys_hardened_cred_test_suite);
+
+MODULE_DESCRIPTION("Tests for the kpkeys_hardened_cred feature");
+MODULE_LICENSE("GPL");
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 1af3a9dae645..9b0563a03ab4 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -338,6 +338,17 @@ config KPKEYS_HARDENED_CRED
 	  This option has no effect if the system does not support
 	  kernel pkeys.
 
+config KPKEYS_HARDENED_CRED_TEST
+	tristate "KUnit tests for kpkeys_hardened_cred" if !KUNIT_ALL_TESTS
+	depends on KPKEYS_HARDENED_CRED
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable this option to check that the kpkeys_hardened_cred feature
+	  functions as intended, i.e. prevents arbitrary writes to live credentials.
+
+	  If unsure, say N.
+
 endmenu
 
 config CC_HAS_RANDSTRUCT
-- 
2.47.0

