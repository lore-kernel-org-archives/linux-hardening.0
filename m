Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362022C15B7
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081143; cv=none; b=gSRuehV7Xq5R2vd74Ce+VH9KnPMFlv9a2otRvmkmuSiYLXHILTP+cUSCj+gHGh02InwXpruTKVe8Zs4j0i3CsD+xdzMug20toLhnDYkbhwjc8to7DZMSHDIzp8YZGKC53DsraKceql4p3oAN6OZK1iY6hDGLNVJ+57vOCQsLk5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081143; c=relaxed/simple;
	bh=NIIZPc0sY912C1m9icYTUlAu6CHaAo3ThTuiUKfZGXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RsSrM5vKYqBeoT/7WCmqBHLXpWmNIgIxABXWuhqV0JGWPI4BQSrhuSN+IspDz65Zz81VZNeVopx3ShmGkeWRC5Skn4Kk+WjAj89EtP/Ck+VZWYTyEO2iBy541jnqBd6f1DlpbtThPZiYBFKBA8Fli5QHc/c4maiV7UzY4D0DWJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M7ij0xoP; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M7ij0xoP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755081138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yRug7LQyvFONu46jBMGRmPeIFE9+yuqhOdPPzW6dSeU=;
	b=M7ij0xoPfeD2CH1dQLA/0tV34M+LYKhKQFovdoB6gCYrIzbVZxdkMWBds9fseU3RgqQ6d/
	vcTf3us3Ri+Jqeh6OoTjfaXWQgQSlOU+nNVEZU1l3/sHwIUuHjDiVoMYcRW4fcg6KRqYoB
	CXvjEr+YP97xor1iZ3smZ8jn8bzzXWA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] powerpc/rtas: Replace one-element array with flexible array member
Date: Wed, 13 Aug 2025 12:30:59 +0200
Message-ID: <20250813103101.163698-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the deprecated one-element array with a modern flexible array
member in the struct rtas_error_log and add the __counted_by_be()
compiler attribute to improve access bounds-checking via
CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/include/asm/rtas-types.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/rtas-types.h b/arch/powerpc/include/asm/rtas-types.h
index 9d5b16803cbb..5d40d187b965 100644
--- a/arch/powerpc/include/asm/rtas-types.h
+++ b/arch/powerpc/include/asm/rtas-types.h
@@ -42,8 +42,9 @@ struct rtas_error_log {
 	 */
 	u8		byte3;			/* General event or error*/
 	__be32		extended_log_length;	/* length in bytes */
-	unsigned char	buffer[1];		/* Start of extended log */
-						/* Variable length.      */
+
+	/* Start of extended log, variable length */
+	unsigned char	buffer[] __counted_by_be(extended_log_length);
 };
 
 /* RTAS general extended event log, Version 6. The extended log starts
-- 
2.50.1

