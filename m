Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F81B35A943;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=Q0KMkjzR6Y8jcCpX5eZAQVyn+PC3ZapfgM+Ve1AwUsPYwc/kzB9peUNJdipqdZbbSeOcMBQ6f/9A83Yk2HVGTPNGa9QBiQ3T2XdEaEhGeu0GIMxLj5bW4Q+D45ea4F0o9VKLSRbiJDgNQfAXDrQKEQK/SR8rlgWM1x97RZi4OcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=3P9hiqMJWs99bANIe05s+PiDHBtg0dmIB/Ud7yaibWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2iwp69paW4KmyvXLRWGMlutfIO3mybUPny4S9P4QOHKzN3f7su0wHlfh6K4wyQYIVNpI98r+NOMtHcazC4/6OhpEUK20Ba521mOh1ZSpiGsMxILMoT6g91xPmqCIgZqGTWwyzXkrzHMVPQreqomKcmORhzS78sVISh72jZ8BSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWMvSLN2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWMvSLN2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BD9C4DDE8;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869522;
	bh=3P9hiqMJWs99bANIe05s+PiDHBtg0dmIB/Ud7yaibWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gWMvSLN2ujlPPfqzEcYYm3pAFHIatlR6wb6AcOiZ2qVO+R7A7nbl+sESP4AIpfstD
	 wfjtcvHyboTY8AjB/f+BZVAYgC5KZU0s6C/EHNiexVcFM9n+0EnUQzWvgHr2yoiVJl
	 v6Qnv8t5jP5qZ2yHt9Viiym0N985MHwV3ogYAZ9/qSkV5SO4kWElv2/8R1C8XTRolK
	 x1UvOZHahwuyB6QWiGWpIYX1YDtcLo0Lq5qSEY+sUTbcO8uN0C0Ifrww64WBi3d9l7
	 W8iF5jf6pO8iOT9qZ2qvp/X4klGpMkTeUgnotDqMbX7Mq6XkbfEYIMhZ3C6fsonMMI
	 cMdz/SRhqTQeQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBua-0000000AVmF-1Tb5;
	Sat, 31 Jan 2026 15:25:20 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v4 38/41] docs: kdoc_output: describe the class init parameters
Date: Sat, 31 Jan 2026 15:25:12 +0100
Message-ID: <ab5562738cbb25e81c177a705063aadcdef5dc46.1769867954.git.mchehab+huawei@kernel.org>
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

As this class is part of the ABI used by both Sphinx kerneldoc
extension and docs/tools/kernel-doc, better describe what
parmeters are used to initialize ManOutput class.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_output.py | 29 +++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_output.py b/tools/lib/python/kdoc/kdoc_output.py
index fb44cc8e0770..1e3dc47bc696 100644
--- a/tools/lib/python/kdoc/kdoc_output.py
+++ b/tools/lib/python/kdoc/kdoc_output.py
@@ -580,7 +580,34 @@ class RestFormat(OutputFormat):
 
 
 class ManFormat(OutputFormat):
-    """Consts and functions used by man pages output."""
+    """
+    Consts and functions used by man pages output.
+
+    This class has one mandatory parameter and some optional ones, which
+    are needed to define the title header contents:
+
+    ``modulename``
+        Defines the module name to be used at the troff ``.TH`` output.
+
+        This argument is mandatory.
+
+    ``section``
+        Usually a numeric value from 0 to 9, but man pages also accept
+        some strings like "p".
+
+        Defauls to ``9``
+
+    ``manual``
+        Defaults to ``Kernel API Manual``.
+
+    The above controls the output of teh corresponding fields on troff
+    title headers, which will be filled like this::
+
+        .TH "{name}" {section} "{date}" "{modulename}" "{manual}"
+
+    where ``name``` will match the API symbol name, and ``date`` will be
+    either the date where the Kernel was compiled or the current date
+    """
 
     highlights = (
         (type_constant, r"\1"),
-- 
2.52.0

