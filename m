Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FCA45D1B9
	for <linux-hardening@vger.kernel.org>; Wed,  2 Sep 2026 23:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788392032; cv=none; b=GrvLfbdYsBekAKv6PWtvBAjVue/GFRU/zBVymVi0BlJZC2wRAUz/J+Vb/HMLBgjYdNuif6NY77ifjTCW34I/khqbHDy2njGwiekhttjUwR99pN8hTPWdX2HeGp1VOEb/gdGHCs21G9ZeaFxnEr+tFwnvvQA8ZX3EQ4dKnMvdKSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788392032; c=relaxed/simple;
	bh=mTbucyKS28ci+xoE7n2nJolqYwccCcBJzP7t5jWneuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mS0wvgec6QMnY9Cxdz4FB1kJHHMq/WL9plfVvrDLj/7sA6kC8hMc2NvAbNOvmPgbMeBbLE0OW2CWNgOQCq8eniHkNc2qhjbX7LvB/X5ZxSRxA2FvfH+PnABG8Tap2XfEEya7F9me8dGc9YljshmKfJoKOlXeoWe4HC1UcQmePoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6c0UhAy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6c0UhAy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631301F00A3A;
	Wed,  2 Sep 2026 23:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788392029;
	bh=pLUBfCSgO26uNB+4CrkUFwNP6/EV3cJrws6qxvxJZyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R6c0UhAyK+dwpdytsoWKDTInx+FvK6342ppluWLHbx0dP4QvRSYgNP9afiOyz6ecV
	 XYL4CCQX9h6QMS2WGRILe1J97CpysUi6NxIV65mbY0ige20rUrxgl2cHZOGDpcYvfQ
	 qfrXq5WSNFR7FfwsA+L5REPLzVNjdf7prPrRH8SIWC/r6LQgw+R3cJ0FPxqwNHPJ5H
	 ObVLGaemlfvkhB8n4sKwYw0/R5CqB9jT56toJfJ1b66VbfqRgCxltODa65U3ZjS7DH
	 z7DBaRjws2pTDd3prMATvFMLHn9tmin+eAe+zCgDOX84aPJSrRH5OIgC98cZLWwunt
	 xM1fsjps0wJcg==
From: Kees Cook <kees@kernel.org>
To: York Jasper Niebuhr <yjn@yjn-systems.com>
Cc: Kees Cook <kees@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	franzen@sec.in.tum.de,
	linux-hardening@vger.kernel.org
Subject: [PATCH 2/3] gcc-plugins: sanemaker: make the no-op trap macros statement-safe
Date: Wed,  2 Sep 2026 16:33:42 -0700
Message-Id: <20260902233349.1996922-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902233338.i.375-kees@kernel.org>
References: <20260902233338.i.375-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2635; i=kees@kernel.org; h=from:subject; bh=mTbucyKS28ci+xoE7n2nJolqYwccCcBJzP7t5jWneuE=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkzNoUpSiy+/OnD6pArbl4Xsstfzv73mfnZobZJCgmmy rZMmYY3O0pZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTAC5yleEP97wy3y73N1NuFazY 9u2I4fry0IDzZvp/lmt5RX3aPNFuKiPDlw+Hrr/iMkv9uPWhT8XiLLuDzx1/7uWI+Slx7FpEtsx SdgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

With CONFIG_SPSLR=y and CONFIG_SANEMAKER=n -- the baseline configuration
named in the cover letter -- the build fails:

  kernel/module/main.c:105:63: error: suggest braces around empty body
    in an 'if' statement [-Werror=empty-body]
    105 |                 (const char *)text->base + text->size);
  cc1: all warnings being treated as errors

The sanemaker_*() stubs expand to nothing when CONFIG_SANEMAKER is off,
and sanemaker_register_module_image() uses them as the body of an if:

	if (text->base && text->size)
		sanemaker_new_image_text(...);

which leaves "if (cond) ;".

Give the stubs the usual do { } while (0) body so they are valid
statements. No change when CONFIG_SANEMAKER=y.

Build tested ARCH=x86_64 defconfig+CONFIG_SPSLR=y with the patched
GCC 16.1.0 / GAS 2.46.1 toolchain, CONFIG_SANEMAKER unset.

Assisted-by: Claude:claude-opus-5[1m]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/sanemaker/traps.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/sanemaker/traps.h b/include/sanemaker/traps.h
index bcb75198b18b..b9a39584de27 100644
--- a/include/sanemaker/traps.h
+++ b/include/sanemaker/traps.h
@@ -17,7 +17,7 @@ void __sanemaker_target_tag_trap(const void *ptr, const unsigned char *target);
 
 #else
 
-#define sanemaker_target_tag(ptr, type)
+#define sanemaker_target_tag(ptr, type) do { } while (0)
 
 #endif
 
@@ -32,7 +32,7 @@ void __sanemaker_target_untag_trap(const void *ptr);
 
 #else
 
-#define sanemaker_target_untag(ptr)
+#define sanemaker_target_untag(ptr) do { } while (0)
 
 #endif
 
@@ -50,7 +50,7 @@ void __sanemaker_finish_layout_trap(const void *fields,
 
 #else
 
-#define sanemaker_finish_layout(fields, target)
+#define sanemaker_finish_layout(fields, target) do { } while (0)
 
 #endif
 
@@ -90,7 +90,7 @@ void __sanemaker_signal_trap(sanemaker_signal_t signal);
 
 #else
 
-#define sanemaker_signal(signal)
+#define sanemaker_signal(signal) do { } while (0)
 
 #endif
 
@@ -125,10 +125,10 @@ void __sanemaker_drop_image_text_trap(const char *image, const void *begin,
 
 #else
 
-#define sanemaker_new_image(name, base)
-#define sanemaker_new_image_text(image, begin, end)
-#define sanemaker_drop_image(image)
-#define sanemaker_drop_image_text(image, begin, end)
+#define sanemaker_new_image(name, base) do { } while (0)
+#define sanemaker_new_image_text(image, begin, end) do { } while (0)
+#define sanemaker_drop_image(image) do { } while (0)
+#define sanemaker_drop_image_text(image, begin, end) do { } while (0)
 
 #endif
 
-- 
2.34.1

