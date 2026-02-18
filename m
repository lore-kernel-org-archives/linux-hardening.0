Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6319734F46D;
	Wed, 18 Feb 2026 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409610; cv=none; b=ktcE00HGcd1JZaEaM2RTFonhwSsQyA0geoPZmwa12MVReNKNIa0/sMKXYXsreUwPBpXJiX9NZSzI4K72qkT1kHUz2adwdn9ayu7n/j6VliuDO0ILRMPnmvxmv5A7Ukj1Zs6YN9v53ygOIKra+jY0ZK03QqeJm6mU0hK27lnA73s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409610; c=relaxed/simple;
	bh=3n5zkoFrFUOIWGD8NapCIbtnoFCw7B0BzF+EBvzaUy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g4jkdsAPPM+13QwcJAVCRBlz+Ay8ZVEYp26P1SxqSvOBwWW4kva7/rudoMo+Nwtk/CZdwb+UyQZNoQrV8Zhx/LnsMlCoTkBAkkhQdmeOOImvV8iudiYuYVJ7AtB8aZV/8fot6FGxzhm9k8vrJUN7d/p03p/Cc4yLabiInPGKZ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcOYv7LY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcOYv7LY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23843C19423;
	Wed, 18 Feb 2026 10:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409610;
	bh=3n5zkoFrFUOIWGD8NapCIbtnoFCw7B0BzF+EBvzaUy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tcOYv7LYcrZ5Lrw7m9IiFT46WDG8lvQC26H6JL+ld2BPUJ/cRpb+fn46o6dyjvT3z
	 fZ36++HlWV8B7DRuYo13mjduPE5fT8nnpO8Rv4MCt6ukJ39Dg+ah/qQ8tKt1Ool9pE
	 3hGfWgGufvONBSABEpw0bdqfPtL4E4y34ZLJMcjtnt7ZIKGQw92gavA/u+Xv+b6qng
	 r9OUi0xaTOnNYXzwOI5k5FLzmWbtUL8ZKzpCOco0nDN+Bj3li2TGD1gTX25P+1WSN8
	 G+BraAGRnfcSmOEanFQ64tv8eoq/NABA9KyFjwEh8fSy0vvBTNR5DKd4utoDLvLdjg
	 KXoPaETHcYK+Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYi-00000000Lux-1Xmg;
	Wed, 18 Feb 2026 11:13:28 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 30/38] docs: kdoc_files: allows the caller to use a different xforms class
Date: Wed, 18 Feb 2026 11:13:00 +0100
Message-ID: <f245479bfa8cd8dc2ad2041a87085dd2ace8c502.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

While the main goal for kernel-doc is to be used inside the Linux
Kernel, other open source projects could benefit for it. That's
currently the case of QEMU, which has a fork, mainly due to two
reasons:

  - they need an extra C function transform rule;
  - they handle the html output a little bit different.

Add an extra optional argument to make easier for the code to be
shared, as, with that, QEMU can just create a new derivated class
that will contain its specific rulesets, and just copy the
remaining kernel-doc files as-is.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_files.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_files.py b/tools/lib/python/kdoc/kdoc_files.py
index 7357c97a4b01..c35e033cf123 100644
--- a/tools/lib/python/kdoc/kdoc_files.py
+++ b/tools/lib/python/kdoc/kdoc_files.py
@@ -118,7 +118,7 @@ class KernelFiles():
         if fname in self.files:
             return
 
-        doc = KernelDoc(self.config, fname, CTransforms)
+        doc = KernelDoc(self.config, fname, self.xforms)
         export_table, entries = doc.parse_kdoc()
 
         self.export_table[fname] = export_table
@@ -154,7 +154,7 @@ class KernelFiles():
 
         self.error(f"Cannot find file {fname}")
 
-    def __init__(self, verbose=False, out_style=None,
+    def __init__(self, verbose=False, out_style=None, xforms=None,
                  werror=False, wreturn=False, wshort_desc=False,
                  wcontents_before_sections=False,
                  logger=None):
@@ -193,6 +193,11 @@ class KernelFiles():
         self.config.wshort_desc = wshort_desc
         self.config.wcontents_before_sections = wcontents_before_sections
 
+        if xforms:
+            self.xforms = xforms
+        else:
+            self.xforms = CTransforms()
+
         if not logger:
             self.config.log = logging.getLogger("kernel-doc")
         else:
-- 
2.52.0

