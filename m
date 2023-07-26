Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7A1C0015E
	for <linux-hardening@archiver.kernel.org>; Wed, 26 Jul 2023 21:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjGZV7d (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 26 Jul 2023 17:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjGZV7c (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 26 Jul 2023 17:59:32 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801C51BF2
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jul 2023 14:59:30 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666e97fcc60so274470b3a.3
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jul 2023 14:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690408770; x=1691013570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iUoFgr64KB2UpVOFBQdb3fXLboqR0/gHMpW4+RbUqpk=;
        b=Z8HPE4tqux9CyxPkz0DHpPIV7emD+YjrccBOGvQagV7m7zeQd2XhmCtleXsSrXP10+
         CJ8CgHxSFMBDD23UH3Cy+teLhQOyLyPCtRuFjm9xCfYTqmd97r+/lQau0sibEkb9El5z
         U5+fhSKGcuRphkEJC1usPgP3Jwjq73Y8LJJxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690408770; x=1691013570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iUoFgr64KB2UpVOFBQdb3fXLboqR0/gHMpW4+RbUqpk=;
        b=KqWsmskxlPOCHarva0DhkTJgn0UUT5iAUDZMwnRY/H7D7qqkU1HUQ1fzzKjo1JBLgu
         G919Af16uhprC35MMCjK+jcUNMXOF6nVi3uS7yxgUcGEbzGZKpOYm8sdCh+1B8WhUN6y
         Pk2bItxBvpOcQgnGDpl0Z6Sa7YXEZxYWU4Jpl3vJFjWrgxLE6vx5vPBzMo+lVoTwJ/tJ
         5QWUJ87AoyTQ6NZqRfTSRMYXhEJLa00A3c8k9zgYK/dL8SMi9tTGtr+fl3C/G0PBNLaD
         KQPoH3n1CUiO2WS3ResW5OV46knT2Dw9QfZ1MG8iE2nS5t2/5nEWh3Pz0ynE+RC3C95M
         Fcuw==
X-Gm-Message-State: ABy/qLbfvM0zL6pblxrD3BeCS0Gr0IcSwdzN7Y3OaXDbZ5qpPQZ6t8pH
        cTOfwcWJgM0hZjV0YYHz4zx6Iw==
X-Google-Smtp-Source: APBJJlGMtsTkQRl3Q1kEtlVd9gtXD6S3B4tZ440ZJALLEHm9Mb0ucbFdNihZsWC4Nc83LlcQbiyrmQ==
X-Received: by 2002:a05:6a00:1591:b0:66c:9e97:aece with SMTP id u17-20020a056a00159100b0066c9e97aecemr3488579pfk.10.1690408769927;
        Wed, 26 Jul 2023 14:59:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c25-20020aa78c19000000b0064d57ecaa1dsm94401pfd.28.2023.07.26.14.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 14:59:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Mark Fasheh <mark@fasheh.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] ocfs2: Use regular seq_show_option for osb_cluster_stack
Date:   Wed, 26 Jul 2023 14:59:22 -0700
Message-Id: <20230726215919.never.127-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1193; i=keescook@chromium.org;
 h=from:subject:message-id; bh=QIxFftlsiJNNbEL1xf2v27ZfHLWZozkFWk4Q3E+r9mM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkwZc6HYN97c9dpESG5p2eAapuOSApu4iE/Li50
 W9KrMtx9X6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZMGXOgAKCRCJcvTf3G3A
 JisRD/968M7Y3iHPE7qmqIHWJy71IXr+3Ge8eIMJRB84Sid3S2QsPFDA9ACIx7IBLLbNKGSEUyj
 j94Tsb6DnhkiwlfUiuwZriheWyE/JB7th/vMT0kWogUaGnGdzewknJ0V18LbRh2pL9W6/5d7I16
 zI2JEg7hsPb2OexXnUIWn9LbF81I5LbO4vY3/Ht2haYNwD3ZBZbA52LfGK58uSUcdZ/7yvAVjOq
 5wOxIlqep3pUzsav9fHzPMicAN2E8vBYcueDmLVQlLhqZv3jaXOL4ebzQMoTM8noevWmdM2P2eV
 9Lne391jiQ9U8JWyEte+d1UBkNP4CH3eYvBHiHxeX4LufJZfrZi0YsJvTlTD6R8TjU6+Q9qA7y9
 Xcms//Uf4lqBrXWjtMDGqKazEW7167S6AxiQU3RVVWgu24msDJvPLlDLjeFVMVG+1QcqswUkodH
 Qq2KjDGO3ZEnlFtw8aAPPPxt0p9x9Vm3Psqf1B5OOfLuvxpJVAcXCzxc2nSZTDx53nbPaft/ho7
 Nsqg3p6kViO+OCDCYXFoELhGkNnK1QbTUcWivcuSE9WqeS8lXDWdwHZ80AUHPI1Z8S1rpTOqDQC
 e8sNn+41gfUjWobfsTXhXlyQdh4PyXLGYjubbq1Y86vFVOFdHhVAiI1wZ8mMsKuL1r2P0sVM+IG
 ZJcx0ti m3+rCGBw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

While cleaning up seq_show_option_n()'s use of strncpy, it was noticed
that the osb_cluster_stack member is always NUL-terminated, so there is
no need to use the special seq_show_option_n() routine. Replace it with
the standard seq_show_option() routine.

Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: ocfs2-devel@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
---
 fs/ocfs2/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 988d1c076861..6b906424902b 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -1517,8 +1517,7 @@ static int ocfs2_show_options(struct seq_file *s, struct dentry *root)
 		seq_printf(s, ",localflocks,");
 
 	if (osb->osb_cluster_stack[0])
-		seq_show_option_n(s, "cluster_stack", osb->osb_cluster_stack,
-				  OCFS2_STACK_LABEL_LEN);
+		seq_show_option(s, "cluster_stack", osb->osb_cluster_stack);
 	if (opts & OCFS2_MOUNT_USRQUOTA)
 		seq_printf(s, ",usrquota");
 	if (opts & OCFS2_MOUNT_GRPQUOTA)
-- 
2.34.1

