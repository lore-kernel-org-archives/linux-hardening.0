Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8171C43603
	for <linux-hardening@archiver.kernel.org>; Thu,  6 May 2021 04:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8153F613BA
	for <linux-hardening@archiver.kernel.org>; Thu,  6 May 2021 04:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhEFEgQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 6 May 2021 00:36:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30892 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232331AbhEFEgO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 6 May 2021 00:36:14 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1464XSVs031004;
        Thu, 6 May 2021 00:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Tg89mH3DPaWzZE15dM0eB1i+AV3aduvX3BmQ25kwPs4=;
 b=UlzzLMBAn7zF4h6A0UH3bpsTF9JEnfVZpdg/pgO0n+Dr+f/hPEBgHZo1pLmSJ1mEZJiW
 cDI6MhodmP9DCkYVQlOg5D96mF/Jtydyc38WZBru4Vf7k69pb/2Xy2tLdvr5oG/uvoXa
 HKH0Gp28MIkeftS4eTIJToIp8L1Olfzv0yeP2ItgBVJIJl5SNwVfKCN8HZQSfPbCiY3X
 TdnVAteqBE9HY4uzWT+zlEKyrmibh2EW0+7LmJFLaFHQO8YLrB6/DFrYq5Cdd6p/U4n8
 ISKSBYiSmPTEEEvB9lmfpU3I0fRqLuu8usnL1RnP70lvrgvoEPZR+TltdnRXpTLnsbdU yQ== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38c7m0a78p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 00:35:10 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1464Xpip029100;
        Thu, 6 May 2021 04:35:09 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01dal.us.ibm.com with ESMTP id 38bee0ueee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 04:35:09 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1464Z7HK34603404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 May 2021 04:35:07 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2AA2BE051;
        Thu,  6 May 2021 04:35:07 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEE3ABE04F;
        Thu,  6 May 2021 04:35:06 +0000 (GMT)
Received: from oc8246131445.ibm.com (unknown [9.160.168.222])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with SMTP;
        Thu,  6 May 2021 04:35:06 +0000 (GMT)
Received: from oc8246131445.ibm.com (localhost.localdomain [127.0.0.1])
        by oc8246131445.ibm.com (Postfix) with ESMTP id BC2EFBC1E55;
        Wed,  5 May 2021 23:34:53 -0500 (CDT)
From:   "Christopher M. Riedl" <cmr@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     tglx@linutronix.de, x86@kernel.org,
        linux-hardening@vger.kernel.org, keescook@chromium.org
Subject: [RESEND PATCH v4 07/11] powerpc/64s: Make slb_allocate_user() non-static
Date:   Wed,  5 May 2021 23:34:48 -0500
Message-Id: <20210506043452.9674-8-cmr@linux.ibm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210506043452.9674-1-cmr@linux.ibm.com>
References: <20210506043452.9674-1-cmr@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0EnHgVqbYANteOz1ZRPn6hr4P80w3ejc
X-Proofpoint-GUID: 0EnHgVqbYANteOz1ZRPn6hr4P80w3ejc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-06_03:2021-05-05,2021-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105060029
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

With Book3s64 Hash translation, manually inserting a PTE requires
updating the Linux PTE, inserting a SLB entry, and inserting the hashed
page. The first is handled via the usual kernel abstractions, the second
requires slb_allocate_user() which is currently 'static', and the third
is available via hash_page_mm() already.

Make slb_allocate_user() non-static and add a prototype so the next
patch can use it during code-patching.

Signed-off-by: Christopher M. Riedl <cmr@linux.ibm.com>

---

v4:  * New to series.
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 1 +
 arch/powerpc/mm/book3s64/slb.c                | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc=
/include/asm/book3s/64/mmu-hash.h
index 3004f3323144d..189854eebba77 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -525,6 +525,7 @@ void slb_dump_contents(struct slb_entry *slb_ptr);
 extern void slb_vmalloc_update(void);
 extern void slb_set_size(u16 size);
 void preload_new_slb_context(unsigned long start, unsigned long sp);
+long slb_allocate_user(struct mm_struct *mm, unsigned long ea);
 #endif /* __ASSEMBLY__ */
=20
 /*
diff --git a/arch/powerpc/mm/book3s64/slb.c b/arch/powerpc/mm/book3s64/sl=
b.c
index da0836cb855af..532eb51bc5211 100644
--- a/arch/powerpc/mm/book3s64/slb.c
+++ b/arch/powerpc/mm/book3s64/slb.c
@@ -29,8 +29,6 @@
 #include "internal.h"
=20
=20
-static long slb_allocate_user(struct mm_struct *mm, unsigned long ea);
-
 bool stress_slb_enabled __initdata;
=20
 static int __init parse_stress_slb(char *p)
@@ -791,7 +789,7 @@ static long slb_allocate_kernel(unsigned long ea, uns=
igned long id)
 	return slb_insert_entry(ea, context, flags, ssize, true);
 }
=20
-static long slb_allocate_user(struct mm_struct *mm, unsigned long ea)
+long slb_allocate_user(struct mm_struct *mm, unsigned long ea)
 {
 	unsigned long context;
 	unsigned long flags;
--=20
2.26.1

