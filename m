Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F46194154;
	Mon, 17 Jun 2024 18:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647983; cv=none; b=IJoa3wfIatorHYaY3A3OJi7rXd7UE9UPc9wVEN+AelOobdM3/916cXvXpGtAnqrmzih5dmtWUBTu39hOqKPt60NPRO4KhCFAfTusqP2s09/34QlFLNyHi1OnLIQWkkMbEG37lN0V8GykaAOjondPRBFx7fbJEf0fIpshfHgFuTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647983; c=relaxed/simple;
	bh=qGzzFCM9GBI/T5/mvB26jY5aMzmD2fljhmO2aKHr978=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QtlTn5tIdGSuIl7CCvqrdzYug6PH+zPqMYxkHPSNPR073u83+ySWH/2Mwuoe47lS3LWaSMfNQnB8pYfHvljbOcfml2jNCCwKA7M2/MxIkqYcS8oSxL+SLBsPVvyeTXHhg503m4fodkb6j2xGhpPcDtJyJOOL26uRQIxEZogq9zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mudRwMLg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mudRwMLg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B107FC2BD10;
	Mon, 17 Jun 2024 18:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718647982;
	bh=qGzzFCM9GBI/T5/mvB26jY5aMzmD2fljhmO2aKHr978=;
	h=From:To:Cc:Subject:Date:From;
	b=mudRwMLg9qfFInpL3OaquJb0OLV867NqKJ7FIOlTLSIg3MXJf08QfF0W02zceTv0Z
	 vroXLjFcJzhORlpDOlZFhuUsoeGWoh+hK1qSydVa2GGpXMW/rBpsITex5jzrwCI9fk
	 ejfmFFb/k0+KouYDkWdQlJQHGoERj4FfRdD0qY6aQ/ZNG2qtvb4RHu4d+MIGvGg2LT
	 tVLEF+E8LLBD2jdTedKfmNJgXjF5O8m6A6G1nAVkApFS25eYdU5O4S/fbVhcPVm1ci
	 TrK5Fyyvrff0APAl5QMeGpFHccISK4VIusDeKOXc6g3gvjM7LTOZUHH9v/FAITXu9n
	 tjQ60CpOzwJdg==
From: Kees Cook <kees@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update entries for Kees Cook
Date: Mon, 17 Jun 2024 11:13:01 -0700
Message-Id: <20240617181257.work.206-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4783; i=kees@kernel.org; h=from:subject:message-id; bh=qGzzFCM9GBI/T5/mvB26jY5aMzmD2fljhmO2aKHr978=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmcHyti7HlRWjD2TwtqEZMQJpIYrgqrBrX1VXDE 31Ix3Z3EDyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZnB8rQAKCRCJcvTf3G3A JqGpD/94AcYEO9+psNEvzDJmExL2YCWdBdwzEPFddhPlIfXW9IdpJm/2cJimt8+SAKklUwEdEaA HYEbTfq6WRJ8P2c2N5X17ShpMMk3/gdlBCeXXI5W34lMrJI535QvIMP8OahiaAeK4bIxHKGzCKr L/NF7Cm6ZTD0gcBxpAQMN+dXOjj6FIRUhucNPTUOHKV28cyMavtZo3uO/HLRK66uwJpYxFFS0iE Hs66/flhe/6Z6xiePl/iB2rCcuAOkBZ3BPAkxp40OAlBQvX4GMI3JrmiQpQc5r6g5P6nkkC+U/a cNzaHtazOKowgU1lnqpugAi58NXfr+nc8ez7MoGf7o+l8UAqN0/A7ZOE+djY1B9D54q6oKFENQQ jVQgHSRXjl9XyZxMvzok2L9WK5T7jvXkNR7Et/JJCXXdrTLrSmRp5+HT2MNadIUBGu8dnnOU+ss 3RhWvAx+I47CDhhlYgz2JYQbVWse6KDwekfvnfc72/n/kM3N2Aq9M6m4FTQMC+Aw+mLUkVSbjs8 FZ8im3MOTu1s1H9rrQTdBSy7r74avWPaLe9aJCRQ0YM+HdzXzxkdYmEK7bTL3sGoTYMy6I1U+lr imgoePphv11rit4YbwNL5KgTe0MGuVqJuJIUo5hvQSrLJtpR+5CLgoFIKbz1Jvrept4lugjpvm5 C/AHYs7xfVsFj
 lA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Update current email address for Kees Cook in the MAINTAINER file to
match the change from commit 4e173c825b19 ("mailmap: update entry for
Kees Cook").

Signed-off-by: Kees Cook <kees@kernel.org>
---
 MAINTAINERS | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8754ac2c259d..f601a2fd1ebf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5296,7 +5296,7 @@ F:	drivers/infiniband/hw/usnic/
 
 CLANG CONTROL FLOW INTEGRITY SUPPORT
 M:	Sami Tolvanen <samitolvanen@google.com>
-M:	Kees Cook <keescook@chromium.org>
+M:	Kees Cook <kees@kernel.org>
 R:	Nathan Chancellor <nathan@kernel.org>
 L:	llvm@lists.linux.dev
 S:	Supported
@@ -8212,7 +8212,7 @@ F:	rust/kernel/net/phy.rs
 
 EXEC & BINFMT API, ELF
 R:	Eric Biederman <ebiederm@xmission.com>
-R:	Kees Cook <keescook@chromium.org>
+R:	Kees Cook <kees@kernel.org>
 L:	linux-mm@kvack.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
@@ -8613,7 +8613,7 @@ S:	Maintained
 F:	drivers/net/ethernet/nvidia/*
 
 FORTIFY_SOURCE
-M:	Kees Cook <keescook@chromium.org>
+M:	Kees Cook <kees@kernel.org>
 L:	linux-hardening@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
@@ -9103,7 +9103,7 @@ F:	include/linux/mfd/gsc.h
 F:	include/linux/platform_data/gsc_hwmon.h
 
 GCC PLUGINS
-M:	Kees Cook <keescook@chromium.org>
+M:	Kees Cook <kees@kernel.org>
 L:	linux-hardening@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
@@ -9237,7 +9237,7 @@ S:	Maintained
 F:	drivers/input/touchscreen/resistive-adc-touch.c
 
 GENERIC STRING LIBRARY
-M:	Kees Cook <keescook@chromium.org>
+M:	Kees Cook <kees@kernel.org>
 R:	Andy Shevchenko <andy@kernel.org>
 L:	linux-hardening@vger.kernel.org
 S:	Supported
@@ -11951,7 +11951,7 @@ F:	scripts/package/
 F:	usr/
 
 KERNEL HARDENING (not covered by other areas)
-M:	Kees Cook <keescook@chromium.org>
+M:	Kees Cook <kees@kernel.org>
 R:	Gustavo A. R. Silva <gustavoars@kernel.org>
 L:	linux-hardening@vger.kernel.org
 S:	Supported
@@ -12479,7 +12479,7 @@ F:	drivers/scsi/53c700*
 
 LEAKING_ADDRESSES
 M:	Tycho Andersen <tycho@tycho.pizza>
-R:	Kees Cook <keescook@chromium.org>
+R:	Kees Cook <kees@kernel.org>
 L:	linux-hardening@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
@@ -12775,7 +12775,7 @@ F:	arch/powerpc/platforms/8xx/
 F:	arch/powerpc/platforms/83xx/
 
 LINUX KERNEL DUMP TEST MODULE (LKDTM)
-M:	Kees Cook <keescook@chromium.org>
+M:	Kees Cook <kees@kernel.org>
 S:	Maintained
 F:	drivers/misc/lkdtm/*
 F:	tools/testing/selftests/lkdtm/*
@@ -12905,7 +12905,7 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 F:	drivers/media/usb/dvb-usb-v2/lmedm04*
 
 LOADPIN SECURITY MODULE
-M:	Kees Cook <keescook@chromium.org>
+M:	Kees Cook <kees@kernel.org>
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
 F:	Documentation/admin-guide/LSM/LoadPin.rst
@@ -17998,7 +17998,7 @@ F:	tools/testing/selftests/proc/
 
 PROC SYSCTL
 M:	Luis Chamberlain <mcgrof@kernel.org>
-M:	Kees Cook <keescook@chromium.org>
+M:	Kees Cook <kees@kernel.org>
 M:	Joel Granados <j.granados@samsung.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-fsdevel@vger.kernel.org
@@ -18054,7 +18054,7 @@ F:	Documentation/devicetree/bindings/net/pse-pd/
 F:	drivers/net/pse-pd/
 
 PSTORE FILESYSTEM
-M:	Kees Cook <keescook@chromium.org>
+M:	Kees Cook <kees@kernel.org>
 R:	Tony Luck <tony.luck@intel.com>
 R:	Guilherme G. Piccoli <gpiccoli@igalia.com>
 L:	linux-hardening@vger.kernel.org
@@ -20060,7 +20060,7 @@ F:	drivers/media/cec/platform/seco/seco-cec.c
 F:	drivers/media/cec/platform/seco/seco-cec.h
 
 SECURE COMPUTING
-M:	Kees Cook <keescook@chromium.org>
+M:	Kees Cook <kees@kernel.org>
 R:	Andy Lutomirski <luto@amacapital.net>
 R:	Will Drewry <wad@chromium.org>
 S:	Supported
@@ -22974,7 +22974,7 @@ F:	drivers/block/ublk_drv.c
 F:	include/uapi/linux/ublk_cmd.h
 
 UBSAN
-M:	Kees Cook <keescook@chromium.org>
+M:	Kees Cook <kees@kernel.org>
 R:	Marco Elver <elver@google.com>
 R:	Andrey Konovalov <andreyknvl@gmail.com>
 R:	Andrey Ryabinin <ryabinin.a.a@gmail.com>
@@ -24812,7 +24812,7 @@ F:	drivers/net/hamradio/yam*
 F:	include/linux/yam.h
 
 YAMA SECURITY MODULE
-M:	Kees Cook <keescook@chromium.org>
+M:	Kees Cook <kees@kernel.org>
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
 F:	Documentation/admin-guide/LSM/Yama.rst
-- 
2.34.1

