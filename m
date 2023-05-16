Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A392FC77B75
	for <linux-hardening@archiver.kernel.org>; Tue, 16 May 2023 18:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjEPSRi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 May 2023 14:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjEPSRh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 May 2023 14:17:37 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365342698
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 11:17:36 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64ab2a37812so7583692b3a.1
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 11:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684261055; x=1686853055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mVGlZG/MsCBdLJd2sTiRj1iau7qUMDFbzDbgKuSoeJk=;
        b=ZvUaPoW1tNREXA/x7esl2fAth6spH/jZRVs+3e57PARRioaHy133wPC/YhfTi0y9IS
         2/brY2FonnUA5mZkHLShr/c1Odj4FLb7j+40yhTB1NsPFl1mlmKdUOzfYretYrgK8lLg
         bbJ3sz1eXLk4NVgtLq59WVUAw9q8HBBGOsI0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684261055; x=1686853055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVGlZG/MsCBdLJd2sTiRj1iau7qUMDFbzDbgKuSoeJk=;
        b=Xixobn9iZ4c1lCtwawRjxkUFkiyF/fPgF5nDy7hcqrM8gt0jZ40IBsVPKP7IHMG3it
         Zdb5aL6L4TElGAzNsghVsRMfCym86jrX64oAnk+GWJ0BYXJfhvwgxpgrW2SSVkZqnsTJ
         TsFXYeI5NfAloec8xL7nTDoE7alx9tA7BDSKBO4vHOhXSpLl8Zod64IghzUrhhFSoO7R
         DOwC0szhFW6E9CVRVPG5mP0B/ydt2Lo/rjv4Up439DrqPCAYoyU5aiOg6miKjsv3+kW0
         b326fFToChFbVv7/Wg+ctst/92uxnIwxfI35DJaxMbeq/WzExT9ZeGWXVtXan7a+qtju
         WTYQ==
X-Gm-Message-State: AC+VfDzsUi8O49uUwygE385Q+0fQcQ8tE++SWB9AHx5qeWUFFJL+08JY
        x45ARoO1H/Qri6JQ9ruGzp8WVg==
X-Google-Smtp-Source: ACHHUZ50ScF5EAXkcZGqiyKtShaHoMMUuBbnpLJjsP2+5r+0M7xt3KRRAGexoPIzyUdoh+x2t5QywA==
X-Received: by 2002:a05:6a21:99aa:b0:100:b7b5:ca34 with SMTP id ve42-20020a056a2199aa00b00100b7b5ca34mr35340311pzb.13.1684261055727;
        Tue, 16 May 2023 11:17:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l22-20020a17090a3f1600b0024e11f31012sm11911pjc.5.2023.05.16.11.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 11:17:35 -0700 (PDT)
Date:   Tue, 16 May 2023 11:17:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: qla4xxx: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305161117.F3FBC0C7@keescook>
References: <20230516025355.2835898-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516025355.2835898-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 16, 2023 at 02:53:55AM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
