Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B260ECAAA1
	for <linux-hardening@archiver.kernel.org>; Tue, 30 Aug 2022 20:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiH3Ux1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 Aug 2022 16:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiH3Ux0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 Aug 2022 16:53:26 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380158606B
        for <linux-hardening@vger.kernel.org>; Tue, 30 Aug 2022 13:53:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33e1114437fso188416507b3.19
        for <linux-hardening@vger.kernel.org>; Tue, 30 Aug 2022 13:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc;
        bh=y+bRnMssrUj/6kbuuva6fXkHo2MrxrsD3o5Kbak+NiU=;
        b=eZwlVRJt892OWPFcvi3mSbbvEI013rOlwJ8QFYrdL6uKjYm2rCWX6K68pF3YCAeqiZ
         qgvPewGSY4+Gp/tXYr2XcFTkyewTDkv/8WPDwyCYAD678FgT1G45MEEmFFJsHyGNo9li
         M170u06nyQlYu659TVabIgtvqCDsqX5PyIVvdS8qYxzp8EvC5H38brNE3E2jYm5bePYx
         6UFwdh9z2Trb+JL9+RtcuaWjK7YLGRcbursv/mRBHLd5869bB7MYcP01QIc+7YNKXGp/
         2sr6/L9MsXDF55j4skMQAOaraXUefeIGVU7QPhKNyLAlR6x3dVZnNX+Bl2b88eQw/2FQ
         FaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc;
        bh=y+bRnMssrUj/6kbuuva6fXkHo2MrxrsD3o5Kbak+NiU=;
        b=zQZMU/xfWTTaspoYgfaoe6o6hO0k/BfphN1uo1Jm3vgpMYHeYxB0OWnyH7sbb2219n
         Hfyq4w/xTzR55nGEh3jyWlH8y+1/+GzGTzfSsARwZI9wQWMaYeBrbXCK9VfIuH4YcUnv
         mZGZoa/SeuPA6OI9bPaAaIuyJxzqUaAedxr8YTU2t9h2Xl4MRVFI0DLZrbGrpRUvPY5Y
         YqSTEEmB/AsvqZNhCvYwD3yUft4BDdBZihYM+6RJKfYzysv33BmbtLz8ujxTwumX1wFX
         yKKT/mSBN7pjvfSlEixU1mBUHWhtktF+LwgdYbcD7sIkxpDtyptiOfnm3rqinQdadbf6
         LRig==
X-Gm-Message-State: ACgBeo1vUchKsjh49k/oEexQGtizul/4NsabodDoxoSQwpXaimoyMPDK
        2TMtDkKxGIL+egSYutV7dEH57KZuhcAKiKg35TY=
X-Google-Smtp-Source: AA6agR6LzzDTJp8/LLgR2tYJHvqNLA1ncTKB/GwiQ/kK5y2JZRXJnpE70VKmyZAmXfDvIzDo4To3MyuHVPeXGdtOKfg=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:0:100e:712:422b:cadb:302a:7901])
 (user=ndesaulniers job=sendgmr) by 2002:a25:7cc2:0:b0:677:5a84:9f79 with SMTP
 id x185-20020a257cc2000000b006775a849f79mr13577501ybc.518.1661892802516; Tue,
 30 Aug 2022 13:53:22 -0700 (PDT)
Date:   Tue, 30 Aug 2022 13:53:06 -0700
Mime-Version: 1.0
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1661892789; l=1211;
 i=ndesaulniers@google.com; s=20211004; h=from:subject; bh=zURt4cRkM9uRF4OuY2wV5cBpIhomPe0G2hadM5Q8amw=;
 b=bLH7JZthL0TsoZymjEI/Nxr8slOa9cg2x+NNHCAC3iV2z7Bk+diYAGjVVEJBHUWsrjvF7VXLCwc/
 a59b5uZjDMXpquiHqECzSVTdCS/k6DqsZi5T4Q7d/+nLj6TzLaa5
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830205309.312864-1-ndesaulniers@google.com>
Subject: [PATCH 0/3] Fix FORTIFY=y UBSAN_LOCAL_BOUNDS=y
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

With CONFIG_FORTIFY=y and CONFIG_UBSAN_LOCAL_BOUNDS=y enabled, we
observe a runtime panic while running Android's Compatibility Test
Suite's (CTS) android.hardware.input.cts.tests.  This is stemming from a
strlen() call in hidinput_allocate().

__builtin_object_size(str, 0 or 1) has interesting behavior for C
strings when str is runtime dependent, and all possible values are known
at compile time; it evaluates to the maximum of those sizes. This causes
UBSAN_LOCAL_BOUNDS to insert faults for the smaller values, which we
trip at runtime.

Patch 1 adds a KCONFIG version check for __builtin_dynamic_object_size,
and uses that in __compiletime_strlen rather than __builtin_object_size.
Patch 2 and 3 are cosmetic cleanups, they're not as important to me as
patch 1 is.

Nick Desaulniers (3):
  fortify: use __builtin_dynamic_object_size in __compiletime_strlen
  fortify: cosmetic cleanups to __compiletime_strlen
  HID: avoid runtime call to strlen

 drivers/hid/hid-input.c        | 13 ++++++++++++-
 include/linux/fortify-string.h | 15 ++++++++++-----
 init/Kconfig                   |  3 +++
 3 files changed, 25 insertions(+), 6 deletions(-)

-- 
2.37.2.672.g94769d06f0-goog

