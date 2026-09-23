Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422C23BB13C
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 06:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790143832; cv=none; b=YXu+15jlA8tZzQ3PXtXfvTrjjF/OE6EMjdmjZPRCexKzY2dXHZ/vKQ6gpDcNCXSj1km4Nwqzy4Asu+GRspaWavGU5gG2UP+N27YnA+6WBY/OKfdLBHgRSBdTXuVTvpSR+I+0QOjlh9xl1gopS/XNgHN9BnAUQrrEKcC9mZ6kcjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790143832; c=relaxed/simple;
	bh=Up3ZIHSEDaIBrMIFPLazLYKJZ8oSLCIb4EWYTIp3x6A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Z4CdNAJr6TbTG0TBf+HpVXr1wanWJJZvFyw+6HzUiu/y+WYoXoEZDp1AOQeBxCma10fFdyLg5XfFNaxgcQ/mCGyYI3vKEmOiCybchbP3DAf6ojb/mAAr8a1vNbBI6wsq/vdcXcgJYh52ULOUzqfrJRVyuQF9SE7arAwx/9+CXPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oduuocLp; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oduuocLp"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfc52ddc55so5499535ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 22 Sep 2026 23:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790143829; x=1790748629; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2NJLY26Tlw5C/ujVQMbXtmFKIsHXJJUk04BO2IFW5X4=;
        b=oduuocLpYVmIJx5Q0E/5ujO6V9aadiXmi3+1xFvd6mds48T5twmzwVOr3h6829pKCV
         XmMcJMA5ZWdysztObkDHZZS/MbKaPluMTKSSf/dQ/oXOv6mBFeNcB8r/EKX9d+Gn0xi4
         hHLpcZrP1NdxojnC8jZWCuE7uAYQxJ1X4iWUjja12KyuI/2jdD0pce8xX4mD5RGHlzFp
         Pmpj5WSGYr7zxuzElxaayEn5hJiSQxns1GvGBd/g3D1K0bpp6AUjqHnkZF4wgZ0sOwOL
         JmULTSKsfW8GO25IGJd/2KSfSIW7DOBY3eNUTX+DZJcUMtUHrdZcy5Xlw3dd/xuyoI6S
         Zt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790143829; x=1790748629;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2NJLY26Tlw5C/ujVQMbXtmFKIsHXJJUk04BO2IFW5X4=;
        b=bvn1YjVy5XV7kEsDYMN4ZvnjoeWkgnTq0RklJwR5TAzr/pxyZSAOGY60TDm1fdYsgf
         LsvUSk9cYAr+3AZWWwCuw8pXWkjMhp1OX4VO4JeLvfsMaowXW0Ubk+3Wb+tUHvXTHv17
         jP4yZJjCve2Sk/kdi/qezs6R+wJF8AGtAtVjAsDmzXlPejHlTF6AG6wW+dnOZLsxjtQl
         oBr1koSabmS342JtEl/Sp7Fbojd+X4+LBbrxJbFVVEBm+0xjLVpuI6Nx85J45AxYC2as
         0gAMbvWKcyjGpgIGm0JIOEIQ1HWCRxeb5ziCyt2SJv5xKMl6MlcsTSQfnqDwoJ4HNHeQ
         OO8w==
X-Forwarded-Encrypted: i=1; AKwUvBz3nJtSgmW7nqU3Y071MvRbeWwd/ggd6R+D6n3TOhjWlODuAL2mSqrMs4Um/TnTa3Dw0L5GcK9XCe0zYso95/8=@vger.kernel.org
X-Gm-Message-State: AFuF++nafdkptaNe11CAnfuEncJskstprgWZImtItsuXQ4qYmRlDbdF0
	3nhAbulV15I7pmn4+ptp8WQDdHvp8fRMjcqXNRc/oS57s5IVYrDot17bAJKA7qh9EjW+Atbq+Df
	p
X-Received: from plad20.prod.google.com ([2002:a17:902:e154:b0:2db:7978:1b17])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec84:b0:2df:434f:5f50
 with SMTP id d9443c01a7336-2df69de2662mr13543765ad.36.1790143829058; Tue, 22
 Sep 2026 23:10:29 -0700 (PDT)
Date: Wed, 23 Sep 2026 06:10:27 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923061027.2650324-1-morbo@google.com>
Subject: [PATCH] crypto: hisilicon/qm - add __counted_by_ptr to dfx_diff_registers
From: Bill Wendling <morbo@google.com>
To: Weili Qian <qianweili@huawei.com>, Zhou Wang <wangzhou1@hisilicon.com>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Bill Wendling <morbo@google.com>, codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"

Annotate the pointer field 'regs' in 'struct dfx_diff_registers' with
the '__counted_by_ptr' attribute, referencing the 'reg_len' member
which holds the element count of the allocated memory.

In 'drivers/crypto/hisilicon/debugfs.c', the 'dfx_regs_init' function
allocates the 'diff_regs' array and initializes each element's 'regs'
pointer after setting its 'reg_len'.

Since 'reg_len' is set before 'regs' is assigned, the compiler's bounds
sanitizer can correctly associate the pointer with its allocated size.

Cc: codemender-patching+linux@google.com
Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
---
 include/linux/hisi_acc_qm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 8dc49fa2123b..f2885d60b468 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -196,7 +196,7 @@ struct qm_dev_dfx {
 };
 
 struct dfx_diff_registers {
-	u32 *regs;
+	u32 *regs __counted_by_ptr(reg_len);
 	u32 reg_offset;
 	u32 reg_len;
 };
-- 
2.55.0.1082.g2b9226bbc0-goog

