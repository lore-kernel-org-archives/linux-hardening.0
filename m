Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C55E3438BD
	for <linux-hardening@vger.kernel.org>; Fri,  3 Jul 2026 05:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783055039; cv=none; b=HRHhq9dCOL/dwTvlfgGJw8AqJM9tT4dg7dWRiuG0XPXy3nHHTM83X9zMFJ5H78+vyPhnmbV1y2StOwYzihK0BDluYGv/2bNDcpB+vc0pbEjg8UrIukfDAIlpXIN8v+D9ofl0+mM8dMr4KvvjBxQzVHjCM8Hp9TL+R3RTK3n9uL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783055039; c=relaxed/simple;
	bh=rVXcKV7+kz5ldKBXO/tHbbJCCqeIj4iVBlRaSUOippg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YvOqRne5ojJ+ELdOYSI2shgB/Sun4F6G5dq/pp2V918dP6SiWN+V8p4z2cBsfemR/qtHnXQ+cfwzZ4800rqgLeNVvQ8t+kOoD9zM3pMlX8suAxqqUaJJzxxd5ki+9m6hwSgXH8MfyzXztZaBdhjlEzH55v43EAKvLaG90KF4kEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kz9PX4ou; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D7jqo7Y8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kz9PX4ou";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D7jqo7Y8"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66342tQA2816746
	for <linux-hardening@vger.kernel.org>; Fri, 3 Jul 2026 05:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=NRBgE59QoTQV38VfgncqRJ
	YraRggkHBcu/Lnxj9AfME=; b=Kz9PX4ou0E2rzYJfU2YnTUQ9yhZCPBQNqiPR9p
	CEFvDPQWZjHGBADxTGLxRQqpJ0xB4605ahj3MquNKlSEoIwfn9qSQYiEM+G7JvH4
	ejAU3XxaBOVO0OhkPDQRMLKZJ5yyUZJlSyVZDopfFRao5i1BYVqOR4R9Zxt0SH3p
	rtN/n2J+N1PgsV0Kj5AxPnGAwhLc0MYB1TdeaODbQF+OU96HilRFmC0dg/PY2Zpg
	udjrrHUeXr69qolFQApg6uVlrvU826UNzdT3yUgozsVxmAc1+HzKSYXZzWd8PAhu
	hXwjqv7JeCyQlCRz0wdGOfuVoro8fyFJD8Qvx6a1kr9CqdGA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5qnpbjm8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 03 Jul 2026 05:03:44 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-37fb9d7b524so298542a91.3
        for <linux-hardening@vger.kernel.org>; Thu, 02 Jul 2026 22:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783055023; x=1783659823; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NRBgE59QoTQV38VfgncqRJYraRggkHBcu/Lnxj9AfME=;
        b=D7jqo7Y8b6FRz9ZPg9+iDqieoYuvmbG68XKkCUkwzlXth4Mi/deGtFmSiYvaDWOswk
         x/QPqGy+2cTgFIcGfqpKPWj3yT1HUAy4EaRUg4dIA5kR7KUOmXhRx1j0n8dldwMW46dM
         FV1vcXjjbR/BZgVsLUfCXJhJ17LETb10vHAkPsTRclB6J90aeTUW7i8uv9hM8yQ3gPmA
         FvoyFBQgYJAAqNlrN1eLeScGFwb5iU42147NbkmVw6XXg3hMQ/M/sTmJq+cN/AYJWmhA
         m3slKeVS938WdR8n9G5mQjq1B9HiX5L3hPs74hkpvF9d7x5tnFJe6L3eAChTwj5lGGud
         WpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783055023; x=1783659823;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NRBgE59QoTQV38VfgncqRJYraRggkHBcu/Lnxj9AfME=;
        b=HpiB+WfLHhze+2SgYk1eHx+VmcC+8g0jWsTkphqpvLgR+asdu0LSeu5p8IJXo7t18P
         9zLeyQTCStCHnKFIx0GkU62wrjHTmVNcavk5c5wi5LNlTl6j+Y1PcN0ojANUOJsmCD6/
         e4ByFXnG623t5SxN3cBtRbtJ3dKKDA4r6zBzPCMKvh8n8mok2RwgEgNXy+93Ed74LMM3
         AAV1JDy4p9RSrCAMES/REvzN4iOTIvlsBcCIYQXxW29ZMfsd/uPUddEUvSldwDo3cGIB
         +vtGjMURlDgK9KGH1qeuPdMWsdNZUBxzCR2xfx6lCrtKDSf/XRSk1xOfk4PVutp5HGiT
         Ya3g==
X-Forwarded-Encrypted: i=1; AHgh+RpPuuREf2gBB1SUBkcH05ejPCavXFCz5i9m7z0h/wQNqracdvG6bhUS1IaIOdtJ8KXHqs1HFiGcuBmiwB+iyCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpBq0kLNdTGYDyO0879S+49YNwewIUbJi+L4AnHJkmn4nqpA38
	/uEW+IOGkvW/QfFiKxiv6U8Z7LeGmHf/P6+KluLhLOH01SWqP+RzCEgkGL0P+TwZQ6ig3kTZLa/
	hukdghQZC73nIg+9HyyH79G8VVptTfav6Zd3Dnh4KIQYFuDtt6t4ipXf65QTdKFWjDO//A918m9
	h4pBs=
X-Gm-Gg: AfdE7cnHQGw6Rigoq5aCAmkFMjN+r/ZfzL1JDHJUmXuFBJ0zBM246kIPLCVGiGY067e
	0EspbEj7Vs0xE1NBys3Vnbk8aNOF9o/djAz/gHfYVeN3yL2GnBCJP8yv59RAmI89y8Pn08f5Odm
	nb+cuJBejsESHn4mKeqvd0bARC+YckZle0Eh/WqYPwE8d8fSCicAW/961b2Xtl6JjSNHZy+m4Lx
	McHGcepeitqaEGLvIGzjd7vHDVUXrCrEZ9jogZX12qW1ZGp29ftQ+NndfHU/JOapuJstiPStVHO
	mNKVgegJlsLJtJ6Lmhb290jC0WavbLS5JG0nl/kKXhXSfV39qPOLt9FoPsMlJioJuwvhR1GvQ0t
	koZOc3vK+u+jQCIcpKNr1oKFCMN+NHqzZf5Jun28Y
X-Received: by 2002:a17:90a:e7cd:b0:37f:464d:ea38 with SMTP id 98e67ed59e1d1-380ba70e00cmr8071253a91.0.1783055022919;
        Thu, 02 Jul 2026 22:03:42 -0700 (PDT)
X-Received: by 2002:a17:90a:e7cd:b0:37f:464d:ea38 with SMTP id 98e67ed59e1d1-380ba70e00cmr8071215a91.0.1783055022356;
        Thu, 02 Jul 2026 22:03:42 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbd2362sm16771941eec.20.2026.07.02.22.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 22:03:41 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Subject: [PATCH v4 00/10] Add support for Qualcomm remoteproc subsystem
 cooling
Date: Fri, 03 Jul 2026 10:33:03 +0530
Message-Id: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIdCR2oC/22Oyw6CMBBFf4V07TR9QAuu/A/jooECjZRKC42G8
 O8WXOjCzSTn5t6TWVHQ3uiAztmKvI4mGDcmyE8Zqns1dhpMkxgxwgQRpILJGphtA7zkDSeaKkE
 USu2H1615HqbrLXFvwuz86xBHuqcfB2WSFoVkDDNZSVlyoNCpxauI764fzMWFgKdFDbWzFqeDd
 lvkX8PvF5EDAVZRxdo2rwXP/8y3bXsDcQqP+ucAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783055015; l=5096;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=rVXcKV7+kz5ldKBXO/tHbbJCCqeIj4iVBlRaSUOippg=;
 b=R2N3EEztkFyImqucagAgpKp8NzRoJaFo2Sly8zMCuJ5DzVuyF7baMMSOJEkNjXzA4AoxyDzI0
 fvQigP25c7XALoF87dIZF4/9xQBqzwSOoTuPeWkBpRKZn6kC7pLZ0/f
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA0NSBTYWx0ZWRfX8iZgFyW+6n+i
 xX1zzadnuiabRHQvziY+tvu96FeOoTbMkJJD9VgoucYSz4UGFNgvFhCdHxmjFpButLmm/66MQCt
 ZeXrkl29m/KuQSZ+xavnxBxcR0UzPNw=
X-Authority-Analysis: v=2.4 cv=FoI1OWrq c=1 sm=1 tr=0 ts=6a4742b0 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=elwFi30hILXyiLWNHsYA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA0NSBTYWx0ZWRfX4caAwuAG7GGL
 B9hNMD9txAI0KqDa4jLSx+pnOZdjeRslSpvTMI3KKM8lVOz3I3D7kydjNbSQGq7GHaCbotgDH3G
 XnVK/TjXzZEerdkiVlGRVsVg5vcshc9db+DDP5twICsmdLXVAqxkndWSUfHgy3aQGn11wUuWz+/
 tYnG59bjUmQawFuTaZGh1XZb2VwfnrSMwt4Q9Q55+MVpQKQ299PRqEBx4LK3Ox6dtfaApg9i/wv
 vW6AoHyWwQ9cuXpCnEOCE9plmGXXb35J77vwFO+w5XYV+NxkUkHlbPR+WK6F79HtnTszYU2Gb/Y
 2Sfqwp5pWTbYudWbUHgs8R5aymO76wR5llBSL4fjBO6d4wa7xx4BfHti8jZ0TV2c0LazephRS0k
 MT2GnN/jDXE9iDp2yMtXnSSqXLGJm2nRoTUZcyI7YmArw7IT2UwAv7NGLkVOhW+bFwPcZNoTwEv
 SqNrDF2KHmKYmEZs8tA==
X-Proofpoint-ORIG-GUID: So9MGgMN6FMT9uxXHg0bRrFu1pavRFt0
X-Proofpoint-GUID: So9MGgMN6FMT9uxXHg0bRrFu1pavRFt0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030045

This series introduces Qualcomm Messaging Interface based Thermal
Mitigation Device (QMI TMD) support to control thermal mitigation
on remote subsystems such as the Modem and CDSP.

The QMI TMD is an interface that instructs a remote subsystem to adjust
the performance level of the devices it manages, reducing power consumption
in response to critically low battery charge, overcurrent alerts, or
overheating conditions.

The series is organized as follows:

 - Add a shared dt-bindings header mapping TMD device indices for use
   in DT cooling-maps, ensuring a consistent binding between the thermal
   zone and the QMI TMD driver.

 - Extend the remoteproc PAS binding with the optional #cooling-cells
   property to allow remoteproc nodes to be referenced as cooling devices.

 - Add QMI TMD support in the remoteproc PAS framework, hooking into
   the probe/unregister lifecycle to register and unregister cooling
   devices with the thermal framework.

 - Enable CDSP and Modem cooling on kodiak, lemans, talos, monaco and
   hamoa platforms using the new binding.

This work revives the earlier QMI cooling series by Casey Connolly [1],
with the following key differences:
 - Uses an id based API for cooling-device binding
 - Integrates QMI TMD directly into the remoteproc PAS framework and
   hooks into the probe/unregister lifecycle.
 - Removes unused code and cleans up macro names

This series depends on cooling device id support from Daniel Lezcano [2].

 [1] https://lore.kernel.org/linux-devicetree/20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org/
 [2] https://lore.kernel.org/all/20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com/

---
Changes in v4:
- Drop the tmd-names DT property.
- Move TMD instance id and tmd device name into PAS platform data.
- Add a shared dt-bindings header to define numeric constant for TMD id. 
- Add mutex documentation comments for get/set state callbacks.
- Link to v3: https://lore.kernel.org/r/20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com

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
      soc: qcom: Add QMI TMD support for remote thermal mitigation

Dipa Ramesh Mantre (1):
      arm64: dts: qcom: hamoa: Enable CDSP cooling

Gaurav Kohli (8):
      dt-bindings: firmware: qcom: tmd: add TMD device type constants
      dt-bindings: remoteproc: qcom,pas: add #cooling-cells property
      remoteproc: qcom: pas: add support for TMD thermal cooling devices
      remoteproc: qcom_q6v5_pas: enable QMI TMD cooling support
      arm64: dts: qcom: kodiak: Enable CDSP & Modem cooling
      arm64: dts: qcom: lemans: Enable CDSP cooling
      arm64: dts: qcom: talos: Enable CDSP cooling
      arm64: dts: qcom: monaco: Enable CDSP cooling

 .../bindings/remoteproc/qcom,pas-common.yaml       |  39 ++
 MAINTAINERS                                        |   7 +
 arch/arm64/boot/dts/qcom/hamoa.dtsi                |  63 +++
 arch/arm64/boot/dts/qcom/kodiak.dtsi               | 134 ++++-
 arch/arm64/boot/dts/qcom/lemans.dtsi               | 125 ++++-
 arch/arm64/boot/dts/qcom/monaco.dtsi               |  99 ++++
 .../boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts     |  17 +
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |  17 +
 .../dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts  |  17 +
 .../boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts |  17 +
 .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi    |  17 +
 .../boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi   |  16 +
 arch/arm64/boot/dts/qcom/talos.dtsi                |  19 +
 drivers/remoteproc/Kconfig                         |   1 +
 drivers/remoteproc/qcom_q6v5_pas.c                 | 120 ++++-
 drivers/soc/qcom/Kconfig                           |  10 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/qmi_tmd.c                         | 581 +++++++++++++++++++++
 include/dt-bindings/firmware/qcom,qmi-tmd.h        |  20 +
 include/linux/soc/qcom/qmi.h                       |   1 +
 include/linux/soc/qcom/qmi_tmd.h                   |  23 +
 21 files changed, 1327 insertions(+), 17 deletions(-)
---
base-commit: a87737435cfa134f9cdcc696ba3080759d04cf72
change-id: 20260609-qmi-tmd-383d30e1a60a

Best regards,
-- 
Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

