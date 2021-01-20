Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2A8C43381
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Jan 2021 19:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C491233EB
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Jan 2021 19:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390374AbhATSqo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Jan 2021 13:46:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46748 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387500AbhATRjk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Jan 2021 12:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1YEVSMla8UOmgBC4LmzAJMeE/UB0SCvN1vHTnN1GioY=;
        b=OUNLES38jeNuMBGpEzrT2JE15yEy/UPvd4WgvRo5jWsBP0Iv13JRNaYkpA4I26CXk8/h3x
        3NHZyeaEhoiWgyHJOq9199Xfofql6Ii6OG9sJs5Ue4HF9JHbB1DjX5KUamF3QaEmqvUdX2
        GMEEpnanLfjUv1m+Ck1NY5GiV56fWOE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-f6AjM-hyMq-I0f4eFxJmDQ-1; Wed, 20 Jan 2021 12:38:11 -0500
X-MC-Unique: f6AjM-hyMq-I0f4eFxJmDQ-1
Received: by mail-wr1-f71.google.com with SMTP id v5so11966599wrr.0
        for <linux-hardening@vger.kernel.org>; Wed, 20 Jan 2021 09:38:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1YEVSMla8UOmgBC4LmzAJMeE/UB0SCvN1vHTnN1GioY=;
        b=XEqN6WbFtsaKjYls01nQFjwC2IDuzrN6SisEIC9cogLCfKAh+mwU+uIzITkSgn3ETB
         +O6uTZnOdOI958tDDtUXwoT9Z3/TPdm7/6TfeV7cuMxN6LSFnOBm3m9qN4+fCILsbOer
         phQvnjzKFsq7/vCSlpQrA/LqU3BjTnzjdVwc3zHpxIXU8Fgl/SlgfQ/Qpmo/iM0Dp1So
         qL/UOIKXTuzuXJsnplA1VZcQTjMiein1/csOiISkPMqBrtDagFMiO5VtQXUiNrFNyXyr
         zaQiviSvqY1YI12j5LD5IlCpV/z9QBQkHked+B8/Hi/CAO41wozhyNMTcqhNz7BRYtfL
         H00g==
X-Gm-Message-State: AOAM530BsGVUvVOIVnpe4IBQlYDczXnTAKohCSe+gvVwgUhb9EUwm7YV
        WbTLT3A778yfIB/rlaGJdePYFMqBx93BAiZfcP7iFBQVhhp8skTRDAOkKGx+ernXID8mtuwGQ9V
        a+FFaXaEqnWnmE4wnvTIKIs8B9AAe
X-Received: by 2002:adf:d238:: with SMTP id k24mr10316325wrh.414.1611164290573;
        Wed, 20 Jan 2021 09:38:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsXKBygCbH5ehSM3hv+i9wV2hjiG6FmiP83Wor2Wz+s8QTVOj8s3jD6nPK36EhOefk08Au5A==
X-Received: by 2002:adf:d238:: with SMTP id k24mr10316310wrh.414.1611164290420;
        Wed, 20 Jan 2021 09:38:10 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:08 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 03/17] tools: bug: Remove duplicate definition
Date:   Wed, 20 Jan 2021 18:37:46 +0100
Message-Id: <20210120173800.1660730-4-jthierry@redhat.com>
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

Under tools, bug.h only defines BUILD_BUG_ON_ZERO() which is already
defined in build_bug.h. This prevents a file to include both headers at
the same time.

Have bug.h include build_bug.h instead.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/include/linux/bug.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/include/linux/bug.h b/tools/include/linux/bug.h
index 85f80258a15f..548be7cffa8e 100644
--- a/tools/include/linux/bug.h
+++ b/tools/include/linux/bug.h
@@ -2,10 +2,6 @@
 #ifndef _TOOLS_PERF_LINUX_BUG_H
 #define _TOOLS_PERF_LINUX_BUG_H
 
-/* Force a compilation error if condition is true, but also produce a
-   result (of value 0 and type size_t), so the expression can be used
-   e.g. in a structure initializer (or where-ever else comma expressions
-   aren't permitted). */
-#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
+#include <linux/build_bug.h>
 
 #endif	/* _TOOLS_PERF_LINUX_BUG_H */
-- 
2.25.4

