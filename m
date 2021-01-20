Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C8EC4332D
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Jan 2021 18:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99747206FA
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Jan 2021 18:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387654AbhATSrG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Jan 2021 13:47:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49334 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387718AbhATRjv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Jan 2021 12:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D/xnDCC8nOFGfsA+lStDur0FhQOLzj3Vyiz97OzDpc8=;
        b=T2baS5S+bzp02+/w25BV4Y1PxktkPaIywqjxwv78+CsJ8l7XZ8kchsWuqW91uefBgrWSm8
        jh1EITJdevr8/Mji67hTSxi6k0qR7WfzIuQLuU4HC8bBZ7zAThDm7ZtFsJX8vtZxMOUEEm
        qs4M7eIh2SesYAzOkIoRhPveFjoS7BU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-w6li-cQ2OEKjdX6gZZdSlg-1; Wed, 20 Jan 2021 12:38:21 -0500
X-MC-Unique: w6li-cQ2OEKjdX6gZZdSlg-1
Received: by mail-wr1-f71.google.com with SMTP id n11so11936503wro.7
        for <linux-hardening@vger.kernel.org>; Wed, 20 Jan 2021 09:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D/xnDCC8nOFGfsA+lStDur0FhQOLzj3Vyiz97OzDpc8=;
        b=NtkTfTCT9w+W4pOAVmYyjiwXIc1yKnqlt+mo5ELDs1lNmuTiBK1z02M83JlvsHY31f
         J7PYEhOKTIQKgW5mrwutV8VTgJU8ieUiKrZnemc9i9T01ByHpOfrKTPDWhpeJNtXY5Kg
         Rol24CgpE+L6ZLV6HOpGSlDDJq1zSFXRxyOMsymC/lGIQviOf+mF587LmtBPNqFYSoCD
         imGyj5uIK0CHfePph+7x7SJnJ5lC3A+wEP4bXCLiWLQDYMQmi2gRYDwYsqZAsiIUKa4b
         vQoQE91oxLVh/dOyIkYLeUoBro7VhyF29pwqpObhIb5evY0T/NWolxRCuy/q8h3eMQEF
         F/tg==
X-Gm-Message-State: AOAM532pqhiT77k50pLwc6AWtOGREQAFPKoLY18STiiVGRueF8viqi7J
        qLGtQ6hu2aGm8dUf3I84SKINHRJp2t/RMPommh2oPWFNn5Z7A7OW38MNH6x7SXpjnrE97cKiJYI
        phDOa3H8aUtUbO7y1eM0a4ahr+ZzQ
X-Received: by 2002:a5d:660c:: with SMTP id n12mr10531783wru.291.1611164300887;
        Wed, 20 Jan 2021 09:38:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5Gt3Pu1qW2EdggZtB7MguFp/4lDK5HfkXjM4AsXdknZgXR2j5+4eIlyKpZr1CO2oaPexByA==
X-Received: by 2002:a5d:660c:: with SMTP id n12mr10531762wru.291.1611164300731;
        Wed, 20 Jan 2021 09:38:20 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:20 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 07/17] objtool: arm64: Decode other system instructions
Date:   Wed, 20 Jan 2021 18:37:50 +0100
Message-Id: <20210120173800.1660730-8-jthierry@redhat.com>
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

Decode ERET, BRK and NOPs

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 924121b4b466..a4a587c400a1 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -223,6 +223,13 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			/* Remaining branch opcodes are conditional */
 			*type = INSN_JUMP_CONDITIONAL;
 			*immediate = aarch64_get_branch_offset(insn);
+		} else if (aarch64_insn_is_eret(insn)) {
+			*type = INSN_CONTEXT_SWITCH;
+		} else if (aarch64_insn_is_steppable_hint(insn)) {
+			*type = INSN_NOP;
+		} else if (aarch64_insn_is_brk(insn)) {
+			*immediate = aarch64_insn_decode_immediate(AARCH64_INSN_IMM_16, insn);
+			*type = INSN_BUG;
 		} else {
 			*type = INSN_OTHER;
 		}
-- 
2.25.4

