Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91FD139588;
	Wed, 29 May 2024 18:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717006181; cv=none; b=IqX7Kz3gXN4V/NCfZXmygUu2a0n7gtvKEEyalC0tBBF/0gKMDnRpLBTKklqflXmJSPoIfBWI1eLb+oqoGB3aEyfrqR9sT/Uz2bMCIhdMJKsbwMFZwrvP6iSGqYsyS8rUmyjcof3sfb2cLG0SgH78NtZs9M702WI7kWol0NBWPtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717006181; c=relaxed/simple;
	bh=bUNBC++5QqCYKmwTCeeD+mv5VmpkCIdPw9OF48t8gKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=G8xr31ESULMyBLerCmC6ujfOBMuucq+9idoqPunEM+FUCpZf7lIhMKbeEyj10iPLFVaIQNLSkOdb4Siv5zIYzui+1HMn6V/lw41Bk4NI4G47WMceNnTDo64oAlZ5RC7JHsUGSquAHlkQ4bCJTGH+fUm3oqp2LH72opHK+0m2hQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g8P6dK2w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g8P6dK2w"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TCKA9Q015705;
	Wed, 29 May 2024 18:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Ju/J3hCB+VSBMcgUZS/ZrV
	7h7Zxp1rYn0GuScpI13VI=; b=g8P6dK2wbUAMBwtGUDqiuzgB8G5cQY4JZ92r3R
	okubOc2K8RAkkrnaE1/k622g3Hpa0DUwV+ZAl/tCA04FiQWyaqL9nlFwP/TsBUTO
	18t4acMtEm5N9jcudmZxO059HmNwEfQ4rvCdda0yth5TXp4t0M6xPTVrX2XSJPVU
	Kb73cdH5Z63sOh9M+Lw2xG6rvBVqZn6FjBifDSBBHxeolPkxkx+zp1rGfjyIbSnW
	+i7KhR7VSgXHPY+RcLrAMWVsuFgbHEDCYlQ6bHBjB85LEGONiu10GFofSghUGzaW
	0Ck8IYZ6poo/8tHtP8rIuF8G3d+KApWEP8V4uxo1IHa8PoJQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2h9smw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 18:09:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44TI9N3j018535
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 18:09:23 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 May
 2024 11:09:23 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 29 May 2024 11:09:21 -0700
Subject: [PATCH] x86/boot: add prototype for __fortify_panic()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240529-fortify_panic-v1-1-9923d5c77657@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAFBvV2YC/x3M0Q6CMAxA0V8hfbbJNkSjv2KIKaOTJjpIiwRD+
 Henj+fh3g2MVdjgWm2gvIjJmAv8oYI4UH4wSl8MwYWja8IF06izpM99oiwR69CcnOfEZ99DaSb
 lJOv/d2uLOzLGTinH4Xd5Sn6v+CKbWWHfv4pyveZ+AAAA
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>, "H. Peter Anvin"
	<hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CrNa4S0doKVMRnvhAvg3nV19ivjHciMf
X-Proofpoint-ORIG-GUID: CrNa4S0doKVMRnvhAvg3nV19ivjHciMf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=882 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290127

As discussed in [1] add a prototype for __fortify_panic() to fix the
'make W=1 C=1' warning:

arch/x86/boot/compressed/misc.c:535:6: warning: symbol '__fortify_panic' was not declared. Should it be static?

Link: https://lore.kernel.org/all/79653cc7-6e59-4657-9c0a-76f49f49d019@quicinc.com/ [1]
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 arch/x86/boot/compressed/misc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index b353a7be380c..3a56138484a9 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -68,6 +68,7 @@ void __putdec(unsigned long value);
 #define error_putstr(__x)  __putstr(__x)
 #define error_puthex(__x)  __puthex(__x)
 #define error_putdec(__x)  __putdec(__x)
+void __fortify_panic(const u8 reason, size_t avail, size_t size);
 
 #ifdef CONFIG_X86_VERBOSE_BOOTUP
 

---
base-commit: e0cce98fe279b64f4a7d81b7f5c3a23d80b92fbc
change-id: 20240529-fortify_panic-325601efe71d

