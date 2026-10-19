Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED1B2931D3
	for <linux-hardening@vger.kernel.org>; Mon, 19 Oct 2026 01:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792375103; cv=none; b=ks86g0Z7YMp69RcgrrAwkg7ldC3MlFe5BVHhB9zQ4dAT33Pm2xYEP17uef+Mg1p8ZLkQOCOEXgpEyZeP6btuLZRrIKgiJmh/7Oc7jzn3gq5+V2qAXP+XSiK8qu96wUVKl79+BW/AfpmHrHR6EqukKEB1lsXSKADMG7XgxiAD/oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792375103; c=relaxed/simple;
	bh=IvgpY5vdVqEpCEAsZKzoB7BbMpzUVF8+3uNWD1OUHNc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hUSx89vgtp8smPKPU5cRTfLzL4p8GB4bg2rYOHKOBJx4Cv/44achWkoitOtt+63/gqjsQCSTDat98M4rr6bdb9HgA6Fc6zASr1IVNd7AQnaQkd7b+7N6q+rYZh4W7QG0Qt9m7tRjmRB9Irjcx5l/c31LaFvISeQ1ErwUbKUiNU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cndT/ivD; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cndT/ivD"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-17bc533fda3so1736905c88.1
        for <linux-hardening@vger.kernel.org>; Sun, 18 Oct 2026 18:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792375101; x=1792979901; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DIsHUtJOv8JTVFKl2AI7iFPSk57QktOjQTbDJ2/Phac=;
        b=cndT/ivDicq5kDK3cPUhETpzYzGDIDiSeFFuKde5Q97EeoxUYr2TTWIRJ1cRzieW7o
         tO5tatlKgakdZrxY4q7zVjPH5LYdTyH2tefyLiQWQXRC3xW9ZuauFq+goFKdQa7HwxoQ
         J+lqPjAEbtSfaS6ofD9Cnok7iY2/yhvmeYCDteshy0zrv7347A0yMmO/5gzWT4AHFB2a
         uNZxX3EOI3aSjnTNSqK9bHxMbw4PsnLG7qfntKUxZJO2I6fDCLr/vCY+jlLAgb+cgihh
         4baB9B9uithiQUZqHU366ycEoW90URbZfhoGoleIZYKNmMV9a+KssQeTHISo9VVZAq/o
         f1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792375101; x=1792979901;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DIsHUtJOv8JTVFKl2AI7iFPSk57QktOjQTbDJ2/Phac=;
        b=Z84//6jP4DxaOIbh0VEj+FLlxyritOknJ/wz+8H7XIcCTuldUMkFtx7+MLO/7m6Eft
         5Fb2QU6lDkeCtxBTQkzTAQny26LP8KGnWtIWY35Eh/9zm4AY9r34MbEnjHBhRrM4768z
         itoejKuQJppAPOmLf2gteCjg6rpu9e/OHLpqQyvEnKj8rdDv359/jA18Ekf/nxjYuMp3
         67VZ0nCqCOCojwTUeHLaBX2NeCTIA0SRATol6OhKLgw7lMSTidv8Oyqg40m/HBVK2UnC
         EOewn9McUe8G2L9nZTFG29WtZ+yjmsn0A42CVB6BaxQVZ6Y+T65t/x3i8PX2BkNC9TXz
         1TeA==
X-Forwarded-Encrypted: i=1; AKwUvBy5URu9MGvi8zuSAAKaz4FSEa5yZc2XX+T+7kKZS7nvANkh4/lenWhSU6lCdqxLdv1bIb782gHSrUzVKVDnVks=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEENt9UYHDpOVAov/l5zYZGHNnXWsvceOFCFTRQoE04S6s+y5/
	RwRVKzS7kwQfaCWJsEnbGEyYAuMxsTFNtEiRK1Vhb2f6yeyWJQPW1NgQ
X-Gm-Gg: AYBFou1Ce8d4beJZ6gfDRD6giUdQITZMMFdVbYTnfrt5fYsrfad3McOxILEGHChK5cg
	s2L+0BsUgWGII3FhNjrkOM69N9EEUVIE7bahqiqM+ML2VweIrKZCh2pvwWyXiH8E9sn6O6Mxhv1
	O8XpWYQYWzOhfq8t35Ymit0NBoI9+w+YZ7bmEFU+LRGXMxdKlR3tYwgjPZWtw+mBhAMudjrWiTo
	kHXZZhcKtw6z/CckAlUI2E+hFBy4j3Coyhrr2jApbaBjR37R8TiDRrAzdsGgfAF13Oa/kHFBH5L
	vF4vNaGSBLaVOWOCI4fjZooda5s1LP7QXMfgbbGG4VBeOwvhI9BnZ4RIncKDLqBHtI3lnDgpeF4
	HPn8lQ9pkkyeyW1QO1zyHo1etNqiY6zKy5NxhGFokUNYCaaHPJwky/9GY5JXDEjrP9bkxqJQexo
	NDlYK+5Eodie26GcDzOaiZzhPiKn47VwLNS3/3sya5kde6rwiNnMWMxBU/5ivXtUyBUtU=
X-Received: by 2002:a05:7022:150e:b0:141:b2c3:d84e with SMTP id a92af1059eb24-185120a8bb4mr10990864c88.11.1792375100720;
        Sun, 18 Oct 2026 18:58:20 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831ba424a6sm24177311c88.17.2026.10.18.18.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 18:58:19 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH 0/2] word-at-a-time: let KASAN see load_unaligned_zeropad()
Date: Mon, 19 Oct 2026 09:58:08 +0800
Message-Id: <20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADB51WoC/x3NwQqDMAyA4VeRnBdoiwT0VcYOmY0aZK2kTsfEd
 1/Z8bv8/wlFTKVA35xgsmvRnCr8rYFh5jQJaqyG4AJ55zt8vic8skXkDRk3fQl+xfLKERcunJD
 H0JJriUQIamY1GfXzX9wf1/UDDOF2FXIAAAA=
To: Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
 Marco Elver <elver@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Kees Cook <kees@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kasan-dev@googlegroups.com, linux-mm@kvack.org, 
 Qiliang Yuan <odys.yuan@gmail.com>, Peter Collingbourne <peter@pcc.me.uk>
X-Mailer: b4 0.13.0

load_unaligned_zeropad() is inline assembly, so KASAN and KCSAN never
see the word loads that sized_strscpy(), the dcache name compare, path
name hashing and x86 csum_partial() do through it. While reviewing a
strscpy() KASAN fix, Peter Collingbourne suggested checking the first
byte inside load_unaligned_zeropad() itself, as read_word_at_a_time()
does [1].

Patch 1 adds that check on the six architectures that implement
load_unaligned_zeropad(). Patch 2 adds a KASAN KUnit case for it.

This is independent of the strscpy() fix, which makes sized_strscpy()
copy byte by byte under software KASAN so that every byte it reads is
checked. Either can be applied without the other.

[1] https://lore.kernel.org/r/CAPQLkRhXZwozmfhNd_PEx1ihwdH1_5qthP6PANYJ_m-v9vfQTw@mail.gmail.com

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
Qiliang Yuan (2):
      word-at-a-time: check the first byte in load_unaligned_zeropad()
      kasan/test: cover load_unaligned_zeropad()

 arch/arm/include/asm/word-at-a-time.h              |  7 +++++++
 arch/arm64/include/asm/word-at-a-time.h            |  7 +++++++
 arch/powerpc/include/asm/word-at-a-time.h          |  6 ++++++
 arch/riscv/include/asm/word-at-a-time.h            |  6 ++++++
 arch/s390/include/asm/word-at-a-time.h             |  6 ++++++
 arch/x86/include/asm/word-at-a-time.h              |  6 ++++++
 mm/kasan/kasan_test_c.c                            | 24 ++++++++++++++++++++++
 .../powerpc/primitives/linux/kasan-checks.h        |  3 +++
 .../powerpc/primitives/linux/kcsan-checks.h        |  3 +++
 9 files changed, 68 insertions(+)
---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261019-bug-word-at-a-time-zeropad-kasan-af2460466ee6

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

