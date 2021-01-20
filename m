Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F135CC433DB
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Jan 2021 18:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D9C22473
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Jan 2021 18:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389273AbhATSrc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Jan 2021 13:47:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60145 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390148AbhATRkO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Jan 2021 12:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ItOqFi7Hkwlfc8KmljIH1mggd+0HU8t9o2eCKjOp56I=;
        b=OGd2gwqEaE99gAi4df4KDH+Q1+yyMItTXEKH6CyGPYwNtMdiiSgc6pXit72XWJEMoiozoc
        AIgjS82UOffeAg8GDHcas5SfK8ufVLCJvxvuGxiDGuJe8pkJt0Qf7RVGd6dAcQn8wD6bQj
        mQXHoSNG2um3Ex5L4BES20lqbCV2yy8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-A8dzeHwKNxqdLsjPcbl2TA-1; Wed, 20 Jan 2021 12:38:39 -0500
X-MC-Unique: A8dzeHwKNxqdLsjPcbl2TA-1
Received: by mail-wr1-f72.google.com with SMTP id x12so1005640wrw.21
        for <linux-hardening@vger.kernel.org>; Wed, 20 Jan 2021 09:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ItOqFi7Hkwlfc8KmljIH1mggd+0HU8t9o2eCKjOp56I=;
        b=im+Vo8CbFwzWXJeW8Diru2B6Am9DfoZZdOHWlSbuT1HD8f+hc+Pe3greGiDh1b8WH9
         xU2gGWwHstW9fkvKkxK+r9XajCnztQ4+9zP9dPx9HPA+05Q0IBCh//o0ylpSuPwaFiKp
         voxncMommaCrnBFbuXTll1MAA/woJQDg4lVLIIOeArP4fT+quIRgEz7N3UTu/26H1ttl
         C05pTalL2SS6MB6ANky69sOAkp61Qkt8nRhnYjXcHCh5HrgmqiODlSM0/06coBwNcDNy
         kxmKvWdpaJTzugGiXHtlodBg5L/c0Omp+mcYcHD8jfs0WA9RNXul79hxDNFir9GVLUAh
         3G2w==
X-Gm-Message-State: AOAM530sD27V6V6HUKrmEpeQXhNAg89pZU1y2UhmxTcQ2Mt+PbNmCq9m
        t55KEdyHdS01T/vto91QE58gruvooj3RehfoTdmjZx9M3CyzTDY/ig32HLhdreYlGra8cm62TU4
        Q2eBdYnIuuck6A0hYtkplkZPr6MJb
X-Received: by 2002:adf:e705:: with SMTP id c5mr10165915wrm.303.1611164318294;
        Wed, 20 Jan 2021 09:38:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyI7z1jfE1krdbjitvV3YQPLDza0TWB9nv2zK4QcJTxmxyvfDnFk8J4YJ4dvyZr3q+eSQSNsg==
X-Received: by 2002:adf:e705:: with SMTP id c5mr10165894wrm.303.1611164318164;
        Wed, 20 Jan 2021 09:38:38 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:37 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>,
        Raphael Gault <raphael.gault@arm.com>
Subject: [RFC PATCH 13/17] objtool: arm64: Implement functions to add switch tables alternatives
Date:   Wed, 20 Jan 2021 18:37:56 +0100
Message-Id: <20210120173800.1660730-14-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210120173800.1660730-1-jthierry@redhat.com>
References: <20210120173800.1660730-1-jthierry@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jthierry@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

This patch implements the functions required to identify and add as
alternatives all the possible destinations of the switch table.
This implementation relies on the new plugin introduced previously which
records information about the switch-table in a
.discard.switch_table_information section.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
[J.T.: Update arch implementation to new prototypes,
       Update switch table information section name,
       Do some clean up,
       Use the offset sign information,
       Use the newly added rela to find the corresponding jump instruction]
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 .../objtool/arch/arm64/include/arch/special.h |  2 +
 tools/objtool/arch/arm64/special.c            | 85 +++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/tools/objtool/arch/arm64/include/arch/special.h b/tools/objtool/arch/arm64/include/arch/special.h
index a82a9b3e51df..b96bcee308cf 100644
--- a/tools/objtool/arch/arm64/include/arch/special.h
+++ b/tools/objtool/arch/arm64/include/arch/special.h
@@ -3,6 +3,8 @@
 #ifndef _ARM64_ARCH_SPECIAL_H
 #define _ARM64_ARCH_SPECIAL_H
 
+#include <linux/types.h>
+
 #define EX_ENTRY_SIZE		8
 #define EX_ORIG_OFFSET		0
 #define EX_NEW_OFFSET		4
diff --git a/tools/objtool/arch/arm64/special.c b/tools/objtool/arch/arm64/special.c
index 45f283283091..396b9c5feebd 100644
--- a/tools/objtool/arch/arm64/special.c
+++ b/tools/objtool/arch/arm64/special.c
@@ -1,6 +1,26 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#include <stdlib.h>
+#include <string.h>
+
+#include <asm/aarch64-insn.h>
+
 #include <objtool/special.h>
+#include <objtool/warn.h>
+#include <arch/special.h>
+
+/*
+ * The arm64_switch_table_detection_plugin generate an array of elements
+ * described by the following structure.
+ * Each jump table found in the compilation unit is associated with one of
+ * entries of the array.
+ */
+struct switch_table_info {
+	u64 padding;
+	u64 jump_ref;
+	u64 nb_entries;
+	u64 dest_relocations[];
+} __attribute__((__packed__));
 
 void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
 {
@@ -14,8 +34,73 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
 }
 
 
+/*
+ * Aarch64 jump tables are just arrays of offsets (of varying size/signess)
+ * representing the potential destination from a base address loaded by an adr
+ * instruction.
+ *
+ * Sadly, extracting the actual offset might require to consider multiple
+ * instructions and decoding them to understand what they do. To make life
+ * easier, the gcc plugin will generate a list of relocation entries for
+ * each jump table target, conforming to the format expected by
+ * add_jump_table().
+ *
+ * Aarch64 branches to jump tables are composed of multiple instructions:
+ *
+ *     ldr<?>  x_offset, [x_offsets_table, x_index, ...]
+ *     adr     x_dest_base, <addr>
+ *     add     x_dest, x_target_base, x_offset, ...
+ *     br      x_dest
+ *
+ * The arm64_switch_table_detection_plugin will make the connection between
+ * the instruction setting x_offsets_table (jump_ref) and the list of
+ * relocations.
+ */
 struct reloc *arch_find_switch_table(struct objtool_file *file,
 				     struct instruction *insn)
 {
+	struct switch_table_info *sti;
+	struct section *table_info_sec;
+	void *sti_sec_start;
+	struct reloc *text_reloc;
+
+	table_info_sec = find_section_by_name(file->elf,
+					      ".discard.switch_table_info");
+	if (!table_info_sec)
+		goto try_c_jmptbl;
+
+	sti_sec_start = table_info_sec->data->d_buf;
+	sti = sti_sec_start;
+
+	while ((char *)sti - (char *)sti_sec_start <  table_info_sec->len) {
+		struct reloc *target_reloc = find_reloc_by_dest(file->elf,
+								table_info_sec,
+								(char *)&sti->jump_ref - (char *)sti_sec_start);
+
+		if (!target_reloc) {
+			WARN("Malformed switch table entry");
+			return NULL;
+		}
+
+		if (target_reloc->sym->sec == insn->sec &&
+		    target_reloc->addend == insn->offset)
+			return find_reloc_by_dest(file->elf, table_info_sec,
+						  (char *)&sti->dest_relocations[0] - (char *)sti_sec_start);
+
+		/* Get next jump table entry */
+		sti = (struct switch_table_info *) (&sti->dest_relocations[0] + sti->nb_entries);
+	}
+
+try_c_jmptbl:
+	text_reloc = find_reloc_by_dest(file->elf, insn->sec, insn->offset);
+	if (!text_reloc || text_reloc->sym->type != STT_SECTION ||
+	    !text_reloc->sym->sec->rodata)
+		return NULL;
+
+	/* Handle C jump tables */
+	if (!strcmp(text_reloc->sym->sec->name, C_JUMP_TABLE_SECTION))
+		return find_reloc_by_dest(file->elf, text_reloc->sym->sec,
+					  text_reloc->addend);
+
 	return NULL;
 }
-- 
2.25.4

