Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD2115AAD7
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 00:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969752; cv=none; b=RUs5ocwdl+NQHtSlEeaSueV0FCwhNAi/6T3l9Urqz2lTjiBHgaat/N4B9oa2cUFru5GF6BTwNqi6cd/F5RXOmQhrqA/ZdqtEIyLszFDKEwxMgPwWCpYqXYkku0P4l75U/2KNWrwPbF4ZHXu/7/qf8bdZ+tTjYbIldXUsXk3PrHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969752; c=relaxed/simple;
	bh=uRCkCvFsyXVpf/RtG8GCWMvVuyi59RVZ9Ft/3XBajpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uBBOEw1jBHKS1H1ulBF0XteDsT0cvZchFA0L37XBGl0bArFtWSukddMTK/jZHN3Tkk2jn/xhpE1CFzbResNslt0TotrTp3rOzLK7z/Ag9k4zRNPmJoEo+kC4FV/cUBsgT1SZOuyjmTtgWfWuYW1TOiRfhxt82mVDXA9S4uhzpB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HTDd9vmf; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HTDd9vmf"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-595b208a050so2339949eaf.0
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 16:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969749; x=1706574549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbagvK/BQHg13GLlZBGhyNRG5sgL74HVCqkvwUtdz7s=;
        b=HTDd9vmfMxS46oacnYCdJMd1aK63IRP3LlrUUFqEmg03ZV/vGdiTTd7LvPfz8BBW/L
         qr9ZquIFSeKht3Xb4VOrKDkGjfVkrir3csOYYaTazijM+1pWg0U4va6TBbNZoC5aksvs
         g15ZsvMVBstvuzMjdMpI+7xwTdA22rqtWlqQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969749; x=1706574549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbagvK/BQHg13GLlZBGhyNRG5sgL74HVCqkvwUtdz7s=;
        b=oPSYFfR6/pLHIdVnbr8KgFqdj83EBLRo0ZeJjT1F3ERvYTS+ogWZyxcVK3EM9YUFts
         w+ogETMHNxxEM4yPW2q7jsk/E+MZI8qac8HDBEaWcEYzBfKUJ5kutOU/iIxMdoFx9WqI
         Y7XpX224AY+z21z9Au2GUhM3c4FNTzsZoxeUjBRpNS9WeBhdEz78c+8LvfnQgW6GDABL
         ArQDEU27u7XsEoGxDTmUixzY+M+j1L0WOPVWd23rgJ9z4Dep4y69N/gIF5WjRq2N6rs1
         jin6FsA2Fu5xnZ7LoHWhItORXMbplZFJUUJ8aevslUcEe1ya8fBrnb795j8ka2Nbqqm3
         Fxiw==
X-Gm-Message-State: AOJu0YxgQMtyc/rPsQapXV6m16WzoYxjc8MINGuevkTIuE887yAU8DpS
	KaD3e1BtuzBPM7vDbfw9NBj9KtaiABlGyXPQJVxLf4+5XIry/6uF2ww2od7b4w==
X-Google-Smtp-Source: AGHT+IE3YZZUAbSaTl6FBGOnqrae/sTpKUCuHtMEUe62rjmX2GkYQhqBolPrkv+LnabYxlrO3YWYvg==
X-Received: by 2002:a05:6358:916:b0:176:5d73:376f with SMTP id r22-20020a056358091600b001765d73376fmr1694130rwi.48.1705969748687;
        Mon, 22 Jan 2024 16:29:08 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h3-20020a056a00218300b006dbd341379dsm4094216pfi.68.2024.01.22.16.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:28:53 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Ben Skeggs <bskeggs@redhat.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 48/82] drm/nouveau/mmu: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:23 -0800
Message-Id: <20240123002814.1396804-48-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2285; i=keescook@chromium.org;
 h=from:subject; bh=uRCkCvFsyXVpf/RtG8GCWMvVuyi59RVZ9Ft/3XBajpQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgJXxmYjo3BZJuP6sKHQxKb/M3OqOpXccNUZ
 qhhlaPYu4iJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICQAKCRCJcvTf3G3A
 Jh/nD/91bB80GL2rgD2Qu9VZOfFU0YicaQRtXMeoaSbnOb9C6bplAraUcHoNvH0F/nzlJcxXU25
 tdFLoL0nVtuTpAc0QwLgnxaobRa9aNgWmW3DUkrO812C5TjVwlXYjliSrA5pLSd1FCOwfEGcLUB
 OasKeE6baUkZj6ytjNign6jV35ncfvu3y/C2MxtKBkts8n1Zwzi540pe8I5UtlySd6rBQjtelTV
 w6SFBV5r1npI2fEZqGplZzZO7EajApmc7jJz1thGgwOaC77JZl1JuklmvrMC4ret/lDs/ycUAAk
 D8MK5b6uevWOPdEY7obK82UJzkJkmcTaxAOtZlX95h01L7rkYBfeFsMYiZxSkbcDNRIQoWxack0
 kuRc0oFbZDU4aaCtjbvKo6CHFYuBsv1B3qzy/dUdlEfz7Q8x7GSiUp1v2zZMHdUUy9zFSFFvHoE
 kZoHAeuRu/Gh7kJhCX7dMPQXqmh1IyQcF7QoTRKQyay+Kirq8rSRKVyOK6qdr+F/8jCxx92g3nD
 2liBspnno23rcfzBqyJV5XbpEehmcvR0R30g5ubq4aeUy2+NIh26YpvJYBT9PIeuAR6WWh7/jm3
 dRFK6//1Q7sP6hjFLcugQJcs/LAqMyL9p1u+btGAthR59AQsdV1I6mj3Cqxb1SXG6UXNsaiPyRb lV4UD0ZObcOgDAQ==
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

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
index 6ca1a82ccbc1..87c0903be9a7 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
@@ -1291,7 +1291,7 @@ nvkm_vmm_pfn_map(struct nvkm_vmm *vmm, u8 shift, u64 addr, u64 size, u64 *pfn)
 
 	if (!page->shift || !IS_ALIGNED(addr, 1ULL << shift) ||
 			    !IS_ALIGNED(size, 1ULL << shift) ||
-	    addr + size < addr || addr + size > vmm->limit) {
+	    add_would_overflow(addr, size) || addr + size > vmm->limit) {
 		VMM_DEBUG(vmm, "paged map %d %d %016llx %016llx\n",
 			  shift, page->shift, addr, size);
 		return -EINVAL;
-- 
2.34.1

