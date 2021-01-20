Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530EDC433DB
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Jan 2021 18:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1BF322473
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Jan 2021 18:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390112AbhATSrw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Jan 2021 13:47:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21824 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390258AbhATRkR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Jan 2021 12:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oYWTEQ/huFSMzsrpwj0azmoT19+DGoe9MjwOTg0OH5c=;
        b=EQwnCL9N9z8dHRYllCZX3VOcqWCbOnp8J38u95Eb6bi/GTqhNZsTC4k9NJL52EiYOxnR8r
        LC0B7rlcODVpeW3Upv20ItoURgXrB4FqbiBpK6lIP4/kGLaaSikQxcMUyL9+zThEDdPT/w
        sxBzSvpnU3a1C3ZUT6uiwhEGjUZOH1I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-DNvWAxM5NkO9yvX4Ega0hw-1; Wed, 20 Jan 2021 12:38:47 -0500
X-MC-Unique: DNvWAxM5NkO9yvX4Ega0hw-1
Received: by mail-wr1-f70.google.com with SMTP id c1so1124277wrx.2
        for <linux-hardening@vger.kernel.org>; Wed, 20 Jan 2021 09:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oYWTEQ/huFSMzsrpwj0azmoT19+DGoe9MjwOTg0OH5c=;
        b=GxSZXpelYsBrL4NdNZpBeYghMaci6xyDCy+HFnyc7nL3JIUq4jZ5gNrRfgHTTA6N8N
         yDst7PE5TsOOkc/jk0iF1Jg7Iyo8+k+Ukc9568aRsG9wd3Avy1GLc+oTfbFygwkAuS1W
         jRuUfloaSrXaOLSp6TshJ2MrBLf4XQfYkKb/IUA4P5t0HQwNdrVei5WTWUBFuUtuWEiW
         RSKW7K5qDjnF4t/c/9R/roi1f1VO8FeQeUru8B5ELPmb/U2WbBtQ7G7/l5/74VSqmeDl
         mOsfADnHyroufHpJzUMkWwZGZQx1ZQ5h0tDyrqBJTH95cLMWWbK0b916bQFYRvNtNPjV
         z4Tg==
X-Gm-Message-State: AOAM5320zYaXhTajyRRAlrlS3z737X1L00p5ufgTMYzcsbWVXWj0brB6
        aZQHvOiNKbbhqRckJiwD26u4ejIeC/QHptnPeZoLRGo0jDlRO5FgF2SrVlThEEn3qn9eKfH7YO0
        MP6Sd/KhtG5IPaPGBXq2SaTXUz/Ww
X-Received: by 2002:a1c:9dd5:: with SMTP id g204mr5387435wme.37.1611164326105;
        Wed, 20 Jan 2021 09:38:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTEEAVF5Wb5DvfyKAa6iIpcJZxKaj/uKR/NeIqD5Cr6bWjyZklj7zuAijYtvvTiqRBg2VXRA==
X-Received: by 2002:a1c:9dd5:: with SMTP id g204mr5387418wme.37.1611164325951;
        Wed, 20 Jan 2021 09:38:45 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:45 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Raphael Gault <raphael.gault@arm.com>,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 17/17] objtool: arm64: Enable stack validation for arm64
Date:   Wed, 20 Jan 2021 18:38:00 +0100
Message-Id: <20210120173800.1660730-18-jthierry@redhat.com>
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

From: Raphael Gault <raphael.gault@arm.com>

Add build option to run stack validation at compile time.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 93a320cc8e03..3f297d61b56b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -185,6 +185,7 @@ config ARM64
 	select MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
+	select HAVE_STACK_VALIDATION if CC_IS_GCC
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
-- 
2.25.4

