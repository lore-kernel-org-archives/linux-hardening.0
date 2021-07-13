Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4F8C11F69
	for <linux-hardening@archiver.kernel.org>; Tue, 13 Jul 2021 05:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F368601FE
	for <linux-hardening@archiver.kernel.org>; Tue, 13 Jul 2021 05:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhGMFed (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 13 Jul 2021 01:34:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231998AbhGMFe2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 13 Jul 2021 01:34:28 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16D541WM107407;
        Tue, 13 Jul 2021 01:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Kwi7foOKwhU8NgG5vG7fgNdpivTmYOH87NzNnOWfJT4=;
 b=Le9FIaAPo8eDCNq8REyGHhF3xmUll/1dd2wHc0ckZenz22KDc0PLyjztRYzc75/3E54p
 lV66uWpmh4hE3aOmcjZE3Au/QBIQLKhr6FF+TnyKmC3cVLOjG5k5wo7/r/j1R/tZO5Wz
 1SjqGrXm50OKcNC1ATnP5m1aV66ay2FhroaT0W7UXEo4ddI97sP9i6NiOsSyt+lkQefA
 op4pOVrVJt3Vu4XKyn2bYT/PItdQQgfeg4WVflItjmMycnIIPbO9X+7zs7uMAv5upXoZ
 +SZxAxVQj4NZJ/WqTWpNOZjWbALJQQIvFD6ogWC3i9BudCnLFrjenc5xc3/OLEYw845O 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39qs117ra4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 01:31:22 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16D54Jio108705;
        Tue, 13 Jul 2021 01:31:22 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39qs117r9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 01:31:22 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16D5RUY2010788;
        Tue, 13 Jul 2021 05:31:21 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01wdc.us.ibm.com with ESMTP id 39q36ayrf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 05:31:21 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16D5VKhp28246524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 05:31:20 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 488D9BE04F;
        Tue, 13 Jul 2021 05:31:20 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1B46BE053;
        Tue, 13 Jul 2021 05:31:19 +0000 (GMT)
Received: from oc8246131445.ibm.com (unknown [9.163.19.100])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with SMTP;
        Tue, 13 Jul 2021 05:31:19 +0000 (GMT)
Received: from oc8246131445.ibm.com (localhost.localdomain [127.0.0.1])
        by oc8246131445.ibm.com (Postfix) with ESMTP id 4A441BC0C34;
        Tue, 13 Jul 2021 00:31:15 -0500 (CDT)
From:   "Christopher M. Riedl" <cmr@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     tglx@linutronix.de, x86@kernel.org,
        linux-hardening@vger.kernel.org, keescook@chromium.org,
        npiggin@gmail.com, dja@axtens.net, peterz@infradead.org
Subject: [PATCH v5 8/8] lkdtm/powerpc: Fix code patching hijack test
Date:   Tue, 13 Jul 2021 00:31:13 -0500
Message-Id: <20210713053113.4632-9-cmr@linux.ibm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210713053113.4632-1-cmr@linux.ibm.com>
References: <20210713053113.4632-1-cmr@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cHCthgBcM9xp9Mt9bos8xwQ5FL3n-jCp
X-Proofpoint-ORIG-GUID: HDbwSKEE2EoyOQh_byeJIz2jcHRRf7Jr
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-13_03:2021-07-13,2021-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107130022
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Code patching on powerpc with a STRICT_KERNEL_RWX uses a userspace
address in a temporary mm on Radix now. Use __put_user() to avoid write
failures due to KUAP when attempting a "hijack" on the patching address.
__put_user() also works with the non-userspace, vmalloc-based patching
address on non-Radix MMUs.

Signed-off-by: Christopher M. Riedl <cmr@linux.ibm.com>
---
 drivers/misc/lkdtm/perms.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 41e87e5f9cc86..da6a34a0a49fb 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -262,16 +262,7 @@ static inline u32 lkdtm_read_patch_site(void)
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

