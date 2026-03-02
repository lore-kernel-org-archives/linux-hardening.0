Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E35425CE4;
	Mon,  2 Mar 2026 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469671; cv=none; b=M5L8XCY0zzKi2IkHc+V4K9VouMHioPbAW8SgpV8ImxgloPcH2HGA7sLHwhhlAzzbl5DY6urNteOSmZDITmgjyFdejLeoeNp2denZQATQCRArXgY/u78AKh50Orjo3+8hq/8xTaIz29Jv+AgOV8irDAm5xFYV4YGbXB3+wL8JiIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469671; c=relaxed/simple;
	bh=krVuokXcDhCbYSFJJTspYEwemL25zHoulATY+A6cBdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u26DXnGNdIsHvimCLlS7DixQ6HGmHSoTtjSh3HT801uPeS1GhdV/hPoLxtRrwiJ7HgDgrRuFm9/aPbC185uQPwVRF9tympG+STBU3qT0ONdp5BjMoVot3C6yykFGTJJD1ZadLVDmKGn10gknzBFD06mKhjWKmIgvcicElBp5FlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8NPyhwt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8NPyhwt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C417DC2BCB2;
	Mon,  2 Mar 2026 16:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772469670;
	bh=krVuokXcDhCbYSFJJTspYEwemL25zHoulATY+A6cBdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q8NPyhwtgCAgKtm9B1ikATdhImsF4zpAgZVPcFtuKFDQ1nZqrTGrphRBmY0ZnyPrR
	 fLX7iqDmS+XlIBpW6OW1ce2R/biSY1RukB5kpn5rVR52K1z+k2Som5ytkH+HsJtKz3
	 5mLgb7Ft3XnFZGMFT8FdZMu49C/b4GReujtiszsOYwp49PqtCQrxydVtsQSEOrmhSs
	 FIOL5HKjnqrDX02r1ne/mym6vakGCy0eO5usQ1bDJyGCIvYY1IgdTboyat0CfLATQ9
	 p54CCaLf+QRrKWkT3fi5rbhPRLx0AHpsMFxaQDseevn1oL5PMTwmZBNXtIpIE9iQW5
	 nOSbt7p/8wNpg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vx6KS-0000000039Z-3OS1;
	Mon, 02 Mar 2026 17:41:08 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 11/18] docs: kdoc_re: better show KernRe() at documentation
Date: Mon,  2 Mar 2026 17:40:54 +0100
Message-ID: <80d27732368c14125c1b76048a70d8b4aee527ef.1772469446.git.mchehab+huawei@kernel.org>
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

the __repr__() function is used by autodoc to document macro
initialization.

Add a better representation for them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_re.py | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 6c44fcce0415..664c04c8cc9f 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -52,7 +52,28 @@ class KernRe:
         return self.regex.pattern
 
     def __repr__(self):
-        return f're.compile("{self.regex.pattern}")'
+        """
+        Returns a displayable version of the class init.
+        """
+
+        flag_map = {
+            re.IGNORECASE: "re.I",
+            re.MULTILINE: "re.M",
+            re.DOTALL: "re.S",
+            re.VERBOSE: "re.X",
+        }
+
+        flags = []
+        for flag, name in flag_map.items():
+            if self.regex.flags & flag:
+                flags.append(name)
+
+        flags_name = " | ".join(flags)
+
+        if flags_name:
+            return f'KernRe("{self.regex.pattern}", {flags_name})'
+        else:
+            return f'KernRe("{self.regex.pattern}")'
 
     def __add__(self, other):
         """
-- 
2.52.0

