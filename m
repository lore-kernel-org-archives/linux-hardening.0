Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC801F754C
	for <linux-hardening@vger.kernel.org>; Fri, 17 Jan 2025 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737103364; cv=none; b=NQB4STkWTCrz4X+RdsGAs/CCRbqzA7NDp4ZSVTWS8l/1adbo+LGrBn4Kv2SeLjZ1zjZP/pEBAyXXCjvohAGlYqGpL+HAx9tHc2HeqWv3w6wu96omagtlo7WmFT19aSafC+8NgDS+lKqe96leK+0HqcIBZmAMbmY8qs13DwWjg68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737103364; c=relaxed/simple;
	bh=C0pXPebYk/Z6eKCj51xDuC/4vVpAywT2Dl8KQgqFL5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BGMrBlr8ZFFbL8dKtvXv3nKa79Yv4zZ63a/VzuMaT+7ZsWL5TmcOX478ZlUu5noI8PauDz3fdsMQFZCkY30MTlRs/rLaaabqEDjTcRdeb7NE/oKnCTm69NO5ebuvkpgWVyqyUa531BACLjZuBHrYKDDE+UlFSmLpmhrsn+PdaT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SPOQhju5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SPOQhju5"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso1466087f8f.1
        for <linux-hardening@vger.kernel.org>; Fri, 17 Jan 2025 00:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737103361; x=1737708161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nCOF/7DWf6/+p38Tf4t2GS4pCPMHx5hroCn7XUZPVyc=;
        b=SPOQhju5nDUu6OQf62tWeUTlGM3NdSVT6alHlibQpwTiGhEZi7DtmbQOWPuTDzvtl7
         mmvWG78J1Nee4lGffNYJETYiNj49sFtNf7/phQRxChho4b4YJtiSHxNXQPuODbO5ZdFL
         +TrKFPGsVPiIYRfhN1pC4UZnSsIZVsSS0WFhMp0Lbu460zdnOy+9ENocDq3OVHBpSTup
         myc1KjglBcTOzbMKPECnkB5lCwpq5c5Fedtf52L//qi8uOrPoxp9a3ZAv0d/3wpul1Fj
         qTYXeoAIlGtw5NAoufdIYmcuHvtcZGC8Bor/6FEYcYjeSBgjgfqULRDWqVNdRXrJhm4F
         FB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737103361; x=1737708161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCOF/7DWf6/+p38Tf4t2GS4pCPMHx5hroCn7XUZPVyc=;
        b=dQCUFLWx8LDi/CZKP7RnymgDAHZ2em7rcU1FLr/iK/BxU5kgZtkDruvUzz3QEilJ2d
         9J4tlJ2fpCa5Zo5rwhajB5nXAEIZL5BBCgAVwmcvVATfCYZlmWeoVtt+1yMnIupFGY1k
         tFCMJk0hP1qkuaP/bvcQSiz2jY4f4OnR7Q/mc47FVf2aF8RTGGXRt3lcMDev8A7ctCBV
         6LHQlTZvZKiSSIGYvVohFkNP+6TAzo6FLYLQWxTcCdtqTFUY4I8iN9xUhjkX+0niqj7x
         hDb7tr15OzV7kcNYp8qE0yXPb1ZEgqHvTLyNh/wfYELrLwjxeFtcvTE9GjEbUEzBikhZ
         K12g==
X-Gm-Message-State: AOJu0YxpCserCyZcNNX/EpTfVsf6lT2QDR7SIWlL3tqCAth+izbDn5LT
	RQ6p4DO/s5Itxd92Q70Vh1TdCRWCz0bOXIN8rb6WIjGV1vPziXqhiLb4Z8ypPl4=
X-Gm-Gg: ASbGncumJLW7ZMaMhrAmZzPq3LBiDvEVHckX5D5ptTC+XEeDQ6kfi6VZjb9KZLfQ5mZ
	NMxprCfhz3YRG3xTf/JzC6+mFti0hO+G4BswQgq3am9cpuz4nbSA2X2BBlVq8gwWyuQOR1x8tBI
	qcj0XYFOQuI9Hxrb9D4m+bh3sg9wIIPDjKSGTy0EqBJ0T01QVtltBuQEqXmHELXLsLoBVoG9IGv
	7BVmiOjbQuES6yV+HjMD4IkmisbXVg7qpg8JsiXwks01UFh6xpMCxT3U9AvswNpa7jfFRet7A==
X-Google-Smtp-Source: AGHT+IE0g2r4mNuufMYa1SF7rV4BL9Qgy7k7aHEbEjsbW6jZHbIv/diqdIIXdLchTvnzZ3HNocPLRQ==
X-Received: by 2002:a05:6000:156c:b0:385:dedb:a156 with SMTP id ffacd0b85a97d-38bf5655e66mr1298777f8f.6.1737103361295;
        Fri, 17 Jan 2025 00:42:41 -0800 (PST)
Received: from localhost.localdomain ([2a00:f29:229:ba3:d022:662:690:4bb8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74c6179sm85902655e9.22.2025.01.17.00.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 00:42:40 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: kees@kernel.org
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH] pstore/zone: rewrite some comments for better understanding
Date: Fri, 17 Jan 2025 10:42:28 +0200
Message-ID: <20250117084228.3218024-1-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rewrite some comments to make it more clear and easier to understand.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 fs/pstore/zone.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index ceb5639a0629..5fa2fa2e7aa7 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -214,7 +214,7 @@ static int psz_zone_write(struct pstore_zone *zone,
 		atomic_set(&zone->buffer->datalen, wlen + off);
 	}
 
-	/* avoid to damage old records */
+	/* avoid damaging old records */
 	if (!is_on_panic() && !atomic_read(&pstore_zone_cxt.recovered))
 		goto dirty;
 
@@ -249,7 +249,7 @@ static int psz_zone_write(struct pstore_zone *zone,
 
 	return 0;
 dirty:
-	/* no need to mark dirty if going to try next zone */
+	/* no need to mark it dirty if going to try next zone */
 	if (wcnt == -ENOMSG)
 		return -ENOMSG;
 	atomic_set(&zone->dirty, true);
@@ -378,7 +378,7 @@ static int psz_kmsg_recover_meta(struct psz_context *cxt)
 	struct timespec64 time = { };
 	unsigned long i;
 	/*
-	 * Recover may on panic, we can't allocate any memory by kmalloc.
+	 * Recover may happen on panic, we can't allocate any memory by kmalloc.
 	 * So, we use local array instead.
 	 */
 	char buffer_header[sizeof(*buf) + sizeof(*hdr)] = {0};
@@ -856,11 +856,11 @@ static int notrace psz_record_write(struct pstore_zone *zone,
 
 	/**
 	 * psz_zone_write will set datalen as start + cnt.
-	 * It work if actual data length lesser than buffer size.
-	 * If data length greater than buffer size, pmsg will rewrite to
-	 * beginning of zone, which make buffer->datalen wrongly.
+	 * It works if actual data length is lesser than buffer size.
+	 * If data length is greater than buffer size, pmsg will rewrite to
+	 * the beginning of the zone, which makes buffer->datalen wrong.
 	 * So we should reset datalen as buffer size once actual data length
-	 * greater than buffer size.
+	 * is greater than buffer size.
 	 */
 	if (is_full_data) {
 		atomic_set(&zone->buffer->datalen, zone->buffer_size);
@@ -878,8 +878,9 @@ static int notrace psz_pstore_write(struct pstore_record *record)
 		atomic_set(&cxt->on_panic, 1);
 
 	/*
-	 * if on panic, do not write except panic records
-	 * Fix case that panic_write prints log which wakes up console backend.
+	 * If on panic, do not write anything except panic records.
+	 * Fix the case when panic_write prints log that wakes up
+	 * console backend.
 	 */
 	if (is_on_panic() && record->type != PSTORE_TYPE_DMESG)
 		return -EBUSY;
-- 
2.43.0

