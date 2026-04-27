Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FFB3BC693
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294008; cv=none; b=u7Omgp1P1BXoajxGCkXJi8bdOueAZTs1foriUEdGb/1t6/di3566gpMCEYIXTuBxy1Czz1V2Ebfkv/AiPxv7i/DuNDLZKl/r2QcDm9LnzhWTdo5xxBGWpkt0RGEtdeyO7ZwJw2Fj8X+bza/g9zJ4fph+aSSjC/HcuyOK6ysx7k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294008; c=relaxed/simple;
	bh=U/xIWfIVyxF2mQ02rx0FKseSqm13qZ1XiNmxrWwriB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WTFj7ML1z7q+UFjwHE3ijD7Ng1tKHuNLZI7YNbZX03nJk5S4ty4vcITDGS6sQXz2zLsgqCsQJ3DCrPE6pDkTUM5LFh4oplTFY1myyuc0e+y3yZ6HehXhFYd3orz0oBppPsTAlkr2wFD3FkjrwM4nu9z3mrmqGCxxmn8Us/pI2LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X1uPdLIG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bzkQREdo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X1uPdLIG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bzkQREdo"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8TEir665693
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S4kiIupbbdzP1AaB54zj5uEJPC21c2MwWBaLlQ5wgiU=; b=X1uPdLIGlNZRxzwR
	/7qKi6EbNQ10JMyLzWgqarhhPJB6jpuCwCq6dUInbebyfQxxVR45i9Zh+6WnaWe8
	buVESTnNACxCrhJ360/QEVLLoCAQiNObjtvn95RAVJNB/JHQD01D6Svg4QJGkjSn
	zmdg0WVGe9BtQDbRIWE8W4QZ2uGof6Gmmkj9jRoxeH5JV8EKYyrlLneRvBB6Yenv
	na8hoh2eAzO5nPjBOQrOU43sgWVC8/KZO3sKviNMv/EsSV0Ajz3nlsptD91M5Yad
	3NOsazrLiaEWOPeXnVwGaKQAC5PayTXPpfpDnqOzfJwENY+afWbm0MfDIthQ5FJS
	+J1SUA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt30n1d2m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:46 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-94d6c5433a0so12466673241.1
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 05:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777293999; x=1777898799; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S4kiIupbbdzP1AaB54zj5uEJPC21c2MwWBaLlQ5wgiU=;
        b=bzkQREdohcoh3eE6JVy9aJV+4+0Ls6pyw+ExBe/rypz2J3G8wg4cnQZNJkHWwhhS7+
         s70zZVIBI7sWy+/AzXcQOimWFwBQmTjNFy9UxUrlOvwy0dMfBKPmolOBfUkdNIBTDZ26
         4CIOu8ieNRyAyqTaqAxFjrzCRxZsGPd8nQGACy5TZ8F4G+AMc6L97G/4IqxTH8IqWxmc
         7FjKjetZh/8BdG4P3PHg95rHHSJPNCN6DUVmhX+kBcMrL5leQ7R+Nluu2XiBhE9gN21k
         iLSKEx3uttx1glvRdlbrMbmzMvWGcCvIRNzdY/+8oYv7GF71xK193CNV7yBRJ83FKRg6
         tSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777293999; x=1777898799;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S4kiIupbbdzP1AaB54zj5uEJPC21c2MwWBaLlQ5wgiU=;
        b=fjJRqGZRwAdJd5yGEjc+7lNQT9w5Ny0f+h3xRDtapWS+60nY/hKGzYOOBsoEDSTPgE
         FBuvV47Thn5RJwdq0QetcTUEvCZyKq4xtgxd0Yqlr/QzXlBMS2E5132/Oyy3BZ5iRVh9
         Xn9dTqINhwlCpSLT7nRLhIwH91BADPxFNlS1kmNXYvAb/mnjkmAsXbID6E6hmnrKG45I
         PQ3pj+lSs0bl1kUIqjP3JD/wPxZwRZ/+V0Wsio6aql+54OU8ZoXlG1sG/Ncm48tRppcg
         jQ7daf1kdWL7xNyH/IdjxS4TLj0RsP+24F/6yewuD2XuU43nlysVbd3ZXLAXBNv1ZVqX
         gK0Q==
X-Forwarded-Encrypted: i=1; AFNElJ++bEzOMULoKmkwwUe6RRfc4GmXKsWcU71bABngyVNefkFnvUNv37viMau5/9bJD7S4FkIKf8Z5tAFPcs9+tN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG8qr6UBkmQUHEaELEH1Xn/2sH82BZNWJcfbOzF9COvF0fTjlm
	9RWLJxRjCuRNQ3ChQuXh90PqOfL1xB6XYLuMh+ABrG3D1IFLO//kKjZ89yg77mWTPRDAyxXY58h
	MOYQ0+zoR9aF9kvGxPlF+VsUWEU/1AOMZvNxCgJ0rAeOfovPFjNsONnUAN3cdV66u1HxPfes=
X-Gm-Gg: AeBDievXawM2ABE50XW1/gdvaoiSAbzYDfBsb8ZQ7EVX9LXHlKxnmKzNxKeAZ4meMVr
	kbdG6xVQD0ZDBT4eJ0QOrVRt3vOAPdQPYjBblENHMq7KHAI9xk2zfCkO+zxiPVzYy9NPsgVJpNv
	QNgYQcbwuWEicjRAqtFGdDG1c+7sc0dNlNFsdsgSBiC/eGTCAQaEbI6K0p0oRhr3DH695NcxO9t
	Z0LWfTCcbBAUxvQHkPXfcVCdCk3BECb82/VY4otpn8h+mprcRAzV3rnBSbFxTAK5Qql3Yp3jrhz
	47DTsrVD+pMsRt3HJ4AARCfUsQxBkq5Sbrg3PkXAR5fcVIf0EiprVhUVftEk2iqKYgd2T/+tgdG
	Dxyx9Kkvsd9jzlPS+RPyPgfTrGRWF0lCP6vw6JQoNyBdC+CRNxFnzxhrJ0auKzFZhjdNylGaatQ
	byFk0IuRdzRNzB93aZk8BPdy34fqU=
X-Received: by 2002:a05:6102:4e:b0:617:9372:dd24 with SMTP id ada2fe7eead31-6179372e22amr15468845137.20.1777293999098;
        Mon, 27 Apr 2026 05:46:39 -0700 (PDT)
X-Received: by 2002:a05:6102:4e:b0:617:9372:dd24 with SMTP id ada2fe7eead31-6179372e22amr15468817137.20.1777293998705;
        Mon, 27 Apr 2026 05:46:38 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba454d1bd19sm1091496866b.37.2026.04.27.05.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:46:37 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 14:43:29 +0200
Subject: [PATCH v2 02/14] media: qcom: camss: Add PM clock support and
 integrate with runtime PM
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-camss-isp-ope-v2-2-f430e7485009@oss.qualcomm.com>
References: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
In-Reply-To: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        kieran.bingham@ideasonboard.com
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEzNSBTYWx0ZWRfX34QsxbQ7yBTQ
 mrdbGe28TsnXx8hY7pv/ae4q73xeAEhomVtnmyE/40h+D8flT7BGoDf6RUVpQAEnFJe/KNqssiS
 n0nSEBc+QbZ2ra2fIIYpBZeyIc2iqtH/BghodGKkudifWDfxjAK8M+8glyQ100BcBT3jTkWp3ez
 v684BJmd9aXiWdI96kcdIsL5LOd5ZLezrq3/KnJWBTU7SRO5kCXtRzLWjaIBMhj297EBbefdvsQ
 okWm5foLCLtC6RLl78iejLtGT6pvgRdmlLGYWygcUoPRHoAM/6ilEiYInC1Imqsl9PEoPSV8bDM
 lC3R/TVMiVuPAFbFLyti/iUwear0c8ObynaOyw6Fs9O00hqC87Jn18kfXb5EcG4r0x7VehhaO56
 hUvC9jwN7JuM8IGRDvHoLuyHqa7h+CgI7wVJpBpDIaDcr8h8FkjiUW2NwrGuNkU/BXH1YWKJ2x8
 Q5N5yaWEOVvfVjRgjIQ==
X-Proofpoint-GUID: -wBUGaWuO4opECTGQSo3N63Se6Gk9gqV
X-Authority-Analysis: v=2.4 cv=efANubEH c=1 sm=1 tr=0 ts=69ef5ab6 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=yohlUIewGNSudplHeboA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: -wBUGaWuO4opECTGQSo3N63Se6Gk9gqV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270135

Add optional PM clock support to the CAMSS driver using the PM clock
framework. This allows CAMSS clocks to be registered once and
automatically managed during runtime suspend and resume.

This is especially useful for global CAMSS clocks that are shared across
multiple CAMSS subnodes. Now that CAMSS is modeled as a simple-bus,
these clocks are automatically enabled whenever a child node becomes
active.

This avoids the need for each subdevice to reference and manage the
shared clocks individually. A typical example is the set of clocks in
the top_group, which may be used by CSID, PHY, CCI, OPE, and other
CAMSS blocks.

Introduce a small PM clock descriptor table in the CAMSS resources
structure to describe clocks and their optional rates. Initialize
these clocks at probe time and delegate clock ownership to the PM
core.

Hook PM clock handling into the runtime PM callbacks to ensure clocks
are properly suspended and resumed alongside power domains and ICC
paths.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/media/platform/qcom/camss/camss.c | 54 ++++++++++++++++++++++++++++++-
 drivers/media/platform/qcom/camss/camss.h |  6 ++++
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 8f2b1d3cd9f289895aa439443d2a18bb036fccde..ca68ad7fc9ff30eae23d3baf34cf1ca642acf9d7 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -19,6 +19,7 @@
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_clock.h>
 #include <linux/slab.h>
 #include <linux/videodev2.h>
 
@@ -4593,6 +4594,49 @@ static void camss_genpd_cleanup(struct camss *camss)
 	dev_pm_domain_detach(camss->genpd, true);
 }
 
+static int camss_init_pm_clks(struct camss *camss)
+{
+	struct device *dev = camss->dev;
+	unsigned int i;
+	int ret;
+
+	if (!camss->res->pm_clks[0].name)
+		return 0;
+
+	ret = devm_pm_clk_create(dev);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < CAMSS_RES_MAX && camss->res->pm_clks[i].name; i++) {
+		const struct camss_pm_clk *entry = &camss->res->pm_clks[i];
+		struct clk *clk;
+
+		clk = clk_get(dev, entry->name);
+		if (IS_ERR(clk)) {
+			dev_warn(dev, "failed to get pm_clk %s: %pe\n",
+				 entry->name, clk);
+			continue;
+		}
+
+		if (entry->rate) {
+			ret = clk_set_rate(clk, entry->rate);
+			if (ret)
+				dev_warn(dev, "failed to set rate for pm_clk %s: %d\n",
+					 entry->name, ret);
+		}
+
+		/* PM takes ownership of the clock, no explicit clk_put() is required. */
+		ret = pm_clk_add_clk(dev, clk);
+		if (ret) {
+			dev_warn(dev, "failed to add pm_clk %s: %d\n",
+				 entry->name, ret);
+			clk_put(clk);
+		}
+	}
+
+	return 0;
+}
+
 /*
  * camss_probe - Probe CAMSS platform device
  * @pdev: Pointer to CAMSS platform device
@@ -4677,6 +4721,10 @@ static int camss_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
+	ret = camss_init_pm_clks(camss);
+	if (ret)
+		goto err_v4l2_device_unregister;
+
 	ret = camss_of_parse_ports(camss);
 	if (ret < 0)
 		goto err_v4l2_device_unregister;
@@ -4984,7 +5032,7 @@ static int __maybe_unused camss_runtime_suspend(struct device *dev)
 			return ret;
 	}
 
-	return 0;
+	return pm_clk_suspend(dev);
 }
 
 static int __maybe_unused camss_runtime_resume(struct device *dev)
@@ -4994,6 +5042,10 @@ static int __maybe_unused camss_runtime_resume(struct device *dev)
 	int i;
 	int ret;
 
+	ret = pm_clk_resume(dev);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < camss->res->icc_path_num; i++) {
 		ret = icc_set_bw(camss->icc_path[i],
 				 icc_res[i].icc_bw_tbl.avg,
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index 9d9a62640e25dce0e8d45af9df01bbfd64b9bb4b..bd5e572f0a0a7daa1668831b7d2fc60e0498200d 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -100,9 +100,15 @@ enum icc_count {
 	ICC_SM8250_COUNT = 4,
 };
 
+struct camss_pm_clk {
+	const char *name;
+	unsigned long rate;	/* 0 = do not set rate */
+};
+
 struct camss_resources {
 	enum camss_version version;
 	const char *pd_name;
+	struct camss_pm_clk pm_clks[CAMSS_RES_MAX];
 	const struct camss_subdev_resources *csiphy_res;
 	const struct camss_subdev_resources *csid_res;
 	const struct camss_subdev_resources *ispif_res;

-- 
2.34.1

