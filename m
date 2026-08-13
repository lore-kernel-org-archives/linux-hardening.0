Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E6143D4EE;
	Thu, 13 Aug 2026 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609824; cv=none; b=BjEdhuZ8IpNeD2Ep1qFYCJtKNQy6joTasUt4oRQi8hOiyMyREkyFSuHXduI4nQDQkLI4q7ApPAASs+Af1mRim2wQdTy/DlpzD7mYD2nu+HhxxluoBupXOK8mlAOfvuMmaWh50mVqJ0PGCbFfGlrBzREyvzqkNVg2Qvih2t4zhGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609824; c=relaxed/simple;
	bh=LrspAeAx/yOVOn1WlpqcgTETe1zfP8oNMzYeylLkjRs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZJPU/5vCzeakvAihoLRYaZO1h/0EH6lM+k1OdOd+JhpEDd8QLXuEKQRcOjWed5GeAtuEnscn1KUffystW2ntv8Ggt+UOvhdj5no/YMzUvnJkC1KWX+82We9V8NZ8rS432wtv4By74Yg38Lkjb7PnMc3mKILRepZqnkR3g29aho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qti.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zgx2T3i2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zgx2T3i2"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D5g7T21072366;
	Thu, 13 Aug 2026 08:30:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V+OQevDySdUiNlsVYK3I5naRXIe8nUtnNrYUvXaCa/8=; b=Zgx2T3i2IFpPi8Xc
	iIdrcQfRq5N2BD4OOZQ5rRDMmWWCrDT1apPrCLK+e8DkUIZ89WLo0CAwG6luqVWq
	HnAntnatc+LES2vXDzeWNCqCwda2RVpYWVKBUIIMs71G8YVBBSZrFr74mDfqhcFg
	3BTxHtuv4bYJgKPdbJuXEwEXyax3G0vUNTD4Xi5pcoLTP/SP1dZEJvasixWWQQXz
	ZBWxikrSNolkBxkM1XG26LU+pD329zW9Pd3ZChkVp9RaaoBfHw+WwPW0bbuUOE98
	gKwVmwaZmRAl3DEvmU9syn2L2biZdYH7zT1+/mHInRxMLsErrqNEVLsTPWAz0doc
	iCP1Aw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g14syhca0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 08:30:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTPS id 67D8UCcb009415
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 08:30:12 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 13 Aug
 2026 01:30:10 -0700
From: Jaihind Yadav <jaihindy@qti.qualcomm.com>
To: <nathan@kernel.org>, <nsc@kernel.org>
CC: <linux-kbuild@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jaihind Yadav <jaihindy@qti.qualcomm.com>
Subject: [PATCH v2] kstack_erase: suppress -grecord-gcc-switches for external module builds
Date: Thu, 13 Aug 2026 13:59:49 +0530
Message-ID: <20260813082949.1622045-1-jaihindy@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803181217.GB1067866@ax162>
References: <20260803181217.GB1067866@ax162>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=ZcQt8MVA c=1 sm=1 tr=0 ts=6a7d8095 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=O4BMjXmnfS_GZb3uHPoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA1OCBTYWx0ZWRfXzc/x3lmBd0k8
 FpOTS2CnfpVhCeqEi8A9HyvwpQrL79UDSoC3/fmy5MY4ynGyOrDO9AhsecbP5tPY/yAk6BJyqzc
 CN6DHkmXT3lfOz1ubZfebw966hCoYLbglT5eYGMIHjSj0f042xkKXy4+rNeSTzftQchEgHtf3/A
 RGnXkcCW103xmIRQqZViA+3xKI5nKJR3RfOtpyoPHEliG7yl2N0HsdqfPzm/gGIrfSeW7sbz6eN
 8LDnzu3wVorde+9soWO2OVdkKqofGM1uLQ/qTP3VzcgzlxhRuGoeO2yatkU0DaR9baSKnWRQfGJ
 S2Oh3hG/uuy35efnwJL/ZBFwRrtYEmrq9Q0WS1tYmHEkqy4+d6nNR52oiCW/LiwM0XS9IdxFZtH
 Rn0OL1zBkjeJudJfgf65HHneWp5K0kzuhkNeb2fH29uCXX/CYB9m9YREQQyQoVT+F3R0cTcuQKu
 g3KLHyut3U1bfyBMbmA==
X-Proofpoint-ORIG-GUID: l2Rc4SpdEorkfkAZJshjKaYmLy1Mh3kB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA1OCBTYWx0ZWRfX2eT0Ll2U9Yj+
 v3qFysTdBH5sl86vTiFCcqlmdIKNuA80RuzEWX4B6BKDv7v/leJXomzOupOELIvtjTod9+i6FqU
 uFLcloIbCcwXxk+gvIZo6WSoeCOhYgI=
X-Proofpoint-GUID: l2Rc4SpdEorkfkAZJshjKaYmLy1Mh3kB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130058

With CONFIG_GCC_PLUGIN_STACKLEAK=y, kstack erase adds:

  -fplugin=$(objtree)/scripts/gcc-plugins/stackleak_plugin.so

For KBUILD_EXTMOD builds, recording gcc switches can embed this host/build
specific plugin path into module DWARF producer strings, which trips QA
checks looking for absolute path leakage.

Disable gcc switch recording only for external modules by adding
-gno-record-gcc-switches to kstack-erase-cflags when KBUILD_EXTMOD is set.

This keeps stackleak plugin instrumentation enabled while avoiding leakage
of host-specific paths in external module debug metadata.

Suggested-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/all/20260803181217.GB1067866@ax162/
Signed-off-by: Jaihind Yadav <jaihindy@qti.qualcomm.com>
---
 scripts/Makefile.kstack_erase | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Makefile.kstack_erase b/scripts/Makefile.kstack_erase
index ee7e4ef7b892..6f31a3915d24 100644
--- a/scripts/Makefile.kstack_erase
+++ b/scripts/Makefile.kstack_erase
@@ -5,6 +5,7 @@ kstack-erase-cflags-y += -fplugin=$(objtree)/scripts/gcc-plugins/stackleak_plugi
 kstack-erase-cflags-y += -fplugin-arg-stackleak_plugin-track-min-size=$(CONFIG_KSTACK_ERASE_TRACK_MIN_SIZE)
 kstack-erase-cflags-y += -fplugin-arg-stackleak_plugin-arch=$(SRCARCH)
 kstack-erase-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK_VERBOSE) += -fplugin-arg-stackleak_plugin-verbose
+kstack-erase-cflags-$(if $(KBUILD_EXTMOD),y) += -gno-record-gcc-switches
 DISABLE_KSTACK_ERASE := -fplugin-arg-stackleak_plugin-disable
 endif
 
-- 
2.43.0

