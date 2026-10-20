Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494568;
	b=5FB/WjdJce7m+H+AxfWNCeBrpOXa65QIrN+bN58LlfXoFwnjP4VLQ/Ph6zwhS/02DU9f
	 ChSFEPAv0gyT30araFhU1kNCOzBvnIf/ecrc/bV/4HswEJ7g9tKA4U0elbrByevMAkhWv
	 6uOpatpQnX5jk+h+eMAa/IvpVngx0JNqp+Z5e8UW56pO+RRKwj8Uf9a5+jMhQcbqG8VIM
	 CnqWX5F0QKU4EBj3f+5SllzL3dXDJQsVj32Gp4PLNFE3WgGHqtQSkW75HMEV0TqkI5ZJq
	 N9mVUkeW9/yXLduLBvgn5dYlTON4ePBJ2mtRmUWe1a+G4sCjJ7wvO34utRYdlED2RUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494568;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=h7jKhgW2MQavDeYA5DvZZ06yeDl1v6ZtS0ur/qsa/To=;
	b=A+6gub8VUQWc15UgEfdCMFIttZ6DFxd40TxyGTqO2Eq8r244dXCVrsu8dLlV5q0PYjiZ
	 F6jekiIuhBR32ihhDgmZ2APKhvI8EfEDpx4La4mwT+JcE2gm/1bGbEbjFUEswwtOMrTxe
	 Q0+EZXQ3mbkufp5F5tq5gYDlFnx2tzn+RLnoI8M2PV8jcY4jSKoRx8O/gNsGTaobSDQvI
	 O406S/BKPqvsRNJMyCaZYdE8vQgOFjSnmrERWiKsLVPt2zLawR/XjqV/E/HY7LDElaWHP
	 TcetNxt7kkDNZkjyCLs0dgyTVmnO6dC/8gLezUZ6ygu+kqjZDx61t/VftoRtiuSjyhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JB5yPkm4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9260606A319;
	Tue, 20 Oct 2026 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JB5yPkm4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A39B1F000C5;
	Tue, 20 Oct 2026 11:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792494568;
	bh=h7jKhgW2MQavDeYA5DvZZ06yeDl1v6ZtS0ur/qsa/To=;
	h=From:To:Cc:Subject:Date;
	b=JB5yPkm4XXvobRkuIEQqQ8ioy5y4+uEbdT7VbrS4d6ejba9cZ4jOTh/XEZYKyMPdH
	 j3t4nJFVyPeys5XaDBddY8adyHIgS9qjpi9B8dKwdK6NqbvGo16pEMAGOv9In4um2N
	 c5RDxYpB7RgBllNJWAWceAVTe2dg8bNVw9uDf2RKeR5Sr/GV2JFO0x1i71R+4FZ+B6
	 PNiOknRO7INNn2kMZRhD1LF1+lhfd+dgxGLz66shluUZ8z2hnLspDvzhtGMFRCO3yJ
	 jI/i6VjkuIzyl+ZUpERaTckvpwsyzhCs7XsZlNw0pM3gw8EqIlSkaUhASeWuTuQ5+C
	 p1S+ruzkpDAHQ==
From: Thorsten Blum <blum@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thorsten Blum <blum@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] arm64: patching: Annotate text_addrs, new_insns with __counted_by_ptr()
Date: Tue, 20 Oct 2026 13:08:39 +0200
Message-ID: <20261020110838.191061-3-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=823; i=blum@kernel.org; h=from:subject; bh=BbljLzGPofMIqi5g5mgMPpwGq6qmez95yloL4CR6jK8=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnXvbcFVf540l7dMN109kXH/tWb5j8TsCw9d0fmtGGE9 F7pG2k8HaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjCRVhGG/z6p+1hTToYtswlr KCw8xKnS8fTtQ6FlOlxS/aw3jp3Jvc7wV2hTr/yStNsVRXPaItcmZTtH7vD9wLJa17XOrqGlpTu TAwA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Add __counted_by_ptr() to aarch64_insn_patch::text_addrs and
aarch64_insn_patch::new_insns to enable access bounds checking via
CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/arm64/kernel/patching.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
index 09f019c6547a..5fc7805a93f0 100644
--- a/arch/arm64/kernel/patching.c
+++ b/arch/arm64/kernel/patching.c
@@ -194,8 +194,8 @@ int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
 }
 
 struct aarch64_insn_patch {
-	void		**text_addrs;
-	u32		*new_insns;
+	void		**text_addrs __counted_by_ptr(insn_cnt);
+	u32		*new_insns __counted_by_ptr(insn_cnt);
 	int		insn_cnt;
 	atomic_t	cpu_count;
 };
