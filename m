Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C08C7EE45
	for <linux-hardening@archiver.kernel.org>; Mon, 12 Jun 2023 10:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbjFLKvh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 12 Jun 2023 06:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbjFLKvK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 12 Jun 2023 06:51:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067AA868B;
        Mon, 12 Jun 2023 03:35:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E01A623E2;
        Mon, 12 Jun 2023 10:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2DDC433EF;
        Mon, 12 Jun 2023 10:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566137;
        bh=IKwH/tBAoVNQ8juC60qCPJoFqJex7Fupw4VQCFwEX/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b91dLeuUTA5gCmHXmyLkB3Jv08CRttQa4eXxozWUPFOvvYt17+NJlsBCLTfi8qODg
         9u+3t6bfMG+TkRdyb1SfnX6cAOMQCMhXd7QQnE/LezZDBsaaTMIwwIfGzU5EJCzRPo
         5tSRpkqVZBIw0SZD9W3+xs6HqyMcJSgXTLD1ejO4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Palmer Dabbelt <palmer@rivosinc.com>,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Paul Barker <paul.barker@sancloud.com>
Subject: [PATCH 5.15 02/91] gcc-plugins: Reorganize gimple includes for GCC 13
Date:   Mon, 12 Jun 2023 12:25:51 +0200
Message-ID: <20230612101702.184506593@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
References: <20230612101702.085813286@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

mainline commit: e6a71160cc145e18ab45195abf89884112e02dfb

The gimple-iterator.h header must be included before gimple-fold.h
starting with GCC 13. Reorganize gimple headers to work for all GCC
versions.

Reported-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Link: https://lore.kernel.org/all/20230113173033.4380-1-palmer@rivosinc.com/
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
[ Modified to handle differences in other includes in the 5.15.y tree. ]
Signed-off-by: Paul Barker <paul.barker@sancloud.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/gcc-plugins/gcc-common.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -77,7 +77,9 @@
 #include "varasm.h"
 #include "stor-layout.h"
 #include "internal-fn.h"
+#include "gimple.h"
 #include "gimple-expr.h"
+#include "gimple-iterator.h"
 #include "gimple-fold.h"
 #include "context.h"
 #include "tree-ssa-alias.h"
@@ -91,11 +93,9 @@
 #include "tree-eh.h"
 #include "stmt.h"
 #include "gimplify.h"
-#include "gimple.h"
 #include "tree-ssa-operands.h"
 #include "tree-phinodes.h"
 #include "tree-cfg.h"
-#include "gimple-iterator.h"
 #include "gimple-ssa.h"
 #include "ssa-iterators.h"
 


