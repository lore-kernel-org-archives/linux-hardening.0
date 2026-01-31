Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE8E357A57;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=RAItewXA07fmNdzE8s9NN7wtHLhhE+gtb1G/TH/nFluhzccuzrc6wR4FZNhM77dZ04oViKzOqfnOedJeyu5o2Sm0kYt/8k2rlHGPsLBUbe1H5vSoJbui6unojE8PsBFmT0x+M2FyH5AOctrk7Ts8Hohd2t+l+48WghIRRimw6f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=enNjosNVgnaAAD5QxgjX5hIH+/xBNCW9H6F1I/JJjkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ad209YuqawAYXorB9+kdVbExIgSgMCpJ/4QqoXo8l2p+psaaOaaxposy3adWlZh38eEZU/VBndxQrAcIsmYU0wi8M/eL0R+YlU1uCuHauLuaoIKneZFNg9guLaDX+WB7/1BysODKeftW2yLbNAc7IbNpS3PviYGkX+erPC2s9bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPGW8Q5W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPGW8Q5W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8792AC2BCC7;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869521;
	bh=enNjosNVgnaAAD5QxgjX5hIH+/xBNCW9H6F1I/JJjkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SPGW8Q5Wj/Kpohrb03QakzQo7UlPpS/JZKe0yv4eUfMVholL6LBI4JI+/3DkpEb/B
	 yhVYJhmiivl2WHinw/H/5jh6QwlTYUhx1PBdDk8WxTZRAJ8FPv6PaBCk1CjSnfy1/g
	 wMmoUxVODTqrSv5fi25JceOe5ieQ0HkwkQtqUcObQK1W6qtwqkIh6vwsvW4tly96vl
	 OPtCN3p/zvLxPZDjVkt93mM5FpvkGlj6pKv33GSa3db10OsK05T+hGYO/6KIAZ5AaB
	 xT+4D99cf1PbK4Dkw/90DGEhtUDEOTjYsJT5tcThKXvocoKJPEmy3+k+Nio52kUDIX
	 gGzdwWOhgCsdA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBuZ-0000000AVke-2uFV;
	Sat, 31 Jan 2026 15:25:19 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v4 14/41] docs: kdoc_parser: handle struct member macro VIRTIO_DECLARE_FEATURES(name)
Date: Sat, 31 Jan 2026 15:24:48 +0100
Message-ID: <a4855f2e1945c7faf41a7ddf63c55da453fae3d6.1769867953.git.mchehab+huawei@kernel.org>
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
index 33710c4be145..db140363104a 100644
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

