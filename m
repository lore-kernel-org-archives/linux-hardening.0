Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476792517A5
	for <linux-hardening@vger.kernel.org>; Tue,  7 Apr 2026 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775598728; cv=none; b=ZrYMxVaCAdqcOiAmBVJaozITY5DQ4FXdp3yYyP4i6cPXRCCm8M+Kv0FJVt296AZlSxnDUhV1sxRmtXmZ58mq5qx818KsiQbM5JgRg4OqhhTBTFEZ2k5sNZYc+z4ZadRJXbn5yREKtQXhM6ypURF+F686Bl785nau13RfIfEvVus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775598728; c=relaxed/simple;
	bh=6rzWCEmgxgBb6ytYesWxnNywYb01hhCB7YS08dhMyK4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pRftaUgcmNtzv3gOhYUIHUKL7OiLPOlyjNT9MiqFWmm1Ii/f1L5btwJCTQgkUlHScQCgS+s9Rty4dBifjqFR+Js56i5DefdTjC8+20D0ZAJJ9yoU1QUN1wTnxXvwMHtyHvXn/PWzPc+6buyYOT14llY3u/t4jPMQ6r5YE2xMOmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TK6TrHtp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U2btZC9V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TK6TrHtp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U2btZC9V"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637JlfNn1314245
	for <linux-hardening@vger.kernel.org>; Tue, 7 Apr 2026 21:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=NuyzkqXwLkh5vwGcgTPUqo
	a/D0g1fiPd2TiXEBRp1Dg=; b=TK6TrHtpPV1Lefo3h5zsxzcHzc4Fg8YEi2UjpB
	X0MNHmyR3rqOAMnIySYmA/Me0p8jFC1JffkMyzMSr8NDvbAWqic112JfrvrhAu8Q
	3PSNDDdcKaVvgrmn7b6gkft/INEXsAW5VDJ4GYWzHY9e0qn8kZgjs0/+xtsaXU3i
	KvDBJttIWLymJX5qEIM/KxJ/kaDV7ddMQbsBYpaIDSzNmYT5xFv7CuR0rOWmCE/5
	TfSuDU7NoJz6sZsYZ0g6jFIwZQWasVC3WqpK0njz9WW5Tq2F3NTy9vH86kcZrec0
	VIiK0ERJHPsGJ3c/HyqKIQJqzRuvJCvwAQK1OM/02roDfWdw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd8d6gb23-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 07 Apr 2026 21:52:06 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-12bfa367189so32933746c88.0
        for <linux-hardening@vger.kernel.org>; Tue, 07 Apr 2026 14:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775598726; x=1776203526; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NuyzkqXwLkh5vwGcgTPUqoa/D0g1fiPd2TiXEBRp1Dg=;
        b=U2btZC9VDRZQofYN8V3VQlebuqwXojgJq7FKu9sBtY5V+TEqRmCy6fkTF6u4yBCbyC
         iH0yKrDxIq3O56N9a79FI3gJvDhAbTm4mgTv3KkHCFPXLM4zCB8ffbyJiDc9ImrlwJyR
         j00N8DM8M3lWZWI8SorW2mLyDoeNe20ss+7uuyK9OIvCa/GfbrhaxxgqqjLU+0oagUkj
         J5d6T08QQBQLXP/MnCMCNDhabJ7WX5+URZ44aFClh62pWkWoMoUUBHwpmrSCly6Gz+jv
         mE8IHsCRbrJpTV6kbY6gPPbCUITsTspefSmqB0hpxjBJR7hmHGKx7XFI5Mq/oorjzYUm
         F3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775598726; x=1776203526;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuyzkqXwLkh5vwGcgTPUqoa/D0g1fiPd2TiXEBRp1Dg=;
        b=sKMGFns0UXtLUKI93RFfOhEIP6x1sk7j4hNxleD8QlgPE5HeCVfYv6BUl3kxs7L1oY
         /S4s6o3QFSab+39nQu5WAjdZJ799a/1FIN1bphtZ9zmga47+chEY8vnaU+pAd7/+IVcV
         LN4xU0VUXFzG58L50Za6TO0NOO01vIvxzlWaVrPrP+GbZOZCs3odoCk8rXKxN+MeNZCX
         T8jiB+zXKPwsv4Gxv8j7LuuYX2rhaavgTmQRb+bSbyV/UKX0eqN597pFJaBX3kKuq69s
         gLE/CUnPulv+s9We3d9nOODOK/i60H2R7dhFkqKqGQy+pU2vgY5JhEML0XC70RjLolCN
         N4AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd1Ge3Y5vT1YwOhBSIdYl+3NAVyXJGIpKi2PCNmZLJwz4kvHEgWBtvKp1/I/hcMWzf6xbUUmvoVUXv/zNm7DE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza6nqaFgeEQizCR+SyZaJqBkJazM/Dx9gyEvp3rOJvfGj9pMEl
	MHjJM/6sb5oPSgUX0YARBWJfhJSCN3Av7/VXUJGE+QqNZcNvAWXMVdBRpx5NMpot8QaK9BEuetp
	FWkqs+cjYwKC/sqjYbuAQ3oF7/ZzZ5gWURM6awe1KSyB2DHKrQWtk1usJlVOeb2omLkWfzA==
X-Gm-Gg: AeBDievvOFa33PtlsL4KNg3jDZDs+pGHGjIS/zqZy+Hwo0QVs2TAdkfx/wPDKWhmryL
	6JThyi37IQ9XIMfrsnAaA1QmrSPZDBskBc0m5Lb61WHs2jHpdSq3d0t1QRluO/p5gFWv7GgUU6P
	ExYmDai+VSjbyZ/s4gokQMLqrTTrzqghw8K5GcUX278X79WxF+RbLGbvKCLKNSRhCR+0iuwhcrC
	irQ6PBEKQkqgUzmjdYVqLMUbojdDMWJOWf7g6hHrSD/aEgwdjFrykLA9T9QiwUmckIPEW/4oyVg
	k8UiMprvMdYbqEblHpQxeVy6Fkttveve6DUiTI4GQLTi2SX8rtZGYZqa4N7NmP+Xc1HkaMCF1NQ
	QFRRhjXfUNjCdYkADvwgJWE9DiE1X3s6CIhi4x/CpezVIT9ALYiYffqLawfE7QYhp5N9q/3fvHg
	==
X-Received: by 2002:a05:7022:41a3:b0:12b:f881:d8fb with SMTP id a92af1059eb24-12bfb6ec86fmr10337012c88.3.1775598725655;
        Tue, 07 Apr 2026 14:52:05 -0700 (PDT)
X-Received: by 2002:a05:7022:41a3:b0:12b:f881:d8fb with SMTP id a92af1059eb24-12bfb6ec86fmr10336988c88.3.1775598724969;
        Tue, 07 Apr 2026 14:52:04 -0700 (PDT)
Received: from hu-fruiz-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bfea5f860sm16224123c88.2.2026.04.07.14.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 14:52:03 -0700 (PDT)
From: Francisco Munoz Ruiz <francisco.ruiz@oss.qualcomm.com>
Subject: [PATCH v2 0/3] Retrieve System Cache Table (SCT) descriptors from
 a shared memory region.
Date: Tue, 07 Apr 2026 14:51:46 -0700
Message-Id: <20260407-external_llcc_changes2set-v2-0-b5017ce2020b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHJ81WkC/42NTQqDMBCFryKzbiQJRmtXvUcRCXGsgWjaTBos4
 t2b2gt08+B7vJ8NCINFgkuxQcBkyfolgzwVYCa93JHZITNILmteccFwjRgW7XrnjOl/GZKEkSl
 EIc7aNEJJyP1HwNGux/atyzxZij68j6skvu4/q0kwztqmrhQO2I61vnqi8vnSzvh5LrNAt+/7B
 8soN4bJAAAA
X-Change-ID: 20260401-external_llcc_changes2set-5ee118ac7152
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775598722; l=1681;
 i=francisco.ruiz@oss.qualcomm.com; s=20260305; h=from:subject:message-id;
 bh=6rzWCEmgxgBb6ytYesWxnNywYb01hhCB7YS08dhMyK4=;
 b=aMCDYIFSc9K5lsVhQv2AbWh0+aaaXGCRFymzhF6bo31xGJmz/rrRbYRHoKJrF9fK3e+M+UENE
 yWht/4Wy5SeCaSFHjHHPJzdJ4XVgaAIIYYeDX7Y5J8eeGVhOUAeyjrs
X-Developer-Key: i=francisco.ruiz@oss.qualcomm.com; a=ed25519;
 pk=Gcv2CX7iHozjnQ4oK+9fINmBiQTmVC4SpaZzoM63CHE=
X-Proofpoint-ORIG-GUID: IV7yYee8Q6Y6Unl_sTgMwSRVW4zveRgk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDIwMCBTYWx0ZWRfXwptjRI1CKG6z
 psBxetK/Wy27fuPMUKBGDnHMmh09wk/eQm1MxP7m4/rpkiOxGEBqZf0vNzOYlADLPI9WcJrgmlQ
 x3MFVdnrpQ+bS5kRP2LBxGMLdGTGr3a60stFH68xIEXLr4DuNY0gcgVjFySE/FhzQwepTuBNdNF
 68IzEgpyIPl2k6oelfjBdxmYd52n4Mk4RzG2sw5K0zny1JK4/Uu8RCLcWc2iDZAhN3xDLaBFmlV
 Cbqs8Mh/PKENHW+uGDwUuyvEsybk48R3YTi6ARXgkoOYZeEJnY7rDgioDf/sv87zMtI//Xf1IC8
 MBhg/EStQQWBjV9c6PZFFYnythfSCe8gZttZ+RQeypR4b7D2X8I8yYP7OgX0SictGORQDCVwgWQ
 KFKkLLEGDd+qT5j+7p2UT1gFxcdG69gugpwzQ2uCCnojNfR5B+k4GDIDJP98KhPAo2cMRYGzlNh
 niGl3SNpvtfghjI8n/w==
X-Authority-Analysis: v=2.4 cv=GN041ONK c=1 sm=1 tr=0 ts=69d57c86 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7fDgnTYA3Q_ah9AnCHUA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: IV7yYee8Q6Y6Unl_sTgMwSRVW4zveRgk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_05,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070200

On newer Qualcomm platforms, SCT initialization and programming are
handled entirely by firmware outside of Linux. The kernel is expected
to consume the pre-initialized descriptor data rather than configure
the SCT itself. The LLCC driver therefore only needs to locate and
parse the descriptor table provided by firmware.

This change implements support for this mechanism in the llcc-qcom
driver, enabling SCT consumption on platforms that expose SCT
programming through firmware. The existing behavior for SoCs where
the kernel programs SCT directly remains unchanged.

Signed-off-by: Francisco Munoz Ruiz <francisco.ruiz@oss.qualcomm.com>
---
Changes in v2:
- dt-bindings: cache: qcom,llcc: Drop "and future SoCs" from commit message subject (Krzysztof Kozlowski)
- dt-bindings: cache: qcom,llcc: Revert binding description (Krzysztof Kozlowski)

- Link to v1: https://lore.kernel.org/r/20260401-external_llcc_changes2set-v1-0-97645ede9f6a@oss.qualcomm.com

---
Francisco Munoz Ruiz (3):
      dt-bindings: cache: qcom,llcc: Document Hawi SoC
      soc: qcom: llcc-qcom: get SCT descriptors from fw-populated memory
      soc: qcom: llcc-qcom: Capitalize LLCC/EDAC in comments and diagnostics

 .../devicetree/bindings/cache/qcom,llcc.yaml       |  19 ++
 drivers/soc/qcom/llcc-qcom.c                       | 301 +++++++++++++++++----
 include/linux/soc/qcom/llcc-qcom.h                 |  44 +--
 3 files changed, 293 insertions(+), 71 deletions(-)
---
base-commit: bd0f139e5fc11182777b81cefc3893ea508544ec
change-id: 20260401-external_llcc_changes2set-5ee118ac7152

Best regards,
-- 
Francisco Munoz Ruiz <francisco.ruiz@oss.qualcomm.com>

