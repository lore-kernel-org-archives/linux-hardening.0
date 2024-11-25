Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC36185935;
	Mon, 25 Nov 2024 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732530770; cv=none; b=MGnl8GmQjBGdyyPm89SIICIzgZgoPFxBk7C1QWP72CfNeD0GTMQ414eb9lz94+mqIAKUSHvG5DfWc1UjIDYsxQSjmt+YPRsytfDS2nmGogYyDZKTBaFkRN726Ox7M3MG+RuqQl1IdDjgjP+rSxP47L7RFHBU6UGtp8it/DuiUBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732530770; c=relaxed/simple;
	bh=CZw438fzgU6+CLnU/rOm3EGzDUGkE8ElDVUYB5jlEQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LXeAM353fqGL2CUyg/L2cCQHY7iMSe2t+cD78cDo70Zcvncg4rnRI6IibsyXFNoc+Nn1bG1G9+s773Qw5z3mcuGXa2tD2P7O9x25jHBm5wjiaRNoQASpv9lXykiqgPs8A4kpXmgc7Pjz2LRSbyFdrZetcMdolMQMh4D5rJXhDEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bMkO/bSa; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bMkO/bSa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732530766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MoENqIKox7AY/qS4ViQA7GaA1waqRgjx+z7WAMBdMEo=;
	b=bMkO/bSaeXG8wna8NGwYZD97IubSVEnjUtqNWn5QX57CMa/m8sjN/mEzXBaSJTtHPnONCy
	P4L4ZUqHYgoL9h8/LyD4kJnFGnS5jf4RPv1mZIIQ0Xkj1KdAdrhxFOs85Wzb15SqaZ+gmE
	b3o1WMZqdLzP2aYF37QAudp5CFqTw+U=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] alpha: Replace one-element array with flexible array member
Date: Mon, 25 Nov 2024 11:32:09 +0100
Message-ID: <20241125103210.134678-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the deprecated one-element array with a modern flexible array
member in the struct crb_struct.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/alpha/include/asm/hwrpb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/include/asm/hwrpb.h b/arch/alpha/include/asm/hwrpb.h
index fc76f36265ad..db831cf8de10 100644
--- a/arch/alpha/include/asm/hwrpb.h
+++ b/arch/alpha/include/asm/hwrpb.h
@@ -135,7 +135,7 @@ struct crb_struct {
 	/* virtual->physical map */
 	unsigned long map_entries;
 	unsigned long map_pages;
-	struct vf_map_struct map[1];
+	struct vf_map_struct map[];
 };
 
 struct memclust_struct {
-- 
2.47.0

