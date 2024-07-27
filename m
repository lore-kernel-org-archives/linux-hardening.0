Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFAE18132A;
	Sat, 27 Jul 2024 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722092593; cv=none; b=VzpBCbCBa3zXZyvH8FPbxN0/8ocW3LuiG+1tFjL5Dg3grVJc88bvurwSsoToN/L+srfdr8kG+OxJO01jfuHN1gotF9Km+6MT0pO5ttLatqDqvk+sde5lsaXOBY6ScU7MI2Ejr4VfMbNSccqa9TMFRQRuVkVhGI5DlLntzjsTiok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722092593; c=relaxed/simple;
	bh=cbx1YE48B0umWKjby4D8iyQs0I9pecobsv9rKwrf2TU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mb7NACoQMcV+Kco8N1SuQmq9A7B2VK2yl8Js+faC3VEaFNDSuqS2RtYgjWGxP0m8z1YtyoeRon0noXrFwGPHhnjeGwnH+JQJiR7oYifxcx7ox2y7/N7GQePB79p/GRSKDhe0ZERfupp9B6A9QJpA4+JtiyVMnGAwkVBhUeASo1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWkuW7HA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWkuW7HA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29486C4AF0A;
	Sat, 27 Jul 2024 15:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722092593;
	bh=cbx1YE48B0umWKjby4D8iyQs0I9pecobsv9rKwrf2TU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jWkuW7HAzR0gw+6wM8OI2NwsPCW2Fv1qaRUgiQLNHFHZj+zSpiwKk1L3vwv2LHe5U
	 4O1xNzfFTF9vP0iGtf5sq1VYJrox04hb5lnBJQz+M1WyWPtDXL6MsZg/TWUUjMtgXq
	 YP+2l2QHIQEZgpayLAL2+/e57mQQG5gHVnLZgHt9S8X5e9YlODmgJ5LtZDPgndguk5
	 CCkDML8P2I6uDdNCCEsZGZ2V2aKf52wA7iGgLOTse3L4cBs5FYNhcMSN+5Qz70j6Tu
	 6HfD6VKILUIG/rLjIv7xNHrTPKWQCbgfpRHGx1+7EMLsj+blN858YAQUUo3w8dlkt8
	 dhbq51cjjBTcQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/3] fortify: refactor test_fortify Makefile to fix some build problems
Date: Sun, 28 Jul 2024 00:02:36 +0900
Message-ID: <20240727150302.1823750-2-masahiroy@kernel.org>
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

There are some issues in the test_fortify Makefile code.

Problem 1: cc-disable-warning invokes compiler dozens of times

To see how many times the cc-disable-warning is evaluated, change
this code:

  $(call cc-disable-warning,fortify-source)

to:

  $(call cc-disable-warning,$(shell touch /tmp/fortify-$$$$)fortify-source)

Then, build the kernel with CONFIG_FORTIFY_SOURCE=y. You will see a
large number of '/tmp/fortify-<PID>' files created:

  $ ls -1 /tmp/fortify-* | wc
       80      80    1600

This means the compiler was invoked 80 times just for checking the
-Wno-fortify-source flag support.

$(call cc-disable-warning,fortify-source) should be added to a simple
variable instead of a recursive variable.

Problem 2: do not recompile string.o when the test code is updated

The test cases are independent of the kernel. However, when the test
code is updated, $(obj)/string.o is rebuilt and vmlinux is relinked
due to this dependency:

  $(obj)/string.o: $(obj)/$(TEST_FORTIFY_LOG)

always-y is suitable for building the log files.

Problem 3: redundant code

  clean-files += $(addsuffix .o, $(TEST_FORTIFY_LOGS))

... is unneeded because the top Makefile globally cleans *.o files.

This commit fixes these issues and makes the code readable.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

 lib/.gitignore              |  2 --
 lib/Makefile                | 38 +------------------------------------
 lib/test_fortify/.gitignore |  2 ++
 lib/test_fortify/Makefile   | 28 +++++++++++++++++++++++++++
 4 files changed, 31 insertions(+), 39 deletions(-)
 create mode 100644 lib/test_fortify/.gitignore
 create mode 100644 lib/test_fortify/Makefile

diff --git a/lib/.gitignore b/lib/.gitignore
index 54596b634ecb..101a4aa92fb5 100644
--- a/lib/.gitignore
+++ b/lib/.gitignore
@@ -5,5 +5,3 @@
 /gen_crc32table
 /gen_crc64table
 /oid_registry_data.c
-/test_fortify.log
-/test_fortify/*.log
diff --git a/lib/Makefile b/lib/Makefile
index 322bb127b4dc..4df3c28b23b4 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -393,40 +393,4 @@ obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
 obj-$(CONFIG_FIRMWARE_TABLE) += fw_table.o
 
-# FORTIFY_SOURCE compile-time behavior tests
-TEST_FORTIFY_SRCS = $(wildcard $(src)/test_fortify/*-*.c)
-TEST_FORTIFY_LOGS = $(patsubst $(src)/%.c, %.log, $(TEST_FORTIFY_SRCS))
-TEST_FORTIFY_LOG = test_fortify.log
-
-quiet_cmd_test_fortify = TEST    $@
-      cmd_test_fortify = $(CONFIG_SHELL) $(srctree)/scripts/test_fortify.sh \
-			$< $@ "$(NM)" $(CC) $(c_flags) \
-			$(call cc-disable-warning,fortify-source) \
-			-DKBUILD_EXTRA_WARN1
-
-targets += $(TEST_FORTIFY_LOGS)
-clean-files += $(TEST_FORTIFY_LOGS)
-clean-files += $(addsuffix .o, $(TEST_FORTIFY_LOGS))
-$(obj)/test_fortify/%.log: $(src)/test_fortify/%.c \
-			   $(src)/test_fortify/test_fortify.h \
-			   $(srctree)/include/linux/fortify-string.h \
-			   $(srctree)/scripts/test_fortify.sh \
-			   FORCE
-	$(call if_changed,test_fortify)
-
-quiet_cmd_gen_fortify_log = GEN     $@
-      cmd_gen_fortify_log = cat </dev/null $(filter-out FORCE,$^) 2>/dev/null > $@ || true
-
-targets += $(TEST_FORTIFY_LOG)
-clean-files += $(TEST_FORTIFY_LOG)
-$(obj)/$(TEST_FORTIFY_LOG): $(addprefix $(obj)/, $(TEST_FORTIFY_LOGS)) FORCE
-	$(call if_changed,gen_fortify_log)
-
-# Fake dependency to trigger the fortify tests.
-ifeq ($(CONFIG_FORTIFY_SOURCE),y)
-$(obj)/string.o: $(obj)/$(TEST_FORTIFY_LOG)
-endif
-
-# Some architectures define __NO_FORTIFY if __SANITIZE_ADDRESS__ is undefined.
-# Pass CFLAGS_KASAN to avoid warnings.
-$(foreach x, $(patsubst %.log,%.o,$(TEST_FORTIFY_LOGS)), $(eval KASAN_SANITIZE_$(x) := y))
+subdir-$(CONFIG_FORTIFY_SOURCE) += test_fortify
diff --git a/lib/test_fortify/.gitignore b/lib/test_fortify/.gitignore
new file mode 100644
index 000000000000..c1ba37d14b50
--- /dev/null
+++ b/lib/test_fortify/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+/*.log
diff --git a/lib/test_fortify/Makefile b/lib/test_fortify/Makefile
new file mode 100644
index 000000000000..3907a2242ef9
--- /dev/null
+++ b/lib/test_fortify/Makefile
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0
+
+ccflags-y := $(call cc-disable-warning,fortify-source)
+
+quiet_cmd_test_fortify = TEST    $@
+      cmd_test_fortify = $(CONFIG_SHELL) $(srctree)/scripts/test_fortify.sh \
+			$< $@ "$(NM)" $(CC) $(c_flags) -DKBUILD_EXTRA_WARN1
+
+$(obj)/%.log: $(src)/%.c $(srctree)/scripts/test_fortify.sh \
+	      $(src)/test_fortify.h \
+	      $(srctree)/include/linux/fortify-string.h \
+	      FORCE
+	$(call if_changed,test_fortify)
+
+logs = $(patsubst $(src)/%.c, %.log, $(wildcard $(src)/*-*.c))
+targets += $(logs)
+
+quiet_cmd_gen_fortify_log = CAT     $@
+      cmd_gen_fortify_log = cat $(or $(real-prereqs),/dev/null) > $@
+
+$(obj)/test_fortify.log: $(addprefix $(obj)/, $(logs)) FORCE
+	$(call if_changed,gen_fortify_log)
+
+always-y += test_fortify.log
+
+# Some architectures define __NO_FORTIFY if __SANITIZE_ADDRESS__ is undefined.
+# Pass CFLAGS_KASAN to avoid warnings.
+KASAN_SANITIZE := y
-- 
2.43.0

