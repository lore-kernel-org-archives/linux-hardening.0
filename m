Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF98C43470
	for <linux-hardening@archiver.kernel.org>; Thu,  6 May 2021 04:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4507613BA
	for <linux-hardening@archiver.kernel.org>; Thu,  6 May 2021 04:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhEFEgP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 6 May 2021 00:36:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232268AbhEFEgN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 6 May 2021 00:36:13 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1464XX3c081163;
        Thu, 6 May 2021 00:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lvQXdUSE1LGilnSeXVxBlpw+DjF1L2POABaCFKcobx4=;
 b=J6vU4botMSUR6YDXtjvdu1ccOZ9+bXyq/toX9j7vN0ADH8wBJnHcpAp6TCg2ZQ+H9vY6
 aQ1Ck40b9VlQoM/zFNI87sRMTEss0Gl72CqyICY8C3bq7F/tvrHWrROZmhErhfzMI00+
 oSggksunyFUG2dEBpMwmyrRD2NdvcJGCwrVrPJlhb8Fm377I8AUD6yA6ov/fNLpmE2pI
 iH9DovNu0dmJ16AncpUVvaY4sAI+18pXsWoqu4RQxh7JCX3971ouCBCAXqFDUM+puK/L
 qTfzwXk0a+iV20lZZcXV9gvz7tMLgfx5teQLX9EdSVrveuIGj3C/wj9XAt+kQ+a4LmY2 iQ== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38c78aapf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 00:35:00 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1464Y9F4023806;
        Thu, 6 May 2021 04:34:59 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma05wdc.us.ibm.com with ESMTP id 38bedwh64g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 04:34:59 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1464YwS918743738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 May 2021 04:34:58 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8576D13605E;
        Thu,  6 May 2021 04:34:58 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD8D2136053;
        Thu,  6 May 2021 04:34:57 +0000 (GMT)
Received: from oc8246131445.ibm.com (unknown [9.160.168.222])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with SMTP;
        Thu,  6 May 2021 04:34:57 +0000 (GMT)
Received: from oc8246131445.ibm.com (localhost.localdomain [127.0.0.1])
        by oc8246131445.ibm.com (Postfix) with ESMTP id 959C9BC0FBC;
        Wed,  5 May 2021 23:34:53 -0500 (CDT)
From:   "Christopher M. Riedl" <cmr@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     tglx@linutronix.de, x86@kernel.org,
        linux-hardening@vger.kernel.org, keescook@chromium.org
Subject: [RESEND PATCH v4 04/11] lkdtm/x86_64: Add test to hijack a patch mapping
Date:   Wed,  5 May 2021 23:34:45 -0500
Message-Id: <20210506043452.9674-5-cmr@linux.ibm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210506043452.9674-1-cmr@linux.ibm.com>
References: <20210506043452.9674-1-cmr@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W2-M-Q6YDZkyJ_6oGJCAeAdG6Tdlbsx9
X-Proofpoint-ORIG-GUID: W2-M-Q6YDZkyJ_6oGJCAeAdG6Tdlbsx9
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-06_03:2021-05-05,2021-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060029
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

A previous commit implemented an LKDTM test on powerpc to exploit the
temporary mapping established when patching code with STRICT_KERNEL_RWX
enabled. Extend the test to work on x86_64 as well.

Signed-off-by: Christopher M. Riedl <cmr@linux.ibm.com>
---
 drivers/misc/lkdtm/perms.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index c6f96ebffccfd..55c3bec6d3b72 100644
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
@@ -233,28 +233,51 @@ static void patching_target(void)
 	return;
 }
=20
+#ifdef CONFIG_PPC
 #include <asm/code-patching.h>
 struct ppc_inst * const patch_site =3D (struct ppc_inst *)&patching_targ=
et;
+#endif
+
+#ifdef CONFIG_X86_64
+#include <asm/text-patching.h>
+u32 * const patch_site =3D (u32 *)&patching_target;
+#endif
=20
 static inline int lkdtm_do_patch(u32 data)
 {
+#ifdef CONFIG_PPC
 	return patch_instruction(patch_site, ppc_inst(data));
+#endif
+#ifdef CONFIG_X86_64
+	text_poke(patch_site, &data, sizeof(u32));
+	return 0;
+#endif
 }
=20
 static inline u32 lkdtm_read_patch_site(void)
 {
+#ifdef CONFIG_PPC
 	struct ppc_inst inst =3D READ_ONCE(*patch_site);
 	return ppc_inst_val(ppc_inst_read(&inst));
+#endif
+#ifdef CONFIG_X86_64
+	return READ_ONCE(*patch_site);
+#endif
 }
=20
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
@@ -347,8 +370,8 @@ void lkdtm_HIJACK_PATCH(void)
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

