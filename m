Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22F2C433E0
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Jan 2021 18:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9333622473
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Jan 2021 18:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388494AbhATSrJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Jan 2021 13:47:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25862 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389044AbhATRj7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Jan 2021 12:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TunnN2Rmw/3iiIk96y5NqcKwVnXUUTnNVIzyUwYw5qc=;
        b=hCwLJDptZta01c4AkW37P6ZZumalO6QPV+GKta5r/c0jrM0xqvBarEsPc8nkhwDomgwTxT
        qSwyXVmlvWGcZWoXZzmQJjAstl9hBhYHHv76eMxb6IlG2VPoBDrkYeLSFD/LyySBMavXRn
        r0QG2eb00JpEc+aDMzx+2oG64XAQE8I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-D9royJcNPOOoa7sEqcx6bQ-1; Wed, 20 Jan 2021 12:38:30 -0500
X-MC-Unique: D9royJcNPOOoa7sEqcx6bQ-1
Received: by mail-wr1-f71.google.com with SMTP id x12so1005343wrw.21
        for <linux-hardening@vger.kernel.org>; Wed, 20 Jan 2021 09:38:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TunnN2Rmw/3iiIk96y5NqcKwVnXUUTnNVIzyUwYw5qc=;
        b=Nj7O1u5Qa1DdSZ7b90AA4R96XtpGEjAW4yApVHkMevmjV0fOK7AZ+hEwj379so6oyl
         kZ/bpCSq+a2uPPg5iu1hD0oJ8yxU+8PrFC9y8iN3j26j1gpvxIu3R/M5+YJWQHbOdqDr
         KExzaR5R2MyDHpkl7bc+3DLcfhRopSWNc/1QPObHiwKAPpBTCthHee2ST0mHzhf35PNe
         A1W+s+HdMT2w7sbv+6hlCBHwc2qSQ21HqVMtqe5ym039kEc9VG066yR2lFfF2gg2w4Pf
         ymbwr/SB4FIFCxcxgMZKtX3NVlTosgImcpBU3wyfzDfnrJA1MWhvW9KkHGGmD8+325c7
         QH6w==
X-Gm-Message-State: AOAM533p91w5tjl/AxqdWCV9Tflk/vL2oivMv1DNaDGCii/C0eGA4ZUe
        vm1dwzp1mcK65gEGC+ZmsSsdGRdW31juQAF55dgdDMlLsO/Bo4YWE/LGBOEuRHd/WiAGdY7Rq0O
        skFUJ2F0zMW72ZyqwyXKAMN+d8ASZ
X-Received: by 2002:a1c:a501:: with SMTP id o1mr5442914wme.21.1611164309133;
        Wed, 20 Jan 2021 09:38:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdkiqIhQMa9qAcvB3y1xPRPRu1ifQGBBsVjTbJnRN8ssR5UHer5yLxDQqnoMtLa25rFV9xTQ==
X-Received: by 2002:a1c:a501:: with SMTP id o1mr5442896wme.21.1611164308963;
        Wed, 20 Jan 2021 09:38:28 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:28 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 10/17] objtool: arm64: Accept padding in code sections
Date:   Wed, 20 Jan 2021 18:37:53 +0100
Message-Id: <20210120173800.1660730-11-jthierry@redhat.com>
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

The compiler can introduce some '0' words in code sections to pad the
end of functions.
Similar to load literal functions, record these zero words to remove
the "struct instruction" created for them.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index b4d4d5b051b0..ed5ef0b52bbe 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -362,8 +362,23 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 
 	switch (aarch64_get_insn_class(insn)) {
 	case AARCH64_INSN_CLS_UNKNOWN:
-		WARN("can't decode instruction at %s:0x%lx", sec->name, offset);
-		return -1;
+	{
+		/*
+		 * There are a few reasons we might have non-valid opcodes in
+		 * code sections:
+		 * - For load literal, assembler can generate the data to be
+		 *   loaded in the code section
+		 * - Compiler/assembler can generate zeroes to pad function that
+		 *   do not end on 8-byte alignment
+		 */
+		/* Compiler might put zeroes as padding */
+		if (record_invalid_insn(sec, offset, insn == 0x0))
+			return -1;
+
+		*type = INSN_OTHER;
+
+		break;
+	}
 	case AARCH64_INSN_CLS_DP_IMM:
 		/* Mov register to and from SP are aliases of add_imm */
 		if (aarch64_insn_is_add_imm(insn) ||
-- 
2.25.4

