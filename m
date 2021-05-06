Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2583DC43460
	for <linux-hardening@archiver.kernel.org>; Thu,  6 May 2021 04:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED2D3613BF
	for <linux-hardening@archiver.kernel.org>; Thu,  6 May 2021 04:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhEFEgO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 6 May 2021 00:36:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4064 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231249AbhEFEgN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 6 May 2021 00:36:13 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1464Ydpd082964;
        Thu, 6 May 2021 00:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ABNn40ygnGwQ5GIm+pfG3KPmd2lvMmkBhy0jJfSgRTM=;
 b=FiWovcWHjmfJdryHYOLr8f34IXiXh3WHU8iHaOVJTSnIlSKQW0SnFhkGueb+FVgVu+/K
 +XuI8vnZlXfbXjxkQDZsmAQHamhXWtGFLmnO8XcxWcw3m5IihRULGJtc/5gtJMJv6YqX
 PQmVga4LsID6wFqOOCNfpFPF91cWrGMk4INT+Lq94RapbArDbi/80AEuxt/cm12ZES3M
 E8Ra6NP74TEIQFy2DznVBpTnm7EBbYqau8C42It6oW3zeXGqmPfpgf9qT2A5H9FV1eUR
 hVpNuACMY2l84btWxCaTZoByLicVJf24mRnj+PflVPaH38F2RVRBACcK6i9MMLqmDI+1 /g== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38c6kpbgfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 00:34:59 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1464Xin8027882;
        Thu, 6 May 2021 04:34:58 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04wdc.us.ibm.com with ESMTP id 38bedu15mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 04:34:58 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1464YwVd33882380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 May 2021 04:34:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 183D4B2066;
        Thu,  6 May 2021 04:34:58 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AD29B205F;
        Thu,  6 May 2021 04:34:57 +0000 (GMT)
Received: from oc8246131445.ibm.com (unknown [9.160.168.222])
        by b01ledav003.gho.pok.ibm.com (Postfix) with SMTP;
        Thu,  6 May 2021 04:34:57 +0000 (GMT)
Received: from oc8246131445.ibm.com (localhost.localdomain [127.0.0.1])
        by oc8246131445.ibm.com (Postfix) with ESMTP id 6EDCDBC0F4E;
        Wed,  5 May 2021 23:34:53 -0500 (CDT)
From:   "Christopher M. Riedl" <cmr@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     tglx@linutronix.de, x86@kernel.org,
        linux-hardening@vger.kernel.org, keescook@chromium.org
Subject: [RESEND PATCH v4 01/11] powerpc: Add LKDTM accessor for patching addr
Date:   Wed,  5 May 2021 23:34:42 -0500
Message-Id: <20210506043452.9674-2-cmr@linux.ibm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210506043452.9674-1-cmr@linux.ibm.com>
References: <20210506043452.9674-1-cmr@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PCeJgLiG2OdQYvoq-mUyN5daR0O7JS2k
X-Proofpoint-GUID: PCeJgLiG2OdQYvoq-mUyN5daR0O7JS2k
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-06_03:2021-05-05,2021-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2105060029
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

When live patching with STRICT_KERNEL_RWX a mapping is installed at a
"patching address" with temporary write permissions. Provide a
LKDTM-only accessor function for this address in preparation for a LKDTM
test which attempts to "hijack" this mapping by writing to it from
another CPU.

Signed-off-by: Christopher M. Riedl <cmr@linux.ibm.com>
---
 arch/powerpc/include/asm/code-patching.h | 4 ++++
 arch/powerpc/lib/code-patching.c         | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/incl=
ude/asm/code-patching.h
index f1d029bf906e5..e51c81e4a9bda 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -188,4 +188,8 @@ static inline unsigned long ppc_kallsyms_lookup_name(=
const char *name)
 				 ___PPC_RA(__REG_R1) | PPC_LR_STKOFF)
 #endif /* CONFIG_PPC64 */
=20
+#if IS_BUILTIN(CONFIG_LKDTM) && IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)
+unsigned long read_cpu_patching_addr(unsigned int cpu);
+#endif
+
 #endif /* _ASM_POWERPC_CODE_PATCHING_H */
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-pat=
ching.c
index 870b30d9be2f8..2b1b3e9043ade 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -48,6 +48,13 @@ int raw_patch_instruction(struct ppc_inst *addr, struc=
t ppc_inst instr)
 #ifdef CONFIG_STRICT_KERNEL_RWX
 static DEFINE_PER_CPU(struct vm_struct *, text_poke_area);
=20
+#if IS_BUILTIN(CONFIG_LKDTM)
+unsigned long read_cpu_patching_addr(unsigned int cpu)
+{
+	return (unsigned long)(per_cpu(text_poke_area, cpu))->addr;
+}
+#endif
+
 static int text_area_cpu_up(unsigned int cpu)
 {
 	struct vm_struct *area;
--=20
2.26.1

