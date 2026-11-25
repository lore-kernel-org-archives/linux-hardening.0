Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.132.180.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607390;
	b=4tRb+B+QhdYDsEHVY3t6mNAW7S61ON+D416TQEcKF5DybUMWmla5BqPgsV1MOdwHcc4x
	 DkCCHoO5F8wDPRaFmrqZ/mjE+7rftzSfN3tbmLul2SEVXIwyJ3YeDoYO9mALacRlb9QGa
	 Tm3z5gUXo3OeIgLvUTc6XCd8RtsYfz6ZbF1sllepyjaa0Fd63uCWA8VcSaINUyrVliDp1
	 BfQ9FosP5tbrVyr1qTYv8CHhfd29ooEYNtfLty1yFE4CxuopnL/6eTOuITMQgK+JZPqNp
	 v6wF5xpC/0MQCSxCx2C9ujYGBEpEGPi4V3czEOdv7u7gaHOe3z8eUtuz+JEmJ8W6cLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607390;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Originating-IP:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID;
	bh=BNg1/lQltaWN4F2ek0a75m31Z2iZwVrE8xmhv5htzVM=;
	b=lH2nBEHCrNowZufgRu7rL7UrhVwnreUJnvPmZSqpPQ35fQTpGXZ0SaeKcGMrPD59Uo8W
	 RUULJVvwsT9JNuI0DZDerzxlq3fPG+lHAq95Xr7eH/o/TewNYynThA/8nBhdeSqdytYAD
	 LzrLKdIVy0p6s7Abrujt7sWi8JpMh32TJvU6sSFPSyyBSz4eeq4VPP2eTQ+Jx91ipk+14
	 axW/ygCtGsmIkO080aGTsGVzgeap8Vciv7OyYY2jCzAgfsG7338E/GGAwnGu1xojaE7b/
	 xUgzp6NfxUqa+ianhKKSarHa1taRVb/TGJaWsrE0xIMiYvOeXS0vo+ahHv77gRr0j4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=imgtec.com;
	spf=pass smtp.mailfrom=imgtec.com;
	dkim=pass header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=KzC0bwrI;
	arc=none smtp.remote-ip=185.132.180.163
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385CD606A6A5;
	Wed, 25 Nov 2026 11:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 385CD606A6A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=KzC0bwrI
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id 6AP5rCg31746101;
	Wed, 25 Nov 2026 11:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=dk201812; bh=BNg1/lQltaWN4F2ek0a75m3
	1Z2iZwVrE8xmhv5htzVM=; b=KzC0bwrIz9HTecFeN5Vaj9lfRBa+crbScDqC8Fh
	S1sQLsF4hQHUdGCLwKNSP53CThHklmVJl10jvKAUEn3akPnXpnuOGiF8MHqJPnF6
	20B8A+BzaX4lnJVTxt5A7FJuzeAAVr04YZ5WbMNob7kQEeTaiFmKLVcaFlElFd7v
	7pjIschv3BRFwdP+2PJbEb+fimCt8Ri8SAz+laxFHWy8GxCjAEI2RRSebMo4kpJ+
	KZg5nTyyVkV2fRivD7IFe4FK3MGLzlmhdIHyeD+8cfR0LYzk9BsYGh7vFGsZR3lw
	/ylaa5XzABNHqChNm4x8BVbb8jqf0CC2aaAY0/1Q00qbN7A==
Received: from hhmail01.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4j3491kdya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT key_exchange=secp384r1);
	Wed, 25 Nov 2026 11:48:56 +0000 (GMT)
Received: from [127.0.1.1] (172.25.10.203) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 25 Nov
 2026 11:48:53 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Subject: [PATCH 0/6] drm/imagination: Commonize firmware segment loading
Date: Wed, 25 Nov 2026 13:48:28 +0200
Message-ID: <20261125-b4-commonize-fw-segment-loading-v1-0-69657fa52ac3@imgtec.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA3LBmsC/yXNTQ7CIBBA4as0s3YSIdYSr2JctDDgGBkMU39i0
 7uLuvw27y2gVJkUDt0ClR6sXKTBbDrw51ESIYdmsFu7N8b2OO3Ql5yL8JswPlEpZZIZr2UMLAm
 Nc8ENMfbkB2iVW6XIr9/hePpb79OF/PzNwrp+AFQzKC2DAAAA
X-Change-ID: 20261125-b4-commonize-fw-segment-loading-188d87ff5ec7
To: Alessio Belle <alessio.belle@imgtec.com>,
        Luigi Santivetti
	<luigi.santivetti@imgtec.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Paul Walmsley <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva"
	<gustavoars@kernel.org>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-hardening@vger.kernel.org>,
        Alexandru Dadu
	<alexandru.dadu@imgtec.com>,
        Matt Coster <opensource@mtcoster.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795607333; l=1716;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=BlYhnr2AbLRA9bM3wpBkSFqOkmBf0O8hmLP0jwOwLhI=;
 b=WhjdN6/yrTgVu3uKC/hzIO7XuHQrG1D9Xpeqx6pv+jxZNpQcnFSjUZj2ksFiF24ZxLiYGuoeN
 /uLywZWq6tBCBZsUgvFszSH18fLrGtE1v87he7JF8HtT8fbxnWPefAI
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0NiBTYWx0ZWRfX07gr3Wo7InVH
 F5Y46zROpjEwT+EXmC54D28DHeQYGYb47Vza1s2uvS9k73PcBaoYBVTuGddGdS0kEGZxXk6YL+F
 sqki+UUzGx+lipOcyWDwTuDxnMSjioOO8T/8it17Sk9XtXwlV3s6+agT681FdYUDcuZN3sr7g3l
 HshpTzZd/ajd+1apcdqakpu8WjFqVRDOAd5H3YXX1sh7ya6e1lzWt0nVcPE7cwkjv8iFxAf9JFJ
 YEKHvJQNcvaXV3R7SP0gHDFjbiqLexRS+MkAN+dNLcKbyoa+ylFPhkhHZAT2T7+bkcR8sAdwt7G
 NlE5tiS30BzlatkvGZHd03X4HcuWSztSirvrtGHKBeuv+kmcyuAzPV/MisuqvSC9JHQTumgsMIG
 L/jxLj78n1SI6PzBi9kfHr/rsPJSKL058wUiTr2KAfdET7PkCXVVjIALYfy7663VMqgGsg3IcVl
 l2lxHgZFWNCYQ3jewSg==
X-Authority-Analysis: v=2.4 cv=OaENnRTY c=1 sm=1 tr=0 ts=6b06cb28 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=4EFqt8Tv61wA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=zY_IWKfkgnbRkjL7nlAA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0NiBTYWx0ZWRfX5LKZSrRWQUnt
 v2RoR5XGV55dLJN5DwOHmslIJIS9YH5lo727Tmx2By0PiHECpx5AK3qf1WGEP4IR6lgD5dfDY1r
 +/O/E3GO6Ypi9sNJzyD0UeHshexsg6o=
X-Proofpoint-GUID: An1FyWGQG2oEilwS4wE5EtWhet2VnNj-
X-Proofpoint-ORIG-GUID: An1FyWGQG2oEilwS4wE5EtWhet2VnNj-

- Clean up and refactor the PowerVR firmware-loading path.
- Remove duplications in segment-loading logic and removes the firmware 
  blob after processing.
- Save firmware metadata at runtime in a kernel-internal format.
- Fix the sizes of firmware header fields.
- Remove duplicate GPU-address helper function.
- Implement a direct lookup when configureing the segment MMU.

Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
Alessio Belle (1):
      drm/imagination: Avoid loop in configure_seg_mmu()

Matt Coster (5):
      drm/imagination: Remove get_fw_obj_gpu_addr()
      drm/imagination: Fix size of FW header members
      drm/imagination: Save metadata from firmware
      drm/imagination: Release firmware after init
      drm/imagination: Generalize FW segment loading

 drivers/gpu/drm/imagination/Makefile       |   1 +
 drivers/gpu/drm/imagination/pvr_device.c   |  61 ++--
 drivers/gpu/drm/imagination/pvr_device.h   |  15 -
 drivers/gpu/drm/imagination/pvr_fw.c       | 534 ++++++++---------------------
 drivers/gpu/drm/imagination/pvr_fw.h       | 196 +++++++----
 drivers/gpu/drm/imagination/pvr_fw_info.c  | 339 ++++++++++++++++++
 drivers/gpu/drm/imagination/pvr_fw_info.h  |  22 +-
 drivers/gpu/drm/imagination/pvr_fw_meta.c  | 124 +++----
 drivers/gpu/drm/imagination/pvr_fw_mips.c  |  50 +--
 drivers/gpu/drm/imagination/pvr_fw_riscv.c |  44 ++-
 drivers/gpu/drm/imagination/pvr_fw_util.c  |  17 +-
 11 files changed, 766 insertions(+), 637 deletions(-)
---
base-commit: c88084027d0e922dd925b96e5a0d184ba04a8f43
change-id: 20261125-b4-commonize-fw-segment-loading-188d87ff5ec7

Best regards,
--  
Alexandru Dadu <alexandru.dadu@imgtec.com>

