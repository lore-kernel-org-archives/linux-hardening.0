Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1DD43ABC
	for <linux-hardening@vger.kernel.org>; Thu,  9 Oct 2025 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760031943; cv=none; b=Kr5rqaIVCTozX8N+/kYElsov0pfeQC19QdvtoEJ7cQK3N0OmC1dLrvDYoQJxiNahRB+1X35c6oTVyVVi5qRF+TJTVlIzQLh8k06b9GrELk8xwBUMXUuJyP7MLzbk+XK+DrZkvwbOkTSWuS9blaDlEdd6iXd1kmY7p8sPp3mOuFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760031943; c=relaxed/simple;
	bh=3nrZtSjEUdo+gvM5rjuHujG2OApFGvCEvez3yDp+qfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H8/9mzDQZrZpey0uQD29pj4HDqDVkIkg2LgL0hD6+gmr4XUJu/QsPnl90nOGl/or5aXdU3SUnyI9/f4N57FacgKiztO0ofdXWwCBBlyn6lqbZaRwNyDnoGAwImq/H71V+z0P+VMAbtFvmaKVC2Y9rTtIKmCXXkFauW5yxUWz9CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QRt+3ZSM; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QRt+3ZSM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760031939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mf0fe+UIwSYw3cvFDgqawJqRgyD2tHm+Y7POs9z4DxM=;
	b=QRt+3ZSMs1N9xuhmzQ/aPAruimTd0J97C+SwVsUVALmSZiJ2TFupXoNmbiM6mZTC2OAK9S
	0fhYM0Myq5GtJAaGzkpvxUhFLoSPM9K8JLJwHiZsTc2mVlCdqP2kSHWop7rcIUWswBQEEo
	Dc2y4FA8bI2NF99qe1Or3aDBZupRiW4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	zhangheng <zhangheng@kylinos.cn>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] w1: ds28e17: Replace deprecated strcpy + strcat in w1_f19_add_slave
Date: Thu,  9 Oct 2025 19:45:12 +0200
Message-ID: <20251009174519.393898-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated and using strcat() is discouraged. Replace them with
scnprintf().  No functional changes.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/w1/slaves/w1_ds28e17.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds28e17.c b/drivers/w1/slaves/w1_ds28e17.c
index 5738cbce1a37..e53bc41bde3c 100644
--- a/drivers/w1/slaves/w1_ds28e17.c
+++ b/drivers/w1/slaves/w1_ds28e17.c
@@ -719,8 +719,8 @@ static int w1_f19_add_slave(struct w1_slave *sl)
 	data->adapter.owner      = THIS_MODULE;
 	data->adapter.algo       = &w1_f19_i2c_algorithm;
 	data->adapter.algo_data  = sl;
-	strcpy(data->adapter.name, "w1-");
-	strcat(data->adapter.name, sl->name);
+	scnprintf(data->adapter.name, sizeof(data->adapter.name), "w1-%s",
+		  sl->name);
 	data->adapter.dev.parent = &sl->dev;
 	data->adapter.quirks     = &w1_f19_i2c_adapter_quirks;
 
-- 
2.51.0

