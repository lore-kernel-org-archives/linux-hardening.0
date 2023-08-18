Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C808EC3DA66
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Aug 2023 01:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356815AbjHRBQY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Aug 2023 21:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356867AbjHRBQH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Aug 2023 21:16:07 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA05421B
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 18:15:24 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-565f8b23151so84318a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 18:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692321310; x=1692926110;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0OZI4NJnVebNM6+xyzwnKsD1iMAOA59kDaPSqooa2s=;
        b=o63LFo902MW3jOMihEhTthkAapz32a8B14io7B4LRVjqDuG13Ue5OxpXnJBUZGVnyG
         03RA88lMAR6UKQX8vGB8lj0F+tLePgx5ynoUORrZAD4gY//TsVr38UUC9Z3rpPKj8JQ4
         Lt2gngGzRIE7p0mXq4yTNP2tRoTWKjfs0Ncp8lPvTnaz0WT/ZRucUlCIWeutorLT8uQS
         YqzndBepB4nOWt85vsREbBi/5VuL0m95ikk1N4tNtynrlrEixZ9SCMAXKFQmAx4trnWQ
         BH8LNsc/8cHblRZ8LRtHSkm+6meWhuMs/a63NmbNMPyKyf2OWcfJV3u9ElV1sOOWVXqt
         urfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692321310; x=1692926110;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0OZI4NJnVebNM6+xyzwnKsD1iMAOA59kDaPSqooa2s=;
        b=GKx4HHc9ssC6H5oqVwFnfFn1S1xL+h87aBfoeF6q/H7tpr8iBiEPnxuQGDnDwApR+B
         zwZu3ES/cUoM7bEloO4mySxlQRhB/PEw1hj6DvXmr0Kt3yiLWuhFZ1Kp8P57Z+OwvIBm
         FCIEUm6Pb+qfaYTOa0/+lyjRWoNASIoOJppB6YNiiWizRVv44mztkV5zNLOxUiyiLEv/
         LcY7Q0xEgDrYHPXrHyVLo/T43iwbCcyhu5F8HPJaEvL+vgTIfl1117NsPDlJhUGN+BBq
         JPSokjKqQPdlv2xfHvmX2U+khSnKuzZNmXKuiXwWO9c5wUBge5a8skqzoA9jUapTmbo2
         WXDw==
X-Gm-Message-State: AOJu0YwCICj5dlrezmcQeiOTmNyTNuJ4J5DoNucTLsTHTDra5PvQBb62
        XA7J4v0D3HcYuBo9cHieen7vJw==
X-Google-Smtp-Source: AGHT+IGQubHAAfLcM9gFxNKvlfXNaq4wEeNmXlj6d+JqwuLxwHoSVzghFX4bWwVbT5cYfcDW4zVlnQ==
X-Received: by 2002:a05:6a00:1d85:b0:681:9fe0:b543 with SMTP id z5-20020a056a001d8500b006819fe0b543mr1234120pfw.2.1692321310699;
        Thu, 17 Aug 2023 18:15:10 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j12-20020aa7800c000000b0068842ebfd10sm358490pfi.160.2023.08.17.18.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 18:15:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Kees Cook <keescook@chromium.org>
Cc:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
In-Reply-To: <20230817212146.never.853-kees@kernel.org>
References: <20230817212146.never.853-kees@kernel.org>
Subject: Re: [PATCH] io_uring/rsrc: Annotate struct io_mapped_ubuf with
 __counted_by
Message-Id: <169232130924.700993.10043093294166679219.b4-ty@kernel.dk>
Date:   Thu, 17 Aug 2023 19:15:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


On Thu, 17 Aug 2023 14:21:47 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct io_mapped_ubuf.
> 
> [...]

Applied, thanks!

[1/1] io_uring/rsrc: Annotate struct io_mapped_ubuf with __counted_by
      commit: 04d9244c9420db33149608a566399176d57690f8

Best regards,
-- 
Jens Axboe



