Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EEBC4332B
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Jan 2021 18:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E26A22473
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Jan 2021 18:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390085AbhATSrQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Jan 2021 13:47:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53650 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390160AbhATRkO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Jan 2021 12:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yRnNjmYT/ZeNDPernGD7mn1nezFUsPnB2CCiwO9XXDo=;
        b=LClsLoEQkI5Hp7hzhwZrezMg6wiALvgwOXsSgPGjVWYS3XceyGIZd7LAqVCYqWEo4oIMoL
        KfFQiDXndrP4xvG13F1acXDb9ZPjcU4vEYWmEK83qD13X9+Ne0f1gN38i2fS9YDQzthpWD
        9ye9xrZhKB3PVRPeVFZPBcbBHm/9h3M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-wP52y3XRPWS9ET7Xl-oe9w-1; Wed, 20 Jan 2021 12:38:43 -0500
X-MC-Unique: wP52y3XRPWS9ET7Xl-oe9w-1
Received: by mail-wm1-f70.google.com with SMTP id z188so1886097wme.1
        for <linux-hardening@vger.kernel.org>; Wed, 20 Jan 2021 09:38:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yRnNjmYT/ZeNDPernGD7mn1nezFUsPnB2CCiwO9XXDo=;
        b=Q5ARhslPm97Udf2+xF2jbDTJeUlQQ2ULnqRNIP8aTSmKqvVWE6XKWmn7Nic2lATc0L
         aeabCJH/D8+8YNM5nKPjYQkab5WkR+J1oUcktJyZ4HbDU6jk77gWfayLUfUG9X46LRwC
         H5uZmCunXxhf7eZNu/1Dm/RgI2axOD2qct/6OMH4u92WlwYYpgJ5zEOuWxPCgPyPE5sD
         ZFmfyY774ceDPhoHum8q5lSEx3/4z2UEc1Js+5HBpaX0/K+1isyCiucUqqxPVGEBpach
         dkRgs2mAPRk+ASGRcayt0FpA/5tbel5nnHR565v2NJvemjiZET1WUV9FRcl3pCMYQo07
         Iqyw==
X-Gm-Message-State: AOAM530xKJnFXvexuuku76h/hgDx+lhPoC8iUA/8DqQEvPK68m4pkWKc
        bVNkJEOOQBfFl58VBoyj2sLRVoNsO82bXcFBQ7fjwBCzcSnWFROSykr6A//LzD3SbQgyBtD7bcX
        H5ila1Aof16qOCKwyrg+Y/sFgagjn
X-Received: by 2002:a05:6000:18a3:: with SMTP id b3mr10468157wri.373.1611164322333;
        Wed, 20 Jan 2021 09:38:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxEuPLL/MUsHXrjcP2RWYCjypmma6HnlV61saf901CvvVF6JcK5tnGFyGuV8565mW/HkAJnQw==
X-Received: by 2002:a05:6000:18a3:: with SMTP id b3mr10468144wri.373.1611164322230;
        Wed, 20 Jan 2021 09:38:42 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:41 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 15/17] objtool: arm64: Handle supported relocations in alternatives
Date:   Wed, 20 Jan 2021 18:37:58 +0100
Message-Id: <20210120173800.1660730-16-jthierry@redhat.com>
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

Based on get_alt_insn() in arch/arm64/kernel/alternative.c, arm64
alternative code adapts offsets for static branches and adrp
instructions.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/special.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/arm64/special.c b/tools/objtool/arch/arm64/special.c
index c9c3e0bfd581..d47e5590ed60 100644
--- a/tools/objtool/arch/arm64/special.c
+++ b/tools/objtool/arch/arm64/special.c
@@ -30,7 +30,11 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
 				 struct instruction *insn,
 				 struct reloc *reloc)
 {
-	return false;
+	u32 opcode = *(u32 *)(insn->sec->data->d_buf + insn->offset);
+
+	return aarch64_insn_is_branch_imm(opcode) ||
+	       aarch64_insn_is_adrp(opcode) ||
+	       !aarch64_insn_uses_literal(opcode);
 }
 
 static struct section *get_switch_table_info_section(struct objtool_file *file)
-- 
2.25.4

