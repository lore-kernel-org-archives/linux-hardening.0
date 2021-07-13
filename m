Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2344C07E95
	for <linux-hardening@archiver.kernel.org>; Tue, 13 Jul 2021 05:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F9F0601FE
	for <linux-hardening@archiver.kernel.org>; Tue, 13 Jul 2021 05:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhGMFeY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 13 Jul 2021 01:34:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40642 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230074AbhGMFeY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 13 Jul 2021 01:34:24 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16D5RQmT147091;
        Tue, 13 Jul 2021 01:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=m9WunVL9v/+sDqvWmb6xfYT5UK9T02Ajzu69XvnBnn0=;
 b=DkvNGnLkBnGTJRwEUhyLGiEOhuwI1eyg7GnBX4y0sWFzRpr/KoZY22+hl86XfKMBJO5T
 OEYQLV5+SXmg5j3gn9Ksuyx/0N8+HhQGy4AlhJzoiabUM/sCz2TJfRP5ESJiQwdZoEv2
 Af3yEp+QF3wprIAHrreasFdIJbtlrlbHqYuc97moSebBZNX+yhZZMJeTukWNwP0lEWi9
 R9iHG7JuUDvCG4CNmJZgDb+d+MprgDqoBGww51ZPTs85+dnACMJbniz8RNFs0TiMixCt
 N+UDEQNlra+mP0wgUxokwv4qTcOpddYYMFYMWbIoYNShaoutxvayZBmhOyB6oXRfHkCB oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39qrvam3gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 01:31:20 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16D5VJDs152458;
        Tue, 13 Jul 2021 01:31:19 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39qrvam3gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 01:31:19 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16D5RUnU010702;
        Tue, 13 Jul 2021 05:31:18 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01wdc.us.ibm.com with ESMTP id 39q36ayrdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 05:31:18 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16D5VHP550004310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 05:31:17 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95D4678068;
        Tue, 13 Jul 2021 05:31:17 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AC7D78066;
        Tue, 13 Jul 2021 05:31:17 +0000 (GMT)
Received: from oc8246131445.ibm.com (unknown [9.163.19.100])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with SMTP;
        Tue, 13 Jul 2021 05:31:17 +0000 (GMT)
Received: from oc8246131445.ibm.com (localhost.localdomain [127.0.0.1])
        by oc8246131445.ibm.com (Postfix) with ESMTP id 074DCBC0B11;
        Tue, 13 Jul 2021 00:31:15 -0500 (CDT)
From:   "Christopher M. Riedl" <cmr@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     tglx@linutronix.de, x86@kernel.org,
        linux-hardening@vger.kernel.org, keescook@chromium.org,
        npiggin@gmail.com, dja@axtens.net, peterz@infradead.org
Subject: [PATCH v5 3/8] x86_64: Add LKDTM accessor for patching addr
Date:   Tue, 13 Jul 2021 00:31:08 -0500
Message-Id: <20210713053113.4632-4-cmr@linux.ibm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210713053113.4632-1-cmr@linux.ibm.com>
References: <20210713053113.4632-1-cmr@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: r6hXbqrh5llFK3wh2elbVGnswmCRkNht
X-Proofpoint-GUID: gRYvcaTsQLdnilhE3MhAzZG_jp22yX9N
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-13_03:2021-07-13,2021-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107130026
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
index e9da3dc712541..28bb92b695639 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -773,6 +773,13 @@ static inline void unuse_temporary_mm(temp_mm_state_=
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

