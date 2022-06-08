Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01FFC43334
	for <linux-hardening@archiver.kernel.org>; Wed,  8 Jun 2022 21:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbiFHVzf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 8 Jun 2022 17:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiFHVzX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 8 Jun 2022 17:55:23 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E66B7CDD4
        for <linux-hardening@vger.kernel.org>; Wed,  8 Jun 2022 14:55:22 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 184so4193697pga.12
        for <linux-hardening@vger.kernel.org>; Wed, 08 Jun 2022 14:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i2/HJgDqRDHXAhrIe7TZ9shX61z2rlEjxsD3obCuJ0E=;
        b=ejbY6kyD3PSAfn4o6MBIcMmgCoa1837lvHWM8ePC4GkL3+8R2AFavhErB7/VForpjE
         K/YUPyjTRqUIhxkV/UTI5UNBph+6AW9bPmKyBYKkuYcWu1XGcRdZDkHZIFHN20iBgdN2
         WSdaFovpKgJbtLMNiOxNCd55mAqGwYJIGKbOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i2/HJgDqRDHXAhrIe7TZ9shX61z2rlEjxsD3obCuJ0E=;
        b=FkFNww2je3TN5lpiB7cfUvAs84JhSg8jCIucx5OdDpO0848QZL6JQQFbccux7RUSXN
         GEKMfUd6UT0r9ce9hKmeyYtH8NifF9+NgDkJm2ZW2cAJGnVGFWtiQf2l7bTx2isagMan
         AoEf1iUQfpqI2B/c4oOq7Ai3np8ADHM4zJSDHvz62RmtK/WcjAxKmxfPJ3Ar+v819i9g
         d2DQjKSsGLrc2RwUiA4ZzNvk4Zq7lN1p6+JjOoJdtCjBoHo0ECaVV1iZZbhsoQz7CHLg
         Eqy14cU8JxhY83yPnfPKdU+e9EvU2ygNzUzqB9Sv7cbFYSbZBb/WrCMjKj99d/a74Iiq
         SKoQ==
X-Gm-Message-State: AOAM533Ct/D280daoi9+AUZw0JS7TZwflL8BdwuRQEFLVvRrYuxUoZa6
        7IAj2ma0QOYXfevTCVeJ8753mw==
X-Google-Smtp-Source: ABdhPJwmcQP/V/A6NseoG5p6/7bTbJ1nh2EFKIeMOTx6qt3s5kMt1TYadcXm7a+6BngixHm1nZoe+w==
X-Received: by 2002:aa7:88cb:0:b0:51c:2627:2c03 with SMTP id k11-20020aa788cb000000b0051c26272c03mr15619435pff.63.1654725322108;
        Wed, 08 Jun 2022 14:55:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bb7-20020a170902bc8700b001624dab05edsm15267933plb.8.2022.06.08.14.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 14:55:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-staging@lists.linux.dev,
        Michael Straube <straube.linux@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: Allocate full pwep structure
Date:   Wed,  8 Jun 2022 14:55:12 -0700
Message-Id: <20220608215512.1070847-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2117; h=from:subject; bh=AJyFIcbZJ1VPa60rPAfpXrSfjpsVRY++wQL7sKxkSIs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBioRq/p9rUe3uakqjDsXLSrG6bN4JGNIi1/jqtyJ9S YeUxJB2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYqEavwAKCRCJcvTf3G3AJjv9EA CN+BAlk7IeNRH5Xzhqd2l1F/BaSob6xpZ5ghIS+ICCSkS9tKSEF0AH5EZAxcdeFN5nKvpiWl9AvOK/ dbCQWIY7PTZW9chMQP8Aw8dpcpXsJYbPbK56FK6IhV8Xsq5DtT/dFDvVSZj/nTGi9sQ4KONGkPPQ0k Jxq/umgCsCtf9QbTbsbeQifPgRSk+FzDJ1cxJ1AhXg4FKaasmp2SeZAXZe37xwMlBGbmkeDN1bUzuB uauU8ewCEZyRa/QkqHwu6A45Oh2Dh83TEtEB0RwWx++vQ89aSHnW78/gQokipVv68JAJ6PjyDMOSjX VK5kXHp6osYrugnA/CSffNDMNtP5lpfyRDQqRzgFBDCLQx0bEXLFiZWWmT76tqGr8c80PapjppaSCN SHomD2lF752k7SiEywXCPO9Yu51OKt/fzCSteuZMiXobQdTjvtFqVtzw6/43OY7TAFW01KwywtfYPE 1z8yFpGFGAoEkcTIu2ncd+E0Ao3H8WaOtM2UuL2NSAtEYjFxtH82rIQu67SXEDWb1gLspuo7kRyIQc +Z0BqItix1wfAiqjV242Xsvo7+F3p8d0FjT589slKeF2/S6UJV0l5XjAHcTdrDLCx2eQYeFBTEWYMx 72T95eNzAojimU9JssAylVWMVQnbbk78/uRoWiJaF96wQg/ls/vNJO56Zp0Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The pwep allocation was always being allocated smaller than the true
structure size. Avoid this by always allocating the full structure.
Found with GCC 12 and -Warray-bounds:

../drivers/staging/rtl8723bs/os_dep/ioctl_linux.c: In function 'rtw_set_encryption':
../drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:591:29: warning: array subscript 'struct ndis_802_11_wep[0]' is partly outside array bounds of 'void[25]' [-Warray-bounds]
  591 |                         pwep->length = wep_total_len;
      |                             ^~

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index ece97e37ac91..30374a820496 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -90,7 +90,8 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, key_material);
-			pwep = kzalloc(wep_total_len, GFP_KERNEL);
+			/* Allocate a full structure to avoid potentially running off the end. */
+			pwep = kzalloc(sizeof(*pwep), GFP_KERNEL);
 			if (!pwep) {
 				ret = -ENOMEM;
 				goto exit;
@@ -582,7 +583,8 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, key_material);
-			pwep = kzalloc(wep_total_len, GFP_KERNEL);
+			/* Allocate a full structure to avoid potentially running off the end. */
+			pwep = kzalloc(sizeof(*pwep), GFP_KERNEL);
 			if (!pwep)
 				goto exit;
 
-- 
2.32.0

