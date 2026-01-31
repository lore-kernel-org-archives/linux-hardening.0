Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9025035A945;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=dZag052rToNTID6UYD6A6E7Tp5NniTy4JKU12xrpJCcASZwwgyxJSiO1CDgJ5a7qq3VROpWij1enOM1IkV9x1wItpIHMckhmeD9m5K/ICJulmGBwoC95LdDNyALrhR2PaJO7iCQ/KHb/k+rVEnpivjTZsuF++y8eRMnpndSto0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=xc3bdeTKA4gaQTm1QPUjzckBF1/Bc6XutKPIezxeXB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IPlDmiUU88UUmvIyTZKxT0f6yBhLhvI6AhU+o5STtmJdh3DTnIimVlZz2jqGvgn0OhnO8gTKq1LMX5Rth7k+75OssP4LJLPZpC7ySlNngSbtS7rizeITnnL2eZ+EKpepwwuEPvCVgjIkz8wV8vnQbTtkXGey3+VFMLziebpTdvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+lgoG9C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+lgoG9C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1600DC2BD04;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869522;
	bh=xc3bdeTKA4gaQTm1QPUjzckBF1/Bc6XutKPIezxeXB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e+lgoG9CCnr7rpRrfsny4rjU3fOjEA51AuUGLbiRKwx4JxSMtmKdWklJMdOrLCagH
	 JF5wdiKyo3olj2bQCU/JKO4RWNPvW5PiF38+1ed3tFZVgSB6VxYq7mXw5iNUgROa9S
	 f2AqXDqsVXQKNJAnTON850mtt7wlHtt6Q00qG5g9KlvTCRkHgxbsgj/Ag22zWTaXeT
	 aUo438xrkfrN2S8hpQFTeJ0cPbJZfK6PMPnw486vZ72kMUbNXYGXODLNQcTQqAeIhP
	 0yiQUASDOOvdYUZeyMG0irPKAvFiWPIWSvNVWbbf9wn9hQpeZ7Hu2CHivgMnC22av+
	 kONely4AuJDNw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBua-0000000AVmB-1Mc4;
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
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v4 37/41] docs: kdoc_output: use a more standard order for .TH on man pages
Date: Sat, 31 Jan 2026 15:25:11 +0100
Message-ID: <b41dd589cfde10cda5ada6b629f93916a4e96162.1769867954.git.mchehab+huawei@kernel.org>
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

The generated man pages are not following the current standards
for Linux documentation. Reorder .TH fields for them to look
like other Linux man pages.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/sphinx-build-wrapper      | 2 +-
 tools/lib/python/kdoc/kdoc_output.py | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index e6418e22e2ff..ac6852e3dd8c 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -625,7 +625,7 @@ class SphinxBuilder:
 
                 # Use shlex here, as it handles well parameters with commas
                 args = shlex.split(line)
-                fname = f"{output_dir}/{args[3]}.{args[2]}"
+                fname = f"{output_dir}/{args[1]}.{args[2]}"
 
                 if self.verbose:
                     print(f"Creating {fname}")
diff --git a/tools/lib/python/kdoc/kdoc_output.py b/tools/lib/python/kdoc/kdoc_output.py
index fe3fc0dfd02b..fb44cc8e0770 100644
--- a/tools/lib/python/kdoc/kdoc_output.py
+++ b/tools/lib/python/kdoc/kdoc_output.py
@@ -611,8 +611,8 @@ class ManFormat(OutputFormat):
         """Emit a title header line."""
         name = name.strip()
 
-        self.data += f'.TH "{self.modulename}" {self.section} "{name}" '
-        self.data += f' "{self.date}" "{self.manual}"\n'
+        self.data += f'.TH "{name}" {self.section} "{self.date}" '
+        self.data += f' "{self.modulename}" "{self.manual}"\n'
 
     def __init__(self, modulename, section="9", manual="Kernel API Manual"):
         """
-- 
2.52.0

