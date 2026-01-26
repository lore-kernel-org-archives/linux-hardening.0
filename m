Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39033314D18
	for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 09:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419667; cv=none; b=jo+Fxkq70fBzLdYJo1ARUsfJ5FZV9LCZRigHZeV9UwrdPxFYlvAHJFtOYS8XncYEZHdAl7NyMvoYDvYUA7tTw32zkLHfioMILD+bvYUuoAk7XBFeZdVWCeu6q4zY3lEsom7gNIXebeI70tqury3r4Qb2GThQjKKVgH79X8Ph8m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419667; c=relaxed/simple;
	bh=aWvImcQIG2Lxet7GuE/7T19bLGTXrPIqmOHZ8YE7GsQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WLCuWnmFfIxDgffRRxejcDvqWXzN54B5TTMtf9vTd6YZt8FjVsnNSNwOxwj44nJr2PFdSmQ1773TORcYvU5O5Ps+4m88vgRTyCJoSaF1F3/TR6rk68bKlGOrhiQrmyK34ZzFihG4zRXsWAV20W+jM4Bj+vIvPp6tcB9BkWlSY5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SFCCfKLB; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SFCCfKLB"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-480600391a0so7257675e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 01:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769419656; x=1770024456; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dus1eDjKV8+fyJlWa6CeOHr5Q8TfY7EJ7ksMCXuuvE8=;
        b=SFCCfKLBLXxQUREjbL57PBik9kEQNySElWsJs0Bn4qRxLdXEHMGlc1o5+C+G8/FKYQ
         4WzU/NnBWeuTkztU/e5Es4MulFIXpr/HQULF7HiFRaqc3CXRx35kP23xBCvAU0lXMWIY
         gUVDgDO4M32u+ckEI1q3+J4PDnDLB6d+sFb9axh6OKHquk/UpHLByI34REXbD+t+NO7p
         8jOOccbryET2/FgnqqOtTxLLFEXVLpBRLq2KDiCGPa9aUp1XnX6eQudokMbr/fYG3FOc
         TgAqix04bzI7s3Vum6dBavfo7f/MckbBz4JlDzsgMluTfSpcV+3M9nJFB0XMB47JAyG2
         PT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769419656; x=1770024456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dus1eDjKV8+fyJlWa6CeOHr5Q8TfY7EJ7ksMCXuuvE8=;
        b=Fo6Ds79HrcgbuFG4oEFNdGCJIUR9G58FbBUYj9y9yPPQZ2fcvdbqAPUtcAnMlAMODU
         TEozprC2NeFHGZNUJk0aQQmfNmyvrQy9LCFT+fPZpnYUGYN26mGL92evUPy+7KX0m5ma
         hG0vsrlEsnYG6tCUgCk86oR+ieVt7EXki3SSuQUodfZxlEqjLiLhTELNMf18fTl8xTxY
         CLhhKSOHUcU3cHADkGGsf3b5l8lu3lY6hsUoTY/U5qMtANEii8zFb21hiAz3KSKjsH0Q
         Us/z5rLedHdUJL0i77tTtRB0esxym19QuuyaSOKb2R/12zoNFSjLCDpag5tnU8EVPwC7
         OvRw==
X-Forwarded-Encrypted: i=1; AJvYcCX7lsuYJnCFCzKEIJG2TLMFToEYqVD41QJhNtoPD/MR17fZ41akpp21W1NfkJo9Z4cg+w+1WFNyRAuD/WLQ9c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzriccL+K3Mt6ip1lS0YVOvvif2TdWYOgr4pm6TQaBcDdCP3XCB
	V7lmNlUUNVB6ADaVtjoxCCS5TRfISvWDbKd/yHHuZVypk4WeRRVuABz8c+bLDeSAmYY2XIZwRA=
	=
X-Received: from wmlf14.prod.google.com ([2002:a7b:c8ce:0:b0:480:4a03:7b6b])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:528d:b0:477:54cd:200e
 with SMTP id 5b1f17b1804b1-4805ce3f893mr62195305e9.1.1769419656709; Mon, 26
 Jan 2026 01:27:36 -0800 (PST)
Date: Mon, 26 Jan 2026 10:26:37 +0100
In-Reply-To: <20260126092630.1800589-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126092630.1800589-12-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=916; i=ardb@kernel.org;
 h=from:subject; bh=AbBNGoFlUmz8DhotcNagR6+hcZWJ6aqvLIQOSvGP0oY=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIbPc2Ctw67qkcsYnkz6HVyaIFV/R/hlm+kvXoVE7kZW7Y
 APXosqOUhYGMS4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJEbfxn+R/2O9dR21crak6f7
 +c5MiwrF2xnXXYI4zDR6lOzKa4V2MPzTu6eudlBgRo3JnMb/EVvfGrmcsfoU/mC9Z4jaodsrJ+x jAwA=
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126092630.1800589-18-ardb+git@google.com>
Subject: [PATCH v2 06/10] arm64: mm: Remove bogus stop condition from
 map_mem() loop
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

The memblock API guarantees that start is not greater than or equal to
end, so there is no need to test it. And if were, it is doubtful that
breaking out of the loop would be a reasonable course of action here
(rather than attempting to map the remaining regions)

So let's drop this check.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d7faa98f427c..377bdc4d84a1 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1158,8 +1158,6 @@ static void __init map_mem(pgd_t *pgdp)
 
 	/* map all the memory banks */
 	for_each_mem_range(i, &start, &end) {
-		if (start >= end)
-			break;
 		/*
 		 * The linear map must allow allocation tags reading/writing
 		 * if MTE is present. Otherwise, it has the same attributes as
-- 
2.52.0.457.g6b5491de43-goog

