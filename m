Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687B5C47083
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Jun 2021 20:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F60460C3F
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Jun 2021 20:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhFBUd0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Jun 2021 16:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhFBUdZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Jun 2021 16:33:25 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96303C06174A
        for <linux-hardening@vger.kernel.org>; Wed,  2 Jun 2021 13:31:42 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id o9so416638pgd.2
        for <linux-hardening@vger.kernel.org>; Wed, 02 Jun 2021 13:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bSLR915keJcdTviRaDzw8PP4+JBptlr8rMLWUQhfRuo=;
        b=Sb/s5Ta+iWJ5VwUoH6Abdz1NLrs8aMm55RMVQ67D7La3FWEIqrHgfSBfa8W9bx5cAZ
         Zg1zqJkllqfjVy7sOZx5DrIvRS+EOU7CVDLSmqE3oI8EsH/w3nQVF/bdQFxntxPabOHH
         ff4aOrt12y6LQLBvevJNH6p4ITV3poo70Yj1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bSLR915keJcdTviRaDzw8PP4+JBptlr8rMLWUQhfRuo=;
        b=BQSN1zaduM4RJK2s5YgG344BRYmAYO3KY05Wg54N3ALKGqgAt8XdY6J4MpPcC9NghT
         edavNdPrDjhiPVUxdETa2IFmTgSHH4xE3j9PGSXZtRcD2HHVm+tdhhNnuGODtDiIDmgS
         3PdyEPG48kO7kIozrA4TMKLvDYlvkEDSD3V5vlKn1FEG4olUPp4T2oS72W+u/MbkwIv6
         2Qv+4H6cJOxPrbm1BWY3JFx4HNAkrY6abUsBCwzFgPa8ukMdwvN6YbxK3IzrDiovql0m
         00kzhpyXYptBLVXLDW1K42luTgZISBFoyDYEuPGSKxKQYJRZ98Mb+yjpB7DldhFMKlGY
         xhXg==
X-Gm-Message-State: AOAM533xInPmd/BPW9EzjS8KRFhWY4eNPeamf2ozZ8L5vwVtLIzbKuYX
        PJyLbiyK/3UfmS2IE8402TXd5A==
X-Google-Smtp-Source: ABdhPJwkeG+5ULmlupCWiLWWBtxNfWEoWmRN5lTAgQJBBL8sKP395AQjhB6kTa9TliCZh2v4p5ivbQ==
X-Received: by 2002:aa7:8a12:0:b029:2ea:2690:7d66 with SMTP id m18-20020aa78a120000b02902ea26907d66mr3778613pfa.8.1622665902194;
        Wed, 02 Jun 2021 13:31:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p6sm378047pfh.166.2021.06.02.13.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 13:31:41 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jay Vosburgh <j.vosburgh@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] net: bonding: Use strscpy() instead of manually-truncated strncpy()
Date:   Wed,  2 Jun 2021 13:31:38 -0700
Message-Id: <20210602203138.4082470-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=a8037d5f76b0c6b374a5a7856a0340dda096eca9; i=+jq1hjyNarBiZF1iCP+ld51I3zySb92TJIxasbU5Dvg=; m=EBWMWbArZClnv/4HRsZOTu5Fjt37QDxBNb2o2f6hgzg=; p=cV40uWr3yIccruWHZ5/NoNE/0PYjMA+rbgzhfh1qkcQ=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmC36qoACgkQiXL039xtwCasChAAqty 3o0rpXgX99jLLZM6+nDi1Y4rVnaI/j8VHgpBnSTmV48Io6oefI1DQnbiCCKMgzDMbpKypc3ut3532 lGKnU06nhaWIVv4vnrRTIZ1kRWAqp2EasUmIDSRzFhZEc3U5KN7wVNFpPnoTzntll0XNAiXHSdY1X xp8g1i32h4JtjWc+81pX6qm6rr1FuMIEjNnOnQdSGpa8J/l4f+i8aXyOYOltGLur417CDm4DOf6Ev 7pao129MpTIFuFb7mxM6NrKTeZsSb3U2BuHcyg3dyHGw3N6FcqZS0WKLFKp4jnGMrNh/QiwOEqN2G oGqxaahWJriHjfV4Tjop4SFVvd0sOVCfVxFyBHquV3n9NohQPFwUov5uQ/weW/cmgNskKyLqnUvbw 1gMF0wvTIvYHrlIas9bhnLNQNWFt5QwTDX5DZm8boZQJjPbBjib8+iDXAb2nTxQUeztOM9imtCTo8 KzYFRtMvA4ENZhJHX8IotRzSc5HF/HJwINvfhBpGxYugYYy3l50OoCLITqBEKhHEM5pBtOX5zxLKg i5zNhjLTEZFVttGz8yprauY8dx+DR6xsv4U88Q3n14tu7hMCYM3DnYQAZoQD6hspcMdtVznldecbM QonsnJ6ReUixWzQxDyAsJztvOGVIeP70m4VyDVZ5Esfq86hE0IIaPPCBV15zudto=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Silence this warning by just using strscpy_pad() directly:

>> drivers/net/bonding/bond_main.c:4877:3: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
    4877 |   strncpy(params->primary, primary, IFNAMSIZ);
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Additionally replace other strncpy() uses, as it is considered deprecated:
https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202102150705.fdR6obB0-lkp@intel.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2:
 - switch to strscpy_pad() and replace earlier strncpy() too
v1: https://lore.kernel.org/lkml/20210602181133.3326856-1-keescook@chromium.org
---
 drivers/net/bonding/bond_main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

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
 
-- 
2.25.1

