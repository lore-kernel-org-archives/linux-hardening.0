Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E5DC433B4
	for <linux-hardening@archiver.kernel.org>; Thu,  6 May 2021 04:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23764613BF
	for <linux-hardening@archiver.kernel.org>; Thu,  6 May 2021 04:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhEFEgN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 6 May 2021 00:36:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229748AbhEFEgM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 6 May 2021 00:36:12 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1464Xi13116938;
        Thu, 6 May 2021 00:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=73mAfI62wtJMKQkp0BcFocAOEpg7TYlwWYR+BOcm+VM=;
 b=sTpr72XtZl9DgeSGl/HNj4uaQyVrnU/V85A+Y/j6ec7Dza4a2lixNBy37CMXiLl6War6
 tBxUTKDILEzKW8BmiooNgM4sw+9FHCYXAp39VUplR8piYoKgibEELB53kc+iq/qtaI16
 JfikICI93G1QQDpnPZTrbkNAKzh26Rsa4AzN9/E88E0nqwINYxxuZDVENjXUuuQqw4Kz
 oC2nVuaGndSfbgIJy6XehPlmfFNtsQBmus8CRxCx2j1hKFmvUi81VQZL4MrVU7WYCPd5
 s+G3lLx9MiTbliLjEix5ezMF7yMerJuNIA1ijD39s4lGMsMae9ZhoAWRt22iVycNO02T GA== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38c9b007h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 00:34:59 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1464RY4m025396;
        Thu, 6 May 2021 04:34:59 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02wdc.us.ibm.com with ESMTP id 38behe15c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 04:34:59 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1464YwSq31261154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 May 2021 04:34:58 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 768D978060;
        Thu,  6 May 2021 04:34:58 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 985437805C;
        Thu,  6 May 2021 04:34:57 +0000 (GMT)
Received: from oc8246131445.ibm.com (unknown [9.160.168.222])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with SMTP;
        Thu,  6 May 2021 04:34:57 +0000 (GMT)
Received: from oc8246131445.ibm.com (localhost.localdomain [127.0.0.1])
        by oc8246131445.ibm.com (Postfix) with ESMTP id 88BF3BC0F99;
        Wed,  5 May 2021 23:34:53 -0500 (CDT)
From:   "Christopher M. Riedl" <cmr@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     tglx@linutronix.de, x86@kernel.org,
        linux-hardening@vger.kernel.org, keescook@chromium.org
Subject: [RESEND PATCH v4 03/11] x86_64: Add LKDTM accessor for patching addr
Date:   Wed,  5 May 2021 23:34:44 -0500
Message-Id: <20210506043452.9674-4-cmr@linux.ibm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210506043452.9674-1-cmr@linux.ibm.com>
References: <20210506043452.9674-1-cmr@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JDJd_fGveA8cdV-E3DvOKWFssxWftwY6
X-Proofpoint-ORIG-GUID: JDJd_fGveA8cdV-E3DvOKWFssxWftwY6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-06_03:2021-05-05,2021-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060029
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
 arch/x86/include/asm/text-patching.h | 4 ++++
 arch/x86/kernel/alternative.c        | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/=
text-patching.h
index b7421780e4e92..f0caf9ee13bd8 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -167,4 +167,8 @@ void int3_emulate_ret(struct pt_regs *regs)
 }
 #endif /* !CONFIG_UML_X86 */
=20
+#if IS_BUILTIN(CONFIG_LKDTM)
+unsigned long read_cpu_patching_addr(unsigned int cpu);
+#endif
+
 #endif /* _ASM_X86_TEXT_PATCHING_H */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.=
c
index 8d778e46725d2..4c95fdd9b1965 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -852,6 +852,13 @@ static inline void unuse_temporary_mm(temp_mm_state_=
t prev_state)
 __ro_after_init struct mm_struct *poking_mm;
 __ro_after_init unsigned long poking_addr;
=20
+#if IS_BUILTIN(CONFIG_LKDTM)
+unsigned long read_cpu_patching_addr(unsigned int cpu)
+{
+	return poking_addr;
+}
+#endif
+
 static void *__text_poke(void *addr, const void *opcode, size_t len)
 {
 	bool cross_page_boundary =3D offset_in_page(addr) + len > PAGE_SIZE;
--=20
2.26.1

