Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210D133D4FB;
	Wed, 18 Feb 2026 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409600; cv=none; b=JRuk53Y1bH4LvZ1lbGffOXbgWcFr2rqB0frk0ZNXqamVaqHkOqqqTKFYLUluGCBqn/CHP7jWSsvVuTo6XrcdJGsgqD3GZGg1rHsL92JYhtyYdMUSX602p84GK3OdIMLuUPd20rAmSRAopl7Tgj4PouC3WKQ6fOGvXXNHSXHFeII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409600; c=relaxed/simple;
	bh=gILK/WypmailkjOfO9MipodpPshzxrKnFuiIkYKk/rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhW+41qbncUoxh0ACj3PtQtpW89A8QXjEXYz1tO0yKAyyrThJHfKoUruPTpVPYmprNBUojPt1pk+CPtHh0MXg0wZ3LSGP+NsCK4GwRb57cGFgYbdHEv23Ve2kPxXkc5Ny09LPwjpzj5fy0sRH15qfouZX5R77FfZup1CBANN8Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atAHd30A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atAHd30A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDD6C2BCAF;
	Wed, 18 Feb 2026 10:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409599;
	bh=gILK/WypmailkjOfO9MipodpPshzxrKnFuiIkYKk/rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=atAHd30ARTdvjh4o3OVEzdOoIfFmyPuQl5F5OjvxUz7NvPU24vgIa+IlnzJOMVn6r
	 fotDv+alUGSOBwHcC8udpOj+pOXyyM7WKw19uboimQ9EQbMIOmJVrQqgf9WgJY4wZV
	 XznuWSt+WhdIWUS2nnxrP978dshViXzVxf+pFp0r2q+tsnivxULuB12vcMFeVgOrvy
	 xy7u2dmECOnxTDZaJR0gqDb2r4pif62jhxJ/adVJvdkU/sA64d6voHGcpGwKvOvKHJ
	 dmLEOhP2LijmlXfG9jflrvQPiJIf2zc4iLdv5DNz08RI9499NXKHCEQKRS61zqltxg
	 M7743dL15HR0w==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYY-00000000LQu-0Rrg;
	Wed, 18 Feb 2026 11:13:18 +0100
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
Subject: [PATCH 06/38] docs: kdoc_parser: use NestedMatch to handle __attribute__ on functions
Date: Wed, 18 Feb 2026 11:12:36 +0100
Message-ID: <1c9b6a151f41f1a6be5f503bd25e262f18baba10.1771408406.git.mchehab+huawei@kernel.org>
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

Some annotations macros may have nested parenthesis, causing normal
regex parsing to fail. The __attribute__ regex is currently very
complex to try to avoid that, but it doesn't catch all cases.

Ensure that the parenthesis will be properly handled by using
the NestedMatch() logic.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index af0ab732048b..b704755d2f0a 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -165,6 +165,7 @@ struct_nested_prefixes = [
 # the start delimiter.
 #
 function_nested_prefixes = [
+    (re.compile(r"__attribute__\s*\("), ""),
 ]
 
 #
@@ -196,7 +197,6 @@ function_xforms = [
     (KernRe(r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +"), ""),
     (KernRe(r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)"), r"\1, \2"),
     (KernRe(r"__attribute_const__ +"), ""),
-    (KernRe(r"__attribute__\s*\(\((?:[\w\s]+(?:\([^)]*\))?\s*,?)+\)\)\s+"), ""),
 ]
 
 #
-- 
2.52.0

