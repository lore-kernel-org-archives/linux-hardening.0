Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CC835A93B;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=Z1V2qWONqM4HChq0CxOUihiQy/OaO9KJ92p73XB8++aU7r/4s6panXOf8V3f43oJIe5H9askYBHDhOxfKPOmd3CqqnUv0geKChUMZAAJY4TbqUnsElGJGvrLzSe2QDIGKEcM29WmmwgxkphtW6SDpNoW03397xHPQGP4FyvyHqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=C2cStPoOoGCftK6fYM/VQjKEO1UC2wtJ9483nmjaklU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cEOfetqAl1XlXVsZlqdJHNBO6Eqeu/fodY7hFQ6jhgWaS0MS2gGzJtLf5rYihITKGnIY7ly0QSiEQJLKDQ/REILIU+C3nS+ZFtl7DO5vmn34BPXvda5eohjeLJLY4Ojy+nsE3sJe5HrTLgxZykh0KfRz0Ra/ZjhkOHR9W6f4vy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUlq74Q3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUlq74Q3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04926C4AF67;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869522;
	bh=C2cStPoOoGCftK6fYM/VQjKEO1UC2wtJ9483nmjaklU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XUlq74Q3cKfYzyY2KmtaeWNQkjLbbRDt5JtA5d4kbIkyhkSG2+r9AGrHLU4Qs3OAO
	 3CImQgNMNaRltbbsjangUr8/RFy/xKGsHu358A75l53bxFqHHyasF1Y45xDrcFc7ZZ
	 zUGz4lPK3g2E73Jcj6dtY4eaNtIuN0oRlF39s22PGLYoBlu/2KrKfAQvAhr+IyXRR+
	 fiDNVldhW85MRQCVRgbBHJVmTVarAAtjw7rDnTFIEHavj+WTvsWpLmLJ87yKpKiD0Q
	 +HIoB2dNIDt/n0P2oHfuEaY5mV8k8GNS3pw9TsRmf1W18wyoLE9yQyFvxtldDB8Ism
	 kso7P7jRnB1bA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBua-0000000AVlv-0v7X;
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
Subject: [PATCH v4 33/41] tools: sphinx-build-wrapper: improve its help message
Date: Sat, 31 Jan 2026 15:25:07 +0100
Message-ID: <9a41e5aa1da74e30a05bc21537a0c170450f01e3.1769867954.git.mchehab+huawei@kernel.org>
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

Besides the parameters that are passed via command line arguments,
the wrapper's behavior is affected by several environment variables.

Document that. While here, use __doc__ for its description.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/sphinx-build-wrapper | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index 8080ace60680..b7c149dff06b 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -814,20 +814,42 @@ def jobs_type(value):
     except ValueError:
         raise argparse.ArgumentTypeError(f"Must be 'auto' or positive integer, got {value}")  # pylint: disable=W0707
 
+EPILOG="""
+Besides the command line arguments, several environment variables affect its
+default behavior, meant to be used when called via Kernel Makefile:
+
+- KERNELVERSION:  Kernel major version
+- KERNELRELEASE:  Kernel release
+- KBUILD_VERBOSE: Contains the value of "make V=[0|1] variable.
+                  When V=0 (KBUILD_VERBOSE=0), sets verbose level to "-q".
+- SPHINXBUILD:    Documentation build tool (default: "sphinx-build").
+- SPHINXOPTS:     Extra options pased to SPHINXBUILD
+                  (default: "-j auto" and "-q" if KBUILD_VERBOSE=0).
+                  The "-v" flag can be used to increase verbosity.
+                  If V=0, the first "-v" will drop "-q".
+- PYTHON3:        Python command to run SPHINXBUILD
+- PDFLATEX:       LaTeX PDF engine. (default: "xelatex")
+- LATEXOPTS:      Optional set of command line arguments to the LaTeX engine
+- srctree:        Location of the Kernel root directory (default: ".").
+
+"""
+
 def main():
     """
     Main function. The only mandatory argument is the target. If not
     specified, the other arguments will use default values if not
     specified at os.environ.
     """
-    parser = argparse.ArgumentParser(description="Kernel documentation builder")
+    parser = argparse.ArgumentParser(formatter_class=argparse.RawTextHelpFormatter,
+                                     description=__doc__,
+                                     epilog=EPILOG)
 
     parser.add_argument("target", choices=list(TARGETS.keys()),
                         help="Documentation target to build")
     parser.add_argument("--sphinxdirs", nargs="+",
                         help="Specific directories to build")
     parser.add_argument("--builddir", default="output",
-                        help="Sphinx configuration file")
+                        help="Sphinx configuration file (default: %(default)s)")
 
     parser.add_argument("--theme", help="Sphinx theme to use")
 
@@ -843,7 +865,7 @@ def main():
                         help="place build in verbose mode")
 
     parser.add_argument('-j', '--jobs', type=jobs_type,
-                        help="Sets number of jobs to use with sphinx-build")
+                        help="Sets number of jobs to use with sphinx-build(default: auto)")
 
     parser.add_argument('-i', '--interactive', action='store_true',
                         help="Change latex default to run in interactive mode")
-- 
2.52.0

