Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CF84690;
	Sat,  1 Jun 2024 02:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717207617; cv=none; b=HMta1Sm+0txcdepCSrzIgIy7bEz1yDPR2BjEJkVKSKdF9/p++tAxdZH2Q2y9SvQ6Ol0BjKF8rmIagDxl51zzovvVOt453qFCRb5Xk1IVsgK0ohOE1ExfDHqwmw5WqvNVq1X9H/eE3gbiF7ApXPHQtUp1WxICjALNIPm7j7SoiAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717207617; c=relaxed/simple;
	bh=yEaXa70C2oIN4fVy02FAO+HZE8c0dxXfqZb9NvCfSAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=lPUQB2Uh10SiTkD3hnbY7P+F7FoqedAJPz8Mo3fN7PjYA8GyIt6TdrfOVlKPhBSBcJdqqHawRPxEv3RuJFtb+wJKcYLd0oHDIofhklGd24GKPYOAxE/dbTpK0eU4oNbHHrj8n+tO+cxVQSvxuOERAKtYU8XcPd/y0+Je1f9BwtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cX42ucI/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cX42ucI/"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VGeT3v022112;
	Sat, 1 Jun 2024 02:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mQNOrNlJBOfvXJ16Q5dYxv
	0u9N5NbtCaHvP2WMeYy0o=; b=cX42ucI/MKcrFTQNhOUGOgsPCluue9+Ot96BZe
	064oVuAYjTBRWybjtS4XM3xQ1V44cZQDVAA/mvD6ntZP4wMyEyaSmZzpFiwkK+2s
	EXq1gnM0dFxRxd8KbL+AyG3woAipbVuZY7h8tJ2RSWSXPKOcxmYU6oY6qD9tUlBF
	TGnPDdgGXSb2lWn4+jPc0dOYEzL9KrjzEEdiDSDHQYMHX8d0N9uCvzhVkDx/tmVS
	0kN8rfClQAiGiCN1UKTuv1kdJUF7Xwag54Px4WBGtp+gIqE9bAjb7VGCvgdXJsyr
	to38mTp9yxNljr7gwBYoubNi5M3sJEWx9WckG849YhTLiDNQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfj9d97b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Jun 2024 02:06:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 45126nPI013007
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 1 Jun 2024 02:06:49 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 19:06:49 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 31 May 2024 19:06:48 -0700
Subject: [PATCH] ubsan: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240531-md-lib-test_ubsan-v1-1-c2a80d258842@quicinc.com>
X-B4-Tracking: v=1; b=H4sIADeCWmYC/x3M0QqDMAxA0V+RPC9QnVvHfmXISGucAe1GUkUQ/
 33dHs/DvTsYq7DBvdpBeRWTdyqoTxXEkdKLUfpiaFzTusu5xrnHSQJmtvxcglHCEMkP1xs57zy
 U7qM8yPZ/PrriQMYYlFIcf6dJ0rLhTJZZ4Ti+TyP834IAAAA=
To: Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>,
        "Andrey
 Konovalov" <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC: <kasan-dev@googlegroups.com>, <linux-hardening@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Xj-dqjCY6hcxigd6yxhJKqMMseUSsBJa
X-Proofpoint-ORIG-GUID: Xj-dqjCY6hcxigd6yxhJKqMMseUSsBJa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-01_01,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1011
 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 mlxlogscore=968 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406010013

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_ubsan.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 lib/test_ubsan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/test_ubsan.c b/lib/test_ubsan.c
index c288df9372ed..5d7b10e98610 100644
--- a/lib/test_ubsan.c
+++ b/lib/test_ubsan.c
@@ -156,4 +156,5 @@ static void __exit test_ubsan_exit(void)
 module_exit(test_ubsan_exit);
 
 MODULE_AUTHOR("Jinbum Park <jinb.park7@gmail.com>");
+MODULE_DESCRIPTION("UBSAN unit test");
 MODULE_LICENSE("GPL v2");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240531-md-lib-test_ubsan-bca7f68a0707

