Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D22C4708D
	for <linux-hardening@archiver.kernel.org>; Fri, 28 May 2021 18:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1186E613D1
	for <linux-hardening@archiver.kernel.org>; Fri, 28 May 2021 18:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhE1SPS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 28 May 2021 14:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhE1SPR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 28 May 2021 14:15:17 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F45C06174A
        for <linux-hardening@vger.kernel.org>; Fri, 28 May 2021 11:13:42 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y202so3848953pfc.6
        for <linux-hardening@vger.kernel.org>; Fri, 28 May 2021 11:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LhCOa1GkQ+RkJ6+ROCyG5Y6gGwAVgI1Bik3Ds034L48=;
        b=JW2PU4A6nuh+DvIHLIFnraf8gdYYaWUVRnlVUAKY+7hnV9yXkWRYjD/U+ktMQcHjpd
         vOY8Yw7T+EBNq4mgCKqPutAFoyDT6oO8/YSDwz9YvW9iwG/YepPU6OwrZwQv4sfwLf9d
         lxF9Gjuu7HqH6SuNnrvFp2UybC+8VERl8IRf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LhCOa1GkQ+RkJ6+ROCyG5Y6gGwAVgI1Bik3Ds034L48=;
        b=NXVG6ArD14AjLAMWjCY5toLk1CUtg7VRmpd/UcKXWMW/N2K9Eehb5mI1+UYDj6zqJX
         r1oLZaMQrGZ0HjA5SWTJMoXL6OZlveD4YP2QuyiUxlt+NZvgZQhViYG73gRD07CSR4Dr
         ElCqMYer8vkBCxsLNOZFa86k3+8gOhQBVxMMeHVm71oDMLiFFMGEf1juKxdg2zDJzwHu
         psGzsg4HJlofrGznsJR9UYfDP5gEloMbzN3FHRDxWqOt4taszJBy83upBjDa5GQtX36s
         U4+8BvHU5xQEkYoXVlyPArUbMlGNhw96sx+XywHFTSVq62us0yTJKMysqkGOcjvZVnDE
         PJUQ==
X-Gm-Message-State: AOAM533VMSToxVmXMXfoNsFwsgUkSF3INXmPtYmNrjsGcnk2xIuiMyr1
        mcKTI3exDMcNa6shXePQ8viYzA==
X-Google-Smtp-Source: ABdhPJyT8dhG0KylcaBFSiur++TUJ1qmtq/5M9hRb9MA9KxTEj0O/X7td0RTRvYZTbk0I5Xxuji+Ng==
X-Received: by 2002:a05:6a00:1a4f:b029:2e0:754b:88c2 with SMTP id h15-20020a056a001a4fb02902e0754b88c2mr5111414pfv.65.1622225622395;
        Fri, 28 May 2021 11:13:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d12sm4590562pfv.190.2021.05.28.11.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 11:13:40 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Kees Cook <keescook@chromium.org>, Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bradley Grove <linuxdrivers@attotech.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/3] scsi: Fix a handful of memcpy() field overflows
Date:   Fri, 28 May 2021 11:13:34 -0700
Message-Id: <20210528181337.792268-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

While working on improving FORTIFY_SOURCE's memcpy() coverage, there are
a few fixes that don't require any helper changes, etc.

-Kees

Kees Cook (3):
  scsi: fcoe: Statically initialize flogi_maddr
  scsi: esas2r: Switch to flexible array member
  scsi: isci: Use correctly sized target buffer for memcpy()

 drivers/scsi/esas2r/atioctl.h | 2 +-
 drivers/scsi/fcoe/fcoe.c      | 6 ++----
 drivers/scsi/isci/task.c      | 4 ++--
 3 files changed, 5 insertions(+), 7 deletions(-)

-- 
2.25.1

