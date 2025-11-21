Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63991E8329
	for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763749480; cv=none; b=aG38ybFgn46rdlyOstkrMEvoZNnG2gt9gEjvkv+5g0vYhBKDtFum8y0MTouJZ2gefGQRdrn8RCXPzqlC/f9elEX3rbVKuj7Ff4nVZi+q2iAIxtqTEfeJz7owsSIVv4cHT+9HnPrpp7CaEwxefIdGxWhZJoGZjB9Lp9RWUVZmpz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763749480; c=relaxed/simple;
	bh=2upa+ctLnc3rpyS8wLGwnlhdWhP183+gUZedT47iZZk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OXnIQoY3k6uPhD+BC81jsb9ACuBfyHcyCJBD9Ml1YkYaivEQ0JQSmeJuXTSrQmLC39jryDBCClqBGygkiWM1j1r5YLSVuNiuZrgYHDRATe/k0uJvYW3I1U/hUPsTEX05XjH5XYvosvAt84FxHblGlTaf6euuB+N+acTwaimNuhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rw+EgwOX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rw+EgwOX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CFBC4CEF1;
	Fri, 21 Nov 2025 18:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763749479;
	bh=2upa+ctLnc3rpyS8wLGwnlhdWhP183+gUZedT47iZZk=;
	h=From:To:Cc:Subject:Date:From;
	b=rw+EgwOXLOIXXgGJzabNBRkVeI8T+EDTG7wCVaxXtx0wOVbbRTdam3HLZgWkj2aFN
	 OlWUVfd63MPtLVzpCvdBRrA2TmWqsvjbIsqBrTzCE6FVzWNnBCQ3UKtIWMKijSy9Vi
	 VUK9jS0zh/AlqbuzMxfMnJESFgjNIly+qxG0ervSYGr3I/NYPr4Az4fbJI0RupT6oC
	 NcfFxUGFP5ugbSkdB95HuiEX2dP9jWIlWKoAbAoBPbKS9g1AKDT+KcrynU/OlSSMDp
	 dpP/91OdqNJfWemZ0b3PNDpkzaPL/NOcmaOrPXKpiRQmLyLrs7A+2Szf7SQXARxv2m
	 ApiJmfFee0z9A==
From: Kees Cook <kees@kernel.org>
To: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Kees Cook <kees@kernel.org>,
	Qing Zhao <qing.zhao@oracle.com>,
	gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] aarch64: Extract aarch64_indirect_branch_asm for sibcall codegen
Date: Fri, 21 Nov 2025 10:24:34 -0800
Message-Id: <20251121182426.work.116-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3258; i=kees@kernel.org; h=from:subject:message-id; bh=2upa+ctLnc3rpyS8wLGwnlhdWhP183+gUZedT47iZZk=; b=owGbwMvMwCVmps19z/KJym7G02pJDJkK6xKDil/+16i9sfZA0/K1BVsZXBIUOH0mL767LV7pu knE1PJXHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABNZ/4iRYffNPr8XybOqkpgf v/q5h6drQYZh87VPJvXrvrsFXBNmKmZk2DtdYtsi8+L4qf7yJf/On1s2NeTC9bbcmeJ3G9y+n9l uyw0A
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Extract indirect branch assembly generation into a new function
aarch64_indirect_branch_asm, paralleling the existing
aarch64_indirect_call_asm function.  Replace the open-coded versions in
the sibcall patterns (*sibcall_insn and *sibcall_value_insn) so there
is a common helper for indirect branches where things like SLS mitigation
need to be handled.

gcc/ChangeLog:

	* config/aarch64/aarch64-protos.h (aarch64_indirect_branch_asm):
	Declare.
	* config/aarch64/aarch64.cc (aarch64_indirect_branch_asm): New
	function to generate indirect branch with SLS barrier.
	* config/aarch64/aarch64.md (*sibcall_insn): Use
	aarch64_indirect_branch_asm.
	(*sibcall_value_insn): Likewise.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/config/aarch64/aarch64-protos.h |  1 +
 gcc/config/aarch64/aarch64.md       | 10 ++--------
 gcc/config/aarch64/aarch64.cc       | 12 ++++++++++++
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/gcc/config/aarch64/aarch64-protos.h b/gcc/config/aarch64/aarch64-protos.h
index a9e407ba340e..50623c3bed2e 100644
--- a/gcc/config/aarch64/aarch64-protos.h
+++ b/gcc/config/aarch64/aarch64-protos.h
@@ -1272,6 +1272,7 @@ tree aarch64_resolve_overloaded_builtin_general (location_t, tree, void *);
 
 const char *aarch64_sls_barrier (int);
 const char *aarch64_indirect_call_asm (rtx);
+const char *aarch64_indirect_branch_asm (rtx);
 extern bool aarch64_harden_sls_retbr_p (void);
 extern bool aarch64_harden_sls_blr_p (void);
 
diff --git a/gcc/config/aarch64/aarch64.md b/gcc/config/aarch64/aarch64.md
index 855df791bae7..de6b1d0ed06b 100644
--- a/gcc/config/aarch64/aarch64.md
+++ b/gcc/config/aarch64/aarch64.md
@@ -1581,10 +1581,7 @@
   "SIBLING_CALL_P (insn)"
   {
     if (which_alternative == 0)
-      {
-	output_asm_insn ("br\\t%0", operands);
-	return aarch64_sls_barrier (aarch64_harden_sls_retbr_p ());
-      }
+      return aarch64_indirect_branch_asm (operands[0]);
     return "b\\t%c0";
   }
   [(set_attr "type" "branch, branch")
@@ -1601,10 +1598,7 @@
   "SIBLING_CALL_P (insn)"
   {
     if (which_alternative == 0)
-      {
-	output_asm_insn ("br\\t%1", operands);
-	return aarch64_sls_barrier (aarch64_harden_sls_retbr_p ());
-      }
+      return aarch64_indirect_branch_asm (operands[1]);
     return "b\\t%c1";
   }
   [(set_attr "type" "branch, branch")
diff --git a/gcc/config/aarch64/aarch64.cc b/gcc/config/aarch64/aarch64.cc
index 6dfdaa4fb9b0..89097e237728 100644
--- a/gcc/config/aarch64/aarch64.cc
+++ b/gcc/config/aarch64/aarch64.cc
@@ -30822,6 +30822,18 @@ aarch64_indirect_call_asm (rtx addr)
   return "";
 }
 
+/* Generate assembly for AArch64 indirect branch instruction.  ADDR is the
+   target address register.  Returns any additional barrier instructions
+   needed for SLS (Straight Line Speculation) mitigation.  */
+
+const char *
+aarch64_indirect_branch_asm (rtx addr)
+{
+  gcc_assert (REG_P (addr));
+  output_asm_insn ("br\t%0", &addr);
+  return aarch64_sls_barrier (aarch64_harden_sls_retbr_p ());
+}
+
 /* Emit the assembly instruction to load the thread pointer into DEST.
    Select between different tpidr_elN registers depending on -mtp= setting.  */
 
-- 
2.34.1

