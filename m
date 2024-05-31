Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E33576025;
	Fri, 31 May 2024 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717195530; cv=none; b=q5pRrVXog0pe0hikCq1VjNGkL3o7okkJ7vIFWfA8daoSR7mjUMcPVWXPC+FM5CGyhgKTuhEpD2BAadrajvWUqBBzlCIUNFGCjc3tkZkg+Oo2wDs9SzA7D1/kxIsvkjNZvJx3W0IFdM/4rFzkQn0j8UHxSDNgR8oNm+seOzKZS+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717195530; c=relaxed/simple;
	bh=bv8gBUvM8MGOof6L8esNJ0rDHdUsxHV4g7DBC6SpCs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=n+I7ObkiNM8pLF6I/YqhGTtwgNofgAnlmIZXmYn/H5/0wk5tmqR7WTWlr46ausL9zObHKrikJEkfQIzx5HW9I9N4OACMtQei8TZuaNUaTe2fH6B4jJnGKiUFqATUR4G75ZetSnKxGDAIJLfQmlE74k2NYXdoagzE2UgHKUa7v1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V1Yh64Sg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V1Yh64Sg"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VGeYpW008944;
	Fri, 31 May 2024 22:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=igng9goX706PdqUpxh2KkS
	kALT+iZbvNsDdfjZJRKZg=; b=V1Yh64SgCAtOrsRanEMquIKCXQTAoqhink1DX+
	j4+ti2Dak6N2IZtz+ohTa5jTh0Vpogc1HTsAeLMC07lxW4ujc1l16L3709aJrE5p
	qHzH21AzvBj/EKdRYcYx7MPXyct3V7CW+3yF6cy8gYazn8AgYA4zuf1HyvoFKBTV
	Wni6dwFMDB9MYlX41olHKTf7ZZsQC3pRiDcoakIMAYcDiZdQcQIXHwgUKEmzDV2Y
	j3I5jV/DGiVIDmagKQUifOqU2OdONaBG3oPLloQN/sWl4i/r6C403oyCuET1i3dr
	aNYR2vb1OFJiDHKQGiBzkiJk0L324AzjIXSi9jRI/vXbc7RA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0ggpr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 22:45:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44VMjP6O006194
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 22:45:25 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 15:45:24 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 31 May 2024 15:45:22 -0700
Subject: [PATCH] kunit/fortify: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240531-md-lib-fortify_source-v1-1-2c37f7fbaafc@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAFTWmYC/x3MTQqDMBBA4avIrDtgUqXQq5RS8jOpA5qUGRWLe
 HfTLr/FezsoCZPCvdlBaGXlkivMpYEwuPwm5FgNtrVd218NThFH9piKzJy+Ly2LBEITwq33kaI
 1CWr7EUq8/b+PZ7V3SujF5TD8biPnZcPJ6UwCx3ECpvscyoYAAAA=
To: Kees Cook <keescook@chromium.org>,
        Andrew Morton
	<akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Fxubfp2EhTrF-FS0eFGiNuNR48f8oq33
X-Proofpoint-ORIG-GUID: Fxubfp2EhTrF-FS0eFGiNuNR48f8oq33
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_14,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310173

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/memcpy_kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/fortify_kunit.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 lib/fortify_kunit.c | 1 +
 lib/memcpy_kunit.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index 39da5b3bc649..a4b3c2afc142 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -1099,4 +1099,5 @@ static struct kunit_suite fortify_test_suite = {
 
 kunit_test_suite(fortify_test_suite);
 
+MODULE_DESCRIPTION("Runtime test cases for CONFIG_FORTIFY_SOURCE");
 MODULE_LICENSE("GPL");
diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
index 20ea9038c3ff..d36933554e46 100644
--- a/lib/memcpy_kunit.c
+++ b/lib/memcpy_kunit.c
@@ -510,4 +510,5 @@ static struct kunit_suite memcpy_test_suite = {
 
 kunit_test_suite(memcpy_test_suite);
 
+MODULE_DESCRIPTION("test cases for memcpy(), memmove(), and memset()");
 MODULE_LICENSE("GPL");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240531-md-lib-fortify_source-1cc75bded21f

