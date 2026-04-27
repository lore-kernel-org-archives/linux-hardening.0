Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF72346FC4
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304139; cv=none; b=sYh+AULnZ4wl+Mu+H/DfnCZkdH8nSrqZCbQUnoPWsDiJ6CJLDtbt/m0bd3hP5CFqQspoXueqihHrG8YV0FstR/oyOIBL6PooijVVEYZCB30fAr1Qo4zyMA39dzYCLDZbhJTS49p+XYTu5qtlbGRqvoZW4r7S1YYI4O2/82zJ6og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304139; c=relaxed/simple;
	bh=DEtCdbcQASaDQouORSj9oUIdAtG/cwaStohTOB0WxM4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=URiOu47jXsTMv+Z5xa20x5jtaEowsmVdM7u9WMCE8wTftP4U92KlDpaOgX2GePNTYmI8IhFlgc4JNrSqB2ZVTXt7iwIc7wfgKiuiftg/649DztJO4vu1YbU8QGhE7cc2K6hHoawiF/ykaGJGqX3yjvQUugkC6clw7VeM2DIIG3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ujMJvyru; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ujMJvyru"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-488cc31ea57so80247785e9.3
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 08:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777304136; x=1777908936; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=etH/ucf0ROVAevEBkHReKesjYkPK8m2/xS+mJi9/Az0=;
        b=ujMJvyruB43A0JqS4KmdDUuXrwKbIMJRo51BwoUBY2BkO/60c5EIBcY66uPKYZVcab
         hC2Rxw2qOwTkqIEwJdZsdtgt6Jt76NjvSjfTuvPu9GQp7BjAXP/SyLDUYpspByTWbSGL
         Zd+G2LqXUI6mmpyd8SqLe1oS7pJzjp93g3hpXMkdoMRv88PqI9IPuHV5UvdBr81FIoBf
         5V3fDn9RmvRl5Uv3VlYKzphat9SWDt0gfxOcFhNjc9kX9ePxqwqlim4f5JGUtXlcFRc+
         Dr5C+WmHMcSELnrPW+OPdDyVPyLARYdL6l2c5S94YIB83SCZ5gWQsCRRDIXTg6AOMq31
         20eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777304136; x=1777908936;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=etH/ucf0ROVAevEBkHReKesjYkPK8m2/xS+mJi9/Az0=;
        b=QiR5eSL2aXOhtKAV/wG7yuy/FVS5RDyYFJIjr1kxjzntxTqENhNfKQfwAQln0J17uu
         y5qAmVIaSkXmmve8AO1qYRphLTLeJEGpK74+YdcHDVAekCRL5vr/qJi6SkJ93hkOcXo0
         Rd6BvSF5ZNzN3jMZ2SNgUiRzZtpVprnekEdML7ezw4sp1KyvIN6Ul/X+PnIM0+Wez4CM
         sU+pjWtgK1IbmkAvQF1J0qOvz/5xdCQCOlKh4dKX/LsEjoabB161yu7eLo+FBKBsoe+k
         cspglRwbncmfF68Ae5auHkD5xDDD0kq4CCGSXaDW7/REyA47c9femLZEoxcOyeXfCxi1
         Yk1g==
X-Forwarded-Encrypted: i=1; AFNElJ9tv83mWH8RRFSk+19dYYpfFQeOKIHvrXTj6nxF7brNiQW/cToXCp6tf6hdwbVERkqmZL73lsM8VBLdkUarIkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN1frhIxEG7yPJ/IIwp4sLO8MrhcRfDFcpHnHX+sgN6GOi6Nif
	CoFwZVBjaWsrF9Ql+RFS3SnwTYPkb6T0IBv4C7Q0PJZ2PgnVznEXnriUSz6EbHn6xAOH3N16lA=
	=
X-Received: from wmcn9.prod.google.com ([2002:a05:600c:c0c9:b0:485:fb9c:ffa5])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3e0d:b0:489:6c28:dbc6
 with SMTP id 5b1f17b1804b1-4896c28dd4emr454740575e9.31.1777304136468; Mon, 27
 Apr 2026 08:35:36 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:34:19 +0200
In-Reply-To: <20260427153416.2103979-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427153416.2103979-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=ardb@kernel.org;
 h=from:subject; bh=Xui4zHPMyqNAfMojX3d72dmyPg9HBiaeXXlaXljmfJY=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIfN945+SRZJXH5vdEE+o7Yvo32RxfuaV3S/5HSeeLwufe
 mV64bHIjlIWBjEuBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjARpwUM/6tzU1eeXBAlq+Z5
 +VDlfPmd8pIhfj95ZQ8bhFlenPP7LBvD/7yyGqPIczsnJ5sZWSR+cbBZf/Xwp98hlSGvVEzOB0r eZAIA
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260427153416.2103979-19-ardb+git@google.com>
Subject: [PATCH v4 02/15] mm: Make empty_zero_page __ro_after_init
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The empty zero page is used to back any kernel or user space mapping
that is supposed to remain cleared, and so the page itself is never
supposed to be modified.

So make it __ro_after_init rather than __page_aligned_bss: on most
architectures, this ensures that both the kernel's mapping of it and any
aliases that are accessible via the kernel direct (linear) map are
mapped read-only, and cannot be used (inadvertently or maliciously) to
corrupt the contents of the zero page.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 mm/mm_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index f9f8e1af921c..6ca01ed2a5a4 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -57,7 +57,7 @@ unsigned long zero_page_pfn __ro_after_init;
 EXPORT_SYMBOL(zero_page_pfn);
 
 #ifndef __HAVE_COLOR_ZERO_PAGE
-uint8_t empty_zero_page[PAGE_SIZE] __page_aligned_bss;
+uint8_t empty_zero_page[PAGE_SIZE] __ro_after_init __aligned(PAGE_SIZE);
 EXPORT_SYMBOL(empty_zero_page);
 
 struct page *__zero_page __ro_after_init;
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

