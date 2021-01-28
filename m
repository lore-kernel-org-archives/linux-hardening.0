Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8E6C433E0
	for <linux-hardening@archiver.kernel.org>; Thu, 28 Jan 2021 20:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 921C064E01
	for <linux-hardening@archiver.kernel.org>; Thu, 28 Jan 2021 20:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhA1UNA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 28 Jan 2021 15:13:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39864 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231213AbhA1UJ6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 28 Jan 2021 15:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611864511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xAaYmkPI3SgxXv9WICFqFagDyxX9PqaHRD1OB+S1ECg=;
        b=fXbVGJo5X1O9G84f7NPPwWg3D9tRO5hM21E5ZXOxG5wak5MTzeED9R3yjtLouPUeDTDt8L
        Meg+RZGH48m4XWPs9uWrYhSSBdkeU4JNzygcMdYI5N2bp2JAn6CEmIECYDXu64al9MVip3
        m9D6YYS/ubJN4MzXq8iDKKfazW+YCYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-NR2Tp5ecMk2VgnEgGOS_mA-1; Thu, 28 Jan 2021 15:08:26 -0500
X-MC-Unique: NR2Tp5ecMk2VgnEgGOS_mA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EEE5803622;
        Thu, 28 Jan 2021 20:08:24 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF98260C13;
        Thu, 28 Jan 2021 20:08:22 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Justin Forbes <jforbes@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Jessica Yu <jeyu@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH RFC] kbuild: Prevent compiler mismatch with external modules
Date:   Thu, 28 Jan 2021 14:08:02 -0600
Message-Id: <fff056a7c9e6050c2d60910f70b6d99602f3bec4.1611863075.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

When building an external module, if the compiler version differs from
what the kernel was built with, bad things can happen.  Many kernel
features change based on available compiler features.  Silently removing
a compiler-dependent feature in the external module build can cause
unpredictable behavior.  Right now there are no checks to help prevent
such mismatches.

On the other hand, when a user is building an external module against a
distro kernel, the exact compiler version may not be installed, or in
some cases not even released yet.  In fact it's quite common for
external modules to be built with a slightly different version of GCC
than the kernel.

A minor version mismatch should be ok.  User space does it all the time.
New compiler features aren't added within a major version.

Add a check for compiler mismatch, but only check the major version.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
This is related to the previous RFC I posted:

  https://lkml.kernel.org/r/efe6b039a544da8215d5e54aa7c4b6d1986fc2b0.1611607264.git.jpoimboe@redhat.com

The discussion revealed gaps between developer perceptions and distro
realities with respect to external (out-of-tree) modules...

Backing up a bit, let's please decide on what exactly is supported (or
not supported) with respect to mismatched compiler versions.  Then let's
try to enforce and/or document the decision.

Please stick to technical arguments...


 Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index b0e4767735dc..f281d2587fa5 100644
--- a/Makefile
+++ b/Makefile
@@ -1744,6 +1744,14 @@ help:
 # no-op for external module builds
 PHONY += prepare modules_prepare
 
+# External module compiler (major) version must match the kernel
+ifneq ($(shell echo $(CONFIG_GCC_VERSION) | cut -c-2), $(shell $(srctree)/scripts/gcc-version.sh $(CC) | cut -c-2))
+  $(error ERROR: Compiler version mismatch in external module build)
+endif
+ifneq ($(shell echo $(CONFIG_CLANG_VERSION) | cut -c-2), $(shell $(srctree)/scripts/clang-version.sh $(CC) | cut -c-2))
+  $(error ERROR: Compiler version mismatch in external module build)
+endif
+
 endif # KBUILD_EXTMOD
 
 # Single targets
-- 
2.29.2

