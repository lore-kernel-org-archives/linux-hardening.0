Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02BE1624C5;
	Tue, 24 Feb 2026 23:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771975482; cv=none; b=GdcvLUQDN7psxdz2g7GJ2HMquYJfE7d2zHD/sIovJzc9PdDrhsSwYJ3DX/0Fv6qz5etee4IQWitQCYrUG716tJFAY+3f5c8IBInDtS614EimqFg9/bVCFHHcnXbMEK1rikMQUfNTSfMFMcK3gFR2iDbYqcBAZ6UVQ9na96UKp2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771975482; c=relaxed/simple;
	bh=xupxSd6KKXCyn4CF6vOxdGC2/8h8XM7Ljals7v3P8Dw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xj6L5GDH/sHbwFV5qdebHdK/Ct+6mV1GD0PJiDkVF4pVypIK6yR6ktj8ML1Q4riJkBrL7yzElCpB8MRBHc3RFZg9x5u7jYwoua2bIAn4shWAehSLh5lisqXMTmxDSDsjMI8q3SM4SUlr2DgVInn/IxLDW+7gDvaNujqbV2LplGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzSu0BEf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzSu0BEf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E133C116D0;
	Tue, 24 Feb 2026 23:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771975482;
	bh=xupxSd6KKXCyn4CF6vOxdGC2/8h8XM7Ljals7v3P8Dw=;
	h=From:To:Cc:Subject:Date:From;
	b=HzSu0BEfHs6ibH4bwymUaLCy0sidmWNU8CSsNO0XV/VoKxYzy+a3IeQORMQzkUFeG
	 nUyhBYEL/fu4Uq9PjhAd4uuQ0wzd7Kn/Vg5HXL3j65PYc/mfHbwuXS98sZQsbFWhm6
	 yR8qbj7krrARKkQflKnFO2e6rVZXusvrJnmqk3/rVKfS2he1/WJ3zznjw7EB5Hn/+K
	 IPI8tmD69zQUkwrB7oocxSoYoYWEw/TVmjXj9WjbaiWjXlBS9fmQErdx8u+rF0wKC7
	 AO17PY6W426qgM0gevhMW1IrxtYU7r1nE2zRQcssTYCzu1fIQiwAA683rVgyg8y50n
	 jH6Xy+trBWFBw==
From: Kees Cook <kees@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] kcsan: test: Adjust "expect" allocation type for kmalloc_obj
Date: Tue, 24 Feb 2026 15:24:40 -0800
Message-Id: <20260224232434.it.591-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1839; i=kees@kernel.org; h=from:subject:message-id; bh=xupxSd6KKXCyn4CF6vOxdGC2/8h8XM7Ljals7v3P8Dw=; b=owGbwMvMwCVmps19z/KJym7G02pJDJnzjC3+tD/h+OAf0Lli5tPZTPkXdqcsyTH+aMXHw5Kgx eL37/zUjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIn8c2X4p55/viF77c/ZQY+u 3DNs2rXni7XJlYr8zOe1c2WXVsjd0WVkeFu341dx9IYqtTnXBPdnrbzyIeV7R/u97zMyjXtv8Px ayA4A
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The call to kmalloc_obj(observed.lines) returns "char (*)[3][512]",
a pointer to the whole 2D array. But "expect" wants to be "char (*)[512]",
the decayed pointer type, as if it were observed.lines itself (though
without the "3" bounds). This produces the following build error:

../kernel/kcsan/kcsan_test.c: In function '__report_matches':
../kernel/kcsan/kcsan_test.c:171:16: error: assignment to 'char (*)[512]' from incompatible pointer type 'char (*)[3][512]'
[-Wincompatible-pointer-types]
  171 |         expect = kmalloc_obj(observed.lines);
      |                ^

Instead of changing the "expect" type to "char (*)[3][512]" and
requiring a dereference at each use (e.g. "(expect*)[0]"), just
explicitly cast the return to the desired type.

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
index 79e655ea4ca1..ae758150ccb9 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -168,7 +168,7 @@ static bool __report_matches(const struct expect_report *r)
 	if (!report_available())
 		return false;
 
-	expect = kmalloc_obj(observed.lines);
+	expect = (typeof(expect))kmalloc_obj(observed.lines);
 	if (WARN_ON(!expect))
 		return false;
 
-- 
2.34.1

