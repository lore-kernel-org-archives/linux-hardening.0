Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B18134A3D2;
	Wed, 18 Feb 2026 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409606; cv=none; b=Xk4MlWFHRBDbYb2dMvv+TuwBOSEtRn7F3iZXhakxSoq1X4WLK5eJoKqg1MSzoCL+2E5ig2vexcJylyVeGXpWm7lf7MnkURS1F7qg/sDagLBKWzBzIHGwaHHasTu8Bk2vgRlgTsRynH3Pn4E5GZVRvegJ7Gf243fV7v05WKcRz7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409606; c=relaxed/simple;
	bh=HfA9d8T9A4lV+0318XofpC8IU2OubqTIaLYGnkL8N/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KAoVCulRwTZUuidiDfuOOrXce27P+m2Ixm4AejmES0ejvcBKfmV1Y2GEodvwwiGvXDNyis+K1EaEfPXQyD4HOUCza6oyfdRMqyYiaVjevESVNMcOqc59PXbsxBdQ8ac1lnPGnl7TLdUfUEgjRiGSuc9ZEreCGU6qWyWSvdwPeio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppwqRnrj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppwqRnrj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC54C19421;
	Wed, 18 Feb 2026 10:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409606;
	bh=HfA9d8T9A4lV+0318XofpC8IU2OubqTIaLYGnkL8N/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ppwqRnrjYO15gyib+5lOd1ODAKoyy3cbzAvuXAwJPFrtNqICxs3RAC8jYSWdmmMdZ
	 ql7Usz87PIjZt1BVES3WLc1Jj4pNfTEZLv8XV5SqztnYc1eHRTBn4hx2uB4NEoXCdg
	 BAl0ju2sz5gzWXVg6z9PQRha+zgKsZDZ6sAQG6u9Ey+DiUc4x8kzFfKnqpsBmK34Uc
	 7Boeesp9dD3r8quVIBzIUTC08TavKn/9m0lzBTcLixRwha1kN2HTwjcbroCcCJWJg8
	 ZNDQWYA2OvsPR++OMK/uvlCU2VWvEb5VNKhUXqp6CFfZSgDFp2yG43H10+9pxnrtx6
	 8+c6fmRkMdKNQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYe-00000000Lkk-2R7d;
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
Subject: [PATCH 22/38] docs: kdoc_re: fix a parse bug on struct page_pool_params
Date: Wed, 18 Feb 2026 11:12:52 +0100
Message-ID: <db9a6339a339b203a474acc2ee9f56da1227a186.1771408406.git.mchehab+huawei@kernel.org>
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

The struct page_pool_params definition has a private
definition on it:

    struct page_pool_params {
	struct_group_tagged(page_pool_params_fast, fast,
		unsigned int	order;
		unsigned int	pool_size;
		int		nid;
		struct device	*dev;
		struct napi_struct *napi;
		enum dma_data_direction dma_dir;
		unsigned int	max_len;
		unsigned int	offset;
	);
	struct_group_tagged(page_pool_params_slow, slow,
		struct net_device *netdev;
		unsigned int queue_idx;
		unsigned int	flags;
    /* private: used by test code only */
		void (*init_callback)(netmem_ref netmem, void *arg);
		void *init_arg;
	);
   };

This makes kernel-doc parser to miss the end parenthesis of
the second struct_group_tagged, causing documentation issues.

Address it by ensuring that, if are there anything at the stack,
it will be placed as the last part of the argument.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_re.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 05f36d665b70..cdc842f5fc8f 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -201,6 +201,9 @@ class NestedMatch:
         """
 
         stack = []
+        start = 0
+        offset = 0
+        pos = 0
 
         for match_re in self.regex.finditer(line):
             start = match_re.start()
@@ -250,6 +253,11 @@ class NestedMatch:
                         yield start, offset, pos + 1
                         break
 
+        # When /* private */ is used, it may end the end delimiterq
+        if stack:
+            stack.pop()
+            yield start, offset, len(line) + 1
+
     def search(self, line):
         """
         This is similar to re.search:
-- 
2.52.0

