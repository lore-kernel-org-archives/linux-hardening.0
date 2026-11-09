Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240047;
	b=fgBTviANHEku/Q8gsx3/IrBGGPnhbuWON+uWcnFZqJbZyKi2oSsyhhaELF7CAmytpta0
	 NdRfNlhv1FQMSpMUv9T+Njh7YIDYVxJ9RIIHhRYJRYTgNV82DYqp+PJzDO5rm5rCYk9B/
	 fEgC+8IeBgj0qvmEqHJ8lGhOBhKqh5uwdZfsGPKTpMvm0+R6XfJJe5WBOHfCJ/rLtZDiJ
	 XgWEOioVsBmEaCaChs7+rvjy8NqR+LffRE3xgqgZOeMuqZ5VMx60z4NNpHt2R2EY5Pup4
	 raTkwR6kdWQJoKCWwpvGU5Dr2JSLe6P66AcuytZ6sgpLLJYAuiDpTFfbVyfRn+BP4vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240047;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=3hwk2GB5E9yuK1j6xly70E+Q1WnRkihoUhyrxhgUk1E=;
	b=BeY4Y9sDrZ4PC73Vndjl5tc1kT72V7TWI+UXGVkX7xPhn+HYdY1q1omjS0sbP2yPdV1l
	 DKMj2gRc46vzBC1Hfyr56mmwU/wONTx1l5MYY9jd/3NwGGveOq3KAIB3I8CNSaC70cS6A
	 HH/NGodvts5KB1q2qOyL0/7YCBReAY5v6PtUA5b2QOwUNve4tQ9iBCjMzNJsGh6OThSiN
	 k+JlISdw8vNUnoT0gpIpcMu0TsXKD3q5X3dR1YXmvBXT1zPl+HrxilJ4kiow4hnYblnz1
	 WAKCFXfKwoCVopO/ihw0w7fZsbQGrWHdeKqbmzpKnYlPw+ASz/AqPJ2DkgaefwpQLNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=efhrXBeT;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDE66082BD5;
	Mon,  9 Nov 2026 16:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EDE66082BD5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=efhrXBeT
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 507AD14BF;
	Mon,  9 Nov 2026 08:00:42 -0800 (PST)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74F283F632;
	Mon,  9 Nov 2026 08:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794240045; bh=OKEfECUxhgnJD4NtvkX2PSEKEz/6It6XOn59vGtNFZ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=efhrXBeTOF6JY5AKxnktAByldq25EXNZeVRm09/Wjf7S5kezGDQUmu0M7VzFSfwil
	 vTH/fZ0C96iOHmegIez5wQ295wUY2VfSMryjaa2iCbFbnH4vObVLJH8lbo05jy320F
	 KbKM3HoqmmAKE1toAvwnccYvWdyVaKCAcVp1xWbM=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Mon, 09 Nov 2026 15:58:27 +0000
Subject: [PATCH RFC v10 02/22] set_memory: Introduce set_direct_map_pkey()
 stub
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
Message-Id: <20261109-kpkeys-v10-2-aa6c4d9603bc@arm.com>
References: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
In-Reply-To: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
To: linux-hardening@vger.kernel.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Ard Biesheuvel <ardb+git@google.com>, Andy Lutomirski <luto@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Jann Horn <jannh@google.com>, 
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>, 
 Kees Cook <kees@kernel.org>, Linu Cherian <linu.cherian@arm.com>, 
 Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Maxwell Bland <mbland@motorola.com>, 
 "Mike Rapoport (IBM)" <rppt@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Pierre Langlois <pierre.langlois@arm.com>, 
 =?utf-8?q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Quentin Perret <qperret@google.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org, 
 Ira Weiny <iweiny@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794240029; l=970;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=OKEfECUxhgnJD4NtvkX2PSEKEz/6It6XOn59vGtNFZ4=;
 b=QZxoRYuTQiuuxIZupKn6dIrLtKt5bbYrAIVLndZ4+TOYTnRcMSs5Z5ryXhuZFgfXQzUYAojW/
 XVUm108COzSBB9z+v+KqzEaNNu2yUR+UCcsn/ZivdTFiTH6wmdcy4hL
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

Introduce a new function, set_direct_map_pkey(), which sets the
protection key (pkey) of pages in the specified direct map range.
Architectures implementing kernel pkeys (kpkeys) must provide a
suitable implementation; an empty stub is added as fallback.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/set_memory.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index 27c32fbabfec..6172f1ecad35 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -190,4 +190,11 @@ static inline int set_memory_decrypted(unsigned long addr, int numpages)
 }
 #endif /* CONFIG_ARCH_HAS_MEM_ENCRYPT */
 
+#ifndef CONFIG_ARCH_HAS_KPKEYS
+static inline int set_direct_map_pkey(unsigned long addr, int numpages, int pkey)
+{
+	return 0;
+}
+#endif
+
 #endif /* _LINUX_SET_MEMORY_H_ */

-- 
2.56.0

