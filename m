Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326B037FF56
	for <linux-hardening@vger.kernel.org>; Sat,  5 Sep 2026 19:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788636586; cv=none; b=eWv0JResu9iS4EWBEqF7w9IWcCqZ5CzAwJwe1cmZNkCMO0Mqg8AcL88s6zw734qGInT/GHMd1PAxLv6s11DrdPvQH7hinUk1wJPuqZ505wlFvsLvNWZz1bBiFL3t/gNhR1IosotMJ9ShI1thpjpRqX/+y7rLKsUf7UGyAVkPJdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788636586; c=relaxed/simple;
	bh=q2x0WUHz2r8ueAKqk8Cn9VqXFBZAzyHK+DfKvxu66yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LIH2WmMk9nyW8ZVzlMey5BJjpW3JKsd45cvUWqNndA0Cgkydg8KaAQvjGZ/UA8QAwRRjngjEkqgrp2HgRAVEmmpe8PexrmvrTuSFLAlOs7LUFdCr+MulB59xRFhfpBlk1LWDMwMUskndrK/sUG2ksOQy57SRNG4vz+HURjg8GKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSyIAuxL; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSyIAuxL"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66e55430869so1421959d50.0
        for <linux-hardening@vger.kernel.org>; Sat, 05 Sep 2026 12:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788636579; x=1789241379; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KEzo1WzJ1Uxj/TIFMsQEInVmXuxuHLlSjkdBUICH5gE=;
        b=LSyIAuxLxlYC9L0DE3AP//fA9jN2EYDhc/0H7nzEkLAnCv/6T7X67Ziuaw/X+UyEcK
         H35KkuST3e1f+AIyr2I/Ur7xi7Ah3SlkWgogMNwc+ndijxh03aUC9WPmB5D1YH4lxQnA
         JgrYDZSUOsgIONndh/NWfcaZwZeBWpOoeV65+9bo+u0xjnw3esm+AEZx5OHwdkZBVw/I
         A+pBNHUqTh/W/WdJJOtbsd1voYjSfw2Kgbm2Jq2aoMlHsr3YrlXBVMy3YK9ve3Gir7lN
         mPMy2G5MYJGSfEi4S8IiRrIr4/M7kYnxUmFx+8ljy2IiEibAlC1uYsArtbg+RF0dKVNZ
         RV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788636579; x=1789241379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KEzo1WzJ1Uxj/TIFMsQEInVmXuxuHLlSjkdBUICH5gE=;
        b=DObkJL0QDCLOqJlNaeVXjxX2vPWvnVOXpxzKEu6I16fCElKMZ+Jon37CVklF0SpfWP
         lnvJ4sl+OC2TWvZe1/8kNyhF+DziQPidBCYPl0dijacxYjvwHCQkzHialR6nsBGLT+rD
         z7a9D19wm3qKZ4aIKKqXd/S93B54jsJqscIgNbmmHfBBuuN1Z25g8r0rFUQNyock07Wa
         PRJMWIUiG6XuyrFhKlDB247ra1mRA5shloWKduKDykNYwj74a9WSyOPrKmex/kinfg7Q
         UzBqmVcnCN/zSQx/9ZsikOuQJm6gZBUf4nv0swxcDwWovWDW8uM4X+3ZZN9kPX9sPEOd
         gk6Q==
X-Forwarded-Encrypted: i=1; AKwUvBxGA0DtGyKE8DaTsQI1z7tOM50SYrdWJQGWlyyglNArpVN/1ALUYn69hL4zIPqlJj9YNsNj4PvFIQIU9mMTTPw=@vger.kernel.org
X-Gm-Message-State: AFuF++ldH8iFwcbM+L44I6S1l+j64vzh9GSfU+AVvfAlymlIJ14gZZc6
	OsZTpqPFk0u6MDrvB/aG5BrH26Vku0t8HXRgc9QMPrQl+LoIQsS0sN9V
X-Gm-Gg: AYBFou0E2lFMdcLohrvu0iQivK3t82bpYibQ3TevrT3ckBGbBeIjnMpoFK0Qy+TY6sE
	2ifU7uLmw27nxODQ/yrYq3MNPbgJTEuEXF9wmksnzf9NGskncCfyV+lphXGsh1pZMBLvH6fYerM
	jVtUa+kJO6DZXGEhEGQRxHiv/0ONTWv4q6XOXAsM3WgjOWzOvBHbytf1eZY3o80Pcn/BsJH4fA7
	VlOvI/itFSR6GFpm9cSNNi3+ulvXly7Qux73/FWcX8SRPz2BInm/tq8ty2aGqTCLv/14XM/Q4Ps
	QtXy/DkneIREZ2cSeuZ7B64z//Uspn7BfDYoIHCrM9Q3N2aIXth7RATfylRjmpMp9ZmavbSqAi8
	HmWAOMSInfSEf6trKPiSJbkZKcjXHDt4+hzFsVmVU5B0R0eyrlv17fM0CTCJqo5GwxPSEU+XDMf
	7n/UcltSxxHS6flmlPGgOJmLVvmhDqbuHqowfS6qh4/6cgkDCCVI4G3H4aTkcB
X-Received: by 2002:a05:690e:14c5:b0:667:5cde:6f36 with SMTP id 956f58d0204a3-66fc1bb8014mr3388782d50.33.1788636578685;
        Sat, 05 Sep 2026 12:29:38 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb47a8894sm5071491d50.1.2026.09.05.12.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 12:29:37 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 05 Sep 2026 15:29:27 -0400
Subject: [PATCH v2 06/22] alpha: select ARCH_SUPPORTS_ATOMIC_RMW
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-arch-kconfig-options-v2-v2-6-83e8245761a2@gmail.com>
References: <20260905-arch-kconfig-options-v2-v2-0-83e8245761a2@gmail.com>
In-Reply-To: <20260905-arch-kconfig-options-v2-v2-0-83e8245761a2@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Kees Cook <kees@kernel.org>, 
 Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
 linux-doc@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1013; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=q2x0WUHz2r8ueAKqk8Cn9VqXFBZAzyHK+DfKvxu66yg=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLm5E6WtGqS3pvKJfx1ye9TR9bu+rTb+tTCMxrC0+Nqr
 zmERf541/GRhUGMi2GmmCJL3HpFllltO5b6nJb+BTOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GQIZOkbxEDk9Bo3M4uLS1CLdtIIih7z8ksSSzPy8Yr38gtS8gvQCvbTMtJKMjPyi4lSgEXp5qSW
 mro5uRoYGJpaOFmZOFo6mJs7OToZObo6Ozq5ORpbmJgbOlo4mrpbmDFycAjDXMB1g+B/0deOFT/
 cfTA/8meDMFqTk8UHidPbMADf35Qc2X5RSue3EyHD2pv70ieHKQsd6TS+0Cqa5n4zMteB/1iYnt
 Z49VK/yAgsA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

Alpha has native LL/SC instructions (LDL_L/STL_C, LDQ_L/STQ_C) that
provide atomic read-modify-write capability, and already selects
ARCH_HAVE_NMI_SAFE_CMPXCHG.

Selecting ARCH_SUPPORTS_ATOMIC_RMW enables MUTEX_SPIN_ON_OWNER and
RWSEM_SPIN_ON_OWNER on SMP, allowing optimistic spinning on contended
locks rather than immediately sleeping.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Matt Turner <mattst88@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 032c23f979c4..d039b7135d18 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -14,6 +14,7 @@ config ALPHA
 	select ARCH_MODULE_NEEDS_WEAK_PER_CPU if SMP
 	select ARCH_NO_PREEMPT
 	select ARCH_NO_SG_CHAIN
+	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select FORCE_PCI
 	select PCI_DOMAINS if PCI

-- 
2.54.0

