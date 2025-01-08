Received: from out.smtpout.orange.fr (out-17.smtpout.orange.fr [193.252.22.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007E81DB37B;
	Wed,  8 Jan 2025 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736346595; cv=none; b=k9OUxL9aZgi2spbGkkqgKkUfPjpWW0LzvHBPjVEr3iUSvObpo8SCNbISiEUafFq19Tyz/jMoIQmpnd2LVaKvW1v2aPrW+ZD0lobj4NMioFPaSyzBlqJC1aP2Md2V7LC1qhVINK7Jbnp1QfixrAqZUu0pbPxHtMVi26QtRLhEum0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736346595; c=relaxed/simple;
	bh=MjKh/LYH2VJL6NObanB7K6M3t56T0vtIQHEjOYRh5zA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=j3MSBwsNxUk3woQxLy7F6uHAAs5+9DQ/dRjZ6xiorfp+wWSExbaRtrxtaSgCh3AXVnjlAye/VBgaJZskp5pt2CkGBtPXQCkDgyZ8dVXKq0ZxhJpTvUCCooVBpFVhO1U99prHgZaQ4LwAwP/EtIp/xlJRQB+l+r/4WRV7dDZDWvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Bjgml3gP; arc=none smtp.client-ip=193.252.22.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Bjgml3gP"
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id VX2itMI6Y32NAVX2wtbvIw; Wed, 08 Jan 2025 15:28:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1736346518;
	bh=PxUQztcRuYrMXkHTXs3g2OIgo2Eb99UYd7M2XyP7GGY=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=Bjgml3gPKGys52oJgsdVvdK/uHRRw+hM7qU7y7Pir/wVmQbEbC9DweYecPtQNCRHz
	 PUL+7GKKQnx3Sy9UkHeKG+skzb5einAbFLV1KmeaVIZ23P6tiP1IEJpKHYn5taK2WP
	 Ka+P7vnw8SC8y8ygZVSnSMM+RXhPN7vbf049DhaAMd2DYmvPDo/b+v2DYUlb+v1wuP
	 XGpc7GrWUt+p9UNDYIrj2OnxfPVK/EtFp/PWfkO6CCdder2Bu7zIsWjmpRyN25q5p5
	 anxxAZ+ZTeuxqfMoHT2saZCqIt8JgAEjOW217jLufBxYMHUdKcy0VXzEcu77/DXtK5
	 IwQrFy8vKdsvw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 08 Jan 2025 15:28:38 +0100
X-ME-IP: 124.33.176.97
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Wed, 08 Jan 2025 23:27:51 +0900
Subject: [PATCH] fortify: turn strlen() into an inline function using
 __builtin_constant_p()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-strlen_use_builtin_constant_p-v1-1-611b52e80a9f@wanadoo.fr>
X-B4-Tracking: v=1; b=H4sIAGaLfmcC/x3MQQqEMAwAwK9IzltoxVz8ikjJdqMGJEpTZUH8u
 8XjXOYC4yxs0DcXZD7FZNOK8GkgLaQzO/lVQ+tb9MGjs5JX1ngYx+8haxGNaVMrpCXuDgNSIvS
 YqIN67Jkn+b//MN73Ax/i9yVvAAAA
X-Change-ID: 20250105-strlen_use_builtin_constant_p-515aca505ca4
To: Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: David Laight <david.laight@aculab.com>, linux-hardening@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4123;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=MjKh/LYH2VJL6NObanB7K6M3t56T0vtIQHEjOYRh5zA=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOl13X1S4t9b06asfTuHz1Dvn+0t/r3bxVhNz5wSFkn+c
 4pHyquno5SFQYyLQVZMkWVZOSe3Qkehd9ihv5Ywc1iZQIYwcHEKwEQkVjL807ZmOP7X3Xn+hlRx
 wcjriVM3BIhPbJ9eca4t+HD1sx9NhYwMDTxhAsZfK3+cEHnT1VvVH7I4+wjjUbmYK5uU2YK3xLr
 zAgA=
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
do the folding on constant strings. This done, strlen() does not
require any more to be a function-like macro, so turn it into a static
inline function. In the process, __fortify_strlen() had to be moved
above strlen() so that it became visible to strlen().

On a side note, strlen() did a double expansion of its argument p.
Turning it into an inline function also resolved this side issue.

[1] https://godbolt.org/z/rqr3YvoP4

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
This patch is the successor of patch [1] which was part of a longer
series [2]. Meanwhile, I decided to split it, so I am sending this again,
but as a stand-alone patch.

Changelog since [1]: use __builtin_constant_p() instead and turn
strlen() into an inline function

[1] https://lore.kernel.org/all/20241203-is_constexpr-refactor-v1-6-4e4cbaecc216@wanadoo.fr/
[2] https://lore.kernel.org/all/20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr/
---
 include/linux/fortify-string.h | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index e4ce1cae03bf770047ce8a7c032b183683388cd5..bd22dd66e5f5b66ad839df42247e6436e0afd053 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -4,7 +4,6 @@
 
 #include <linux/bitfield.h>
 #include <linux/bug.h>
-#include <linux/const.h>
 #include <linux/limits.h>
 
 #define __FORTIFY_INLINE extern __always_inline __gnu_inline __overloadable
@@ -241,6 +240,21 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size
  * possible for strlen() to be used on compile-time strings for use in
  * static initializers (i.e. as a constant expression).
  */
+__FORTIFY_INLINE __diagnose_as(__builtin_strlen, 1)
+__kernel_size_t __fortify_strlen(const char * const POS p)
+{
+	const size_t p_size = __member_size(p);
+	__kernel_size_t ret;
+
+	/* Give up if we don't know how large p is. */
+	if (p_size == SIZE_MAX)
+		return __underlying_strlen(p);
+	ret = strnlen(p, p_size);
+	if (p_size <= ret)
+		fortify_panic(FORTIFY_FUNC_strlen, FORTIFY_READ, p_size, ret + 1, ret);
+	return ret;
+}
+
 /**
  * strlen - Return count of characters in a NUL-terminated string
  *
@@ -254,22 +268,12 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size
  * Returns number of characters in @p (NOT including the final NUL).
  *
  */
-#define strlen(p)							\
-	__builtin_choose_expr(__is_constexpr(__builtin_strlen(p)),	\
-		__builtin_strlen(p), __fortify_strlen(p))
 __FORTIFY_INLINE __diagnose_as(__builtin_strlen, 1)
-__kernel_size_t __fortify_strlen(const char * const POS p)
+__kernel_size_t strlen(const char *p)
 {
-	const size_t p_size = __member_size(p);
-	__kernel_size_t ret;
-
-	/* Give up if we don't know how large p is. */
-	if (p_size == SIZE_MAX)
-		return __underlying_strlen(p);
-	ret = strnlen(p, p_size);
-	if (p_size <= ret)
-		fortify_panic(FORTIFY_FUNC_strlen, FORTIFY_READ, p_size, ret + 1, ret);
-	return ret;
+	if (__builtin_constant_p(__builtin_strlen(p)))
+		return __builtin_strlen(p);
+	return __fortify_strlen(p);
 }
 
 /* Defined after fortified strnlen() to reuse it. */

---
base-commit: 9d89551994a430b50c4fffcb1e617a057fa76e20
change-id: 20250105-strlen_use_builtin_constant_p-515aca505ca4

Best regards,
-- 
Vincent Mailhol <mailhol.vincent@wanadoo.fr>

