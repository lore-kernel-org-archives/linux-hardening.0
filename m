Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D1534F47E;
	Wed, 27 Aug 2025 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302749; cv=none; b=VhGp7ai23QLttALfWWHmAu0t/1vpohpflx4wlowpfpWRDt/0TKp7FMbebIjhRBfMmiYN8QT97k5VG1A/hZFMwr+zpJq1cD5QEis0rduGCxsKkHUeqOvbnavC5bJEItFqmw9dLgU/n1tI81ihO7ukzdAxCThjigtHgdLD+FyNj7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302749; c=relaxed/simple;
	bh=l1b2oYf7bI8/K/LR7wVgwK4gwobnm0eTFGSfXZlVVaA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=EwinUSHj48bhbyg5SQa0gJ8Nu6JckPh6TyKwYCNrxrFITTfGY3/sCriCih2cIprDgCD0Hj9N75//bnSjsZwXho+VdstPDqZQtwM/IbDs29YH3u1EYjFFxI+tuOjo4zZ88VC3QVBs6vjrHff7zvmTXbsAaBedjhMlUQmS/lWscLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DnrVLBYf; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DnrVLBYf"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RDFf3Q003527;
	Wed, 27 Aug 2025 09:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=g+5AtPXuvaoz16o655Sf+Dg2fM/
	il6GJk2/0kUZSvUQ=; b=DnrVLBYf/C+WoM7ls/0XwBXIeThnuQAVDbreZhpFZ1O
	eLI5MR2QcTPClskuCHeBRSOw2MQFwUW5TdWYwOuKL/DNJNynQWqrCQRl4QlVFsdD
	wgro9xC8h4B4kTFlx6dSBqslQ/QsDZENht1h9w90l4vgvxfKvKcZIrr+TMYFDjAf
	BBa3TOOXeVh/u/6PFGUOceKt58Af+EtVK6/JXH/g61woFFY+tvOYlhrVug73gFzO
	9VG98YDL74gJyS4DVKRSQd4cnVTZlvIll9TizG6dJ6DXu6jcW2+RNNs02DUzRtto
	ZytDuDaa89uPiCszbmiHMCEXR9++/lfDFlUwQ6tH55g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48sqasugtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 09:52:15 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57RDqEjx058159
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 27 Aug 2025 09:52:14 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 27 Aug 2025 09:52:13 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 27 Aug 2025 09:52:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 27 Aug 2025 09:52:13 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.69])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57RDpw2Q006762;
	Wed, 27 Aug 2025 09:52:01 -0400
From: Jorge Marques <jorge.marques@analog.com>
Subject: [PATCH v9 0/2] Add ADI I3C Controller
Date: Wed, 27 Aug 2025 15:51:57 +0200
Message-ID: <20250827-adi-i3c-master-v9-0-04413925abe1@analog.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH0Nr2gC/3XSwU7DMAwG4FeZciYoSRPH5cR7IA5u4m6RWDvaU
 oGmvjtpQVpRxtGWvt+K8l/FyEPiUTwdrmLgOY2p7/JQPxxEOFF3ZJlinoVRxilQVlJMMlVBnmm
 ceJCGnLYYHAbrRUaXgdv0uQW+vOb5lMapH762/Fmv23+jZi2VVBaRUUVqQ/NMHb31x8fQn8WaN
 Zu9h8Kb7BmwqYmigUoVvtp5jYWvNg/aK4LQ1K7wdudNed9mX6EF0i1AdFx4d/Neu8K77APWtrK
 hofaOh733hYfsIQB6jl43HAvvbx7vvN9n33qjfK0MQF163HlT3sf1/8gHj+ywifaPX37KMfD7R
 y7Z9NuQZfkGg6YfXIICAAA=
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
        Jorge Marques <jorge.marques@analog.com>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756302718; l=6044;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=l1b2oYf7bI8/K/LR7wVgwK4gwobnm0eTFGSfXZlVVaA=;
 b=EdAFgsKLY3kyjPTnMukQCTffhiHI9sfHVdW2nzL0TuSqiOcyySui+6nKMZDUy9VTRFjanGeE2
 V9PZgq1miJgCs+J+BMXrNU27niLNBUxMi0489C5bXFDly09mXn/icFv
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDAwMCBTYWx0ZWRfXwLPdam7KMmnn
 NVDn44/G9YnjsoV+8fAWnc6YCFn8mLVjoNqKF1E/u++HGF960ancxQnJd5gtqueSEVrmSP9hvD8
 Kx2t7GSxv9YAnvggZaM3RsR39fVJ7CjWECOQtrEoXnbEFcjOj9LAlqidHUwhvbmGJeuF/oZnD7L
 kkKKmH3KiLgF56zbTAfeNUcuhrDsKVbO1xeLNopVOQpBUtL6RDxtrQtxMsfBQZCSmggXaqqvHiK
 B2MOnKDmT13P+jez9Kmm3gwFcPpYdVEaYLlNjxoJr6UJ5oK4zqi4T6nMvKqwd0zBU0hQnZ17UO3
 Gk3I2vlC8tH7AmHVFelI8Jedi4cKnOYpI36iRkwIzqMkdwRABBAx6ER6jC1/+xahJPwtcbiPlh+
 ivITeF3/
X-Authority-Analysis: v=2.4 cv=Z4bsHGRA c=1 sm=1 tr=0 ts=68af0d8f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=wI1k2SEZAAAA:8 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=9gqjl8QYTY5QUUvjqJMA:9 a=QEXdDO2ut3YA:10 a=2-210J_X17oA:10
 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-ORIG-GUID: PT89ZrRHSrNrmXLza5dDXBTKf291dCZC
X-Proofpoint-GUID: PT89ZrRHSrNrmXLza5dDXBTKf291dCZC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 malwarescore=0 bulkscore=0 adultscore=0
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
Changes in v9:
- Collected trailers manually from v7, since mentioned content in the
  thread messed b4 capability
- Link to v8: https://lore.kernel.org/r/20250827-adi-i3c-master-v8-0-0a7c78e58bd4@analog.com

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

