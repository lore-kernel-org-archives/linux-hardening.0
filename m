Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9553242C3
	for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764235377; cv=none; b=qPOr6Pp1PgZS2winvYtu98Czq9yDPBRIGCoL7YGDuw4seCcWTzKrQCRaAwk/Tsv8ZXYQ9quIAMtveMRU6z8KNVEhjOUR0m/QX79vrs7fwhXCeRvW/YbsmfVXSnqESbR9WTugpPHG2E274G+m3NB/QNNm0+hEMnf1eYklF5jN3dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764235377; c=relaxed/simple;
	bh=5pU8T3R8EfCbCbbm9FQnjNIKnM4Oc0VA2KxjEL7tDKI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=av1ppr4Rd99hYrRcMIw+fDJL+HvC04mdDRoUIaeSyA3unHT0NgHD1oDs9d1mPUh3ansSOit6SHElU5PpO/sd3leuFJtTZlu6FMN+zDj3XtzEydxjVitQCce6SXM22DHntMF77ivbCEEvsebdwuCDISWKOWexRmdE4eG92EZkODo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UkA7+Gvy; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UkA7+Gvy"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-42b3b5ed793so410504f8f.2
        for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 01:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764235374; x=1764840174; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lm8/PsD24JkqtJEBb/JHL05JmcK80K+YBsbDIDkSPDM=;
        b=UkA7+GvyMvUjv3iPLCdYg8o+5CUVRL1ncq5gdLMjiOtbOthuiglXgfK+ydxFcJd3AC
         lo6ER/rjiLjPGA07DsHTLzhAcZMc5tJsotFoJGEBHbun4e5AR1WwmdeagkfJ8OKDdUZe
         CbCvC+lQdbg3oj2VJ/RHRFwmlupxKeqgOS/tCCm+uTTGBEFTkgLNlPPCySgrtXX/D4gZ
         1Ohj3jhJv1/teyIpaGM0e4XtANKbQi7q0GhKia+eepsUIVvxL6zuheDHAxzZZ4QHJfvD
         rKGdlEniApnNQ62L+LHpW+HwgUgJmdMx5sZcwcdYVVMirys0cqq37OgKnerKYZYwyVUu
         PwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764235374; x=1764840174;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lm8/PsD24JkqtJEBb/JHL05JmcK80K+YBsbDIDkSPDM=;
        b=gBaRMXA4rzRm+qiCljXfAjJ10ZvD3Wqbaci4oHcqH7mWSYx0azs7Lfj4n4vQ4Aew09
         fsNpIjRsmyMOiIj2o3JEq7LY5lFnB85U8iTDpIO1xX/fZy0XpTmChqF8hAphz+jmXjIX
         HpXhoswxZVDMoFcnSiIebyfPRCTo7YWogmgeXzScD42fJFiEHCl4WDKQBzyL9X7akVG/
         pU5nSVdkfh9QQPehKXctmZpbFPxf5bBW/jAKsfrpKuOyZKkOQnkotzo25MAl6EcLF/ga
         7Jd6WhdeGqLqJ1IWL4jslvXcv8DL2A1guccxqiy4hptns7lSkkVPdzMxBmud4viuZz88
         00Sw==
X-Gm-Message-State: AOJu0YwTZMi/YN2qHpiFu45/IvB6z7BbkOAYCTj5qZyUerzWoZ90DyOQ
	Mx7Ch4BtkMy7Z0Kl47FK1IuG+MHjiYBH5YOKBYUmqBzJ5WcxXzLFhIGcYNVweXJtpWBc1CT/gB0
	3ULf3FsUfFApGTWqRkYCAdrAo+XMJWIkjVUb9ScL1kC5LLeEAx0fSwuQ0XeKarY33IVHZ6AtvEa
	TfIpgTp19rka4ymyp5GonVhPbQDJTw9xCpfjEfhA==
X-Google-Smtp-Source: AGHT+IFiRUSTUyUmmDCfp9DRVB+ITplmlr8U1Vk596xaInsS5h9GpzAVehE1Ma2+bZO9lWJEhGAZ3DXo
X-Received: from wrwt2.prod.google.com ([2002:a5d:6a42:0:b0:429:de3f:8280])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:1447:b0:42b:32c3:3948
 with SMTP id ffacd0b85a97d-42cc1d0ce41mr23885901f8f.31.1764235374004; Thu, 27
 Nov 2025 01:22:54 -0800 (PST)
Date: Thu, 27 Nov 2025 10:22:28 +0100
In-Reply-To: <20251127092226.1439196-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251127092226.1439196-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=875; i=ardb@kernel.org;
 h=from:subject; bh=LXaoefJgP6t3V697yrG8QR6lNpOK4nbDq1CishfTlx0=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIVNDItRQuip5xYWJK0Jad7HG9b2/1b1Fii33VdirLhdnB
 tc7m+w6SlkYxLgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQ4mRn+aa9dL7tAoXn35YWy
 QSLC104ZXX9x+MnM33/3+icp7VJvc2dk6Fganr6zP8NI1tT1wnbPW+tMZMK2Xolc17SUM+bHreX qDAA=
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <20251127092226.1439196-9-ardb+git@google.com>
Subject: [RFC/RFT PATCH 1/6] hexagon: Wire up cmpxchg64_local() to generic implementation
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-hardening@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Kees Cook <kees@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <Catalin.Marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Provide cmpxchg64_local() for hexagon so we can start using it in
generic code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/hexagon/include/asm/cmpxchg.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/hexagon/include/asm/cmpxchg.h b/arch/hexagon/include/asm/cmpxchg.h
index 9c58fb81f7fd..05e426475d2a 100644
--- a/arch/hexagon/include/asm/cmpxchg.h
+++ b/arch/hexagon/include/asm/cmpxchg.h
@@ -8,6 +8,8 @@
 #ifndef _ASM_CMPXCHG_H
 #define _ASM_CMPXCHG_H
 
+#include <asm-generic/cmpxchg-local.h>
+
 /*
  * __arch_xchg - atomically exchange a register and a memory location
  * @x: value to swap
@@ -72,4 +74,6 @@ __arch_xchg(unsigned long x, volatile void *ptr, int size)
 	__oldval;						\
 })
 
+#define arch_cmpxchg64_local __generic_cmpxchg64_local
+
 #endif /* _ASM_CMPXCHG_H */
-- 
2.52.0.107.ga0afd4fd5b-goog

