Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80093C5DC4
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018811; cv=none; b=a7WmVa+n96CXXFzNibfwDYe1zI/IrzcFcv9hH6eVJwFF1ujL/SzYvNYTS3KH3rJbPxja67SncRpIQsfYDZ6h+Cxq5Utrac2sZRknIyLfi3qa13FWzaVpwNL7X154X06hLqfcGxHyQRFakeiF2OKrSQe6/fC98+GkbV7n+MgPhr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018811; c=relaxed/simple;
	bh=VqpVj+W0FM6b9m8WDPY3YbvaCmG28PnmLS9IjR3RHKo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n4jk2Mz/2PUnoLTbQadFzh8OBMRA42f4XCrJjs2FKtvvMIYqeGJUOu/vB4HrsawJms0cmx/bkyc6Zmv1TrxKM7gowkJDc6R1ytxt/pJwca1gn8WZFyx7ekIduNqDIFqI5WAP6I1TGJJn431etlzYCVclWU+W3hLHjVdILlm5qPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fi5D94oP; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fi5D94oP"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-483786a09b1so21852915e9.3
        for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 08:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774018805; x=1774623605; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FREiFmsRIXiOQcSDf+g4S+t23y0B3LOgQe0t9T04+rU=;
        b=fi5D94oPSe/zlJhcU/9OwaY5KG/DDr6G/M1edabSkl2bDsKI5zXg2ycGNyyJ3cr1zV
         12cAcoM9pd0IKVwdwiRpupU0Qo4vQ17grQgH+5hz3MOYn119sjsErvv00TXfpJDbJ86X
         w0EHu0ZTcVMsyOP+F0PoNxf6ET2eOzNyc8afUSmFcbFcc7J0Zr4maUj7rmkePHr78oOs
         8+BfHcqtATLnVz/IpwpI6z4zH6slhJ4CZZvcWpHDSfjlIWIstwrnLq7m7374G78dOar8
         sPsuqTIAYvOw+oyT8TAprGI0N5pcHdfCGsGOqrdJWg8piD6VsDrxja0pR5Hslte/xi9N
         Z7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774018805; x=1774623605;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FREiFmsRIXiOQcSDf+g4S+t23y0B3LOgQe0t9T04+rU=;
        b=jL3PNVXQbQapJJChQ7YPXSiWG/fw4jN35hnnplrJ8VQr5sF7IWOEiyepBo63jqD9sC
         48JdqrWVh42gw+JKlF7YVyIzYga+0nm4ECcuFS8xev6BBu4IuT92rtEpyHebiQpgaR07
         DpCWPuyXO8qcTf8iRGctaN64EHod3PBJSatzZJKJaGXI82F/pWpZYgozXj59wESfEyGr
         4ea2aLidTgLJ0tKd7DXOn8yBIiTNRsIYe5jz4h3PcWdxBOa65wDTzGWrY4u5nxOOXRFK
         TS9oRsW9Fl+zjRyU1yosZvygqVQalHMblD9nctGajY3q63cgjYP69jVCYmrBTDVzhutu
         hRqg==
X-Forwarded-Encrypted: i=1; AJvYcCXzKBTmb39d17jj/N1c8sOWTetC7G56yy9TqkjdV1fI95c+aCm+zsxqq6f5HEXvD7WgLyICOw3+TY9j+bdAr8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2MWG6RCvw1aqcec4Ew4mEBGsMm47Wu8PQAjZFAfXkJHUVz6JJ
	1hrzP6xJF1GWTFdjmUbsIPdX0zzgzCw+l24m3opFFG4xEwrUs+fxRPpDjR5YghPb57bqowRemg=
	=
X-Received: from wrwp1.prod.google.com ([2002:a5d:68c1:0:b0:43b:443c:fc00])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1f0e:b0:486:5f71:5829
 with SMTP id 5b1f17b1804b1-486fedab740mr49836565e9.5.1774018804352; Fri, 20
 Mar 2026 08:00:04 -0700 (PDT)
Date: Fri, 20 Mar 2026 15:59:41 +0100
In-Reply-To: <20260320145934.2349881-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320145934.2349881-15-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=914; i=ardb@kernel.org;
 h=from:subject; bh=E+pO5/eHkkh2sajPGACS/nW0kkP4G/kfrd6uShLIRX4=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXNvwn1xAS6VoMiOyA2+FtGnPNwL5JMFZkScquZs1dh6u
 t1XqKejlIVBjItBVkyRRWD233c7T0+UqnWeJQszh5UJZAgDF6cATCR+GSPDoSuMq7lCWb9aveeY
 7Bn0TcF2hdf55QUZssayBlVT/HlnMjKs/79HqyM9/M2u1Qa/OsRvb2R5csxUmk3+gI7K2Rfx28T 4AQ==
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320145934.2349881-21-ardb+git@google.com>
Subject: [PATCH v3 06/13] arm64: mm: Permit contiguous descriptors to be rewritten
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
 arch/arm64/mm/mmu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 744cf76f25aa..6780236b6cf8 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -140,10 +140,6 @@ bool pgattr_change_is_safe(pteval_t old, pteval_t new)
 	if (pte_pfn(__pte(old)) != pte_pfn(__pte(new)))
 		return false;
 
-	/* live contiguous mappings may not be manipulated at all */
-	if ((old | new) & PTE_CONT)
-		return false;
-
 	/* Transitioning from Non-Global to Global is unsafe */
 	if (old & ~new & PTE_NG)
 		return false;
-- 
2.53.0.959.g497ff81fa9-goog

