Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E129C32771
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Sep 2022 02:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiI0CbC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 22:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiI0CbB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 22:31:01 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F493D5772
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 19:30:59 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f193so8226774pgc.0
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 19:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=A415gP/CRCjugI919Jgs4A7RjNMw5l2C7zh5BSt6/9c=;
        b=cw1mNAoz6pNqX9M9TacTMaWM7ZPCbyB8Mb9RNo7yXHBX9IKQGVa/41aGSh5SNA6ReX
         rlJ5CyiLsludHGviO+mcCHmKxOv/8lplcVMUt36CtQJX4wiVF2N1YfBw0fLcmU6PXtIB
         vy23Ig8jYsSrL0qGNTlVykrfFGMrYNkRW5iF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=A415gP/CRCjugI919Jgs4A7RjNMw5l2C7zh5BSt6/9c=;
        b=a9d9/73SEgPwQXuQNfn98ALi6bqpdSQxb1rpGc0o4/bjC1sL6jAEeY1blNFfeR8vvR
         3WnBRbsKu5WZ98sBpJvepFVEQJXlPMsXHpK09G0X/xwtMxW1PW+8ukxNoqYjodl3Xfnc
         efpQuHFuObq4Oki/njYeHNvBtb5aXZUxMpDyp1Pit5Bv7yIWTNxgbJRwkD76cVnASo4U
         E7BVRXKb8BDVCyY+4g/EBhz8FGkX5xZrnxCnxYWi1C+rCuFJ/NrJVUKPDi3D+JinfMVf
         7sDm78Q4uxQT1Yqwt9y1tJWEhov+q1SuqQgbGZn/ZqTYBWV+uNsRp5WmqJxZW0PLVsaD
         PuqA==
X-Gm-Message-State: ACrzQf08rYj7IUUxpX4qvZdjG+eeUKpRSelGbiOOqTPOOH4XgQApDN9C
        y1OgU02zJcRiUS+9h3Ikd+IpCg==
X-Google-Smtp-Source: AMsMyM6AY2+tFrwQWLzXm+PKLmT1J0IOCatxxUFW3+DUfSmE3r+tA8R98tAzBB0w523VWRgHKThzyw==
X-Received: by 2002:a63:b957:0:b0:434:c30d:84b0 with SMTP id v23-20020a63b957000000b00434c30d84b0mr23027587pgo.293.1664245858318;
        Mon, 26 Sep 2022 19:30:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902ce8b00b0016ed20eacd2sm144134plg.150.2022.09.26.19.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 19:30:57 -0700 (PDT)
Date:   Mon, 26 Sep 2022 19:30:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] soc: qcom: smd-rpm: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261930.A34FE7B@keescook>
References: <YzIvNIyPhWaG2DTr@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIvNIyPhWaG2DTr@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 26, 2022 at 06:01:08PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/224
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
