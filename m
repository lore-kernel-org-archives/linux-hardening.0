Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD85C432BE
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 04:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B737761058
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 04:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbhHREbO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 00:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237378AbhHREbN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 00:31:13 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5872CC0613D9
        for <linux-hardening@vger.kernel.org>; Tue, 17 Aug 2021 21:30:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso8040673pjh.5
        for <linux-hardening@vger.kernel.org>; Tue, 17 Aug 2021 21:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a0LOe5TP/MBO2wNeDbghMruuMrb9dKCIPmMRCLEki+o=;
        b=eDN/L6WuO3TyTi0qDmqtH9D45GKtl3b2ANmz/AMyOyEVKFYG/4Yuyy0Gh7FDbN5bWe
         WBNYwmuDJ+LaXEImCFGYICnkvJLJFiWev+0DLPABDkQXJptxMHh8soPhf4P4IpwnQnV4
         X0ypgxMF7PN/NHuYeGGKeNdYkajLrqlMYFBRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a0LOe5TP/MBO2wNeDbghMruuMrb9dKCIPmMRCLEki+o=;
        b=iJDJRBmsWcs6K3I+XzBFwTCP2gDZ1DqAmYvAx5emwaq+gviWXM7NRXP/HKI7ExHLCN
         oilqVHtp/ifek6vu1btz3vf2fdHGYgiWHi2nUFwKBI51mROyg7pY670k1xs+LVIr4CMB
         PkskHNGEuyQR/au9L7nsEs0qTns759QYdfvLWmMsC2GdjOAR0jemnkysfoC4dnL/5jcw
         GzdLGRFM0gnC0NRxOhUKrrak/OeRStIG3Hpz1HXySwky3B1WbspnvCRyq0sDaZgpkp00
         nRR61rqrQmWMxnz29a3MQGAaXhUEfhs7aCjARhn6Q6/6vYKXdBiRetii9JWJtakxmSma
         JT1A==
X-Gm-Message-State: AOAM532Q3kA4p2kpW2eoe7obf36v6FkLh2FOKhc1vcKpLAcE3NujmGkU
        AGElzUOkvZQ0b0/PvcrYiKcFTQ==
X-Google-Smtp-Source: ABdhPJwsaTtZYXKiN4quxJ4tzCQha7i8BPchElKOd3en3ff3OSk7pG/77Ovg0c9R34pvM4YsriVjhA==
X-Received: by 2002:a17:903:4101:b029:12d:6318:6226 with SMTP id r1-20020a1709034101b029012d63186226mr5601156pld.8.1629261038930;
        Tue, 17 Aug 2021 21:30:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y5sm4998163pgs.27.2021.08.17.21.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 21:30:38 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] USB: EHCI: Add register array bounds to HCS ports
Date:   Tue, 17 Aug 2021 21:30:32 -0700
Message-Id: <20210818043035.1308062-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=714; h=from:subject; bh=gAZBA/dZMYNBvc+aJ1p1+ilMGGcRI9fgz97TIxYfSJw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHIzp9ZEAsN6oHOIuutYwg2OQxH7kmBw4WprGR96W TR5ELHSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyM6QAKCRCJcvTf3G3AJlWDD/ 0ZnrXjglcHMcCrFnazmWm3XRbajDPcRWtyCYemldv5kCEDC7Yhxrz8ouoLpM1TIUPfGk9S1kKqNwZU ttqIU9//EVeda2hrcDCV6RuuuOFhdMDU9SRpjwNYbuC46Qr1HoLlhBf5CGEwodNZ2nmCbkzpUXGAU0 ru10H2fLTIYtj3LWG71+bqhbPpu+R6MiTS1mw+G4z6aR+FFBgN3XAJFhML+nIst54zd/ilkhIJMDBN jJPDUXUvlVSiduNap3Wu5oCs/4WcLcj/a6BZ+QaiJTzB0S8NBPdI/RALe6QUscMjda6PCN0HBQ76tD Jjz2ZErujVzW60ugo5EXVsLRNrPE4NfcPS0oIlFjuBsIky9jXTFwEosm16e9u/RI907TYK+5UsEbx/ AGwsZ9aRF6Sd+hdWyaq3o6813KedX4tfhq0JPMVHF16VzNqEDP3MFwDaOkN2AhBPcbknlLvlrZTGCd XIrbW3IVJLYIUp7WKV4HOgXpQKRjWjSDgs4Z5l01G/+67Vk+q3DWZQd1ngBSN9h+YODdiKhXc9CHwT evJo1DkjGAxp9X+MfbeWzt1msdEnQBSulZpce5UN5U7buH+YLftsxHN/x3omJw7sBw+B4eagLsNxOh eBB1nwNxR1MfQn9rezy3pzi8lTunkDWeckdxixa5rmq5rf0TunEMXaJdEttA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

This is cleaning up some of the remaining things to be able to apply
-Warray-bounds and -Wzero-length-bounds globally. Only after doing my
own version of the port_status patch did I find Arnd's earlier
patches, including for the weird Broadcom stuff[1].

Anyway, here's what I got. :) No binary differences.

-Kees

[1] https://lore.kernel.org/lkml/20200527134320.869042-1-arnd@arndb.de/#t

Kees Cook (2):
  USB: EHCI: Add register array bounds to HCS ports
  USB: EHCI: Add alias for Broadcom INSNREG

 drivers/usb/host/ehci-brcm.c | 11 +++++------
 include/linux/usb/ehci_def.h | 38 ++++++++++++++++++++++++------------
 2 files changed, 31 insertions(+), 18 deletions(-)

-- 
2.30.2

