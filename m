Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A430728DF50;
	Wed, 28 May 2025 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748456786; cv=none; b=B5WwGY/W7vbQCwTC00lG+fqFATTwZMvuLN8QC4vpfZ4VePQzqfLbEEBCjPVesGV3rajLeV6q/9e3hlwC09w57jvETTVeqMerojTX9Y2fwqU9o4Kwjc0lxQnFtUnr+y/BDF+zYLM4ugo26jyVUv8+l/XvHdBUvxIA6gXvPFsruJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748456786; c=relaxed/simple;
	bh=mEfXzcnqDNQheuyLIWUHO0vVqugIkry0kL3KxVq/byg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sI9eqoT0E54wUATfM9q1N7PFRLysXnItqR757WBL4l8k0Xq2t7kjNl9Jx9KmFoPBsbSv6ulPJP/dL7E4lvwQFLtdaglsBgPhYmDZpO3BUhAivjCKfSRm6CDelPxICHWhMOOdl7s/HRc+n2Y6UYrVFLErHlP3XgQC1uxxSZtlUF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6xC55NK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6xC55NK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17C6C4CEE3;
	Wed, 28 May 2025 18:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748456785;
	bh=mEfXzcnqDNQheuyLIWUHO0vVqugIkry0kL3KxVq/byg=;
	h=From:To:Cc:Subject:Date:From;
	b=P6xC55NKD6rWiTE8l4AGmFtl6Y09SrdUutWPVAk5TpsfdnCeh+w4FGGxrhPcI8hQ2
	 iGWVJApyBVCqyGrx5o9B/UzamVdi9T1/KEdl/dKjyhHBvFcNBETZ3PEPs0GvAC/o2M
	 5/BtVVFU8Zw7DhSwmNJiFp5ZghQddn4MctbAm/P0hWTekKmgOeEgdc5JeSc0dvKJqW
	 9JTFuGnGO+Wt4Z8UBFdBTYqOrGJ4rWQ1p9vXGYDnaDls/JnOub2XoYFc/N8I3Vi+7q
	 98CQt6M/PdSjHfTJrWTQQ8SvuoCMZgzatuUOvz8r1rKs5tQwi7XHFKq96fRCqlOJoJ
	 BhWUxHlkO0zuQ==
From: Kees Cook <kees@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Marco Elver <elver@google.com>,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ubsan: integer-overflow: depend on BROKEN to keep this out of CI
Date: Wed, 28 May 2025 11:26:22 -0700
Message-Id: <20250528182616.work.296-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1397; i=kees@kernel.org; h=from:subject:message-id; bh=mEfXzcnqDNQheuyLIWUHO0vVqugIkry0kL3KxVq/byg=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnmob7Z0YytHhlTTn6VXleWGLZxwxRZDZuHa19LbbX7m O9srB3QUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJGjRgy/WeYmZ0Sl3NbgOvLj jojXOyPO6Hn+OdEKnisUfHXOP1l+leEX843DKnbrHx7O/Tbly7UTuWqbWlxfZk+Q/XSWbYfG9k9 eXAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Depending on !COMPILE_TEST isn't sufficient to keep this feature out of
CI because we can't stop it from being included in randconfig builds.
This feature is still highly experimental, and is developed in lock-step
with Clang's Overflow Behavior Types[1]. Depend on BROKEN to keep it
from being enabled by anyone not expecting it.

Link: https://discourse.llvm.org/t/rfc-v2-clang-introduce-overflowbehaviortypes-for-wrapping-and-non-wrapping-arithmetic/86507 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Justin Stitt <justinstitt@google.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jann Horn <jannh@google.com>
Cc: Marco Elver <elver@google.com>
Cc: llvm@lists.linux.dev
Cc: <linux-hardening@vger.kernel.org>
---
 lib/Kconfig.ubsan | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index f6ea0c5b5da3..96cd89668467 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -118,6 +118,8 @@ config UBSAN_UNREACHABLE
 
 config UBSAN_INTEGER_WRAP
 	bool "Perform checking for integer arithmetic wrap-around"
+	# This is very experimental so drop the next line if you really want it
+	depends on BROKEN
 	depends on !COMPILE_TEST
 	depends on $(cc-option,-fsanitize-undefined-ignore-overflow-pattern=all)
 	depends on $(cc-option,-fsanitize=signed-integer-overflow)
-- 
2.34.1

