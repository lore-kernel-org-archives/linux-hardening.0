Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5CC3033DC
	for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419663; cv=none; b=b9bAjYUx1hpsVKOnm4hKcZcwia/8Hk96ToHY/3ks2vJkd7YQfpylmtgSS7n69SHtJGwNfiZi2BdRc9hpW93LH/0KZm9xvTNE0ZX1u/ICEBRyLqRd6aCQ5FaB9ZtqCah0Kh43Sax8XFwt5ETxPLk0dkhfhBvtYpUAag0CQWMXUBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419663; c=relaxed/simple;
	bh=SDlEjyekYdAdgWCCN+ljk7uFaBBvdsahPV/SeWDyUAo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kv/qL8K/bpG0VHvepbqtUTTcJOaMNTVVGDeLqbe+1MXLZPM0rANo06GYZy2AtwwGGUH3opmNA7tr85dc9svH6wuiZ9C/sydTl4FPlYBv1I1vcZZbAMpy9jUFX1PT0mjwsARF8APwGN/6qTFD8Ey9KBt4/saKTWywumG78KUsKFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Kwv/I8I; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Kwv/I8I"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-480593535efso8350545e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 01:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769419654; x=1770024454; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eLShc81E/+Lme+gJ9JRioNlppj/hbf+/HE944re/X2I=;
        b=4Kwv/I8IJ+MyBFnRp2bCEq9KETW5xPjyHJcUC+AZxE7QjdDuurltozvL1qxU2EXnni
         3R0P2u+9EpmgNp0kPBcpW6elQC6aoScd7Abk6+g7GuA9DpKHdg7vU/tc2AP3H7pPUHSn
         UinQ/oiWIVTvmRamev6B8LvcXxMnyenNEnBpFL4QLywUJa6J+WwwogYtdW93nZY0C7hw
         cgKTztWYKnZXCbiYImCJhGnOBC/3uSzhCkz12AsR3lj7yWVqJEso9ZjPwzF9Dq9IojmH
         mOBGqIGJ1ug8ylGfhrfhoFxIQTvmWpCHfH2wPMf9EFabXg0XzK/u+eC9uLGVenZeCx45
         mNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769419654; x=1770024454;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eLShc81E/+Lme+gJ9JRioNlppj/hbf+/HE944re/X2I=;
        b=K40/RF3xsUWshB/yXfM7ufHz1oWyE7uB7JS/B+ixLRsRYbNteHSR6LYtRXNWAfNU+l
         F24AgRGdyal54J85uTHtE1zuIHI8l92cAgrSYFNrGPFw4Q208R6cXUTLN3/yZ70/rs8/
         AJcny+XYItO2XRXNzUDs0ZwxvUBhUKlvzR5pJgS1S+V02CJNKg09SRHYw2aPnrvvt7tx
         cnSYQgh+SZ7UbTQygDDZQ7jfsFWy2XgOqmmxBNHgIcZYeKGCH5yjL8uwb26Apc1hPJV/
         K78OI/4KDuKrZzU0JMisnMQguGzzex7PK3Aw7U/eV4R1n5TgbLUM0PhmJGS8+yla64ax
         UVYw==
X-Forwarded-Encrypted: i=1; AJvYcCVAEQrHWZm+URH6NYwgwXd8s/vwvhiDkvDxhlKDa5bxw1T/02gtSqOcTj5pkFFtNLPUZr+dp+FIIeb3O/TDVIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzffnryhLbxyYr3lD5JQHBfjF+6YDsSKUeT5J25EnFW+wNUYpRi
	1GHFCiMrKHKb1KJlNpQ8LYFTVR0sqIu6TaW5zk4MJzqkmVZ4eluJb/5gUuhP+iGdr/bfcURJfg=
	=
X-Received: from wmbjw6.prod.google.com ([2002:a05:600c:5746:b0:480:3842:3532])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4689:b0:47e:e78a:c831
 with SMTP id 5b1f17b1804b1-4805d0668famr63022225e9.36.1769419654312; Mon, 26
 Jan 2026 01:27:34 -0800 (PST)
Date: Mon, 26 Jan 2026 10:26:34 +0100
In-Reply-To: <20260126092630.1800589-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126092630.1800589-12-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=874; i=ardb@kernel.org;
 h=from:subject; bh=Gtkmu5xUf/IdJr0kiShY6X4TSbxJqYA0pGP5tteQQSc=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIbPc2EOMl1Oe+ZtxwpPOV9LiF4RXP+tbf+lo+TXjL389J
 m2duYmho5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzkSiQjQyt7cfCidwej5f/9
 5p7Qf1Jt4vfD9tERNyW+nXLVefgp8xkjw8lZxm6uxhc5n927XLbV0/fcU+dXx87Oeyi4gG+7QvH jeEYA
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126092630.1800589-15-ardb+git@google.com>
Subject: [PATCH v2 03/10] arm64: mm: Permit contiguous descriptors to be rewritten
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, will@kernel.org, 
	catalin.marinas@arm.com, mark.rutland@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Currently, pgattr_change_is_safe() is overly pedantic when it comes to
descriptors with the contiguous hint attribute set, as it rejects
assignments even if the old and the new value are the same.

So relax the check to allow that.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c36422a3fae2..9d39de3cfe67 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -141,7 +141,7 @@ bool pgattr_change_is_safe(pteval_t old, pteval_t new)
 		return false;
 
 	/* live contiguous mappings may not be manipulated at all */
-	if ((old | new) & PTE_CONT)
+	if ((old | new) & PTE_CONT && old != new)
 		return false;
 
 	/* Transitioning from Non-Global to Global is unsafe */
-- 
2.52.0.457.g6b5491de43-goog

