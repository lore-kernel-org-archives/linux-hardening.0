Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FE0403EAB
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203909; cv=none; b=f0CCJ1MQmt/6Ljw/znd3W2BZrke98ptiohirDKCRAGwEs6VFi7xkWK17T7dURjBiP4o6bYrMCrzFu4UO5RWoTWQBaHZ/cMLfWLWH3Y6F8rzPaLisvp6W+ezehgplOQPFuwECj0IaWxJngGjSgmKavPCLsuDP/61DNoP+pPS2WLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203909; c=relaxed/simple;
	bh=9sBG4RmDDHDyT14kf4TeIb21ZFRmWbzOoDL28EV+qxs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hgdNYImo55uPR9amou7xWG4oaTEe0SyjTdEiNiMilBKpA/o4pDRhl7G9w+lyw471m2UCl7zTzLV+aRyUkw5Asnxch5Ogb8M6cqgrOcCP92nqGMuCqsHdy+ukoDO9/N6LS+bWg0lvpuxDNI6seipc/DIt5t/zyShEKmZEjVrhTiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WNDyTptm; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WNDyTptm"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48fd396daedso24201325e9.0
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 08:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779203903; x=1779808703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1BqpbKAWZ7q/0CP68ZcgDWV1seLRY3kHiP/caX3fZn0=;
        b=WNDyTptmV/HyT4q2akMyjokUVuQ0ABJgXzxza+WAYuuomEYAJLE/OBp1kzZ2/ZgES+
         ZaL1NeVCXqlt2D1PhEA02/LD04hcxhUkGo5ax6EYwNCsZsyBkDYvF2KxPsZtk73ArNlE
         uQGL0jpx2LJLCVzafJWirC4sDB29mh3VoFJuLunsKOiEKrMblMCB4gnAHgM3Ct8gY/nD
         5CophrOi4wS8Dwwb6RVQ6VI7mnylXiPAKxvvYRicUmBlsrzYuKRR/ErhLHEQuyZo8uOx
         q53n1/FEObskoORqI4wAsrk0Ygspm5sbzM20ZFhGR0wHj9+l9p5cgWQHMe6lMNWBSp4y
         QHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203903; x=1779808703;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BqpbKAWZ7q/0CP68ZcgDWV1seLRY3kHiP/caX3fZn0=;
        b=HdMtbCfpGvUZdZIQzm6UnJHb0Bm2sTi32fyo2wnsTo1/vclrl+uL2KBR12rezBPHPs
         AfDApCjLjEIAEwBO4/OzXHcy9vE+QGdlcwSf8vgRdOqQruUhtk7dSPljDTT+0SE48q/v
         WkkE4A1WklhisyWAKjpiV56miS4I51N85Y/EqvnZS9bBMSvo4WV9YnanjUmutu2WTa77
         G2+twsyTUv4GYNgMtrdsSfjnX+YC9uzU1m2/HKfxnIe/EB76qex94JAgwkObIe/gL9CH
         gkG9y5Hr7bU6n7uoY2SgpVx+HfN2QAGOrTpZEmjF4YYEGQAEXkm52XtKE99R2f+USg3C
         RlFA==
X-Forwarded-Encrypted: i=1; AFNElJ/LaGQAmkJtRLnAjh1LZW85EsJnlpyYgwPRZhP+D2G33CWfNMTXZvgNiLhumsNW5qoFBmRGrAVqe0D+40juF1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/qhaFGPy8Z6ylQ4hjyeOSrnMRjMVKGduAFzU0SPWqZPI12TwN
	oAEfisa/SGqEtOS/n6raGEQTn/blfIsJyVtuWhnPJzp5ptWOKIaFPyRv4VB1DoOpZJGJ2TIIwg=
	=
X-Received: from wmlz4.prod.google.com ([2002:a05:600c:2204:b0:48f:f301:5115])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:34c7:b0:48a:54fd:54ea
 with SMTP id 5b1f17b1804b1-48fe60ecd93mr316640905e9.12.1779203902737; Tue, 19
 May 2026 08:18:22 -0700 (PDT)
Date: Tue, 19 May 2026 17:16:22 +0200
In-Reply-To: <20260519151616.2557018-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519151616.2557018-15-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1021; i=ardb@kernel.org;
 h=from:subject; bh=Ku3pRDk9G9j/NzX3V+jyzDs6V1KXE9BKuYBtWjFzJCA=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIYun7uSdmn8Xi1/JLnzWebNMa9qxsDn1W/8/E5t3/2356
 9nLJq5821HKwiDGxSArpsgiMPvvu52nJ0rVOs+ShZnDygQyhIGLUwAm0jeVkeF+J9sCHsZM9s+P
 1wYpNRk982/e72CvdncSS6EzizDTPX2G/yXHhFfdUP9v++DE/9cvj37ZIBhl2cD+iFf1/KEVwWU yrUwA
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519151616.2557018-20-ardb+git@google.com>
Subject: [PATCH v5 05/13] arm64: mm: Remove bogus stop condition from
 map_mem() loop
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The memblock API guarantees that start is not greater than or equal to
end, so there is no need to test it. And if it were, it is doubtful that
breaking out of the loop would be a reasonable course of action here
(rather than attempting to map the remaining regions)

So let's drop this check.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 4c6ef0d35714..cd841a392b44 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1177,8 +1177,6 @@ static void __init map_mem(pgd_t *pgdp)
 
 	/* map all the memory banks */
 	for_each_mem_range(i, &start, &end) {
-		if (start >= end)
-			break;
 		/*
 		 * The linear map must allow allocation tags reading/writing
 		 * if MTE is present. Otherwise, it has the same attributes as
-- 
2.54.0.563.g4f69b47b94-goog

