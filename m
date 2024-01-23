Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB1B137C4F
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 00:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970170; cv=none; b=JV4ODRDUSf7Rzqq+tjPicqfPeTVz3hoGHRLmSAV1znlQVy+FQo93m3dkGQYVIkxuZ6FVljZkuHDeusmFSWkgBBN2YIYLnENQmDSU2EJ9EFO4xqsrMp02FLvfIBeNGnGQM2SGALNVDszzwgO1ZLd+swmm/FL2xP3LYgFXXxNQhcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970170; c=relaxed/simple;
	bh=j3gjFFi89fE5hWuOH0xzr9hUX4P6fWiq/YFrtYI1j0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y195tP1po4ODDcsWO02oaBFX3svi/AUW/a6damoG+PFRnszVtnWvayCFHTUAY5NXS5QVov7Eekt4dB1+A5Gs4W4hsE86pqdUZO0XQRtRDto3XT8O+xeK1ybGRRIuE0idv5+DavUflzpGfgHs+EcM7Bdk7rqkZOEY2YmsN0beEa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DsFGLxaT; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DsFGLxaT"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5986cb7bb61so2116123eaf.2
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 16:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970168; x=1706574968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWkbiiH3/fFBjXvcbT3aPuNGXGqy/rkl4yqgLah2PkQ=;
        b=DsFGLxaTrkEC18juVhDlERfHhwExSuj7q6WnJDWX+RXKC+nsuo2F7BzakjL8d3jQuK
         b2gzSlgoocgnPgGztGxMYrud13lL8R09bk3oSVPwuSEMIUrQplba3UjdSkL3Uk/Ec2Tw
         J/zJoMzsXW3Z9ditfU4i3/UrF1WqtOHzSDo6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970168; x=1706574968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWkbiiH3/fFBjXvcbT3aPuNGXGqy/rkl4yqgLah2PkQ=;
        b=jVXgbnCV3MOcvRudQSnFEBuspAqnzAXzg22uDAksWYvjl2PRMtNsU8VrN0NYFUvLBM
         yVOGNaUd9ZHMrFZL7XWNFDNQgj1xeH7wk0kcNAEpkqHNGv6N0whg2lnNBqnPdw2kQ1Mo
         0PQ/DU029Um23WBJhpBsYBnPPErLtM4Y/ovnzjF8qqC9h57zPoIUc3Tq70QE/cJ1dsio
         zf38y91wvggJHiZ5Row6pFfewf3Bmoz5tpGiV9LlY41zlwXCS9AcoAI/4cZxJQyVWnyi
         zsbC8OQM6J8mrApEJJn5MmlKdgl5Gx7EazuZRfzJARkZ/aRwgt4DIU+FgGxsK+gJOaW2
         r9Gg==
X-Gm-Message-State: AOJu0Yx6xcPXcoPvpb5aDqdFco/a/T0oU2GYMf479hOPKVAYnzNOKiB4
	mLqRuuPaqtvAtJ0ld8IGZ/KuckywMJ+0XNJncRqC8+jUKVlRTFapJhEmceyU3A==
X-Google-Smtp-Source: AGHT+IGCE6wKB0vFo5DQU4i3rippgddBtp79PTYZ3m2V82MozDWJLYPquNrFjcuiK2uXFRm90PZo9Q==
X-Received: by 2002:a05:6358:6f97:b0:176:2c3d:fb35 with SMTP id s23-20020a0563586f9700b001762c3dfb35mr3682344rwn.20.1705970168652;
        Mon, 22 Jan 2024 16:36:08 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e33-20020a631e21000000b005d0796e779bsm443952pge.12.2024.01.22.16.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:35:59 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 75/82] timekeeping: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:50 -0800
Message-Id: <20240123002814.1396804-75-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1918; i=keescook@chromium.org;
 h=from:subject; bh=j3gjFFi89fE5hWuOH0xzr9hUX4P6fWiq/YFrtYI1j0Y=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgMYckjD86gf/4cfDfniKeSqD0L0XmJ51qsC
 Om3IcpSCEWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IDAAKCRCJcvTf3G3A
 JhBOD/9e96QfLEjRR2+qhyB61fGhN/WxCMNySyJQM8sIeDxAo5K/ULqUmvt+L1RbQj6LFEsxhM4
 UJedG+p4JcnhH+R53J7/OuNQPRgCIS+tzlF/8uGd3mRLdB145zOQ9ukNMQCzfFQEZqtdfkpf/n4
 VdhGXTw/fOWZ57e+MMGyyWYDMm/ER8H0IWMflMlG1f4L7wAAzSuLgaZXr6h8I4jBY9knySyVuWh
 fDVPZod66S5Vyp3vqUrRnatGxHW/SbYv6odYSz21titb2F/Xzzr+yICMeW2pGzkMtrpohySkGBh
 FdJoQ/LY+nEMfaGLIQibr+dLnkqa3B0Qg7/Vi/XKbuTr395lI2LnCx1A4HpSwgKlktNV/2Ih2Ey
 JhZhiZhJeIhGtTmuqlLXyFpmzkVuvTUVwKLFQlfY5HekV7kZY0Zzgu4ZqR/4HtRCm+jqmaw5tX1
 MovwgIpbaHHXZiFPQyX0X5RZg8/xral+SZXA3NBwFOI8nutl0Nbghz7xEFHaluKv+1kIVBg3WSp
 9vM0UEXQ2adsZPgp2g71YeWak3Fac8p6QgFlGRZNextT3T0ZLYWoleTfjj74Ij3mj0DI6Tedbmi
 gikhr35jTk3wjvNCX+vdwRxeEJoKDbe2uO1Kj1JlhmkXnVS5cQUUOT+tgAaewBUK6bw48xlhXwm 57RPQajdkj16fbw==
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
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 266d02809dbb..2fc7cf16584c 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1984,7 +1984,7 @@ static __always_inline void timekeeping_apply_adjustment(struct timekeeper *tk,
 	 * Which simplifies to:
 	 *	xtime_nsec -= offset
 	 */
-	if ((mult_adj > 0) && (tk->tkr_mono.mult + mult_adj < mult_adj)) {
+	if ((mult_adj > 0) && (add_would_overflow(mult_adj, tk->tkr_mono.mult))) {
 		/* NTP adjustment caused clocksource mult overflow */
 		WARN_ON_ONCE(1);
 		return;
-- 
2.34.1

