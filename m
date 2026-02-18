Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07BA344D86;
	Wed, 18 Feb 2026 10:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409602; cv=none; b=tFuOi0D5M+cuqzMS7wZCuEsWm98Enb7tV6/pDZCcTnoZL4sJiEnvRibErbakBX9/h8XBexTo1Iot7FazfrUX0HauGi5M+2ZnjrZjZzp53iDV0jXx5jXLdYgT+ywd/EM2SOAc2RoZxfMgNR/8ADjE+Yd8zyHZpabOXzq7XXgSJxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409602; c=relaxed/simple;
	bh=ANXFSo26ZIet9VFxR9KfWGVyYc/Hjaq5uByQoaJKpUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=katqYRDwgRBY+IySj+/N8xDaB6e+fnFycwmNqrlYu5EszcSabCRq17KyuZeqsJKgSDtea3wd9evER7gPG6DuHm+u7DqCl8/XJ/ukEIQeHCka5Xh+g17BsFtvjVhOPVjNyhcyy94DbRKf1WOOs287afaiv2tYz6a84WHXfDn3AdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRoqqIpO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRoqqIpO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B42C19425;
	Wed, 18 Feb 2026 10:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409602;
	bh=ANXFSo26ZIet9VFxR9KfWGVyYc/Hjaq5uByQoaJKpUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GRoqqIpOh8KBAHdnmBPXjVRd1w+0ZswrOmO5iM3eQgbXb+mSGS7P4eoaqrstOeSJD
	 kKyRiy8IA+Hr/ga9e79w+L7i7s33ndwthBktovkttS5y8DBBTlH3S8+VOJofTWU/c9
	 YQjZW4rPCEnbFi/QQduZObO6hYl4j4aHEBYT0tBJaReBlDtHPPecLl4pHYnb8fpZLC
	 NrGN89fEUyL28wWgQUY2TMm06HUoWZVgq0h8sMRsYCyNGTH6sDQRAsFEsPKuQlbzT+
	 IECCDJohgVme3rhB49N/nz5j2gm5cDmwVlCEyL2yw+G3Ilt0SwLOZLdTvAagP3cy9G
	 n6xAbFVPcZnnQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYa-00000000LZf-3pcS;
	Wed, 18 Feb 2026 11:13:20 +0100
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
Subject: [PATCH 13/38] docs: kdoc_parser: add support for LIST_HEAD
Date: Wed, 18 Feb 2026 11:12:43 +0100
Message-ID: <fb829a86209dd902a2b537044a440b28517d7817.1771408406.git.mchehab+huawei@kernel.org>
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

Convert LIST_HEAD into struct list_head when handling its
prototype.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 25d8a89f32b2..6fe2fa032900 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -220,6 +220,7 @@ var_xforms = [
     (KernRe(r"__ro_after_init"), ""),
     (KernRe(r'\s*__guarded_by\s*\([^\)]*\)', re.S), ""),
     (KernRe(r'\s*__pt_guarded_by\s*\([^\)]*\)', re.S), ""),
+    (KernRe(r"LIST_HEAD\(([\w_]+)\)"), r"struct list_head \1"),
     (KernRe(r"(?://.*)$"), ""),
     (KernRe(r"(?:/\*.*\*/)"), ""),
     (KernRe(r";$"), ""),
-- 
2.52.0

