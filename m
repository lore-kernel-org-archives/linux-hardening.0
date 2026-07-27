Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42645382F08
	for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162217; cv=none; b=dl23mubKkKQ2RignJCihzEEGg0OpQ7edhek+j0JGCACogmO05VirvC60wKvcuV4l/jrubP5aFNJye/WlrI0Y+wyUFRjvhcWZyIbrbptB9bvxOce+vYb37DzR/tsPKq6SD+xivN5ji5GFWwJ7ksvfBtq1v2xP9tIdlcIcsTrxD6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162217; c=relaxed/simple;
	bh=lY2yoHcldcA+3NaI8lXXUOj0RQzCzCCOyPwbI6I3/FA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IihWgmU6RMw2Yfk/pMmzroR9ht0LPGB/JwyH9vS73JiTQX6zrudn6ajlFY+CM8PmvG2HSidzkW/oAbhZPTjmfmJeDZIMTTzY8ZaxvTh4Mx2OFo7dTUKw9NIF9rokhF6PoAEBoyWqKFDAZcoDUN/sZPh+wNyTaf6Q8H0yaabD44w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KRKk0Ali; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K5LD5oJV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KRKk0Ali";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K5LD5oJV"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlSBi4065457
	for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 14:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LqMjPqmNKTABTQyu4/oXXNeGMN13hbmHy5tUZLQLrYc=; b=KRKk0Ali4VxzfNdy
	mSi9EKlqwIze2xfh71SEbCde5KOZvAdpu82P6btTVjzuEYhLcz7j6fVSZYlFQEw0
	T6D3p9BhkY3HrJo2aChnjXMOt/Q9pMUCdigMWc/P3tO65zXpV5s6EX/n18T/eDAU
	lMenKyJWZIv7CDuWKs9BcaSPRCWue47QybrYE34b/siNX9SHhLpf3yE3bMUokhvm
	8Azzko5St2gXl7mEIbU6aqcz4XcCq4ZNvol6C8rxnKYTDg11AiwvoHirk7h7K7z7
	XvnhzLWTSl1wPW22HzfADoyDSsfl1YDVcqNRUVXcgmcqtH+4viL2q0yXQdCQn7zq
	ydHi1w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fngysuv26-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 14:23:34 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e667368f0so4539771a91.2
        for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 07:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785162213; x=1785767013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LqMjPqmNKTABTQyu4/oXXNeGMN13hbmHy5tUZLQLrYc=;
        b=K5LD5oJVQiec6nHlyaUCCrU9+yyqCtLVQbPHHFpKj+dn1eFxRsVrqFDDlWLXlsvQrg
         bqxiY/lWCoaXYP42So4sb3NuprcRb0mzJioLWxZL9kiszhgec3fiNc9T3bl006AZWsMF
         GnHtkEGzsTEsvBCj8uELpm4pFidulboBqCYmyWEW8iQ96JasyTi+t3DN7C56/eZ8EBpZ
         nHURhS5UgR77JMYC8YL7bf3JKf7TgYCc8Fe0GHuat3huvk3tos0v2VzpdGoz+PM6zRHi
         vIdXZgy6xnYkf9tBS3hT+cGA2jV3umTKyvlx70Mswoey14ppneQrgvyleIeusDrkZmrC
         bMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785162213; x=1785767013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LqMjPqmNKTABTQyu4/oXXNeGMN13hbmHy5tUZLQLrYc=;
        b=tA83Lg1oUe+D0/kgXEhwfA8N/a5Wgip1RTKlSYczp+68pcMJ7Qc0XSey5IysfEMDvq
         4d4PFYaAroIAJnZ1z5R5X/IsDiyYh9ftgg5xMJeKOIQNXW3ysT0rN5iuEYhkxN1Ak+Q+
         bouAsRHgTfLCqz6Z2mB6bvBx+6GpuLqmvrcs+kgGk5d5Tk0wdeIya0j+IxXjz2A7X8t+
         D5ZooiIFAsBjpps/kA0lV5yxIo7i/7Eu3UASpgWADaCG0XFQ/sG/YtTs+2aAKTJ40xaF
         weZ7C/c5vTAHkdJ4dDL9DlWGs/sYSdKAWyhG3vml4jYg1JeOEc5n9Z19NkUjXznXi519
         IjTw==
X-Forwarded-Encrypted: i=1; AHgh+RqAO4V6J6stCxvrsHJH2o68OGQF4e6Thv5QhzrvK6byZSLhmpxgkuW+w/VV3mYStA+gSIsT6Fb6N1KNVN/eoIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+xDQuo8xSP0N3pJmycNoTPRhcnlDWizgk3L7C7aMJ5bssHCtg
	2rzcyDPMcgnnKw4Us7o5FqWrbjIObipQxhSAATMKci2SZoGPQiCBKP6N80QePadNkS7sodSkY4q
	WDW0zvjSsHzXz7ifCuOwkUPFPtHZOuMuccvjcBykttZhjUpPCFBox0l2JyjSvdF94DM0b9yk=
X-Gm-Gg: AR+sD13PDafcmEYggqyXXtjGWemrytsbaqKhtTr2/bqf/ZzcR554/QGsB5pSoaRNmbH
	TDI7azFDbeAjL/5NKDT6jqSbMhqDLf7CHaKdzwp8vQUu0iu9UZzl5XyQpILNENtzdT+Kh4YmGWs
	sXUga+XoA+EKByR/38W8g69MxOqXJrFyH6PXfX/fdIUx12gTVEQTkdG0t74lgKOgzdHKMPB2ayl
	GW2NfZA9uTVaVrXTT/yBKFydD5fhvTD7BGpgt/19hu32Yd07V5A6tuiCR1X+22q2mQg1JTML5ry
	kt+87H0ufTTs+VsG4yYvo6fUMBULF/MVvlTeNGAd/QmrApY9ZWt3STEKqm/KGT/DI3xgtZEso27
	dbECNX7BPn9RGATAKCKtYXQvZIakbbQ==
X-Received: by 2002:a17:902:d48b:b0:2ca:d151:383a with SMTP id d9443c01a7336-2cfde7adcaemr86494195ad.20.1785162213490;
        Mon, 27 Jul 2026 07:23:33 -0700 (PDT)
X-Received: by 2002:a17:902:d48b:b0:2ca:d151:383a with SMTP id d9443c01a7336-2cfde7adcaemr86493745ad.20.1785162212992;
        Mon, 27 Jul 2026 07:23:32 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde81d7f5sm36608755ad.83.2026.07.27.07.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:23:32 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 19:52:21 +0530
Subject: [PATCH v6 4/9] remoteproc: qcom_q6v5_pas: enable QMI TMD cooling
 support
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-b4-qmi-tmd-v6-4-973cd3a226af@oss.qualcomm.com>
References: <20260727-b4-qmi-tmd-v6-0-973cd3a226af@oss.qualcomm.com>
In-Reply-To: <20260727-b4-qmi-tmd-v6-0-973cd3a226af@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785162177; l=3908;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=lY2yoHcldcA+3NaI8lXXUOj0RQzCzCCOyPwbI6I3/FA=;
 b=NeDCgOWKfvQfPbiBGlv8v4h+J0TA3CDp3WSY2FOn/Sipv4ba2znp8p0drrEA8UF7va2mTdFIb
 bjSzdydwb0jD6kju7rc+MVH+ZpDlJQDGgz6w4sxZHk1HEWIZpzwaPdW
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX4IMYr5B77bqs
 wO317cQDGcMKnISi42Y/mGWxP3Z+NRnoJplskutI7sPu6RPEaZedglZTfsTniJSX0IC7MI2Usfe
 /f3QAdoNNrnxeYvNDYoxe/x1Mribh0J0NA+WgQfrYEcMShq6amcURZW8Was4OqYcvU7mh1k5fyY
 hslzphZni4oTUu+Vb79GZla5h84YN4wUCPu04JUSRJwj1jXymmX3gUpN1yvbkTDe+dkjIcsjSDG
 jFLpXlzx/XZ7TDO/wT78yunaXoW4uI1s0ubpOmv9826Ez0YPQ7kabKl0lCSHR/gSXJvb/Jx+g/2
 WPmc9CTIUNLoHKa+LhnWS+04dkhYjRlkvGSI5tTt09DrRo4GLqydTxb0i56Gy6gmupX99qdtr4S
 B8+OXNZyoCu6zJe4v6UjPNTZADHdmTYIMqQuXhVKE+CXOzu+4c8hrdTEvYM4OdFtZ6vPjokZKpT
 eD4qSTH16grWTf0NRHw==
X-Proofpoint-GUID: JaAoP7DYHdP-0eHqO7uOMP2y93FoiITI
X-Authority-Analysis: v=2.4 cv=DNG/JSNb c=1 sm=1 tr=0 ts=6a6769e6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=j6jQExit_mXiN_RbaP8A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX+k1P+mRlcGnx
 pCP3Adw2zHReH3xlO4TSPKGE6HoE5vu/SlgQi7+3FmRTluVY5gSagG/e0LxNM1WZFpII5ckbGeC
 8Iazcp+O0LEmTSxmOxhQQAyVQOxBgXg=
X-Proofpoint-ORIG-GUID: JaAoP7DYHdP-0eHqO7uOMP2y93FoiITI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270136

Enable Thermal Mitigation Device (TMD) support for PAS-managed CDSP and
modem remote processors on platforms that expose the QMI TMD service.

This adds per-platform TMD configuration in qcom_q6v5_pas for:
- Hamoa (X1E80100) CDSP
- Kodiak CDSP and modem
- Lemans (SA8775P) CDSP
- Talos CDSP
- Monaco CDSP

For each remoteproc, the configured TMD QMI instance ID is used to bind to
the TMD service running on that subsystem (e.g. CDSP: 0x43, modem: 0x0).
The driver then uses the corresponding TMD endpoint names ("cdsp_sw",
"pa", "modem") for cooling-device registration.

QMI TMD identifies mitigation endpoints by name, while DT thermal bindings
reference cooling devices by id. This change provides the mapping
between DT cooling indices and QMI TMD names, allowing remoteproc nodes
with #cooling-cells to act as cooling devices in the thermal framework.

With this in place, thermal policies can request mitigation from CDSP and
modem subsystems via QMI under thermal pressure.

Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 07336a2d75f7..ab23c371601f 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -1061,6 +1061,15 @@ static void qcom_pas_remove(struct platform_device *pdev)
 	device_init_wakeup(pas->dev, false);
 }
 
+static const struct tmd_name cdsp_tmd_name[] = {
+	{ .name = "cdsp_sw", .id = QCOM_TMD_CDSP_SW },
+};
+
+static const struct tmd_name modem_tmd_name[] = {
+	{ .name = "pa", .id = QCOM_TMD_PA },
+	{ .name = "modem", .id = QCOM_TMD_MODEM },
+};
+
 static const struct qcom_pas_data adsp_resource_init = {
 	.crash_reason_smem = 423,
 	.firmware_name = "adsp.mdt",
@@ -1218,6 +1227,9 @@ static const struct qcom_pas_data sa8775p_cdsp0_resource = {
 	.ssr_name = "cdsp",
 	.sysmon_name = "cdsp",
 	.ssctl_id = 0x17,
+	.tmd_instance_id = 0x43,
+	.tmd_name = cdsp_tmd_name,
+	.num_tmd = ARRAY_SIZE(cdsp_tmd_name),
 };
 
 static const struct qcom_pas_data sa8775p_cdsp1_resource = {
@@ -1236,6 +1248,9 @@ static const struct qcom_pas_data sa8775p_cdsp1_resource = {
 	.ssr_name = "cdsp1",
 	.sysmon_name = "cdsp1",
 	.ssctl_id = 0x20,
+	.tmd_instance_id = 0x44,
+	.tmd_name = cdsp_tmd_name,
+	.num_tmd = ARRAY_SIZE(cdsp_tmd_name),
 };
 
 static const struct qcom_pas_data sdm845_cdsp_resource_init = {
@@ -1263,6 +1278,9 @@ static const struct qcom_pas_data sm6350_cdsp_resource = {
 	.ssr_name = "cdsp",
 	.sysmon_name = "cdsp",
 	.ssctl_id = 0x17,
+	.tmd_instance_id = 0x43,
+	.tmd_name = cdsp_tmd_name,
+	.num_tmd = ARRAY_SIZE(cdsp_tmd_name),
 };
 
 static const struct qcom_pas_data sm8150_cdsp_resource = {
@@ -1278,6 +1296,9 @@ static const struct qcom_pas_data sm8150_cdsp_resource = {
 	.ssr_name = "cdsp",
 	.sysmon_name = "cdsp",
 	.ssctl_id = 0x17,
+	.tmd_instance_id = 0x43,
+	.tmd_name = cdsp_tmd_name,
+	.num_tmd = ARRAY_SIZE(cdsp_tmd_name),
 };
 
 static const struct qcom_pas_data sm8250_cdsp_resource = {
@@ -1362,6 +1383,9 @@ static const struct qcom_pas_data x1e80100_cdsp_resource = {
 	.ssr_name = "cdsp",
 	.sysmon_name = "cdsp",
 	.ssctl_id = 0x17,
+	.tmd_instance_id = 0x43,
+	.tmd_name = cdsp_tmd_name,
+	.num_tmd = ARRAY_SIZE(cdsp_tmd_name),
 };
 
 static const struct qcom_pas_data sm8350_cdsp_resource = {
@@ -1430,6 +1454,9 @@ static const struct qcom_pas_data mpss_resource_init = {
 	.ssr_name = "mpss",
 	.sysmon_name = "modem",
 	.ssctl_id = 0x12,
+	.tmd_instance_id = 0x0,
+	.tmd_name = modem_tmd_name,
+	.num_tmd = ARRAY_SIZE(modem_tmd_name),
 };
 
 static const struct qcom_pas_data sc8180x_mpss_resource = {

-- 
2.34.1

