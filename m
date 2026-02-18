Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BEB33EB10;
	Wed, 18 Feb 2026 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409607; cv=none; b=rPTVrYLrAfNyKltEPRnuw0T1wELaLrSlvB/Q3x5+qlg97Dm09hNSSufiSHdwwGFX0SLCTAZdK4qmt9dWD3YzKpY5AGl7MEOC1eWvUWnwZEJPsM0ePdqO2m35V1uoVvcdeGcWGEwJ8wYiSsbavNrHj7VX5aBsw7cMpYFd81csMXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409607; c=relaxed/simple;
	bh=ClRhaNpIRp4d1LeCk51dHxLXX4FD+ZDnmDB3anBLh9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBAYISBltoNqc1HdZPIVMsnEpHkrI2A/ZkmJvp9GqvBN/Je6sMMvUgfksZ5FZSCSFe6D2sYJrDp4TWhbUKWqP28kRSqBgf+ni5DD1e/EQmTK85f7+Q9bOD4bogX3f+rZa5TvwDXRS7WzDe9CfuJQAyPDNMoeaW310ouxy5YOOSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4jW1HQE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4jW1HQE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACFAC19423;
	Wed, 18 Feb 2026 10:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409607;
	bh=ClRhaNpIRp4d1LeCk51dHxLXX4FD+ZDnmDB3anBLh9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E4jW1HQEiNJGt9nxlWI7HPbPRCzBmC2z4/0V+SKXwbQCMFGfYkQQdUPUjxfK1785C
	 8peGmSJYA1db+nfNkQZMKfH8b2Jx6r0pjKIdjcmerVlhmbqNBDlRsD2+rdABgs2eiR
	 dPC5cgWXdTKvgafq8jxD1ZeEdx0Xg6icPuDtdvyKN56CaKv0d/rOZIPUKwMZAPrOX5
	 ZsSIDLz68gsR3V/uCbF1dfdeYRAIWg9Kt1L5UnaW9MkDpZdowBgPVyvnbjpw7tRCzX
	 x24RT1AdesyHRv3ptd19n8jamK067eY76BDnbcadlv/NTBPSMYfPhO3lByB7I9VNp9
	 8CEgVb48qVKBg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYf-00000000Loe-3OFS;
	Wed, 18 Feb 2026 11:13:25 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 25/38] docs: kdoc_parser: minimize differences with struct_group_tagged
Date: Wed, 18 Feb 2026 11:12:55 +0100
Message-ID: <7b6f6ba86ebeab3d62735eb5b851631d042a361c.1771408406.git.mchehab+huawei@kernel.org>
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

While the previous version does a better job representing
the actual struct, it ends losing documentation from each
member.

Change the replacements to minimize such changes. With that,
the only differences before/after using NestedMatch new
replacement logic are (at man page output):

    --- before.log  2026-01-29 06:14:20.163592584 +0100
    +++ after.log   2026-01-29 06:32:04.811370234 +0100
    @@ -1573701 +1573701 @@
    -.BI "    struct ice_health_tx_hang_buf  tx_hang_buf;"
    +.BI "    struct ice_health_tx_hang_buf tx_hang_buf;"
    @@ -4156451 +4156451 @@
    -.BI "    struct libeth_fq_fp  fp;"
    +.BI "    struct libeth_fq_fp fp;"
    @@ -4164041 +4164041 @@
    -.BI "    struct libeth_xskfq_fp  fp;"
    +.BI "    struct libeth_xskfq_fp fp;"
    @@ -4269434 +4269434 @@
    -.BI "    struct page_pool_params_fast  fast;"
    +.BI "    struct page_pool_params_fast fast;"
    @@ -4269452 +4269452 @@
    -.BI "    struct page_pool_params_slow  slow;"
    +.BI "    struct page_pool_params_slow slow;"
    @@ -4269454 +4269454 @@
    -.BI "    STRUCT_GROUP( struct net_device *netdev;"
    +.BI "    struct net_device *netdev;"

e.g. basically whitespaces, plus a fix NestedMatch to
better handle /* private */ comments.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index e1914b2a6ab7..e735e79b5061 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -126,7 +126,7 @@ struct_xforms = [
     #
     (CFunction('struct_group'), r'\2'),
     (CFunction('struct_group_attr'), r'\3'),
-    (CFunction('struct_group_tagged'), r'struct \1 { \3 } \2;'),
+    (CFunction('struct_group_tagged'), r'struct \1 \2; \3'),
     (CFunction('__struct_group'), r'\4'),
 
     #
-- 
2.52.0

