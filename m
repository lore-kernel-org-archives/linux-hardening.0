Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8414C281508;
	Wed, 27 Aug 2025 12:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756297563; cv=none; b=F8LVIon6i/HWn/rMIrp/i6C8xziA5Sd0ot0QmR15Ip2lWKzSk8lB9jy3JP6Uxm1yA/064T85P3xG8Q1Rm8S8xGZUGXwBVbWnvgqAJK6prZuEEhV46BnDGWImbZNsO6upmjXNFh1B4J9PaE96q3YvUegA0GaBr3j/J/V5kO9b6mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756297563; c=relaxed/simple;
	bh=RPCCll8qcV/RA5Nvz4A7AuiVRK/eIgpDS1FKjGCO9Gc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=YCL8nxm1zC9yWG4lHgHgn1z1Kd8+dgSO7+h4C8AlXfaLETsP1r3RAUBtfd0ehj1/Dx6l9hgGtEhNcnLtmitP9+4RlEcRS8iFQZM1QFxGAM6L/UhBHuqySfO20iiUICnFG75nsc9en5AwJW2Q33ZSrrgKe/aEmUGeKUCafF2hmI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=NIIfNNDq; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="NIIfNNDq"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R93WZ3003527;
	Wed, 27 Aug 2025 08:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=DQcVjXdsTkLAE9JTLvUnwJ2TFSd
	XWObOe6bTJvKwBko=; b=NIIfNNDqy4z+avAGPnw30TFwb7/2h6Kj0abQXxyH2Hr
	m8Oh/JgRuKcEobYk3gi0jPXnYbAE7hZKelx1n5Czd+EmWmBMDcAcUSqSfUhvt3k0
	qcS/iWhmhcHUHjP9T7fP6OwUHd5dqupq7xgGUWcCyfSqsDzw7nJQPwEL6B/abV+y
	ZZnz1WAggL+uBw5E9CW5d+EPOGkGYMtemj+UmPNHOObZhUjypO3cnUR43VEht++n
	w1mYyuOfe+tHZRzGMK6ZRu7NeiESAlkx+o1zlDKQzCK+TbOfh4GpKmyU6n1WNjJI
	FUrhA2wXEVMbvRjDhp8lf6WEfj1ApmNHi4i9AB79YKA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48sqasu25v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 08:25:37 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57RCPaI7052978
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 27 Aug 2025 08:25:36 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 27 Aug
 2025 08:25:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 27 Aug 2025 08:25:36 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.69] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57RCPHog002921;
	Wed, 27 Aug 2025 08:25:20 -0400
From: Jorge Marques <jorge.marques@analog.com>
Subject: [PATCH v8 0/2] Add ADI I3C Controller
Date: Wed, 27 Aug 2025 14:25:16 +0200
Message-ID: <20250827-adi-i3c-master-v8-0-0a7c78e58bd4@analog.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACz5rmgC/3XSwU7DMAwG4FeZciYoSRPH5cR7IA5u4m6R2DrSU
 oGmvjtZQVpRxvG39P2R5VzEyDnxKJ52F5F5TmMaTiXgw06EA532LFMsWRhlnAJlJcUkUxPkkca
 JszTktMXgMFgvCjpn7tPnWvjyWvIhjdOQv9b+WV+n/1bNWiqpLCKjitSH7plO9DbsH8NwFNeu2
 Ww9VN4Uz4BdSxQNNKryzcZrrHyzetBeEYSudZW3G2/q923xDVog3QNEx5V3N++1q7wrPmBrGxs
 66u942HpfeSgeAqDn6HXHsfL+5vHO/r743hvlW2UA2r9++Tlu5veP8kmm3wsvyzduOfS/QgIAA
 A==
X-Change-ID: 20250604-adi-i3c-master-2a5148c58c47
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Frank Li
	<Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook
	<kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC: <linux-i3c@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gastmaier@gmail.com>,
        <linux-hardening@vger.kernel.org>,
        Jorge Marques <jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756297517; l=5830;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=RPCCll8qcV/RA5Nvz4A7AuiVRK/eIgpDS1FKjGCO9Gc=;
 b=Ml1voom0Pj8ARXYIjYB6Nzw/VuevOt86j0jL+8vIbKH75R7XoEp5GbTIG7FB8toei/m1z7sqM
 Loi5A+UQEREC6gY/IPlUAE5ZF/00xW4XEQQ/vTYCtS5Dgaab8V/8cnN
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDAwMCBTYWx0ZWRfX7JESUA5erPI0
 8zQh+GqGE1rZsKWY7JVKYtuFOFVKAoKntESfl4u0kI56CN7qABMota6EYbHazDWykt4G5gwGtqJ
 z8ppPCNbLXVXE941TNByuESwwraBQQP4aSn4r2weP/rJR5LVU0gI8+f2x/beWYLbQGMpq7SNAnQ
 nAXVc/D9dxZrCvSZR9Q7WBtp0NsjkAgkn6uWB/c7YGNdCRDF5mXsz+Pglg4vsK5vzQV1k6eEcZO
 HPb6M1ojHfAIz843fKDqlp3nW/8N+NpUhBi2iG6dYWJUT2zNWmjfsp3mrPSDjfgCOdHQ3ZxZT/Q
 FNQIUPBkQmZ13vc+qy++SrYxfwn1ycoe1BAm8JheICBg074Vmby61Qtghq64ksHYZ6BTXHsAVn5
 anSXm4PV
X-Authority-Analysis: v=2.4 cv=Z4bsHGRA c=1 sm=1 tr=0 ts=68aef942 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=wI1k2SEZAAAA:8 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=9gqjl8QYTY5QUUvjqJMA:9 a=QEXdDO2ut3YA:10 a=2-210J_X17oA:10
 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-ORIG-GUID: Z8sPG4vgUUQPmgEqpqx6Z-l5Jmq7bQJP
X-Proofpoint-GUID: Z8sPG4vgUUQPmgEqpqx6Z-l5Jmq7bQJP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508270000

I3C Controller is subset of the I3C-basic specification to interface
peripherals through I3C and I2C. The controller RTL is FPGA
synthesizable and documentation is provided at
https://analogdevicesinc.github.io/hdl/library/i3c_controller

The main target for the I3C Controller IP is low-cost FPGAs.
In this version the driver supports IBI (only the MDB), I3C and I2C
transfers.

The IP Core is versioned following ADI's open source HDL guidelines
for devicetree bindings and drivers described at
https://analogdevicesinc.github.io/hdl/user_guide/contributing.html#devicetree-bindings-drivers
in summary, follows Semantic Versioning 2.0.0, with the dt-binding suffixed
by -v<major>.

If necessary, the contents of
https://analogdevicesinc.github.io/hdl/user_guide/contributing.html#devicetree-bindings-drivers
can be replicated to a file in a different series, similar to AMD Xilinx
at Documentation/devicetree/bindings/xilinx.txt, but as adi.txt or
similar.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
Changes in v8:
- Remove depends
  https://lore.kernel.org/linux-i3c/20250622-i3c-writesl-readsl-v2-0-2afd34ec6306@analog.com/T/#t
  already in v6.17-rc1.
Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml:
- Remove pipe from descriptions
- Link to v7: https://lore.kernel.org/r/20250818-adi-i3c-master-v7-0-f7207902669d@analog.com

Changes in v7:
- Edit cover linking guidelines to ADI IP Core versioning.
Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml:
- Extend second clock description to explain relation to synthesized topology.
- Link to v6: https://lore.kernel.org/r/20250717-adi-i3c-master-v6-0-6c687ed71bed@analog.com

Changes in v6:
- Format 0x05C undercase
- Link to v5: https://lore.kernel.org/r/20250715-adi-i3c-master-v5-0-c89434cbaf5e@analog.com

Changes in v5:
Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml:
- Use semantic versioning major field for dt-binding compatible, with
  the format adi,<ip-name>-v<major>

adi-i3c-master.c:
- Rename MAX_DEVS to ADI_MAX_DEVS
- Encapsulate REG_CMD_FIFO_0_DEV_ADDR var
- Reorder struct adi_i3c_i2c_dev_data fields
- Start addr at 0 instead of 8 at adi_i3c_master_get_rr_slot
- Minor rework on adi_i3c_master_handle_ibi to most logic out of the
  lock. Even if length is 0 (BCR[2]=0), the mdb field is extracted and
  written to the slot buffer. Since the length is 0, the written data
  doesn't matter.
  In a future update with additional bytes support (e.g., bits 31-23),
  len would be incremented and an IBI FIFO would be read.
- Version check against first stable release, major v1.
  Driver+RTL features updates affect the minor field, therefore check
  for major == 1.
- Link to v4: https://lore.kernel.org/r/20250626-adi-i3c-master-v4-0-3846a1f66d5e@analog.com

Changes in v4:
Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml:
- Add -1.00.a suffix where missing
- Extend clocks descriptions
- Add minItems to clock-names, to match clocks
- Use header in example

adi-i3c-master.c:
- Regmap:
  - Add new controller info registers (dyn_addr, dcr, bcr, pid)
  - Always decreasing fields
  - Add line break between registers
  - Reformat REG_DEV_CHAR_BSCR_IBI to use easier to read FIELD_GET,
    FIELD_PREP
- Read controller info from regmap with explanation comment
- Use linux/fpga/adi-axi-common.h macros
- Use __counter_by macro on ncmds
- Use __free macro
- Use new i3c_writel_fifo and i3c_readl_fifo macros
- Rename bytes to buf when nbytes is present
- Use scoped_guard instead of spin_lock, spin_unlock
- Reformat loops to read fifo status, use while single line alternative
- Drop adi_i3c_master.max_devs, use MAX_DEVS directly
- Use devm_clk_bulk_get_all_enabled, dropping clock name match (CHECK_DTB does it)
- Init spin_lock
- Init list head
- Link to v3: https://lore.kernel.org/r/20250618-adi-i3c-master-v3-0-e66170a6cb95@analog.com

Changes in v3:
Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml:
- Small reworking of the description
- Add -1.00.a suffix to compatible

adi-i3c-master.c:
- Misspelling
- Remove REG_CMD_FIFO_0_LEN_MAX since it is a HDL parameter
- Use adapter timeout value for I2C transfers, as in
  https://lore.kernel.org/linux-i3c/aEBd%2FFIKADYr%2F631@lizhi-Precision-Tower-5810/T/#t

- Link to v2: https://lore.kernel.org/r/20250606-adi-i3c-master-v2-0-e68b9aad2630@analog.com

Changes in v2:
Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml:
- Move allof
- Rename clocks to axi, i3c

adi-i3c-master.c:
- Update license year
- Rework regmap to use FIELD_GET, FIELD_PREP
- Reformat regmap to have FIELDS after REG, prefixed by reg name.
- Add overflow safeguards to cmd, tx fifos
- Fix macro related macros (mostly erroneous `| ~BITMASK`
- Use guard macros, remove goto.
- Simplify daa logic
- Replace devm_clk_get with devm_clk_get_enabled
- Solve 64bit->32bit warnings on x86_64 systems by casting to u32
- Immediate clear irq request flags, then handle it.

- Link to v1: https://lore.kernel.org/r/20250604-adi-i3c-master-v1-0-0488e80dafcb@analog.com

---
Jorge Marques (2):
      dt-bindings: i3c: Add adi-i3c-master
      i3c: master: Add driver for Analog Devices I3C Controller IP

 .../devicetree/bindings/i3c/adi,i3c-master.yaml    |   72 ++
 MAINTAINERS                                        |    6 +
 drivers/i3c/master/Kconfig                         |   11 +
 drivers/i3c/master/Makefile                        |    1 +
 drivers/i3c/master/adi-i3c-master.c                | 1019 ++++++++++++++++++++
 5 files changed, 1109 insertions(+)
---
base-commit: e21fcdd9fcc6ef2e2898d51fbc0e6c79427068e6
change-id: 20250604-adi-i3c-master-2a5148c58c47

Best regards,
-- 
Jorge Marques <jorge.marques@analog.com>

