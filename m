Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1C623A2
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 03:24:41 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833D71A8
	for <linux-hardening@vger.kernel.org>; Thu, 28 Sep 2023 20:24:39 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68fdcc37827so161776b3a.0
        for <linux-hardening@vger.kernel.org>; Thu, 28 Sep 2023 20:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695957879; x=1696562679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95+jGh9HzPfjIjeeQbyhCMVgDdqV+t+zi0ml5yOYuB8=;
        b=jxYfHi6UrmlN+2RUW3BFPUPF6/N0gHYlZIWZzjNHw7WzqWZzyCSQIRcCf7rXysywY3
         s1yOxdFMqC5M6da9Zpq4ZD/D53DypziHPfjATX/sfflu3nUOB5j8/C0VJBMaHXLMRUrV
         CLytRsuOuOhoJWKJqFJCuVH8yPGfPTe1n9hmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695957879; x=1696562679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95+jGh9HzPfjIjeeQbyhCMVgDdqV+t+zi0ml5yOYuB8=;
        b=iVzkSJq90lxBifXAFyykV7HA+py+DDGK/L7xlJTBnbsMHV0urz1CIxSPC9jKv36FV2
         ds9nvHLPV2ZW+ZbLob5c0LqF5WjVc9ZbD3HpT+8JnpbRYTiXR2dTUk2mi0aYwoNPxAO1
         9omg44MxV4hyBGRg2IXkQRKxcqGl3z+UmXQkpG09jIKksh0uQPbAI8dSkG3steSzdwL9
         s1FhSWgqrDAEXfAwR/XG6r3o/whE4EEG019NjiAzX1NxtilRz8721SFsXpAuNMWfFcXD
         acMQc9IxT1nHvxtr9EWtRoHDSA6uCpVhr6bCMc7ku6/+PT9IAtrmh5IP3+lj3uqTrT2v
         seww==
X-Gm-Message-State: AOJu0YxrRukIX5cQ1pSq13+JvJ76Z5Pld7ew38HJFGlNe1q5dSfBVqRd
	eE+b2/h+ZppcSDCpD9IdaqgH3Q==
X-Google-Smtp-Source: AGHT+IENptQn7XIn+gHi7Xk/Rom3FrwjZlYNl2dbdfUf0uD5PWaNHfgd4GwUs3Rvuj8dtt6Ixw6ezw==
X-Received: by 2002:a05:6a20:72a5:b0:153:4ea6:d12e with SMTP id o37-20020a056a2072a500b001534ea6d12emr5304382pzk.17.1695957878823;
        Thu, 28 Sep 2023 20:24:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b5-20020aa78705000000b0068ff267f094sm3481738pfo.158.2023.09.28.20.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 20:24:36 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Sebastian Ott <sebott@redhat.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Pedro Falcato <pedro.falcato@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v4 4/6] binfmt_elf: Use elf_load() for library
Date: Thu, 28 Sep 2023 20:24:32 -0700
Message-Id: <20230929032435.2391507-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929031716.it.155-kees@kernel.org>
References: <20230929031716.it.155-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1627; i=keescook@chromium.org;
 h=from:subject; bh=HDRWJgiZi2B41NjfcoHun/GXVPB8PhMH+K8nRgD/QEY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFkNyd7onj53UAnvTrNuqjrOoqdzlhhnL6T0n4
 waDipxrCuyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRZDcgAKCRCJcvTf3G3A
 JgqhEACQaxzh9TUbPcDbZo8niTtocmDdmljr+QUAo/kUcZsO7WwVGlruTUeAl3DsFH2PvI/7f8q
 6Gzf2F516CRNsoFBvkxeJHFWa21p4CjiRwEYH+rdFGIQwe4ZXPrdSrcJhWVB35JNjqR8CK/aRK2
 NAJeh7WuuaTnpcDhFmPiXWQuRt1noAczm74SRZU8IZ06ucQ49FNFgl7FPCGA0RLuWRQDEc4zXaQ
 BQktUi2h0of64YlxMdZfk+SQMGz2lOqO7a3F8Zy9PazbSnHb5k2NrkreHnNxtncdID9uE6SiKy+
 JVJ8/BMveYU1W8I+asdhp8xe2CV19g1Qmlq4ZVCoeGxeV9OtFE+c8gjwaTlFdRjzRgfVqvqVmtp
 OYM3ExS5b6+tEeavoEpUw88foXpj9yoZLMwL8pVfsXc2FYIlPsrtaFfUyacQhttqevffosf/oUf
 bksChMr+i07cgy1L/yGOx/6wCfvU8HTwH+VMXDpSSowba7S7GbBmvxw9EtoVWjqJAGNdtQ6FvJZ
 6SXLe7ag42PtcuMWe8C14GuF1yYIcvu/o/vpy24R3zfZUovoJAGPuns5yKBok4/GV2c31zPoB/p
 5ZXXOtl28un+F7p/qF9lnnk6I8GbyO4YgCPqLeXph77PUUZfI4r38oOBt9/p+hKk0yQ+7nD6eH+ 8MpI/toIRLPKXkg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

While load_elf_library() is a libc5-ism, we can still replace most of
its contents with elf_load() as well, further simplifying the code.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Suggested-by: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/binfmt_elf.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index db47cb802f89..f8b4747f87ed 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1351,30 +1351,15 @@ static int load_elf_library(struct file *file)
 		eppnt++;
 
 	/* Now use mmap to map the library into memory. */
-	error = vm_mmap(file,
-			ELF_PAGESTART(eppnt->p_vaddr),
-			(eppnt->p_filesz +
-			 ELF_PAGEOFFSET(eppnt->p_vaddr)),
+	error = elf_load(file, ELF_PAGESTART(eppnt->p_vaddr),
+			eppnt,
 			PROT_READ | PROT_WRITE | PROT_EXEC,
 			MAP_FIXED_NOREPLACE | MAP_PRIVATE,
-			(eppnt->p_offset -
-			 ELF_PAGEOFFSET(eppnt->p_vaddr)));
-	if (error != ELF_PAGESTART(eppnt->p_vaddr))
-		goto out_free_ph;
+			0);
 
-	elf_bss = eppnt->p_vaddr + eppnt->p_filesz;
-	if (padzero(elf_bss)) {
-		error = -EFAULT;
+	if (error != ELF_PAGESTART(eppnt->p_vaddr))
 		goto out_free_ph;
-	}
 
-	len = ELF_PAGEALIGN(eppnt->p_filesz + eppnt->p_vaddr);
-	bss = ELF_PAGEALIGN(eppnt->p_memsz + eppnt->p_vaddr);
-	if (bss > len) {
-		error = vm_brk(len, bss - len);
-		if (error)
-			goto out_free_ph;
-	}
 	error = 0;
 
 out_free_ph:
-- 
2.34.1

