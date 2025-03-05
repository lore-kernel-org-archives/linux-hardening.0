Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7658018CBE8
	for <linux-hardening@vger.kernel.org>; Wed,  5 Mar 2025 02:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141052; cv=none; b=mMR5LTWilasF2l7UiEPn7/kIZAJcyO5EAEMBiF39V8NHH5laEAhzl8+1JcxJySyzDvU8qybTMTSEdXzeggtflUKwwcSiMpfRRBhZKwcVj2JjgkrMR06sdsOSwb2j0cRuvG5ZTAdztnoeAf/PFD0RMHDKLkmsezLkYgzdOsHXyis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141052; c=relaxed/simple;
	bh=92tjd51ZxlOW6iKXAPr3x72R2NqaT4p+LyMw3QPXUtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWxrwbI6BVYpVRxcwRaxsSif9Sxo3CX+38XAa36r1MFcCHLCXZg9BvYqwOzuzT4wQ3V2G1LgpOClSdHEPq6qmbk7QUwFM4/Fp7qGOcw9czAnDvmy+CEtBJe2bnVw8hmr7IDhLWQmP5dX++Y/71w13PemGgCMLTChCAYXyLJc1w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E/Vh7wRq; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E/Vh7wRq"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dbf5fb2c39so762393a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 04 Mar 2025 18:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741141049; x=1741745849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GUuWdJKxZ3/BvY94DN0LEqc9J/B6h1FHzMtAHgZb/M=;
        b=E/Vh7wRqVxkMZ+wUn6gWYwv21ASEkrgMxBDITGLZxksCXvscZbl1VNBLnFimoZshcy
         LM5947BkIiIXZ1q5QiAIQlGKZDg2Us2953USRmBhaTr72Iy71NvBaOCRrKH5sZcKK1AL
         j8K3mvAxXObXdl2X3dxed6jrWpmQxDj4/Vy1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741141049; x=1741745849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GUuWdJKxZ3/BvY94DN0LEqc9J/B6h1FHzMtAHgZb/M=;
        b=C1x6GnAv64PT6bfll7PBWfpOey/aefaEPRS2sk1PWg4d1OBCkwKGFgfgheQHxNEm04
         aKRn5HEilggzWU4S6caFRXF8b7SBi9J38dOifYlhUSgxsNH8aMLe6Cg9qyIC7Aa/nr2m
         +DxvD7tV1uMsqZMrfKCjvaofu1OiqZjkQznn1eJP/BDRwHUxu1Eaj7m3j3zWeo38TTzB
         E3K3xQ4u78SJgdmB24PNAsRwxE+twjUDCyxY4ByhYzH5uz8b/6qA2E7K1J4nxA5vqoku
         UyQwl8Nf+PMvcVQIeAz3K+ZBf2vS95Kd1yQbnjgf2N5GGwEyQsdvJbqzdmnL4VeSrnkv
         bjEw==
X-Forwarded-Encrypted: i=1; AJvYcCUd844DM2TS82vcTCxu7yORO+boriZ9hDfTabPgwHodQTTXQ8AOXiENe5l5/+EvM4mSqWoPnQt0q7slMKi/nfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl2JHOCbaco2ziDyTBa2tjcyEx+Mh9Iym/XAPIVNizMufZo2r3
	Cbl+rxgy975gPUgJMeYmIlEKVdmZM5moC1H8p2wF6wdC7thMkeN6/6c6ycIiUg==
X-Gm-Gg: ASbGncviWxzGSHB5maGZLe5FXmr5ghqThuP0Q5rJwBTUzfSpWwr729rT5iWE0KNDTS2
	hxdc+GQ1H3EsB4buTFlYrsjToUOtQuO5WA7b6/jdDTOKKxjnm+fKQjk8OfZ07ncDZhCorVOmbhC
	5/fWlDi91Ay4zS6zJkw8EML3xntR79oGJSAeackOcTi9HbsmmNULiMflfBQj62aboqfqPqDjB4H
	BONpXyr8QcXIhCcYe79V8hOL+ptRLnQaMU1BMv5wigrvOCSjUUErwbYwEh7zv99S1ODx1GHVq6v
	xRe0q466e+H+3ypVxhM2tG3ByoYRchjhQPr/VZt0qdJU2pvpe5g/oq3DBZOAE4DYiYEVvEq+OkQ
	X
X-Google-Smtp-Source: AGHT+IES9/6N/5toY1Cf9aspTXKgI3/7p+xl7igipg0af9FRFEO+OX7pUZ04JGOESjzxfe8IxQnMgQ==
X-Received: by 2002:a05:6402:51d4:b0:5de:cb8d:1c82 with SMTP id 4fb4d7f45d1cf-5e59f3a84f8mr383796a12.4.1741141048576;
        Tue, 04 Mar 2025 18:17:28 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a55besm8891211a12.72.2025.03.04.18.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:17:27 -0800 (PST)
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
	linux-kselftest@vger.kernel.org,
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
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v9 5/7] mseal sysmap: uprobe mapping
Date: Wed,  5 Mar 2025 02:17:09 +0000
Message-ID: <20250305021711.3867874-6-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250305021711.3867874-1-jeffxu@google.com>
References: <20250305021711.3867874-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Provide support to mseal the uprobe mapping.

Unlike other system mappings, the uprobe mapping is not
established during program startup. However, its lifetime is the same
as the process's lifetime. It could be sealed from creation.

Test was done with perf tool, and observe the uprobe mapping is sealed.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 kernel/events/uprobes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index bf2a87a0a378..98632bc47216 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1683,7 +1683,8 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 	}
 
 	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
-				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
+				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|
+				VM_SEALED_SYSMAP,
 				&xol_mapping);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
-- 
2.48.1.711.g2feabab25a-goog

