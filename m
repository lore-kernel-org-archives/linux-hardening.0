Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC7CC433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Feb 2022 02:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiBJCxW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 9 Feb 2022 21:53:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiBJCxW (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 9 Feb 2022 21:53:22 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECF8240AD
        for <linux-hardening@vger.kernel.org>; Wed,  9 Feb 2022 18:53:24 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id p6so441451plf.10
        for <linux-hardening@vger.kernel.org>; Wed, 09 Feb 2022 18:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H8yuowP1mvnDP9KBlBJhs+EnqVN/L7/OeGc4T0MUUiI=;
        b=g3Y3erdYSib9j/KQ5dVDkf9MH5o6tk7fSy3xi0e7V484U3gvKLCnVzajg8vgMbwvX1
         Jjnrv+KBTSKJQDdGJbzVPu7uadccKPxqe4E2p99bdkQOVJTvNA5AhIBxn1wFhRuK/weP
         9IYh32uj8DKIO1dyV7kxJg9k3xnMFL3G7baZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H8yuowP1mvnDP9KBlBJhs+EnqVN/L7/OeGc4T0MUUiI=;
        b=MNojotyFboNlTHDj2WLy7/CX31VEae59foSXvEOX4ohN6pnA6tgxGwH2ylPA7/RWVF
         QvAviDXxDcJTQYCDM0DcFXlKuehn5N2Q3NWq4ebRgw2okXxfl2lR0lRldSZbgQhHYVjU
         imkfYRixoPmhKCCdX9Ff10Vt2ZtBJ3k1cNumfblYAvxYOSAIsL8pJnVNPGtaO2FOJRkf
         6gh/gWg8fJS0GvVubOQSgv1d4hPZswHScV3LnbEmJceBdCrmEIxB5ONT6VQ2h3N5wRnL
         xu2Oank0lO8pX/sfc1ZaisPIMd0UD4TiC4DepODb7F4ymuiw+rHdFUBnFQiKHdjcgKqX
         tdUQ==
X-Gm-Message-State: AOAM5328sKNir3AOSO/q11Uu0AnRQ5QUzX9GMqx9VS5OvzUUucZrtxo1
        iigO8+AO4bdWsHFvp3WMG9//d6Ux6pYiuw==
X-Google-Smtp-Source: ABdhPJyL8cIqzqClp86dbDBLCDXuzRTYQHVGbS1hWszwpQyFYwKZ3Z+2yLCflwC+36gHOAlNqTd1JQ==
X-Received: by 2002:a17:902:c24d:: with SMTP id 13mr5363988plg.22.1644461603571;
        Wed, 09 Feb 2022 18:53:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i10sm676425pjd.2.2022.02.09.18.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 18:53:23 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Robert=20=C5=9Awi=C4=99cki?= <robert@swiecki.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/3] signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
Date:   Wed,  9 Feb 2022 18:53:18 -0800
Message-Id: <20220210025321.787113-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=907; h=from:subject; bh=hTr0tOO4h3lt/wmDEd+6435u89taCT0sXulysY0LXCw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiBH4gQ43Wy8/NXcOkUg/7VSRgkMgvhZk6QoYYYdXd mO5Dn9eJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgR+IAAKCRCJcvTf3G3AJtu6D/ 9Qs9NPuLfVzVfEw8ZNSLED2BCppQF666ohGTYmyF6E1tkcRI4mFt87GMbc7/B+wLkWc2UcnK+lhCcC XoYNMKZ0e4yh+6EcfHj3UPpOVsMJVImlbfnQe2lzlENx0eUD3Psh/i2MNykflD/nDXYGMeR3i0URVS QtvJz2vXvRFAZNf3PluThlzT1YU6gy+SXSf1UF9y3hFrmLDAVpdfM9mAVlS4Ur1zgIlYKZsUOAqNUg 3NUGZ6cMj1Zaap9Hd+PgMDZW/2b2jbAgwbIFvG1cjqrtH1K0wamutZVA9rHieLCId8m3A9+78e+K4I L7m5SuS48W1jq6TxHhb8YXgPaQDl9uN+67ff8F4hnWXz+zoa0LvkiLwWdxmGE5OG7WoZ0blf+DJx3T z04beNzndFVKYD+rI73h7xQ0UjzsXUeRiyNm73yeSxufBCGEeyHT+zQ3GffJD2IlqIL5oonq6pkP8c q4fW2+5DpUAfkHr7xrCeZKqn2sUJZ9MReYGyoeVHjiyTZx2IMBFER4FDA/tUU9jE6d6QvtbeWM6NzM eGMpWqlVnFnfVkTG27QUfboS+FmB7PYW/4M3Rs7gXL1iwn9xkqbz6F4eDrZI3fBFaQnkzW/MTwmBhk tIS4f3zFRoSi1f+lE7DjclN2KQB3mEOiDP09xXX2C0RJU/ggN8Dov4F7cOOQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

This fixes the signal refactoring to actually kill unkillable processes
when receiving a fatal SIGSYS from seccomp. Thanks to Robert for the
report and Eric for the fix! I've also tweaked seccomp internal a bit to
fail more safely. This was a partial seccomp bypass, in the sense that
SECCOMP_RET_KILL_* didn't kill the process, but it didn't bypass other
aspects of the filters. (i.e. the syscall was still blocked, etc.)

I'll be sending this to Linus after a bit more testing...

Thanks,

-Kees

Kees Cook (3):
  signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
  seccomp: Invalidate seccomp mode to catch death failures
  samples/seccomp: Adjust sample to also provide kill option

 kernel/seccomp.c          | 10 ++++++++++
 kernel/signal.c           |  5 +++--
 samples/seccomp/dropper.c |  9 +++++++--
 3 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.30.2

