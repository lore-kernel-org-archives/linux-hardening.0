Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308191DF982
	for <linux-hardening@vger.kernel.org>; Mon, 14 Jul 2025 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752454231; cv=none; b=O131yKim9XRL/jaQsTRXNKbCSt+A4tmahQhmzp05AP9O+M4SsQcuR2f6Fh4dARd5ie5s0O8ClIIxj450xKLqqmWZhDjd/2j2ZZvfyQxxq3zaW5zvWmGS1kwhVFu307tViRbuBD1loJ1bJ/D9o3nq4Myd4OpIrgKvSX/GmdOF0vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752454231; c=relaxed/simple;
	bh=2KwZ3KI5eKIBJMJcle/ZfSUr1MEMcnWJRLfVwTDios4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VmxXdEcssnHr6O4GCWGJEb8lo/pr5DWZEdDQrMqEgk5T53bYYYgtv8qolMmJs2XxOaObwh+sTWNYf+eYV3d/PbnrugLQ7lcNAMLysWM0K4WDcfly8nqm6HslPr6VRnLUEISlH05ccqACI8UQ9J29XpE0+iOo3/U1ZqEIxrX7HDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BnOfVpoL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BnOfVpoL"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DMmOcr011638
	for <linux-hardening@vger.kernel.org>; Mon, 14 Jul 2025 00:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b67myxdpCtuGIkbvWeVD6YddhWlprlVB9XE7tJnjHvU=; b=BnOfVpoL8XYgchEo
	0BRBel91B2k+b0u320i4z8TZV7oNSZNxAAznHcYI/4eWrQ8LOE491rCH9OwZwM0x
	leMVIr6SQOf8E8FsABxW604KxQ7Z3pN/URkxGbfPp5VoeksmUO3Z7Tc5uaxtp9E8
	r2rP/v3JqPOIhAB+WAim3sGGiEZl7xoF5Q9WfyTPE8FE6/FjCE1u1ewJkZ5Ircbi
	edBGRD3K+Q91kLY40MmHtFjO3Y2gAia0RSiQRSZrNjC86ES7RMilPYmKstO2+3b2
	qa0DEVobM2H614cUMSVX0h5hLn++BiN/xpXevoOSMpE183tAyVc4JvBWwD/0NNoy
	LwaSAw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47v56a1b4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 14 Jul 2025 00:50:29 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2382607509fso21709655ad.3
        for <linux-hardening@vger.kernel.org>; Sun, 13 Jul 2025 17:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752454228; x=1753059028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b67myxdpCtuGIkbvWeVD6YddhWlprlVB9XE7tJnjHvU=;
        b=lhMX/g5IHD8XPA84hR2T4Q06DbII4/bV19P8FnJwjjVVh6Sm4yPX0mKUAjaGOyC0i4
         j4+n4/0nMoKa0zciInf+lUSB/rPrkm+kA22DrayvrJka4klRHJOpSgtMNfbiNc24G13S
         FO7xI03nXDiAO9jKUyA73e0C2qcZ4kS86Cr/NrMoZgETK8lWm0gflTJkFuM+YJfhVtP9
         vjEB1pM3MszSPoNMFtl/XB/VZ8uCBIkPhzhVfIEy+JeDfLRfaDr8FmEc++TcpoUUecL0
         FqGWecQjuUHpDMyX5/tzkmxWnnC17N+kp12GiT5OeZCxHw6BRIR99BZ5h0xHX9iZ0flz
         ruag==
X-Forwarded-Encrypted: i=1; AJvYcCUz19gD7u8QMeVg+68d3EaY/ZqHlr150HODBA6x/m2CPSSe00w45FTkkDPEvXieWj/cBG1m0/5FaA60fB3PoNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLsX1fmsWn5iWejd6J+p+acM97YxlbSQBlf5TL2x2hqUZJAYkZ
	YrLnsmE6X2GhynjpGowTgl60dZ4ARbghwHHXod0Qy49ZwolHhea+gJqyDVcboUJPL1Ic5V/wubB
	WkE02SUWxRxUEVdJT69nSQFUUSbRfork78yYnG2lIF06hEjfMus31cIzce7dmsVRzqexM5g==
X-Gm-Gg: ASbGncuW0Ej8Tp7BWlwE+NYrPEb7PHym7h3wyCXOcX8ilpjcE+E+G9MgflxYq0LbAWr
	OWEHPFJsVgxAL0l0wcDdJww1VzBmDRm2ljfO6sbCFn0ndkBBV7a5ZYUEQXjPTC3agvELCVvuT/N
	eP6HyDkPLER8mwtUsRlnsjAJP46f5y5pbCLgB9OvON/2uGfTdiWmvw0VgkTS/lA2FYC3uGlDYtG
	Lr4/wWQE8q0v/SnILF1jeb3GVOI19JZvGy4HqgMvUaxDDNG50yFPjnXqf91YOqikJ+dMI20zlVA
	B30jBIMSK4fiUO2cNFrgwDwMzwDEHU8UYUDc1n6QJZOaGG1gStHjjxk+LC8pEPubmQfFoAaGy4X
	n7iIrJvfjJugkJpH8SZDHhhM=
X-Received: by 2002:a17:903:1245:b0:235:779:edea with SMTP id d9443c01a7336-23dede87276mr176010035ad.38.1752454228182;
        Sun, 13 Jul 2025 17:50:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7Mpvu7t8vk/+o90LARgzF3B+C1vy3adW9gyDL9dboTlzE/VukEM7b42Zrq1mzEQrn7FC6Ew==
X-Received: by 2002:a17:903:1245:b0:235:779:edea with SMTP id d9443c01a7336-23dede87276mr176009555ad.38.1752454227586;
        Sun, 13 Jul 2025 17:50:27 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de428473fsm87562605ad.13.2025.07.13.17.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 17:50:27 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Sun, 13 Jul 2025 17:49:18 -0700
Subject: [PATCH v6 06/12] firmware: qcom: scm: add support for object
 invocation
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-6-697fb7d41c36@oss.qualcomm.com>
References: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com>
In-Reply-To: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com>
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
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: VQ-5XwaPyCCxbyyICLsOK424f08mRLAc
X-Authority-Analysis: v=2.4 cv=X7BSKHTe c=1 sm=1 tr=0 ts=68745455 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=dBYAKgxw8cyf2mnx-aAA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: VQ-5XwaPyCCxbyyICLsOK424f08mRLAc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAwMiBTYWx0ZWRfX712/4ijsK0Lr
 vLs4W0uUCRPpNHQNSCG0bzhxBYtM/7Z4qbMZzqCP8VgEvjVRpDtSdO9zIdjGhSiUVLWL4i0Qbfv
 T0dVFY5vpkKYDaNa9pxk0Cc6kBhw9Q51NAFM4yQIpZ4ZStBOqLEHYminL13Zx3cM1QYuNLjHzwp
 tfPPVYL3Az9mFFk+L+Qkl5Hn7cP+2Fg3mSOr87dyCeOqgP3IfHefACwOpmM7tU0AolaFRVQRvh0
 00m8ORUvUPvVZzad6iKgBhGEKENXYIYI+Z11OTllq/SeGPo8D7HHjeAtl3hcbHCq+UlUUZxXU5y
 +ewJHye7NLk0s+QboO68Xc9+IX/Ncwtp6ZzjzXK2uQ8l7daOlifsOjmUeL0EdCiGmhkxFvGiGzn
 f4LMNybI7ozP24sy7/XQWNhBwJfR9NXZh2wm0c+WSVodLb7mPjZkKG7GRwaxIRZ/HOXbaj1+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140002

Qualcomm TEE (QTEE) hosts Trusted Applications (TAs) and services in
the secure world, accessed via objects. A QTEE client can invoke these
objects to request services. Similarly, QTEE can request services from
the nonsecure world using objects exported to the secure world.

Add low-level primitives to facilitate the invocation of objects hosted
in QTEE, as well as those hosted in the nonsecure world.

If support for object invocation is available, the qcom_scm allocates
a dedicated child platform device. The driver for this device communicates
with QTEE using low-level primitives.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Harshal Dev <quic_hdev@quicinc.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c       | 128 +++++++++++++++++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.h       |   7 ++
 include/linux/firmware/qcom/qcom_scm.h |   6 ++
 3 files changed, 141 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index f63b716be5b0..e3207a9d2de6 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2087,6 +2087,124 @@ static int qcom_scm_qseecom_init(struct qcom_scm *scm)
 
 #endif /* CONFIG_QCOM_QSEECOM */
 
+/**
+ * qcom_scm_qtee_invoke_smc() - Invoke a QTEE object.
+ * @inbuf: start address of memory area used for inbound buffer.
+ * @inbuf_size: size of the memory area used for inbound buffer.
+ * @outbuf: start address of memory area used for outbound buffer.
+ * @outbuf_size: size of the memory area used for outbound buffer.
+ * @result: result of QTEE object invocation.
+ * @response_type: response type returned by QTEE.
+ *
+ * @response_type determines how the contents of @inbuf and @outbuf
+ * should be processed.
+ *
+ * Return: On success, return 0 or <0 on failure.
+ */
+int qcom_scm_qtee_invoke_smc(phys_addr_t inbuf, size_t inbuf_size,
+			     phys_addr_t outbuf, size_t outbuf_size,
+			     u64 *result, u64 *response_type)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_SMCINVOKE,
+		.cmd = QCOM_SCM_SMCINVOKE_INVOKE,
+		.owner = ARM_SMCCC_OWNER_TRUSTED_OS,
+		.args[0] = inbuf,
+		.args[1] = inbuf_size,
+		.args[2] = outbuf,
+		.args[3] = outbuf_size,
+		.arginfo = QCOM_SCM_ARGS(4, QCOM_SCM_RW, QCOM_SCM_VAL,
+					 QCOM_SCM_RW, QCOM_SCM_VAL),
+	};
+	struct qcom_scm_res res;
+	int ret;
+
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	if (ret)
+		return ret;
+
+	*response_type = res.result[0];
+	*result = res.result[1];
+
+	return 0;
+}
+EXPORT_SYMBOL(qcom_scm_qtee_invoke_smc);
+
+/**
+ * qcom_scm_qtee_callback_response() - Submit response for callback request.
+ * @buf: start address of memory area used for outbound buffer.
+ * @buf_size: size of the memory area used for outbound buffer.
+ * @result: Result of QTEE object invocation.
+ * @response_type: Response type returned by QTEE.
+ *
+ * @response_type determines how the contents of @buf should be processed.
+ *
+ * Return: On success, return 0 or <0 on failure.
+ */
+int qcom_scm_qtee_callback_response(phys_addr_t buf, size_t buf_size,
+				    u64 *result, u64 *response_type)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_SMCINVOKE,
+		.cmd = QCOM_SCM_SMCINVOKE_CB_RSP,
+		.owner = ARM_SMCCC_OWNER_TRUSTED_OS,
+		.args[0] = buf,
+		.args[1] = buf_size,
+		.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_RW, QCOM_SCM_VAL),
+	};
+	struct qcom_scm_res res;
+	int ret;
+
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	if (ret)
+		return ret;
+
+	*response_type = res.result[0];
+	*result = res.result[1];
+
+	return 0;
+}
+EXPORT_SYMBOL(qcom_scm_qtee_callback_response);
+
+static void qcom_scm_qtee_free(void *data)
+{
+	struct platform_device *qtee_dev = data;
+
+	platform_device_unregister(qtee_dev);
+}
+
+static int qcom_scm_qtee_init(struct qcom_scm *scm)
+{
+	struct platform_device *qtee_dev;
+	u64 result, response_type;
+	int ret;
+
+	/*
+	 * Check if QTEE supports smcinvoke:
+	 * This will fail with -EINVAL due to invalid buffers, but first,
+	 * it checks whether the call is supported in QTEE syscall handler.
+	 * If not supported, -EIO is returned.
+	 */
+	ret = qcom_scm_qtee_invoke_smc(0, 0, 0, 0, &result, &response_type);
+	if (ret == -EIO)
+		return -EIO;
+
+	/* Setup QTEE interface device. */
+	qtee_dev = platform_device_alloc("qcomtee", -1);
+	if (!qtee_dev)
+		return -ENOMEM;
+
+	qtee_dev->dev.parent = scm->dev;
+
+	ret = platform_device_add(qtee_dev);
+	if (ret) {
+		platform_device_put(qtee_dev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(scm->dev, qcom_scm_qtee_free, qtee_dev);
+}
+
 /**
  * qcom_scm_is_available() - Checks if SCM is available
  */
@@ -2322,6 +2440,16 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	ret = qcom_scm_qseecom_init(scm);
 	WARN(ret < 0, "failed to initialize qseecom: %d\n", ret);
 
+	/*
+	 * Initialize the QTEE object interface.
+	 *
+	 * This only represents the availability for QTEE object invocation
+	 * and callback support. On failure, ignore the result. Any subsystem
+	 * depending on it may fail if it tries to access this interface.
+	 */
+	ret = qcom_scm_qtee_init(scm);
+	WARN(ret < 0, "failed to initialize qcomtee: %d\n", ret);
+
 	return 0;
 
 err:
diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
index 3133d826f5fa..665e21feec9b 100644
--- a/drivers/firmware/qcom/qcom_scm.h
+++ b/drivers/firmware/qcom/qcom_scm.h
@@ -155,6 +155,13 @@ struct qcom_tzmem_pool *qcom_scm_get_tzmem_pool(void);
 #define QCOM_SCM_SVC_GPU			0x28
 #define QCOM_SCM_SVC_GPU_INIT_REGS		0x01
 
+/* ARM_SMCCC_OWNER_TRUSTED_OS calls */
+
+#define QCOM_SCM_SVC_SMCINVOKE			0x06
+#define QCOM_SCM_SMCINVOKE_INVOKE_LEGACY	0x00
+#define QCOM_SCM_SMCINVOKE_CB_RSP		0x01
+#define QCOM_SCM_SMCINVOKE_INVOKE		0x02
+
 /* common error codes */
 #define QCOM_SCM_V2_EBUSY	-12
 #define QCOM_SCM_ENOMEM		-5
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 983e1591bbba..b3a7cc20e617 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -176,4 +176,10 @@ static inline int qcom_scm_qseecom_app_send(u32 app_id,
 
 #endif /* CONFIG_QCOM_QSEECOM */
 
+int qcom_scm_qtee_invoke_smc(phys_addr_t inbuf, size_t inbuf_size,
+			     phys_addr_t outbuf, size_t outbuf_size,
+			     u64 *result, u64 *response_type);
+int qcom_scm_qtee_callback_response(phys_addr_t buf, size_t buf_size,
+				    u64 *result, u64 *response_type);
+
 #endif

-- 
2.34.1

