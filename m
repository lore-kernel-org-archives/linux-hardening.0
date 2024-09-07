Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C15E1E522;
	Sun,  8 Sep 2024 12:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725800066; cv=none; b=nM599YA6/xw7MuHX0iTq0gxfLrAM638pzN2zMcVD2Z+i25sffo6OprJZxit+w//YAUla6qKjXV1wBcSZrTEgp2qQrJVRx4BmUr3d1p+R0NepLgioFoHsjnosNUjBzUN47ooNw6MwwNhpyPTwy1XNjq9xshnKDRXtAXG/wMyx1cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725800066; c=relaxed/simple;
	bh=N+qkoDcLCz0nBG8DXDVrSGBMG8nY+5HdmPu0vjkLdMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I4DxVHz7SHJc3AbTQOhSiqsXYsM7adA7fo+xWQJTFwgXlfqkuNkLV+M0O4i6kzGwf7VPPkeQmnoGlv7+dJX27mg5tPT53wMiqhQV6NVwhQrl0IUyqu/3ANZNAe69mnzu7D85XSTis7xH9e7z9LYmuPnThW02VeEi/vLk6IT0IxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4X1qfk3Qvtz9sRs;
	Sun,  8 Sep 2024 14:54:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id No8n7tfpJuzs; Sun,  8 Sep 2024 14:54:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4X1qZJ2Zg4z9sXn;
	Sun,  8 Sep 2024 14:50:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7CC738CC39;
	Sat,  7 Sep 2024 17:40:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id jjF9I3I5fwXQ; Sat,  7 Sep 2024 17:40:49 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.96])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0F3958CC37;
	Sat,  7 Sep 2024 17:40:49 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH] powerpc: Add __must_check to set_memory_...()
Date: Sat,  7 Sep 2024 17:40:41 +0200
Message-ID: <775dae48064a661554802ed24ed5bdffe1784724.1725723351.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725723641; l=3067; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=N+qkoDcLCz0nBG8DXDVrSGBMG8nY+5HdmPu0vjkLdMo=; b=3s5nC2tzY102OKRqd/YuS/bwTF8HWMEO8Mj9qHeyPXuxbjT4yXeXh7zMXGVzceYkE1BXdl4r1 L0CuuCR0jbgD7jnIN/2Wum5dnj2wWPMsmuuCyE9qaKUWWPev0kqItK3
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

After the following powerpc commits, all calls to set_memory_...()
functions check returned value.
- Commit 8f17bd2f4196 ("powerpc: Handle error in mark_rodata_ro() and
mark_initmem_nx()")
- Commit f7f18e30b468 ("powerpc/kprobes: Handle error returned by
set_memory_rox()")
- Commit 009cf11d4aab ("powerpc: Don't ignore errors from
set_memory_{n}p() in __kernel_map_pages()")
- Commit 9cbacb834b4a ("powerpc: Don't ignore errors from
set_memory_{n}p() in __kernel_map_pages()")
- Commit 78cb0945f714 ("powerpc: Handle error in mark_rodata_ro() and
mark_initmem_nx()")

All calls in core parts of the kernel also always check returned value,
can be looked at with following query:

  $ git grep -w -e set_memory_ro -e set_memory_rw -e set_memory_x -e set_memory_nx -e set_memory_rox `find . -maxdepth 1 -type d | grep -v arch | grep /`

It is now possible to flag those functions with __must_check to make
sure no new unchecked call it added.

Link: https://github.com/KSPP/linux/issues/7
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/set_memory.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/set_memory.h b/arch/powerpc/include/asm/set_memory.h
index 9a025b776a4b..9c8d5747755d 100644
--- a/arch/powerpc/include/asm/set_memory.h
+++ b/arch/powerpc/include/asm/set_memory.h
@@ -12,37 +12,37 @@
 
 int change_memory_attr(unsigned long addr, int numpages, long action);
 
-static inline int set_memory_ro(unsigned long addr, int numpages)
+static inline int __must_check set_memory_ro(unsigned long addr, int numpages)
 {
 	return change_memory_attr(addr, numpages, SET_MEMORY_RO);
 }
 
-static inline int set_memory_rw(unsigned long addr, int numpages)
+static inline int __must_check set_memory_rw(unsigned long addr, int numpages)
 {
 	return change_memory_attr(addr, numpages, SET_MEMORY_RW);
 }
 
-static inline int set_memory_nx(unsigned long addr, int numpages)
+static inline int __must_check set_memory_nx(unsigned long addr, int numpages)
 {
 	return change_memory_attr(addr, numpages, SET_MEMORY_NX);
 }
 
-static inline int set_memory_x(unsigned long addr, int numpages)
+static inline int __must_check set_memory_x(unsigned long addr, int numpages)
 {
 	return change_memory_attr(addr, numpages, SET_MEMORY_X);
 }
 
-static inline int set_memory_np(unsigned long addr, int numpages)
+static inline int __must_check set_memory_np(unsigned long addr, int numpages)
 {
 	return change_memory_attr(addr, numpages, SET_MEMORY_NP);
 }
 
-static inline int set_memory_p(unsigned long addr, int numpages)
+static inline int __must_check set_memory_p(unsigned long addr, int numpages)
 {
 	return change_memory_attr(addr, numpages, SET_MEMORY_P);
 }
 
-static inline int set_memory_rox(unsigned long addr, int numpages)
+static inline int __must_check set_memory_rox(unsigned long addr, int numpages)
 {
 	return change_memory_attr(addr, numpages, SET_MEMORY_ROX);
 }
-- 
2.44.0

