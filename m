Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CC150EC0B
	for <linux-hardening@vger.kernel.org>; Thu,  3 Sep 2026 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788467875; cv=none; b=XuEhH2tHiJ3jprelT2gX6owHrjmhkUzGJXIXwfehTsK4jJTDxuaKYelbjIxY5V4+3rTI/4NuZOgFWXHVQjSvArC5RODGU8K/1r+hmtKDL/HRaNbIYjlOnkpvq/4za9t5zIYrF84PUhZU/xhz+CmlUoK6HmbM3f+HAJzLkUeo97Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788467875; c=relaxed/simple;
	bh=2UBlYQEyGWOQDtIcz85wPWpuQThTw5iKFdTHWIgVFSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LZEqzQSMC7GsWoPKDM5PnNm55ZmBpfOIH1TiJxvpv3AAbMQ1HVNtuq53/uEKvYbXTi6HWAIFF/FoRu4pEF/2iNVzvs7BgJz3UPdVzcrZw3HerUePK8tjzqH/gcG+80+ZHQJC2Lg8XuQB809W7YqNLFyusBUDeU/+X7fOIaYVOEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ph9B1whv; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ph9B1whv"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4843efcbdb2so213787f8f.2
        for <linux-hardening@vger.kernel.org>; Thu, 03 Sep 2026 13:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788467856; x=1789072656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JG5wHGxobGMru3PHPCCaPFK+av72ZMxaO+XhGsfKu1Y=;
        b=ph9B1whvBT8TvHNzlYj5fngC4KNl8ic5pB7hUhI9EmVFkf8zM46QqzBr1wsR5wdeR1
         QBwF5UzF745ngelPYPWU2BeOpsla2Nqg3DwfRgb/ogYYOkt1hURPCIGii8CnJhXBuWvO
         mu8j6kV+9ewhnLYoGU6aJUdFPUgXaj0faclZ4V935AI6Im23FW9ZfC2XlpPiHsCgTij6
         JT8J47WYqp48mbWkpjZ8HaiyBvNrn/iigFSHtgtto4pOkXG5aJlLFJFm48DOQel5jjK3
         Q10y0aTdoCVdsYkBDsv9n416DMZxFzJbA/267PzAVL/p+WxCHSpqRsbBUnNg6ZXkfBWF
         YXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788467856; x=1789072656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JG5wHGxobGMru3PHPCCaPFK+av72ZMxaO+XhGsfKu1Y=;
        b=bQI3FBK/mN/eA7WPzN2OLmY+qAlXr/Xe9pO1WBJCeWZU/LOJBI8bDSWUoVPL+I+hz0
         lRooo0/QGG3Zpnt/wjgUOhOZymbD0V9wV/7KBpacNTtIYsISOufMXrdgLeqPvXi3l/q/
         A+TY6kJUW736LywyqpJ1y4Qga/jqDltyHq7wd+GECx91S3MCh/8om64NA0uhH2mGa+S/
         t+Jdq+lJuH/gofkHyAVLc/ZXcyu/Ur/y4ZKjifkTTKQ424rFd2M8JtnM/c7SgwvWvGEy
         CefLoBuEPX1kzDaZn/vH3n5cAP98jA9c+7YcUsAllfc9I7w3tq89GeE0gOsyYFeF7l60
         1dLg==
X-Forwarded-Encrypted: i=1; AKwUvBy7AGUWEN7Ff8P/r9f075gboWBDXrvqzG7C0L9bp5TJov5zaPMu7o6OUJKSCaNzseCSgLoY7GEfjt2XooYJkT4=@vger.kernel.org
X-Gm-Message-State: AFuF++nxe2RbTjUR8kq+M4969i2/VGSyYHf6R4R89arOLo0lUrJRBqiZ
	MCOn+z4rrUZXGXlZqWsSkGtA8fvT0WZWnUuyYKK6WOX3ixDm2CQeKD60
X-Gm-Gg: AYBFou1JA52mJp1bmhMxFdbCiYt6UQ56PjQwQYlYhB9njRYQlv/ol+RIjh1xD2Q0hCo
	U/+yAEUN2PGitU6beQwerQqIG7uFxFpuWw5+Vs1HacmykfMxD/vHL5s+fbCCAiWt+6ssxy0vg2E
	pFnyhYF8+P95nQkMf64kBqvY4OS952qELvhQKyVvdPyzoJbFJSNWnwl/3TvUU4bbEQz24YQgdpL
	TriL+TEF6Jrlr78ofV85RjxygfcB7qwIruu4jdjTMkWTRE7fm48DATtvncGsvxFT0Pt/JO6C9c5
	mXuJT5HkLu25ZoG4rA+MVezvJudz7hgiB+2iVzJ9L2Fu/vniNC62N5vxm+mhUFt2mT0MbGMbkYd
	e77eZMOLK15y242Py9IRZ9m5opDcKq/MNCXQhxoQMM+lNhfN2xAlwYbU1oUzfAI96JSANTtvncS
	S6/ZogUdnK88ZNyVaC8ugbFD+bKyteynP3qUj9pgcuLEYTmWiadRwIHkTuAu8Cz5Ccc7MiZgZnO
	OZRDFvRqdhmb/Jvxe/9qMi2GRFnD4FdfIqrOiJ2P1Vo8I2P1B2BYTlcbbsSB2dZro1bgc07tnlV
	7kszyvASvcX4d1lhozs83tBBi2BG9JsL81LfKvLr/TNz1DQQGYCsGqxh20VljuwY3SXcPbgkbFa
	/uVGS
X-Received: by 2002:a05:6000:4b0f:b0:484:3647:d977 with SMTP id ffacd0b85a97d-485872df445mr2610818f8f.27.1788467855677;
        Thu, 03 Sep 2026 13:37:35 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a979-9501-3df6-d7fa-8a5a-06c5.310.pool.telefonica.de. [2a02:3100:a979:9501:3df6:d7fa:8a5a:6c5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588394fa1sm1005070f8f.8.2026.09.03.13.37.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 13:37:35 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v3 5/5] slab: test ERR_PTR handling in kfree and hardened usercopy
Date: Thu,  3 Sep 2026 22:37:20 +0200
Message-Id: <20260903203720.63689-6-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260903203720.63689-1-kmehltretter@gmail.com>
References: <20260903203720.63689-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add KUnit coverage that kfree() warns and returns for ERR_PTR values
while remaining silent for NULL and ZERO_SIZE_PTR.

Add an LKDTM test that verifies hardened usercopy rejects an ERR_PTR
before attempting the copy.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/misc/lkdtm/usercopy.c           | 27 +++++++++++++++++++++++++
 lib/tests/slub_kunit.c                  | 18 +++++++++++++++++
 tools/testing/selftests/lkdtm/tests.txt |  1 +
 3 files changed, 46 insertions(+)

diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index 67db57249a34..10751e48211f 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -4,6 +4,7 @@
  * hardening.
  */
 #include "lkdtm.h"
+#include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/highmem.h>
 #include <linux/vmalloc.h>
@@ -273,6 +274,31 @@ static void do_usercopy_slab_whitelist(bool to_user)
 }
 
 /* Callable tests. */
+static void lkdtm_USERCOPY_ERR_PTR(void)
+{
+	unsigned long user_addr;
+	size_t size = unconst + 1;
+
+	user_addr = vm_mmap(NULL, 0, PAGE_SIZE,
+			    PROT_READ | PROT_WRITE,
+			    MAP_ANONYMOUS | MAP_PRIVATE, 0);
+	if (user_addr >= TASK_SIZE) {
+		pr_warn("Failed to allocate user memory\n");
+		return;
+	}
+
+	pr_info("attempting bad one-byte copy_to_user() from ERR_PTR\n");
+	if (copy_to_user((void __user *)user_addr, ERR_PTR(-EINVAL), size)) {
+		pr_warn("copy_to_user failed, but lacked Oops\n");
+		goto free_user;
+	}
+	pr_err("FAIL: ERR_PTR usercopy not detected!\n");
+	pr_expected_config_param(CONFIG_HARDENED_USERCOPY, "hardened_usercopy");
+
+free_user:
+	vm_munmap(user_addr, PAGE_SIZE);
+}
+
 static void lkdtm_USERCOPY_SLAB_SIZE_TO(void)
 {
 	do_usercopy_slab_size(true);
@@ -439,6 +465,7 @@ void __exit lkdtm_usercopy_exit(void)
 }
 
 static struct crashtype crashtypes[] = {
+	CRASHTYPE(USERCOPY_ERR_PTR),
 	CRASHTYPE(USERCOPY_SLAB_SIZE_TO),
 	CRASHTYPE(USERCOPY_SLAB_SIZE_FROM),
 	CRASHTYPE(USERCOPY_SLAB_WHITELIST_TO),
diff --git a/lib/tests/slub_kunit.c b/lib/tests/slub_kunit.c
index 923d8646bca1..079563387007 100644
--- a/lib/tests/slub_kunit.c
+++ b/lib/tests/slub_kunit.c
@@ -507,6 +507,23 @@ static void test_zero_size_alloc(struct kunit *test)
 	kvfree(ZERO_SIZE_PTR);
 }
 
+static void test_kfree_err_ptr(struct kunit *test)
+{
+	if (!IS_ENABLED(CONFIG_BUG))
+		kunit_skip(test, "requires CONFIG_BUG");
+
+	kunit_warning_suppress(test) {
+		kfree(NULL);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 0);
+
+		kfree(ZERO_SIZE_PTR);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 0);
+
+		kfree(ERR_PTR(-EINVAL));
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
+}
+
 static int test_init(struct kunit *test)
 {
 	slab_errors = 0;
@@ -532,6 +549,7 @@ static struct kunit_case test_cases[] = {
 	KUNIT_CASE(test_leak_destroy),
 	KUNIT_CASE(test_krealloc_redzone_zeroing),
 	KUNIT_CASE(test_zero_size_alloc),
+	KUNIT_CASE(test_kfree_err_ptr),
 #ifdef CONFIG_PERF_EVENTS
 	KUNIT_CASE_SLOW(test_kmalloc_nolock_and_friends_perf),
 #endif
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index bec57a02913a..d3e38c1c75cd 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -70,6 +70,7 @@ REFCOUNT_DEC_AND_TEST_SATURATED Saturation detected: still saturated
 REFCOUNT_SUB_AND_TEST_SATURATED Saturation detected: still saturated
 #REFCOUNT_TIMING timing only
 #ATOMIC_TIMING timing only
+USERCOPY_ERR_PTR Kernel memory exposure attempt detected from ERR_PTR
 USERCOPY_SLAB_SIZE_TO
 USERCOPY_SLAB_SIZE_FROM
 USERCOPY_SLAB_WHITELIST_TO
-- 
2.53.0

