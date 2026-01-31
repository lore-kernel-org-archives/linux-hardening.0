Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436A53590A4;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=hdDRfeaZPq0X8lFmcM4pMNxB0KJsGx7OClfkl0TGkjPtvj2a+DUtxfClpo901/X6Jne0mKNV9tlRC9k9pVoDOHQdAkF0d0tRU410FLCu2ANHo6Hu/PHoYQX6QuK3HTVKaoJqOReoMbzVaqaTBlq4q0WY0V6bOy+auN4QxpQ07Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=yHTvoLbqPGgQzPgBOzeytRzZYEiySFBnO0ERiQ2SquU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nvvtcUAYp9W5LTC9FmeBrQwMTmpN09ZWxRejUwWShncSQYqfPXsPAqhKbQtcxpKlNCepumCHfLQKVjLF1BTVfvb7K72YHPAfIK+/dAK1nMGoyX0Ey14G6pbvHndxdOWwMu7wiK5IRVWYaMBiZI7BASHH7RpdDwYx/u0mfN5V0to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ih6ncNpr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ih6ncNpr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E79C2BCFF;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869521;
	bh=yHTvoLbqPGgQzPgBOzeytRzZYEiySFBnO0ERiQ2SquU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ih6ncNprGLq//Yqu8qYVTYKtlrKIjoBVXKfVLoguaydHod2z+8k7gZ6WyA/N99XnD
	 aVmqJ1ksWogW5q1zJ91xrSLLDm8+9PFa7aAf5ibzhqslu1QAOCI58+mOTpypB3Tfhh
	 24l13tvvffnuD1TAOLXKEkN36JwdtG8XHPr/hbglzW0F4e1U8+yY0udtZ0IC+VO2/e
	 Mv1cgFZh8gH6ux25BlTIZJjc4wgHzRTvTe1G1uflypKUwYQj4RLxZvVulqDimJURbK
	 DhHUMw4HXQzQn3tlxcnDOdXyskwU27kvekbm8SddgOvCAzKSCTc0c3aszXzWrnv3P+
	 WjC4vo4U+ZG3g==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBuZ-0000000AVl6-3ii2;
	Sat, 31 Jan 2026 15:25:19 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v4 21/41] docs: kdoc_parser: better handle struct_group macros
Date: Sat, 31 Jan 2026 15:24:55 +0100
Message-ID: <5429d80aaf51f22a8b840f269ef2e0a2b55bca82.1769867953.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769867953.git.mchehab+huawei@kernel.org>
References: <cover.1769867953.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Instead of converting them on two steps, implement a single
logic to parse them using the new sub functionality of
NestedMatch.sub().

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 3a5614106af7..d2eb93f9d489 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -124,10 +124,11 @@ struct_xforms = [
     # matched. So, the implementation to drop STRUCT_GROUP() will be
     # handled in separate.
     #
-    (KernRe(r'\bstruct_group\s*\(([^,]*,)', re.S), r'STRUCT_GROUP('),
-    (KernRe(r'\bstruct_group_attr\s*\(([^,]*,){2}', re.S), r'STRUCT_GROUP('),
-    (KernRe(r'\bstruct_group_tagged\s*\(([^,]*),([^,]*),', re.S), r'struct \1 \2; STRUCT_GROUP('),
-    (KernRe(r'\b__struct_group\s*\(([^,]*,){3}', re.S), r'STRUCT_GROUP('),
+    (NestedMatch(r'\bstruct_group\s*\('), r'\2'),
+    (NestedMatch(r'\bstruct_group_attr\s*\('), r'\3'),
+    (NestedMatch(r'\bstruct_group_tagged\s*\('), r'struct \1 { \3 } \2;'),
+    (NestedMatch(r'\b__struct_group\s*\('), r'\4'),
+
     #
     # Replace macros
     #
@@ -153,7 +154,6 @@ struct_xforms = [
     (KernRe(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + struct_args_pattern + r'\)', re.S), r'dma_addr_t \1'),
     (KernRe(r'DEFINE_DMA_UNMAP_LEN\s*\(' + struct_args_pattern + r'\)', re.S), r'__u32 \1'),
     (KernRe(r'VIRTIO_DECLARE_FEATURES\(([\w_]+)\)'), r'union { u64 \1; u64 \1_array[VIRTIO_FEATURES_U64S]; }'),
-    (NestedMatch(r'\bSTRUCT_GROUP\('), r'\0'),
 ]
 
 #
-- 
2.52.0

