Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4150A3F076D
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jun 2026 10:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000600; cv=none; b=AZkzuEYbo7/Jmvy+pCvb+XZBjAictq7NkG2xzlsxJRFnsu1Oxg1sshxya8/RPXQBmMJfRjjYjFrKdSzubIT9JpSQcdSIksSzb4MQ+qxesJ0AcEMGNL0rqzqFw9sLK/G4cXgVi3Yx2DovIyc70xyEJ+Yrdc75gHNTkREuqwHjm/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000600; c=relaxed/simple;
	bh=pRWR7Sle0Ibge83uBc7U3bzTmBHPG659jM3kFTWozRQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Cvaf5c9I44bGUz5crpPHxx1FLCFY24ZSp02B0mig57vun25D8wd7Sl6GqynbUxGd22gXqJc2oiLBHi3rMU3BcZVlmpMDX8ENC042ExhrTK8tEO/tEc9BI5D+DtFAtU0izoe65PszvrW7EgAkUiJCe4XgCJYNWJQ71TdL/9U4i7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gh1m0U+v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AlW56y5Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gh1m0U+v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AlW56y5Z"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6599vDqY1868517
	for <linux-hardening@vger.kernel.org>; Tue, 9 Jun 2026 10:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ObQ+hdcLgIgQf/C1IxxeoW
	mIo7Pz7pQxcaJXHArQT1c=; b=Gh1m0U+v/mdHb92vT846r7mnSNcUb/cjHm9aFk
	iV6kJ0iKB7faoAkzv3loQSMP9mqIeiRXbpVEJrAyNlnbDA57BlDrYsVdfHk9aNH+
	lJsHxv6lIJo/h2ScILSN8NZTVF4dRfEAwolk/KuxfjYwST0BaV6+RhV7LrZOAqhY
	v3bS3Hq06GWSzXaHbXSIODvNofS+fjCe1p77l3KYYZ6+Qce9BAQCeJzsFGX2C14C
	nWZu5NJlJeRIQu4e910FMB1kQ9D/fjnNO/BltM5chOCRKVQxMA1nZtMS6nVAiGm1
	3htwUDIxnLy+k2gm35Pai/+OMKmU6YV44cXKbEPpiCcoXhWw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3wg7rd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 10:23:18 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bf11699875so55577885ad.1
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 03:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781000598; x=1781605398; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ObQ+hdcLgIgQf/C1IxxeoWmIo7Pz7pQxcaJXHArQT1c=;
        b=AlW56y5ZvpTuzBtlmDVDQ3fnLJQqhWPfWQ6EDj+vZzo0MfJGUQQ/dynJ0s5UPxZR9E
         0ppHNFHo7xT4vlpPwPsJeS84752Gr64XKFc2pjrPG7dcBG8K+yGl1Rb506HemgPQWyA0
         IHMZRIKbJsvg5JUsIwQCCVZVCk2Gn8ZEwzj41BvoHXrLrdwWchDYICLuuG/CptSq/+Yg
         B1A9kGIdPdKbC6AZIniLZDUWrq0LBGm1gmHI3bRigtpBLKbGfBDnmMQe5Sv1I8uLSLzN
         TC+rOhy4uEmJI6XZxxoEHPWWrFprqb+rJswhTMhnR5luxLpxzMI5BeszmOsfpWdNtYZc
         Uvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781000598; x=1781605398;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObQ+hdcLgIgQf/C1IxxeoWmIo7Pz7pQxcaJXHArQT1c=;
        b=s3/gpjH2Gg7p3Jm/pcguyuJuyE0d4B8Ca5+ORL12tnKyrri8dZ4vLhKuyT3v70avet
         xs9564HPxCZWMcTWN0Pjf/vM1XhbQJkeVvnGNoXzRN9D4ISIsr7WRtdhw09Is2oh8ABq
         HmfrY3/JKgkUcZWLZAq6hmS0XzKBvjurFWNWurLL+x1DotU5EMKx4g45qj8UVUV7fNfF
         6DbV4qtFzd1ttYHb/l8J0zhE+sLvhP2F0Ib1uWMOf+7vD/GN3Hl1RCHyOxBq9g4CV1n8
         CKshQvAiZvs3V5g5NQjcmYlzCFIDiXw7//2vmnoY8igRGGj2PbtjA+yraKyHRDYkFp/Q
         6D8w==
X-Forwarded-Encrypted: i=1; AFNElJ8z1nNsgY1IAnr2+eBF9z0DprUA/wT6GLM2kRfbUgPoSXt7J1Jv5v5RQdN0fdTaFqCY0ZSMGvHNzJ9MV93qoWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylekuB6LTFC70SplLiQsSd9z9FVa+3a6TZINdceQWdH4YnZCHo
	7kWSTFPqMjcjWi6Rn4TX+G9zZTTwdPIigT23sr3AwF74shWVseqvl6pPhSYIiR4lKpYbHz0Q3iD
	VhaulE0UHQT+gfqqHvT4I80MOWqWYPx/nfoigaYtz+x/6GXPxmPK+oK0Z00NbEN1uMee/0dc=
X-Gm-Gg: Acq92OHydHhveHLarKURHYOi3tewDSkZN02Kf0e1irSNMrygTaB4f5r8n9cvNztmWZo
	JZVKIglcBwsBHym9AHmvIbFzgOz0AbZ95JV+JmPa9jW+bu3cbK4zjHfAK1NkqgXS1hGxbtNsOQI
	z2FmHVb5IW/C/tdLk+KGvhEGIwZgVxxF3XFBM4DfVa/fdWe110YFl78N2z8sSgcb2SbH7ohpj5R
	IIFF2LXOxcx86wQPs2ppDpma/HQBYgtm9lIxv/hJO8VDMjOfrziMOaBOlLVE0LKFZEihLloyq/b
	cX1ne5+8pypn+uCsItARTegOCLnIOwnwlExe4Wfgb7Yy8d+fpoSEJPqwNhqjkRLHEpWWViXUl3D
	XwadXSobrdNtwUqflKacfP8eR3CPyhL2tH06YQkibgAaC0GAfP3MONm95v21FWA==
X-Received: by 2002:a17:903:2acd:b0:2c0:bcff:e1a9 with SMTP id d9443c01a7336-2c1ec7dc6d1mr151598155ad.9.1781000595615;
        Tue, 09 Jun 2026 03:23:15 -0700 (PDT)
X-Received: by 2002:a17:903:2acd:b0:2c0:bcff:e1a9 with SMTP id d9443c01a7336-2c1ec7dc6d1mr151597585ad.9.1781000594976;
        Tue, 09 Jun 2026 03:23:14 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c2a4a64e22sm14738915ad.61.2026.06.09.03.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:23:14 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Subject: [PATCH v3 0/8] Add support for Qualcomm remoteproc subsystem
 cooling
Date: Tue, 09 Jun 2026 15:52:55 +0530
Message-Id: <20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIDpJ2oC/yWMyw6DIBQFf8XcdSE8ImhX/Y/GBVGqNxWpoKSN4
 d9L7eYkczKZA6INaCNcqwOCTRjRLwXkpYJ+MstoCQ6FQTChmGItWR2SzQ1ENnKQzHKjmIFiv4J
 94Pss3bvCE8bNh88ZTvz3/htcaF7XWggqdKt1Iwkno9mDSfTppxlvPka67mbuvXO0DHQ55y973
 AYjqAAAAA==
X-Change-ID: 20260609-qmi-tmd-383d30e1a60a
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
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Casey Connolly <casey.connolly@linaro.org>,
        Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781000588; l=4132;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=pRWR7Sle0Ibge83uBc7U3bzTmBHPG659jM3kFTWozRQ=;
 b=RUjO4ZaHu8eAp2L8TuRvYgI7olAouPDsvkLczSlOr4bCtcXeXr4R2ehYF+7uafzptJ2lzbQbE
 PA6ZHT1TKsLAppBFVkEqBbikCGwHhlYKjw0Y/UZcTJwtDp32DYfMJ+6
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5NyBTYWx0ZWRfXxLsaG6GAp1L0
 p3qusQJKii3BjcsAxyKXEwc5hxBn0+HKNocrV4s2mJ1iWrG+pS/Pq0Bw7i08fNg3z5Wwl9Tk1c0
 RYxnzu/9idhNaiLG6tTshoPL0wgmSdCEljrq2bqYhp/1VN4jlIju5FWCJzPtuP0xAl/QT5bVIyJ
 yQMxGTZIjlIPCCRFt5jxRGnGiJwFxIVQwVFiy1XCgTmG+QJV5FKBHjC3yCWQ57/zjWc/EZzHqGO
 2yvgwq84VS0nSsOZa2FnZ6OAeLkfSQtszePvWfmIzxNntmWfANetOOjBEPgYQxgpxZ5v5zyGXBN
 yu3X6eNex51d0C7N+9f0RIbp7iF1ThlQ9jE9/yba/dJLjQm2MhCm2YTcdaYUk+bd61QzFETYscH
 owxoZvORDLwbuNa9UIhObDMW6B0pJG1ywZ8XU3lqbE/EcHGOALJ45EPGpdmt4VzKOTCBgosdq76
 Dhv11zzZdbwNCBz3mDQ==
X-Authority-Analysis: v=2.4 cv=csWrVV4i c=1 sm=1 tr=0 ts=6a27e996 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=OMKWdJ6r1yPKoj1lEeoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: sS9Eon2UILUOEpmXkv4ACUeBJuI4CWl4
X-Proofpoint-ORIG-GUID: sS9Eon2UILUOEpmXkv4ACUeBJuI4CWl4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090097

This series introduces a QMI TMD (Qualcomm Messaging Interface-based
Thermal Mitigation Device) helper library to control thermal mitigation
devices on remote subsystems such as the Modem and CDSP.

The objective is to enable thermal mitigation for Qualcomm remote
subsystems (for example, modem and CDSP) by using subsystem
temperature data into the existing Linux thermal framework.

Major functionality provided by this series:

-> Initializes a QMI handle and performs TMD service discovery
-> Monitors TMD service availability (arrival/removal)
-> Creates cooling devices from DT-provided TMD names
-> Supports multiple mitigation devices per subsystem via index-based
binding
-> Sends cooling-state updates to remote TMD endpoints

To support cooling device with id (index-based binding), this series depends on:
https://lore.kernel.org/all/20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com/

This series also revives qmi-cooling from Casey’s earlier QMI cooling series:
https://lore.kernel.org/linux-devicetree/20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org/

Key design differences from the earlier series:
->Integrates qmi-cooling as a library and hooks probe/unregister into
the remoteproc core framework
->Uses an index-based API for cooling-device binding
->Cleans up the macro name and removes unused code

---
Changes in v3:
- Removed the remoteproc-cooling abstraction approach.
- Integerated QMI TMD with remoteproc core framework.
- Cleaned the macro names and removed unused code.
- Switched to index-based thermal_of_cooling_device_register() api.
- Link to v2: https://lore.kernel.org/linux-devicetree/20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com/

Changes in v2:
- Update Remoreproc thermal config to tristate and removed unnecessary NULL checks.
- Fixed dt binding file format and added generic name support for cdsp.
- Fixed memory leak and cleaned up qmi-cooling driver file.
- Corrected DT formatting errors and commit descriptions for all targets.
- Link to v1: https://lore.kernel.org/linux-devicetree/20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com/
---

---
Casey Connolly (1):
      soc: qcom: Add support for QMI TMD cooling devices

Dipa Ramesh Mantre (1):
      arm64: dts: qcom: hamoa: Enable CDSP cooling

Gaurav Kohli (6):
      dt-bindings: remoteproc: qcom,pas: add thermal mitigation properties
      remoteproc: qcom: pas: register TMD thermal cooling devices
      arm64: dts: qcom: kodiak: Enable CDSP & Modem cooling
      arm64: dts: qcom: lemans: Enable CDSP cooling
      arm64: dts: qcom: talos: Enable CDSP cooling
      arm64: dts: qcom: monaco: Enable CDSP cooling

 .../bindings/remoteproc/qcom,pas-common.yaml       |  14 +
 MAINTAINERS                                        |   6 +
 arch/arm64/boot/dts/qcom/hamoa.dtsi                |  63 +++
 arch/arm64/boot/dts/qcom/kodiak.dtsi               | 127 ++++-
 arch/arm64/boot/dts/qcom/lemans.dtsi               | 126 ++++-
 arch/arm64/boot/dts/qcom/monaco.dtsi               |  99 ++++
 .../boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts     |  17 +
 .../dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts  |  17 +
 .../boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts |  17 +
 .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi    |  18 +
 .../boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi   |  16 +
 arch/arm64/boot/dts/qcom/talos.dtsi                |  19 +
 drivers/remoteproc/Kconfig                         |   1 +
 drivers/remoteproc/qcom_q6v5_pas.c                 |  61 ++-
 drivers/soc/qcom/Kconfig                           |  10 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/qmi_tmd.c                         | 604 +++++++++++++++++++++
 include/linux/soc/qcom/qmi.h                       |   1 +
 include/linux/soc/qcom/qmi_tmd.h                   |  23 +
 19 files changed, 1223 insertions(+), 17 deletions(-)
---
base-commit: a87737435cfa134f9cdcc696ba3080759d04cf72
change-id: 20260609-qmi-tmd-383d30e1a60a

Best regards,
-- 
Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

