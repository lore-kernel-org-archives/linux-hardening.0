Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B10304BDA
	for <linux-hardening@vger.kernel.org>; Sun, 17 Aug 2025 18:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755455906; cv=none; b=seTNg778tH13cugC5xhfdK1n2VKVf8l2fS3VEI1oLtzf7XeqImp/mJjQdpZ+5/02U8q+0pexJlD8n1VPGMwD5lo1a3BXHaMG+HmBVHfGK8nH5CFIeSqBQBS2mAj588OVNNMXiHxLZBAJTy97pUmB8q7Rxgp8hlNBQrXkssZZcaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755455906; c=relaxed/simple;
	bh=X4lBTembOiyTREsOWuwF7phdvgJeUg9914S2xxx0nI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1VU3w595T+K5iCM8OuYUk08n8pGAjYXbI7/M7Os6LfddPAB9Xfw2MhrZWxrd0hZniU4tFuetFd5qSAy61VYPUv49Ke3QcJ/+ITfQomZ97skBvQHKniRYxADfylEULKQxKNFXmGI4OD4b7W70H8ufGh0lhAMm6cHvIW8lVoVZAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m3oDURCO; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m3oDURCO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755455902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xGaYIIsYcw9GGnEbF9Gu9aE5V4JusFgZWm3kX9cMs60=;
	b=m3oDURCONZ83j6dRBCgAWatRrHaTSA3b+oV37uxZ2AXeLGLVnGfSrBVtbWAYwhDbunLH/j
	CrJzUoXlcifDUx/IudffJrbRBni59qlgoBj2WTxtwxgrCG49Ow6prlsJ3FGJcX5TRCLDKJ
	IXW9MjNbfN41j6TLm7uE0zYH0hhlfKA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-hardening@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] MIPS: octeon: Replace deprecated strcpy() in octeon_model_get_string_buffer()
Date: Sun, 17 Aug 2025 20:37:17 +0200
Message-ID: <20250817183728.612012-7-thorsten.blum@linux.dev>
In-Reply-To: <20250817183728.612012-1-thorsten.blum@linux.dev>
References: <20250817183728.612012-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 .../cavium-octeon/executive/octeon-model.c    | 31 ++++++++++---------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/octeon-model.c b/arch/mips/cavium-octeon/executive/octeon-model.c
index 657dbad9644e..98996cc0857e 100644
--- a/arch/mips/cavium-octeon/executive/octeon-model.c
+++ b/arch/mips/cavium-octeon/executive/octeon-model.c
@@ -25,6 +25,7 @@
  * Contact Cavium Networks for more information
  ***********************license end**************************************/
 
+#include <linux/string.h>
 #include <asm/octeon/octeon.h>
 
 enum octeon_feature_bits __octeon_feature_bits __read_mostly;
@@ -208,16 +209,16 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 		 */
 		switch (chip_id & 0xf) {
 		case 0:
-			strcpy(pass, "1.X");
+			strscpy(pass, "1.X");
 			break;
 		case 1:
-			strcpy(pass, "2.X");
+			strscpy(pass, "2.X");
 			break;
 		case 3:
-			strcpy(pass, "3.X");
+			strscpy(pass, "3.X");
 			break;
 		default:
-			strcpy(pass, "X.X");
+			strscpy(pass, "X.X");
 			break;
 		}
 		break;
@@ -232,13 +233,13 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 		 */
 		switch (chip_id & 0xf) {
 		case 0:
-			strcpy(pass, "1.0");
+			strscpy(pass, "1.0");
 			break;
 		case 2:
-			strcpy(pass, "1.1");
+			strscpy(pass, "1.1");
 			break;
 		default:
-			strcpy(pass, "X.X");
+			strscpy(pass, "X.X");
 			break;
 		}
 		break;
@@ -253,13 +254,13 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 		 */
 		switch (chip_id & 0xf) {
 		case 0:
-			strcpy(pass, "1.0");
+			strscpy(pass, "1.0");
 			break;
 		case 2:
-			strcpy(pass, "1.1");
+			strscpy(pass, "1.1");
 			break;
 		default:
-			strcpy(pass, "X.X");
+			strscpy(pass, "X.X");
 			break;
 		}
 		break;
@@ -273,16 +274,16 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 		if ((chip_id & 0xFF) < 0x8) {
 			switch (chip_id & 0x3) {
 			case 0:
-				strcpy(pass, "1.0");
+				strscpy(pass, "1.0");
 				break;
 			case 1:
-				strcpy(pass, "1.1");
+				strscpy(pass, "1.1");
 				break;
 			case 3:
-				strcpy(pass, "1.2");
+				strscpy(pass, "1.2");
 				break;
 			default:
-				strcpy(pass, "1.X");
+				strscpy(pass, "1.X");
 				break;
 			}
 		}
@@ -447,7 +448,7 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 	default:
 		family = "XX";
 		core_model = "XX";
-		strcpy(pass, "X.X");
+		strscpy(pass, "X.X");
 		suffix = "XXX";
 		break;
 	}
-- 
2.50.1

