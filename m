Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19DB181BB6;
	Sat, 27 Jul 2024 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722092596; cv=none; b=r18MEhCVu12CNuGmaxYfQWKsngAthaxs66jpbjpXlg8Te6Bnj5kTAu0niF78hyFAycFkaxzxnwb2Um930b3Qr2SRq0V+3Tzs2O9ibhzPKnGaB/aMk4W6aFaINXM/vECum6XWUFY6nXT18+un5inTJs4f3ZrR8rdBFdor5EUAw54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722092596; c=relaxed/simple;
	bh=2yN/VlmMFTF0afGkVkVR3CjBLMIjxBvcVSugI531oxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ne8XPWoKw0JvhZH2bsRtyPU/0cknAsHoGr9AVtZJj4SDGN9viZJ3wY7nOPh3xmoZy3BVRUqdPFqSJMZfzWooVJYQHxLFmutvHpyAPoIQ1fX/RT2Q92RinK0iqGZQC9czkUohSXpyY1IYYDvC5JGdbIVF7ks7LUjBvWaBL2au1W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZtkBBrq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZtkBBrq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C65FC4AF0E;
	Sat, 27 Jul 2024 15:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722092596;
	bh=2yN/VlmMFTF0afGkVkVR3CjBLMIjxBvcVSugI531oxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DZtkBBrqPGXadpPWuVSHyE5SQVu6SX8uQr5Az7bnSlKgCcb75L1TuNW6kYSuRNm3+
	 75iJm3+jT8lfta+KUZgf/vT1UePanwawebFNNT6JBxoXyFjDVa/DnzvoqCHiHseVEF
	 1+VJTzm6DzfFLkLxVzbfXIY0TfeQE6Ru3R2NopknaRVg4iJaUk7OqIKR90JR37HYVZ
	 N9dtvA6wfxugMvEEBaN9OoRFmUcuShcMJfoW9QR3fe2177xc5Z6sZ8JxziaqmRJzGI
	 WB0sJiRIKbA8swl6f41CUBICnJXz6Y1YW84CsjWhwvLTVqMPVQtrhOA61q373JD/TL
	 nMPd1pIUchLYg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 3/3] fortify: use if_changed_dep to record header dependency in *.cmd files
Date: Sun, 28 Jul 2024 00:02:38 +0900
Message-ID: <20240727150302.1823750-4-masahiroy@kernel.org>
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

After building with CONFIG_FORTIFY_SOURCE=y, many .*.d files are left
in lib/test_fortify/ because the compiler outputs header dependencies
into *.d without fixdep being invoked.

When compiling C files, if_changed_dep should be used so that the
auto-generated header dependencies are recorded in .*.cmd files.

Currently, if_changed is incorrectly used, and only two headers are
hard-coded in lib/Makefile.

In the previous patch version, the kbuild test robot detected new errors
on GCC 7.

GCC 7 or older does not produce test.d with the following test code:

 $ echo 'void b(void) __attribute__((__error__(""))); void a(void) { b(); }' |
   gcc -Wp,-MMD,test.d -c -o /dev/null -x c -

Perhaps, this was a bug that existed in older GCC versions.

Skip the tests for GCC<=7 for now, as this will be eventually solved
when we bump the minimal supported GCC version.

Link: https://lore.kernel.org/oe-kbuild-all/CAK7LNARmJcyyzL-jVJfBPi3W684LTDmuhMf1koF0TXoCpKTmcw@mail.gmail.com/T/#m13771bf78ae21adff22efc4d310c973fb4bcaf67
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Skip the tests for GCC <= 7

 lib/test_fortify/Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/test_fortify/Makefile b/lib/test_fortify/Makefile
index 1826172c32d4..1c3f82ad8bb2 100644
--- a/lib/test_fortify/Makefile
+++ b/lib/test_fortify/Makefile
@@ -6,11 +6,8 @@ quiet_cmd_test_fortify = TEST    $@
       cmd_test_fortify = $(CONFIG_SHELL) $(src)/test_fortify.sh \
 			$< $@ "$(NM)" $(CC) $(c_flags) -DKBUILD_EXTRA_WARN1
 
-$(obj)/%.log: $(src)/%.c $(src)/test_fortify.sh \
-	      $(src)/test_fortify.h \
-	      $(srctree)/include/linux/fortify-string.h \
-	      FORCE
-	$(call if_changed,test_fortify)
+$(obj)/%.log: $(src)/%.c $(src)/test_fortify.sh FORCE
+	$(call if_changed_dep,test_fortify)
 
 logs = $(patsubst $(src)/%.c, %.log, $(wildcard $(src)/*-*.c))
 targets += $(logs)
@@ -21,7 +18,10 @@ quiet_cmd_gen_fortify_log = CAT     $@
 $(obj)/test_fortify.log: $(addprefix $(obj)/, $(logs)) FORCE
 	$(call if_changed,gen_fortify_log)
 
-always-y += test_fortify.log
+# GCC<=7 does not always produce *.d files.
+# Run the tests only for GCC>=8 or Clang.
+always-$(call gcc-min-version, 80000) += test_fortify.log
+always-$(CONFIG_CC_IS_CLANG)          += test_fortify.log
 
 # Some architectures define __NO_FORTIFY if __SANITIZE_ADDRESS__ is undefined.
 # Pass CFLAGS_KASAN to avoid warnings.
-- 
2.43.0

