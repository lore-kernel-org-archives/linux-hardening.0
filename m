Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749CC359FAF;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=CmbQZiQe0EcCcPv+U49bmZqqi+Sa30H7s6yDATlO9SBaDe2HKzDdBB6mgZtOHaLv0r/6qCFaZakBPhJXNb2HWHyUFcgcFNcIZ+2uoOSLuZ0HsJBNkuzO3RQPcXDi3ych/fACSbDba+VGEJv6plCi6Htpw0DJf+q7RJaaJkhLkcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=4aMfKYcVERhHxWAsYjEi8+tgICvrID1mZsAmSUTyoxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=th9Tign/ogcZUgLi3jjfBzw97d8T2X1DpH9VRj/qxpnqtvC0BPGVWc8U14fDxSiUg0OdM35aUEfcbvF8QJoBn0KatSC0YxWOCetMZMKdEjugVqgdX672sV0qsyu+9Bgd2GznMqiM+hPZDXpT+0NMON1gaiwa5pE/Rqb9rI6JKqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwEnvRTB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwEnvRTB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75FEC4CEF1;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869522;
	bh=4aMfKYcVERhHxWAsYjEi8+tgICvrID1mZsAmSUTyoxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GwEnvRTBbcukjFCvBXvPdgcMk8cgUg/NaCFQ0rJOvDeTecyO+ZPAkjpB/Ku3JxiY8
	 GMBLmijNIKMU44tEeKWSwefOeYvvim8vyZpfqFsjJMPO27NfrgSeVMkDacZNKm60Cb
	 XNLdkazVD4yre6r7b0aF1is/lkAwGwRGaMrdozz4fvmF7zDzMfTsOM4TI6kuu2Slbq
	 HzMCVXVkDYQh+J+b9YGeyPpOtOwVbT/ma64oMzW8R51OIxHD7f2f8KzCF9jzsjf+ZK
	 Yy7GXjlkf9Owx8xrNBMDZGTq6Wzv4s0SsQNowqDsocRn2CoCKudSeOONO5uwmZbHCx
	 3ZESXL3Kdrumg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBua-0000000AVlr-0oEC;
	Sat, 31 Jan 2026 15:25:20 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v4 32/41] docs: sphinx-build-wrapper: allow -v override -q
Date: Sat, 31 Jan 2026 15:25:06 +0100
Message-ID: <64fe15e0ddaba7de59a7c031db03f87c19873c04.1769867954.git.mchehab+huawei@kernel.org>
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

Documentation builds were using "-q" for a long time, but sometimes
it is nice to see the Sphinx progress, without increasing build
verbosity - which would also turn on kernel-doc verbosity.

Instead of doing that, let's parse the sphinx-build already-existing
-v: each time it is used, it increases the verbosity level.

With that, if the default is to use -q, a single -v will disable
quiet mode. Passing more -v will keep increasing its verbosity.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/sphinx-build-wrapper | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index 78ff7ac202ef..8080ace60680 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -168,6 +168,7 @@ class SphinxBuilder:
         parser = argparse.ArgumentParser()
         parser.add_argument('-j', '--jobs', type=int)
         parser.add_argument('-q', '--quiet', action='store_true')
+        parser.add_argument('-v', '--verbose', default=0, action='count')
 
         #
         # Other sphinx-build arguments go as-is, so place them
@@ -179,10 +180,14 @@ class SphinxBuilder:
         # Build a list of sphinx args, honoring verbosity here if specified
         #
 
-        verbose = self.verbose
         sphinx_args, self.sphinxopts = parser.parse_known_args(sphinxopts)
+
+        verbose = sphinx_args.verbose
+        if self.verbose:
+            verbose += 1
+
         if sphinx_args.quiet is True:
-            verbose = False
+            verbose = 0
 
         #
         # If the user explicitly sets "-j" at command line, use it.
@@ -195,8 +200,11 @@ class SphinxBuilder:
         else:
             self.n_jobs = None
 
-        if not verbose:
+        if verbose < 1:
             self.sphinxopts += ["-q"]
+        else:
+            for i in range(1, sphinx_args.verbose):
+                self.sphinxopts += ["-v"]
 
     def __init__(self, builddir, venv=None, verbose=False, n_jobs=None,
                  interactive=None):
-- 
2.52.0

