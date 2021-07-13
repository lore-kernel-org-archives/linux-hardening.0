Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F179FC07E95
	for <linux-hardening@archiver.kernel.org>; Tue, 13 Jul 2021 05:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D253A611C1
	for <linux-hardening@archiver.kernel.org>; Tue, 13 Jul 2021 05:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhGMFe1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 13 Jul 2021 01:34:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21590 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230477AbhGMFeY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 13 Jul 2021 01:34:24 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16D53TBn132263;
        Tue, 13 Jul 2021 01:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lBQJcKIInaD1wbLxW3CUMOLANnkl5yTpxunO/eZz2p0=;
 b=hKxn7JOCLLJyGrGQLVbnY5JQ+z4bn4DXaDNQcljW0HM1QFsbwLrSgy/0arrxY4tAUosz
 Fh0T8oe0O+6eidjjHXMpjpp1pCa2IrP/tKiMVVSBPK6WTbRedxJVerPvD6xxPgOtWRyC
 4/ipu2Twgd1TlLSPUN8nGxGvwGWdCMIl8TDXu5HgUcgoWvEA/Aeztc4vRxHGpjX4KUo1
 1G1TUfrnNrM/yrFKy1o5bMO4EPHd+r9CJlcPwzFvXwIBUp0aF+ypucILpiEbgjs0nTtS
 lNlCjsKxTR/TwSyqbpM9rxcXEMT8jBsHIi4tiSpbBJ/tWyzgvmmqqKDq0kH6aghJt3C2 Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39qs49fvy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 01:31:20 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16D54FQR135176;
        Tue, 13 Jul 2021 01:31:19 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39qs49fvxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 01:31:19 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16D5RQpp003397;
        Tue, 13 Jul 2021 05:31:18 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma05wdc.us.ibm.com with ESMTP id 39q36bqrqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 05:31:18 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16D5VHkp16908608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 05:31:17 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7F25136051;
        Tue, 13 Jul 2021 05:31:17 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 645C7136055;
        Tue, 13 Jul 2021 05:31:17 +0000 (GMT)
Received: from oc8246131445.ibm.com (unknown [9.163.19.100])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with SMTP;
        Tue, 13 Jul 2021 05:31:17 +0000 (GMT)
Received: from oc8246131445.ibm.com (localhost.localdomain [127.0.0.1])
        by oc8246131445.ibm.com (Postfix) with ESMTP id 1460CBC0B24;
        Tue, 13 Jul 2021 00:31:15 -0500 (CDT)
From:   "Christopher M. Riedl" <cmr@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     tglx@linutronix.de, x86@kernel.org,
        linux-hardening@vger.kernel.org, keescook@chromium.org,
        npiggin@gmail.com, dja@axtens.net, peterz@infradead.org
Subject: [PATCH v5 4/8] lkdtm/x86_64: Add test to hijack a patch mapping
Date:   Tue, 13 Jul 2021 00:31:09 -0500
Message-Id: <20210713053113.4632-5-cmr@linux.ibm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210713053113.4632-1-cmr@linux.ibm.com>
References: <20210713053113.4632-1-cmr@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pCCKxfVjoj7mFUp7bu2RIzF3Q4m8S6El
X-Proofpoint-ORIG-GUID: QDtJ03sGPYCLaSQlGDX7uPxx0-suv1Hs
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-13_03:2021-07-13,2021-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107130026
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

A previous commit implemented an LKDTM test on powerpc to exploit the
temporary mapping established when patching code with STRICT_KERNEL_RWX
enabled. Extend the test to work on x86_64 as well.

Signed-off-by: Christopher M. Riedl <cmr@linux.ibm.com>
---
 drivers/misc/lkdtm/perms.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 39e7456852229..41e87e5f9cc86 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -224,7 +224,7 @@ void lkdtm_ACCESS_NULL(void)
 }
=20
 #if (IS_BUILTIN(CONFIG_LKDTM) && defined(CONFIG_STRICT_KERNEL_RWX) && \
-	defined(CONFIG_PPC))
+	(defined(CONFIG_PPC) || defined(CONFIG_X86_64)))
 /*
  * This is just a dummy location to patch-over.
  */
@@ -233,12 +233,25 @@ static void patching_target(void)
 	return;
 }
=20
-#include <asm/code-patching.h>
 const u32 *patch_site =3D (const u32 *)&patching_target;
=20
+#ifdef CONFIG_PPC
+#include <asm/code-patching.h>
+#endif
+
+#ifdef CONFIG_X86_64
+#include <asm/text-patching.h>
+#endif
+
 static inline int lkdtm_do_patch(u32 data)
 {
+#ifdef CONFIG_PPC
 	return patch_instruction((u32 *)patch_site, ppc_inst(data));
+#endif
+#ifdef CONFIG_X86_64
+	text_poke((void *)patch_site, &data, sizeof(u32));
+	return 0;
+#endif
 }
=20
 static inline u32 lkdtm_read_patch_site(void)
@@ -249,11 +262,16 @@ static inline u32 lkdtm_read_patch_site(void)
 /* Returns True if the write succeeds */
 static inline bool lkdtm_try_write(u32 data, u32 *addr)
 {
+#ifdef CONFIG_PPC
 	__put_kernel_nofault(addr, &data, u32, err);
 	return true;
=20
 err:
 	return false;
+#endif
+#ifdef CONFIG_X86_64
+	return !__put_user(data, addr);
+#endif
 }
=20
 static int lkdtm_patching_cpu(void *data)
@@ -346,8 +364,8 @@ void lkdtm_HIJACK_PATCH(void)
=20
 void lkdtm_HIJACK_PATCH(void)
 {
-	if (!IS_ENABLED(CONFIG_PPC))
-		pr_err("XFAIL: this test only runs on powerpc\n");
+	if (!IS_ENABLED(CONFIG_PPC) && !IS_ENABLED(CONFIG_X86_64))
+		pr_err("XFAIL: this test only runs on powerpc and x86_64\n");
 	if (!IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
 		pr_err("XFAIL: this test requires CONFIG_STRICT_KERNEL_RWX\n");
 	if (!IS_BUILTIN(CONFIG_LKDTM))
--=20
2.26.1

