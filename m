Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C51442C
	for <linux-hardening@vger.kernel.org>; Wed, 10 Sep 2025 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757463085; cv=none; b=TMMDFLyvKKxwFJ9cu+hZwgcZrtcoQyEOYK3boSrfGEoA5oLg5lXW+JcHAj8TQtDBDhn7KWo+3ygE11+s+9Fx0jXc8P2TQQneWukQnd8G/5tbkYhRuiIxVvDm86CsGeKgXDYsRcw+PIxpl0vnJ0pcqbAT1ehjPTaSFmctRlkx+fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757463085; c=relaxed/simple;
	bh=ZRS6JSqauRlryJc3bfvaAzYiMZgptSB3VgRLdbw/uJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ivuwdTDOERLFSHccmZvZFr7KTcDCR46GSJT2enpU9n8V2p5eI47NqVvjh37CeSZ6srjULiMpsBwTroLIhTgr5kXwDEn1U9qwaCG2rp7Z+cPa+LxcI5zEu74GIkPNPzUiRPVZTSfUw6wFZQ6oe2DQ+dBW+nEUHhwlBH9yiN8e0RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oqZ857Gr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oqZ857Gr"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589HVFKS029169
	for <linux-hardening@vger.kernel.org>; Wed, 10 Sep 2025 00:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8jY2HwwgMRulTaAiPVsU/MOC8fxFx36a56qnT/3OybA=; b=oqZ857GrknySkiTP
	8OxQvZv7gcfyhtHQS7R2+iIUH5KQrb9FZaRkXoGFXed/+orxuB4r1BoDPrRBb/7m
	wjE5Q/ED/OKS2EbhGXfR/HVf1R6Xrh8yPpMraSGZe2BbtAp9nmrA/is6VG1RXILZ
	AISMbpB89/SqqnfklD5E2/C1PwMbEj3R5ya7+R2tl3U2hV2qF+PYQaGY/gyILipI
	JxjbEgoMuhd5HXEA+H/zHYMyvuzGE+n34Mteaa0JV8Bi3mRQnxIGO4SzptCtNpwC
	9nHgzoS7nX3XiYv3JO9wAqAuePCDFKzfI3WZhSGGzacVUigwcpBz5ynXP4+P/J1C
	hcxDVw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8j1kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 10 Sep 2025 00:11:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24cc4458e89so142480595ad.1
        for <linux-hardening@vger.kernel.org>; Tue, 09 Sep 2025 17:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757463080; x=1758067880;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jY2HwwgMRulTaAiPVsU/MOC8fxFx36a56qnT/3OybA=;
        b=MGNiUmTU8jkRvTpd5MQqCr5SLAgUI9WwsBfFl2Z7e8yynMRDS+5y9Siws/xjSYs/8I
         DVNYRT0BXZ3Btt5DssIeeYJ9ojh67aRYmFRt7xF4VYWLDhe0itcGApxFIbKC5laLnv/R
         gNGyv1KoM58LpwUnOJlhnXlqBg2b6Uiamd5z7b79gP4rOB7B+kYvZjx7y1R3JCoGbAiC
         l/O5OqV2IwpN1araUfBLeL6O7vwKVNoI1/ivjj+7wnyssJj2ziV5yw6u/xXzFaTTs2BW
         2b+AGPgki5TjNJrAMIoIAAQWhS+nwZS4+wlsutu74kR6mUMxqp4Q0F0r+gJHA9M/qnZS
         6rhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHykDUd8K7QbWLAouqDbYsUQn7s3k3rvuqaqI0boywvVZjyzZ0Leos64JVwKqZ6VGsPSdFHC9tuidMXhfJ42g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxOuj5GDVEbo2cl6ZrIowRjZ2+N2e8od1LoLjAnHmmEwhLBk2y
	LEskVFDclGHJEkbPFNDP8+AN3KBDI9Brh4YydXNpkJr4GCVl68lvgsfY9yMkpnGpozoEsoL0B2i
	7YeqT2ELj4bWvGJBjApiWonAhDk4IeMe7zFtAC3LAaybtmhVQ7wTjI2wSuhb2dgF2QYoTcQ==
X-Gm-Gg: ASbGnct3GyK7XN9F71LEOHS0vyl56KpDeqi+Qamm8XuoAlHKmVveaCTrxRa0Kv9WFNk
	WMlAZsWVn7Viu8JO/xpsJIr3iMdxvy5ID1CyqmMK3Z28WPFZnd7ATzpLkF4yDiE5Y+VJpniQyuT
	mBSqjitbgglnhMiYqd/7yLOuBF3cr8C+Q5y3gfd3NnBOmURArZNFfCJIm8tx1gJ7sOoRGeBybpE
	q3foR+Foeiv6cUO6+bxqx/fwGY/L7REoRHxKp2p+5iUHK5/72eRaR0o0e7qK9htQIIdGRX5Um8G
	mlRcUpLT/HzWsbawgtqbfHghjbyXatdaErAVFAzOc6fCUWK5AISVj7jiopRPDZY/vg23qtDBIMs
	LBUiSXMBeIIuiqr1jqNYwnoo=
X-Received: by 2002:a17:902:d490:b0:24e:13f6:23e with SMTP id d9443c01a7336-2516d52d43fmr148372335ad.8.1757463079802;
        Tue, 09 Sep 2025 17:11:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM6XHIQCW29yMyzTDh4Y1gyHfVNYY+raVtASU/ynhT5cDb+vK6J9J7gdFDyy+k6kWU/N8gtA==
X-Received: by 2002:a17:902:d490:b0:24e:13f6:23e with SMTP id d9443c01a7336-2516d52d43fmr148372075ad.8.1757463079246;
        Tue, 09 Sep 2025 17:11:19 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dab6bb655sm1285672a91.10.2025.09.09.17.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 17:11:18 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Tue, 09 Sep 2025 17:11:04 -0700
Subject: [PATCH v10 02/11] firmware: qcom: scm: add support for object
 invocation
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-2-20b17855ef31@oss.qualcomm.com>
References: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-0-20b17855ef31@oss.qualcomm.com>
In-Reply-To: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-0-20b17855ef31@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX37lFRRqx+Z/A
 uTpV1CpnxX3W3+GYGl1iwHzg6ihmoiZyK4oj8vUB1GK10TuhvuF1VAFHDMISZ9P+xNMXbaJX3n3
 Kgc8Vx7i3bAGkgh4Z/097nROdU7Guc5bvti2FRKwKdVPnV2swvGKtsdv/EY+QinXdp7OMjr82wy
 crWurSn7A5GizZ4/Vcwheo/1HyVUClAYJLhxzS+sV1/jgExJgaF+i50P0xXENLjBRU2Y0LZC/qW
 dtgW9D/KTSbJjlSL2nPpT73p3TAsOKJOGrmmI6450MqEym4ZFonSMolPVRhaD7jgTHYv0M8KQ1T
 SyJ+YIR0YVLI2O0if+FteoyyMlUmLMRgBr51NSjAe7RWM223n6bpyqJBBU+gYYrik9GcXSNnMvI
 NiroVppx
X-Proofpoint-ORIG-GUID: ynrtoMBEW0vYQ5MguN26tKmksIjblLr8
X-Proofpoint-GUID: ynrtoMBEW0vYQ5MguN26tKmksIjblLr8
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c0c229 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=dBYAKgxw8cyf2mnx-aAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

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
 drivers/firmware/qcom/qcom_scm.c       | 119 +++++++++++++++++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.h       |   7 ++
 include/linux/firmware/qcom/qcom_scm.h |   6 ++
 3 files changed, 132 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index edeae6cdcf31..948f20125c8c 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2094,6 +2094,122 @@ static int qcom_scm_qseecom_init(struct qcom_scm *scm)
 
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
+	if (response_type)
+		*response_type = res.result[0];
+
+	if (result)
+		*result = res.result[1];
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
+	if (response_type)
+		*response_type = res.result[0];
+
+	if (result)
+		*result = res.result[1];
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
+static void qcom_scm_qtee_init(struct qcom_scm *scm)
+{
+	struct platform_device *qtee_dev;
+	u64 result, response_type;
+	int ret;
+
+	/*
+	 * Probe for smcinvoke support. This will fail due to invalid buffers,
+	 * but first, it checks whether the call is supported in QTEE syscall
+	 * handler. If it is not supported, -EIO is returned.
+	 */
+	ret = qcom_scm_qtee_invoke_smc(0, 0, 0, 0, &result, &response_type);
+	if (ret == -EIO)
+		return;
+
+	/* Setup QTEE interface device. */
+	qtee_dev = platform_device_register_data(scm->dev, "qcomtee",
+						 PLATFORM_DEVID_NONE, NULL, 0);
+	if (IS_ERR(qtee_dev))
+		return;
+
+	devm_add_action_or_reset(scm->dev, qcom_scm_qtee_free, qtee_dev);
+}
+
 /**
  * qcom_scm_is_available() - Checks if SCM is available
  */
@@ -2326,6 +2442,9 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	ret = qcom_scm_qseecom_init(scm);
 	WARN(ret < 0, "failed to initialize qseecom: %d\n", ret);
 
+	/* Initialize the QTEE object interface. */
+	qcom_scm_qtee_init(scm);
+
 	return 0;
 }
 
diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
index 0e8dd838099e..a56c8212cc0c 100644
--- a/drivers/firmware/qcom/qcom_scm.h
+++ b/drivers/firmware/qcom/qcom_scm.h
@@ -156,6 +156,13 @@ int qcom_scm_shm_bridge_enable(struct device *scm_dev);
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
index 0f667bf1d4d9..a55ca771286b 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -175,4 +175,10 @@ static inline int qcom_scm_qseecom_app_send(u32 app_id,
 
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

