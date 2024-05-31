Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95B878C7E;
	Fri, 31 May 2024 23:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717196877; cv=none; b=OBDete5SSmX5sz23FCK3SVilIJ+YrOzE4//V3VqaxSlb1uZrtTT0d99U35xqfGdn6xEWnWVDasMAYYxt9G3oATQFayyoIn2HsgD/knVowwcB+5nUPi2S5kIPieAZOgkA28wiqER4gY1EQa/ZThE6QAHzWZF76sHV4CcgoLNqayI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717196877; c=relaxed/simple;
	bh=3L8q6+HeknLNIZfhdkFFi4EhUcFS6SsgKfSMxydRkI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Qy+o3zBMlqV/7LLHwcqS1eBzLQMIE4WT4WOq+hEdUF0V/TVH27jMsdiZktgIWKDHNYJhzBBL6gJdVYhUqwvONrMubRvBc7K4/IFypobp9aVzxSCdyH4UVfNz4JmRGIaykGKlZmi11QtqO4PazYc3yS1cdjNYKT/Eqpi90dNKJ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O5xV2CYN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O5xV2CYN"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VMAfkx003470;
	Fri, 31 May 2024 23:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UloEUe7AvInSWdJYghVBKr
	arL03QWUuf05ctdl7DoL8=; b=O5xV2CYNPMlJQyJTy2aRLzRv4ARsa8kWu3sbtl
	MsHrj2ytGhf57iRAZKZ1c/1pSkhKBvNMgUm6ppx75MYYqX5jvKu7bwvG5vduYEWV
	Ye8V2T1uCoXydy++qgOs1e/ch++stx39Xkrx4expS+/qvpNiM5xP/ac81Cfn8mol
	f0R3O9aT6eJLP5CDYzk6qi65t4v/c8Xp9tFLJCUP9h8+ZfEP6iFCMQl91AGTv7HC
	SeCnDGNQ1mzD6wDPmlw+gMIHZVmXJy7b+N5LQyHsoFM9O1yopC0nsBZCyGP/L/54
	QSLL/KsYYt5unvIacx0IMmPLwFN1dOrLwe9wmFOHNSXYWhvw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yesw5mhv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 23:07:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44VN7nas030486
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 23:07:50 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 16:07:49 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 31 May 2024 16:07:26 -0700
Subject: [PATCH] string: kunit: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240531-md-lib-string-v1-1-2738cf057d94@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAC1YWmYC/x3MwQqDMAyA4VeRnBewtmNurzI8tDbTgGYjcUMQ3
 92643f4/w2MlMngUW2g9GPjtxS4SwX9GGUg5FwMTd2E+uodzhknTmiLsgyY7+0tt84nHwKU5qP
 04vX/e3bFKRph0ij9eF4mlu+Kc7SFFPb9AL+3IKx+AAAA
To: Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook
	<keescook@chromium.org>, Andy Shevchenko <andy@kernel.org>
CC: <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nfPBLTy5pgwf_aNgb92UGnqazCOEfK2P
X-Proofpoint-GUID: nfPBLTy5pgwf_aNgb92UGnqazCOEfK2P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_14,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1011 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310176

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/string_kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/string_helpers_kunit.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 lib/string_helpers_kunit.c | 1 +
 lib/string_kunit.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/lib/string_helpers_kunit.c b/lib/string_helpers_kunit.c
index f88e39fd68d6..c853046183d2 100644
--- a/lib/string_helpers_kunit.c
+++ b/lib/string_helpers_kunit.c
@@ -625,4 +625,5 @@ static struct kunit_suite string_helpers_test_suite = {
 
 kunit_test_suites(&string_helpers_test_suite);
 
+MODULE_DESCRIPTION("Test cases for string helpers module");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/lib/string_kunit.c b/lib/string_kunit.c
index 2a812decf14b..c919e3293da6 100644
--- a/lib/string_kunit.c
+++ b/lib/string_kunit.c
@@ -633,4 +633,5 @@ static struct kunit_suite string_test_suite = {
 
 kunit_test_suites(&string_test_suite);
 
+MODULE_DESCRIPTION("Test cases for string functions");
 MODULE_LICENSE("GPL v2");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240531-md-lib-string-d987d813b344

