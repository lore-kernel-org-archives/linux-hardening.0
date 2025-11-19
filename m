Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B433A79AD
	for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567165; cv=none; b=GGPu6qI9YVr1Kr+cq8we4NjY0VW0/feqZ1VmoOMdpczfef8Lm06XzFIDJ+cLddyY8K16UOH33V0sfJSI5V/nEqfbevcPoXbJAk4SLcxgZ13o+Bw8eNs1QOTeEVX5fJk6W9typs8yyT49zfTRjwiUWN3GOO0bfDBjN5OXtmPbgnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567165; c=relaxed/simple;
	bh=BG5tLoxomZq6QyZmtX+DmOmp49QzG4CslaIEh2rN2og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTHs5pzamHX5yctcmHhnoJHjOGAtUXJnvJQ5Pzi7Hqh/kNvuHw6Ep4j6rWiY9EqQxt7p+qgqsvvB8ZmIQqtpiNLDcbf73ZVGvXFXbj5Qmpe8xSJ3v02zTQIlPI+QxQ1HvxRrd4XxPSHv+JuCyTmfNaLsTdbBc7qOihPf/FNWBWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h67n1qs9; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h67n1qs9"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429ce7e79f8so4789790f8f.0
        for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 07:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567159; x=1764171959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqVd/I23ujzds6aG+1Lfyj/OLmPD/Ehk8Zy8jv9bGeE=;
        b=h67n1qs9Ihf0s3aPMinZSRCAczRQpw45ihMWMfjlNIvhknSfGnG+w+mMTwEi2c4pVy
         DL0+rKrt3+DReC07qFokF5Zkip6Gxvmbs6ndgMAcyZWTrgMwyDTjzLCMzlMYA9iEa8Sp
         Qtv3Ml8J57ag90nIHGke7OMoWVl6pkSuHd+H9mOYHRulvjzQRwMtGgelh1C/+3AXs0Vp
         mPSyP3aEBR4pq7oTf94IHwIeM5TfZSJDalWq7B2Kt327N8QvEp4zkM/wHSsLopjX5SEg
         6CImGXk5cI/2l+iH0yRuOdj8QppJoe8lro4QThyAmtoqPuVU4Oz9R0Ce1/nthGUifyJ5
         gWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567159; x=1764171959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rqVd/I23ujzds6aG+1Lfyj/OLmPD/Ehk8Zy8jv9bGeE=;
        b=IlkTo1sDGsBVMp07lCrBnDCtRaPYZa6HyCmOHVKxhFEzwXcoKqgcTB8mr8eT8k9TmD
         //tHyZqoAwzXOLYp4bFISZck0BeQFO/6CKxCAC5sMnSuweZlemP2fsK6+D1dPez/9HrH
         /6wzfTu+d0OsMF4+aFejhI98Jv28VzWA2iKYYI5246FGwmzxuZ1vuFn54h2i/xeTaP73
         YVRiPSR0ITBphpETzTDcRqHfeuRb9wOw2sCv93vjbWcTLX4No3DnQQutlxRtAuZikkMw
         7TJBQHK00D0gB0+0CxmNMu+nmlmaVgdw6UJiD/dzdR8zt/jhEarQbGO6NTztELAFIfGz
         6eaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBQfY1nDJvnngmJ3JlXLzqNSW615Qjs1nZ6zWliJa5nGUdRPbgVgwAQKmo7tuerwi72sj2rw6rV+BnpdVZEAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQKW5GNwLvUDTBlrE9jGFlPvmmX91wDSrK2vLJRX9ViKjIE/CW
	Y3kkCpUVoBPIwBmwcrlCZduP4tHHBvkB19mEEb1x6pV5cIJa0CfNLxhmnygnHk/U/xo=
X-Gm-Gg: ASbGnctkl7vN6CT56He7AImEAQZYUikoQELpz+QruJsK9k3fBDRV6WiKaAm3y1pa6Wp
	Ra5Oiv5YiG97PGIjT2xHLeXzuqmtaiOjjuz/fg4NA6dT2FJc5W7zjTrFP8+rBLgnwTOi+o7+7sN
	/inCGRBkUS69MNlBa3HU00Dkk6oXQ68LScCFPbWPtlpDfgkYbiTaPruy5noJDKbPhOga8SRG8lJ
	U6PcHrfqSWaO69jdXuFgPMRYgwd1JMUqbAAo/vQnZHW2fHEXvXwUYhVYupkHyCqJgVLf/kjVgKH
	F1V6DqF7zZwWP9Swv3mSF7RN4ZlwSzZfOyH/eCQ4T/vUdkXIFA+tHRCSHUwW5Hsdr9MFN3sdQe2
	LYoS9ws/mQ8mrCqmZFGOb0ZF9MyS2rMNpsEONxxyYW2Ll7xj9hhJWDGk/H2487LVnseSIrzMbj8
	az8hwVbPCmR0DU7N7HcNcSXhyW0xU2dQ==
X-Google-Smtp-Source: AGHT+IETZCFytuhcxmwyAYMbvVQ+k0LcHrDBKuExYdhaEVzislepliPqczS5k/WGmFJtVck24Vggmg==
X-Received: by 2002:a05:6000:2405:b0:42b:3a84:1ec3 with SMTP id ffacd0b85a97d-42b5937ff2emr21375859f8f.29.1763567158737;
        Wed, 19 Nov 2025 07:45:58 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:58 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org,
	tony.luck@intel.com,
	kees@kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 24/26] soc: qcom: smem: Add minidump device
Date: Wed, 19 Nov 2025 17:44:25 +0200
Message-ID: <20251119154427.1033475-25-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119154427.1033475-1-eugen.hristev@linaro.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a minidump platform device.
Minidump can collect various memory snippets using dedicated firmware.
To know which snippets to collect, each snippet must be registered
by the kernel into a specific shared memory table which is controlled
by the qcom smem driver.
To instantiate the minidump platform driver, register its data using
platform_device_register_data.
Later on, the minidump driver will probe and obtain the required memory
snippets from the memory inspection table (meminspect)

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 drivers/soc/qcom/smem.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index c4c45f15dca4..03315722d71a 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -270,6 +270,7 @@ struct smem_region {
  * @partitions: list of partitions of current processor/host
  * @item_count: max accepted item number
  * @socinfo:	platform device pointer
+ * @mdinfo:	minidump device pointer
  * @num_regions: number of @regions
  * @regions:	list of the memory regions defining the shared memory
  */
@@ -280,6 +281,7 @@ struct qcom_smem {
 
 	u32 item_count;
 	struct platform_device *socinfo;
+	struct platform_device *mdinfo;
 	struct smem_ptable *ptable;
 	struct smem_partition global_partition;
 	struct smem_partition partitions[SMEM_HOST_COUNT];
@@ -1236,12 +1238,20 @@ static int qcom_smem_probe(struct platform_device *pdev)
 	if (IS_ERR(smem->socinfo))
 		dev_dbg(&pdev->dev, "failed to register socinfo device\n");
 
+	smem->mdinfo = platform_device_register_data(&pdev->dev, "qcom-minidump",
+						     PLATFORM_DEVID_AUTO, NULL,
+						     0);
+	if (IS_ERR(smem->mdinfo))
+		dev_err(&pdev->dev, "failed to register platform md device\n");
+
 	return 0;
 }
 
 static void qcom_smem_remove(struct platform_device *pdev)
 {
 	platform_device_unregister(__smem->socinfo);
+	if (!IS_ERR(__smem->mdinfo))
+		platform_device_unregister(__smem->mdinfo);
 
 	hwspin_lock_free(__smem->hwlock);
 	__smem = NULL;
-- 
2.43.0

