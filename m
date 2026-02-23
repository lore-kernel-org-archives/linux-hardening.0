Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999AD3EBF10;
	Mon, 23 Feb 2026 22:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771885352; cv=none; b=EtBMgvEgNc1Dnt+BFA/Huad17gJ+UiEmiDCfSePVvr5Pg8EFLOOJM4IWx0FsH2XFVassgMGI4eUpasTHo2Fjk4kY5Blglou6Fps5Vj62DwNnXH4VrS8n/fWOxW1aN/Z2Iz3Kfz3cpTrcVwXtSpM6X8RjhbBvZEy9Yty6FU8g2qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771885352; c=relaxed/simple;
	bh=Ihme3BeQuf5dfeZKKF9RAQvVrJKW09YsEJyzB6dEgSw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fIE7N+Z0fQmUoasPbSGa2GuD+7+joLswctQdT0QPfYisXrVvsBYB18B5HORhlO/Jmy0mQuDWDqPwTOtv6oMTlDEXpcv6Bc/Mji1/i9C8k5YHP1avQO6bXp7PlY/tgXCAkmfAhvMdeqBLVAHi2X/8+dj45znpzbDCqdW/0oXJqvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okXmN25o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okXmN25o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30344C116C6;
	Mon, 23 Feb 2026 22:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771885352;
	bh=Ihme3BeQuf5dfeZKKF9RAQvVrJKW09YsEJyzB6dEgSw=;
	h=From:To:Cc:Subject:Date:From;
	b=okXmN25o1zrbsKFm+bfMtfKHG/aCjEtqTo9rBuQW6j1CrYxrn4j81lmlWRfEum531
	 ZwlSx9tDhfOFL7BLR81QgLuuzxxgiixVeDR3CS8l68bqDk8l+LiMhYuk30bWF1+aUa
	 Va4uaOifeCgM+wEpyC/x2eaosrpXY81yUeMtqTvXhzGE8YIu1x91wv/yA8Z4WuGNII
	 wJII89x7MHV1EZ55yweVSdGGVHJzlSh9YhJAbfp6NYyWmocwWaQN9o3fpwfjo1HN6X
	 I91Y/LA+YazAMxkliJ/nsw/SS67k8i0FHF/JhkZG3hnDO6Y0vb8W04LTzyEc8sE7rf
	 cKVp2q0WhXhxg==
From: Kees Cook <kees@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] kcsan: test: Adjust "expect" allocation type for kmalloc_obj
Date: Mon, 23 Feb 2026 14:22:30 -0800
Message-Id: <20260223222226.work.188-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1564; i=kees@kernel.org; h=from:subject:message-id; bh=Ihme3BeQuf5dfeZKKF9RAQvVrJKW09YsEJyzB6dEgSw=; b=owGbwMvMwCVmps19z/KJym7G02pJDJlzLqv19RrJ/TYWDlkYVR+zXew/g4xdxu1JkbPurYvpX pa8a0FSRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwERiLBgZ/kSF3422S/gUKCso 5hTZGT7NZ2P9qz5RFaNLFaXslkcvMjIsna1RfCrP3OmoccHcu8d2svy4csVF3/Wy9lOnvNNL7l5 iAQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Instead of depending on the implicit case between a pointer to pointers
and pointer to arrays, use the assigned variable type for the allocation
type so they correctly match. Solves the following build error:

../kernel/kcsan/kcsan_test.c: In function '__report_matches':
../kernel/kcsan/kcsan_test.c:171:16: error: assignment to 'char (*)[512]' from incompatible pointer type 'char (*)[3][512]'
[-Wincompatible-pointer-types]
  171 |         expect = kmalloc_obj(observed.lines);
      |                ^

Tested with:

$ ./tools/testing/kunit/kunit.py run \
	--kconfig_add CONFIG_DEBUG_KERNEL=y \
	--kconfig_add CONFIG_KCSAN=y \
	--kconfig_add CONFIG_KCSAN_KUNIT_TEST=y \
	--arch=x86_64 --qemu_args '-smp 2' kcsan

Reported-by: Nathan Chancellor <nathan@kernel.org>
Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: <kasan-dev@googlegroups.com>
---
 kernel/kcsan/kcsan_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 79e655ea4ca1..056fa859ad9a 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -168,7 +168,7 @@ static bool __report_matches(const struct expect_report *r)
 	if (!report_available())
 		return false;
 
-	expect = kmalloc_obj(observed.lines);
+	expect = kmalloc_obj(*expect);
 	if (WARN_ON(!expect))
 		return false;
 
-- 
2.34.1

