Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A93E423A6A;
	Mon,  2 Mar 2026 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469670; cv=none; b=uGXPr6byl+IdkdshHijQlvq1H06cbspzzuNadVqF0PLuRu94TWP80L+Vm8JUQ6x6JmDi2gtk/q+bnuQ8r4GIVSjrZ4XZ6/2c12yM0SLZjCBM6Up7qDwdTnVqYvtPlDHNIllZ9LHHqJ+xbd+vNJ5mVJonzPBbvjf/XYV2Utce9bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469670; c=relaxed/simple;
	bh=E99JX2x2bb+0GoK4fzDy1ZhSDI4u616jwvyzl9pv/wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kd58kSJkOcvT637HVHmydBk7bt0MPP9wk2kUdDBEr7exq94yEHWZsbFJCXhweTrROBRBRrEVFSKt+MNWVY2EPt4Dn5qw4U0qzacn4Q0H/Pjy1QprXoQV/lIE8iNceQG4Y/PZ4Ur36i39UvzZPRtTTCmHJAmED0GYXWueuKpDBM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hl47MmHh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hl47MmHh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FA3C2BCAF;
	Mon,  2 Mar 2026 16:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772469670;
	bh=E99JX2x2bb+0GoK4fzDy1ZhSDI4u616jwvyzl9pv/wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hl47MmHh1IluAWUgODvHXYuFVBjWPtk2Sz9KTXqrUqF/shtXoF042UIJIS/NnTSPN
	 MmLmEZMkCG6qJvA5ug0NDNpYXhb30c8mv61y/KH/hoh5XrdleHMqv9w6sn7JO/Z2Y1
	 /dxEt+c8lXkFGH/vS7o9nLDD8+b82gDmjW5J5z3bvUPdGiuhl344fNLmeYJBWnjw6R
	 VtDDtd1FzKdF0IJtsNTyHGbsn0iViD+jnbcDsXM+/FHs8jZXuWH/xsElidDHVW3Bh2
	 8wiNhrMwoY3SBmDKOI8vH+47IFRnsQXUksAvm5lw9mKNm5Tfl+w82aweRAWh0CLTrg
	 NeH+o96MI+wNg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vx6KS-0000000035v-0yqk;
	Mon, 02 Mar 2026 17:41:08 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 08/18] docs: kdoc_parser: fix parser to support multi-word types
Date: Mon,  2 Mar 2026 17:40:51 +0100
Message-ID: <544c73a9e670b6fef1828bf4f2ba0de7d29d8675.1772469446.git.mchehab+huawei@kernel.org>
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

The regular expression currently expects a single word for the
type, but it may be something like  "struct foo".

Add support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 39ff27d421eb..22a820d33dc8 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -1018,14 +1018,14 @@ class KernelDoc:
 
         default_val = None
 
-        r= KernRe(OPTIONAL_VAR_ATTR + r"[\w_]*\s+(?:\*+)?([\w_]+)\s*[\d\]\[]*\s*(=.*)?")
+        r= KernRe(OPTIONAL_VAR_ATTR + r"\s*[\w_\s]*\s+(?:\*+)?([\w_]+)\s*[\d\]\[]*\s*(=.*)?")
         if r.match(proto):
             if not declaration_name:
                 declaration_name = r.group(1)
 
             default_val = r.group(2)
         else:
-            r= KernRe(OPTIONAL_VAR_ATTR + r"(?:[\w_]*)?\s+(?:\*+)?(?:[\w_]+)\s*[\d\]\[]*\s*(=.*)?")
+            r= KernRe(OPTIONAL_VAR_ATTR + r"(?:[\w_\s]*)?\s+(?:\*+)?(?:[\w_]+)\s*[\d\]\[]*\s*(=.*)?")
 
             if r.match(proto):
                 default_val = r.group(1)
-- 
2.52.0

