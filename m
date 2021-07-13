Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8226FC11F6A
	for <linux-hardening@archiver.kernel.org>; Tue, 13 Jul 2021 05:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D910601FE
	for <linux-hardening@archiver.kernel.org>; Tue, 13 Jul 2021 05:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhGMFed (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 13 Jul 2021 01:34:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232158AbhGMFec (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 13 Jul 2021 01:34:32 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16D54Hua000762;
        Tue, 13 Jul 2021 01:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XCleOmoVIk8CFFqNyEx7CfNU9+f7yAb7rw5n/scUPag=;
 b=THx/RzqicsHTMdmZuD4AQjVZYQwAI++kaA9uP6nin+HoG7K6P5XoccCKfLesnIxlw8YZ
 60CIiD/NivffZla3phRX12MRLibqFeFho9P4FO206HEBhOz22iZVH4VrZZedCGzyhdGm
 5HEPBbfThhMd1hpltp5z3j+4+B/pfi1EuMgdX7AH55DKytaSuFFkmLMWc4xemsVrinq9
 bfSwNT0VlY+zVZMlLC1jKoBfDLA3+Qb6+5BkG/8RrtLRzJmioKuDsXui806FqX7Syb2b
 BNX7lZyXavc+vjQhf2Sbvt83PDgjRRtk3dxjrgu1Dri6xhWQY6b8nRB+ysXXNl8HaiHV HA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39qs2vr9h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 01:31:22 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16D54P29001501;
        Tue, 13 Jul 2021 01:31:22 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39qs2vr9gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 01:31:22 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16D5SPHL011535;
        Tue, 13 Jul 2021 05:31:21 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04dal.us.ibm.com with ESMTP id 39q36b7n7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 05:31:21 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16D5VKhR11600150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 05:31:20 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB74828065;
        Tue, 13 Jul 2021 05:31:20 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 081F628059;
        Tue, 13 Jul 2021 05:31:20 +0000 (GMT)
Received: from oc8246131445.ibm.com (unknown [9.163.19.100])
        by b01ledav001.gho.pok.ibm.com (Postfix) with SMTP;
        Tue, 13 Jul 2021 05:31:19 +0000 (GMT)
Received: from oc8246131445.ibm.com (localhost.localdomain [127.0.0.1])
        by oc8246131445.ibm.com (Postfix) with ESMTP id 21E9ABC0B41;
        Tue, 13 Jul 2021 00:31:15 -0500 (CDT)
From:   "Christopher M. Riedl" <cmr@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     tglx@linutronix.de, x86@kernel.org,
        linux-hardening@vger.kernel.org, keescook@chromium.org,
        npiggin@gmail.com, dja@axtens.net, peterz@infradead.org
Subject: [PATCH v5 5/8] powerpc/64s: Introduce temporary mm for Radix MMU
Date:   Tue, 13 Jul 2021 00:31:10 -0500
Message-Id: <20210713053113.4632-6-cmr@linux.ibm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210713053113.4632-1-cmr@linux.ibm.com>
References: <20210713053113.4632-1-cmr@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mR43311HGck7F-7OTJw7B0VjrQMc3tzu
X-Proofpoint-GUID: aecOiKltVjrwY5VvOvgGJD_4qjWgNhTx
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-13_03:2021-07-13,2021-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107130026
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

x86 supports the notion of a temporary mm which restricts access to
temporary PTEs to a single CPU. A temporary mm is useful for situations
where a CPU needs to perform sensitive operations (such as patching a
STRICT_KERNEL_RWX kernel) requiring temporary mappings without exposing
said mappings to other CPUs. Another benefit is that other CPU TLBs do
not need to be flushed when the temporary mm is torn down.

Mappings in the temporary mm can be set in the userspace portion of the
address-space.

Interrupts must be disabled while the temporary mm is in use. HW
breakpoints, which may have been set by userspace as watchpoints on
addresses now within the temporary mm, are saved and disabled when
loading the temporary mm. The HW breakpoints are restored when unloading
the temporary mm. All HW breakpoints are indiscriminately disabled while
the temporary mm is in use.

Based on x86 implementation:

commit cefa929c034e
("x86/mm: Introduce temporary mm structs")

Signed-off-by: Christopher M. Riedl <cmr@linux.ibm.com>

---

v5:  * Drop support for using a temporary mm on Book3s64 Hash MMU.

v4:  * Pass the prev mm instead of NULL to switch_mm_irqs_off() when
       using/unusing the temp mm as suggested by Jann Horn to keep
       the context.active counter in-sync on mm/nohash.
     * Disable SLB preload in the temporary mm when initializing the
       temp_mm struct.
     * Include asm/debug.h header to fix build issue with
       ppc44x_defconfig.
---
 arch/powerpc/include/asm/debug.h |  1 +
 arch/powerpc/kernel/process.c    |  5 +++
 arch/powerpc/lib/code-patching.c | 56 ++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/arch/powerpc/include/asm/debug.h b/arch/powerpc/include/asm/=
debug.h
index 86a14736c76c3..dfd82635ea8b3 100644
--- a/arch/powerpc/include/asm/debug.h
+++ b/arch/powerpc/include/asm/debug.h
@@ -46,6 +46,7 @@ static inline int debugger_fault_handler(struct pt_regs=
 *regs) { return 0; }
 #endif
=20
 void __set_breakpoint(int nr, struct arch_hw_breakpoint *brk);
+void __get_breakpoint(int nr, struct arch_hw_breakpoint *brk);
 bool ppc_breakpoint_available(void);
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 extern void do_send_trap(struct pt_regs *regs, unsigned long address,
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.=
c
index 185beb2905801..a0776200772e8 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -865,6 +865,11 @@ static inline int set_breakpoint_8xx(struct arch_hw_=
breakpoint *brk)
 	return 0;
 }
=20
+void __get_breakpoint(int nr, struct arch_hw_breakpoint *brk)
+{
+	memcpy(brk, this_cpu_ptr(&current_brk[nr]), sizeof(*brk));
+}
+
 void __set_breakpoint(int nr, struct arch_hw_breakpoint *brk)
 {
 	memcpy(this_cpu_ptr(&current_brk[nr]), brk, sizeof(*brk));
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-pat=
ching.c
index 54b6157d44e95..3122d8e4cc013 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -17,6 +17,9 @@
 #include <asm/code-patching.h>
 #include <asm/setup.h>
 #include <asm/inst.h>
+#include <asm/mmu_context.h>
+#include <asm/debug.h>
+#include <asm/tlb.h>
=20
 static int __patch_instruction(u32 *exec_addr, struct ppc_inst instr, u3=
2 *patch_addr)
 {
@@ -45,6 +48,59 @@ int raw_patch_instruction(u32 *addr, struct ppc_inst i=
nstr)
 }
=20
 #ifdef CONFIG_STRICT_KERNEL_RWX
+
+struct temp_mm {
+	struct mm_struct *temp;
+	struct mm_struct *prev;
+	struct arch_hw_breakpoint brk[HBP_NUM_MAX];
+};
+
+static inline void init_temp_mm(struct temp_mm *temp_mm, struct mm_struc=
t *mm)
+{
+	/* We currently only support temporary mm on the Book3s64 Radix MMU */
+	WARN_ON(!radix_enabled());
+
+	temp_mm->temp =3D mm;
+	temp_mm->prev =3D NULL;
+	memset(&temp_mm->brk, 0, sizeof(temp_mm->brk));
+}
+
+static inline void use_temporary_mm(struct temp_mm *temp_mm)
+{
+	lockdep_assert_irqs_disabled();
+
+	temp_mm->prev =3D current->active_mm;
+	switch_mm_irqs_off(temp_mm->prev, temp_mm->temp, current);
+
+	WARN_ON(!mm_is_thread_local(temp_mm->temp));
+
+	if (ppc_breakpoint_available()) {
+		struct arch_hw_breakpoint null_brk =3D {0};
+		int i =3D 0;
+
+		for (; i < nr_wp_slots(); ++i) {
+			__get_breakpoint(i, &temp_mm->brk[i]);
+			if (temp_mm->brk[i].type !=3D 0)
+				__set_breakpoint(i, &null_brk);
+		}
+	}
+}
+
+static inline void unuse_temporary_mm(struct temp_mm *temp_mm)
+{
+	lockdep_assert_irqs_disabled();
+
+	switch_mm_irqs_off(temp_mm->temp, temp_mm->prev, current);
+
+	if (ppc_breakpoint_available()) {
+		int i =3D 0;
+
+		for (; i < nr_wp_slots(); ++i)
+			if (temp_mm->brk[i].type !=3D 0)
+				__set_breakpoint(i, &temp_mm->brk[i]);
+	}
+}
+
 static DEFINE_PER_CPU(struct vm_struct *, text_poke_area);
=20
 #if IS_BUILTIN(CONFIG_LKDTM)
--=20
2.26.1

