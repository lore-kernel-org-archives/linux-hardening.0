Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8F01F470B
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jan 2025 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737471992; cv=none; b=Ee9yslqSBVkT6gpYgWLWQ/yjgxuVnNM1QYIQ8Usu2aS/nwYKpmUXenbPLUjdtKnMpI/3LY+OXpKdqqVgcVYe9UgeKPPNV+uIslayQuFWKgTS+pSkHDVGDr87+Us80xflIJiFcRlynHMcyb+vzEUZG9xpxEA0MhrhioQp6upImpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737471992; c=relaxed/simple;
	bh=fACdkvrQz3xHG26Gy/TSFwx/AcDLdoyuEAccUKN5eXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pJIqc2DhHdvatzxYG4gfi4RDu0n5enSMNDW8MPYlGWLMt/cw5ISBpBO+0UrPrMr/h+3hjKu1/8L6o49gpoVtyWLqctXCc29npx5jnJ8x+WTcYZd9Lhp95jjdUSbNyoafa9xq0IawpBRFJh7vmUqGoJYAQoB+tPHuv748zJWsPis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pD5DLzTP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pD5DLzTP"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43621d27adeso39573055e9.2
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jan 2025 07:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737471989; x=1738076789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O9D0+ljEbQhZcGi15IbGvnov0OawqjfcmowqWE1AvlQ=;
        b=pD5DLzTPr940F2gNp2wToTymVaqjVbrsNmgORJLjDbxthLQ7ph0DRHhE3jwET4eKs/
         8ZsujWaVMzeyHac7Mg7AF7Ban5ceYb0Fe18HKwyyjBAiHBDk0cE8YBLghsdrnlOFWdEJ
         nZxPDlyyy/eUFLbD9RrTOzfZ/vubE/iyQ6/E7Ttp00sExU+PmCI1Pfj7BJbSnhhvglPl
         Xehac2ZMb/qcitRL+SJgC3t7sidjJDrM7dzmkr804z8M8bLkYdyUCWECNQaj4JVCubmi
         8rSk3hjIJD+D2iYi8rNL2Kv5tgvXG6J5nZjXsXALUsntevPjY5sW6SCBit2V35joEkU9
         5SHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737471989; x=1738076789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9D0+ljEbQhZcGi15IbGvnov0OawqjfcmowqWE1AvlQ=;
        b=lnZ1tS00KQJMW80KVY+/ddVmF93fa77VBsJT/42AWQfEe+pKHNVc0DBAXuxrbBuKab
         M980AMDoINR9pyuLMuJfiwSAWMWBFaNI8DAZ8FgyBSXxIAP6/cYONv/+93l3L4XRwcxH
         Gw4SaDyJrDHZBiR4DZQFWhYgm/aOnxu6MvTconH/cyi8GaLimGFX/HXcr0ji+4MMykTl
         NiMGukzJ+qhuxUuHLySIcWmlVK/7tZB5rQfLwumUcsO+ieS420yx5MhPPRSIeG5cGHNM
         u+bgaCT0jz+1JhW85/U85i2QusYcB+nMaYua6k9ahaLJ8KODLwxVgxfJLCKSLFIM37JT
         EcjQ==
X-Gm-Message-State: AOJu0YzUw7HCzBb+QIEuUg5O0XKmL4hTxEPOkFJSkTvlK9rv+tG/esbV
	FGMRRV2cz8mxesBbIyr83i5VXvOVCdz/meFik21Itx/aLd9+IbVWlc1k1b3+M9c=
X-Gm-Gg: ASbGncsx6nvSKwqTUbkR7H/k2HtNIsSkAC9uDRGDJYypH/S+SCtuhsfsIDxiUyRXsgv
	rw72o+rQVXfzOtRg+f611pyUH0jQ0OW3sl7v81toXWmkODreV0oNUw269MhPxWG00cLunwSHJzG
	H7N3NNiZ8aP0GEgyLkqubl3kVIpi76jcOjGwlZ5w7V0HF505Mr8d1x/D/pu+PDuh7BtReiejw97
	mBi8VCt0Y8UyIsXJGNWbYVpjg6w3m7HVDFcEZMr6USaeq3g6gWXt8XjpENFRoA9vMTNlLHC49v7
	z04=
X-Google-Smtp-Source: AGHT+IGhiM80Yx8g7FgQEg9lBl/tB6jqhiNWi6qeIbN3jHFPIOlb2fJoLnI+x2zn9XucLqolIv1CyA==
X-Received: by 2002:a05:600c:348c:b0:434:f1d5:1453 with SMTP id 5b1f17b1804b1-438912dbfedmr184206655e9.0.1737471989066;
        Tue, 21 Jan 2025 07:06:29 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c7499942sm240936555e9.6.2025.01.21.07.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 07:06:28 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: kees@kernel.org
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH] pstore/zone: fix return value for psz_init_zones
Date: Tue, 21 Jan 2025 17:06:17 +0200
Message-ID: <20250121150617.608118-1-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

psz_init_zones is not supposed to return NULL. It returns an errno,
and its caller always checks for an errno to look for a problem.
If the caller receives a NULL as a return, this code will go further
without any errors:

        cxt->kpszs = psz_init_zones(PSTORE_TYPE_DMESG, &off,
                        info->total_size - off_size,
                        info->kmsg_size, &cxt->kmsg_max_cnt);
        if (IS_ERR(cxt->kpszs)) {
                err = PTR_ERR(cxt->kpszs);
                cxt->kpszs = NULL;
                goto free_out;
        }

Later, when dereferencing kpszs, a panic would occur.

Thus, to avoid this possible crash, it's better to avoid returning NULL
in psz_init_zones, and just return -EINVAL if the parameters received
are wrong (in this case, a zero size request).

Fixes: d26c3321fe18 ("pstore/zone: Introduce common layer to manage storage zones")
Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 fs/pstore/zone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 5fa2fa2e7aa7..dbafc72a2f68 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -1204,7 +1204,7 @@ static struct pstore_zone **psz_init_zones(enum pstore_type_id type,
 
 	*cnt = 0;
 	if (!total_size || !record_size)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	if (*off + total_size > info->total_size) {
 		pr_err("no room for zones %s (0x%zx@0x%llx over 0x%lx)\n",
-- 
2.43.0

