Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08821C4332F
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Nov 2022 17:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242404AbiKRRAU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 18 Nov 2022 12:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242398AbiKRRAT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 18 Nov 2022 12:00:19 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A6087A60
        for <linux-hardening@vger.kernel.org>; Fri, 18 Nov 2022 09:00:18 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id k7so5075613pll.6
        for <linux-hardening@vger.kernel.org>; Fri, 18 Nov 2022 09:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/TThN9EjghGiN/tuFc6wPX6GqaW/hzqaujSE2kp1eBs=;
        b=eygPz9dT5zVZTbgpWAHY1wME0OfRDovtVRGYQqwVShoGa80yBlHlieQFim7CsakxqX
         fDMll4oHXXBUP6E8waKvG83ciP3NU2XiVtAoPF6EpTNOPJ3OJMVfWHhacPuaIwYVQwug
         kuHuEDxaPmOPnanz4g5nBvSVTTchZje4v4pjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/TThN9EjghGiN/tuFc6wPX6GqaW/hzqaujSE2kp1eBs=;
        b=S/bcyBzSBMtpTk7spB3iBMACBiXkv+fsBVvh8GJ+8MQOD7GkrF0e4at8BHdqgCdO6l
         SqQ010OGOlO8mgBD0FXKdkRi0kjzgEfbx4V5fWsOuaKiG41ZMFWpfsZYkvn8KmTsojJ3
         sgxA8NcR3MZ7ddtsgflJgDy8rzTDdssPHrL7tGz/l4ccV8qDjS2P44cDAL3++DozTifH
         jqtN/GLSIlHvUNyH2Vye3z+A2wV36LsL2uy8hzVjceQAz5WGOy+t5zsD34JcqDvgWH2F
         WT8/FvLtgGl5Fk7mtuVAohZmZ7PGyALYVtuaYX7Ba923VIBhysLiB7jUgEhDnEecmsNj
         XrUg==
X-Gm-Message-State: ANoB5pkY+b+mz5akMmSF9/mnPeK0DT6nrgsFpFVR4MByh/APWtFDAkTs
        nIRdmlSbvV2pUTXntP6setzSnA==
X-Google-Smtp-Source: AA0mqf5QvHv11UC9twhA6JD4pceg2EobzmHdMqKKh3Naitc4xc3SRR7TJucJpCtXoSecmx9CZqphkw==
X-Received: by 2002:a17:90a:294f:b0:213:d04:7529 with SMTP id x15-20020a17090a294f00b002130d047529mr14331588pjf.181.1668790817961;
        Fri, 18 Nov 2022 09:00:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d17-20020a170903231100b00178b77b7e71sm475429plh.188.2022.11.18.09.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 09:00:17 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Fri, 18 Nov 2022 09:00:16 -0800
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: encode_cb_recallany4args(): Error handling issues
Message-ID: <202211180900.6F94436@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221118 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Thu Nov 17 11:55:28 2022 -0500
    32dce0f9611b ("NFSD: add support for sending CB_RECALL_ANY")

Coverity reported the following:

*** CID 1527365:  Error handling issues  (CHECKED_RETURN)
fs/nfsd/nfs4callback.c:344 in encode_cb_recallany4args()
338      */
339     static void
340     encode_cb_recallany4args(struct xdr_stream *xdr,
341     	struct nfs4_cb_compound_hdr *hdr, struct nfsd4_cb_recall_any *ra)
342     {
343     	encode_nfs_cb_opnum4(xdr, OP_CB_RECALL_ANY);
vvv     CID 1527365:  Error handling issues  (CHECKED_RETURN)
vvv     Calling "xdr_stream_encode_u32" without checking return value (as is done elsewhere 23 out of 24 times).
344     	xdr_stream_encode_u32(xdr, ra->ra_keep);
345     	xdr_stream_encode_uint32_array(xdr, ra->ra_bmval,
346     				       ARRAY_SIZE(ra->ra_bmval));
347     	hdr->nops++;
348     }
349

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527365 ("Error handling issues")
Fixes: 32dce0f9611b ("NFSD: add support for sending CB_RECALL_ANY")

Thanks for your attention!

-- 
Coverity-bot
