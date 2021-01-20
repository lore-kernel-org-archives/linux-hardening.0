Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D1AC433E6
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Jan 2021 19:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF62D23403
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Jan 2021 19:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389044AbhATSrM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Jan 2021 13:47:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33740 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390158AbhATRkN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Jan 2021 12:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+7NJAZ5HEs+o3c9ngN8mAhWOXYs+DN99Jpiq66kpMs=;
        b=ZLEzBpVTZR1acq6H6oI1srch/E6CWQbEQN931y6Wg2MvZn0boi3O2xUNG7mezfZHLM+eIz
        3M5rhbXk8GxgLSNKxxOSKl4bLKuGsevG4y1uTYiJ/ZPJwnWwqPktvQ1XOCbijd9jgDVnaM
        jHBYDj81aMQkDsPX0w7RR72nFDrrM2A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-Ejr93Z2aPV6JWu-LQoqrdw-1; Wed, 20 Jan 2021 12:38:41 -0500
X-MC-Unique: Ejr93Z2aPV6JWu-LQoqrdw-1
Received: by mail-wm1-f72.google.com with SMTP id u1so1834162wml.2
        for <linux-hardening@vger.kernel.org>; Wed, 20 Jan 2021 09:38:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h+7NJAZ5HEs+o3c9ngN8mAhWOXYs+DN99Jpiq66kpMs=;
        b=Jd7dqNHdrHydUUrUl6iYMBvLAN2Ln9Wdqh3D3DTh0eIBkKaG3CJhsmI5CVm6rS9onT
         /QgLzGK2ySuoi51JFVul3R4v7vkoVBF8ZzumlZn5Q0R1cKybyP+EBy1uajrajB4eABPX
         u+RtmrfK9A0Fxe6soiAuR6Oy6AKlJUgjAExSJISlsWXvjOdTo6yNd89RgthnH7yEdZFJ
         dmbElE/zNZ3izD6g8qLnk1LsmD2zLiEL/j5DoqWPETB9ciuHQjGuz7bSE5m9CmP0evOY
         Q1JMlkiOJhvwlPXds86nrMytcqRn0miVC5A/wXRzxTZAZGXZkJx4oWOYZAOgwmYClYb1
         dlsQ==
X-Gm-Message-State: AOAM533XwmEhPbzXHkk2Jo6GB4OtwztxMXnGyCOrIqnk54y+eDEusjOp
        yECTb31fGSC2KsqD0+hdNL48UFmDKvhi8QgGnTulOFcDgQgeMfMuegZyEbWCkojYel7BYFqb2w5
        JDW7bZtVYSLjpn5Yqt9ZhGLXp2fCw
X-Received: by 2002:adf:fa92:: with SMTP id h18mr4344313wrr.142.1611164320485;
        Wed, 20 Jan 2021 09:38:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDeWheflvYEpolU09LBJTJ+72qBUJL1UqdbbjxQT7QJExRg0tyCLTSK2CpCQqblVViiEwsaA==
X-Received: by 2002:adf:fa92:: with SMTP id h18mr4344296wrr.142.1611164320375;
        Wed, 20 Jan 2021 09:38:40 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:40 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 14/17] objtool: arm64: Cache section with switch table information
Date:   Wed, 20 Jan 2021 18:37:57 +0100
Message-Id: <20210120173800.1660730-15-jthierry@redhat.com>
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

Section ".discard.switch_table_info", created by the gcc plugin will
be looked up for every dynamic jump in the object file while the section
might not even exist.

Cache the result of the first lookup.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/special.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/arch/arm64/special.c b/tools/objtool/arch/arm64/special.c
index 396b9c5feebd..c9c3e0bfd581 100644
--- a/tools/objtool/arch/arm64/special.c
+++ b/tools/objtool/arch/arm64/special.c
@@ -33,6 +33,19 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
 	return false;
 }
 
+static struct section *get_switch_table_info_section(struct objtool_file *file)
+{
+	static bool first = true;
+	static struct section *info_section = NULL;
+
+	if (first) {
+		first = false;
+		info_section = find_section_by_name(file->elf,
+						    ".discard.switch_table_info");
+	}
+
+	return info_section;
+}
 
 /*
  * Aarch64 jump tables are just arrays of offsets (of varying size/signess)
@@ -64,8 +77,7 @@ struct reloc *arch_find_switch_table(struct objtool_file *file,
 	void *sti_sec_start;
 	struct reloc *text_reloc;
 
-	table_info_sec = find_section_by_name(file->elf,
-					      ".discard.switch_table_info");
+	table_info_sec = get_switch_table_info_section(file);
 	if (!table_info_sec)
 		goto try_c_jmptbl;
 
-- 
2.25.4

