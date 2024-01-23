Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2C615EA8D
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 00:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970174; cv=none; b=au3q3Qyx+kIyS0H53lhhyVNIkYM5T1c4T8vVQveiI4Yf2bVPNx5Ka1KJWiQcQQ3M6pO6/T6s2JDjqrsQaIW+BzIao4TEYcaY1zPaqkq1kbtH6lPAiZ2vm7pAoWTwLDod/4JVd2sVCx4m91nDn1FQWHIY69hqo7mY7w869iHz4Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970174; c=relaxed/simple;
	bh=O50T+ehgWO04+/PTwK/XEjtbdWM1siGuxiWx5Y9VWF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aUWf+p742NilavEHNOijQR79NWUm3Pwa13AtVWj1siJz0nhOdvao6k+hgNBojtpSXW1EoV1zWtNiAUgufguxsVXOaRnMwfmxF42mdfZ789EwmGHagyznyOnZHR9gO+MkVr6LaTMiSfxkOyoUAZhhPkOLTldIfT8NQDYE5DkqHGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HFC2D/w8; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HFC2D/w8"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5999f3f6ce9so341064eaf.0
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 16:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970172; x=1706574972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKixWzqfowMzvUX6r00bx/1VlD3LFsId3tPJIJRuIR0=;
        b=HFC2D/w8uclQu1y30dfKDrOf3EDdjqB5rPeIVnPGsAqsah4CP4enAkdphiBcykqKpz
         EAo95xODZqXsiNOS4A+vkjjOuGBI+mWHfVKsgsH/IR798pDBAST9TLl5ibXCe0VYwil3
         AGFLKlu8M/+rFzg6fRtzH7YaH9yB+Xewexpk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970172; x=1706574972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKixWzqfowMzvUX6r00bx/1VlD3LFsId3tPJIJRuIR0=;
        b=O/WOiWWphhqJ9wbaNJtmbMq5dPcsaITWqXpGspwdd7s2lVUezhojcrjYYVfUwDMDVG
         rf/fcmHWa/enuimj6kKmicH4zEZ8SDF0skBPu5XFB5EXHOVTOYMftM7tyREcfk8DlYXG
         dC+GZSfRaalLBHRWBWnbg8CJGKhckE7T+Vqi7KB9V7EqTJdxwukpuYO+nmDyZBCxDckA
         flcgcC5eLFO96xutaM1mmiGeuQDoV6DRXyI1c/hA0qrMcsc2rfwZfzLlcEhmMEqGfGV/
         p5ptIybc1R6x/JA0AT7rstgHHF9n7BQIYhCm0sAh9n0/pzChHxDrVAWyUBszRxqxwk4D
         VIUg==
X-Gm-Message-State: AOJu0Yxtt2eMUBohMbAEwFYA5yOVmpMf/8bX6icb0e8sKcfrYOA1gcAy
	iB/54fN/yUKpVSHt2lgTtaE0O7I7jJ9dJL9kXvulLFYF4J71pJpHDu+9AZe2tw==
X-Google-Smtp-Source: AGHT+IHGoYZGs2buOqQkiIhEJDExn82aWCutmrbis2Hs9LbtRGU/qouIkWFMc0AMtn7Yh4iOMq5Tmw==
X-Received: by 2002:a05:6358:719:b0:176:5d0d:4c6a with SMTP id e25-20020a056358071900b001765d0d4c6amr1659265rwj.29.1705970172214;
        Mon, 22 Jan 2024 16:36:12 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sb12-20020a17090b50cc00b0028cef2025ddsm10440436pjb.15.2024.01.22.16.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:36:08 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/82] dma-buf: Refactor intentional wrap-around calculation
Date: Mon, 22 Jan 2024 16:26:50 -0800
Message-Id: <20240123002814.1396804-15-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2493; i=keescook@chromium.org;
 h=from:subject; bh=O50T+ehgWO04+/PTwK/XEjtbdWM1siGuxiWx5Y9VWF8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgFQ84pwHJOpkJM7cBBjZQ+dyB2q0GyyRoUN
 phvzaNFVByJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBQAKCRCJcvTf3G3A
 Jju2D/9msHfBekreecuP9d0fYucPYwOuP/5LSP35dnh1uQL9A/+S6Af8H21MOl+me8AiycS0dk2
 0Nd3au8vn2Nl78aIRV+C7DFP3rFOa3KdUfS/qJRRlEE9tAeJXHJECtKEMp7t9CehEJHacXZIT45
 r8trE7qdtUW4JMqG9sya72KThUcsRNHfVbJQQ536OU9zvx/NhCHm1onTJ2C9o3h+1II4GGGKmlJ
 1zJ3W0eVSeM24egFgMxHcqvYy+Cue+A5RfFDwojwaBnfmWhBtXesTBwFJTsQanPGWE9JxbSxsbz
 CglnWiNPjq9pDs31mtBqwR8DgmONGfQIo9NhxiQ+1Cdjx4VWvmPO49vDUmd1yNPDgbj/QxI/cRq
 ARVjAjmWNHxVGH0lTnwUrrDgtkF+R44Iuhdim/nvBSBZrpaG8yrRA+4NFpPtsZOwVdXMSnfI7wQ
 gE0joPsgazTDQFUqzcRtfyqrcvYXIeIiXdh/Y4Ej/km9tQ0/0DLxTbTCqoGtnoSuEVfvCzs+unU
 tfzaCnbjn45fawrtcGUb6pVdFQzPQRUw9P1lmZqDc+GxwioZP4dCvcu/bG0+essTAlw/09sdKqu
 O/ci8K7u1AkUc7NcLes5iGCNf8aWaXBCSkX8vB/mu6PUk7piIN/1FYcQTY+LYW8Hq5cLwHBPmQn wygzmyMo3p0bqsw==
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
wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Christian König <christian.koenig@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/dma-buf/dma-buf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 8fe5aa67b167..3743c63a9b59 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1458,6 +1458,8 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_end_cpu_access, DMA_BUF);
 int dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma,
 		 unsigned long pgoff)
 {
+	unsigned long sum;
+
 	if (WARN_ON(!dmabuf || !vma))
 		return -EINVAL;
 
@@ -1466,12 +1468,11 @@ int dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma,
 		return -EINVAL;
 
 	/* check for offset overflow */
-	if (pgoff + vma_pages(vma) < pgoff)
+	if (check_add_overflow(pgoff, vma_pages(vma), &sum))
 		return -EOVERFLOW;
 
 	/* check for overflowing the buffer's size */
-	if (pgoff + vma_pages(vma) >
-	    dmabuf->size >> PAGE_SHIFT)
+	if (sum > dmabuf->size >> PAGE_SHIFT)
 		return -EINVAL;
 
 	/* readjust the vma */
-- 
2.34.1

