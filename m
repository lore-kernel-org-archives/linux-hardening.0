Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953DF1534E8;
	Tue,  2 Jul 2024 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719954978; cv=none; b=izPn4xL5IpnrBkXYVcVG1i6nyBoYKcCiDLJ0otF7WC8pQsB7oo6Tn8wBdI3dU1l9Fetb02J37ESRrlTdj4dGhlSu9YC9O5vyKrk6yIIafnAcJXwtqNqNtEI4zxqOZAxcbinGnKomGax6QcF98jLOx7TKep6pGd0DNF+WHhDtRCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719954978; c=relaxed/simple;
	bh=YLPiVvVQnIVQyA15VWnMycIugc+oko488O9GXWc/iAg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QEV/XTnijni42ePD1e5gHMsDqUF7ZiMF4r5gBwNuFONOd1X1BFARLTD7TLkWIQZGabFcAp9ikpVAoC9U4TzpDhwVpslY3VPokzYT5VHHyEnIyqNbh22/+4FPIsQhThZDtyFhZKxQ3qG5sK7qqTeanegLyXqG1etP5zRnCESUZdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQO9ojOE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQO9ojOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17ECBC116B1;
	Tue,  2 Jul 2024 21:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719954978;
	bh=YLPiVvVQnIVQyA15VWnMycIugc+oko488O9GXWc/iAg=;
	h=From:To:Cc:Subject:Date:From;
	b=FQO9ojOEKBiSoEsqh3p0Hbq8YBarl3k2FA15LkaJUywt9xcNC6Ja8s9qg0lwnvZz3
	 HNMuLPCpk13mZ7RXjDmpAGAHB25/7ylTD4OC7snYDbcJRPUazwfaOMGYY0OzF2Ztp3
	 Vx7BkzPbnhdRIPqbkemUdoPk5CZRBkptt9TSlXkQ16AW0ihPrTHcWYmMyvJBOTDJoV
	 lvnfstasvRktbTsKuHQxc5FM2zDsrK6A8/Axe9QPDkmTy/N2P9HNjnY7RCP//aT15L
	 Wn2HozHJY8HMRjiCDdGZCudBS5o9KuyP3PjQcMy9Kk2GXMqj/b4i4FlHhF0bt0ZcRM
	 mYBhOJuHgpm0Q==
From: Kees Cook <kees@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <kees@kernel.org>,
	"liuyuntao (F)" <liuyuntao12@huawei.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] randomize_kstack: Improve stack alignment codegen
Date: Tue,  2 Jul 2024 14:16:16 -0700
Message-Id: <20240702211612.work.576-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3361; i=kees@kernel.org; h=from:subject:message-id; bh=YLPiVvVQnIVQyA15VWnMycIugc+oko488O9GXWc/iAg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmhG4gLYI1/PtI3Ps7QZQg5s2FfZhAY6zQ5fHxT YjigKobE8aJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZoRuIAAKCRCJcvTf3G3A JplGEACqkr71k+UriTYK3il1IciWwaCmkwIju1hFYugtton/Oklyorpa0pzgZAbuzD+/bRD7Ja4 E4EC/NdCSNXmNahcEe8nBrWv6laVZLYcflvCyaDpG5Z3VSi/b3LvNI3SUM1PVZ7F6sFLknd4NLU yUkIPefwCWBTSO+iIOsq0NSQEEowJBBknJuuDj27P/NEgsaCXLpC/+Pbe1+clXbWW70Bzh6XE8y kdv51pILjcJa0VS9MQioqLGU1wpmhiRSwBykbRXupIwJMZllOuxs2MSzRaamez2bBgyocdPsqNE z5ITrQp8PZDQ4nMvM6A50zzoJoUXRktZNwUL/MD2gXkKbmMjzXCxSX4R8bj0nfezzmysO6c36gs gOU3C86yiwuEpdApGbBGqLgfCEGe2Psh8Sd8ZaXTrqmKOP1bamS2VHbHqfV461jl+xJjb5ZJiXh mcrQI9dUH8fDjnZysR/tnKzory5w6kUy3JD4M7/jdxl4PiiQAD4O3WoSZhfaUyED9H+HumdhCDU gcXxTJci1Chvw0ibToCOO+L1acV2y1pmsf8DR5kT85+WwE5vWHBEwv4NmPrcqbTWiO31o4IWygq ctLFNj+cB5xX4SFnaJMNco4b9IXIZHphSdGYeyzBZeZ+lSk7oV7MIEzNRP1e9bzwo+34T28I1nM r8520I60+BaLc
 /g==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The codgen for adding architecture-specific stack alignment to the
effective alloca() usage is somewhat inefficient and allows a bit to get
carried beyond the desired entropy range. This isn't really a problem,
but it's unexpected and the codegen is kind of bad.

Quoting Mark[1], the disassembly for arm64's invoke_syscall() looks like:

	// offset = raw_cpu_read(kstack_offset)
	mov     x4, sp
	adrp    x0, kstack_offset
	mrs     x5, tpidr_el1
	add     x0, x0, #:lo12:kstack_offset
	ldr     w0, [x0, x5]

	// offset = KSTACK_OFFSET_MAX(offset)
	and     x0, x0, #0x3ff

	// alloca(offset)
	add     x0, x0, #0xf
	and     x0, x0, #0x7f0
	sub     sp, x4, x0

... which in C would be:

	offset = raw_cpu_read(kstack_offset)
	offset &= 0x3ff;			// [0x0, 0x3ff]
	offset += 0xf;				// [0xf, 0x40e]
	offset &= 0x7f0;			// [0x0,

... so when *all* bits [3:0] are 0, they'll have no impact, and when
*any* of bits [3:0] are 1 they'll trigger a carry into bit 4, which
could ripple all the way up and spill into bit 10.

Switch the masking in KSTACK_OFFSET_MAX() to explicitly clear the bottom
bits to avoid the rounding by using 0b1111110000 instead of 0b1111111111:

	// offset = raw_cpu_read(kstack_offset)
	mov     x4, sp
	adrp    x0, 0 <kstack_offset>
	mrs     x5, tpidr_el1
	add     x0, x0, #:lo12:kstack_offset
	ldr     w0, [x0, x5]

	// offset = KSTACK_OFFSET_MAX(offset)
	and     x0, x0, #0x3f0

	// alloca(offset)
	sub     sp, x4, x0

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/lkml/ZnVfOnIuFl2kNWkT@J2N7QTR9R3/ [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "liuyuntao (F)" <liuyuntao12@huawei.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org
---
 include/linux/randomize_kstack.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
index 6d92b68efbf6..1d982dbdd0d0 100644
--- a/include/linux/randomize_kstack.h
+++ b/include/linux/randomize_kstack.h
@@ -32,13 +32,19 @@ DECLARE_PER_CPU(u32, kstack_offset);
 #endif
 
 /*
- * Use, at most, 10 bits of entropy. We explicitly cap this to keep the
- * "VLA" from being unbounded (see above). 10 bits leaves enough room for
- * per-arch offset masks to reduce entropy (by removing higher bits, since
- * high entropy may overly constrain usable stack space), and for
- * compiler/arch-specific stack alignment to remove the lower bits.
+ * Use, at most, 6 bits of entropy (on 64-bit; 8 on 32-bit). This cap is
+ * to keep the "VLA" from being unbounded (see above). Additionally clear
+ * the bottom 4 bits (on 64-bit systems, 2 for 32-bit), since stack
+ * alignment will always be at least word size. This makes the compiler
+ * code gen better when it is applying the actual per-arch alignment to
+ * the final offset. The resulting randomness is reasonable without overly
+ * constraining usable stack space.
  */
-#define KSTACK_OFFSET_MAX(x)	((x) & 0x3FF)
+#ifdef CONFIG_64BIT
+#define KSTACK_OFFSET_MAX(x)	((x) & 0b1111110000)
+#else
+#define KSTACK_OFFSET_MAX(x)	((x) & 0b1111111100)
+#endif
 
 /**
  * add_random_kstack_offset - Increase stack utilization by previously
-- 
2.34.1

