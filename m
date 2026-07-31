Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ECB41D10A
	for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 10:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494084; cv=none; b=ZD3EnZHygN9NcwjsCMRnx4rKYwNIBYQBH98KRuT0276pYA4PFbpnRxmobqpl/xaTgKXYM1azyBcZ89eyOR7NnLXeyxeQo8dmq2mQ4KlqxvsTr1xQcUPcdpPePkA+JyrCblFn6RQ2Mdcia0v4BmFJhhwh/jMAVpoXf8o/4smxINo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494084; c=relaxed/simple;
	bh=LjX2uu5uRns9aB9+huzFuwyv8G8eDp/UqYn/3VCYmRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BiwPd0Tyr9Ygr04onbYjJk5EbSXHon3t+95RHojRhvzFiMNlqEvO6vU+9jsxBZVeU1bJ6nDHxnkYd+xwPHHVz/CLeElQeH6hy6M2EIk5tZUleEXcTZjzer+FIXcBX73LEMlwjLeQMTaOkrtZaXUJf7cFioMiQaG+6I6pMuisGvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VpAZ9TyE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UycNZF4n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VpAZ9TyE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UycNZF4n"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VAC1X73512094
	for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 10:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pYF9h6alUVBD7tym5vNqQYIx2ehof1mwtVNRI9CjH2w=; b=VpAZ9TyEoc15/jBZ
	BcEWFlksd+tNz2xLa5zhh8EJLwlzJlClxyh22KrknxFZ2NGmervUkceyJQSlYXYl
	jwdhzgkZN+vPQ7smfn/hRKxtAfaj2qAN5dR1PFFe5B0YBsL/IQBE0VXAh0UBaFXe
	6e4iAAKnaRAngoPauGatFB5fzAOhF2e9727ns9t5MCRIKVFURNrGvPCovI5/zrgr
	OzJzUZ5xAc02HLTvHuPCPjmKUAH1SGcyyJkrFg1JyrOjqQPFI5ERy2nQDySffj0I
	FBQe4ZrHXP6pRrfWwTtHSI6oDJFM7qXhha2G9cYdA0TJfu0CrSK4CduOhtyCq4Yb
	6ys3gw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frsf2g4dr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 10:34:24 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d001671a54so17082185ad.2
        for <linux-hardening@vger.kernel.org>; Fri, 31 Jul 2026 03:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785494063; x=1786098863; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pYF9h6alUVBD7tym5vNqQYIx2ehof1mwtVNRI9CjH2w=;
        b=UycNZF4nGPTuyW9c8AYwlH7MUX6qqsT/Is04HTtItzqo10LhEAELxtTgV96SRR3NxB
         Le5Z5yntQvszxFJoDbzKlwkcTMt3yXWXGHJMyUW2m+HSJwjjq2hYbM7RZ9nEjcB3ZZbS
         rmunmWCdTBaOaajXtVcwgw0r+4f6ELGYbOufWr1VdmgbNRDhTmO9PbKn3glwM+n+uCUk
         HaT5EvB5a7FWIneU4Ev2xP/43HR5tsN0g5Be+h/NEPgIZ7jcFI185BWudA7ytKc17oo+
         918EMpKPNK+PRXY6lbZzC4BXRHWDLnNQI0SOaabGDW+y4+Jx7v2SrQgvHTa1WCj3DQuE
         CwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785494063; x=1786098863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pYF9h6alUVBD7tym5vNqQYIx2ehof1mwtVNRI9CjH2w=;
        b=as0XG8zGQTcKzcJ/3C4gt5IXZHRM4IzRCtuKCPet2CNZph7+d2bo3tA1YbzGBTAz9I
         7zqYGAITSGuHu72C61RKq22/tnf78U+wK/yVq1tUOXvdRjUQobHfpIRHsLE6UqU8AVxk
         aDB25SG2JeP3LGkq6eD8k0D3sbh5CTDlzZTezYq0n0xSvKlhBZaLwf/j9resgiMjk4Au
         SJq+4VcwMDc/G75Gsiejc9W/qWMLBdoH274TZK0kfbJmTjpOH5r5/Ie7tE5taKdZDqeU
         fWRAyPd9OdQ6P2d6BU65X7qc00CA62mP03hFiJkQs327THVIiZRHicOHT4EnW/48Q7Oo
         Ts4g==
X-Forwarded-Encrypted: i=1; AHgh+RrVBDhYUox92RVKhk99TmsjByozvQgxird5LHUPknBh6abq9wGi73oSVr5tjaKNjKiziRkurd+sELuRh6z3Sbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb6mAXdICQtVWNN2/5U+BRsRzl3sebQo2449LbzsP8hv+xx8Ij
	9CtNVQCU2g+g6CmlyWMe7cvy/y1p3rbdosuC+W1f3PkxsuVgAT6/PEWEYJSQ6p375i8aAJI5zyM
	tRHNtYsUMEj84HAglIDWtSZfqPh/QUGPN4MpTUTttd+6+KfDz2a+X4J4HrSm3mK+zEBUZbMw=
X-Gm-Gg: AR+sD11nwaBDLOZnyUPY8YbNuFjlG/bg2L6hjyGjg3LKsz8ereqlJ0xxoiPxjHFeG7N
	OhV86qMpmen/oI0ts3QMY3Nuu+XczbEP2eYOYVN4zHOnVgmmtE7uoy2gvRMFBYCC737YWouR9Oi
	CC1BPLawdF31eNm7ugyZUkIECAy/eM9U2FtmFkSWeryNaF36HsPPacxjAah3dUtHQbLoUNM8F7G
	bbB3UNkU7/37jac+5jOsZMKUUCpO4oZAt0U2X4iXda4l3OLtTdAnM5jal130cEPWD3lBVZ7sh8H
	FFis5tAEc6zKHYKq/OdC5DUMRpLpxMbLfwc6htRWgdxRqtE6PW3RqALqfChBDIOb7rRoiMA2s8k
	H6N/G2wa9ZKroqNpHgjBsoIDyf1pIpA==
X-Received: by 2002:a05:6a21:790:b0:3bf:49c8:f7b with SMTP id adf61e73a8af0-3c91b08f204mr1566997637.13.1785494063367;
        Fri, 31 Jul 2026 03:34:23 -0700 (PDT)
X-Received: by 2002:a05:6a21:790:b0:3bf:49c8:f7b with SMTP id adf61e73a8af0-3c91b08f204mr1566958637.13.1785494062924;
        Fri, 31 Jul 2026 03:34:22 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18e114sm8493680eec.28.2026.07.31.03.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:34:22 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 16:03:41 +0530
Subject: [PATCH v7 1/9] dt-bindings: remoteproc: qcom,pas: add
 #cooling-cells property
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-b4-qmi-tmd-v7-1-3befd44403d5@oss.qualcomm.com>
References: <20260731-b4-qmi-tmd-v7-0-3befd44403d5@oss.qualcomm.com>
In-Reply-To: <20260731-b4-qmi-tmd-v7-0-3befd44403d5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785494047; l=3338;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=LjX2uu5uRns9aB9+huzFuwyv8G8eDp/UqYn/3VCYmRY=;
 b=+Ty/Bcvly1jI+WWQz/dApbymnZLZER2rXS661XRs7pe3SHqPe/N0DFN3Z0fT9/uJVNWsaPp1W
 JJRfLpyXyJSDyCoaqmH+yLurQ5VxvNfbF8+46zkOH9FFdOLqDqrKLNM
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Authority-Analysis: v=2.4 cv=ev3vCIpX c=1 sm=1 tr=0 ts=6a6c7a30 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=T6nhelsJTOTiISQcNXMA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: lnrpwSfDatGlQhulwaqSwZk0XnJayGjQ
X-Proofpoint-ORIG-GUID: lnrpwSfDatGlQhulwaqSwZk0XnJayGjQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA3OSBTYWx0ZWRfX4ktcD4QRwJrk
 G4tRNOii4EZp54W64nWklmfEjwCikvU/5lcJ/gEbyv82ouvrF10cenwhSHOVbBB0koyOPRwHciu
 +feGXDVPcB1rZoLu6jOnOdrH/jXvunY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA3OSBTYWx0ZWRfX5jZBqQmIR7H+
 Jh918lhGfY8fcG0/6k9lEBdAElSCXTC1Jj3sziMBiMN6ceIZefHeoHgU3lBUXRHFBK/tfKLvo/v
 2vwsq7v4rVtklm2sCRS7K6H2MWUiglvHlAvZR6lnVF16ERj1ShKFnQLJWJAB2oOmk7Slty17qHG
 9wxq1d3Asz3NMVvV52cR8uv/pjXfQlxX+lttDahSm5uGrH+vUsZJD0ebuWTJtNeKrWUUSnsKf+k
 OpbsauPlQMBMFslundQcZ+iKvP+Jaq+tW92dPb7aJMtbBYfrm+cfX215lFOarybxsiw0ljs8cAP
 aqpVhkcHkvLoXKqg1g1sx7CEr7dqZyUDcHDuhvT4/r0Lo+N5g4WyoNpvtyqmSkR5KPiqWW8XEXb
 LYm+aTDRYTKHZdyMgSq5RTaj/LTBBmyMpfirGFoyOIevRqjgw0kXH7hP1eLjNDj6Eio92N8pp8N
 WKX8lOdBcJUZDjYZBFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310079

Document the optional #cooling-cells property for Qualcomm PAS
remoteproc nodes so they can be used as thermal cooling devices via
the QMI Thermal Mitigation Device (TMD) interface.

Qualcomm remote processors expose TMD endpoints that support thermal
throttling through firmware. The cooling-device specifier uses 3 cells:

  <&phandle device_id min_state max_state>

where device_id selects the TMD endpoint (for example PA, modem, or
CDSP software mitigation), with constants defined in:
include/dt-bindings/thermal/qcom,pas.h

Example usage in a thermal zone:

  cooling-maps {
      map0 {
          trip = <&cpu_alert>;
          cooling-device = <&remoteproc_cdsp
                           QCOM_TMD_CDSP_SW
                           0 THERMAL_NO_LIMIT>;
      };
  };

Acked-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 .../bindings/remoteproc/qcom,pas-common.yaml         |  9 +++++++++
 MAINTAINERS                                          |  1 +
 include/dt-bindings/thermal/qcom,pas.h               | 20 ++++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
index 11faf655f530..f75cab6b4ed9 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
@@ -77,6 +77,15 @@ properties:
       channels and devices related to the ADSP.
     unevaluatedProperties: false
 
+  '#cooling-cells':
+    description: |
+      Cooling device with three cells:
+        Cell 0: Cooling device id as defined in
+                include/dt-bindings/thermal/qcom,pas.h
+        Cell 1: Minimum cooling state
+        Cell 2: Maximum cooling state
+    const: 3
+
   glink-edge:
     $ref: /schemas/remoteproc/qcom,glink-edge.yaml#
     description:
diff --git a/MAINTAINERS b/MAINTAINERS
index dcffe9fc54f6..3f1e2bbf7099 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3423,6 +3423,7 @@ F:	drivers/watchdog/gunyah_wdt.c
 F:	include/dt-bindings/arm/qcom,ids.h
 F:	include/dt-bindings/firmware/qcom,scm.h
 F:	include/dt-bindings/soc/qcom*
+F:	include/dt-bindings/thermal/qcom,pas.h
 F:	include/linux/firmware/qcom
 F:	include/linux/soc/qcom/
 F:	include/soc/qcom/
diff --git a/include/dt-bindings/thermal/qcom,pas.h b/include/dt-bindings/thermal/qcom,pas.h
new file mode 100644
index 000000000000..f603bddef9a8
--- /dev/null
+++ b/include/dt-bindings/thermal/qcom,pas.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Qualcomm PAS remoteproc cooling device indices
+ *
+ * These indices are used in device tree cooling-maps to reference
+ * specific TMD devices provided by PAS-managed remote processors via QMI.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#ifndef _DT_BINDINGS_THERMAL_QCOM_PAS_H
+#define _DT_BINDINGS_THERMAL_QCOM_PAS_H
+
+/* CDSP thermal mitigation device id */
+#define QCOM_TMD_CDSP_SW	0
+
+/* Modem thermal mitigation device id */
+#define QCOM_TMD_PA	0
+#define QCOM_TMD_MODEM	1
+
+#endif /* _DT_BINDINGS_THERMAL_QCOM_PAS_H */

-- 
2.34.1

