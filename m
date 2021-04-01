Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB5EC433B4
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 02:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B4F61029
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 02:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbhDACWL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 31 Mar 2021 22:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbhDACWE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 31 Mar 2021 22:22:04 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00843C061764
        for <linux-hardening@vger.kernel.org>; Wed, 31 Mar 2021 19:22:03 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id v23so220436ple.9
        for <linux-hardening@vger.kernel.org>; Wed, 31 Mar 2021 19:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=20t3Z2Ezqb2rE1bConlM4wRSnwABgpWNKfax2QRMFTU=;
        b=RJNxuSFV2ZryyyPhdb4aveR6o/ve/TH5dwmkQyH9JGK/pCGPRU0x37vYcqiRF/DAUz
         5V6VrNeg5+UKezoF2NIy+GY2DrRwlyRjh50aK7fUdoGWnlWTHM9L9ofxViFCatcWEi8B
         1Hrx46JmejpcEDizEKryGNqdrA0AWDBpJAG60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=20t3Z2Ezqb2rE1bConlM4wRSnwABgpWNKfax2QRMFTU=;
        b=g8/oKvKMyQzm9lEyHiTTJSZI+Z95KpwseLDvcBFulRseJk7XJv+Z9eOApRywODCN/8
         gYHyFFEmDe+V55jLXTdWtAnH8EigKLbxt1Bi2PWiZHodUyQ5utOE7EaQsTFj2OXoce2i
         7Tr+LotfYE7c6Y3NfK9xQ8p9tXn3ft31/RSCiQh4Vm9HyYmpea8qk1G3imJuhjaHyGst
         2cC+k39qtJqPMnMnuoGJhnSTY7e8rpBK+trRI2+EoDz5+KEQXp6yXmiGDIMTrIEdptZY
         3hpc9VMA7J/ZmkfNo/0bbzqZVM/1R8NUmMojbyA0fZJpv24njpjWiCs38E/Bwr5PT+MD
         ZOpQ==
X-Gm-Message-State: AOAM5319i2g2luTMAUTxDMZn2T/0+HSgTuXXJYONOJqXRV6whwXNLijT
        jHUi8NR3HewkDqu5A35YH6kmqw==
X-Google-Smtp-Source: ABdhPJxBAcx6D24KzxmFd+pj9t4gcfofw7BBQh+sx/GHayEZD9JnHIua5ZSHoMvJtQyHFATJ7oSRWg==
X-Received: by 2002:a17:90b:608:: with SMTP id gb8mr6386510pjb.121.1617243723473;
        Wed, 31 Mar 2021 19:22:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d24sm3407795pjw.37.2021.03.31.19.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 19:22:02 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] sysfs: Unconditionally use vmalloc for buffer
Date:   Wed, 31 Mar 2021 19:21:45 -0700
Message-Id: <20210401022145.2019422-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=34a00efd11e1dd540ae559d3caaa025b987e11a0; i=MEvu9Y2iWCN6KW+GL93HEcZTxkhRtLohrU2GVi3yOA0=; m=ZrHDDJno4UVWbAnqKUYPeyFpJeXadp0BBU1Hvcnbhyc=; p=qvMzpmM3liwhY3mKtLggzNl9Ebh8tUN/hVmEvpbrtbk=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBlLjkACgkQiXL039xtwCboHxAArg+ DJB8HO7eN/bcreEy22Hw3TxxPs7WfLC+ma3a99ZvoensWPtolE8AoCtHtmbvPAcTiMWWcoCO3dHb4 f1i+eDFiDCJ3jTUOoSfJdzImZtDC0Hosu1Woqx2WNetoaNgIhpdCKVpEMsvTSxYWH++ok23fv6gps J8vENroiX1/HyGSX3cv1GWyLkMhtxs+caqBS01cW+OlfhWMbBhNc+DBLfW73AcAbhBGrzua6MODHh rdROPRuHva/8xIZlSsnmPI8wJswpRP+ORswdnoIxBWbp2ls0UJFD3klZoYB9DT/+JCSzhoGPfBiWU mzUZTPbKu4JKLJuD5f4uFwdX5tY/G4sLKsPtBZKsD2tg56/u1p3v9Au1IU3lSN8FhGH9/NN9LItNF r3uInyKjSUsMo3HoG6S/Gsj2Kdu3RDA6qXmbBLu8GMCmSwJCTrWCUZCayc4LNnswUv23jRj/o9UNQ 4ASSFM5DpZKIbYR7ndpei6zsrbeLJBPsh7ln7TcxDOMtADvhVFFPEhyHi39gd+zrxL7EFAMbGmhYs MWDw1n1sKI2gP77POezKDdsL+BmJWyLuWu8/E4EQi6gThLzay3yf9yVpBl6sdoAmhvbBaTKw/nihp IBbcgJdGJRiVkAmIdCi9eya0bFGB2uzj+jr8fZe3D4WGfwhR37d2UOY2UvhjBohQ=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The sysfs interface to seq_file continues to be rather fragile
(seq_get_buf() should not be used outside of seq_file), as seen with
some recent exploits[1]. Move the seq_file buffer to the vmap area
(while retaining the accounting flag), since it has guard pages that
will catch and stop linear overflows. This seems justified given that
sysfs's use of seq_file already uses kvmalloc(), is almost always using
a PAGE_SIZE or larger allocation, has normally short-lived allocations,
and is not normally on a performance critical path.

Once seq_get_buf() has been removed (and all sysfs callbacks using
seq_file directly), this change can also be removed.

[1] https://blog.grimm-co.com/2021/03/new-old-bugs-in-linux-kernel.html

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3:
- Limit to only sysfs (instead of all of seq_file).
v2: https://lore.kernel.org/lkml/20210315174851.622228-1-keescook@chromium.org/
v1: https://lore.kernel.org/lkml/20210312205558.2947488-1-keescook@chromium.org/
---
 fs/sysfs/file.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 9aefa7779b29..70e7a450e5d1 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -16,6 +16,7 @@
 #include <linux/mutex.h>
 #include <linux/seq_file.h>
 #include <linux/mm.h>
+#include <linux/vmalloc.h>
 
 #include "sysfs.h"
 
@@ -32,6 +33,25 @@ static const struct sysfs_ops *sysfs_file_ops(struct kernfs_node *kn)
 	return kobj->ktype ? kobj->ktype->sysfs_ops : NULL;
 }
 
+/*
+ * To be proactively defensive against sysfs show() handlers that do not
+ * correctly stay within their PAGE_SIZE buffer, use the vmap area to gain
+ * the trailing guard page which will stop linear buffer overflows.
+ */
+static void *sysfs_kf_seq_start(struct seq_file *sf, loff_t *ppos)
+{
+	struct kernfs_open_file *of = sf->private;
+	struct kernfs_node *kn = of->kn;
+
+	WARN_ON_ONCE(sf->buf);
+	sf->buf = __vmalloc(kn->attr.size, GFP_KERNEL_ACCOUNT);
+	if (!sf->buf)
+		return ERR_PTR(-ENOMEM);
+	sf->size = kn->attr.size;
+
+	return NULL + !*ppos;
+}
+
 /*
  * Reads on sysfs are handled through seq_file, which takes care of hairy
  * details like buffering and seeking.  The following function pipes
@@ -206,14 +226,17 @@ static const struct kernfs_ops sysfs_file_kfops_empty = {
 };
 
 static const struct kernfs_ops sysfs_file_kfops_ro = {
+	.seq_start	= sysfs_kf_seq_start,
 	.seq_show	= sysfs_kf_seq_show,
 };
 
 static const struct kernfs_ops sysfs_file_kfops_wo = {
+	.seq_start	= sysfs_kf_seq_start,
 	.write		= sysfs_kf_write,
 };
 
 static const struct kernfs_ops sysfs_file_kfops_rw = {
+	.seq_start	= sysfs_kf_seq_start,
 	.seq_show	= sysfs_kf_seq_show,
 	.write		= sysfs_kf_write,
 };
-- 
2.25.1

