Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4878D37CD51;
	Thu, 12 Mar 2026 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327298; cv=none; b=NXGCA2YhAax9g3VAA2z6Y3kMD5J1nAXdum4RfupMXQWeRLskfYYuj9GdUWAASQ7+D9Zh1dv/BLLX/TN+arGWFF9qICdZP4A5fVm/mGMWJL0ino/vFUTFDZYyGI5bDdSRd03XZ5E0BkM9EC5LY1Xs26kXI1OVWshx0q8F+E6Vmuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327298; c=relaxed/simple;
	bh=n3BVrBoQMdxdpoipeTxJikhOj3p5syl4ggfaedUESPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fsv4Md1yTWELpmVeqCmb9kGzF6uCb0Y8+X6u7iJ7Sg43PqSPW2loEX6LtJmSmIjIgy5S+qMn3RXidqkXCCbfiQ3cr/t3OmYg6FuevJMCFB+KGpf8xKR3kLkRUqRKsiomgCGMR30/TahK95ECuky63nuKUau7b3Fh2CjgFdtgdSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBtwuJS9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBtwuJS9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F927C2BC86;
	Thu, 12 Mar 2026 14:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773327298;
	bh=n3BVrBoQMdxdpoipeTxJikhOj3p5syl4ggfaedUESPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JBtwuJS93Ei0ji3+9dLTNknDLYGUVEFH5keP/ymhnribkhxbbmYOmdf/92A9b/MXX
	 +k/AfX/GsjtmR1I6tnyhVcNqIg7CNOCr0eQUJb3V9g+jqa/+0xblpTeWUZMnU20Ddf
	 6uYHrbeK3mfk7uorglWp1ZO6/1LYBV3N+3oRnuVprsJyXMh40E1LYEZ2ZgzS+hsjr5
	 RrLrznlRAZEIldmEIuFErVVt67pKYD3n6+mWHexMVvfsj3QmpeEfNi+uT+a3zu+FkU
	 5C3axdT4YX5eYzqF7lwOAUFSAQC3BsX7Ngnp6qSDYF+8pwxJy1ecEIqHBKqpdDRwUJ
	 E8X8yEkoMcHFg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0hRA-00000008xpc-0MoI;
	Thu, 12 Mar 2026 15:54:56 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 04/28] docs: kdoc: properly handle empty enum arguments
Date: Thu, 12 Mar 2026 15:54:24 +0100
Message-ID: <abcc260f770c4fcb2ae40be58bd8eea5e44bf697.1773326442.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1773326442.git.mchehab+huawei@kernel.org>
References: <cover.1773326442.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Depending on how the enum proto is written, a comma at the end
may incorrectly make kernel-doc parse an arg like " ".

Strip spaces before checking if arg is empty.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Message-ID: <4182bfb7e5f5b4bbaf05cee1bede691e56247eaf.1773074166.git.mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 086579d00b5c..4b3c555e6c8e 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -810,9 +810,10 @@ class KernelDoc:
         member_set = set()
         members = KernRe(r'\([^;)]*\)').sub('', members)
         for arg in members.split(','):
-            if not arg:
-                continue
             arg = KernRe(r'^\s*(\w+).*').sub(r'\1', arg)
+            if not arg.strip():
+                continue
+
             self.entry.parameterlist.append(arg)
             if arg not in self.entry.parameterdescs:
                 self.entry.parameterdescs[arg] = self.undescribed
-- 
2.52.0

