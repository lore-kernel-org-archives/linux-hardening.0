Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A323C3F
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 01:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972340; cv=none; b=CbyXweijR6VAV+10ipI5bapKjjRhAXGxkUVgrcNlx5xxYS+ez3U5m10hOqyXMNABaNqZotBq7D7IecNtDUC8u8GaeIUu94PfU49f+Pdyy116ua1QyLBaP+TP9ncf0PqUhYhMaSxtxtsg5I2RyVjVB89ukuEnf6r/ZJZ8qMBDNwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972340; c=relaxed/simple;
	bh=ZCXYUvRq5QkiujopZKa+oos+1nywJjGYg1IVAwcoHTU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I5NBWUV4nfIzg+rm24NTh1hGSJituoSHO/TxSHD23lvKY7AKpbqrhYsxsYaqEr+7VCtAe5w5LqpXt/wkvQbfyTCggQpI0x53/GRKG7dI/sDtLVBqyDE0yWs6x/GVYS20E276Z+UZA7cPuVH/Uzg7y8dZU/65jTyIIrMNhnotEDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=azrXpgIF; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="azrXpgIF"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6dbe5014eb5so898864b3a.0
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 17:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705972338; x=1706577138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4qH9Rf/zd/bFfsFZBAS2bb+VGZ3TWvzsYRdk9oqlfHE=;
        b=azrXpgIFgYmpAZoHosPXfQs6o5/SdrzwyLtUcLQGxUeLgcsnZZrRdiBvbiwfIvLEQs
         ++Y53QfJVQxjUAGAfEGaDiMrH7HeIbn/dov+75CX7DGdpRg3WhvWrDEIRx60tU1zK7rT
         +iJkRZrQK5CKqAPFk68AzoB//EiuzXhLcXRyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705972338; x=1706577138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4qH9Rf/zd/bFfsFZBAS2bb+VGZ3TWvzsYRdk9oqlfHE=;
        b=Hk20e9sBXRcklJ8XdN+ddATFgWTARERlQL9ry/Sd077PLVZCeNSBEnMi6poGEgXG8D
         ev3TXMlIkuYW2xdtyjmx5Ec1jUDJjWQ9GC2aouR2YV7at8D2N1CmJmisdHNwcTFNfyfL
         j1BUBGcoE6bnRX2SLgl09uC1phf0gqrvrSZySKX++8FZ73lUa7PCwqxP6ZW16Tj/kILT
         INzviAD20LMs2pp5ykMkQptDgxCHCoLql6iREFZZCOyC+L/uYBz36wlBi+n4b6h4Fx3F
         QzjihQiz/944J2D2GFUmfN/uVZYRDaLr68sZLKVnkTaKbnqvivy/GGPSkDuIpj4GUi/E
         AL1w==
X-Gm-Message-State: AOJu0Yxrq5euuehd7udU0iDESo8swVskT03DOZZzG8wkfiSPFdLDS4fQ
	WdvSKa6x2kDA0x0odc+7ZmD3D7VvuOiClbeqT0tIijzPgRJ4JaOgZcjY/OrYzWzlfalUsYiK567
	cSQ==
X-Google-Smtp-Source: AGHT+IGNrTPrac7ISZlO2e5t99w9hTwrpumEwsfIdx7bdlG3ZBChA/j7c0HGByhiNohLx2kmMirFcQ==
X-Received: by 2002:a17:902:da91:b0:1d7:4e2:592b with SMTP id j17-20020a170902da9100b001d704e2592bmr3161029plx.103.1705972338231;
        Mon, 22 Jan 2024 17:12:18 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w2-20020a170902c78200b001d71f10aa42sm5968938pla.11.2024.01.22.17.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 17:12:16 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Kees Cook <keescook@chromium.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Wang Kefeng <wangkefeng.wang@huawei.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Russell King <linux@armlinux.org.uk>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ARM: fault: Add "cut here" line for prefetch aborts
Date: Mon, 22 Jan 2024 17:12:15 -0800
Message-Id: <20240123011211.work.227-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=935; i=keescook@chromium.org;
 h=from:subject:message-id; bh=ZCXYUvRq5QkiujopZKa+oos+1nywJjGYg1IVAwcoHTU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrxJuxQakNaOdgA1fbKkrd9nBEjS8Bl0aB6r2y
 6AtqY38AQuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8SbgAKCRCJcvTf3G3A
 JnRTD/91aoq4t5Oh+w4+1avUipu20D+yzeP9E3R7zVZG/KmQyCAFUSLowG/5ggQFVkv7TN8Wit9
 ZGNlfOuX8hBK0yLB6hYBGfOoHcsh1Gn7bcwBK6V5HkupzaTohUCDm28WaRM4GPvyx+Lt0sk9A6g
 6HAcuu0GvPgX6ZpMW3G+OYfqnrXC+oDXw1JoWSZ6ByS0H3SiQBO1/3sspw9IPDLcxcce8B5/1dz
 7lZ+PhKbqJ0ZUh+DmdS4UVbOrtzf9bFsdKAMO5NthlwHeeEDPtwbDYqqqRhyfikfds/k0jrcyYw
 mj8r4Ckh93ofW3TTufuvqoiLToS0cQ4joPsbbgKTnwBLQnu/Sovm1SV+2qPeG8CSrylxToPn66c
 VJUZjaLhI+vzE8HHhwfOqOtFIAC4d2uqY0lZu/tXbS0Jf4sWTNDr9R3DVlvsJ035PhLX7Jzfzt6
 /yboV6QecaqFRqw2aPFwYL8F4LFLXCgrDrmms6oYk/+ibyVeOxxt0HAcZK1/C9pF1AAn5CBW+sD
 QZP/hxPvayNBRU2hgWSFhZCrPEm6Aa4GoXsGIqiMVQHMy1peVqURo24q89XsgK4LOQ9+HVURGJk
 WHNO5Xzhzh6evN0gwT+E+cf/LPul96AgTHVfftpVQLe/5AibJkCWT4fDM8VYAc/kgvx71nzhZEh
 ZZiuYLDe 2RO/4pw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The common pattern in arm is to emit a "8<--- cut here ---" line for
faults, but it was missing for do_PrefetchAbort(). Add it.

Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Wang Kefeng <wangkefeng.wang@huawei.com>
Cc: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/mm/fault.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index e96fb40b9cc3..e804432e905e 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -586,6 +586,7 @@ do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
 	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
 		return;
 
+	pr_alert("8<--- cut here ---\n");
 	pr_alert("Unhandled prefetch abort: %s (0x%03x) at 0x%08lx\n",
 		inf->name, ifsr, addr);
 
-- 
2.34.1

