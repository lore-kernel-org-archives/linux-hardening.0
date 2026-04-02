Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B333537D7
	for <linux-hardening@vger.kernel.org>; Thu,  2 Apr 2026 03:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775098903; cv=none; b=q2PYThRq/0CNyAdDUqO2aNVjB3ziFDK/uaEseoYaLCimTbwqJCXNtiTDHsYHGIMIh166YdsDhDA5nCf1V43rYkdysco/SRp94AkomFnPjYSrZAbzXsdDYpFsQNO7rO3h8E9XfxRpZhy4t1IEE5L4i4DjudOP3OyRoPaM3NCJfek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775098903; c=relaxed/simple;
	bh=f2v5SwwFgePL9gIso6GzVLr45Q605cPfPF219lREbvE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RO3YeWt335Tc0tSdnLXKgBYWfUiBqnYIyoiIWHborBUdDEcwFXg7DmiW7TEa/F9OTGqDFib/EpdJsoOh+gxcUXLp8cj2mgiSc6s8MVdFVEaV/Wxug9ubbLhZGgpqyGsAxdoOtgTJIbi/butLkoaOu7orr9fiSuF+KVSOjAV6vvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XSDRflnU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GURm9cqS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XSDRflnU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GURm9cqS"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631M3xWJ3745854
	for <linux-hardening@vger.kernel.org>; Thu, 2 Apr 2026 03:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=oRGv2sSlVdsBDicGh/FSno
	6dDdTvkWE0GZ5eJYt+YxI=; b=XSDRflnUfutXKvSChnepvq6OZQicV651dUOf4z
	0koHefBnt6qTTB7H79hfBBbSj7d5Q3nXZHZ4orJ0Yy2M1nwiB5kAS7cr3mMuX1BQ
	gHklt7j2oPxS0rvV73HSnCkDHTPaVrPxnIJyo1g6k1OP5UqAWvNq/eGHMHPUreYd
	sjoN83abCNW+/bOMpmvvRfl2Hfx2p7EKQCwL5bkddsY+xKq1eyM8MrRWD6oC5OTx
	3srqIbTiLgAc0CcHkbJfLhZVI4VhdBh9V5oRd5EF+O18ZvXDLDSYHBHmcYv44tEl
	yHnfdM9Q+NS44tU4cCYKLPMSEFPNX4r/gzHfL4d2NShDbLNQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9324k3br-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 02 Apr 2026 03:01:41 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so544171eec.0
        for <linux-hardening@vger.kernel.org>; Wed, 01 Apr 2026 20:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775098900; x=1775703700; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oRGv2sSlVdsBDicGh/FSno6dDdTvkWE0GZ5eJYt+YxI=;
        b=GURm9cqS307HBknbVngJ03J/vM4xyPx9hqnRio5Qp4Gn/QNIMM5BVLq+1jX+IXSOrp
         ZsEZYVD1PAuo6K2QIVYx/X4/GDnhMFz9TRv/wFoe1kc1V0U5n7/Z0+cBCvJIde6lXc29
         F0V7QVDr89B5szEu2AYfoNZpEOgLp4DGCjDvdAVRtzCZq6FlKoLRA9CFnK5DVMn+5hsJ
         j9/a6PFbcx7pAGUmjZRTa7z0tUYJU70lvKkqiPdlQH+x8o+lWXvRCOeyIGHX6Gr3YAP7
         D1ze1BR67S4L3tOiOF3HdI4uArM/yBKh03FYsOXIOwRZqsflqiNMJwHnDudj3DqNiBso
         BENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775098900; x=1775703700;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRGv2sSlVdsBDicGh/FSno6dDdTvkWE0GZ5eJYt+YxI=;
        b=fjXGf5MIQFDF7WVI+tUpHw1rBkjYAL+SSgwEEftUybwu5abRkiZpm3ZWAs2+7Ia3Ri
         inq21GU1+1o10XCeSCR2NGUS0Cck/3lVfuszdxbi9yuiAnWet/3xknm/LX6FitMauWZH
         5zoh9mX5x1eJ/7poVHT2vdqUaQ/RUqPr1voXlTorK2qrMjGp6DQGRLOJjEYPFeCF+mCO
         TBO8ioSSPUmEPldb8Kchk5rUKndbkL5xFgrIcrSnMOJ303tGWCyP6KTdosb3tGVEv1UI
         o6MB0RjDfS8gN+smr4GBTY31xrmHVAudGumpiXqfXJGgzu2eXCknTn0Nxc8mHuVJCx9O
         IVyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEPfph6rNexh4mB+z15k7MiT1ZDuD/mo9m3ZDW2nXGN+u6u+aYyo36m6U09oQ8z5csqsmciKChV8teuxSsXYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCmLeGz+l0wvUPg3FZH7pC+ycAcoARThrA3bWP5nwGOdGs9PlB
	jfC3iK1JLc+B+KszY/oCa6jjl9wak77d1CNlHK4Ek6yWpgjxnerAIFNAaj4cBLEnq7IYI1dKi2k
	XHKJHmBz0TmQELkqGEsuvRybbk/FkMH2iC1noTW1LyG401FvLM4EvIO+bQDhwK2yu4U/Jow==
X-Gm-Gg: ATEYQzysxWSosIhwGt5zb0bksdI1TdihFn1ZFSRo0uKV4SBIU1vJvr2cLQUD8C2I6Kf
	2MFyGDjfbacvysIbSGGYkcMGc7qIIND8WnFGZRWFiXqjp/t8drxTKyCW8CGhkiHG0QCCBkYcbRZ
	iVP3BZpIv6xGW0bhgGyJWUGLarCpY+Ow+KWeBHzt1mmigL2wbGnQ2VjWiE8ZZt2y0z+u+X8ZyXG
	aXkXUQioPWQ7b7yF4B1pCrmxifJJ58tiXm4jFhrRW1EwAiIwd/wq0VL3eR0I0Ks7zIETrx1SAvt
	qQgF8HoMSrb8byLPxPvOvZpPBsw/FLwcnrCADv0rnw75TUbdNoxaw+GMlAdYvFYLDNW9zKtsDdF
	ontLnyashR1yOUnIlQ+epZMA2JglHzdWP5Sd+XCPy+ib6pKWgpyEA0x7nKAiLuCpRJkMWEwEe6A
	==
X-Received: by 2002:a05:7300:ed0e:b0:2c3:fb9d:cd04 with SMTP id 5a478bee46e88-2c9325b08a7mr2875858eec.17.1775098900189;
        Wed, 01 Apr 2026 20:01:40 -0700 (PDT)
X-Received: by 2002:a05:7300:ed0e:b0:2c3:fb9d:cd04 with SMTP id 5a478bee46e88-2c9325b08a7mr2875839eec.17.1775098899342;
        Wed, 01 Apr 2026 20:01:39 -0700 (PDT)
Received: from hu-fruiz-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7cf010d7sm1287044eec.25.2026.04.01.20.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 20:01:38 -0700 (PDT)
From: Francisco Munoz Ruiz <francisco.ruiz@oss.qualcomm.com>
Subject: [PATCH 0/3] Retrieve System Cache Table (SCT) descriptors from a
 shared memory region.
Date: Wed, 01 Apr 2026 20:01:33 -0700
Message-Id: <20260401-external_llcc_changes2set-v1-0-97645ede9f6a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA7czWkC/yWMXQqDMBAGryL73EA21B96FSkS4qcuhFSyUgTx7
 gZ9HJiZgxRZoPSpDsr4i8ovFeBXRWHxaYaRsTA56xr7tmywb8jJxyHGEIbHUafYTA0wdz60XDs
 q/ZoxyX6/++95XiPBT5BrAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775098898; l=1367;
 i=francisco.ruiz@oss.qualcomm.com; s=20260305; h=from:subject:message-id;
 bh=f2v5SwwFgePL9gIso6GzVLr45Q605cPfPF219lREbvE=;
 b=BGgjtTogITYB5Gl7DlQ3B2Zoh4XHOWyNyXTzZCG7e8ngvUF+vbxzbkpIwOurWuxyVpY5bV2Wc
 1Wg5qAFrGDWBRIXCv26yTCLmCR97xXh4g00j4wUfCxOhWzmL5o79rNn
X-Developer-Key: i=francisco.ruiz@oss.qualcomm.com; a=ed25519;
 pk=Gcv2CX7iHozjnQ4oK+9fINmBiQTmVC4SpaZzoM63CHE=
X-Proofpoint-GUID: 39Idkgs4o8HYft1JfpiY3gAB_FmKCIYf
X-Authority-Analysis: v=2.4 cv=TKBIilla c=1 sm=1 tr=0 ts=69cddc15 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=7fDgnTYA3Q_ah9AnCHUA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAyNCBTYWx0ZWRfX11rv5Oh0bcTM
 IUnXea4fKd9g64VYhtFAK/vNLpSNVcyV6K59eyVtcd7h6oGEUeprWdYmZMM59vbK/8lZ9CRA7UL
 iPW4nVYUguAhZFAkp5CbJZ6oXON2DZuJoy4cNGDCCD03cIZtxOfyv76ebmpn5+aJK/bMDXMk565
 AbU/JA8lbKMKVj0qSuN/nEfbzqDHgYMuLJEwkYY6P3KFfZOEuCngTrXUJMwzIi7H3xRpYXlD9Ve
 u2MhUcke+qo0tTl62ynPKblAF76f0PSfVD2DVFMI1wx9jA8T3qSxuFjlmN1OoSGfNtPpmjXj2y5
 2uY0A+s5GXUjrdn7pSvTps5uK720cEZMkMMcs5+gcgiKT1Q9zQWhsG7YbAcNTYd6wTkB+djSQfy
 cUfkG/FCJ7uMcYeXm7GtjikfoWMCCPpNUDQuTKX391sENx0wbX3p5kfQPSvUMUdgiHWh6B87kKk
 cLW/U8hn7GBkOuRvT1Q==
X-Proofpoint-ORIG-GUID: 39Idkgs4o8HYft1JfpiY3gAB_FmKCIYf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020024

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
Francisco Munoz Ruiz (3):
      dt-bindings: cache: qcom,llcc: Document Hawi and future SoCs
      soc: qcom: llcc-qcom: get SCT descriptors from fw-populated memory
      soc: qcom: llcc-qcom: Capitalize LLCC/EDAC in comments and diagnostics

 .../devicetree/bindings/cache/qcom,llcc.yaml       |  29 +-
 drivers/soc/qcom/llcc-qcom.c                       | 301 +++++++++++++++++----
 include/linux/soc/qcom/llcc-qcom.h                 |  44 +--
 3 files changed, 298 insertions(+), 76 deletions(-)
---
base-commit: bd0f139e5fc11182777b81cefc3893ea508544ec
change-id: 20260401-external_llcc_changes2set-5ee118ac7152

Best regards,
-- 
Francisco Munoz Ruiz <francisco.ruiz@oss.qualcomm.com>

