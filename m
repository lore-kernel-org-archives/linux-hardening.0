Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE87C360;
	Sat, 26 Apr 2025 00:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745626033; cv=none; b=ZqYoiSweJ24+7XqzzTGYrx7rBf/GcdbPvc30eUFVT8haf2QU+OU0lP8TxriKXG5JLvAJy9hzUTm7eSGqJtXF1PInCKAhvA700BkG3u8+MgRC7bROftcyISLmzKpIo9U8jsCbicrqtKZnY9NHxE0883uWL9zfKntJaku2C+l2SkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745626033; c=relaxed/simple;
	bh=UoxqykoSJQYy0HuyseAsAhDvn5nbQ6gFG5I+BwMHNN4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BYtoEDN/LE1D0D/DTmrjBAKIzwUInvoWWRf7g2k2dJL3s4QWO4mmRXt3J3Z8OqxyXPFPQYCvzQ5ZzdKWF/OQIkfEFW4uSUd/1EYZmc+Gj3iRrcoYz7VCwiPeklUve17YrFL4GUpn5T8+UPdFqArXF9mzoUSUKi3a5Zr//u+3PfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyxhD+pD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyxhD+pD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D51C4CEE4;
	Sat, 26 Apr 2025 00:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745626033;
	bh=UoxqykoSJQYy0HuyseAsAhDvn5nbQ6gFG5I+BwMHNN4=;
	h=From:To:Cc:Subject:Date:From;
	b=LyxhD+pDYH3mjbUMG//m/KUkrdANKLMw3grgt8i8YT5xwkE94n8Z2aiuf6XSevq2g
	 cUHMR3b4atIiGWOAU3grWRCvFXXF0fcDQR09BX2ocOaaXlzO20JvFbpdLb030pXKxc
	 iHdfSnyN+dCNzw4+GhYAxntVXppGpPrjCp0BG6a/GFkaJpRxyquZDQ14mKf65j2Sp6
	 sygJeHT2VQPsZqXKH6uEHk75BD4CbiM1iIusPGtx9gatYZqOfJNEnMV4tOfBGZaR5I
	 +nP5iiDOGtLZbU/uGNGP0nbT5COPK3Pp2Kkwx0/y0M6IG0h+FhlyjUZCHSUI1UE/40
	 +hOxdd4ba+ONw==
From: Kees Cook <kees@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	Maxime Ripard <mripard@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Natalie Vock <natalie.vock@gmx.de>,
	Xavier <xavier_qy@163.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Maarten Lankhorst <dev@lankhorst.se>,
	Dan Williams <dan.j.williams@intel.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] kernel-doc: Add initial binfmt docs
Date: Fri, 25 Apr 2025 17:07:09 -0700
Message-Id: <20250426000704.work.637-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3675; i=kees@kernel.org; h=from:subject:message-id; bh=UoxqykoSJQYy0HuyseAsAhDvn5nbQ6gFG5I+BwMHNN4=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk8ymv+MN5+cXzSpIM+axNt1BPnLo44Hs5T8Nn678GH0 zgkD3m96ihlYRDjYpAVU2QJsnOPc/F42x7uPlcRZg4rE8gQBi5OAZjIp90M//StpQIm+71lj3ER dbGc5rC16sK9oG6B8NT7/3J2Vvzfb8Hwv+6MpNf2ra1yyxmT2X/2xpx7+Wv5E7U1EYcuf26KLZ2 iygQA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Adds a framework to hold the initial exec.c and binfmt_elf.c
kernel-docs. Updates scripts/kernel-doc to allow leading whitespace so
that embedded "DOC:" tags can be found that aren't at the start of a
line so that in-function documentation can be found, like that recently
marked up in binfmt_elf.c[1].

Link: https://lore.kernel.org/lkml/20250425224502.work.520-kees@kernel.org/ [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: <linux-doc@vger.kernel.org>
Cc: <linux-mm@kvack.org>
---
 Documentation/core-api/exec-binfmt.rst | 30 ++++++++++++++++++++++++++
 Documentation/core-api/index.rst       |  1 +
 MAINTAINERS                            |  1 +
 scripts/kernel-doc                     |  4 ++--
 4 files changed, 34 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/core-api/exec-binfmt.rst

diff --git a/Documentation/core-api/exec-binfmt.rst b/Documentation/core-api/exec-binfmt.rst
new file mode 100644
index 000000000000..7e9b515a8107
--- /dev/null
+++ b/Documentation/core-api/exec-binfmt.rst
@@ -0,0 +1,30 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+======================================
+execve(2) internals and Binary Formats
+======================================
+
+Overview
+========
+To perform execve(), the kernel loads the header of a file from disk,
+searches through all binary handlers to find a match, and then builds a
+new process memory layout with the resulting binfmt, before transferring
+userspace execution control to it.
+
+ELF PIE Handling Notes
+======================
+.. kernel-doc:: fs/binfmt_elf.c
+   :doc: PIE handling
+
+brk handling
+============
+.. kernel-doc:: fs/binfmt_elf.c
+   :doc: "brk" handling
+
+Functions and structures
+========================
+.. kernel-doc:: fs/exec.c
+   :identifiers:
+
+.. kernel-doc:: fs/binfmt_elf.c
+   :identifiers:
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index e9789bd381d8..e44b9b2e60ef 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -62,6 +62,7 @@ Low level entry and exit
    :maxdepth: 1
 
    entry
+   exec-binfmt
 
 Concurrency primitives
 ======================
diff --git a/MAINTAINERS b/MAINTAINERS
index fa1e04e87d1d..0dca4c2cbbff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8820,6 +8820,7 @@ M:	Kees Cook <kees@kernel.org>
 L:	linux-mm@kvack.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
+F:	Documentation/core-api/exec-binfmt.rst
 F:	Documentation/userspace-api/ELF.rst
 F:	fs/*binfmt_*.c
 F:	fs/Kconfig.binfmt
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index af6cf408b96d..a2af8ac5acff 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -243,7 +243,7 @@ my $decl_type;
 # Name of the kernel-doc identifier for non-DOC markups
 my $identifier;
 
-my $doc_start = '^/\*\*\s*$'; # Allow whitespace at end of comment start.
+my $doc_start = '^\s*/\*\*\s*$'; # Allow whitespace at end of comment start.
 my $doc_end = '\*/';
 my $doc_com = '\s*\*\s*';
 my $doc_com_body = '\s*\* ?';
@@ -2261,7 +2261,7 @@ sub process_file($) {
 
     $section_counter = 0;
     while (<IN_FILE>) {
-        while (!/^ \*/ && s/\\\s*$//) {
+        while (!/^\s* \*/ && s/\\\s*$//) {
             $_ .= <IN_FILE>;
         }
         # Replace tabs by spaces
-- 
2.34.1

