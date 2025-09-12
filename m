Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A8D21C179
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 04:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757650071; cv=none; b=HuHCmjaTCmA18KF3fCT0nkd8CLgN9PCwvlAll7SEa5EIXSIo3dURBvWG3OEwPNm2xcLItbq2USLC3qYfu14ESrrkpjV/CEDEMec4nwqxuYqpIYKdBZ5HGpawueEIam3W5+NFTcY3G68W28cpcXegzD6uUSTz9L3kSMg/azixmig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757650071; c=relaxed/simple;
	bh=lgp1LOhLLp/W5q+GFi1cI9hy6O6fqjuRWo/O+rRQgWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZtO6l065zGSc4jA4LVzviZPP5NGRDHVy4YjASi1r/+jpbNtPJsrW7OBNy/Pixi9Rp1bMO7E9uSkd3rF5p05C1qJp1k48uzc0pctws4dvgP6fp7aWEnLylqoDwNAhgcBp0TXP6AfGbcq/u/mw/dmMxBl2Ulvc7uUn5pGNN+HreFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fpRy7/pW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fpRy7/pW"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BKBaXi016087
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 04:07:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	30MVqau9h2AN1WxS7vqJoVCbxWXWCZTilNucOIr42c8=; b=fpRy7/pWGVZTP1Dz
	e1t34cDlD/ZTGfskyE/LL6vIYand7oenVD9yQVWch8rrYP+a3kdIqLPeBh6CQCw8
	wxTElaiRDoGt/Wogw+ZsQ09EWh8GVRb4p+b+PCp80AUzZxABlMhvc6poTwPfzHJ7
	ufkpi1TfRSxduaJmlqk6hvjvfvvNfa3KZMbz7J0wCXbd/WzT+4Jh7GySmAFqdX5F
	HcxJ7K58TVZsZKpjfs3uA6NbWFNrK9nICcp6PnKMf9g6/51FG26/kTpcOFR9WCTG
	FjjksPAbOki4XZZxkXvwxFoahWUkjzH19Hylj7H1QWWqCIAbW2P1TDKPtF+vQbHB
	r86uaA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t386jvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 04:07:48 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77283b2b5f7so2492459b3a.0
        for <linux-hardening@vger.kernel.org>; Thu, 11 Sep 2025 21:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757650068; x=1758254868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30MVqau9h2AN1WxS7vqJoVCbxWXWCZTilNucOIr42c8=;
        b=RdcycAn0+OEitq6UYx2hTRm6hXSXbhFfWKHUtj51VMAOpqugwdfY8PDzCzfMOxXhuq
         4EQPJkV9M8MChXipQBSETUbkKPjnXzlyjhDNA9nFEYNS57c3QkULWzk6S6N7eYw9qlT0
         msZWNhtuHk1czV7vpufYVKSRlUM5XC8e9k5CxhEBfiK9hYxFPiOCyMws8JoUk9TuLpiZ
         GygNpPf6pA2a7PimQxjKmOjbdjGgJbApU6TTh4w192s9v7mZ4bfa7S8RhNLHWk+lkvjE
         ZSPI67b7peccK2tluh7I77a/c8kawIWpvQWKNVV3SWui828kJECGHEL1KCIB9GgxfwE7
         wYrg==
X-Forwarded-Encrypted: i=1; AJvYcCW1xfOWvO31Gxx5izbsqkTzp1zA1+KG2SE1oM9fd57wGXqpZwqLjRtMACgvaPTJK60pnMzXvF2M+ADc7Kh1HFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXqNdAfEQMrvPVZA2VzzxjREyImurBYxAP/Hhof5plIztWY1nz
	eoXsozt606LgI14FmcXugpmtyFkQYIjSGMqDFikyCrYKLxnt/qiKJenxWX62GeCVv5yagX0V4hX
	vFEBfKfc0O/UK61AuBoBDrI96JcdKDPhZMr1jcbqalv70CFwkuND6iJEgxC1eT2cecJUGqw==
X-Gm-Gg: ASbGncv8dP7tfNPnNyTe9ljq7JiZ5FCfmyDqBMnJ4Uzr24eiwS8pSZmTXVk2DJ5swxF
	O07fxPvG99e5OD+QQ/YpewKDGcCsm8V0rvzvQo/b0cqGU6nKdCN2Dv3xThe8vL7HY+u4c2hQUkr
	1Fz+HKTx3XYU9JiC9Qpt7bvi288zGH6TE3xAl4rb3Ldja1E5DRUPiYPtciyvqrDNPaZuOewLPul
	ESgGqVvBbCOiUopjGxlxXb7GwRdOb1Snn/twaHT1GLcjyewousVXr+F3fnpwnb8kGdrMhGtR/nI
	dVr2k0jYGm2uEFyzkVZ0q9hUKlQFBtLduDmfjXzNClA/IRDxUUgAAM1/Dm2MjCQhUfN0RkNwUXr
	TWUNUc6h3gJ4rYYSrm3lKvHU=
X-Received: by 2002:a05:6a20:939d:b0:243:78a:82b3 with SMTP id adf61e73a8af0-2602c71d516mr1871837637.59.1757650067487;
        Thu, 11 Sep 2025 21:07:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHevztzKn6DXhvylSu0O6F+lXoEaD+zI7oVZzqteG9Gk7d9QFgPnS+w+PLRXJqMaYWSBzS4UA==
X-Received: by 2002:a05:6a20:939d:b0:243:78a:82b3 with SMTP id adf61e73a8af0-2602c71d516mr1871794637.59.1757650067008;
        Thu, 11 Sep 2025 21:07:47 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ad5e168fsm690960a12.13.2025.09.11.21.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 21:07:46 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 21:07:40 -0700
Subject: [PATCH v12 01/11] firmware: qcom: tzmem: export shm_bridge
 create/delete
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-1-17f07a942b8d@oss.qualcomm.com>
References: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
In-Reply-To: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuldeep Singh <quic_kuldsing@quicinc.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: nx909cqz1Ca6xEo3iX7CcTnvXjy5Wnsr
X-Proofpoint-GUID: nx909cqz1Ca6xEo3iX7CcTnvXjy5Wnsr
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68c39c94 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=sWKEhP36mHoA:10 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=5numxkeOl0lsm_bA3l4A:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfX6R3oOjKaWfBG
 dwuUbCyBdZg67s85ofguk+eWcdXq8yHcr+KImc8ffN+AkXYHd8YKHKzMQwdzyuqjhl+e/scEaPb
 Gs7oysO5voTlXAiMbspP5PShZ9OLGS/ewIGjKKYXvRMjfnAhbcfO/0L2z/OlGQGShFr8IW4HUF0
 EYM0Bob2RCWKYIRbJ0KEsuElyoQTl/LssWqLzzAjvkOacyH/JsrB4ha8Qj24I28shWXPQGRSOPc
 XsFGxmcrNo6WI4ZwCrY0mSE9thDqfyymNGdP4i/mG1nD63E+NuO+/tQpl6eYsanYBQVVe7My6Q7
 9t2QIUq+ZcynBxAAPNtPUHZI5mripRm2MsD3N0LxdhtU0a+SaGLuKlzuYeSi1O8wtQGBwOcFyla
 eaTyJAZT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066

Anyone with access to contiguous physical memory should be able to
share memory with QTEE using shm_bridge.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Harshal Dev <quic_hdev@quicinc.com>
Reviewed-by: Kuldeep Singh <quic_kuldsing@quicinc.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_tzmem.c       | 63 ++++++++++++++++++++++++++------
 include/linux/firmware/qcom/qcom_tzmem.h | 15 ++++++++
 2 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
index ea0a35355657..186511ced924 100644
--- a/drivers/firmware/qcom/qcom_tzmem.c
+++ b/drivers/firmware/qcom/qcom_tzmem.c
@@ -109,7 +109,19 @@ static int qcom_tzmem_init(void)
 	return 0;
 }
 
-static int qcom_tzmem_init_area(struct qcom_tzmem_area *area)
+/**
+ * qcom_tzmem_shm_bridge_create() - Create a SHM bridge.
+ * @paddr: Physical address of the memory to share.
+ * @size: Size of the memory to share.
+ * @handle: Handle to the SHM bridge.
+ *
+ * On platforms that support SHM bridge, this function creates a SHM bridge
+ * for the given memory region with QTEE. The handle returned by this function
+ * must be passed to qcom_tzmem_shm_bridge_delete() to free the SHM bridge.
+ *
+ * Return: On success, returns 0; on failure, returns < 0.
+ */
+int qcom_tzmem_shm_bridge_create(phys_addr_t paddr, size_t size, u64 *handle)
 {
 	u64 pfn_and_ns_perm, ipfn_and_s_perm, size_and_flags;
 	int ret;
@@ -117,17 +129,49 @@ static int qcom_tzmem_init_area(struct qcom_tzmem_area *area)
 	if (!qcom_tzmem_using_shm_bridge)
 		return 0;
 
-	pfn_and_ns_perm = (u64)area->paddr | QCOM_SCM_PERM_RW;
-	ipfn_and_s_perm = (u64)area->paddr | QCOM_SCM_PERM_RW;
-	size_and_flags = area->size | (1 << QCOM_SHM_BRIDGE_NUM_VM_SHIFT);
+	pfn_and_ns_perm = paddr | QCOM_SCM_PERM_RW;
+	ipfn_and_s_perm = paddr | QCOM_SCM_PERM_RW;
+	size_and_flags = size | (1 << QCOM_SHM_BRIDGE_NUM_VM_SHIFT);
+
+	ret = qcom_scm_shm_bridge_create(pfn_and_ns_perm, ipfn_and_s_perm,
+					 size_and_flags, QCOM_SCM_VMID_HLOS,
+					 handle);
+	if (ret) {
+		dev_err(qcom_tzmem_dev,
+			"SHM Bridge failed: ret %d paddr 0x%pa, size %zu\n",
+			ret, &paddr, size);
+
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_tzmem_shm_bridge_create);
+
+/**
+ * qcom_tzmem_shm_bridge_delete() - Delete a SHM bridge.
+ * @handle: Handle to the SHM bridge.
+ *
+ * On platforms that support SHM bridge, this function deletes the SHM bridge
+ * for the given memory region. The handle must be the same as the one
+ * returned by qcom_tzmem_shm_bridge_create().
+ */
+void qcom_tzmem_shm_bridge_delete(u64 handle)
+{
+	if (qcom_tzmem_using_shm_bridge)
+		qcom_scm_shm_bridge_delete(handle);
+}
+EXPORT_SYMBOL_GPL(qcom_tzmem_shm_bridge_delete);
+
+static int qcom_tzmem_init_area(struct qcom_tzmem_area *area)
+{
+	int ret;
 
 	u64 *handle __free(kfree) = kzalloc(sizeof(*handle), GFP_KERNEL);
 	if (!handle)
 		return -ENOMEM;
 
-	ret = qcom_scm_shm_bridge_create(pfn_and_ns_perm, ipfn_and_s_perm,
-					 size_and_flags, QCOM_SCM_VMID_HLOS,
-					 handle);
+	ret = qcom_tzmem_shm_bridge_create(area->paddr, area->size, handle);
 	if (ret)
 		return ret;
 
@@ -140,10 +184,7 @@ static void qcom_tzmem_cleanup_area(struct qcom_tzmem_area *area)
 {
 	u64 *handle = area->priv;
 
-	if (!qcom_tzmem_using_shm_bridge)
-		return;
-
-	qcom_scm_shm_bridge_delete(*handle);
+	qcom_tzmem_shm_bridge_delete(*handle);
 	kfree(handle);
 }
 
diff --git a/include/linux/firmware/qcom/qcom_tzmem.h b/include/linux/firmware/qcom/qcom_tzmem.h
index b83b63a0c049..48ac0e5454c7 100644
--- a/include/linux/firmware/qcom/qcom_tzmem.h
+++ b/include/linux/firmware/qcom/qcom_tzmem.h
@@ -53,4 +53,19 @@ DEFINE_FREE(qcom_tzmem, void *, if (_T) qcom_tzmem_free(_T))
 
 phys_addr_t qcom_tzmem_to_phys(void *ptr);
 
+#if IS_ENABLED(CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE)
+int qcom_tzmem_shm_bridge_create(phys_addr_t paddr, size_t size, u64 *handle);
+void qcom_tzmem_shm_bridge_delete(u64 handle);
+#else
+static inline int qcom_tzmem_shm_bridge_create(phys_addr_t paddr,
+					       size_t size, u64 *handle)
+{
+	return 0;
+}
+
+static inline void qcom_tzmem_shm_bridge_delete(u64 handle)
+{
+}
+#endif
+
 #endif /* __QCOM_TZMEM */

-- 
2.34.1

