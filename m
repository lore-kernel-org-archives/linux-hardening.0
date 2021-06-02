Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F802C4708F
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Jun 2021 20:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55F3B613EA
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Jun 2021 20:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhFBVAI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Jun 2021 17:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhFBVAH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Jun 2021 17:00:07 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A79C061756
        for <linux-hardening@vger.kernel.org>; Wed,  2 Jun 2021 13:58:24 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id q25so3170129pfh.7
        for <linux-hardening@vger.kernel.org>; Wed, 02 Jun 2021 13:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nArN1r78vaOvHv/VuXchBWF7aTVLFLFg7TatmXuNnm8=;
        b=JP/lfhP8mKZT2FZ7oyzfZwmEOzZCe11cmZQRivpG9B4lijtim35gvlcrWwl1PXr3or
         HixccN4Wdktu0dbau/BtMU9jkEt6O+poY1xsouDgYQSNq4bjoXcftFS8unk6lA9xkOcl
         V3dmVAMtg+BNUWlDKvv04rv/3fmU77EjE3t98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nArN1r78vaOvHv/VuXchBWF7aTVLFLFg7TatmXuNnm8=;
        b=YRYYuMdaK7KK06USsqJ2Y44topE5V3zjGfNj30iWvvCK4qsdNhKTOIoGGrz5v0++aJ
         v2/n60jrMDfEyruru7cMYaL1uPK9MrdSIDiMC65nIB4Ez5r++mQXS/K7gWPO/RuDCBzE
         Mvc4ZlO3rU+r8v6iUBgj5GWLbPvvZH8X/m3qG6uvjl9hLWooEhWND50OtVfnCDGD5CaZ
         0sAEIzMQP15n5BhXxAtAn3se2OurEEi2zSYro1WBQdR+wLShpprDNjJmk1wqC/sCRX2F
         j2uv1vQbsX0WPSklM1pbSClY2YUhT4PZb2NFSx/xlwlcLBCNOPG2kwZvieZP/x8IsRV2
         D7cA==
X-Gm-Message-State: AOAM532F3JDJYr2+NX/IXtGWa5Q7rA4g7TfCZSSlYlfqYN+gjUY39mAU
        G+/VEB+nlbQvOj97785tnP9fNA==
X-Google-Smtp-Source: ABdhPJwJZxJa96y31AaDzXH+m2XwM9AWhSlzDLpgj2RugUjUogkJiZnaxBb/6GIApWloivcNO6dxcw==
X-Received: by 2002:a63:7204:: with SMTP id n4mr36385133pgc.78.1622667504096;
        Wed, 02 Jun 2021 13:58:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o17sm618351pgj.25.2021.06.02.13.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 13:58:23 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jay Vosburgh <jay.vosburgh@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3] net: bonding: Use strscpy_pad() instead of manually-truncated strncpy()
Date:   Wed,  2 Jun 2021 13:58:20 -0700
Message-Id: <20210602205820.361846-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=2e11e60ff27ee8b34974fbad6036bc136589716a; i=HjH5SohPsTIA+ATf9MAz+FmJX9yY3N0haOkHTcGQcac=; m=18UDZYY/68QHWKtZdgvmTol8lJm0hlosSnAKcsyXgI4=; p=DNYQYvFG1gRT/TAGQtHMHwmlxYhPMjyU3dkOCM2XDVI=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmC38OsACgkQiXL039xtwCae2xAAoNv o/7bpXPBKOahHSRsZ0kh/GDtEnAFmgCExukTsbrFbHPXcMX45G6Eh2lhbsTrYlDgasa8Mz+quqzFe UpEUU1I6BiNs5Xz31YSM/jgdyh09HRKIrVKbyBpVUHYxhp8si/DpEMKCAOjp6RqCuW3YG+8tjQUFr 40UUkUcqrCh2lx7g5ElYjTG1sAFc2o2MgTWgNSs4eIbaCfNo2kHTI1+IgwWkPfzC3EZKM5lsy1xiJ omRPX5blHuj0b+wD7absV36LjqkAw5UF8UjqxtRGBF+vc3sxubIUuHT/D9CX/Qn9s6Dvp170edWLD Zm7lT7qQNnCzcdVAGzcgmz2nDLihsA5RFBL3/qnBwvFuXTl66ibgrKEPE9jx2OliAqlta5XG+1FnS iDxt4d2c+qHzJR60YOyMJkrPQLCLqZYqSc879keDPsipkRIevzFNb4lW+dyUnYpJGU1uml4zzoAOV 37MRn+HnPTsnPA5tQSdQG+/DeM8xTWXQ8kcOwzUU/SNl0bJa/KaLXwtTcHlhvzCt5HsoYNUXSv+nn 1/V1l5sJO69cvRepC1BcjNjtxASyo8r9oJRLCAxqr4BpMKB2gP8Y33llLn3Wg7EeLE2OU7DgtrPXF 1SLpetJm9GC8XS0i0iqWq5LjPQ55zPbt6atoZQrsqdRvYUXIZs6CUnpctQT0pDxY=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Silence this warning by using strscpy_pad() directly:

drivers/net/bonding/bond_main.c:4877:3: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
    4877 |   strncpy(params->primary, primary, IFNAMSIZ);
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Additionally replace other strncpy() uses, as it is considered deprecated:
https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202102150705.fdR6obB0-lkp@intel.com
Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3: - other files in drivers/net/bonding/ too!
v2: https://lore.kernel.org/lkml/20210602203138.4082470-1-keescook@chromium.org
v1: https://lore.kernel.org/lkml/20210602181133.3326856-1-keescook@chromium.org

---
 drivers/net/bonding/bond_main.c    | 8 +++-----
 drivers/net/bonding/bond_options.c | 3 +--
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index c5a646d06102..e9cb716ad849 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -620,7 +620,7 @@ static int bond_check_dev_link(struct bonding *bond,
 		 */
 
 		/* Yes, the mii is overlaid on the ifreq.ifr_ifru */
-		strncpy(ifr.ifr_name, slave_dev->name, IFNAMSIZ);
+		strscpy_pad(ifr.ifr_name, slave_dev->name, IFNAMSIZ);
 		mii = if_mii(&ifr);
 		if (ioctl(slave_dev, &ifr, SIOCGMIIPHY) == 0) {
 			mii->reg_num = MII_BMSR;
@@ -5329,10 +5329,8 @@ static int bond_check_params(struct bond_params *params)
 			(struct reciprocal_value) { 0 };
 	}
 
-	if (primary) {
-		strncpy(params->primary, primary, IFNAMSIZ);
-		params->primary[IFNAMSIZ - 1] = 0;
-	}
+	if (primary)
+		strscpy_pad(params->primary, primary, sizeof(params->primary));
 
 	memcpy(params->arp_targets, arp_target, sizeof(arp_target));
 
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index c9d3604ae129..81c039531e66 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1206,8 +1206,7 @@ static int bond_option_primary_set(struct bonding *bond,
 		RCU_INIT_POINTER(bond->primary_slave, NULL);
 		bond_select_active_slave(bond);
 	}
-	strncpy(bond->params.primary, primary, IFNAMSIZ);
-	bond->params.primary[IFNAMSIZ - 1] = 0;
+	strscpy_pad(bond->params.primary, primary, IFNAMSIZ);
 
 	netdev_dbg(bond->dev, "Recording %s as primary, but it has not been enslaved yet\n",
 		   primary);
-- 
2.25.1

