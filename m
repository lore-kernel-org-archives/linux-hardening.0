Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE737CA64;
	Tue, 22 Apr 2025 07:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745307824; cv=none; b=bQV73ImKmN65ipSIBdDS3doPXNugEjhbxNtZpb4ayiiFaF4mwj97e4adTs4UQFtJNBe+v2aWNq6LXNBs2f/XQKl/G8KDVrjBUUR81ivHrvWYcq69ChNK6YZWcFinaDUqiCt9TP1xMsaZtYzocHuQ7QN6/KbdpaHBd3d/ormn9H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745307824; c=relaxed/simple;
	bh=R5SFfORZyHAzVkPV76H8wV6285XhlcAIVYEAw7yOVvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t9HdzlxvA4Y65q3sNeq4hnEkrBg+G5/HDOGaywQSe79CGPlGzHIcjlPJZ4TRTr966sEFN2X899vvL+PAfaUjIl9ydIBtlSRWLg5QgPqREEQJKLBRnHWf0V6T/8jInTxukwg+9/e/8OmKsLONMXqGS3zPJlVOOSLauwoVHWztOzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XdSGTa6W; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XdSGTa6W"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745307807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OudTtl9ifhGoOWeWZyumebbyu3fyKvkdq2X/syYruzc=;
	b=XdSGTa6WnFgv860U++wFbXqW6yV3Z+iN1/kEXX8RQsqavIEFXgbncR4hKZdtl6uzYwWZE6
	hAXU8oAND2S72L4qw9R/1J0N06ycSVmbajeOyjahnw/GhIhVsnFlIMKBVlhAg9ZWMdfGrA
	AiV29uU+BFWdvXqZeDHcKaPFad/I5QA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: BCM63XX: Replace strcpy() with strscpy() in board_prom_init()
Date: Tue, 22 Apr 2025 09:42:55 +0200
Message-ID: <20250422074257.544016-2-thorsten.blum@linux.dev>
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
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/mips/bcm63xx/boards/board_bcm963xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 9cc8fbf218a5..c5617b889b1c 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -764,7 +764,7 @@ void __init board_prom_init(void)
 			snprintf(cfe_version, 12, "%s", (char *) &cfe[4]);
 		}
 	} else {
-		strcpy(cfe_version, "unknown");
+		strscpy(cfe_version, "unknown");
 	}
 	pr_info("CFE version: %s\n", cfe_version);
 
-- 
2.49.0

