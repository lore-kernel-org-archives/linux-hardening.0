Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266C1181B99;
	Sat, 27 Jul 2024 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722092595; cv=none; b=Y+Qh6Zff7ycjlGt4h6j7pTi3QJSru8e7uBV3RbwRpJmcH57A8hXGtO8a/AiQkMq5BU//PLbUObkRrDyxnG8+T+nEo3s02r6hH9iRJFoYZ7TwgsQSDUR/QvbXXbA5KBAviCScb77cM2G9FPGYTa9xMI5lHvKyrhFN+HW0RR/wygs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722092595; c=relaxed/simple;
	bh=Tu01D0s1mcrNeWCedJqo217lE1eCAdLxxFPJZWU9A0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6mKr8+PRL7Eu44lficbREScLDLenIJz4f1ZROBblfTsVrVTFgVgTOvQ5sYpExrRNOz/ZzlXQQ2vSrWKzBYgpLukkiFuOn0f9Qrj+8wRRSffi0Pr/i0HHn1joVqj9WQ+HFppxwvx23wm/LDHaBT6J8oCN7LhOGX2XOBqdl3X9Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anr3Y+XU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anr3Y+XU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DAFC32781;
	Sat, 27 Jul 2024 15:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722092594;
	bh=Tu01D0s1mcrNeWCedJqo217lE1eCAdLxxFPJZWU9A0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=anr3Y+XU0Bl8OFoUhQLo/BsmAI1bYRjFVYKHgNBdrKdNe6hMzNbnedFSoGrVV0m7Z
	 K8Q/igpC8AX6Jdzc4iGoPT6PMSQAL4Ynv4b/0xAvDFWH5iU++gi4wM4TDpRAnoq55b
	 CEuV3SAm2b2nsyfhJ2yRCcWdkIfEf0tpL6CKLLpYzsVo6YAg5aHAmi8X1dVuYAtY8L
	 4lfna5WxptIav1gpJ9aYwPY84ReovbDuLd2+Kfriz9ngyL4HthV0Cj3Fr8nP6+nbLR
	 ghmzrHQq6+CF26KSBXylHnMGTXCbWy247R+prGbRFdWkCNk829QopP8SyVLHmCcGqm
	 /1S72WmItYB1Q==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 2/3] fortify: move test_fortify.sh to lib/test_fortify/
Date: Sun, 28 Jul 2024 00:02:37 +0900
Message-ID: <20240727150302.1823750-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240727150302.1823750-1-masahiroy@kernel.org>
References: <20240727150302.1823750-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This script is only used in lib/test_fortify/.

There is no reason to keep it in scripts/.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

 MAINTAINERS                                   | 1 -
 lib/test_fortify/Makefile                     | 4 ++--
 {scripts => lib/test_fortify}/test_fortify.sh | 0
 3 files changed, 2 insertions(+), 3 deletions(-)
 rename {scripts => lib/test_fortify}/test_fortify.sh (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 85fbbc25112f..6e14bd77e3c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8758,7 +8758,6 @@ F:	include/linux/fortify-string.h
 F:	lib/fortify_kunit.c
 F:	lib/memcpy_kunit.c
 F:	lib/test_fortify/*
-F:	scripts/test_fortify.sh
 K:	\b__NO_FORTIFY\b
 
 FPGA DFL DRIVERS
diff --git a/lib/test_fortify/Makefile b/lib/test_fortify/Makefile
index 3907a2242ef9..1826172c32d4 100644
--- a/lib/test_fortify/Makefile
+++ b/lib/test_fortify/Makefile
@@ -3,10 +3,10 @@
 ccflags-y := $(call cc-disable-warning,fortify-source)
 
 quiet_cmd_test_fortify = TEST    $@
-      cmd_test_fortify = $(CONFIG_SHELL) $(srctree)/scripts/test_fortify.sh \
+      cmd_test_fortify = $(CONFIG_SHELL) $(src)/test_fortify.sh \
 			$< $@ "$(NM)" $(CC) $(c_flags) -DKBUILD_EXTRA_WARN1
 
-$(obj)/%.log: $(src)/%.c $(srctree)/scripts/test_fortify.sh \
+$(obj)/%.log: $(src)/%.c $(src)/test_fortify.sh \
 	      $(src)/test_fortify.h \
 	      $(srctree)/include/linux/fortify-string.h \
 	      FORCE
diff --git a/scripts/test_fortify.sh b/lib/test_fortify/test_fortify.sh
similarity index 100%
rename from scripts/test_fortify.sh
rename to lib/test_fortify/test_fortify.sh
-- 
2.43.0

