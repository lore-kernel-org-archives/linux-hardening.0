Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FB7C43461
	for <linux-hardening@archiver.kernel.org>; Thu,  6 May 2021 04:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B14B613BA
	for <linux-hardening@archiver.kernel.org>; Thu,  6 May 2021 04:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhEFEgP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 6 May 2021 00:36:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12048 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230441AbhEFEgN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 6 May 2021 00:36:13 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1464XWSY080408;
        Thu, 6 May 2021 00:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=D+/9a8rZ+6og9MqN27ACLuVALgmvUlrIKR9nDPbhWtg=;
 b=Sw7e1h23m3b/K527miZ3jvIqNjBHFEgEaUzKibfDNcm4CQQnHNpfyte/IYVSP9Bq4RyS
 t2zYdVqc1+z6n7ApL05v6cTVc4BUwIq28nNisDScw7MNRyriY169YhBTOT1jSMhkzYm6
 NgVe4JuHoAGsLtd0BoTmiKTcW2+onz/VXAp0UYEjagKnTmkNSDS+pLOtANMpkFA9/gxn
 n28uMPe0IaJk2SasHaG2AcAd/ugCtGmAA0fTe24TrBbwi/R01nZIHaKJXtbQDDBpZHrU
 qZdswPuv9o7oG7qfiVTA97ZBqD5HC0GMKlH68tvGR6/tliC1LnpafGUOGUZnScSjLh1w 9g== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38c9f2r36k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 00:35:09 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1464XwVB023752;
        Thu, 6 May 2021 04:35:09 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma05wdc.us.ibm.com with ESMTP id 38bedwh658-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 04:35:08 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1464Z8Tn27066684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 May 2021 04:35:08 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17F1FBE053;
        Thu,  6 May 2021 04:35:08 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5427ABE056;
        Thu,  6 May 2021 04:35:07 +0000 (GMT)
Received: from oc8246131445.ibm.com (unknown [9.160.168.222])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with SMTP;
        Thu,  6 May 2021 04:35:07 +0000 (GMT)
Received: from oc8246131445.ibm.com (localhost.localdomain [127.0.0.1])
        by oc8246131445.ibm.com (Postfix) with ESMTP id D6ADCBC1EED;
        Wed,  5 May 2021 23:34:53 -0500 (CDT)
From:   "Christopher M. Riedl" <cmr@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     tglx@linutronix.de, x86@kernel.org,
        linux-hardening@vger.kernel.org, keescook@chromium.org
Subject: [RESEND PATCH v4 09/11] lkdtm/powerpc: Fix code patching hijack test
Date:   Wed,  5 May 2021 23:34:50 -0500
Message-Id: <20210506043452.9674-10-cmr@linux.ibm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210506043452.9674-1-cmr@linux.ibm.com>
References: <20210506043452.9674-1-cmr@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7bZDNk3hnwVghcNFw4OU7dzwTiJu4euu
X-Proofpoint-ORIG-GUID: 7bZDNk3hnwVghcNFw4OU7dzwTiJu4euu
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-06_03:2021-05-05,2021-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=979 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060029
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Code patching on powerpc with a STRICT_KERNEL_RWX uses a userspace
address in a temporary mm now. Use __put_user() to avoid write failures
due to KUAP when attempting a "hijack" on the patching address.

Signed-off-by: Christopher M. Riedl <cmr@linux.ibm.com>
---
 drivers/misc/lkdtm/perms.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 55c3bec6d3b72..af9bf285fe326 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -268,16 +268,7 @@ static inline u32 lkdtm_read_patch_site(void)
 /* Returns True if the write succeeds */
 static inline bool lkdtm_try_write(u32 data, u32 *addr)
 {
-#ifdef CONFIG_PPC
-	__put_kernel_nofault(addr, &data, u32, err);
-	return true;
-
-err:
-	return false;
-#endif
-#ifdef CONFIG_X86_64
 	return !__put_user(data, addr);
-#endif
 }
=20
 static int lkdtm_patching_cpu(void *data)
--=20
2.26.1

