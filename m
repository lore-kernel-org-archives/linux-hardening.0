Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DBDC433E6
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Jan 2021 18:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 026AC20575
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Jan 2021 18:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391851AbhATSrt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Jan 2021 13:47:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32415 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390254AbhATRkQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Jan 2021 12:40:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9GqcdDd08Zk15EP4JDTkI5z15oNQedvKunbBtce3hNY=;
        b=jTFU+jEXfIAJTpCOQAE9vBsP78B6DJUHmJNIGJzoa74ItVa5X79gBypIFXgK9gm9DEHbWU
        V9X6GWGXmuDjOtNQwU3stKj+PhWiHcAsf/jeAl/Yot7CdSIXvE8bijJ54500rDy/g/5iiE
        bVIvjioJfxmUeF+3Sm4YO6BcDHdh65U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-_n2uSHNQOEWt-Iugi5HXAw-1; Wed, 20 Jan 2021 12:38:45 -0500
X-MC-Unique: _n2uSHNQOEWt-Iugi5HXAw-1
Received: by mail-wr1-f69.google.com with SMTP id e12so3133078wrx.14
        for <linux-hardening@vger.kernel.org>; Wed, 20 Jan 2021 09:38:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9GqcdDd08Zk15EP4JDTkI5z15oNQedvKunbBtce3hNY=;
        b=SXJxR1PEpaGM93tX59fPenoaTYKhFlfFV2O0qO+fQ30ldPx/o0zum/pJ4AZfw+WBCG
         Y1OhnDf+fZTSuwqrYMbJdvllQ8fR/AFnrN26J0Xf59CD16P1Jkk4BTPZYx+Nn7fP2ewQ
         pYpq19FRqedCCckV6oI/+guLhpR+r5zsI7DhR2tdHWtGr37TyQVi9b+DhwL0VbPLKTu2
         59j+hDFv5kszaRRPnjEKHhixRdXMEzwOkIiBFJAZbwFuy6piD1Fp3V+n0vOUzf0V90SL
         sxYZXKNhEeeyA/VyTMnO+CQvuznW+IBv3LqDI7C4gYm0RaGf5dj4+WLlpcRyurXcvfYq
         SuAw==
X-Gm-Message-State: AOAM532nrsXEYxi7CpoOfu7WaodHs7/TYYvQvsZ4vy5DJi+HykZI9Guu
        kSg/iFwfwtxAJralYyeNGtucUEncV6TmeTXJRo+4OF/NYp6ZokAoIIVvAqg4CDEdOpHLfZhYs8/
        iTmKB8ybr5W5FALkvf0duZ267emIN
X-Received: by 2002:a1c:6a02:: with SMTP id f2mr5525604wmc.36.1611164323970;
        Wed, 20 Jan 2021 09:38:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz3m5zpvqhoSgn4NA796inwCeJU9v3FtPD1K/BYY6WVb/FI0tRzJHQ322lTzH3clEsPdXWdpg==
X-Received: by 2002:a1c:6a02:: with SMTP id f2mr5525587wmc.36.1611164323845;
        Wed, 20 Jan 2021 09:38:43 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:43 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 16/17] objtool: arm64: Ignore replacement section for alternative callback
Date:   Wed, 20 Jan 2021 18:37:59 +0100
Message-Id: <20210120173800.1660730-17-jthierry@redhat.com>
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

ARM64_CB_PATCH doesn't have static replacement instructions. Skip
trying to validate the alternative section.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/special.c | 12 ++++++++++++
 tools/objtool/check.c              |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/tools/objtool/arch/arm64/special.c b/tools/objtool/arch/arm64/special.c
index d47e5590ed60..aff8577e71e9 100644
--- a/tools/objtool/arch/arm64/special.c
+++ b/tools/objtool/arch/arm64/special.c
@@ -24,6 +24,18 @@ struct switch_table_info {
 
 void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
 {
+	if (alt->orig_len && !alt->new_len) {
+		/*
+		 * ARM64_CB_PATCH has no alternative instruction.
+		 * a callback is called at alternative replacement time
+		 * to dynamically change the original instructions.
+		 *
+		 * ARM64_CB_PATCH is the last ARM64 feature, it's value changes
+		 * every time a new feature is added. So the orig/alt region
+		 * length are used to detect those alternatives
+		 */
+		alt->skip_alt = true;
+	}
 }
 
 bool arch_support_alt_relocation(struct special_alt *special_alt,
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d902697a388e..8840af09f843 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1182,6 +1182,9 @@ static int add_special_section_alts(struct objtool_file *file)
 				continue;
 			}
 
+			if (special_alt->skip_alt && !special_alt->new_len)
+				continue;
+
 			ret = handle_group_alt(file, special_alt, orig_insn,
 					       &new_insn);
 			if (ret)
-- 
2.25.4

