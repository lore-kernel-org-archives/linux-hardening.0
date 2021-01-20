Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8204C4332B
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Jan 2021 19:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7074F233FE
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Jan 2021 19:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387639AbhATSrE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Jan 2021 13:47:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52402 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387673AbhATRjr (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Jan 2021 12:39:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ybADuVVj33zXJpBTN6zXgGLfnzshZUI1ojUuRxuiGxo=;
        b=CvlhGPSilL2M4xf/bzvy2s8xp83o5ym05ToX3jmd1GcywNCAMVHkNpnnIrGrLX/6udOJyw
        X2fR9d7x3f5/FI6G8BURY2Dh1e1lsr5QnnshDDX/XZ22v3nS8mGZs/cntxfjeVsz8fwmX3
        3bQK2ujM87BzG2U4H6XTnb/S/JQ9C4Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-zAnGhMGZOwCkQlDjatG55w-1; Wed, 20 Jan 2021 12:38:20 -0500
X-MC-Unique: zAnGhMGZOwCkQlDjatG55w-1
Received: by mail-wr1-f70.google.com with SMTP id c1so1123582wrx.2
        for <linux-hardening@vger.kernel.org>; Wed, 20 Jan 2021 09:38:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ybADuVVj33zXJpBTN6zXgGLfnzshZUI1ojUuRxuiGxo=;
        b=taj3s10Es9L6vjqQYH9cblZ2H4t8HUDjWTFPjBxLy0ykVAHXe8i22R6Re99jmz6RIF
         OtlUnJX+t77EN14yrousrsCZW+j71srBLuo0WR7F1bS4xfZqfn5OQ0yLv1ojNkACXeeX
         rnxPQM7/thoHs9XOyAzFc9l3lj6TNR292JJGZcMOUFrHQNWPl+8SmZC/DIzBwhQAMlqo
         E84iledPFO1+ZVjxbx1pQSlgLCSkMMyA+z6XGhQso3VTcaS+jaBVC+/TgkZP25cb6/Dc
         L1+Cy4Iwmi75JjFdLNFqKfhLByzJRM0LThcSclEyfSnfJ/PLRMN1I/FXB2uUhs9PoLWD
         lZIA==
X-Gm-Message-State: AOAM530PH9e/jAjnki3uqZ/CiUNiM2+XJw/IWhwQz9S+8qiR9xp3DhgM
        6VT3uYmvBPaJ5WEaMrqOmETaXwJmxRztPFCkZDBbY3aQsN2sKotrYmai9IY636+PRxZ8tj1EWF7
        jRJnsR4ElFKEDf35vk28MNdSPjyJY
X-Received: by 2002:a5d:5917:: with SMTP id v23mr10790332wrd.308.1611164298825;
        Wed, 20 Jan 2021 09:38:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwCWhKh32IYPGwQ7eOyS6NFprZttJ5fMUAm09DXGKOoX6f0LQRibhfxka+az9xnCWXYUtnyTw==
X-Received: by 2002:a5d:5917:: with SMTP id v23mr10790318wrd.308.1611164298719;
        Wed, 20 Jan 2021 09:38:18 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:18 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 06/17] objtool: arm64: Decode jump and call related instructions
Date:   Wed, 20 Jan 2021 18:37:49 +0100
Message-Id: <20210120173800.1660730-7-jthierry@redhat.com>
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

Decode branch, branch and link (aarch64's call) and return instructions.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 0f312dd1b146..924121b4b466 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -205,6 +205,28 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		}
 		*type = INSN_OTHER;
 		break;
+	case AARCH64_INSN_CLS_BR_SYS:
+		if (aarch64_insn_is_ret(insn) &&
+		    aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RN, insn) == AARCH64_INSN_REG_LR) {
+			*type = INSN_RETURN;
+		} else if (aarch64_insn_is_bl(insn)) {
+			*type = INSN_CALL;
+			*immediate = aarch64_get_branch_offset(insn);
+		} else if (aarch64_insn_is_blr(insn)) {
+			*type = INSN_CALL_DYNAMIC;
+		} else if (aarch64_insn_is_b(insn)) {
+			*type = INSN_JUMP_UNCONDITIONAL;
+			*immediate = aarch64_get_branch_offset(insn);
+		} else if (aarch64_insn_is_br(insn)) {
+			*type = INSN_JUMP_DYNAMIC;
+		} else if (aarch64_insn_is_branch_imm(insn)) {
+			/* Remaining branch opcodes are conditional */
+			*type = INSN_JUMP_CONDITIONAL;
+			*immediate = aarch64_get_branch_offset(insn);
+		} else {
+			*type = INSN_OTHER;
+		}
+		break;
 	default:
 		*type = INSN_OTHER;
 		break;
-- 
2.25.4

