Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B19CD37A7
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 19:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbjIOTng (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 15:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237120AbjIOTn3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 15:43:29 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096AC1FDE
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 12:43:24 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c35ee3b0d2so20173085ad.2
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 12:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694807003; x=1695411803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a6+sswFsC9jOA36RIWjPp2T/q8ZGAafBXoclkZefwbQ=;
        b=dqgnotqsnYIi5a/HnQxT9yvJWcsPXKoTbdz0zQ3erVMxfsBwebSvRgePUHaxdRP9Dz
         KfQ0n7hYc3yYHXxFyXoZealbfy6yqIvjIgqvwo04TTk1aSNEWRyjF9Dm3NCMBFRmy9S1
         yPYcNbfRDsJiH8qwyEiwdiE10W3CaKo8drpaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694807003; x=1695411803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6+sswFsC9jOA36RIWjPp2T/q8ZGAafBXoclkZefwbQ=;
        b=OOJJiA1UMAXSOZOgu9ddiq595M4jueB+kedFgKgtXV3a8gm5LknPIjAPwSsrpreFG8
         /RGvtcMMKkl5RIywcNbrJAAoUkXwS3XWVfvpoCb5WAO72Plo98ertk7c2bwqs3G4Bnv1
         nys/pbD8I8niw+PLHnnPEQ7c5EPtJK6u1zy9ijzO3BB+A7e4Q2S/yNxVG7ohp09mwtly
         nzDO2mWGvG3wWQ18fSLqV672FVF5Z07erwzJRHYv9ZBtyd6CG/ItSS+b3X314GczQatH
         247ZPSe4q6q06BnkL9DGhw3ozEv9bYJiAR3g6CZaUHjzvXXso6AkeB/nDa730AHBDbWd
         SO3Q==
X-Gm-Message-State: AOJu0YzA4BA+OKbSK3kck496oimiPgRFWmEWLwMLIsvt2o0lM+krowpF
        1GYNEAVvBzRlq5dwhYp/JCt5XA==
X-Google-Smtp-Source: AGHT+IFSpBH4WxdF3BlGbEDuAyvk2UVoNFNE1yYoSuMa31xAi+uP36IkyDJkx9K3A36VzJvCVoF0AA==
X-Received: by 2002:a17:90a:f3d4:b0:274:6cd3:a533 with SMTP id ha20-20020a17090af3d400b002746cd3a533mr2314769pjb.20.1694807003442;
        Fri, 15 Sep 2023 12:43:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a199700b00267eead2f16sm3640941pji.36.2023.09.15.12.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 12:43:22 -0700 (PDT)
Date:   Fri, 15 Sep 2023 12:43:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Duncan Sands <duncan.sands@free.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] usb: atm: Use size_add() in call to struct_size()
Message-ID: <202309151243.028CC322D@keescook>
References: <ZQSuboEIhvATAdxN@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQSuboEIhvATAdxN@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 15, 2023 at 01:20:14PM -0600, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound,
> the protection that `struct_size()` adds against potential integer
> overflows is defeated. Fix this by hardening call to `struct_size()`
> with `size_add()`.
> 
> Fixes: b626871a7cda ("usb: atm: Use struct_size() helper")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
