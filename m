Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3148020C009
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 22:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740437574; cv=none; b=Yj76H/+xHswlYaI+o3ISquDFCAXRWvL/gHTo+l8RXsWNMMfoJlZw3yH7bDQ2EZRKeRQueNm3HQls9fKw1n6ETQ0rr9EPG73l5bj5+f5xQx8WoswEYuRlU/DbB34qAtuL9fxpiVqrjTbzCCfnCvs0DxdRU3CdXT/7hOKlZEaVMIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740437574; c=relaxed/simple;
	bh=3yyGx1/qbWOwaz7n1P3h6mE9HnHTR0hKpDC/6427r/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUDouMl4PQLor3uua0rJHrLOa7dqnfjFVPeSUF4mqSL9H9Oe7uzwpzF+j7xiGtTGN85bBO/5tiWR5NCpp/KMu+nssAjHq/ETXDG4NILgIwc8KetMe7WdAx04xZHNLgntItZ/nZqjWKhaNKMlDAirWgG+zu+Jbm3sywn23v9WWs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eK1raW8J; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eK1raW8J"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220cd9959f6so12644935ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 14:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740437572; x=1741042372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JxfqC34JK5pAuQi2kIh7I1xgd0YTjcXZqYM95ZHnLw=;
        b=eK1raW8JNsYOQOtcpNo0y2Imk49/hd//ZKeYo0qEeTEbAoLvYeBopRePA2dTkIR+th
         bHV7fzfm2WKbKqKsCAK3NX1PnIraL9MVvSA4Vy4XPDNNK+jo0Vbau4vI/Kz43QvB5FKN
         AUMG9ppnJIUKX1gvDi5yKNHGQzIHT36+9LnJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740437572; x=1741042372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JxfqC34JK5pAuQi2kIh7I1xgd0YTjcXZqYM95ZHnLw=;
        b=UVzTheUAtfJNQZoQrLhrRyc9LQxNA+XMrqvYw2i5QLRQJIcWxAec6F3kKXXVDSyi8+
         iGAQ0y+EPwRLRAdyz+g6oYiSDtN1vOoEQDBZcOyoDO9EybeZK8QT1qlVNu7xQm5v0tYq
         8ytjs8nB6EnIjPMvoOpK/zLoIv9E0UJ49Ed3NjT6xPqwf8uUncZnEswdZiwfdvlDW8yZ
         D4HKgscyGZiNNlYzeR1kTs4sBJMTapB9dsuXcEZut4IWE8XfHh8cM56VSoRj1H3H/3lE
         22g9De8DrRZCERukH20HNasA8e1OmLpHNQuAgbCzpyA4l80Mr0SQmOigQxuHbjp9PKrt
         K7nQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5jFKtyKO+NzkECjKjGkt+R5mp2gnJjNGyAXvxJ82Pp8ZXr6/m42ZYovvTiqsqr0zXn39GKxsnqwXZSU54xJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YynH4jYQir+4p45ePROVSsfCYV7q6gsj+1TUkbsdWwBvvyKsJhC
	UfqsZh3sYl6AqxqZunckLKjikxGxw+pnBNEaoG7bTfgWa6tvfYJlvWDTVH0yKQ==
X-Gm-Gg: ASbGncsyefV18qPJa5uCID2z4/bGD0kxXPDpr/Xe5zaMvfXthbPfktorgAkL+l8OQel
	tKjpDXvq2LEV2KJBI9jSGk/rcf2p13AUatBtJM3bemcgjD3EC1Y45gHxfEhraxHtaVam0uFSrO7
	VdI7nCBuj787xAxmqdGfIgnRB/lv8xqKYgm6CZdJD2qipkRoKH8OXu0vDZya4rQJ0HDH9WeE2HU
	yAYFSt4G/TbV2hNnbJ/Z78YHbknpSVPBsBA4ADSfkaXpJ8/q3ZC4pd4LBevXdBLM05muVqfMgrt
	sTphPdpqDj9UES6fjAZ8+7R4/I5lQ1gt4ZMEzlo0WMw3kXVG4E+G+nWt2DoY
X-Google-Smtp-Source: AGHT+IF5qFqZ2XMAkd11tZhw0TNlD5KvpPShH7QiyA0ymh3azQkuml1yZnRKVOO/3ENETx0NVF9uNw==
X-Received: by 2002:a17:903:18d:b0:220:f181:4e70 with SMTP id d9443c01a7336-2219ffdfa48mr97695445ad.10.1740437572458;
        Mon, 24 Feb 2025 14:52:52 -0800 (PST)
Received: from localhost (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2230a095f02sm1313475ad.152.2025.02.24.14.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 14:52:51 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com,
	avagin@gmail.com,
	benjamin@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	hch@lst.de,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com,
	johannes@sipsolutions.net,
	pedro.falcato@gmail.com,
	hca@linux.ibm.com,
	willy@infradead.org,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	peterx@redhat.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com,
	Jeff Xu <jeffxu@chromium.org>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v7 5/7] mseal, system mappings: enable uml architecture
Date: Mon, 24 Feb 2025 22:52:44 +0000
Message-ID: <20250224225246.3712295-6-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250224225246.3712295-1-jeffxu@google.com>
References: <20250224225246.3712295-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on UML, covering
the vdso.

Testing passes on UML.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Tested-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/Kconfig        | 1 +
 arch/x86/um/vdso/vma.c | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 18051b1cfce0..eb2d439a5334 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -10,6 +10,7 @@ config UML
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
 	select HAVE_ARCH_AUDITSYSCALL
diff --git a/arch/x86/um/vdso/vma.c b/arch/x86/um/vdso/vma.c
index f238f7b33cdd..fdfba858ffc9 100644
--- a/arch/x86/um/vdso/vma.c
+++ b/arch/x86/um/vdso/vma.c
@@ -54,6 +54,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
+	unsigned long vm_flags;
 	static struct vm_special_mapping vdso_mapping = {
 		.name = "[vdso]",
 	};
@@ -65,9 +66,10 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 		return -EINTR;
 
 	vdso_mapping.pages = vdsop;
+	vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
+	vm_flags |= VM_SEALED_SYSMAP;
 	vma = _install_special_mapping(mm, um_vdso_addr, PAGE_SIZE,
-		VM_READ|VM_EXEC|
-		VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+		vm_flags,
 		&vdso_mapping);
 
 	mmap_write_unlock(mm);
-- 
2.48.1.658.g4767266eb4-goog

