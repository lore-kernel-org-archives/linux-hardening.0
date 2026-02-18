Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3222343D7D;
	Wed, 18 Feb 2026 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409602; cv=none; b=Dc/hjhZ5qC99clzblhQoz1iukGZVPyHj0VaKdbh8HqMyL00x4LJ3mBvtMGgaKbQTeF+dsHuj+Cwx1fxhPc+pVtrztwkF79vb4GMIOW7ossIl6+Jcdkmndh34Gc/AEJ0b+6dFoSMFbnYyeJgPWsjfEffgkgusTpQdQfU9UW5KJ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409602; c=relaxed/simple;
	bh=4ie062/uAY7NEPbx8HftQesMKv4XY2PkHG2S9mIU+Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+6SEEtG5kCUmo5qwRzYMWyMecpZmHQMiXwOVD12EaJnkH9ERzhHNK58F6nqmSvBez4xwBu8WtfOuluSykYEw1mgZdrxcz8apiFFu6SCVvD5F7Bf9KGho4z4r66npt++QK+zh/6rS2cstWKFzn7PbCuhXleyFJBQF7iSqf074mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZBY/1Fa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZBY/1Fa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF90C2BCB7;
	Wed, 18 Feb 2026 10:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409601;
	bh=4ie062/uAY7NEPbx8HftQesMKv4XY2PkHG2S9mIU+Tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZBY/1FaTnkXJUmGtrYofH1jQEkrmiDH3KpK/oMOiX4Il8R4zcJIniD3IhdIE89iD
	 TU2dKrLM62QIp5pdYkTIq/mStnBg5nB+o6jSOfZpo78kXbwZZwAtbOOZrg3j2N1J85
	 k/354c4U3twO9yQeUdzuck7fSvOQlLJAbgymluH+vMuv5/fmRVQcXgC2CXUyH97UwX
	 UsFyVRua0vtH7FN2nUSVuFpuM0sC9RAEY/m6qMd30gQRsDhJyhj4hG0mh6XNBMdZrG
	 xB78oUuxqKOy4l/DKj4Srg8JPVJO+iSpfdWM8mY1XpTPvoOnloKFmKktwGWIxp5WSi
	 LGtOUSyPF6MVA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYa-00000000LXG-0D7i;
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
Subject: [PATCH 11/38] docs: kdoc_parser: fix parser to support multi-word types
Date: Wed, 18 Feb 2026 11:12:41 +0100
Message-ID: <35ed0e29955ab12d67e22d451d03c7cf0a3530c3.1771408406.git.mchehab+huawei@kernel.org>
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
index d8e96c6c4ebc..f524385543a6 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -1027,7 +1027,7 @@ class KernelDoc:
 
         default_val = None
 
-        r= KernRe(OPTIONAL_VAR_ATTR + r"[\w_]*\s+(?:\*+)?([\w_]+)\s*[\d\]\[]*\s*(=.*)?")
+        r= KernRe(OPTIONAL_VAR_ATTR + r"\s*[\w_\s]*\s+(?:\*+)?([\w_]+)\s*[\d\]\[]*\s*(=.*)?")
         if r.match(proto):
             if not declaration_name:
                 declaration_name = r.group(1)
@@ -1038,7 +1038,7 @@ class KernelDoc:
                                   r.groups(), proto)
 
         else:
-            r= KernRe(OPTIONAL_VAR_ATTR + r"(?:[\w_]*)?\s+(?:\*+)?(?:[\w_]+)\s*[\d\]\[]*\s*(=.*)?")
+            r= KernRe(OPTIONAL_VAR_ATTR + r"(?:[\w_\s]*)?\s+(?:\*+)?(?:[\w_]+)\s*[\d\]\[]*\s*(=.*)?")
 
             if r.match(proto):
                 default_val = r.group(1)
-- 
2.52.0

