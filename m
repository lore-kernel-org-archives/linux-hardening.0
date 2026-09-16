Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDFD4E80B8;
	Wed, 16 Sep 2026 18:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584098; cv=none; b=LR7EEEkyBStlnhI1CJtJA5qeN247e7OV3qrwcizGuU+WkHHkmUsK960nZoH+Q5v3N2gYPoZY6RLIgtxJx9OLmwp303fJ7y6R1GFg9bCgZUKQvjiHnTbpmgNcexVLE/DH/aL1H2qZ2vK4AUXfKwnjc7erNeq22sb02mVrOJflJcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584098; c=relaxed/simple;
	bh=rMBaxz4ZXa8jSEz8njA9uaS8oYerVZGYbNcsaCNokiw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QyMbbSXzRD70ys2hmtWZGw1w6fQy6SZnaLB/tXanWmgHIu76plVcIAaK4+9/GGcjqvFEBw63Ho4oePLC5qbr2jArkQGyiwkJRIWhbSqNs2YG14H4YECeEGeuYHq5PiM7p54PCnUuZa1ncNyi5d+00mWbAebFuaeUWtqf4fIcZW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBfjaM20; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBfjaM20"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DAD1F00899;
	Wed, 16 Sep 2026 18:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584075;
	bh=0wRC0GXn1+fNdmH70nf9JZ5F/Llik+RfDcCb5TeT+0I=;
	h=From:To:Cc:Subject:Date;
	b=RBfjaM20TRWhMb9Wmzl0Vcwtevwqs4K+4RFVZy7FuX8MdnC9sKpC1NE8/ZBx1/Hq7
	 3W4fjmtxE+/5LPDuuOACNFNlPBhZjXEaWVhhgo+D/xElsI5SvfAJdI8c/a6yeP9O/e
	 2s5SCtrJw6W1OyP9Ft4HpNrBAvBnfkY3T7qumPGZxyP2VfjegsGErvP//c8T7gkXoX
	 yh6/k9JJT2AZxB9gdUInsFvbhjvVjxW9POQ/1p/axSzhdBWkxiicJQPZE5nka7DXMa
	 hIU/Ha1fabh1En91rj3WvgIWUKs0Qv4vKFyqOVK303+s9tfJlm+9RANddObE2E3WCV
	 c3pspQ0S8CbWA==
From: Kees Cook <kees@kernel.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Maximilian Huber <maximilian.huber@tngtech.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Luis Augenstein <luis.augenstein@tngtech.com>,
	Breno Leitao <leitao@debian.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Andrew Jones <andrew.jones@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] docs: Makefile: Add a testdocs target for the documentation unit tests
Date: Wed, 16 Sep 2026 11:41:11 -0700
Message-Id: <20260916184107.i.183-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2686; i=kees@kernel.org; h=from:subject:message-id; bh=rMBaxz4ZXa8jSEz8njA9uaS8oYerVZGYbNcsaCNokiw=; b=owGbwMvMwCVmps19z/KJym7G02pJDFmrHh3XOVn85YT9if6vSyZPaK5zS+fu2LL816J18/RSI nYFz+u17ShlYRDjYpAVU2QJsnOPc/F42x7uPlcRZg4rE8gQBi5OAZjI3XeMDG0u862PN35dvbHo 4KfwacannDNvXWRa/H3aqXweC4man7cZGR44zXs073xgzMYTVqe1nD4bhvlMWLCL6ZrRJfW1zXd 0NrIDAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

tools/unittests/run.py discovers and runs the unit tests there (which
are primarily documentation tools), but nothing in the build calls it,
so the tests are only run by whoever remembers that the script is there.

Give it a target, next to the other checks that need no Sphinx. The name
ends in "docs", so it matches the "%docs" pattern already in
no-dot-config-targets and runs without a configured tree, and it sets
PYTHONPYCACHEPREFIX as the other Python targets here do, to keep
__pycache__ directories out of the source tree.

  $ make testdocs
  ...
  Ran 121 tests

with "make dochelp" listing it between refcheckdocs and cleandocs.

Tested with GNU Make 4.4.1 and Python 3.14.7, on a tree with no .config,
where it ran 121 tests and left no __pycache__ behind.

Assisted-by: LLM
Signed-off-by: Kees Cook <kees@kernel.org>
---
I debated the naming here, since "tools/unittests/" is such a general
directory location, but figured I'd start with a target that made the most
logical sense given what is actually being tested there? I dunno. Maybe
"make testtools"? But that reads weird.
---
 Makefile               | 2 +-
 Documentation/Makefile | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 66654fa71655..88557288163d 100644
--- a/Makefile
+++ b/Makefile
@@ -2002,7 +2002,7 @@ $(help-board-dirs): help-%:
 # ---------------------------------------------------------------------------
 DOC_TARGETS := xmldocs latexdocs pdfdocs htmldocs epubdocs cleandocs \
 	       linkcheckdocs dochelp refcheckdocs texinfodocs infodocs mandocs \
-	       htmldocs-redirects
+	       htmldocs-redirects testdocs
 
 PHONY += $(DOC_TARGETS)
 $(DOC_TARGETS):
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 377a449656c8..ee852afe9bb9 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -74,6 +74,10 @@ htmldocs-redirects: $(srctree)/Documentation/.renames.txt
 refcheckdocs:
 	$(Q)cd $(srctree); tools/docs/documentation-file-ref-check
 
+testdocs:
+	$(Q)PYTHONPYCACHEPREFIX="$(PYTHONPYCACHEPREFIX)" \
+		$(PYTHON3) $(srctree)/tools/unittests/run.py
+
 cleandocs:
 	$(Q)rm -rf $(BUILDDIR)
 
@@ -95,6 +99,7 @@ dochelp:
 	@echo  '                    (will connect to external hosts)'
 	@echo  '  refcheckdocs    - check for references to non-existing files under'
 	@echo  '                    Documentation'
+	@echo  '  testdocs        - run the unit tests of the documentation tools'
 	@echo  '  cleandocs       - clean all generated files'
 	@echo
 	@echo  '  make SPHINXDIRS="s1 s2" [target] Generate only docs of folder s1, s2'
-- 
2.34.1

