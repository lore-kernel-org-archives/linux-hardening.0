Received: from out.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EDB1E492;
	Sat, 11 Jan 2025 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736607823; cv=none; b=XApi2/lstW6dn4+TUFPjeadR80XhLbaLg/QqWoYezPQU0IZ0StYD4EHm+Zu1kaLq4/y/yYdNiaVQfkbLSBifT0zW38dophH4M5HwkzgUqIumvDQw8ynmg4/aCYodWY9BDs6q/NI8RUVnPKdcl4a9MMp54Iy4jwcle174sintBu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736607823; c=relaxed/simple;
	bh=AjlDSPViCridkQpq/axEpjEcH2ItgMEytzK4T4hZ99U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GzA8x6lRagdzI+CJ7JmVt8/89YZsH0s52WZEZPRzN/Y8X6MbaL6ky3v05Uqmq4KaJws7WiF+1LuHPHf5iPhbq/EEVlRAGvmYoCQ0QIIHC7P8vDA4e6L6fRCaz1g1halRadh8benDTGrkYXgjcfR/o+IR9ZwmszmdNo9RQFH+8Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=rwcSoy+y; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="rwcSoy+y"
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id Wd11tBPCOefOOWd1MtOLAs; Sat, 11 Jan 2025 16:03:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1736607812;
	bh=iLyNQXsWimEYn00kpoNr+aeM2yTPkfGCnVt3CoWTuwI=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=rwcSoy+yjtypvX2MBVFS3iHZPrD97i2ugCHuOWuZciRuhN8oqwVd1IkqM1BN8Uu3H
	 pIjASPYBEf8EXS3JdFnjv7CYzqjzLhCrwLGODlMZLO620+A9yNUaqDgl3W+3LIhNVJ
	 BBF2y18WUQ0DEA9I8Hw+gYpHspiEzxMlCVYVf9vHtc3tejPznJGzp7bCTtz7h1IlF7
	 AIsa5tD0vI5xqUYASRnJt3y8s33wIfo+H11drcBqUunMNkZzenDWcz3b4AxFgzwtR7
	 HsH+VUPO56LlPXC86XZR3c+yPs8lGpPo+/3smdrQhq+UubtE7QWXgIWRbADpO6Q2NJ
	 1dbp4R3JtJGpQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 Jan 2025 16:03:32 +0100
X-ME-IP: 124.33.176.97
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Sun, 12 Jan 2025 00:03:05 +0900
Subject: [PATCH v2] fortify: use __builtin_constant_p() in strlen()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250112-strlen_use_builtin_constant_p-v2-1-2c85b928c9f4@wanadoo.fr>
X-B4-Tracking: v=1; b=H4sIACiIgmcC/4XNQQrCMBCF4auUrI0kwUh15T2khGk6tQMlKZm0K
 qV3NxZcu/zf4nurYEyELK7VKhIuxBRDCXOohB8gPFBSV1oYZazSykrOacTgZkbXzjRmCs7HwBl
 CdpO02oIHq6yHkyjGlLCn1+7fm9IDcY7pvd8t+rv+5PqPvGip5Vnr1hqsFVz62xMCdDEe+ySab
 ds+A+kficsAAAA=
X-Change-ID: 20250105-strlen_use_builtin_constant_p-515aca505ca4
To: Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: David Laight <david.laight@aculab.com>, linux-hardening@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3207;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=AjlDSPViCridkQpq/axEpjEcH2ItgMEytzK4T4hZ99U=;
 b=kA0DAAoW0WQ+QNd/fbMByyZiAGeCiDug+Lw0i8eUGaTUDvrUfqn7bY09z5tfkGVZwge1bMgvF
 Ih1BAAWCgAdFiEEpncJCyCIcUtWwv050WQ+QNd/fbMFAmeCiDsACgkQ0WQ+QNd/fbPVsAD+NL2q
 6gueOQC8oKCWVv6xrm6+cN17/IFz7I7xegNdM6MBAKPZsV/ME+qfZHgAfnM7Wav1a7UBFAERyiy
 ZsAZ0XSQK
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

The strlen(p) function-like macro uses:

  __is_constexpr(__builtin_strlen(p))

in which GCC would only yield true if the argument p is a string
literal. Otherwise, GCC would return false even if p is a const
string.

In contrary, by using:

  __builtin_constant_p(__builtin_strlen(p))

then GCC can also recognizes when p is a compile time constant string.

The above is illustrated in [1].

N.B.: clang is not impacted by any of this and gives the same results
with either __is_constexpr() and __builting_constant_p().

Use __builtin_constant_p() instead of __is_constexpr() so that GCC can
do the folding on compile time constant strings.

Replace the __builtin_choose_expr() by a ternary expression because it
is sufficient and it is the pattern advertised in GCC documentation
for initializers for static data [2].

Finally, __is_constexpr() was historically defined in linux/const.h.
Meanwhile is has been moved to compiler.h. Regardless, the
linux/const.h include directive is not needed any more so remove it.

[1] https://godbolt.org/z/rqr3YvoP4
[2] https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html#index-_005f_005fbuiltin_005fconstant_005fp

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
This patch is the successor of patch [1] which was part of a longer
series [2]. Meanwhile, I decided to split it, so I am sending this again,
but as a stand-alone patch.

Changes in v2:

  - only keep the s/__is_constexpr/__builtin_constant_p/g, do not
    change strlen() into an inline function anymore
  - Link to v1: https://lore.kernel.org/r/20250108-strlen_use_builtin_constant_p-v1-1-611b52e80a9f@wanadoo.fr

Changes since [1]:

  - use __builtin_constant_p() instead and turn strlen() into an
    inline function

[1] https://lore.kernel.org/all/20241203-is_constexpr-refactor-v1-6-4e4cbaecc216@wanadoo.fr/
[2] https://lore.kernel.org/all/20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr/
---
 include/linux/fortify-string.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index e4ce1cae03bf770047ce8a7c032b183683388cd5..ae56a52bf0c5c5d34c4f7029c821ac6ea9f52c3b 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -4,7 +4,6 @@
 
 #include <linux/bitfield.h>
 #include <linux/bug.h>
-#include <linux/const.h>
 #include <linux/limits.h>
 
 #define __FORTIFY_INLINE extern __always_inline __gnu_inline __overloadable
@@ -255,8 +254,8 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size
  *
  */
 #define strlen(p)							\
-	__builtin_choose_expr(__is_constexpr(__builtin_strlen(p)),	\
-		__builtin_strlen(p), __fortify_strlen(p))
+	(__builtin_constant_p(__builtin_strlen(p)) ?			\
+		__builtin_strlen(p) : __fortify_strlen(p))
 __FORTIFY_INLINE __diagnose_as(__builtin_strlen, 1)
 __kernel_size_t __fortify_strlen(const char * const POS p)
 {

---
base-commit: 9d89551994a430b50c4fffcb1e617a057fa76e20
change-id: 20250105-strlen_use_builtin_constant_p-515aca505ca4

Best regards,
-- 
Vincent Mailhol <mailhol.vincent@wanadoo.fr>

