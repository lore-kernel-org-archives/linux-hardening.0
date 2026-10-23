Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792720199;
	b=3bV5Wquz4TsRvi1ZttQGWk0snEvaRGrIUqRdN2dCugn1JYdILD2meDKdg5YiKDCWwN68
	 v1msb2Z0BHe8dUr89wwJEEjSDw9PP+lWrXenpfDvmaW9dN2q9PTx5lVW85sENYz7+YbwS
	 l8FCNygK3bOfb8ILc/Vmg6LMANPHRkBcVIxhC0uaQcT7b00vNEqin8++kEXJAFYOA8k7p
	 kXPdtuCEi9ld8z5aKpvvTxE3DBfVt7TMC5MjuAtO+rs3mU5App9CeWio9ITunn/S3j8Kl
	 8JW33DBRW/fshINBDEFYhC5hWuYiM7iyLgMhukP+baU9tDSri1Huw1GrZLtDaDyNQug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer;
	bh=+p8cIpnt0YjLXT/3n6WuKQxFq68+6JJEn3PVDsIrB3s=;
	b=efrD6zZJPOpuOZJwMXmEdF84hwmUbdVMBWqft4MblFbqzg4NNhCXwCP58jaXlIpCsOTp
	 78+UTGSgNNBx7wubqxJktlvL8kZ/1tyM8NHM1tXq3QWneCdvYl/ylG3dSKk4zctLfERfw
	 5ie6lHjq9Ck7IC+uRuD8YFYwZ+oXoEzAdtC+ipdxbQpkW2eQd7BetTB0/QJ/xKoZNE/23
	 PZqSc0325dZmpvP6PRWsX5c0vf4j3KLhwNJ/jctJtiy8LKQJH5HOOB2Hb2c20o7zc164p
	 +0+PxriPKxJAVDT8hFOOUTp030FKA6baSDw0WGrrQJOtMEM4vyMnfy6hywvGzJ6PwIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PHs0evTi;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D89F606A31D
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 01:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D89F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PHs0evTi
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-353804b591eso742838eec.0
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 18:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792720198; x=1793324998; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+p8cIpnt0YjLXT/3n6WuKQxFq68+6JJEn3PVDsIrB3s=;
        b=PHs0evTiNgq7bTCxWxmObhVX3ilYIc4d8fs7f6MAKtrZpjcCuj6KvG4PaaNKaCq5OP
         vd0bn33Vmr/5vjZ/OgMwLA7+m/y+AGHg46jurwktN5DTEhdbX3DBjeLk8QkRfaS6Aao/
         SbxIQWUMZ+xqre+Z3Nwo7JAlI8CQdOX9RJEafX7unWxlJsUhZF2Re1wNvzkWBo3YVvyC
         Sm2ZJFfP7nSxLE6xo0DC+Zv9m19JmbCRS5JuHSkwa2zpHDknf5RDPlTYWVx4aNCFPsZk
         93M5iuKr/eLBeRBe01Va3QWhV75VKJ3DHKUbvSiL1d+g0P04+8WVrTfCeFmzkCI3PQUc
         kYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792720198; x=1793324998;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+p8cIpnt0YjLXT/3n6WuKQxFq68+6JJEn3PVDsIrB3s=;
        b=pWZjXXxGfkKPjGpUNJSePsgoseCDEA5p5cnXHEDLy6IGeLNtiSB4e8DIsIxgGaOYPp
         t4D7CFVgfjqSuQBklGqkA1Ou7phRVZPmhjEJ/WRZ9iPE0qLA93j/znojtUN8489FuVU8
         QD2/Z1fxkJUl9vQgfeOBvk5PAOWv0Nz7Qph6RcygJVpgWNtrXAEG8mAGyvcPv8SXywuf
         rvpoY4CoF1pjCXCsaSEdl91Ox1Fdq+ax41QtmcGaXfNmzEMUM+MsSWdkD8qHI6VH/B9P
         RszEv8rb8unuliGMFkqeb5jYHqujy8pqb6rN0/yIuZpXCSPSRflkeDRX4dTJsbhrNtZJ
         emiQ==
X-Forwarded-Encrypted: i=1; AKwUvByMkchzPgiGwxzCLVUC6yUdJwQMcPQu+yYq83xoI8g60NOgZa7T3sQKH1LY8clJAl2uF9nj9kCQmWctgknLvpU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI524tJCbr89F6FmPEX9pw0hS82JqgyGn1GX5eeBT7LXjp1pr7q
	Zc6G37UyvgRdPydfiYAaBa87SJPx5KZ6eg3SdH4KuW+6z2VVqn65MAFw
X-Gm-Gg: AYBFou1rFiowWE/QUpNFvXGztwB32S05HwtA87912VoUckfXBhQ9Y9CL4klSZuldyy4
	VtoxM9OZDLZYVvskekVBphUR8F020jASavz1BZvXgmyyWLYFrtmR0Cs1bt12XbOXmApmFAVhl3Q
	M4cCPjgMRaqUf+9ruKT0oZvzWREUQixo0uCAPTqS3JECTwa1QvN9tqFaoGwS2p1PzDHUaH33tyc
	ahqp2cRefhCU8LLz151hEpj+q6euOkEKmFR9/9eHeqGoUMqRNg0e4TO5yfLY3DA4uXUqVxZ+g2v
	FTqx4vvQZKZL/A8Hiz5QZ5FxMSMtD/jLY4kvKViXaBrF0AMgceG0YbRoAZiGARMjmnwWYDVey/W
	+l7EjKQCyPj/Yx1eU0IQsfBMgswN6SkpdRpgWmAYKpO0WOgKCdqZ9ng1RuzYXy5BL+QhE1Stwlg
	CjsOIp+jBN/Sm/C8Oz3YLhPCL3QTG1N30eI7kRlKCY8GEUe6cG7EABmbR8ihC1j/B+IT9qsIK4L
	GlkEZb73JnqpnHuasvNV/fZW5riu5tyiX9JFTF7ZGcm9e9dvT0=
X-Received: by 2002:a05:7300:c00d:10b0:35f:4780:518e with SMTP id 5a478bee46e88-369d97155f0mr1233857eec.16.1792720198309;
        Thu, 22 Oct 2026 18:49:58 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9c0e60dsm1971091eec.2.2026.10.22.18.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 18:49:57 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH v2 0/2] word-at-a-time: let KASAN see
 load_unaligned_zeropad()
Date: Fri, 23 Oct 2026 09:49:47 +0800
Message-Id: <20261023-bug-word-at-a-time-zeropad-kasan-v2-0-be0ecfbae847@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADu92moC/5WNSw6CMBBAr0Jm7Zi2khJdeQ/DYqQDTBRK2oofw
 t2t3MDle4v3FogchCOcigUCzxLFjxnMroCmp7FjFJcZjDJWK33E66PDpw8OKSFhkoHxw8FP5PB
 GkUak1pRWldYyW8iZKXArr21xqTP3EpMP7+0465/9Iz5rVNgaTQd2lsqqOncDyX3f+AHqdV2/W
 tfq3NAAAAA=
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

[1] https://lore.kernel.org/r/CAPQLkRhXZwozmfhNd_PEx1ihwdH1_5qthP6PANYJ_m-v9vfQTw@mail.gmail.com

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
V1 -> V2:
- Call instrument_read() instead of open-coding it (Andrey Ryabinin)
- Keep Marco Elver's Reviewed-by, as the check itself is unchanged
- Rebase onto 7be4bc52fd9e, which drops the big-endian branch of the
  arm64 header and rewrites the s390 load_unaligned_zeropad()

v1: https://lore.kernel.org/r/20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com

---
Qiliang Yuan (2):
      word-at-a-time: check the first byte in load_unaligned_zeropad()
      kasan/test: cover load_unaligned_zeropad()

 arch/arm/include/asm/word-at-a-time.h              |  5 +++++
 arch/arm64/include/asm/word-at-a-time.h            |  4 ++++
 arch/powerpc/include/asm/word-at-a-time.h          |  4 ++++
 arch/riscv/include/asm/word-at-a-time.h            |  4 ++++
 arch/s390/include/asm/word-at-a-time.h             |  4 ++++
 arch/x86/include/asm/word-at-a-time.h              |  4 ++++
 mm/kasan/kasan_test_c.c                            | 24 ++++++++++++++++++++++
 .../powerpc/primitives/linux/instrumented.h        |  3 +++
 8 files changed, 52 insertions(+)
---
base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
change-id: 20261019-bug-word-at-a-time-zeropad-kasan-af2460466ee6

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

