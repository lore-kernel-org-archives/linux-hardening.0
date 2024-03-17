Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923101C288
	for <linux-hardening@vger.kernel.org>; Sun, 17 Mar 2024 15:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710688057; cv=none; b=ZoFFuWrNU5h/fwWIS2khcambiWxNazeFXulX6fy61ieJVy0uaFnmJl5HkchX+Z+hBt7rmTTRM9HfsWNcEmfoCXPGS4ONaB7AZ1JIksQrsYTgTqzwnqnXtiMRT4QnnkPj4EQjLXmITCNSiMzSiN452TbzInmRWKxVNPCLmHF82kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710688057; c=relaxed/simple;
	bh=IacdikwGeETM03FPof7cc/AY/6hLvnXxuleazQHPrek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ByH8M0kxocDFC9BGSEVJnMGoDBp7PKGM1X2x9pruuBJCDBVv3VROsTig9LDvZkDoIAbUPf0t3gHqiS0p6OMayXPmX6bIlby40UgjHVNNsdvoS/YvJmVBE5encg8GneR0Uszmfug3tBfvhw0Rn8oEgcPXjkispCCqVV5Y+1AlTL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WkP7kOSc; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WkP7kOSc"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cedfc32250so2601796a12.0
        for <linux-hardening@vger.kernel.org>; Sun, 17 Mar 2024 08:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710688055; x=1711292855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hhICYYV1g+oDZFsBzqUaHWt+HsbjmOKz1L+K4AX4MSo=;
        b=WkP7kOScHjvBNLENFHPG5gu08Tqur8WJkPXrh32gHq2lAvVkiQXUK/QrAk0k7grmHy
         neqFxiSIHO5TRr3Nqo1pTiMZCrrZsK/DC4DzXY6Nh1yEaezEfnyI5EY9L513wj1QgVk6
         ntyTcR/H5zM2njrlHTq/RZ15vgYJgMAExe0wMA12Kjpo/gGM0HydbumrzQtAzMbQsI/v
         U+XEmZsWjLYf9q4VPtSMZ+qAqNz8i2Qn6P5lhfVpUJYzrYVkCGz9lc7hfyZxL1gYQm0J
         f0QW2DY0f20YZDrpmVtR9Smt/uHG0U1QMwEaQA3DJvrgr773ZLluCazWC7BAkKiXNq1Z
         YvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710688055; x=1711292855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hhICYYV1g+oDZFsBzqUaHWt+HsbjmOKz1L+K4AX4MSo=;
        b=UC0zyIyb1+v6BO3o4a0xnfPAuiwiljgLwFEIpBhitORrNfcLSJCzbSovDGSlmMfnsr
         4WKC656cesri4c4jWJ/ylvDDep4fx+WG9f2YHjwBsYebSnnTVEctBPYxfpQBTmP7tSmh
         +ZNEHMYpQ+zOhd84k6pOxvLS+JnucG6OeIJbDn6li80IlKWASsBOpUkcJ4Fh2wjCHS//
         ZpNH5GbPI/cFiTTvUTzwda8pxjg1mK+Mt3YS78N3PQi3Xu70RIhXrN7pmVQF6JJhGVu0
         +1YAPhkUBU81zBQtfqHVMTqVhaJsImdCA32xCvd+AVl2qFmKWmmwEUEDmHtpdyG8+bZd
         KbOw==
X-Forwarded-Encrypted: i=1; AJvYcCW8M87kDJzzKXKG5nSSQ5A3OKYeEgTw2bNng5aTLFsthf4klscJXH7H24+dOXDMmqWkzghMYFGOY+Mevy4/s5pFpO/WoU0A3rh2euUcAfg2
X-Gm-Message-State: AOJu0YywcV+/ldpsuBEog3ftMMIbDknl9AvcCTbUaE7oDuS9qOHbDzbb
	h0iy3fzoGvrv7oeS4XgiG2nKBxuetBBBYm+5agma56HWUfcyDjgQ9S4FkKN9Pes=
X-Google-Smtp-Source: AGHT+IHxGaa6Pn6062Ac3witWXSLzJOmdl6pedhlmppjiYLrKqco1HzUbQZ8yF7evP2SNB9JcqLheg==
X-Received: by 2002:a17:903:264e:b0:1dd:e13d:6834 with SMTP id je14-20020a170903264e00b001dde13d6834mr6845647plb.41.1710688054845;
        Sun, 17 Mar 2024 08:07:34 -0700 (PDT)
Received: from C02FG0GJMD6V.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b001db5ecd115bsm5921296plh.276.2024.03.17.08.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 08:07:34 -0700 (PDT)
From: Guixiong Wei <weiguixiong@bytedance.com>
To: keescook@chromium.org,
	tglx@linutronix.de
Cc: jgross@suse.com,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	gregkh@linuxfoundation.org,
	tony.luck@intel.com,
	adobriyan@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	weiguixiong@bytedance.com
Subject: [PATCH] x86, relocs: Ignore relocations in .notes section on walk_relocs
Date: Sun, 17 Mar 2024 23:05:47 +0800
Message-Id: <20240317150547.24910-1-weiguixiong@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit aaa8736370db ("x86, relocs: Ignore relocations in
.notes section") only ignore .note section on print_absolute_relocs,
but it also need to add on walk_relocs to avoid relocations in .note
section.

Fixes: aaa8736370db ("x86, relocs: Ignore relocations in .notes section")
Fixes: 5ead97c84fa7 ("xen: Core Xen implementation")
Fixes: da1a679cde9b ("Add /sys/kernel/notes")
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
---
 arch/x86/tools/relocs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index b029fb81ebee..33844b33b8b9 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -746,6 +746,16 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
 		if (!(sec_applies->shdr.sh_flags & SHF_ALLOC)) {
 			continue;
 		}
+
+		/*
+		 * Do not perform relocations in .notes section; any
+		 * values there are meant for pre-boot consumption (e.g.
+		 * startup_xen).
+		 */
+		if (sec_applies->shdr.sh_type == SHT_NOTE) {
+			continue;
+		}
+
 		sh_symtab = sec_symtab->symtab;
 		sym_strtab = sec_symtab->link->strtab;
 		for (j = 0; j < sec->shdr.sh_size/sizeof(Elf_Rel); j++) {
-- 
2.24.3 (Apple Git-128)

