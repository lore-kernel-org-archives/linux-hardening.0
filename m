Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415524;
	b=3MbmsFor99Q5G5YXsOgDgpoiyycBnLWC5Q9JcUPEgJrsYHOeE/kc9aWXZd98j9wTPjsO
	 DZzG3xmVWTA4yvHKzgg0gPMNwoDvL7KpENye50gpgGg8ruilXdRC5gMa9MNTLcI0/UyDy
	 mT7bgGZ7P86v6HCnJPalDOt8XaJ7eaD3z8w6WpYUugZHKNGr0JitP03Jjx80nwHFWRaTM
	 Vw8Op1mXLEHrNL35CRoMnV1FT0UWHwJnmqxmeaZw0ZUlQ+jbMpBdsYI0NsDgI/a3nfwT2
	 g8TOS9X7ZURFjRmgd4pogBg12T3nqxRyJbGhJKGUKAS43YGp5v842vvSkPRARMDGrcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415524;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=h7jKhgW2MQavDeYA5DvZZ06yeDl1v6ZtS0ur/qsa/To=;
	b=PL3AnJhVsYW122b2YeacuT2cZ/FQy8eXi5Tk+MJD7v6Nigj84TX6xDFbFPsm36jbv/YN
	 RajxvXrY40+RM0ESiy80l8BRUd1L+DmwB5vicArpS07xnCp3Yd5IpZkOg9Fud2xNtrdrD
	 qOngI7laeYf/p3yurzzYCyiTVn+5LQbwLTd1DfspyFdlDof9DjwK8u7iNrhkmVNAceqtM
	 OL2gvLPcVIZo/kc6lQNPqkvRSNeFJIjHWeZgXz5iMgGn0ewihdlQMo84HOJUjBes6yyjM
	 qmfxcmhh+zagqjNKIXu33DRKWmKEsKNdmQgPcQznaoRpcieHp3fWq96xiWmf3AEsY5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCdudd45;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDE5606A31C;
	Wed, 11 Nov 2026 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCdudd45
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522A01F00A05;
	Wed, 11 Nov 2026 16:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415523;
	bh=h7jKhgW2MQavDeYA5DvZZ06yeDl1v6ZtS0ur/qsa/To=;
	h=From:To:Cc:Subject:Date;
	b=bCdudd452ELxWqGQCoyC336cufFyki3Z4ZUyrtUobMnejdC5KGFvKDLrpgaaxe0Et
	 8FAd8CFYzWgZmvK+A2rEtJPjn2ohFWwJ1DaVWoWNEdbLztZIXitFFT5kl5o6NL4Mtq
	 Ko3VJlnFFGTIfbsneDLuqjZL0aw3M0Fc2HYWfgxAx58dYeWjmL1FQcWn4q1LmBQHXU
	 Cw1XUtd1SzJdjUeo0L3yYeaxjlNKvtQ2WqwFVbxgOYRvoDUyQcAyY4IkjYV6zUyPJv
	 sRRlLQyHTmyaRK20YwnQXBP8wHBwPXNLUhhc0gPAUAPi2sRpA8fVLN32uBryu+VhWJ
	 JsICkMsKe/XPw==
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
Subject: [PATCH RESEND] arm64: patching: Annotate text_addrs, new_insns with __counted_by_ptr()
Date: Wed, 11 Nov 2026 17:45:14 +0100
Message-ID: <20261111164515.77988-2-blum@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=823; i=blum@kernel.org; h=from:subject; bh=BbljLzGPofMIqi5g5mgMPpwGq6qmez95yloL4CR6jK8=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlfZs8OqvzxpL26Ybrp7IuO/as3zX8mYFl67o7MacMI6 b3SN9J4OkpZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAiwWcZ/ko+Ltvx64DPPYn1 Ky0zPto8PZgsvX1VaEaD4+55LwL+yBgx/JXy9FMpVuz/I+uzR/XbofaTUxqEaoUunr327eZtZwN THW4A
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
