Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C96349AE3;
	Wed, 18 Feb 2026 10:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409606; cv=none; b=aVhUDYBt2EsHHXlmzO3OYTXHKHQQ/TlL4xqEd1AOpCiuQ9H69neW7VtoIPlC7GLDf7LJUwJNYOXhv4cXE8M1kIAk4P8bn84pz09xPrLxWHKSyC842864eK2bTLP3EtJfwkZdj4p4KRNyzCrOohu+iKfilYRkNfRI72ntN+rTmzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409606; c=relaxed/simple;
	bh=pTv8fyARiYUzN0SDULk8va6HhWxLlLCbC3eYwm4RiCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVMgNnAUb2+Ct5Py6St9V4t+Ds6Y0yzCg5JjvClDjjXkXfctogqoZESU3BPO+NKWqX6OCkgLVvA44UI+wSHI+mn8w5gQAHZ0pvLkL+L7eXSb11iOpZaA+ynJQ8+2IdoTHBB2P2kECwx4/0fPq0G83iCEf1g2Pi56btFZN/7f4lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3ChlR4b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3ChlR4b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A9AC19421;
	Wed, 18 Feb 2026 10:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409605;
	bh=pTv8fyARiYUzN0SDULk8va6HhWxLlLCbC3eYwm4RiCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P3ChlR4bTE9lXd1SFNrL/stGx3aof4/2iZ+R4z2npTsJJzrL0y7iSZcs0aHf69M7Y
	 YpCuS5UxLto9x8LI8zDheQxYMNMKWMBNpFxFfsaWt3S3rZXT32cXhmWFFfwQrXBnsU
	 GP9d9Yv6BEakf0VD86lH4RNMBJVm8dphzPXA8UFwK10Dv5t0S/PRpA7JZEElgvHNlA
	 sm1RyZwr3P/r4ntFzHfvJ3MSo3EbhNS/2fkf5EdJjwx/gAVfVisFqk2S0sYBXk5xYv
	 ZL0xw8/GQuqQjXrjcIwF7GsUm3MiycxfP60XQYz+KcQzPLI3g+DsGjocPJzg6+N7P+
	 m9x6Zhlxw5l6w==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYe-00000000LjY-0ayj;
	Wed, 18 Feb 2026 11:13:24 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 21/38] docs: kdoc_parser: better handle struct_group macros
Date: Wed, 18 Feb 2026 11:12:51 +0100
Message-ID: <0f5400a1573288f9e0d48c34954ac9e769f83aa3.1771408406.git.mchehab+huawei@kernel.org>
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

Instead of converting them on two steps, implement a single
logic to parse them using the new sub functionality of
NestedMatch.sub().

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 06a7af4bfa57..b63a70f184eb 100644
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

