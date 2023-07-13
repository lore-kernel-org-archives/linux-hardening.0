Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDBFC0015E
	for <linux-hardening@archiver.kernel.org>; Thu, 13 Jul 2023 17:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjGMRhP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 13 Jul 2023 13:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjGMRhO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 13 Jul 2023 13:37:14 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68D3193
        for <linux-hardening@vger.kernel.org>; Thu, 13 Jul 2023 10:37:13 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-55adfa61199so801297a12.2
        for <linux-hardening@vger.kernel.org>; Thu, 13 Jul 2023 10:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689269833; x=1691861833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YizuHrmtzvKQs4n7NHgt61z/8NdjxTzrnZuplMNbtlI=;
        b=norcP0Cwdiyd7BTffnvetZ7gS5v7Xwv5KIJJmblhcf1bAGTdNZAylZasG3tD3gImG3
         rlDzf2c5YfBTyaIVZCOgptPXL8Ku+qXc99V7i3wsoIBsL83brkUTLkMJJnypPjw3fltR
         BulPr0Nmo+FcF5e161D1VDLnNdytDHp6JCKsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689269833; x=1691861833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YizuHrmtzvKQs4n7NHgt61z/8NdjxTzrnZuplMNbtlI=;
        b=HoDiVvOn0ALGh/yYEOGDR21FA6a5YbaaLUZwlcFbmKJVbrf/2i1YWYHW/velfs2Eof
         rXp+xYdB6fZZVhHJnxmnw9WTEAYwXk9q8a2sSslmObxiwO6omIO0zk+IAxJOyBE2GqfF
         lyCSF4V2GOammwI4WZZ0F/gnolPDkyu/Phvwvp2Luj6oHT1SfMiQyiXcUVhZ34WZe0KL
         TNyJPE2ZN9G/zfnRpnh1M04TMptez/Wm6C/MEFgQuuSaayeZ8l0IsoelV+vC3mN47iYI
         FLE/MZ/Z7ZhSRjTaP3CXuNljCJqQ5vRnNgmJ9t5UQ4E9CQFcI683P/LhjdHYse2032vQ
         2QWA==
X-Gm-Message-State: ABy/qLZeqhsv4EG6V4Vo0irZNOa3vxIkjqilu5iDbi8IkdARByd91kbY
        lWMd3nBcekqytc9Ho5pmKx/k1w==
X-Google-Smtp-Source: APBJJlGkv3uwaU1SUgu1y/MkYZvbEXWW48kaE62WRE0ASP2/aIXBEpuDa2smk8F8qvdR6N7C9sg2zQ==
X-Received: by 2002:a17:90a:13c6:b0:262:cef9:84f6 with SMTP id s6-20020a17090a13c600b00262cef984f6mr1793285pjf.22.1689269832985;
        Thu, 13 Jul 2023 10:37:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gp11-20020a17090adf0b00b00263a985abc0sm5790509pjb.26.2023.07.13.10.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 10:37:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v3 0/2] pstore: Replace crypto API compression with zlib calls
Date:   Thu, 13 Jul 2023 10:37:06 -0700
Message-Id: <168926982309.199014.17782001136753188986.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712162332.2670437-1-ardb@kernel.org>
References: <20230712162332.2670437-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


On Wed, 12 Jul 2023 18:23:30 +0200, Ard Biesheuvel wrote:
> The pstore layer implements support for compression of kernel log
> output, using a variety of compression algorithms provided by the
> [deprecated] crypto API 'comp' interface.
> 
> This appears to have been somebody's pet project rather than a solution
> to a real problem: the original deflate compression is reasonably fast,
> compresses well and is comparatively small in terms of code footprint,
> and so the flexibility that the crypto API integration provides does
> little more than complicate the code for no reason.
> 
> [...]

Applied, thanks!

[1/2] pstore: Remove worst-case compression size logic
      https://git.kernel.org/kees/c/32a9ef435140
[2/2] pstore: Replace crypto API compression with zlib_deflate library calls
      https://git.kernel.org/kees/c/efe5be6664c8

Best regards,
-- 
Kees Cook

