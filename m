Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCF9345758;
	Wed, 18 Feb 2026 10:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409603; cv=none; b=jdGtkcE/GQhpyCl8K7fLJzpPK/b95LCHW1gDY7JClOAutBYTWRpgTEunL2+bskS1CeJRhpkitpSjFaSlVfuvxjeuaE26tKQcr6AplZm0enRpNO5zTGHu0SSIE0laD0lxfdcfOV249gkLuAEEJakdqFcEdAPd1to29U8DGHOgwww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409603; c=relaxed/simple;
	bh=Z36YMV6EMn5rFyaqYGer/gsooo6w2VF9hIyZNnrWbgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohjxLU5QBJcoqmjTb9UeZ1mpYhwJotYSUep1fP3gwbkanGOdbjtUzy++Rtwy1z+hlUDvY153uV4vdAFxmNqkMFnzmwap5Jd3EaDlos+B5Dpm+jsHizeHsku+s7CBlizgULYYWNoMgt4txQPCTCxbJHhRVo9BdkNMnVXlgCGPi4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZ7ngsvQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZ7ngsvQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F518C19421;
	Wed, 18 Feb 2026 10:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409603;
	bh=Z36YMV6EMn5rFyaqYGer/gsooo6w2VF9hIyZNnrWbgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UZ7ngsvQWV+yF2K49kxsi+ciJK1WcKwWLhpRYok7EriWqUsYG1+ZzzpC98QV/LN3l
	 x1hg94t3i7+rNvR3dLhbArDLu2YMg6Cgz4wHjYx5dP8V0WxTHPZP8ZxxOLS9t+WgD+
	 IIL/0twb+1YWHTgo+zBwRvaDxbQ92NJA22djnbAntcGyyhFRJ5Sd61HvkRTxrrMNqw
	 4rjOQAdWYdQilTEDOk3Lg8PZk+Oz0dEsSm8vVUfAY+OOhu5/krsuTYIqyCIsFEddnB
	 Y99GPuDA43lOC6jikWdLaKoGWyHrIxSWs1EgSCCXQhcFxXbcTcE2mT7CdzZUy1Ieel
	 /lQQzVLhf79MA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYb-00000000Lar-0nUE;
	Wed, 18 Feb 2026 11:13:21 +0100
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
Subject: [PATCH 14/38] docs: kdoc_parser: handle struct member macro VIRTIO_DECLARE_FEATURES(name)
Date: Wed, 18 Feb 2026 11:12:44 +0100
Message-ID: <7b7809ce8ee561e6023a82288e3c429e9a1889d2.1771408406.git.mchehab+huawei@kernel.org>
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

From: Randy Dunlap <rdunlap@infradead.org>

Parse the macro VIRTIO_DECLARE_FEATURES(name) and expand it to its
definition. These prevents one build warning:

WARNING: include/linux/virtio.h:188 struct member 'VIRTIO_DECLARE_FEATURES(features' not described in 'virtio_device'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 6fe2fa032900..32a30851db08 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -152,6 +152,7 @@ struct_xforms = [
             struct_args_pattern + r'\)', re.S), r'\1 \2[]'),
     (KernRe(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + struct_args_pattern + r'\)', re.S), r'dma_addr_t \1'),
     (KernRe(r'DEFINE_DMA_UNMAP_LEN\s*\(' + struct_args_pattern + r'\)', re.S), r'__u32 \1'),
+    (KernRe(r'VIRTIO_DECLARE_FEATURES\(([\w_]+)\)'), r'union { u64 \1; u64 \1_array[VIRTIO_FEATURES_U64S]; }'),
 ]
 #
 # Struct regexes here are guaranteed to have the end delimiter matching
-- 
2.52.0

