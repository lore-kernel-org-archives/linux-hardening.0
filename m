Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95622C77B75
	for <linux-hardening@archiver.kernel.org>; Mon, 15 May 2023 18:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242982AbjEOSDe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 15 May 2023 14:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243251AbjEOSDJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 15 May 2023 14:03:09 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAEA16420
        for <linux-hardening@vger.kernel.org>; Mon, 15 May 2023 11:00:44 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1929818d7faso73456029fac.0
        for <linux-hardening@vger.kernel.org>; Mon, 15 May 2023 11:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684173638; x=1686765638;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0mSaHf0z4H/25tkQER9uB8ytIeulJA6BHDHaGGeScc8=;
        b=W4umkPDOYnX9LBbSIbjR8NqLV96FNNnGrKovk6clhtH+Ob6vVA/thEAIOGKBeslT+4
         WbszT7aF4iGAuXxwF5unWu7UYp5nHO9D4r+3KjLgw+V2B74+eq8A+dWlhcpphfH1hErU
         iXjlu0t5F+2kbJyT4RCcD3e68fxYU1/GUD9LU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684173638; x=1686765638;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0mSaHf0z4H/25tkQER9uB8ytIeulJA6BHDHaGGeScc8=;
        b=ilcSb4OiyvAnpcpl04BUHM1NvfzSuqSu5ISG7TF9CgpL/GDAyPfoRaSXWs7IWdEq4W
         4HsIoZ9F2fLH//ZQzbYT6PgWlgK6bRhI6j4aHE82CUoM+ePQOnuaqos4Hz2pQY8ScsEN
         xo+FN8EqXd9dKJfdXMMPs+t/+7KHXdncgWVjUblfN8hHqF8SHdNfXbtvUTEjtk7RAFdD
         R9dORCPsWoyk3im3fCPV5EH7B/p7Uwc5g0nfq8G2vAm+L3XwC1sqCntolXqq4NBZBKOe
         6Ym7Jm6nTTGZlxCHNAuelEV/fsY+j99hI8p5TkIozROXJrIgsmc23ORhi7rwEzmJrpcd
         vDpg==
X-Gm-Message-State: AC+VfDxj5AKDPW1w2jaclYbKoji5PN7m43ge6NsBnN1gEEvToWsEAlbp
        ovLvcf2TmfjL9PN2AvwMjKTycUzgGIZ+hZZUt5n/Wg==
X-Google-Smtp-Source: ACHHUZ5ScY8TBqNcKrDXAoJzX4Fpk+Nh7sNbnwOLqmyOSrrnlSNwpiIoHeOyML3P8/0oaJ0S1WSTakp1dUEkzwA5B5o=
X-Received: by 2002:aca:d885:0:b0:394:441a:6de7 with SMTP id
 p127-20020acad885000000b00394441a6de7mr8548261oig.12.1684173638588; Mon, 15
 May 2023 11:00:38 -0700 (PDT)
MIME-Version: 1.0
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Mon, 15 May 2023 11:00:27 -0700
Message-ID: <CABi2SkXjN+5iFoBhxk71t3cmunTk-s=rB4T7qo0UQRh17s49PQ@mail.gmail.com>
Subject: mprotect outbound check.
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
        Jorge Lucangeli Obes <jorgelo@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Noticed there is a slight change for mprotect between 6.1 and 6.4 RC1

For example:
Consider the case below:
1 mmap(0x5000000, PAGE_SIZE,  ...)
2 mprotect(0x5000000, PAGE_SIZE*4, ...)

in 6.1 and before, 2 will fail, and in 6.4 RC1, it will pass.

I know that munmap will accept out-of-bound cases like this (because
memory is freed anyway).

Is this change intentional ?

Thanks!
Best regards,
-Jeff
