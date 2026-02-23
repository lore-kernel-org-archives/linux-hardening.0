Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDC7315D46;
	Mon, 23 Feb 2026 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771871007; cv=none; b=OSOoDGX44AqO/Pme1KyKYXW5DHd/9DXHY/lEchsU5YHfNV2e6S98Lqd7zOanC5byNurekYwNuzB99l+YonQKK0N8xOzlp/YcXEH7IGZtuRBLLFz9mPvVg8eQf4zLZI8GX+2cJ1U9hzQYmc2clRRJ3q4pSxK5tktA8SZWagKou2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771871007; c=relaxed/simple;
	bh=6+2naQDXV5XODs47cZvDUyCoEdwlayXFA/uMm8d4/HY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rUmdtSLbxQao7lB1qcoVK2vbbC/Qr4RgbjIQizolYiUl1mCYD2ebOAv7t/xix3mX8ANseJM1O8e8O/JmkkIu7+xR7YdfnXl4kGVqn/Kti+RmpYI2G3xAOhQJbsepD0FdA7Q1bBaIKqPygFMZJ+PQzmkFrAiiPVeQQ54Go/tn7gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSbrhxjJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSbrhxjJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361BEC116C6;
	Mon, 23 Feb 2026 18:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771871006;
	bh=6+2naQDXV5XODs47cZvDUyCoEdwlayXFA/uMm8d4/HY=;
	h=From:Date:Subject:To:Cc:From;
	b=tSbrhxjJusGsXpCZ+JQYWKeF+uIsYK3cZ88z58ReYq2CYcg0uN06mm8UtU/Bp1uJo
	 R4dP3W1XC3+2ITv0dK6x4D07kp530IMPbIJlFkbxbIFZtwQpOY4KZ7sx13N+YYf2QK
	 n8I28bSszPv6b9m+XFZ2JkVnnpLCo6wsJJptRAsJZ1gNIKEu8qVC4Likeb7mYzdDs1
	 JYBnYsnfO53sAYwOYjevHbyfGDWqZ4duklAyZKT23Y/6vslC6Z1uh+A0MZh4GShZtI
	 /ufcqWrsbD296fYJ9sqIxcr+Iv/f3j9y2msNIaQm9ZgVeedhlZ/nVFTIE7PD/sXIy6
	 qgIIADjl4irbw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 23 Feb 2026 11:23:12 -0700
Subject: [PATCH] init/Kconfig: Adjust fixed clang version for
 __builtin_counted_by_ref
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-fix-clang-version-builtin-counted-by-ref-v1-1-3ea478a24f0a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWN2wrCMBBEf6Xsswt1IwH9FfHBJJu6UlLJpVRK/
 92tfTwzw5kVCmfhArduhcyzFJmSwvnUgX8908AoQRmoJ9sTGYyyoB+1wZnzvkbXZKyS0E8tVQ7
 ovpg5IgXmqzU2XkwA1X00lOV/dX8cXJp7s6+7H7btBxdN3YWMAAAA
X-Change-ID: 20260223-fix-clang-version-builtin-counted-by-ref-2dee9636f43d
To: Kees Cook <kees@kernel.org>, Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1495; i=nathan@kernel.org;
 h=from:subject:message-id; bh=6+2naQDXV5XODs47cZvDUyCoEdwlayXFA/uMm8d4/HY=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDJlzZstkx6xsENulecokm7el2c7F9HpF5vri+r9HA1O5v
 KNr+6M6SlkYxLgYZMUUWaofqx43NJxzlvHGqUkwc1iZQIYwcHEKwES4XzEyTGyZ7fs602KTIsvx
 vwIBk9/z/D+d+bvp9rvm5dJ2z2fN3sHIcHh7je/cM9XztwWsXWTG4vyPQ37VKx9p3Uidht/Hbp/
 dwwoA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Commit d39a1d7486d9 ("compiler_types: Disable __builtin_counted_by_ref
for Clang") used 22.0.0 as the fixed version for a compiler crash but
the fix was only merged in main (23.0.0) and release/22.x (22.1.0). With
the current fixed version number, prerelease or Android LLVM 22 builds
will still be able to hit the compiler crash when building the kernel.
This can be particularly disruptive when bisecting LLVM.

Use 21.1.0 as the fixed version number to ensure the fix for this crash
is always present.

Fixes: d39a1d7486d9 ("compiler_types: Disable __builtin_counted_by_ref for Clang")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index c25869cf59c1..b55deae9256c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -153,7 +153,7 @@ config CC_HAS_COUNTED_BY_PTR
 config CC_HAS_BROKEN_COUNTED_BY_REF
 	bool
 	# https://github.com/llvm/llvm-project/issues/182575
-	default y if CC_IS_CLANG && CLANG_VERSION < 220000
+	default y if CC_IS_CLANG && CLANG_VERSION < 220100
 
 config CC_HAS_MULTIDIMENSIONAL_NONSTRING
 	def_bool $(success,echo 'char tag[][4] __attribute__((__nonstring__)) = { };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260223-fix-clang-version-builtin-counted-by-ref-2dee9636f43d

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>

