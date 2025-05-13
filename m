Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD4F1C84D5;
	Tue, 13 May 2025 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747158038; cv=none; b=mn/vpKJTqod7eMYFnUfzgqbLli2xqK3c55iUayBdSSRFmGjK8OT0XcnSf2J+RhVwKsv/IXb6ca7TLYU0ObSXyCyYQ1CMEyB8eIoVJm7k/W0EOkkDHS/yUD1xJu4QGt9lujOiBC0CQZMNuysfQxBDRIF/EJJkzv+zqrNlm0QR6Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747158038; c=relaxed/simple;
	bh=t0/XpU4JadBJ6GwKFenplEEaSC5kW1qBslh+Bi3T1kw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pbpICbJ1AtdLrByyTGTKibhu1kVv2GBTn5OwtjB8WFj2/jBqndx4s66khA7abSOVTeyoDRrxNVH0OsWopyN2cU6Uo/kPy7r/PNTWxOQx1o4kjxLPVwnLcT3xgGi941JetLbTOwYP9MG7YVxH0n6WytashQitVBJ/l2hQtAShcEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Er91PvWy; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Er91PvWy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747158032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=irfEXLRw0ePs++TyHy3Fjxp4dBF0FDMvktUtW0vNle4=;
	b=Er91PvWyG3UWI/YZeVJk6w7xuxXsoKWTWlIMFXqE2iiM/bQsCjGydokq5f3OoaXsb01m3w
	1vWQwbH6IU976N3JmZG6bLSGFDTHO4Rzu7Cr8gko/3wwXcT16IqZw2jr670kSiK4W08LDI
	XVgzUvwv/pKaDl/TQr6Vw9PHQbfQGdo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] powerpc/rtas: Replace one-element array with flexible array member
Date: Tue, 13 May 2025 19:40:01 +0200
Message-ID: <20250513174003.335857-2-thorsten.blum@linux.dev>
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

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/83
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
2.49.0

