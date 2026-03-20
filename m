Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFBD2620E5
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018808; cv=none; b=e1jjz5dyD0+xIQXvhRY8yywDPL2buRxocKJaBOP5MgnfICwiYynsluldr1qpgUaFWmztkjUSbIyj536JU0IBRZbXzoXsx1zVio76qydQOaf049G0klllFPl2Jy5SnjKu5BqWnNfVnipzoZMwMK1zsYX63hy0KHwE0FvZST3RXMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018808; c=relaxed/simple;
	bh=N12j8EIF8rQgy0go0YZV4EDhJgbdVWCWVwT0HY9CkXc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RZPOXycL0P+e6ULAnTNQJ9zsC2etPnZIxRZomu+sCiTyO6v3m8LLUy2wbUL9vpk+xUGQz6BIIauIeFM1NrbozdSiKfAycCu9LO33omPrtlkgQY5oyfyv2IZPZedKLMAn1zvDUybatxyJKPesVi3/0l24ROTlYNxZp40OyBsskeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YUzPIQCV; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YUzPIQCV"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-485375aa56eso5007115e9.1
        for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 08:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774018802; x=1774623602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ry+R/ZaKd/jQkpCgufXe2UFucnecXTxYuVWEy5sRefU=;
        b=YUzPIQCV9jfrB1P7Z8kjBS6yyyJEJ8RS/qU/xKTvJrrsE24HHNJM88EaxUvsytlI0/
         OHBYrX42S/Dcwr6Ttozlm4dRuOrvuFLCiSIhwFIBOkf+0+tLvFT1apu41DprB1CI+siU
         yOK2RdGu9mkHLYyrd16ox3qUY6+k7hToaRlzDeiYKYco00ON9D4HhrwcqW8g4jXWHooI
         j9cMcavpuBV/5CML+Xoc/ncavRdv45ir8F1NAFvg/Hc2d/QEjnvh62VmXYhVSWPFVh+s
         qZE6fqejDzVCLU4jc6XMwh74uetFy2Yz8X//KHS8Lc3rSLdSbIqIGJTSlZGYA1Icr60T
         TF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774018802; x=1774623602;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ry+R/ZaKd/jQkpCgufXe2UFucnecXTxYuVWEy5sRefU=;
        b=Il4M88uoccGKmilJFEaFZLeMq108WHgFFpIfbXwBvtusggZwxkP7lSL4MmEuH6jC+s
         ijHpoqf3YUQic2qX+Uo9P8ejHDOV1qSZy1co07qCmHVTUOokywynd45S8CxpMtxAFvnG
         ogCfXNmGs9RJj+i4TD/0NlGgoy+FzXU+xqhTvoaWualtSpAaQ8o0+TqwpMjtaCXv39Os
         PEwFSTKXa3Nv2Af9cRsoKSDTesOAswcOIX7me8lpQMcu56kQjuGi/slMDyIhOuxUkiyT
         hkTFxFCa0CsNFJ/Fnky0/V3f4uzBGzHOfIwJ34nFl4mB4XWqYp3RgXPAccf6doQybxfm
         u4tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzL50j/64UrNJtt+JDokw5nJaTFtKneCmkVw04suiK0aiXh+79zMzlaFVyIjpPkjbfz6o+YrFoC/I72/grIpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/RzZNwVJHtgOv4niD+guN/cuaaQAihPRhnJa0IcXvkJDtoMwN
	W4MbM2mDjWsYzpgGlrQhyXhX+0NnRXT0exdzXg0ZlEZbPHzR5nTPn0acGS6xv4kjBpawH2cGzQ=
	=
X-Received: from wmow21.prod.google.com ([2002:a05:600c:4755:b0:485:6976:d608])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b07:b0:485:3abe:ab86
 with SMTP id 5b1f17b1804b1-486fedab424mr52152315e9.4.1774018802093; Fri, 20
 Mar 2026 08:00:02 -0700 (PDT)
Date: Fri, 20 Mar 2026 15:59:39 +0100
In-Reply-To: <20260320145934.2349881-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320145934.2349881-15-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=966; i=ardb@kernel.org;
 h=from:subject; bh=xcKv0iq0nxsp6X5JaqW8GiHsewOrGWIHuRHfq8YpCzU=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXNvwp0GtsN3TltOPrsrt2BdV3b6jJx5clvuzr38q3frW
 8FZxnvfdpSyMIhxMciKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJPI5mZLgfK623XG9/YMbb
 zItORtx3L8xmzvydcsxi1tbtaxmY5YsY/uk8vmXq83RThfOLXVyap3xeyITYpEfoRW/XPHlqWdE nE14A
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320145934.2349881-19-ardb+git@google.com>
Subject: [PATCH v3 04/13] arm64: mm: Remove bogus stop condition from
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

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 7f7d63009440..652fe2c52b5a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1157,8 +1157,6 @@ static void __init map_mem(pgd_t *pgdp)
 
 	/* map all the memory banks */
 	for_each_mem_range(i, &start, &end) {
-		if (start >= end)
-			break;
 		/*
 		 * The linear map must allow allocation tags reading/writing
 		 * if MTE is present. Otherwise, it has the same attributes as
-- 
2.53.0.959.g497ff81fa9-goog

