Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AEC425CEE;
	Mon,  2 Mar 2026 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469671; cv=none; b=sRCFyU04rXtW/OFRxBUArnZ0I6u0SwqeiYWrccbOuojzbNfd1cFLyWqxKGz056QaZATvjtQ+wiUltYGzFdFuCUkzyj4JX7UQmKsW2GDwmIyO5tgU2wz7QMjcb/SySM2yt/tKV9SbdbIDEvLKExZ1ZgZUNsIIlEVIBjuQY5qtrAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469671; c=relaxed/simple;
	bh=61qjPlozwdHGFvs8c7DRWC7o3HB3XcjbiutDDyCkiOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lVVZgPi7Kb6LIc3d0SMFIVt6RPiCxuW1Aj283KOtFBVpCFhccWy8yZn3razTk2q+9smeuexLiscuzgohb/21mmPd7POMALLm0MB/m2Upo6zLTTZV3tR6GG5LcmiHcpZJoYEDBBpgspBfg+GTXfYHY6ah6GDJN37MCdvIbFzzS1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xye5RCmi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xye5RCmi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EB5C2BC9E;
	Mon,  2 Mar 2026 16:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772469670;
	bh=61qjPlozwdHGFvs8c7DRWC7o3HB3XcjbiutDDyCkiOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xye5RCmi5xwFqa2D1USh3659QwPyNjT0/WYBASKxeORUNAju7/Z1H4E2NG1M/Pmwy
	 Ek5+hnsLejOn9tSf7b+9oSjc8zvcOLH+//Jf4jqQuwhWh1F739hbeC23QabvbKRhz2
	 MP4Qpv0ED6wS+Rlp7XmxF2gsPheebuVGAq69fInn594/ThojYzeSBdUeWPYcuT2bjo
	 uB/1c40XN6yFivPNDbq97djllR6Ljx6xO81mEsOpLZoYSvIMabct3eZQ6Zu3IAK0Ml
	 YeopJQH8joLiSx3v4XPxNU1fTCSErt3VKwnGhv8WedtqJOyPGP6pDOIwXolup0J8MB
	 8La2xAcwDYjBQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vx6KS-0000000038M-2b0y;
	Mon, 02 Mar 2026 17:41:08 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 10/18] docs: kdoc_parser: handle struct member macro VIRTIO_DECLARE_FEATURES(name)
Date: Mon,  2 Mar 2026 17:40:53 +0100
Message-ID: <6f62e1f1210e74906fa50f4e937f66f54813661b.1772469446.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1772469446.git.mchehab+huawei@kernel.org>
References: <cover.1772469446.git.mchehab+huawei@kernel.org>
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
index 1df869061bf3..917e4528bfbf 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -150,6 +150,7 @@ struct_xforms = [
             struct_args_pattern + r'\)', re.S), r'\1 \2[]'),
     (KernRe(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + struct_args_pattern + r'\)', re.S), r'dma_addr_t \1'),
     (KernRe(r'DEFINE_DMA_UNMAP_LEN\s*\(' + struct_args_pattern + r'\)', re.S), r'__u32 \1'),
+    (KernRe(r'VIRTIO_DECLARE_FEATURES\(([\w_]+)\)'), r'union { u64 \1; u64 \1_array[VIRTIO_FEATURES_U64S]; }'),
 ]
 #
 # Regexes here are guaranteed to have the end delimiter matching
-- 
2.52.0

