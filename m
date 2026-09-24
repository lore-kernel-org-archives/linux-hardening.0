Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC5C3B47D9;
	Thu, 24 Sep 2026 20:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790282075; cv=none; b=OGU31iih4VplKPrJlnoLp/FMuwWbeM64VVrmUZScgNsHdgX/D2liMPCDWIwxJdY6a1rwYaP7UskhzF083UpQF406gaz/XXZyjSUl73tHCtam9GMYOyFrPbxknYR1+bUqnhtFkPHe5xSqgouxXBJjXhd2rXwkBBuyp4OAkHH8GSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790282075; c=relaxed/simple;
	bh=tZ4LhebgG0hWDs4rbIm7P3IxIqV2Qc2V5xxW9DvcwZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tERtFR2/VmuKF+2MCvfduiQwcl+x9UrqFq4oJqeo3gv3Jvesg17Uz5F3pMrFWcPN0EzMOLHYLp1t+FN9MTaHYTiZ/kQPvlsPavWr8243PswLV75prSL3rzoqb14IUBg8lHBt9aP/MjhHE11Gos6xdr2QWJt+zlG0KUTun009uOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ps7ALK0v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ps7ALK0v"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1B99C2BCB3;
	Thu, 24 Sep 2026 20:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790282073;
	bh=tZ4LhebgG0hWDs4rbIm7P3IxIqV2Qc2V5xxW9DvcwZk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ps7ALK0vrHJrmCCAqQerXO41PYiDyCwqV+F8eJpwdaOW+lAdcPvDrVhRQko59ZHr+
	 vgsEGPs3SyvIgdnDBp2DeGlLvo4WytoHBAZXHNMfA5fzHB0UC21DFwdrypfwz0i0PW
	 ApaOhIfXOT7Gc0xQ83vwO8hTRQ/D+jysPAo71mNvR3x8n1NH90PqboVXJezKc2U4kD
	 K8e9uDNa3wKZKgRJEMeJwmRiunZPeBLVDdtKm/YMz917CRlMUIx8T04k8I9b+dP9fK
	 N8MnCxCrdSKF+MvIv7zlAjUIzPp5FUDIqDpySnotnYDDUdSRzutyaV8ZkCliXiWHG6
	 KRtXbUZ/z5B9Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A2CC98318;
	Thu, 24 Sep 2026 20:34:33 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Thu, 24 Sep 2026 23:34:29 +0300
Subject: [PATCH] fortify: Disable colored diagnostics in test_fortify.sh
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-fortify-test-color-v1-1-37f6d50e31ec@iav.lv>
X-B4-Tracking: v=1; b=H4sIAFSJtWoC/x3MQQqAIBBA0avErBsos6CuEi3MxhqIjFGiCO+et
 HyL/18IJEwBhuIFoYsD+yOjLguwmzlWQl6yQVWqq3ql0XmJ7B6MFCJav3tB12jT1HPbzdZCDk8
 hx/c/HaeUPvTYskFkAAAA
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolas Schier <nsc@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2167; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=tN/DvwCdrtUMmAm2d81PYH3EqnXQ5R4X+EBqa75C8ac=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFlbOyOy1s1uaXwSxV9WfmmW9EcFQzXHKhelgBkL/3x+t
 NNG9WBDRykLgxgXg6yYIsuEQxq3MpZc/evvYf4AZg4rE8gQBi5OAZhIRiYjw5wZk1nkxCaYbPnb
 sOTD4wnfbr/8eU3+7j1eh2ILhrxb89QZ/pmc0Z9YufHWDisxpgufVm6bFd148jdfrEJPetSEvSU
 f3jACAA==
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv

From: Igor Velkov <iav@iav.lv>

When the build forces colored diagnostics, e.g. with
KCFLAGS=-fdiagnostics-color=always, the compiler wraps the expected
error in ANSI escape sequences and the grep does not match it. Every
test then reports "lacked '__write_overflow' warning" although FORTIFY
caught the overflow, and a real FORTIFY regression looks the same.

  warning: unsafe strcpy() usage lacked '__write_overflow' warning in lib/test_fortify/write_overflow-strcpy.c

Pass -fdiagnostics-color=never after the caller's flags so that the
test compile always emits plain text.

Fixes: be58f7103700 ("fortify: Add compile-time FORTIFY_SOURCE tests")
Assisted-by: LLM
Signed-off-by: Igor Velkov <iav@iav.lv>
---
Found in Armbian kernel builds, which pass -fdiagnostics-color=always
in KCFLAGS: all 18 tests reported "lacked".

Tested on arm64, 7.2.y, KCFLAGS=-fdiagnostics-color=always,
building lib/test_fortify/ (tests ok out of 18):

                 before   after   after, -D__NO_FORTIFY
  GCC 14.2          0       18        0
  clang 19.1.7      0       18        0

An LLM assistant found the cause, wrote the fix and the changelog,
and ran the tests; I reviewed all of it.
---
 lib/test_fortify/test_fortify.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/test_fortify/test_fortify.sh b/lib/test_fortify/test_fortify.sh
index ad6dd44fa31c..c07eb3302c9d 100644
--- a/lib/test_fortify/test_fortify.sh
+++ b/lib/test_fortify/test_fortify.sh
@@ -37,7 +37,8 @@ export LANG=C
 
 status=
 # Attempt to build a source that is expected to fail with a specific warning.
-if "$@" -Werror -c "$IN" -o "$OUT".o 2> "$TMP" ; then
+# Disable colors so that the grep below can match the warning.
+if "$@" -Werror -fdiagnostics-color=never -c "$IN" -o "$OUT".o 2> "$TMP" ; then
 	# If the build succeeds, either the test has failed or the
 	# warning may only happen at link time (Clang). In that case,
 	# make sure the expected symbol is unresolved in the symbol list.

---
base-commit: 760f96b7f54beb8dc6f85d97ac7854fddba86835
change-id: 20260924-fortify-test-color-f34a31b56bcc

Best regards,
-- 
Igor Velkov <iav@iav.lv>


