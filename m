Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91F1328B62
	for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764235378; cv=none; b=QeIt/YySniF3kA7H+Na7XChPHp9Qky78sCoXSGNbPa6M+DOfXKq4Wk14PBbrxjyoQKieWgmx0v1aRQVKxNoTHCuBzvdZNCmOPxAoZd6uRFE9+lrwQenQNOXtBblc8ejBtR3oTs/w/XoBouEHp/E571kLNw3X/gnKsaT3QiVgQ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764235378; c=relaxed/simple;
	bh=Ue2OWN8dxl4S1oCDpiOXA5V1r7n4OPJH5dF2+7O1GlI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u1jlzQSf9J6+yh5xp2elvGOVsdfngqONdmpGixxFungb5l0eT3U3HFIF0Z+WROkcX/2dqkpp78tnUAqcUVMK20JPPr1Guf6btW0oDmv3QAW0VdVL+tptnfUBqxCaVvNC+RRv6E0EZPbC8tooSD2TaEMfiXWfnclD3eZVVKn/jkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A93bpXOa; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A93bpXOa"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b764b80358bso59385866b.1
        for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 01:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764235375; x=1764840175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nxY6K3VXBOtHUoqxNWrBAsAGxnWGhHRmDGILp9vXmzY=;
        b=A93bpXOahsQgW+Vy8fvUntMEmJfgeMYfjDpj+zPji5/hYLF1B3XkncUIrWXZ/OSa6A
         hwzyWDyNHeWssLS9f93I/QJmU8CDUtwVhFutQBgw0BttV4bY1L6ljGRI/MrdG/mM3bXV
         w/TDhl5HrYCU5ciW3/fHfASaHPiiCfGFBThWs0uXx1DG6Si61xCi4akLXKs74yioD470
         9oxd2+Zuyj0aZwP8C67bFUuu1RkEbaGNCotjqrXDem2XeYRabfwcGjuBrmO21dTMMIRm
         4qV8UZRUEfjExMj/hIDF7WjMY7KZjReWFZrg9RufodtIza0v6gQu1ztT8NXImXDuIuJG
         qnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764235375; x=1764840175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nxY6K3VXBOtHUoqxNWrBAsAGxnWGhHRmDGILp9vXmzY=;
        b=a5mMcBAcclq57tcDn2XpIKEQHx8mN95ckcvzKSqm8FrjGG5ORXYV/U6x+HsGRh+6yE
         aYYOgSOH74aC3XjoVt0g4RB3EOSZOHT+yhv7lkkB4uef03JX97S3N4hDhmAqHPH6AQ67
         20BYblpEIOdjxDjZtjL+ukgVnBzuEnGj9UFFU5pZNEoSHJE3adSVEJdxWUi1tcSCIn8a
         qGSCp2ni8L7ZFOHw6FUCiWqMIvaP07TMFxVfTDfW6WqVoD2b22TbKF5AXbsuGTNVHw0E
         lcqLt4xziD0P06Qr0lJqdQ1q8c9+ScnZEoLZ6WKya6CRm8NN/A0+2L96r1zRw4X+piha
         TLlw==
X-Gm-Message-State: AOJu0Yx56SvDTJQ/rgi+q6Fu9DR7g+mbi59kAks7h93+mqCcUs4XS+S/
	/9rBdYh150t5oDss2qdrselqdVxWf+LR+hBZnISLqE1dhtnJOguO0wPVa040EbJDLa+Wp3qTdsr
	1m2f+TyK4tj2P9XmmnQScwiGCxdCTP/ARcAvT+noABlbB6oLPZ6LoQ43F2qsIZb6guQCPDka/aU
	iMB7MRbPMU3XO6s2YyMknVJNgD6kt/X1hdcmn3TQ==
X-Google-Smtp-Source: AGHT+IGFdDZxAqRvQLpZk6/eWvniWko12T2iQL0bdLzORuqHked+ojY3yfI07AtzD9o2ck5cQMXXIq6+
X-Received: from ejcvv1.prod.google.com ([2002:a17:907:a681:b0:b73:36a1:4995])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:3d90:b0:b0e:d477:4972
 with SMTP id a640c23a62f3a-b76c54090f0mr967515866b.25.1764235375046; Thu, 27
 Nov 2025 01:22:55 -0800 (PST)
Date: Thu, 27 Nov 2025 10:22:29 +0100
In-Reply-To: <20251127092226.1439196-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251127092226.1439196-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=697; i=ardb@kernel.org;
 h=from:subject; bh=bPOIFl7qSFo8fyyP7vM3iVB+S1w+UZidjo3tNBxTCOI=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIVNDIkz65cQ92/8IPf/2+Omz95cLdJSj//5xu/T6vgODl
 7BcJ49nRykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIxyyGfxY7e1+ncsRubd0+
 r/dYC9upMAneH5cXs1vfeyHuyNHMVc7IMOWVVNRJEeuexw86Pyaei/4Wy1X763/6xVc6DttPhKw q5gQA
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <20251127092226.1439196-10-ardb+git@google.com>
Subject: [RFC/RFT PATCH 2/6] arc: Wire up cmpxchg64_local() to generic implementation
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
 arch/arc/include/asm/cmpxchg.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index 76f43db0890f..f2d55823645c 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -12,6 +12,7 @@
 
 #include <asm/barrier.h>
 #include <asm/smp.h>
+#include <asm-generic/cmpxchg-local.h>
 
 #ifdef CONFIG_ARC_HAS_LLSC
 
@@ -142,4 +143,6 @@
 
 #endif
 
+#define arch_cmpxchg64_local __generic_cmpxchg64_local
+
 #endif
-- 
2.52.0.107.ga0afd4fd5b-goog

