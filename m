Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20713ACA59;
	Thu, 20 Aug 2026 06:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787205708; cv=none; b=aI51brNyRmgtit1XAnqYAKQyxpDuX+vC8caQJ9iMpoC5xQRYWhZWCxZf2V8zuaNAK9+WjmN2RhR9woM4clmn7mkEED8wRYrobNq2WyypHVhf49u1jztbfT+7fW+6wDLAnfqv9YAXaFp/L9ov4bY8/RJK1HA0n7qTo6DWMVrhLOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787205708; c=relaxed/simple;
	bh=8uS5dsRPHfi7icvqcmgyhb3CNDYj77hQkpwH8ooc2yo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jKbDdW2A0M3N9auZVdKRgyLLwDFcNOhlxsgLDXZeJj4KuOkP5UQrGrP9wdeRJKAs6aw/7NAujHl6UAm/m3+FnnjhP+n+INYkum/izIDfwbSDxWC07cC/aH2cRZL5yt76ewTIXz0jAqCOUAwZCaYh/+1Mrj77V7FWTzgVSQS/Wx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qti.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lpTkDIuB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lpTkDIuB"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JL8S041354410;
	Thu, 20 Aug 2026 06:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VVQjbC9+fnH6Vyr1Zks+xvDk69G/N0rKNtI8rI2rI8A=; b=lpTkDIuBMxLSHxGQ
	xxQtqNBLoluswlZbAqJxAqTpsnVpo5I7a5i2NQ4FwmLUbiUQraekDicZISS59HGy
	2XxY8vQBNVfMVLTKdCyGxOxxpHj6FkkMvcXu7ea9iJrnj1/YM+wQUu26ndwjh2AJ
	svZuRtJB+2rSvc/TvypRitOBhXqvmJwPWcav1MW1uvKaoayeVBLqY7pNi/coo3UY
	cQD0a60brLjzpN8bY/MkBWnLZLBf7WNgoVN950hAlV13sE1ypdZN6P8Y3hgvqdTB
	Sc6KJkY0lTesR6yZLMgJ0gVMm5i+r4lOunZ1SCqXxh/kIshoHOrMy5I9NZF8XqPi
	4BRXng==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5es5bdk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 06:01:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTPS id 67K61hBv002831
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 06:01:43 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 19 Aug
 2026 23:01:39 -0700
From: Jaihind Yadav <jaihindy@qti.qualcomm.com>
To: <kees@kernel.org>
CC: <nathan@kernel.org>, <nsc@kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-modules@vger.kernel.org>,
        Jaihind Yadav <jaihindy@qti.qualcomm.com>
Subject: [PATCH v3] scripts/gcc-plugins: suppress recorded GCC switches for extmod builds
Date: Thu, 20 Aug 2026 11:31:16 +0530
Message-ID: <20260820060116.786173-1-jaihindy@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817185146.GC1249844@ax162>
References: <20260817185146.GC1249844@ax162>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: n2s15Jq5oFV4WnoqJlERk3BkmEGGKM4M
X-Proofpoint-GUID: n2s15Jq5oFV4WnoqJlERk3BkmEGGKM4M
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA0MiBTYWx0ZWRfX8ZbtTo307tc2
 gAhQoZu2fa5sWlT0TIfJa3xfy01cB7qgltZKIdx7OSbguvSV3Zad3CdVBmd1Bu1JBJqK9bdlvRi
 t2OfXpvdwWq11t+/zOg4/fZv+90r2h0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA0MiBTYWx0ZWRfXx5HwNLJSQir6
 ENZEGZNwwh8fAZwyqjXwXRcvzrqB/8bFoywgOupNQ+ZYM70J0WJ/i4q/UCcwsZyX7Ca2mJZqE8/
 9euaRA+rwrrTSUsltvG8AL+wXmnlpTg+0tn+TYGwhgivHCgGzjVvHTtQeIbvMLhs044J+ZyJcNI
 wG8+eh+qKsWT8NsLSQm/rMaOcvOAD2nHPCCrkKjlOAzTJqCc9n8u64pJq582ID7qdLYQVHexQN+
 oKUXQT1yo61l/K95z+5VMNzsHFfY+8HUfNhhyEBZ481lMdXM0sXV47EZEwDY1RVbgZaw0UBosVf
 CZk+JOOPf2cBeX0okjdT3jSJP9ujY7rRf+gucUg8UuZDfFIbwmQ/BcyF2LgeSMreM2j/PjNEs7y
 efD5j2QrqN0vUB1zn681Pw5uIOycdFYYC0GnM6oa2h0sWLLjxeP7xgcmf4BSHqAmjcMk0RLe35r
 bO8crs/uGqLRzhnw5BQ==
X-Authority-Analysis: v=2.4 cv=Oc+oyBTY c=1 sm=1 tr=0 ts=6a869848 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jsFOyA_XevxqPLBfZcQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200042

With GCC plugins enabled, external module builds can record
-fplugin=... paths in DWARF producer metadata via
-grecord-gcc-switches, leaking host/build specific paths and
triggering QA checks.

Handle this in scripts/Makefile.gcc-plugins for KBUILD_EXTMOD
builds by adding -gno-record-gcc-switches to plugin cflags.

This keeps plugin behavior unchanged while avoiding absolute
plugin path leakage in external module debug metadata.

Suggested-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/all/20260817185146.GC1249844@ax162/
Signed-off-by: Jaihind Yadav <jaihindy@qti.qualcomm.com>
---
 scripts/Makefile.gcc-plugins | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index b0e1423b09c2..9b9899580571 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -8,6 +8,10 @@ ifdef CONFIG_GCC_PLUGIN_LATENT_ENTROPY
 endif
 export DISABLE_LATENT_ENTROPY_PLUGIN
 
+# Disable recording GCC options in debug info when building external modules to
+# avoid leaking absolute host build paths
+gcc-plugin-cflags-$(if $(KBUILD_EXTMOD),y) += -gno-record-gcc-switches
+
 # All the plugin CFLAGS are collected here in case a build target needs to
 # filter them out of the KBUILD_CFLAGS.
 GCC_PLUGINS_CFLAGS := $(strip $(addprefix -fplugin=$(objtree)/scripts/gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y)) -DGCC_PLUGINS
-- 
2.43.0

