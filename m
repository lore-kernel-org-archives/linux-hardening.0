Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6903B312834
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294001; cv=none; b=JO3OGjkils+7O9fwDunzevfgnXib8FobDVITjGUG4cXhizzUg1GIsV9NnaQrzB4B4P+YdsnP3qrMPt11BNeKPdX5YTdYr4iu5aPbGkeA6XPPF+qdNZc9BB1XFNb4iUTKM2yUNGDC3DA7IdDohL3+lHHZ9iZnOu60qRD/FKAAwMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294001; c=relaxed/simple;
	bh=8W5y78VKUavviXikxj7dAYRekuTy1qq9Xl81Z8IQtNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rbEStpR+h73DPYsWAMLJ+lgXnyufl+cfD3N1YG84SHZTSRZRPVcrzgYzznI1OaQPXyPTxB+J3uleMQNV0nhlD4A+INqn8Cj4XIMKWRq6EUjl6yloHpv24uv4Ybsw/cvt3QmZZGSuiPNt9RuyFktFnD1WY6Molfzc9tXX50PD3HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dOvuZIMR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G+6r4IgR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dOvuZIMR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G+6r4IgR"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8TGE93682620
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lCJ9j9cXMZuO871EpV/2lp8v7oOXkTCu0ysZH6cE8Us=; b=dOvuZIMRDKj2fsPO
	rey3TLa65b68eWZrdBiA3kmksbE2ZUzz7/xMoOBH/YtCghhCPQyHO+GJsA7ektCr
	TJpgi4cTerxyjmPDs5gtz3LsNSgN6EMbX3+vKB9xCEB9d8Kd69g9G03iCkdVJuo8
	K9I3LhBxl2hp0GRyUEc8akNzqzaaCtfN1iV90PS9QfdMoh0SZ3bCGQdHvDJNDFBC
	z3kzrOz9yONT0JW95F2awgIaZDHATPlmgSmmH1S7Z6u7dIfBBS4RM9ZKetlCVCuv
	+Voa0ibEC2Ky3SvcxxyN8FjHVR5Hx7DBrcGyqzYy58pg7SwaPGMnJNAX58VcDlxY
	TUA3Dw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnmr6430-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:38 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-953e8999d8fso15272474241.0
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 05:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777293997; x=1777898797; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCJ9j9cXMZuO871EpV/2lp8v7oOXkTCu0ysZH6cE8Us=;
        b=G+6r4IgROX4alcWPUNrzlQ+vIlheTjWOTFZ0sDtKeas/mRDwZ0VHuBC531QcVbn/zn
         oIQokG6VerEAvYVGdo0VFZMzWOvAogfKnSr+c6ZhhEXOjNFF+jUqqHO4LPefiC2yH2BJ
         nVYopGf1zuBDvioQlipsX4loYqw/k+CLFKCwnhOa4YcyURqrJGkTGx/DDpHnsMcjZkN5
         54AJN6HYH8hR6KO4OIXuxYCafFHwxNp11cncMHx1Ib3CO4OtzJ2K+NwPT8LOY8f7oaUm
         18C997GPVkqalfuSZyOjigLX0LN6dg5SKC2OOTNwKww5Ot5pm2s+cMWtTmn26s9OFE+o
         nhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777293997; x=1777898797;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lCJ9j9cXMZuO871EpV/2lp8v7oOXkTCu0ysZH6cE8Us=;
        b=XY4cuYGGc7rqHyzrjEuRcSkk8w4nK7DqdMVe5N1+awnfKq1i9h3DR5pnAofKzSqJN8
         b5Mw805PteW5TlfkH981G4NYLq2kmIV/QTaduSGFyH4lgceu09UBCTNh6Avc2c34ytBD
         kIR0liSI7GuxQ3oH5+sdfrSRWTr0MkwCPyV096H+v187tGykQvNxfnMY1HuXCnev8uYH
         86/VBbXxKApMJ8d511yhG6BXzXcnatUucZF/pgGsVSkPKjAfF0u228CnPdPIrn4zYOym
         WvRthIDSOIYhdUW2P02aI9UWmZmXApVbzhKzmcXmECjL3YDKozFftFH5RoFM2KF4fbvF
         2O+A==
X-Forwarded-Encrypted: i=1; AFNElJ+tJ3OoeP25HfzClYxDHntrmQ2GWJ+OZM1esCQWijr4qbKiJTy86raMANVG39bpyXf15/wEGeWXBJvzcsC5pXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi9xNFsF/Llcdhb/ovFWDjP1E3mdk+oA9uz3+YZPtv3qPi9bcg
	y1ILTXdaz9EheX8FQhJAcpSeSc5K6PXZVZDoFE6dV82E2u3ufvEs0N0CZ3aWS+FSMufd8V/zztn
	IxOnjCgyFWpe9elnppczDIA7cZXhfDEYjKceamtldNmm8EfdpotGGt0bBh8WTdveDmkY1H5Q=
X-Gm-Gg: AeBDieunHkiNZX3Rgq1pkz+HDqyEHxNh15h8A1+YLftHHriJiaXaLXviI66MUuWLNSC
	Pgv98RBRmdUsBPpcgUChpIKs9XXa3YTLSaDyhmHepcTyDZhIy7XgjGI/flSipZg6Wdk4fBFa+LF
	Zg/k8etL0g1ohbvvx0x35F6RGteM0bBdhlgeULZk7aOburih1M4uZGvCtNEKCHaKQa7P3cr5hfJ
	o7g0g3Nw68pNy+iPiRpiB52qmjSo/aJq/nfx1uzNuE2VY3XbESpsToJfugG05OEzCD3vjtWLBOs
	OLRTK/36gmxnoZOJODLi0p0ewsNJr4kA4A7Qo1wvLAbja2fypSCynkFiGA/b6AeLmhdjGKmZI5/
	BFCp9UJHDoiOngOXzmbiWbJC+KSTCWl3yP19uDG5U4eO1xmGb5IJ9awiBkPIoNYc8byTVUy6I0r
	D41D+wM9uDPwKTru2VD3nJSQ+Rv8Y=
X-Received: by 2002:a05:6102:2d09:b0:605:17b8:16dc with SMTP id ada2fe7eead31-616f6ef7d62mr22668412137.20.1777293997348;
        Mon, 27 Apr 2026 05:46:37 -0700 (PDT)
X-Received: by 2002:a05:6102:2d09:b0:605:17b8:16dc with SMTP id ada2fe7eead31-616f6ef7d62mr22668384137.20.1777293996955;
        Mon, 27 Apr 2026 05:46:36 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba454d1bd19sm1091496866b.37.2026.04.27.05.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:46:36 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 14:43:28 +0200
Subject: [PATCH v2 01/14] media: qcom: camss: Add support to populate
 sub-devices
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-camss-isp-ope-v2-1-f430e7485009@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=aqCCzyZV c=1 sm=1 tr=0 ts=69ef5aae cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=5bRy6lfvdnCUHtv4pvsA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: uUFEQBS4ZRzN33JTtINgZEbWRqRnL7Sn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEzMyBTYWx0ZWRfX/3VRkOzYPNwS
 fc1JfZ5Hkjx3l8dOlVLDMzN3LL9eAAAgQLqBdhL6foPigkgIg4KJ4FaZT6G1bfPtfaPoxW39Sdp
 1//T5eQ91BwEBaIFzYN9EUefy/AIxanx1HCGPwCymdMM2hDr+v9+RuF+VTo/T8GL3zC2eb0d/Mg
 x5VaH4p9TRrYdI1NwI5slRADaVMDPKlJrc5UySklkTscgpNBOYiCRt/+5BMXRgKF2QgFEO7wEzQ
 +7SX+Mw9gF8ki0IfB33uoYM4YJn82T7Hv3Lhi3nGMXM4lJ0+zVfJHsT7vQhspMVEZlNWSrHzog6
 TiNojhVPlO6dnXCZYtYUY79L8l2ToqksHX5s2OEtbpTCmt0OrtfOTh5QYOVg6LZdRbtdX3XHt6e
 NWZDTGBhN1CV750/ZS5KLOU0PDde+xf1njXJbmdvDhrj9y0vP4RNx2cbJaLlB8LAbHKRT9KiaZ0
 cDHBmbFcAFI2eXOSeDA==
X-Proofpoint-ORIG-GUID: uUFEQBS4ZRzN33JTtINgZEbWRqRnL7Sn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270133

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Use devm_of_platform_populate() to populate subs in the tree.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/media/platform/qcom/camss/camss.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 36c601c595053ddad8d327b1416d7ff587920174..8f2b1d3cd9f289895aa439443d2a18bb036fccde 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_graph.h>
+#include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_domain.h>
 #include <linux/slab.h>
@@ -4608,6 +4609,8 @@ static int camss_probe(struct platform_device *pdev)
 	if (!camss)
 		return -ENOMEM;
 
+	devm_of_platform_populate(dev);
+
 	camss->res = of_device_get_match_data(dev);
 
 	atomic_set(&camss->ref_count, 0);

-- 
2.34.1

