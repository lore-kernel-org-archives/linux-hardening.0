Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA063C8730;
	Thu, 12 Mar 2026 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327302; cv=none; b=cq9O2oMgoI07adozXheMAqTTxvf/f9niENbLJ1tjGfMwvl1ET7Msh9Sc59Z44lWNIF9U+5eznJp8RGCj3iT6tVPlFaxT98COQoZtc1Nii+ZVaAIyNf16tp1oeM8r/LM1HlP+qKHzHwSY5HlSEqYGDJ4kI9PrfDX2rpzwicxEx4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327302; c=relaxed/simple;
	bh=5jZgXDuXy6s4D25aK3Qlqh5spqAcl7bX24uiv3sv3AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atvVAmy7MVtl4cviP+Kzs4VNit0Mtadk2lSjtGzQE2szQJ27n8ywXRbAxU1qJFVlJiy76koU29GHAfLqF/9X2Li2aG5bJXyR42OKN6rVZ5kC9Yg0JZfTQuwY7p8jBCkDlVzAu+branBQJgM+l7az7oBDUchrg1xTgiM4scATNWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uW8Mrep5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uW8Mrep5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EACC2BCAF;
	Thu, 12 Mar 2026 14:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773327302;
	bh=5jZgXDuXy6s4D25aK3Qlqh5spqAcl7bX24uiv3sv3AQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uW8Mrep5jOSuKY4Ye5LLQass9soXmaf/T4ofLd/Zf3V4025FADVDO6HOSOH409xZi
	 M4b0QDYXOe/p/o/vNGg54dKhjsvlN253qn4Q2ISdgfVnlsld7fOZY9bX7CykCki+YO
	 GHbtcBJ7Urqg0eChmX1XdyvALAqKAjIgtoycsHhgMsD5EHrQZGLhH00uA4cJcNpWSj
	 7CQ/2KsW3It5UHpuGQSJws51CzEdrse/e8zX0/JFy63Qsp6IsmybewozM50vIXhlBr
	 AxtHdQRXybKAzK/kpPEISw+Rrj5fAYKeZkyvkjcCA+hCahlPJzzaXgupfsObnGQbAZ
	 ZHK1MjFOMlKKA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0hRE-00000008yKL-3ZsI;
	Thu, 12 Mar 2026 15:55:00 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 28/28] unittests: test_cmatch: remove weird stuff from expected results
Date: Thu, 12 Mar 2026 15:54:48 +0100
Message-ID: <8e64a6492d379be01951f897682ae4dc4e03efcb.1773326442.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1773326442.git.mchehab+huawei@kernel.org>
References: <cover.1773326442.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Now that c_lex produces a cleaner output, change the expected
results for them to not have duplicated ";" or whitespaces just
before it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/unittests/test_cmatch.py | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/tools/unittests/test_cmatch.py b/tools/unittests/test_cmatch.py
index 3fbc5d3bc244..7b996f83784d 100755
--- a/tools/unittests/test_cmatch.py
+++ b/tools/unittests/test_cmatch.py
@@ -416,7 +416,6 @@ class TestSubWithLocalXforms(TestCaseDiff):
             struct tx_pkt_info {
                     struct tx_sop_header sop;
                     struct tx_segment_header seg;
-                    ;
                     struct tx_eop_header eop;
                     u16 pkt_len;
                     u16 seq_num;
@@ -490,7 +489,6 @@ class TestSubWithLocalXforms(TestCaseDiff):
                 __le64 LastWriteTime;
                 __le64 ChangeTime;
                 __le32 FileAttributes;
-                ;
                 __le64 AllocationSize;
                 __le64 EndOfFile;
                 __le16 FileType;
@@ -504,7 +502,6 @@ class TestSubWithLocalXforms(TestCaseDiff):
             __le64 LastWriteTime;
             __le64 ChangeTime;
             __le32 Attributes;
-            ;
             __u32 Pad1;
             __le64 AllocationSize;
             __le64 EndOfFile;
@@ -543,7 +540,6 @@ class TestSubWithLocalXforms(TestCaseDiff):
                 __le16 num_entries;
                 __le16 supported_feats;
                 __u8 reserved[4];
-                ;
                 struct cxl_feat_entry ents[];
             };
         """
@@ -605,23 +601,23 @@ class TestSubWithLocalXforms(TestCaseDiff):
             struct cxl_component_regs {
                 void __iomem *hdm_decoder;
                 void __iomem *ras;
-            } component;;
+            } component;
 
             struct cxl_device_regs {
                 void __iomem *status, *mbox, *memdev;
-            } device_regs;;
+            } device_regs;
 
             struct cxl_pmu_regs {
                 void __iomem *pmu;
-            } pmu_regs;;
+            } pmu_regs;
 
             struct cxl_rch_regs {
                 void __iomem *dport_aer;
-            } rch_regs;;
+            } rch_regs;
 
             struct cxl_rcd_regs {
                 void __iomem *rcd_pcie_cap;
-            } rcd_regs;;
+            } rcd_regs;
         };
         """
 
@@ -667,7 +663,7 @@ class TestSubWithLocalXforms(TestCaseDiff):
                     struct net_device *netdev;
                     unsigned int queue_idx;
                     unsigned int    flags;
-                } slow;;
+                } slow;
                 struct page_pool_params_fast {
                     unsigned int order;
                     unsigned int    pool_size;
@@ -677,7 +673,7 @@ class TestSubWithLocalXforms(TestCaseDiff):
                     enum dma_data_direction dma_dir;
                     unsigned int    max_len;
                     unsigned int    offset;
-                } fast;;
+                } fast;
             };
         """
 
-- 
2.52.0

