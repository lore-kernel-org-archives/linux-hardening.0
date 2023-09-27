Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347CB79C7
	for <linux-hardening@vger.kernel.org>; Wed, 27 Sep 2023 03:42:29 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6A56197
	for <linux-hardening@vger.kernel.org>; Tue, 26 Sep 2023 20:42:27 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c1e3a4a06fso73190345ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 26 Sep 2023 20:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695786147; x=1696390947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGhwDBPbCWZ00dYqQrvOzcYwuI2lZJAyT/mcJzKB6R4=;
        b=Gn8gM/3yYje83klxRkXj59yeqOCnHVvIfl5xp35mK1+zd4V5d3CWCJm4tEEz9YTVKL
         VNhqkn4Tq8YGWWoYhX7OZARQbCrLzrJyZr1NOwyRrjiKeHW62gkqrK3gE+PFxXXJve2N
         wxm8+6oDs5Uh/VRqIIlMzadsY06M/mBMkxju0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695786147; x=1696390947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGhwDBPbCWZ00dYqQrvOzcYwuI2lZJAyT/mcJzKB6R4=;
        b=SDDfI5AUV7Up+fneC6lXiEgr2FbYrvdt5beRR6oCTrkt0B4BwbkK97SThwRX3ewc46
         RvIALnHTe1xHMVOFyejGWLh+CvvqyM3+L5ePfJkKKkDKWoJygZRmi7Q7ESwlqQCgIR9l
         HTuOTNKQYF0Dprv9JXHdUzKUz9cZ2WRs09id+EXzwhpW20CZkAt3qCxxvGPvhcsCTcaw
         tQQZl4g8N9Vghx9eecPtQUI6gQb5BAKncRPvp1TC30IekKmFjl5cO/YKfBAb9osn3LO0
         +z2m2QHB5s7t67O/VJ+r7TtEnIqHyF53eMeeiR+sYDd/h4qIpLFTnvlCU6yV3rraIZy2
         F6sw==
X-Gm-Message-State: AOJu0YzVmsco8SUFxArY2ciz7AfnEm0zkoemGrVCpubdWEKpBB+LX2Ke
	DJin0n9sjN6XxKYjP3RKr5bZcA==
X-Google-Smtp-Source: AGHT+IEMRh07dxmRBvxAFfE5SwpELfOldF0XUoKYTyABrKV6bOgIMJW1wNCR/iQbnr++EfKTyUevcg==
X-Received: by 2002:a17:902:e74f:b0:1c6:112f:5d02 with SMTP id p15-20020a170902e74f00b001c6112f5d02mr741873plf.55.1695786147186;
        Tue, 26 Sep 2023 20:42:27 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v7-20020a170902b7c700b001c61073b064sm5974160plz.69.2023.09.26.20.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 20:42:24 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 2/4] binfmt_elf: elf_bss no longer used by load_elf_binary()
Date: Tue, 26 Sep 2023 20:42:19 -0700
Message-Id: <20230927034223.986157-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927033634.make.602-kees@kernel.org>
References: <20230927033634.make.602-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1738; i=keescook@chromium.org;
 h=from:subject; bh=G8gKivjP+bPsGdacm75CduzZVarN6sAt0dfrtCVUjtY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlE6Sd2BuLhX7iIAkgIu+LW3P3r4pxnZlwRaDRf
 vA/0AICBj2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZROknQAKCRCJcvTf3G3A
 JoZiEACxnnqWBzMIIDewc78beSt5xMPBmGmN6i2luWvAqAMFgVuNI0nDLE57tnMWit7yDj2XgJ1
 2Z/pa68XIcntr/l4Ox2lUHBpmeW82kMxXbte18Ecfkifetz5bSTNhT4eqz9iInkevtzRWO3uUpq
 i3Sjs/gANX1ErFrzlbJdGorFoQ2WChDbSXKcGCifcF+7ByszsUMc7ciRkTfJ+c69ymHfkIjFnB4
 NABq4TtLUWJgQ4fWWHfAXP7ibJqTV+vue/6haJy4EBtrPblhUpyXmaPHPlLFqfB4NWp67PspCGn
 Xt+4d8whIqgJJO12woWoD2kad16SwfEWwy6rtb5glKxP4P8lwFkwUY2npYvmLb7oLp/JOBGWtT4
 zN8stmcyYoHO5JH1fxDZ/M4IbnvhDjIyT/v4bcz2Sn/t26aRdaLx2dvl1fz3GLavqQm1IhRhQ+f
 XxYEJIe0C5lZ5EdXJrERty9WadxoFIpFZuQtqKSIfGNDtWQIQ1fwZPbObiOfsYvT6LcbQLKMUG1
 /xXJ+v8+u3jW+HTFnzZ+EE7ig4RRSprVCTd5QEzX4RbC8KXboi2yMozBdmUhOTOlkUJSU/uUZ1+
 VZHcMo6rE0t3wu84BkMjvDVBAPXSGtNLDJ9xoujVrtMltIzQDhdxPz2ce74LXQ2WEx1wn991e8y t1zbNpVW5qc63Kw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

With the BSS handled generically via the new filesz/memsz mismatch
handling logic in elf_load(), elf_bss no longer needs to be tracked.
Drop the variable.

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Suggested-by: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/binfmt_elf.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 2a615f476e44..0214d5a949fc 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -854,7 +854,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	unsigned long error;
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
 	struct elf_phdr *elf_property_phdata = NULL;
-	unsigned long elf_bss, elf_brk;
+	unsigned long elf_brk;
 	int retval, i;
 	unsigned long elf_entry;
 	unsigned long e_entry;
@@ -1045,7 +1045,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (retval < 0)
 		goto out_free_dentry;
 
-	elf_bss = 0;
 	elf_brk = 0;
 
 	start_code = ~0UL;
@@ -1208,8 +1207,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 		k = elf_ppnt->p_vaddr + elf_ppnt->p_filesz;
 
-		if (k > elf_bss)
-			elf_bss = k;
 		if ((elf_ppnt->p_flags & PF_X) && end_code < k)
 			end_code = k;
 		if (end_data < k)
@@ -1221,7 +1218,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 	e_entry = elf_ex->e_entry + load_bias;
 	phdr_addr += load_bias;
-	elf_bss += load_bias;
 	elf_brk += load_bias;
 	start_code += load_bias;
 	end_code += load_bias;
-- 
2.34.1

