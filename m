Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED4356463
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 00:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970158; cv=none; b=T8raB0kQqYeWvTvVhXJ5e/D8bB89v9GvxIOZsNbfHz4N4ysSbczaNXcqei9XErZYML4qUyGbYWiko3zH69hNVoAZZuhTLP6wDL3iOvviHUMarx9WwvjZXH9hFpXppu1OdP5k7GsVyXgwXBHLtm428xSlVYj1Iwg1EDBASE9DOZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970158; c=relaxed/simple;
	bh=X+8lYZfwausQ7ppEEJSi8ujVkOr46HTxCp5e8PDYgLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eBN9sNGQryE0IHiHpL8s2gskH3kKDA2crUz9MJNwZC+JlLsD2wK2bGc51bJPn2PwUXwfjKBOLCdDayXlq1HeAoCTaSSsE5fTmIh7eYExEkLzgW4SAlBnULRQ2OxupH98oYi5iv+F01AI1ZeW++WiTQ7DzShTApkBs3Wcr1Xn04M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lOwaZOn2; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lOwaZOn2"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-290b1e19101so858464a91.0
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 16:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970156; x=1706574956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjn3WA13frGFh/So+bkUR88Se/B2ZjAIsqCTRdISoWQ=;
        b=lOwaZOn20gj5kSl4RrIPb1yD6KxGoafGt4iY7aYFicxNRh08Poj5519WodLNdQiZ3F
         gLv9FkDc7Q/lLkogJhaihWUVmKe+EQwHxPX2A3rP6y47OWkbqMNaYWqKC2kY38juSMoo
         KtF5naYTw5aUPgF8V5h1x/1cEJcRnkq+2xRtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970156; x=1706574956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjn3WA13frGFh/So+bkUR88Se/B2ZjAIsqCTRdISoWQ=;
        b=RRY26CQq8DPqJNbXFNPQhRx/vpCo0KI3JiKNlNLeqFZDAHnivwFiR1FprRBhkrnRl/
         Rfc8sSkfDM1pw2n9TIicKmJ/2kDHSLWIFTpQr6HqIJyisoEbGehymbrQrrHe1HE9X5Pi
         vFF6LK2BWsTv1if9/WJtjlWzqLQ03ozsBq9I55nNG4lLB145yXmTOIeP0SSMa+mwn8Xh
         YG1jOvxWEqJ4Z0svI2/2fDWVGxP9JeSV3nWYsHeKaN80EDahX27rIVzOid/guYm1SId8
         vRQ69GnDIif0Tg5G35ogUKCk5RDuFpao7got1dwgmXDodu2IRXLQtXgrtcud+UI0lPhS
         5UlQ==
X-Gm-Message-State: AOJu0YyaM9E2bqy5n9GxqiBF0v3QO1lQOCUbo8oAmaLhH9rxm0j5hx9Z
	9hMWSRRKksNuKvc4agcvGLzWRmZHPEG8aJzsCAE4VAjouyrJ2MmSBtn9Xbm0Tg==
X-Google-Smtp-Source: AGHT+IEyfTuL6aTwKFxTD2yVDhKLMQ/yhYL7MnyaB0lQ00kHUz62vvrrDFMKYyYwE3mOokyKej0s1A==
X-Received: by 2002:a17:90a:88b:b0:290:a33c:e6d2 with SMTP id v11-20020a17090a088b00b00290a33ce6d2mr2368564pjc.49.1705970156038;
        Mon, 22 Jan 2024 16:35:56 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gb22-20020a17090b061600b0028ae9cb6ce0sm10407877pjb.6.2024.01.22.16.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:35:55 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Liam Howlett <liam.howlett@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	linux-m68k@lists.linux-m68k.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 27/82] m68k: Refactor intentional wrap-around calculation
Date: Mon, 22 Jan 2024 16:27:02 -0800
Message-Id: <20240123002814.1396804-27-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2444; i=keescook@chromium.org;
 h=from:subject; bh=X+8lYZfwausQ7ppEEJSi8ujVkOr46HTxCp5e8PDYgLw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgGCBOFjblHeST3/ZilwfcWPfGLaZV7X8YPW
 C79tN/SYeiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBgAKCRCJcvTf3G3A
 JrLrD/9imhNacUFtEeErviKwZFpQOrHjRz9qfDPETHNojaoiOgYqepLMlRb2Ro9DVU0O/SNoauJ
 XDvSMCA29L49m19UUqfBC98mMaq6pMQyS1NYL3dNN2wfigmBHbgxSG6nokdw68ERa4QFn92dDwy
 bQwrdR1ku7ltobTrb9kWZP81HzorXQ53yz5cPLqMXn5u4vNUjxoZ6WlRUSJ/tEDJ085Y0o5sge1
 LBmfMY3FImhVAZxGzzY3zyjplajEiXwl2vKYZk6BCTy8gXY+veeoOEVDOnnIN2a4KvDEPyaaxot
 HR2z07RN8UtX6TH5kmJTHOWFe84EDKOCqi2aWFqGYAyRDkFpP0wty9kY6+0AC3gehj5w1ti2iiO
 NAD8yNoNlLtKKkMtjrfR6XrpsyZ0rROiAJov2mqM1I/OL4pV/aRK6BJYWmZNDTosqLgl+L80IWY
 p8KuezBrvoHfw0WGYNrhqdeJVZbU2Wdu0pHD+Yt4QzANL7JatZjIrCkplcEqXEtd88+vkizAwgN
 GMtPKAqJ8N2iL3FYauZ/MtkWupQDFcsJCs+zJtK0/ubZyvgDoPrepWguwDHZl8EiGA060zaJtRc
 AgqRGJkK2LmpBTJ9DPQPYtCnuBZcfKAOHGS6bIVCqHi0QsU+3CTeDiscqO9J3/m/SF/x7U/Q5xH NVY94wexVhKaRdg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded unsigned wrap-around addition test to use
check_add_overflow(), retaining the result for later usage (which removes
the redundant open-coded addition). This paves the way to enabling the
unsigned wrap-around sanitizer[2] in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-m68k@lists.linux-m68k.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/m68k/kernel/sys_m68k.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/kernel/sys_m68k.c b/arch/m68k/kernel/sys_m68k.c
index 1af5e6082467..b2b9248f2566 100644
--- a/arch/m68k/kernel/sys_m68k.c
+++ b/arch/m68k/kernel/sys_m68k.c
@@ -391,10 +391,11 @@ sys_cacheflush (unsigned long addr, int scope, int cache, unsigned long len)
 
 		mmap_read_lock(current->mm);
 	} else {
+		unsigned long sum;
 		struct vm_area_struct *vma;
 
 		/* Check for overflow.  */
-		if (addr + len < addr)
+		if (check_add_overflow(addr, len, &sum))
 			goto out;
 
 		/*
@@ -403,7 +404,7 @@ sys_cacheflush (unsigned long addr, int scope, int cache, unsigned long len)
 		 */
 		mmap_read_lock(current->mm);
 		vma = vma_lookup(current->mm, addr);
-		if (!vma || addr + len > vma->vm_end)
+		if (!vma || sum > vma->vm_end)
 			goto out_unlock;
 	}
 
-- 
2.34.1

