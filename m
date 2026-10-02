Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC58B35FF58
	for <linux-hardening@vger.kernel.org>; Fri,  2 Oct 2026 19:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790968377; cv=none; b=oZmvGgrUXUaF1fVlkOnCXiabCJsLNSjCqUm8SGFC5WDBJftY4GytKlwq0W/yu2C3VssawDxCIKCGnyFjoViNRhakyMgjwOsg98AsJwuMtSoaR6Bvwr47VGRE1SopMG4GBiqNckI9u1iAqcZvzGMbfAK9B6pNMpypdpfB6cSowSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790968377; c=relaxed/simple;
	bh=VXYscRPCLO7/B51vHKehDNHl1fFhWkTSNPgHZbmLDBE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Vrc+PHelWNdfHAvRkCofmk+BZUaj3XDz7TRPTpBboEQzKFnCfOvMn+g6mXcPIvdHfHOfQB3+gdTFdSD8dnBy8q3acsEe8aY82UqALp6F+/d2f1+gsg8gZhmQ9tl8yRMiFRI334tPo16W5XjubKxtZqNpfL5cGmA8Stc73vabXRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WCb0bZ60; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WCb0bZ60"
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4cc89e86e9eso11541032b6e.3
        for <linux-hardening@vger.kernel.org>; Fri, 02 Oct 2026 12:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790968375; x=1791573175; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ju7lYd5Yw64Z3Dvl1ezRi6rNcZFkDznJ7WatWUwaWnE=;
        b=WCb0bZ608q75jsSV9HbRvoALBTMxDyUEzvwzVHoZwHmB1C8rXLagN6bBmNS8xt4nKJ
         fJ317/s6YSoXWk5zCUxe5MdT4cAQyStuJgVclPyUXCaJFRpI5KXTEeX5Bx/T8T25kEFe
         mLGXcNIUOv6FnqO6ig33l3pQvrlz/n89ZBOJlIrxEfhxrALdMUdflrO5q5WMF/eQ45Hb
         Ot4rZYzFXCng3h29XN9wOgl32emRASZXEN1rrV+fdheYP0ad84+1iLy4p3FDmnGXluPm
         aBcHVUnqBz+Sh4ctVrat8kAYZKmdLR0Hu5Hkah++5TUBS7PX1lrjPkd69f6blOX7hetk
         WsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790968375; x=1791573175;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ju7lYd5Yw64Z3Dvl1ezRi6rNcZFkDznJ7WatWUwaWnE=;
        b=DQJbDVjN61oc878C47GtGd4TMR0Zi6N00g1GkACwI2ZX45fYVvIEw0StLtwFEuyovU
         TMxHLx+2tNf1XP+KI5RusHvkMyIAnEn0lipZN+ySgBsQqTwyxB8aid4YXcymZFiaHx5G
         eTlafBwxnKhw+JcSV4E17g1MCla6hzkPseo4u92V6HOfavHjJ0c0wnINAhz9xs6Mpd+s
         NqU4wel5J8Kj8q65clVEZuyqv1KnJI5gLxLRqBitjLHcR+AGLhtprAtf4XtyjNMW2vjr
         4QSf3ZVl5Mcx/MhdOYxgUzmGPA51vSZRGZo/kKgUoJHaT+765RA2lhixQWz208ZQxwry
         tygw==
X-Gm-Message-State: AFuF++nIduERV/mzvMXGUliK92pIVg93FeLuyN5TcGeV1OJjsOsXF1+L
	a109Awb9oGiecsi+Lvj55izPglhEJlMZmKjlo5SPIZB6isKI5oZ2fhAwDmi0LjWGvs6QYTR6B5X
	hwLPkGXQHFM4lkQndBZPo06dlKw==
X-Received: from jaso12.prod.google.com ([2002:a05:6638:124c:b0:5f9:6f05:3fd8])
 (user=justinstitt job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:6409:b0:4d5:2b09:a6a8 with SMTP id 5614622812f47-4f67bb70fd6mr326114b6e.66.1790968374329;
 Fri, 02 Oct 2026 12:12:54 -0700 (PDT)
Date: Fri, 2 Oct 2026 12:12:53 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QpAQBCF4VfRXNvanQ3lVeTCMhiKbQcpeXeLy
 6/+cy4QCkwCZXJBoIOF1yXCpAm0Y7MMpLiLBtSYG61RzeK9MpgpS7YhdE6bwkLMfaCez++qqn/ L7iZqt3cP9/0AJ59dH2wAAAA=
X-Change-Id: 20261002-kspp-125-3e3ae2bb0173
X-Developer-Key: i=justinstitt@google.com; a=openpgp; fpr=E8700888482CBCD3779E67F32D8CB922E382C412
X-Developer-Signature: v=1; a=openpgp-sha256; l=4319; i=justinstitt@google.com;
 h=from:subject:message-id; bh=CMxtKQblFVuOs9yO0cOd0qjokWPxJqtBuipzA4VLqOk=;
 b=owEBbQKS/ZANAwAKAS2MuSLjgsQSAcsmYgBqwAE2r0gF8ef+9zrb/Tnx5YDs+uDLCUy900v6U
 kKaVNpzhvWJAjMEAAEKAB0WIQTocAiISCy803eeZ/MtjLki44LEEgUCasABNgAKCRAtjLki44LE
 EruhEACo681vlkH22FDTfWSqCvpuIODD+WjYFnnSK5TVc/3YmBNBVYd34ULTGijvGhh39H7Z5bh
 D5zUjNlbu7NXvlXE5QqoacRc/RPi3BQdxkrC+YGjiaS53nyoWkkFBsW+No4r11gRw1Pbu0UATKs
 JgXyMbb4ev3Ep/c2eDhTgywCsvURzhy3rU/sCKgmZ+WuUtIwa0IGHuQKrwy/+iZxpLDnYlYzEl3
 cigkyHDf1igCYUdh/vk24sBixs/AI+jWoy1+bHoOJsZt7jUwdd0/gZ9WRmflqhcHFRk+Dn6UdVY
 uye+kEyRR45nNTnju6tfHs+dr2fJGjM/iJRrYpvbyJ83iwwjDSjiHLYZ+bYzndYwkhzTcYT/BZH
 UEz580uo3+nA57hgzSjpX5vPQ2HcGlfTt6MC05E9TXMm4DKF8+5OTjc48EHSf1WTANbFtOnVJG0
 iLvEv4eVD8lol8YXkv/dVdXM2rSpcM30sb3fUN6nFPiaLgJ0+ra7I9KF/3g+m5EMjfbV+UkFfVz
 PDRP/fj+L2t/z0OKL29LkKqEcO05ZfW39dHP+ADHcI9wz5jx+LluT16T465qcdeAaMzfSsz4iqo
 vervsLOV9SxujrHtS0bx/m2SyWMo4i45eCL3jyTtCj6JYM/j6ZCn2ytvyN/sxhTzUau88EK4uzr jmAdEgNtYEPzPBA==
X-Mailer: b4 0.15.2
Message-ID: <20261002-kspp-125-v1-1-91286a454fda@google.com>
Subject: [PATCH] kunit/stackinit: Cover declarations bypassed by goto and switch
From: Justin Stitt <justinstitt@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="us-ascii"

From: Justin Stitt <justinstitt@google.com>

Under -ftrivial-auto-var-init= the initialization is emitted where a
variable is declared. A switch dispatch that reaches a case label below
the declaration, or a goto that jumps past it, never reaches that point,
so the variable was left uninitialized.

Commit 9cf016e6b49b ("lib: test_stackinit.c: XFAIL switch variable init
tests") marked test_switch_1_none and test_switch_2_none as expected
failures, noting the test should be retained "so that we can evaluate
compiler fixes". Clang 24 emits the initialization on the jumps that
bypass the declaration, so make the expectation depend on the compiler
version instead of failing unconditionally.

Add test_goto_none as well. The existing cases only cover a declaration
sitting between a switch and its first case label, while the compiler
change covers plain goto too.

GCC continues to initialize only at the declaration, and reports as much
with -Wtrivial-auto-var-init, so it keeps the expected-failure path.

Link: https://github.com/llvm/llvm-project/pull/181937
Link: https://github.com/KSPP/linux/issues/125
Link: https://llvm.org/pr44916
Assisted-by: LLM
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 lib/tests/stackinit_kunit.c | 53 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/lib/tests/stackinit_kunit.c b/lib/tests/stackinit_kunit.c
index ff2784769772..a0029f3b894d 100644
--- a/lib/tests/stackinit_kunit.c
+++ b/lib/tests/stackinit_kunit.c
@@ -493,6 +493,36 @@ static int noinline __leaf_switch_none(int path, bool fill)
 	return 0;
 }
 
+static noinline int __leaf_goto_none(bool fill)
+{
+	goto bypass;
+	/*
+	 * This declaration is jumped over by the goto above, so it is
+	 * never reached. Compilers that initialize only at the point of
+	 * declaration leave this variable untouched.
+	 */
+	uint64_t var[10];
+
+bypass:
+	target_start = &var;
+	target_size = sizeof(var);
+	if (fill) {
+		fill_start = &var;
+		fill_size = sizeof(var);
+
+		memset(fill_start, (forced_mask | 0x55) & FILL_BYTE, fill_size);
+	}
+	memcpy(check_buf, target_start, target_size);
+
+	return 0;
+}
+
+static noinline int leaf_goto_none(unsigned long sp, bool fill,
+					  uint64_t *arg)
+{
+	return __leaf_goto_none(fill);
+}
+
 static noinline int leaf_switch_1_none(unsigned long sp, bool fill,
 					      uint64_t *arg)
 {
@@ -506,13 +536,23 @@ static noinline int leaf_switch_2_none(unsigned long sp, bool fill,
 }
 
 /*
- * These are expected to fail for most configurations because neither
- * GCC nor Clang have a way to perform initialization of variables in
- * non-code areas (i.e. in a switch statement before the first "case").
- * https://llvm.org/pr44916
+ * A declaration whose definition point is jumped over, either by a switch
+ * dispatch reaching a "case" label below it or by a goto, used to be left
+ * uninitialized: the initialization is emitted where the variable is
+ * declared, and that point is never reached.
+ *
+ * Clang 24 and later emit the initialization on the jumps that bypass the
+ * declaration instead. GCC still initializes only at the declaration, and
+ * says so with -Wtrivial-auto-var-init.
  */
-DEFINE_TEST_DRIVER(switch_1_none, uint64_t, SCALAR, ALWAYS_FAIL);
-DEFINE_TEST_DRIVER(switch_2_none, uint64_t, SCALAR, ALWAYS_FAIL);
+#if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION >= 240000
+# define BYPASS_PASS	WANT_SUCCESS
+#else
+# define BYPASS_PASS	XFAIL
+#endif
+DEFINE_TEST_DRIVER(switch_1_none, uint64_t, SCALAR, BYPASS_PASS);
+DEFINE_TEST_DRIVER(switch_2_none, uint64_t, SCALAR, BYPASS_PASS);
+DEFINE_TEST_DRIVER(goto_none, uint64_t, SCALAR, BYPASS_PASS);
 
 #define KUNIT_test_scalars(init)			\
 		KUNIT_CASE(test_u8_ ## init),		\
@@ -568,6 +608,7 @@ static struct kunit_case stackinit_test_cases[] = {
 	KUNIT_test_scalars(none),
 	KUNIT_CASE(test_switch_1_none),
 	KUNIT_CASE(test_switch_2_none),
+	KUNIT_CASE(test_goto_none),
 	/* STRUCTLEAK_BYREF should cover from here down. */
 	KUNIT_test_structs(none),
 	/* STRUCTLEAK will only cover this. */

---
base-commit: 5e0f8396d4805a3e7f753fa58c8c55f1f3cc2160
change-id: 20261002-kspp-125-3e3ae2bb0173

Best regards,
--  
Justin Stitt <justinstitt@google.com>

