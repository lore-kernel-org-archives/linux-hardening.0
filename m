Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE383385BC
	for <linux-hardening@vger.kernel.org>; Fri,  3 Jul 2026 05:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783055051; cv=none; b=L2T5m4fv4yPJrmWegAdCh+t4Pc0Eop0y2c8jYti8QHY2KHhS8KsgdM3QOysqO/y6uvX87tTrrErOPmgHpzFe2QRm+PI3hWPRu3SU8TBj9mnh1v9fny1wIze/T8FVdDvrTmW5GxGLLBb+2H9BajRnzkT108cR98n9xOJsdD4DIho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783055051; c=relaxed/simple;
	bh=AHfQqxqvUWEpKg7THeGPiYVTmEIZJi6on0qcJOPK+0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f18HiMGx+lmFScQlQafZRKCmy2sKKXqq+xKQLodhmg6EpS2FKGvxXy3Cwo7lwrGLM1OmS2U2XhjuK0l8D2cr6AhBUfSnwJd82T/fdnhd58K3wn3q+m4lXWGMZnomK83Uf3IqXvwzfAP4aE0UPM+h3PY0HsE712xtlKRTx3Aj4+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b2nQYXfU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zus1RwLY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b2nQYXfU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zus1RwLY"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66342hlw2687153
	for <linux-hardening@vger.kernel.org>; Fri, 3 Jul 2026 05:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mMrBdqNXSo2PZU6K/xNM4G+bRIzioC1tVR0BqX8fGXQ=; b=b2nQYXfUm2eGaYpi
	VZ8gZEPjRadBwTJIrJgb/q1hux53hTu6YV0UkHgy0+2XOdXiVxRrOM7Hlrun+0OT
	cYpBW62VsoI4QwlmGaIQLZbynAXl9cE3RNlfgfsMBlptECgHgldYCHSAPvWDvEdG
	sph6Aj+0ng3UfOXzIvrF8OMprBI5vGANv19ypXQpxMhd0oTJD+Nw3yvhFdWVhQ3G
	JNcWzR+ZY4u5/TQuZAlDjlhOzIlrDIjAUyNIBEZyYonX+/fDIwx2KQlNtU78vPkY
	Te2XDCzw9afm8PxJDdSUx57HF7OxiH7wzdSyBF+Lr+oSZ4L72Nvw06KC+OAhRNT5
	QLju+Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f648n0hr2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 03 Jul 2026 05:03:56 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c88fc985a65so357120a12.2
        for <linux-hardening@vger.kernel.org>; Thu, 02 Jul 2026 22:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783055035; x=1783659835; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMrBdqNXSo2PZU6K/xNM4G+bRIzioC1tVR0BqX8fGXQ=;
        b=Zus1RwLYPx1s9tviEY+z2iTPv9tz+rR93s8XXFG76xqpbd65qCqSsDQ25u9em9ecbc
         qirgFt3NEF07vEeNz+CVQ/IMb+CUBvDkPIBqQI6niyTJMDazwVIIigJGsrT06Idxs91c
         4mIqYyQQ1NzVmlfxSBWZMI5nf8nn+WQxmXh58WlTMxiT9nRuBSWk+/b+/msKXIr1+3Ka
         zvrz4TILqLGYdJt9sLhP13PuqfndPrFK0VndvO9RzQ++wiSu6gzQ0ccq9Xz1dSKSZ9PP
         HVNMYtP39s3rdcDq18lxnTl/BqU7c/jZVdjb87RB6jLIOaiCmhyTEOm9JO7V8V21sOs1
         yo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783055035; x=1783659835;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mMrBdqNXSo2PZU6K/xNM4G+bRIzioC1tVR0BqX8fGXQ=;
        b=f5cMYaCq9oZd90jOLcp/gHofpRxN6fjEJfT9oQRLtyVUp21pnqbzXpgsZt16LutQ4r
         W7IgHK9qLx5PD/kWtyErqsjC3RrPZ+aNie4dSVFyVpnuIfl7yp8BIxpA1noX0l+h75RA
         JxNhllaLYXSFp5VlgO7AewCOzXZiXJB8cnUeASL1kuHs+rvhcpiFj2Ae11MbJHB6Hk5U
         O6dKBUU6D3Q7QDrqTkf8zQrr+8NkHMVFXt6zJnVfyGtxQimHqszCKknimZ1uy8iUstaE
         bPBAQBoMb2yzwejbnJKLCNiTt8lTbvLmi751+bgFOUqf2gBY0xzKbIavONP7H/n6xidG
         Nyjw==
X-Forwarded-Encrypted: i=1; AFNElJ924sr5rIwCvZyDlFCqz34EcGcQvsWoSUaXwjLaC2xDwPZDVXmYw7mbE+sm461Lm4Iqb79SZvWOIqWd3+Kgfe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZxNwLAE/zdTBNvys2nHSfjoMYhs0PEPxnAfl9IcVXmHkz17B1
	38/Fw6O/26vBYCzgM0ehhw2zXUl3Ds3VB+GW3CZolrRXRE+Lw6ld9K9iGjc4WQkN3xsknB25Wh8
	cqqrAQwCeEd0hFzmXP5d421gLQYeazQTg/h00wWH3kI2XAjc3/7TI4IJ9xf9IBWX83days28=
X-Gm-Gg: AfdE7cnA1BtMU/+9/4QQm5suJCkfS/xmVDNeS0qExOoDmHG7oEynT8UcE/aQyq1FEMH
	ZK0npSLFNEkQeLglvhyf27I1la0bpUnd0hcgaDZS1mk6FYrxsKxjPockv2I4rfFMh4rn+8pzLqZ
	2l8QOU2RnUBrwM9GpfdgfhAMetJ1vYD5Lg2gUjkahjRclXTWpSA2oEdQqgjymHuKVvEWaC2SMTj
	K3+jzLmF16IziNOHgzM+SS6tUv/SAQu0TgqBEOS3sTaZXXol2/L03w3DeCZWQXLf+GrSd+b+Ilk
	qI1IgCqI1/hNLi5pvxQgsCjGPVzaFWwGZzS7kEkIY1q+hKdlcniiZvc2NeubzZN6ng+xAsSAHkI
	/GQAYAs8txY19MumwSMIrCf499w3H5RlQ6029wq+E
X-Received: by 2002:a05:6a20:7486:b0:3b4:65ac:e2e6 with SMTP id adf61e73a8af0-3bfed362212mr10430101637.36.1783055035295;
        Thu, 02 Jul 2026 22:03:55 -0700 (PDT)
X-Received: by 2002:a05:6a20:7486:b0:3b4:65ac:e2e6 with SMTP id adf61e73a8af0-3bfed362212mr10430053637.36.1783055034786;
        Thu, 02 Jul 2026 22:03:54 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbd2362sm16771941eec.20.2026.07.02.22.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 22:03:54 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 10:33:05 +0530
Subject: [PATCH v4 02/10] dt-bindings: remoteproc: qcom,pas: add
 #cooling-cells property
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-qmi-tmd-v4-2-3882189c1f83@oss.qualcomm.com>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
In-Reply-To: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783055015; l=2326;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=AHfQqxqvUWEpKg7THeGPiYVTmEIZJi6on0qcJOPK+0M=;
 b=UImge96cIdZ4CYD7PRKR4dfZ7NsDhPZlNtKO/+BLXVmJD68rxmIrTitXhlHIyHyjcpNJYfrY0
 euRG1xFLIEdDTvmuyWrMOn/QY8QxhxkqjXlKR+tzdlPuLiDBY8vCCtr
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA0NSBTYWx0ZWRfXw5nemNT3T+bs
 ZGFsAIpEqrMVm/SrQ9q+8bns3IwET0zKIApm6kwarxfwZ87UOBEJk1pxCEyJtckEj8UG6dvyNe3
 sc8j/C0bixdWKVoeaRfgavCmwBd0pIw=
X-Proofpoint-ORIG-GUID: -umnxTMMXCwEiBh3is9yF2wusZXK0Svf
X-Authority-Analysis: v=2.4 cv=O4wJeh9W c=1 sm=1 tr=0 ts=6a4742bc cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=glLd2v_-c-plxm5TIp8A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: -umnxTMMXCwEiBh3is9yF2wusZXK0Svf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA0NSBTYWx0ZWRfX0ayzcGCj8/4t
 yXLtkqNZC8jeliVS373GSxXrizNKjXu2g7f1DATB1C/rpXnEC7FnCfn09Tt7lUEoSfA8THzG0J9
 93P3hnUOSIA5F/+lm1EEnXahKQC7UxG3DGmd+Se9nxMMU8m3UfQsR1PtAgD75VSNwjCz2IZzajT
 zQZJ4rEKcYjJT76PzIA+XCvCmFIQwSYzk6r+6P8UDnlhz73Ux5RT1t8bkKUnY28OR12Vv5HqKFx
 70V0wLm9jcMf1sAICTreTDYPJ7wJtWFO6Ha/G8Ac2S3/BkCndtWFSZNEAeCzpiALrklnI4RoRca
 7Fz5hLfLauxPu0L+4J1eIb77YNhp6nJ27rlhVqLgAhviSTE0GOgu3/GlF4HCJj0bI2UvbPXwdjz
 aG6pG2U+ZY6VcDdmBdJ9SjVcNEp/Xl9a7BSN47zErzmg7x7nH8Ayj5p6YPAn+fCJoWZG8vx5EXR
 Cd2IpdOBXHia4+YHy1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030045

Document the optional #cooling-cells property for Qualcomm PAS
remoteproc nodes so they can be used as thermal cooling devices via
the QMI Thermal Mitigation Device (TMD) interface.

Qualcomm remote processors expose TMD endpoints that support thermal
throttling through firmware. The cooling-device specifier uses 3 cells:

  <&phandle device_id min_state max_state>

where device_index selects the TMD endpoint (for example PA, modem,
or CDSP software mitigation), with constants defined in:
- dt-bindings/firmware/qcom,qmi-tmd.h

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 .../bindings/remoteproc/qcom,pas-common.yaml       | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
index 4607b459131b..ef11371058c4 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
@@ -79,6 +79,14 @@ properties:
       channels and devices related to the ADSP.
     unevaluatedProperties: false
 
+  '#cooling-cells':
+    description: |
+      Cooling device with three cells:
+        Cell 0: Cooling device id
+        Cell 1: Minimum cooling state
+        Cell 2: Maximum cooling state
+    const: 3
+
   glink-edge:
     $ref: /schemas/remoteproc/qcom,glink-edge.yaml#
     description:
@@ -95,3 +103,34 @@ required:
   - qcom,smem-state-names
 
 additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/thermal/thermal.h>
+    #include <dt-bindings/firmware/qcom,qmi-tmd.h>
+
+    remoteproc: remoteproc {
+      #cooling-cells = <3>;
+    };
+
+    thermal-zones {
+      subsystem-thermal {
+        thermal-sensors = <&tsens 0>;
+
+        trips {
+          alert: alert {
+            temperature = <95000>;
+            hysteresis = <2000>;
+            type = "passive";
+          };
+        };
+
+        cooling-maps {
+          map0 {
+            trip = <&alert>;
+            cooling-device = <&remoteproc QCOM_CDSP_TMD_CDSP_SW
+                             THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+          };
+        };
+      };
+    };

-- 
2.34.1

