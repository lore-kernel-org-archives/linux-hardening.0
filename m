Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D987B3033DE;
	Mon, 20 Jul 2026 09:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540155; cv=none; b=GE4snEZ2ZbNAUUfSWNq7FpXayLsTJJhHqZkEO7XPDwITWk8pSzm4GIaf6qCENn9Wz5jgQJS9DBiyzRf0bJGtz98IqujUOJCdMJLVdliQ18Af8gYDd2eaXW3NJ6T1odsTeAw3kf9mOl8EKx+ViZEIqHRinesVTOvvaLXNVlxqUoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540155; c=relaxed/simple;
	bh=DyxOMZzA2k4hB3vl1HuYpFbwQe/dyjkOLBtutR0DyLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PT6iJRwjmNEAIJUatCbkntFc4DDLJNeDZOcU0UxEbcLF+jYufmTooiygXxb2Xlk6+HQCkYBIzvFxydhEID/PtHXKrc9LLdNIEiJtJLOq9a8Zwv+hhcmJB5t+WP6NlL05hxBb3TN2P1WvnN7j0T1oXD1zCRRQhWYh9+RgV/ITWfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UdGfrhZi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UdGfrhZi"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K963jI2110471;
	Mon, 20 Jul 2026 09:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=M3uRqlUrDEZ
	EZU28+D+F6qyLvARXLHd/wFZNCIfUcV4=; b=UdGfrhZiJTytyuacXTf15qwdSyP
	GXxc7s8VyLapXdTYqF5kCmYwHsyl1tQZkMffvU5QeidB0itRJ+Jt9YJWLw5jSLbp
	NHStbdPwLlnztb3IuAGAKGDwt00VFQ34NbND9jDdYIZbZ1l2Lj1zlh6qm0N2uTA3
	rHtXHKYORaewTc+CKSxt8PbaMNLU2YOX6xIrsp2O5t3r807Q0iZERoaSlcG3yaL9
	qznKFkTJ+/jmAYueGpjIgvE2flGW+CjjeBgLgttX20MSpY70GSOS5gf+Ut7MfOt7
	46Z9exL5yKe5FQYLuIW7Ylp4iNZdmorQOr9HRG2UXCWQGK4SIMzlqbfv1ZQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgre84fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 09:35:50 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66K9Zk5e005809;
	Mon, 20 Jul 2026 09:35:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4fgj53by72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 09:35:46 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66K9Zkcf005798;
	Mon, 20 Jul 2026 09:35:46 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-jaihindy-hyd.qualcomm.com [10.213.102.234])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 66K9ZkDY005796
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 09:35:46 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 448081)
	id A4CE222161; Mon, 20 Jul 2026 15:05:45 +0530 (+0530)
From: Jaihind Yadav <jaihindy@qti.qualcomm.com>
To: nathan@kernel.org, nsc@kernel.org, kees@kernel.org,
        linux-kbuild@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: gustavoars@kernel.org, linux-kernel@vger.kernel.org,
        Jaihind Yadav <jaihindy@qti.qualcomm.com>
Subject: [PATCH 1/1] scripts: kstack_erase: use relative stackleak plugin path
Date: Mon, 20 Jul 2026 15:05:45 +0530
Message-ID: <20260720093545.3836066-2-jaihindy@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720093545.3836066-1-jaihindy@qti.qualcomm.com>
References: <20260720093545.3836066-1-jaihindy@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwNiBTYWx0ZWRfXzNk0jarJmVLg
 AQvy1gUsV4f05+ECtwl8q3mvA8RS0rgzG1Gvxh5tTZDksIOUDj489KA/nVv4p/Ci1nTGKZqWyYC
 FI2as9YSHr0ou88Wpz30kC50xwE0u3w=
X-Proofpoint-GUID: VocrOH1rOyGiUOFrP2hKwguEH06OrQoF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwNiBTYWx0ZWRfX0TXkVrCjbdOv
 2dToUbdcKUa1dn0AsBo/c0YfognT6o5Aa2g4hO2HC/yqAjws3YdzwG39t0QrrJYk+OGbTx/9F83
 iTo5eU4k4PatCVK4m9Mb1pG1URUWazIWVe4fgXSX7LF5+hZsgMU23YuG9yKjLBdrgynZIOqmLe2
 A+wYEPIHJyiBKR0GVgS6Yk0cjoUwHlI05eohQgYBHrPM6wByQGSUbu1whe3Y6O18Y/pg7AHy6Dn
 olYGw2J/limCJ35ThpsFQxq/yPqEdeWoV1s3YyKbo/fmEWFZ1KDu2ZBZMXEjngYC3PYQcrZhqVp
 JqEsOlQFst72cjq/EO9haZtexTwi0RGWv6oRvcJB270CUNwh7O6gAbo+MKRHU3oG2TRaAbFTFbG
 zEeNuqlXnnAUjfCKAT/Up0wJyFEMHsSx7179tbZMNYWsjWuyyuLdwT0NNv+EjXDXhKcGnLObD4w
 1UAy+G960cJTloXF/CQ==
X-Proofpoint-ORIG-GUID: VocrOH1rOyGiUOFrP2hKwguEH06OrQoF
X-Authority-Analysis: v=2.4 cv=foLsol4f c=1 sm=1 tr=0 ts=6a5debf6 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=Y0pXpkGaDFTcPSGoZn0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200106

GCC records full compiler command lines in DWARF producer strings by\ndefault. With CONFIG_KSTACK_ERASE, the stackleak plugin is currently\npassed using an absolute -fplugin path, which can leak host-specific\nbuild paths into debug artifacts.\n\nResolve the stackleak plugin directory relative to the current build\ndirectory and use that in the -fplugin option, falling back to the\nexisting absolute objtree path when needed.\n\nThis keeps plugin loading behavior unchanged while avoiding absolute\nworkspace paths in recorded compiler flags.

Signed-off-by: Jaihind Yadav <jaihindy@qti.qualcomm.com>
---
 scripts/Makefile.kstack_erase | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.kstack_erase b/scripts/Makefile.kstack_erase
index ee7e4ef7b8926..006d10f3b77a0 100644
--- a/scripts/Makefile.kstack_erase
+++ b/scripts/Makefile.kstack_erase
@@ -1,7 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 
 ifdef CONFIG_GCC_PLUGIN_STACKLEAK
-kstack-erase-cflags-y += -fplugin=$(objtree)/scripts/gcc-plugins/stackleak_plugin.so
+stackleak-plugin-dir := $(or \
+	$(shell realpath -m --relative-to=$(CURDIR) $(objtree)/scripts/gcc-plugins 2>/dev/null), \
+	$(objtree)/scripts/gcc-plugins)
+kstack-erase-cflags-y += -fplugin=$(stackleak-plugin-dir)/stackleak_plugin.so
 kstack-erase-cflags-y += -fplugin-arg-stackleak_plugin-track-min-size=$(CONFIG_KSTACK_ERASE_TRACK_MIN_SIZE)
 kstack-erase-cflags-y += -fplugin-arg-stackleak_plugin-arch=$(SRCARCH)
 kstack-erase-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK_VERBOSE) += -fplugin-arg-stackleak_plugin-verbose
-- 
2.43.0

