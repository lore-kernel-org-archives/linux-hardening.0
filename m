Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F2F37DE9B
	for <linux-hardening@vger.kernel.org>; Tue,  7 Apr 2026 21:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775598735; cv=none; b=pzkF7caAWj69eUGms/qd7znxkljFxoMy6kMRqvAnc8CBaSjLwhFwUyR5pGpEvAAsn6nrF1r9WSJC6wLhE2WmEZf6UrxrsmtTyhhaqcZ4DOj7bXH+N1QhtHJxV4E2GSSDb2PB/rtoSAZBKMxK/Eih7bYXoBE5bqqbM5Yb6ovqjkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775598735; c=relaxed/simple;
	bh=2Y3ZNVnqNzvGn4NwizHcAhPQrYo7GkEd/vnRF4b+W5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=diQDetVGG30LMGbP7qQOrvzvBItkiBO3JBZHFGyUQPHhRTHN+ECFFzFXnQmSfWERTgR9qKmYWXsLbb5gMhj/DefxRA7D3iPcsElCoyC+Xg1APbrunKwjwGpKjst0vXniclmZV8yckvcemXxqNfjnkzLzUICj85q4wPci81+zdeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nLiFr5Q3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WIWGLzc5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nLiFr5Q3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WIWGLzc5"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637Jl4rh2580434
	for <linux-hardening@vger.kernel.org>; Tue, 7 Apr 2026 21:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dkodzDOEhiLOVRt5dWjZn1rS8FD4B1gl5hvYY5lrWII=; b=nLiFr5Q3YhEomPX1
	5/9AaxHosLqrpEmpjdtOPv07RaxStJfYUaGAUMdBM0IwLA5n8nzKUG+y/nHzRntm
	J8KDJUIJ0gxivX3Ms5a8IQCrJ5MMiT+8qvglXZtxuRS6BmhZVdzg72xFpfT5CIe2
	uJMmjkDFAzqoFqoNkOwLOcUB8quVLp0vy0jO8hcd1+oTvCpWwHVI+Eh1VFIGrACQ
	1/VJq61gLiaj20QoULTuH4uMGTyEpe+xlAGZz2SQ0E8JobfXi/87N+MIZDNY5M2F
	4oR4hWd0RHwgPXLDEMdC7fv0Y/tJS4wSgmV5/95t2lSgZG4X+xnykSedhAtW82Ww
	C5tseA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmsf4rkw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 07 Apr 2026 21:52:12 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-12776bebeb3so21877985c88.1
        for <linux-hardening@vger.kernel.org>; Tue, 07 Apr 2026 14:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775598731; x=1776203531; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkodzDOEhiLOVRt5dWjZn1rS8FD4B1gl5hvYY5lrWII=;
        b=WIWGLzc5ekjIZjdZB6Z9k2Q1v0AEvmiHUbT379XvBN5226+4LdMh0pd6LIpUN2k0Ki
         KxJrad8SDHNwXCTEvcZuj8rSupKWXYleXEgGTwkY8+dey/XdV9gxB9ZLZSwWzQxooiB3
         LW3M3Xk4bKpt28GwV2xg0haDLLrnjapoOX7kKz+BOJ4oNxYlAqm7Xtk5KrjHWn7g8mmM
         sWdC8T0O1B/Ot4tSLzceRImKUET/NRji2l7uLMAbRj1IU5QTcEVBmIogYfq54iyAVIbD
         DQsMfm4tbqM6XUNKUs/0oqzbMugBMoIfxjtKTOJypeyYllQg8F58Vfmrj0oOQ/PL+c+z
         aa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775598731; x=1776203531;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dkodzDOEhiLOVRt5dWjZn1rS8FD4B1gl5hvYY5lrWII=;
        b=MckwNT5zxN2aM+XiCFiOFPrqnDMiuO+rq7dRLl0uP4XMvem+l6jb/VmbokrLB/CyvL
         G/Ny8JAhKtdj3VyK+e7wYrgu5XatmS5zk5/8R2p0CzR6uZgO0RH33qegJEgPIBjewh8p
         dqQYnGQYussxPEbFghUHwSkMSU+eqQOSLuesBmEsbmerbF3HElyk6nWsY6w4x1A8oJw9
         vvlVGSOgfQ3WbmOY32S2yjblH+nZISaLILn6w3wuf23jdREInUGMfpcA7X1o7MomGlrt
         1ZOu/fmeA+/H8cEJeRT5oaCA1YLcmWGiQfK4ffqgww8Erxes4p6RBv9u+eD5CQ4Kn9aN
         VOYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB/V6XGr5KHYGEEXeKAHbT0y5T6x/ulcoLmsJfk5TpEcPifVYEfClT51rb6OQTU8ABtiT2wnBaR21TmoNzUyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl/mdEEx+8FwmpAr3ahHPQ/f/5Sjx5CFdDbaPqnTfM364ibmrD
	TwapfMS1w/Z1fviHfG1Fh4vxADtygASyxVl1RGZi5oNk9SGRlhRz8gtymEv9kJXsZIgsXMPh0tI
	gtYKSMhp7xAStVfHNn9nD+aRsDi9I59pF1N9ZqFRDoJSB/KEAh0SJCNRPxq3LaGyMyPXYrg==
X-Gm-Gg: AeBDievJ6gS9JjOzPfeFUvwfNUPE3UlC0c6gy+ln6PjyIL/5q/BLuXhSewuyICxNMWX
	9kNXhsb5mdhLdlydftoZDq3H29ebo3L2L1MSTsoiQvT2aGT+ku/wEAyVZokujl4xWC7KKD5O4R4
	iBFrdsXTx7Xkz4QyxB/7zAr2rO89t+4u00Mx6VaNOe97fSPpIH+KejH2WYuypdeZlvabH577D7Z
	Vf18VNVFR+tw6B8G+0vZu+wM/c7KnUEHjmD0YtFHazRhyYaV+7jUuLVUJR4ra+mI4s9MSsecZtb
	wAjNSAyLlUVtuAzOTMsVmigi2jKZBute5+hacIid4g/ifzDjz3CsgdQig9yyJQ7JrIpTEQBseHr
	5clU61u70Gu+D6/H6FzmZXNMyITaLpAWfm5iCBU7l7biJhXn3tocMedCLELhDqTx2NwQvZjz2JQ
	==
X-Received: by 2002:a05:7022:e09:b0:12a:6902:ddc6 with SMTP id a92af1059eb24-12bfb63ac8cmr9001249c88.0.1775598731151;
        Tue, 07 Apr 2026 14:52:11 -0700 (PDT)
X-Received: by 2002:a05:7022:e09:b0:12a:6902:ddc6 with SMTP id a92af1059eb24-12bfb63ac8cmr9001230c88.0.1775598730474;
        Tue, 07 Apr 2026 14:52:10 -0700 (PDT)
Received: from hu-fruiz-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bfea5f860sm16224123c88.2.2026.04.07.14.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 14:52:08 -0700 (PDT)
From: Francisco Munoz Ruiz <francisco.ruiz@oss.qualcomm.com>
Date: Tue, 07 Apr 2026 14:51:49 -0700
Subject: [PATCH v2 3/3] soc: qcom: llcc-qcom: Capitalize LLCC/EDAC in
 comments and diagnostics
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-external_llcc_changes2set-v2-3-b5017ce2020b@oss.qualcomm.com>
References: <20260407-external_llcc_changes2set-v2-0-b5017ce2020b@oss.qualcomm.com>
In-Reply-To: <20260407-external_llcc_changes2set-v2-0-b5017ce2020b@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Francisco Munoz Ruiz <francisco.ruiz@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775598723; l=8946;
 i=francisco.ruiz@oss.qualcomm.com; s=20260305; h=from:subject:message-id;
 bh=2Y3ZNVnqNzvGn4NwizHcAhPQrYo7GkEd/vnRF4b+W5o=;
 b=IxUukN8806itKMrKByDZN01avDTh3nItvCv15dyMmUgM3ou7zZvG8plz2MqOg88Rf8HP5xkPK
 AGTqhhkTj0UBVIpxNmoN8H4ySp1J2wB4yQzSOSjFJJL7fKFbc6RYN7s
X-Developer-Key: i=francisco.ruiz@oss.qualcomm.com; a=ed25519;
 pk=Gcv2CX7iHozjnQ4oK+9fINmBiQTmVC4SpaZzoM63CHE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDIwMCBTYWx0ZWRfX/CTb71gjHI5c
 gkkEc3LMDbvc9WJDdSEpmJEIRr5Bi4GwqMeKQwE62+VlDEKBrpj/0prjSam3onZQToKwgdQrVmL
 zc2wM5DwYXOQOa2gLtzp3ZbegRP/0TkXQFoSi7/jdH+rEhOmTsmXhyNwehJt7ELiJUlfxiEpQi7
 1dbr+ABxoYyXlH2AatJNFiqFTHAOtd8wLNVsZErDI+8xUCia30uscsUHSn37pYzU8Q+xO++MOVj
 8b5yWbhFF5coiRr9515/te/ks0umqTbIOsG13xEIRZN6IyOVpo1UjhGTD51BMJwggaocZHH7igc
 3CpRIENPMlfubwkm791LEuRHzMApNi8Q0Wcx/r54c7BArxqu0H8FZXu0jummJQ+B45Av8NRS3d0
 YWtQAh/0N05AXnuyNb57YqJ9H4OzAE/bV2Q9wUIgoIPgLU8KmOlMytz7GilPt/Kk99z7cBV7Oqs
 0e8m8aEPhoRGM9Fli3Q==
X-Proofpoint-ORIG-GUID: fbgXMFqNQs-EGP7zK84-B9DLBXpTwVQM
X-Proofpoint-GUID: fbgXMFqNQs-EGP7zK84-B9DLBXpTwVQM
X-Authority-Analysis: v=2.4 cv=DcInbPtW c=1 sm=1 tr=0 ts=69d57c8c cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=19UnNs3dAo88WjIHmoIA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_05,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070200

Capitalize occurrences of the acronym "LLCC" and "EDAC" in comments
and diagnostic text to improve consistency and readability.

Signed-off-by: Francisco Munoz Ruiz <francisco.ruiz@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/soc/qcom/llcc-qcom.c       | 32 ++++++++++++++---------------
 include/linux/soc/qcom/llcc-qcom.h | 42 +++++++++++++++++++-------------------
 2 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index f8cd35b205eb..dcc08f63e020 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -83,9 +83,9 @@
 #define SLC_SCT_SLICE_ACT_ON_BOOT     BIT(25)
 
 /**
- * struct llcc_slice_config - Data associated with the llcc slice
+ * struct llcc_slice_config - Data associated with the LLCC slice
  * @usecase_id: Unique id for the client's use case
- * @slice_id: llcc slice id for each client
+ * @slice_id: LLCC slice id for each client
  * @max_cap: The maximum capacity of the cache slice provided in KB
  * @priority: Priority of the client used to select victim line for replacement
  * @fixed_size: Boolean indicating if the slice has a fixed capacity
@@ -99,7 +99,7 @@
  *             slice: normal or TCM(Tightly Coupled Memory)
  * @probe_target_ways: Determines what ways to probe for access hit. When
  *                    configured to 1 only bonus and reserved ways are probed.
- *                    When configured to 0 all ways in llcc are probed.
+ *                    When configured to 0 all ways in LLCC are probed.
  * @dis_cap_alloc: Disable capacity based allocation for a client
  * @retain_on_pc: If this bit is set and client has maintained active vote
  *               then the ways assigned to this client are not flushed on power
@@ -4626,10 +4626,10 @@ static const struct qcom_sct_config x1e80100_cfgs = {
 static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
 
 /**
- * llcc_slice_getd - get llcc slice descriptor
+ * llcc_slice_getd - get LLCC slice descriptor
  * @uid: usecase_id for the client
  *
- * A pointer to llcc slice descriptor will be returned on success
+ * A pointer to LLCC slice descriptor will be returned on success
  * and error pointer is returned on failure
  */
 struct llcc_slice_desc *llcc_slice_getd(u32 uid)
@@ -4652,8 +4652,8 @@ struct llcc_slice_desc *llcc_slice_getd(u32 uid)
 EXPORT_SYMBOL_GPL(llcc_slice_getd);
 
 /**
- * llcc_slice_putd - llcc slice descriptor
- * @desc: Pointer to llcc slice descriptor
+ * llcc_slice_putd - LLCC slice descriptor
+ * @desc: Pointer to LLCC slice descriptor
  */
 void llcc_slice_putd(struct llcc_slice_desc *desc)
 {
@@ -4716,8 +4716,8 @@ static int llcc_update_act_ctrl(u32 sid,
 }
 
 /**
- * llcc_slice_activate - Activate the llcc slice
- * @desc: Pointer to llcc slice descriptor
+ * llcc_slice_activate - Activate the LLCC slice
+ * @desc: Pointer to LLCC slice descriptor
  *
  * A value of zero will be returned on success and a negative errno will
  * be returned in error cases
@@ -4752,8 +4752,8 @@ int llcc_slice_activate(struct llcc_slice_desc *desc)
 EXPORT_SYMBOL_GPL(llcc_slice_activate);
 
 /**
- * llcc_slice_deactivate - Deactivate the llcc slice
- * @desc: Pointer to llcc slice descriptor
+ * llcc_slice_deactivate - Deactivate the LLCC slice
+ * @desc: Pointer to LLCC slice descriptor
  *
  * A value of zero will be returned on success and a negative errno will
  * be returned in error cases
@@ -4789,7 +4789,7 @@ EXPORT_SYMBOL_GPL(llcc_slice_deactivate);
 
 /**
  * llcc_get_slice_id - return the slice id
- * @desc: Pointer to llcc slice descriptor
+ * @desc: Pointer to LLCC slice descriptor
  */
 int llcc_get_slice_id(struct llcc_slice_desc *desc)
 {
@@ -4802,7 +4802,7 @@ EXPORT_SYMBOL_GPL(llcc_get_slice_id);
 
 /**
  * llcc_get_slice_size - return the slice id
- * @desc: Pointer to llcc slice descriptor
+ * @desc: Pointer to LLCC slice descriptor
  */
 size_t llcc_get_slice_size(struct llcc_slice_desc *desc)
 {
@@ -4836,9 +4836,9 @@ static int _qcom_llcc_cfg_program(const struct llcc_slice_config *config,
 	/*
 	 * LLCC instances can vary for each target.
 	 * The SW writes to broadcast register which gets propagated
-	 * to each llcc instance (llcc0,.. llccN).
+	 * to each LLCC instance (llcc0,.. llccN).
 	 * Since the size of the memory is divided equally amongst the
-	 * llcc instances, we need to configure the max cap accordingly.
+	 * LLCC instances, we need to configure the max cap accordingly.
 	 */
 	max_cap_cacheline = max_cap_cacheline / drv_data->num_banks;
 	max_cap_cacheline >>= CACHE_LINE_SIZE_SHIFT;
@@ -5424,7 +5424,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 						"qcom_llcc_edac", -1, drv_data,
 						sizeof(*drv_data));
 		if (IS_ERR(llcc_edac))
-			dev_err(dev, "Failed to register llcc edac driver\n");
+			dev_err(dev, "Failed to register LLCC EDAC driver\n");
 	}
 
 	platform_set_drvdata(pdev, drv_data);
diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
index b5e917154998..f3ed63e475ab 100644
--- a/include/linux/soc/qcom/llcc-qcom.h
+++ b/include/linux/soc/qcom/llcc-qcom.h
@@ -89,9 +89,9 @@
 
 /**
  * struct llcc_slice_desc - Cache slice descriptor
- * @slice_id: llcc slice id
- * @uid: Unique ID associated with the llcc device
- * @slice_size: Size allocated for the llcc slice
+ * @slice_id: LLCC slice id
+ * @uid: Unique ID associated with the LLCC device
+ * @slice_size: Size allocated for the LLCC slice
  * @refcount: Atomic counter to track activate/deactivate calls
  */
 struct llcc_slice_desc {
@@ -102,7 +102,7 @@ struct llcc_slice_desc {
 };
 
 /**
- * struct llcc_edac_reg_data - llcc edac registers data for each error type
+ * struct llcc_edac_reg_data - LLCC EDAC registers data for each error type
  * @name: Name of the error
  * @reg_cnt: Number of registers
  * @count_mask: Mask value to get the error count
@@ -148,17 +148,17 @@ struct llcc_edac_reg_offset {
 };
 
 /**
- * struct llcc_drv_data - Data associated with the llcc driver
- * @dev: device back-pointer for this llcc instance
- * @regmaps: regmaps associated with the llcc device
- * @bcast_regmap: regmap associated with llcc broadcast OR offset
- * @bcast_and_regmap: regmap associated with llcc broadcast AND offset
+ * struct llcc_drv_data - Data associated with the LLCC driver
+ * @dev: device back-pointer for this LLCC instance
+ * @regmaps: regmaps associated with the LLCC device
+ * @bcast_regmap: regmap associated with LLCC broadcast OR offset
+ * @bcast_and_regmap: regmap associated with LLCC broadcast AND offset
  * @cfg: pointer to the data structure for slice configuration
  * @edac_reg_offset: Offset of the LLCC EDAC registers
  * @lock: mutex associated with each slice
  * @cfg_size: size of the config data table
- * @num_banks: Number of llcc banks
- * @ecc_irq: interrupt for llcc cache error detection and reporting
+ * @num_banks: Number of LLCC banks
+ * @ecc_irq: interrupt for LLCC cache error detection and reporting
  * @ecc_irq_configured: 'True' if firmware has already configured the irq propagation
  * @version: Indicates the LLCC version
  * @desc: Array pointer of pre-allocated LLCC slice descriptors
@@ -181,38 +181,38 @@ struct llcc_drv_data {
 
 #if IS_ENABLED(CONFIG_QCOM_LLCC)
 /**
- * llcc_slice_getd - get llcc slice descriptor
+ * llcc_slice_getd - get LLCC slice descriptor
  * @uid: usecase_id of the client
  */
 struct llcc_slice_desc *llcc_slice_getd(u32 uid);
 
 /**
- * llcc_slice_putd - llcc slice descriptor
- * @desc: Pointer to llcc slice descriptor
+ * llcc_slice_putd - LLCC slice descriptor
+ * @desc: Pointer to LLCC slice descriptor
  */
 void llcc_slice_putd(struct llcc_slice_desc *desc);
 
 /**
  * llcc_get_slice_id - get slice id
- * @desc: Pointer to llcc slice descriptor
+ * @desc: Pointer to LLCC slice descriptor
  */
 int llcc_get_slice_id(struct llcc_slice_desc *desc);
 
 /**
- * llcc_get_slice_size - llcc slice size
- * @desc: Pointer to llcc slice descriptor
+ * llcc_get_slice_size - LLCC slice size
+ * @desc: Pointer to LLCC slice descriptor
  */
 size_t llcc_get_slice_size(struct llcc_slice_desc *desc);
 
 /**
- * llcc_slice_activate - Activate the llcc slice
- * @desc: Pointer to llcc slice descriptor
+ * llcc_slice_activate - Activate the LLCC slice
+ * @desc: Pointer to LLCC slice descriptor
  */
 int llcc_slice_activate(struct llcc_slice_desc *desc);
 
 /**
- * llcc_slice_deactivate - Deactivate the llcc slice
- * @desc: Pointer to llcc slice descriptor
+ * llcc_slice_deactivate - Deactivate the LLCC slice
+ * @desc: Pointer to LLCC slice descriptor
  */
 int llcc_slice_deactivate(struct llcc_slice_desc *desc);
 

-- 
2.34.1

