Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.207.212.86
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607378;
	b=UKVN+VkvkxqsMv7mB/87vKWvZgVcths23PPiUaQLSU76PxnRwxIuHPX2CwsEdbeSplTm
	 zebYGpjG5m4HehlOUEIA5AC2gzAGjOZ0s7r0SwLnl01Jm8CYRno+MhyXCjyGcLZBlTqBb
	 ECvy8gIKWlDmenOES4m6voYYCZAGRchh5g+ocjAqzcG5z5iV1vYOpBIj5QtUxmjarXk+P
	 8nMJ7b2yBt8yxUaBOgybTAKFpo5NZ2Gmr13/qeobaS/up1cjh9XFm/huIW69hbgzLJz1a
	 SwVP+C1pVHA+8CtbFgGLsTuJxCoqK4xeQ1F6CkRn1Hxd/ZHVXN7fo8hanybpRYYXYww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607378;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Originating-IP:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID;
	bh=ce5JvCWjxkbLgLwIua+N1v3pyOdandUPeaQMGVLon3o=;
	b=viqWXyVS7KCgVSL7c2uLrNHo7Fj8RdfxM2QEsimjZ5FgGferTxwsvyHqxASOYQCQ7Zop
	 VkH7ur+QnX3VeIQn/sQi/OqpJAkYWpq7JgG9qWXppSc+ApcfJU1QCi63WAYzDdViY/CR7
	 d/iH7tii5RRQCu/B22q2HRSSmW0yZSqA+OOZ3E+TvEPuBok8tbfMsiE7zu7gyopKHjj0v
	 cjvdE9dFLuAurcUVHxLb3+1i6AAYCtinSa0PSl94KQyfBKuPadHVhS4x48kEcDgv+I2nB
	 5srqMczBweTcTKpZwR1t31EFRIimGbe6T1Fqvr6iq9blnRH14HMOUXrDo8UTZ2yJ0bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=imgtec.com;
	spf=pass smtp.mailfrom=imgtec.com;
	dkim=pass header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=kbC85YzK;
	arc=none smtp.remote-ip=91.207.212.86
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D32606A692;
	Wed, 25 Nov 2026 11:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0D32606A692
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=kbC85YzK
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id 6AP79Js51860080;
	Wed, 25 Nov 2026 11:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=c
	e5JvCWjxkbLgLwIua+N1v3pyOdandUPeaQMGVLon3o=; b=kbC85YzKOQxmNyzWj
	s/Uhoeq9zF5k5wIaLt/ppbiuP1sl6lLeF/YDkPOXZRRPjP1itopWWahDJztxwkMH
	I59ToNLnpeND95Qsa0IddolBiDpI7LjvkUmSCo2qTdZdjKkSdDApdhDxV6Vi9ltY
	WYQsQro1gzBIXLgeoMWQ6YPmCJ9bgQDJ1tM5tqisW7xIwaOBSgu5P6boUw3vjuEE
	kIfuP2+ej9wYL+lqMzv+jP/6dBgHbKFUSLH1LAC1ldfF+RsLjV+TLCoK8KlGqX/1
	DlMGfLklYddB4G6/02doCYu5IxxM1n6C5WhK5LEYUJ4ZennYXByPBZBPZ0ZAxmKH
	ZsyuQ==
Received: from hhmail01.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4j32ev31p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT key_exchange=secp384r1);
	Wed, 25 Nov 2026 11:48:57 +0000 (GMT)
Received: from [127.0.1.1] (172.25.10.203) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 25 Nov
 2026 11:48:55 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Wed, 25 Nov 2026 13:48:29 +0200
Subject: [PATCH 1/6] drm/imagination: Remove get_fw_obj_gpu_addr()
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
Message-ID: <20261125-b4-commonize-fw-segment-loading-v1-1-69657fa52ac3@imgtec.com>
References: <20261125-b4-commonize-fw-segment-loading-v1-0-69657fa52ac3@imgtec.com>
In-Reply-To: <20261125-b4-commonize-fw-segment-loading-v1-0-69657fa52ac3@imgtec.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795607333; l=1492;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=8iH000nnA3gLzcQQjDaJ6UCxN6ehPOwjRAQyE4EjKEM=;
 b=mN7vFwAc21jQWae0s5+z1O4jGGuMlVKt5NwFqkeK9ZHApPa9JFMMcAKeePTGRH5u/R5wRwEYK
 TQ+n+so7yXwD3YNMEkw8ngStgPlwfWIdzHUJWujgZfiapBQ/620s8Ch
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0NiBTYWx0ZWRfX54cMBOOVrI8e
 w1CJj87benYV9u8dXO1NZ1mdTtZT3mVbGbXlld6hHny7LsBY+BokGuT0Rt8McPyMOK0221myw2f
 acHza4qNABulS2hVRHKhxLd+KFiO9Bw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0NiBTYWx0ZWRfX3Rceip49RCjb
 S6ZTVZDGOHWy62jX/FqCY6qxdJPv5RHcJQgTPHo4svOcVRfHWg81kWwyBVMQN0fkRv4kYgkUII1
 t8Zle5pld0TxZrCDeBAM2jfptk2GEGqcEj+QuN64HjlmWTZdKGF6cTDLDfaejKkxx/85ifaOMDe
 z1CYrcQ0u2Qj0b2mInP77NhEFb2wor7pNI9WRssrv2whk+vFR8x/SVYpMa0nyqy1RB1sCrwNQId
 TOyvFS2H2KiCUSnAOhTMmOA7fVbYS3WDXUin7pz9VEuJa/+vH9hRJLEcgUX6yKxwDbVFyRSs+ck
 oBf/MGaLxw0svgbd5IIbVWzqXOHDA7gvmHJj9adH0lDGWpAN5aOsjMdJPniWU/Oykoyrvoj62+2
 vuSdfXl7xbyiYvCMRV/Z1mHmx2b0E2qAInQSbSli/bLJtzGghe84UE9FE5Hpkl2+gEjRgaSVjvF
 VfvUV2MsM5r01DpbyHQ==
X-Authority-Analysis: v=2.4 cv=T7AZ3PKQ c=1 sm=1 tr=0 ts=6b06cb2a cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=4EFqt8Tv61wA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=IP9JAmHCEJnWvg-4tKgA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: e7lErjGrTsDUT1TlRKWJoI0uaFBTMbd6
X-Proofpoint-ORIG-GUID: e7lErjGrTsDUT1TlRKWJoI0uaFBTMbd6

From: Matt Coster <matt.coster@imgtec.com>

This is just a duplicate of pvr_fw_obj_get_gpu_addr(); use that instead.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_fw_meta.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw_meta.c b/drivers/gpu/drm/imagination/pvr_fw_meta.c
index 38a91dcb66cb..74a0e4d255c3 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_meta.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_meta.c
@@ -357,14 +357,6 @@ configure_seg_id(u64 seg_out_addr, u32 seg_base, u32 seg_limit, u32 seg_id,
 	*boot_conf_ptr = boot_conf;
 }
 
-static u64 get_fw_obj_gpu_addr(struct pvr_fw_object *fw_obj)
-{
-	struct pvr_device *pvr_dev = to_pvr_device(gem_from_pvr_gem(fw_obj->gem)->dev);
-	struct pvr_fw_device *fw_dev = &pvr_dev->fw_dev;
-
-	return fw_obj->fw_addr_offset + fw_dev->fw_heap_info.gpu_addr;
-}
-
 static void
 configure_seg_mmu(struct pvr_device *pvr_dev, u32 **boot_conf_ptr)
 {
@@ -384,7 +376,7 @@ configure_seg_mmu(struct pvr_device *pvr_dev, u32 **boot_conf_ptr)
 		 */
 		if (layout_entries[i].type == FW_DATA) {
 			u32 seg_id = ROGUE_FW_SEGMMU_DATA_ID;
-			u64 seg_out_addr = get_fw_obj_gpu_addr(pvr_dev->fw_dev.mem.data_obj);
+			u64 seg_out_addr = pvr_fw_obj_get_gpu_addr(pvr_dev->fw_dev.mem.data_obj);
 
 			seg_out_addr += layout_entries[i].alloc_offset;
 			seg_out_addr |= seg_out_addr_top;

-- 
2.43.0

