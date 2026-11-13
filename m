Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591841;
	b=dPF6EHtfX3YfK1V2XdVlGnC/hQFhmtfwRgJBSwUZ9uQN6kjLRFTEaHg0PaTZ5DrStqH3
	 t8IEuE44ugT5aEMTQI9Hak7s4fN6WxhshTtcIfC5gSPLDa8NNedPpUU3joKyYgHWRNqek
	 sWPKcIlLGY52PilFsmcL+55cF63SxObYqeFeoUkoqjD7mM3B4NwWYd+AdbGv4P5D3om5N
	 gZefxNey49ZO3nZC9OTKZ9tjjKCUP6jBo6hDPV+If8xAfc2pnGmj5YEPoWI2y4+dNU8tE
	 UW8anRwI76mw4RjD4bM6pWgVlhfA88+G9rU+6kN7hLAZWSPLTuKzPLqbj/iNsBNRUYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591841;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:Content-Type:
	 Content-Transfer-Encoding;
	bh=NKYKol3Yl8sj0vRz5pMfnn5MzLxxfO4L/cc7D90OHlM=;
	b=qsmT//z6KOXhCtSPGebjxhDiK7FtqDVLSSKIkgNhAyqVkAMpFweBdbp27bq9cMHUMEJ2
	 t20mDEdIQD0bCMvFC/BnGsye08p2YGcp4JbxRLq0tiS6mtNnDnkHyVCR/FLnlp0Y4oEjA
	 jRouH4aTUr4ejACXWmRXXQ7BRPEG/MufrjCZ0u+QmgPKyqzmRyLgEcQ800YGrBx3u3dfE
	 xH/uflqZZbsO+3qrJdVlwCMxsciKmA8ZY+3iEfCQwjyOZMcF96wzkQzqfpdUEfQTqjI9N
	 CScqWphJNl3TC4BUlG6JTNXUm2EdwNh6Gxw+a6UDh18AHwvctWQzb4oML0nq5OjWKOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D8PydKzG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEBB606A335;
	Fri, 13 Nov 2026 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D8PydKzG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE13C1F000C4;
	Fri, 13 Nov 2026 17:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591840;
	bh=NKYKol3Yl8sj0vRz5pMfnn5MzLxxfO4L/cc7D90OHlM=;
	h=From:To:Cc:Subject:Date;
	b=D8PydKzGBNcypjDn4bE9hoeZT8KdZr5dn3qCmtSk61EjF7gWIedagRnsFbvfhqjXG
	 Q7/XpagR/oIlbCxstL1kXFWZS5XGiJEACJDexeMehtbDAd493hBgeCgvcxB3eB2f55
	 Km8gT7+dQxjLm6G1P5HpkENR2DnSfPgB8TRY0V/ls5EMlILpDPqO+XjQK4jsjl9kLk
	 leW3QtnmqCWn+/wj+PPxPcIssHYd5Selc0hHCmsgnYaWjU3xek3AWomPBiFb3YVqIN
	 du1nE/EocSZ1P3Hl3lyKclNBch8PwhcBPy8JTmEWUX80fBqamRltb229ZVex/OtAGD
	 iHMKha6+F/qbw==
From: Kees Cook <kees@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <kees@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] CREDITS: Regularize email address for Kees Cook
Date: Fri, 13 Nov 2026 09:43:58 -0800
Message-ID: <20261113174357.i.748-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7436; i=kees@kernel.org; h=from:subject:message-id; bh=bDZG/3A+LdKKon59/JLDY2N10GRHjo/Ki44YlTYgw6U=; b=owGbwMvMwCVmps19z/KJym7G02pJDFnffeJ6FQ8FBBZ9iulKCeMOZ+05/brr3ZzgGQfWLsgqP S3tkLa5o5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCILvRj+p60seRvSq8Tnx/U/ 0IFx+ptrHxbIeDdN9WLNYBfpP/U0iuGvQJp3wLsPjDdfqbSzJUsGmf+r/j51l8aZjfJmmTZv/q7 kAAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update my email address to better reflect reality: company-specific things
(hw embargo) to Google, everything else to @kernel.org, drop less-used
aliases, but leave copyright-associated email comments as-is.

Signed-off-by: Kees Cook <kees@kernel.org>
---
I am happy to carry this via pstore or hardening, but figured I'd send
it via docs just to avoid any collisions with translation updates.
---
 Documentation/process/embargoed-hardware-issues.rst           | 2 +-
 .../translations/pt_BR/process/embargoed-hardware-issues.rst  | 4 ++--
 .../translations/sp_SP/process/embargoed-hardware-issues.rst  | 2 +-
 .../translations/zh_CN/process/embargoed-hardware-issues.rst  | 2 +-
 .../translations/zh_TW/process/embargoed-hardware-issues.rst  | 2 +-
 fs/pstore/blk.c                                               | 2 +-
 fs/pstore/zone.c                                              | 2 +-
 lib/test_firmware.c                                           | 2 +-
 lib/test_module.c                                             | 2 +-
 CREDITS                                                       | 3 +--
 10 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index 2c244a6d1463..c588a7140293 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -306,7 +306,7 @@ an involved disclosed party. The current ambassadors list:
   Red Hat	Josh Poimboeuf <jpoimboe@redhat.com>
   SUSE		Jiri Kosina <jkosina@suse.cz>
 
-  Google	Kees Cook <keescook@chromium.org>
+  Google	Kees Cook <keescook@google.com>
 
   LLVM		Nick Desaulniers <ndesaulniers@google.com>
   ============= ========================================================
diff --git a/Documentation/translations/pt_BR/process/embargoed-hardware-issues.rst b/Documentation/translations/pt_BR/process/embargoed-hardware-issues.rst
index ae1fda0880cc..9a728c0291a3 100644
--- a/Documentation/translations/pt_BR/process/embargoed-hardware-issues.rst
+++ b/Documentation/translations/pt_BR/process/embargoed-hardware-issues.rst
@@ -310,7 +310,7 @@ A lista atual de embaixadores:
   Red Hat       Josh Poimboeuf <jpoimboe@redhat.com>
   SUSE          Jiri Kosina <jkosina@suse.cz>
 
-  Google        Kees Cook <keescook@chromium.org>
+  Google        Kees Cook <keescook@google.com>
 
   LLVM          Nick Desaulniers <ndesaulniers@google.com>
   ============= ========================================================
@@ -359,4 +359,4 @@ adiciona à lista. Após a inscrição, o assinante receberá e-mails da lista d
 e-mail que são assinados com a chave PGP da lista ou com o certificado S/MIME
 da lista. O cliente de e-mail do assinante pode extrair a chave PGP ou o
 certificado S/MIME da assinatura para que o assinante possa enviar e-mails
-criptografados para a lista.
\ No newline at end of file
+criptografados para a lista.
diff --git a/Documentation/translations/sp_SP/process/embargoed-hardware-issues.rst b/Documentation/translations/sp_SP/process/embargoed-hardware-issues.rst
index 7d4d694967c7..15084a29e51e 100644
--- a/Documentation/translations/sp_SP/process/embargoed-hardware-issues.rst
+++ b/Documentation/translations/sp_SP/process/embargoed-hardware-issues.rst
@@ -285,7 +285,7 @@ revelada involucrada. La lista de embajadores actuales:
   Red Hat	Josh Poimboeuf <jpoimboe@redhat.com>
   SUSE		Jiri Kosina <jkosina@suse.cz>
 
-  Google	Kees Cook <keescook@chromium.org>
+  Google	Kees Cook <keescook@google.com>
 
   LLVM		Nick Desaulniers <ndesaulniers@google.com>
   ============= ========================================================
diff --git a/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst b/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst
index c90ecb557811..c87d2ecda7d8 100644
--- a/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst
+++ b/Documentation/translations/zh_CN/process/embargoed-hardware-issues.rst
@@ -190,7 +190,7 @@ CVE分配
   SUSE		Jiri Kosina <jkosina@suse.cz>
 
   Amazon
-  Google	Kees Cook <keescook@chromium.org>
+  Google	Kees Cook <keescook@google.com>
   ============= ========================================================
 
 如果要将您的组织添加到专使名单中，请与硬件安全小组联系。被提名的专使必须完全
diff --git a/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst b/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
index 611247c816f4..ab81081c7a17 100644
--- a/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
+++ b/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
@@ -226,7 +226,7 @@ CVE分配
   Red Hat	Josh Poimboeuf <jpoimboe@redhat.com>
   SUSE		Jiri Kosina <jkosina@suse.cz>
 
-  Google	Kees Cook <keescook@chromium.org>
+  Google	Kees Cook <keescook@google.com>
 
   LLVM		Nick Desaulniers <ndesaulniers@google.com>
   ============= ========================================================
diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index 12070b6a7b11..3d7ab7eff821 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -357,5 +357,5 @@ module_exit(pstore_blk_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("WeiXiong Liao <liaoweixiong@allwinnertech.com>");
-MODULE_AUTHOR("Kees Cook <keescook@chromium.org>");
+MODULE_AUTHOR("Kees Cook <kees@kernel.org>");
 MODULE_DESCRIPTION("pstore backend for block devices");
diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index a3b003f9a3a0..628c6cdaeae7 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -1471,5 +1471,5 @@ EXPORT_SYMBOL_GPL(unregister_pstore_zone);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("WeiXiong Liao <liaoweixiong@allwinnertech.com>");
-MODULE_AUTHOR("Kees Cook <keescook@chromium.org>");
+MODULE_AUTHOR("Kees Cook <kees@kernel.org>");
 MODULE_DESCRIPTION("Storage Manager for pstore/blk");
diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 7459bba65444..870fa0489a08 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -1567,6 +1567,6 @@ static void __exit test_firmware_exit(void)
 
 module_exit(test_firmware_exit);
 
-MODULE_AUTHOR("Kees Cook <keescook@chromium.org>");
+MODULE_AUTHOR("Kees Cook <kees@kernel.org>");
 MODULE_DESCRIPTION("interface to trigger and test firmware loading");
 MODULE_LICENSE("GPL");
diff --git a/lib/test_module.c b/lib/test_module.c
index 3d1b29b74807..a14b1e2d0e46 100644
--- a/lib/test_module.c
+++ b/lib/test_module.c
@@ -30,6 +30,6 @@ static void __exit test_module_exit(void)
 
 module_exit(test_module_exit);
 
-MODULE_AUTHOR("Kees Cook <keescook@chromium.org>");
+MODULE_AUTHOR("Kees Cook <kees@kernel.org>");
 MODULE_DESCRIPTION("module loading subsystem test module");
 MODULE_LICENSE("GPL");
diff --git a/CREDITS b/CREDITS
index c6c7b173b064..7242d7c92bf5 100644
--- a/CREDITS
+++ b/CREDITS
@@ -787,9 +787,8 @@ D: Assorted sched/mm titbits
 S: Oxfordshire, UK.
 
 N: Kees Cook
+E: kees@kernel.org
 E: kees@outflux.net
-E: kees@ubuntu.com
-E: keescook@chromium.org
 W: http://outflux.net/blog/
 P: 4096R/DC6DC026 A5C3 F68F 229D D60F 723E  6E13 8972 F4DF DC6D C026
 D: Various security things, bug fixes, and documentation.
-- 
2.55.0

