Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5241B354AD0;
	Wed, 18 Feb 2026 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409613; cv=none; b=D3XuN4/wNWNChkFFSJeOpeopstoU+A9IiKcZK0m0UPFivOcdU8+lx4KKsedcOYKdI8xp9Hq1sk5n1h+1Ryhc6mVj8vqY82zc1porHb4TzlQutQwjMePC6c4Q02+wRktxbDvbVCXvqpdnHG3aYcfopMItiHKFOIWP7Qff2HZSfIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409613; c=relaxed/simple;
	bh=3P9hiqMJWs99bANIe05s+PiDHBtg0dmIB/Ud7yaibWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eKJxdRHCVD0kQYHBII6CXiFHcJYJOCXEB6zHLF57qU5PYohpIp9hH2j85DFlSchlDVimdG38bTapn9HNWz3L/eQS5T+gzREHEtyNuONNa4IorwbBg6yHj0bAFq0aI1YfEM5C1+uh33uWei46ep9JBaBh7RSRBwJGhkmUieKoFLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIqwfoV+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIqwfoV+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355F5C19423;
	Wed, 18 Feb 2026 10:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409613;
	bh=3P9hiqMJWs99bANIe05s+PiDHBtg0dmIB/Ud7yaibWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BIqwfoV+v2/xOuRN3E350Oc1l18+qkwnx9/6fTKNR5zqTbMATC7FyhCuXooCYEFv+
	 nuM+zMKR0Dkz76X0z+E27ndHyVP60cR4SY0EnFxlB/tmE9dpC2E6vxiaTrzzNrQCgq
	 N/s/PVLmWVtxqkDYYgqml5YXJxERJp9sZnI8wxLeuPkES5tQEw87AGs+ijfiuzH+9d
	 8aY7C5sLaHyfK00lC4HG4/4qB022KabQuKgPsjpyUY+Ph4W2czJRHO+lgACqw0A7oE
	 n6rLK0qfM05yTq7X21eGyzrHxkfKv12GCRxxBtH+72jVUmcsleSjOxBtcSALVF/SWd
	 8rjjIjpYU76FQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYl-00000000M3c-1jrv;
	Wed, 18 Feb 2026 11:13:31 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 37/38] docs: kdoc_output: describe the class init parameters
Date: Wed, 18 Feb 2026 11:13:07 +0100
Message-ID: <260f2d989f4187940e371023dc8a035c28521b8e.1771408406.git.mchehab+huawei@kernel.org>
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

