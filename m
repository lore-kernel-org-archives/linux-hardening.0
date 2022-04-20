Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C9AC433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Apr 2022 00:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358654AbiDTAqk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 19 Apr 2022 20:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358656AbiDTAqg (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 19 Apr 2022 20:46:36 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Apr 2022 17:43:52 PDT
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F74E205D3;
        Tue, 19 Apr 2022 17:43:51 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5D5D51BF205;
        Wed, 20 Apr 2022 00:43:45 +0000 (UTC)
From:   joao@overdrivepizza.com
To:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     joao@overdrivepizza.com, peterz@infradead.org, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: [RFC PATCH 10/11] linux/interrupt: Fix prototype matching property
Date:   Tue, 19 Apr 2022 17:42:40 -0700
Message-Id: <20220420004241.2093-11-joao@overdrivepizza.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420004241.2093-1-joao@overdrivepizza.com>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Joao Moreira <joao@overdrivepizza.com>

Unions will make function pointers with different prototypes be used through
the same call. This leads into the same call instruction being used for
calling functions with different prototypes, making them unsuitable for
prototype-based fine-grained CFI.

Fix this CFI policy violation by removing the function pointer union in
the tasklet struct.

Signed-off-by: Joao Moreira <joao@overdrivepizza.com>
---
 include/linux/interrupt.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index f40754caaefa..8d5504b0f20b 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -650,10 +650,8 @@ struct tasklet_struct
 	unsigned long state;
 	atomic_t count;
 	bool use_callback;
-	union {
-		void (*func)(unsigned long data);
-		void (*callback)(struct tasklet_struct *t);
-	};
+	void (*func)(unsigned long data);
+	void (*callback)(struct tasklet_struct *t);
 	unsigned long data;
 };
 
-- 
2.35.1

