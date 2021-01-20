Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08742C433E6
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Jan 2021 18:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4831233EB
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Jan 2021 18:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390158AbhATSrO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Jan 2021 13:47:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51772 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389952AbhATRkN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Jan 2021 12:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611164316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oGGCmA0OrDAFQ859/Q0LnejciDnPGfHlYFyTyvifQtk=;
        b=SdvcoaL9xGpZqU5uAkooZs4maGhL8HgONkM9y34yVuJfD3GrlKwEXFCQJuBBfP+ITM3HWh
        BZShwe5JfC1bxLICpZDsaW5tFM9jlr02Q+fNxkAMmE80ZpvMNKMwRvOsOTI1gcLFskHhZk
        oRJZwSOOetFPBhFUC7dG0vcG+VAiQ8E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-siLksifmPHWJFL9NN0yoDw-1; Wed, 20 Jan 2021 12:38:33 -0500
X-MC-Unique: siLksifmPHWJFL9NN0yoDw-1
Received: by mail-wm1-f70.google.com with SMTP id j133so1434176wma.4
        for <linux-hardening@vger.kernel.org>; Wed, 20 Jan 2021 09:38:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oGGCmA0OrDAFQ859/Q0LnejciDnPGfHlYFyTyvifQtk=;
        b=nRcEfW4OLRdhnASd0QVTpbCbA68kTfbCGpYcBSSlu4uxbLnTDzZQ385Moy9GK6rSXv
         rAvagcQXSR874Z9qLd8moixBOx+yDOJquHacnSKVbmhG4Oku0mFE/7wqNz1Ks95O4Ak0
         At3ombBVFjN4HP1kOV1zvY2oq+o9KrHyg4q8Kr05k8dbznDzOWtAJ1/cGTZWoXpZ0E6S
         etwwA6/NbYEgOe4LbhOhoDSMbkV0QPj1RTRuOebX/X2wErbNQNnHSEEv2lDMF3EZ2TV1
         t3QXYx7VE6YTcYSYa1ysE7G4bXjNtx+vf4zDwNkb6F2oXbxnbJBuFnhx3uVNydSC7wMP
         GRVA==
X-Gm-Message-State: AOAM532UAn5DmwYTwkYWvC8os7tSaqy9QXF981x+Ie0pP9PG8qFGDijP
        ihHE03xGzwpFH8j8mzOcozIDGxxIFV5e43FXYIlXOj6dX10wr3L0nfGTVdbKtxMT4yVyKjP+Apu
        2hyKGlH2fJHu/GXy5v49lIuZi8dJ3
X-Received: by 2002:a5d:4a09:: with SMTP id m9mr10650931wrq.359.1611164311855;
        Wed, 20 Jan 2021 09:38:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJykIx+mFRDz39bWZUr6EuNu+ftrUmcrlFbF3bvA/9HzFKbHf9ER+LSC2Ppw5dI+TMNMsSLSCQ==
X-Received: by 2002:a5d:4a09:: with SMTP id m9mr10650911wrq.359.1611164311737;
        Wed, 20 Jan 2021 09:38:31 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x11sm4948325wmi.4.2021.01.20.09.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:38:31 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        michal.lkml@markovi.net, jpoimboe@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, broonie@kernel.org,
        linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 11/17] efi: libstub: Ignore relocations for .discard sections
Date:   Wed, 20 Jan 2021 18:37:54 +0100
Message-Id: <20210120173800.1660730-12-jthierry@redhat.com>
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

EFI stub cannot have absolute relocations in sections affecting the
execution flow. However, for sections that get discarded at link time,
it doesn't really matter if they have absolute relocations.

Ignore the relocation associated with such sections.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 drivers/firmware/efi/libstub/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 8a94388e38b3..70e9c7f45d30 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -133,7 +133,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 #
 quiet_cmd_stubcopy = STUBCPY $@
       cmd_stubcopy =							\
-	$(STRIP) --strip-debug -o $@ $<;				\
+	$(STRIP) --strip-debug --remove-relocations=".discard.*" -o $@ $<;		\
 	if $(OBJDUMP) -r $@ | grep $(STUBCOPY_RELOC-y); then		\
 		echo "$@: absolute symbol references not allowed in the EFI stub" >&2; \
 		/bin/false;						\
-- 
2.25.4

