Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31278258EE8;
	Mon, 18 Aug 2025 11:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755517922; cv=none; b=SgA4HfE8VX/qM98pG1RXcQsWuuhO1rNg/OkQZa9xJK0behrNDWMSIYwBmHPzgvougpBtJr8xP7bX57rZHPOcld5Q1ymTVwAUjdrzEJENcGAFkVJ46mxgmzE6cswkPeSCQ3CY16KPb31cWJs+k+nZ02SeKwPgMNA3nJS8ge5WS2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755517922; c=relaxed/simple;
	bh=zroE3ZRBcvTHvfTeomTUce9CH8qHiYvB5mEwVo14FDY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=NJH+VNTnyCaeYaaUkRr88eqWSwxNem/HvF1CuE0DQsrsv0tN8gFroVyv4PSUa4vWxG+hhwSc2QRUpYNNhGdr5hHf8rZnTXu6JH4j2o921W1FzdCO7ZswjLWKnErs2o4L10rWURAEEHWLvKobSmggDmxfYG4e5OD30QMGsgT7cEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=C6xNShL7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="C6xNShL7"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IBlw3d025526;
	Mon, 18 Aug 2025 07:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=UVel09Sb15hnFFOi4la6QUq0xmk
	S12lWEQvBOxj0434=; b=C6xNShL7L37/S05zi83iNWxkEiUNhhakX4ZT4wZcVf1
	82Ddy0JkMhVJojTVfJVXiGe3+M9jPxa8WZzSzpMbGjOKfaNSAk4Y/GNckWkYfen7
	Ggy3u7lfxeJIAiAUOxh7rWHpUClR5Byv93J9GTOsGpuXnsF0Sp6OxVDiCa3xkrof
	OHYYzKTBoNeIRy6tLWjgycJZYSe6sAVB7rZaIfTm9Wt22si8TNqBBCyKMvmtyVZF
	i5dLdnjqZ1GtNSNLPjcB9CwL4Wt+fk5lrWIqelACLtp2Kkw+qSy2fYGMuQhFP+Jb
	q1f5waKmKnHds9QkKKFgTJK3ojJE33bcHI6VVWB8xqw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48kn0supy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 07:51:31 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 57IBpUrx002220
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Aug 2025 07:51:30 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 18 Aug
 2025 07:51:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 18 Aug 2025 07:51:30 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.53])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57IBpIJS022575;
	Mon, 18 Aug 2025 07:51:20 -0400
From: Jorge Marques <jorge.marques@analog.com>
Subject: [PATCH v7 0/2] Add ADI I3C Controller
Date: Mon, 18 Aug 2025 13:51:12 +0200
Message-ID: <20250818-adi-i3c-master-v7-0-f7207902669d@analog.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALATo2gC/3XR3UrEMBAF4FdZcm0kv5N0EfE9xItJMt0N2K22t
 SrLvrtpV7ASvQoT+p22c85spCHTyPa7MxtozmPuT2VwNzsWj3g6EM+pzEwJZQUIwzFlnnXkHY4
 TDVyhlcZH66NxrKCXgdr8sQY+PpX5mMepHz7X/Fkut/9GzZILLoz35EXCNoYHPOFzf7iNfceWr
 FltPVReFU/gQ4OYFGhReb3x0lderx6kEwgxNLbyZuNV/X5TvPYGULYAyVLl7Y930lbeFh99Y7S
 JAds/PGy9qzwUDxG8o+RkoPTLX67lDPT6Vkqerg2xjsYR15L3u7vvH1Nr6PuwPPTMB8JUjnW5C
 tukDcWyW9iE3y/FBxyJl6HL035nZQPaeR28A1StaTRqwigIGwqonIwBvGiwfNblC1KeO/KDAgA
 A
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755517878; l=5873;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=zroE3ZRBcvTHvfTeomTUce9CH8qHiYvB5mEwVo14FDY=;
 b=ksB28LpgmtRqkBom2wNuTsepJjgUZLUjcTbmvfGWokqNSRsawuuBJoNEbJD7oHA6R09F5GoHp
 nimxI9j6jYyD1Xzpqanw4eyMrIFBp1YG52cb7deue9bN5OrJPRboT3Y
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: NcnSr65xXA3uWgKSxIpuOD0KbHGtv6KY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE3MDE5OSBTYWx0ZWRfXwo2CnGJrLZZ9
 Y2F7zzLb4Kb4cSCfruQhhrt18gOq4ZVK3e8IB7zn9xSxAcgdnPa0yhSy6XVc5/mZmP8UtaLpVwK
 I/k8Vu/ykuSFwAwtZfrl9PTHrCuqIhZ0EiuQSSSi96gJsjkkMK3uoZxURKqSK5JPhnXgSiZqoOf
 56InsKlGfwwdwmTnR0vGyTTtR+cI7SWznPOK+Pww0rMlZ/46eJCjtdwzrf3v3JDP/XbgnM/Eo58
 k29LmTAesIuW84k3+IsHbEwdX372NDVvY64neCey1Mvn+4rpVMQlaxmqlYCcHyYeklBcUcaJRVR
 36/+HrPZkaLDipLE0ldyfT8JH1o++NkcMHbcxZD1a+B78jkfQ9lp69jPBBI509mGl/Qkw0pO+eP
 t28DSHlO
X-Authority-Analysis: v=2.4 cv=T6qMT+KQ c=1 sm=1 tr=0 ts=68a313c3 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=wI1k2SEZAAAA:8 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=ze3ezcZjs5cA45okC0AA:9 a=QEXdDO2ut3YA:10 a=2-210J_X17oA:10
 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-ORIG-GUID: NcnSr65xXA3uWgKSxIpuOD0KbHGtv6KY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508170199

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

Depends on https://lore.kernel.org/linux-i3c/20250622-i3c-writesl-readsl-v2-0-2afd34ec6306@analog.com/T/#t

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
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
base-commit: 51963783b876a2f493a3eac0ea9eba271cb6809a
change-id: 20250604-adi-i3c-master-2a5148c58c47
prerequisite-message-id: <20250622-i3c-writesl-readsl-v2-0-2afd34ec6306@analog.com>
prerequisite-patch-id: 5443f14ca82fc08593960fafdb43488cce56f7d9
prerequisite-patch-id: 647084f5fe09f4887f633b0b02b306912a156672
prerequisite-patch-id: 6f582bb2ef1aafb66f26c515a19d5efa06ab8968

Best regards,
-- 
Jorge Marques <jorge.marques@analog.com>

