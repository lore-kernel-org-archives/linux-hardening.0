Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F082737EE
	for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 02:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774580153; cv=none; b=ONmfHzpssVDd9qTNkMAuxmteXm1RdmYg+pnyyybi7fnLQJ/5rpU0vidhw2P2vpU06+1bItqCB/09IpEcJ9wSi1vB54hsBXfXEBOKJ0DBYK1y+RA7HXvZ1FKOUZjK9l+IQqEDKpfb36/Fx9rpFGlLnk+3mV8vnBu6GMdLroQKDQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774580153; c=relaxed/simple;
	bh=iINfrVicT0U5ezZ3pE2giAjTHpsPII0vZlDnVZgk1BU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s2ExR8KlOCW5WihHNE/aYy+e2Pl5n8gUS0jOciLC7xtw7uMs0XdTjj5mZynOHQOXq5z3e4u6FNKUt+inf4zeuba/SQPyXw/JNafUM+cMrSRs6ZwsYzaY6Xht6JgkQoKfsstfXgNv6zoBCNsp+17brEhrTopBGDpn7GHj91XwnGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awCdkszt; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awCdkszt"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-823c56765fdso895515b3a.1
        for <linux-hardening@vger.kernel.org>; Thu, 26 Mar 2026 19:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774580152; x=1775184952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jxOcLQAL828r9gNJF4VDxn22m5oC9wjYM2C1LJJwNlw=;
        b=awCdksztQSH1m9srS8WvlXY8s8eMij47LZRcVIjbHnQ8BKPJzn0vV1Qojw4yfAwLnY
         tDqsJ39RdPE7G3c+OFLqlsOnkFUpjjKs0wNJmS/fJd8izXibn0gJgjEN6djJdHoOngJj
         pSBlQaYJOqTCOG+m+erYfjyoTKPI3Mq71ovQBKNkZL1I1riy7C0QYPJ20mRjqZ+BqEHP
         X9uqOvdUbcXhQChS9crtdoprifBhLkKEn/Ki4fIEmNjehDgH4q4NwhBZIldOCmKl6fyH
         Lm0K9jspV/w63AvgEh0i4lrNK7XDh0h4G8PMzuDgaQokaj1awJ9xr5qAETqRUrX52gsh
         FtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774580152; x=1775184952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxOcLQAL828r9gNJF4VDxn22m5oC9wjYM2C1LJJwNlw=;
        b=Wi1veHau0C2pO2BzMYiuV+q6mNlEmf4xNbyKi0inXkthrjbZ8w3TZR6uHP/90nHmMH
         wHy0bPq4EvvoWQmFwJAppAjJ4I4r5K6BDQ9NKd9rgOJhi3gXwXTHb2yZ3dfsyshBOdLk
         LH/OMw/DmRCLBYTzXjVTRlFYji3V+BANb/wtJjPus5B53M/QVIl5+NrGD8p5+eG6+/9I
         k/FMeNqUrTcr+7LvcF+SwsKwWlchEGs8ureLBBESbQV+sZMo0Js53Nlm24wu+Y9kNbxI
         BVNLgBAcoNAilJY+Dz2++z78pxiomA1hse43hlnCEv34f6j1eAqwJgruSE1IGoovR8wf
         Z/cw==
X-Forwarded-Encrypted: i=1; AJvYcCUMK4d/HMBWtY8EWSQLizFnElj4fpSSJMlYDj3dbzi4TdSglRcvVK+sCFiOSiZH6Gm6/OjEn/QaCLhHIWzoEfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGT6SpvNI8o8OePn58ull4GLVy3Ag71r5cTQhc/4JVjOLspG69
	Dk9HqN2oxByHEwFrlv/6YCBhFHF2QR84duyrUewy11UdSUi4nwvpSSw+
X-Gm-Gg: ATEYQzzn8Z5ql0gsVNlymz/C7zDiouAGh/Vm39E2nxKCiolKI2aQKqLaDJIOa/1JJeK
	pM5dqZDsNE7AQ9UZna/sEIWTizMAsV1hzoOF0p6BlFlJY5Cg4IlNJgdBkd0X6OF9qK6NMx+MDgB
	Jyj6ipKTPlA6k4IzrclTSOArhWuLv1jn/bemnPgwav6W8pB8tQOP3T9uyFh7RnxDU5/OA/U0TjY
	BC+HpAwLDiLn048xuPkh618E9W+6yL97Wjhouj75ILz5Yk6f9p+IpQOv6uXwLE/ipSO6NIGZr1S
	Scx+/VQ75hch+/2jJIQnpiDRSYyfpSo+b2yb84hGyPQPUu1MJJ1YXqNwBle2pkeMkLK3mhAqmpO
	gIEsUds32J2AIwhFKyMMXE4T5znvk9GllQZfP6IDiYfeEXw63VPv9rEjMxb05rUIb+MuCjlB5z2
	qpNbcJFKqfMLoLLtMwn4+u4D/FLqRWAAiapvDGtuRCopUV7r2d/5Gv9q8=
X-Received: by 2002:a05:6a00:3e21:b0:82a:7f1a:758c with SMTP id d2e1a72fcca58-82c95c27a26mr779771b3a.11.1774580151840;
        Thu, 26 Mar 2026 19:55:51 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d1e63b6sm4205803b3a.12.2026.03.26.19.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 19:55:51 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] soc: qcom: wcnss: simplify allocation of req
Date: Thu, 26 Mar 2026 19:55:34 -0700
Message-ID: <20260327025534.7864-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get rid of automatic kfree and move allocation down to where it's used.

Use kzalloc_flex as we're dealing with a flexible array member.

Use struct_size to avoid some pointer math.

Add __counted_by for extra runtime analysis. Move the counting variable
assignment to right after allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/soc/qcom/wcnss_ctrl.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/qcom/wcnss_ctrl.c b/drivers/soc/qcom/wcnss_ctrl.c
index 62b424e90d90..ffb31a049d4a 100644
--- a/drivers/soc/qcom/wcnss_ctrl.c
+++ b/drivers/soc/qcom/wcnss_ctrl.c
@@ -94,7 +94,7 @@ struct wcnss_download_nv_req {
 	u16 seq;
 	u16 last;
 	u32 frag_size;
-	u8 fragment[];
+	u8 fragment[] __counted_by(frag_size);
 } __packed;
 
 /**
@@ -201,16 +201,12 @@ static int wcnss_download_nv(struct wcnss_ctrl *wcnss, bool *expect_cbc)
 {
 	const struct firmware *fw;
 	struct device *dev = wcnss->dev;
+	struct wcnss_download_nv_req *req;
 	const char *nvbin = NVBIN_FILE;
 	const void *data;
 	ssize_t left;
 	int ret;
 
-	struct wcnss_download_nv_req *req __free(kfree) = kzalloc(sizeof(*req) + NV_FRAGMENT_SIZE,
-								  GFP_KERNEL);
-	if (!req)
-		return -ENOMEM;
-
 	ret = of_property_read_string(dev->of_node, "firmware-name", &nvbin);
 	if (ret < 0 && ret != -EINVAL)
 		return ret;
@@ -224,11 +220,15 @@ static int wcnss_download_nv(struct wcnss_ctrl *wcnss, bool *expect_cbc)
 	data = fw->data;
 	left = fw->size;
 
+	req = kzalloc_flex(*req, fragment, NV_FRAGMENT_SIZE);
+	if (!req)
+		return -ENOMEM;
+
+	req->frag_size = NV_FRAGMENT_SIZE;
 	req->hdr.type = WCNSS_DOWNLOAD_NV_REQ;
-	req->hdr.len = sizeof(*req) + NV_FRAGMENT_SIZE;
+	req->hdr.len = struct_size(req, fragment, NV_FRAGMENT_SIZE);
 
 	req->last = 0;
-	req->frag_size = NV_FRAGMENT_SIZE;
 
 	req->seq = 0;
 	do {
@@ -264,6 +264,7 @@ static int wcnss_download_nv(struct wcnss_ctrl *wcnss, bool *expect_cbc)
 
 release_fw:
 	release_firmware(fw);
+	kfree(req);
 
 	return ret;
 }
-- 
2.53.0

