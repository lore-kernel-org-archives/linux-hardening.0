Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F92C6167D
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 00:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970759; cv=none; b=psCARoyktFFs7xePhv8/BQ4q86/zVnLiguiRWwyxMNt+0R4w2iJK+pbhxv+8iMF7SfW8ht5UyWKwm6FqLRu9EmmlRjQdgf9t47GlEObUHgTRZPPQsAnjBQI0LnipTfPnVAt3CPiIRxwqbvr8fHCoTS/ZB/l4Y8ixXyLfkCcoJtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970759; c=relaxed/simple;
	bh=7SK+CeaptbBP/v+CP2JEux9OatqqjJKzGmyq2Voqx04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RoxGkoKvrkbjTU0M/kq9K+c0awSphaK5DJc7+9d0M3SwdyMaQV2tEQ5wvf4b98W7XaRaXvJ4E8LZaKs1UbiI4C+UvB8htC8CEuOXw3u8bPAEqbI9338q5EyAF6zL2aYC48/3zv1BS9d1j23KrDv/kwudItoDeiHSfroopryw/hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NdcyDFzU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NdcyDFzU"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d730b6943bso6729985ad.2
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 16:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970757; x=1706575557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBzwhtxHV7+0pkueVEdOMj16Ew6MX43q2RtCRgBYnfE=;
        b=NdcyDFzUhvzwX4yoUH4hoUPRRbxPVswsvgSrjYNQ54x5uzW9pV54KelUvXlN97GcLf
         LKSb1v1TQQEQ1HC134EB+87lJrhokCugQ1IC/LJwPjt0ndO4rBR7kCnNeaKMXfItHDYK
         HyNNFIBlgVVW+LRphKpcKBrr6QAdLpoZz+XIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970757; x=1706575557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBzwhtxHV7+0pkueVEdOMj16Ew6MX43q2RtCRgBYnfE=;
        b=KXoE9C+OPmSqfIQ8SClZnHSmzyGVVaa/ntoGg3armq2kfVgD78KmXmccmfMLHG8cgV
         Gj8RrhUt1moqrDJRLXsw6epCSaKyaKtteKQelEvv06+gzCHGBShbkawd6ACkCG6fgYBT
         514TCg3fxwFoba2mdoLdtHIA1Q57yr9XpsUVKJm83oayvP7+LqGYYbaHmIWC+aAPz8N0
         SZAcnEEtSC3CyOn1XDqFstVoxB1D0+wjKApiuuJL3giWIOUkVD1t4enwifCNsKTmHmzm
         tif77as8l6Hf8YamD03yuZlzwWkAxaT8sUHZQD7/AhfQ/uJpqE5VLy54ISBezgqkZ0mb
         +aaw==
X-Gm-Message-State: AOJu0YyfYaxXfL56RZa2ovMG+gTS0GDIXjHo70fvTVTK4hCjXHoTXnsp
	QwyLY/dLa4YH5CaUPEEBzpZkLF98Z9EbvFlYFzrW24na2h3ftrWFQqC1AaNIEA==
X-Google-Smtp-Source: AGHT+IF8yhCmkJNt7Ij2XpjUMJOmTKGRgOFOqqmGAHzjTF1WQ4RIpNJnjNIqKXh4JiYJsFhdhzQmyQ==
X-Received: by 2002:a17:903:249:b0:1d7:4f6:931b with SMTP id j9-20020a170903024900b001d704f6931bmr2578303plh.18.1705970757393;
        Mon, 22 Jan 2024 16:45:57 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902784600b001d66b134f53sm8013882pln.233.2024.01.22.16.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:45:55 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 23/82] KVM: Refactor intentional wrap-around calculation
Date: Mon, 22 Jan 2024 16:26:58 -0800
Message-Id: <20240123002814.1396804-23-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2091; i=keescook@chromium.org;
 h=from:subject; bh=7SK+CeaptbBP/v+CP2JEux9OatqqjJKzGmyq2Voqx04=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgGMUghWI+PGsPguK5zp1jJTO9Udx8kDt3JM
 m98iBkuTfCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBgAKCRCJcvTf3G3A
 JsIxEACt5a2RN2oZ+4JYd2ymbmpv5B6nOsrUIqOPauBUQY+OHeVN8nMnsBdASH58oAT8jCD9WVQ
 7HAb+2ANB08IYc8/R0h6xkBqa2lCZk/3c5dpFUtpIlCTzY+hAfPnj3l7atArhXefRspVNbsJft8
 hYD5qHs7sMR4xnQPCwbKLBjLn46735BXMxnSYAn9JYVGEL740vCDkxpqmQgFiSX23MaRZDi2p8U
 v1qhycBB3BSMK6Lo8r85YYSK2XJ9x47dytKFlfuqi371X3bi2J4T1Zmf1zmU0ALDy4G3/NJIlX2
 JhbQiOfH98N9+MtqcBMq3RWtHRqVRJsqM4nPVlbzO4D0Z5EKX7HzxzAg+wZOWXOJqZBUflBMu00
 jbo8OBTZLfp9yRmymYTGlNNuanwYU4YZpdO9MQx9rvC1YQM+HdtO9YWpu+++sAgjyvdln94rlUO
 sMJ9ZmFXRxInaysdaafEyQBh06ugVvFdamYsCf6FILZP9XmKMUKSGcyiRVCG0f2brI9Fuyw3SRn
 cbpJzb9ATyxDFZyuhMI/7g3fuPMKee7yNNoMul1dOGNFcLCtwSAgsgOVJEGFdCgdgXj7MmvUulL
 ZBQpjnBa8JFB3UeWkmEc5ex6AaaLMKyDaTl9rbXMZXXt2w178+78kcYV5TBWH9Pt2AyakcqiqaQ C0S0f0g8Orqog+w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notable, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed, unsigned, or
pointer types.

Refactor open-coded unsigned wrap-around addition test to use
check_add_overflow(), retaining the result for later usage (which removes
the redundant open-coded addition). This paves the way to enabling the
unsigned wrap-around sanitizer[2] in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/27 [2]
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 virt/kvm/coalesced_mmio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
index 1b90acb6e3fe..0a3b706fbf4c 100644
--- a/virt/kvm/coalesced_mmio.c
+++ b/virt/kvm/coalesced_mmio.c
@@ -25,17 +25,19 @@ static inline struct kvm_coalesced_mmio_dev *to_mmio(struct kvm_io_device *dev)
 static int coalesced_mmio_in_range(struct kvm_coalesced_mmio_dev *dev,
 				   gpa_t addr, int len)
 {
+	gpa_t sum;
+
 	/* is it in a batchable area ?
 	 * (addr,len) is fully included in
 	 * (zone->addr, zone->size)
 	 */
 	if (len < 0)
 		return 0;
-	if (addr + len < addr)
+	if (check_add_overflow(addr, len, &sum))
 		return 0;
 	if (addr < dev->zone.addr)
 		return 0;
-	if (addr + len > dev->zone.addr + dev->zone.size)
+	if (sum > dev->zone.addr + dev->zone.size)
 		return 0;
 	return 1;
 }
-- 
2.34.1

