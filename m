Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F222FC7EE26
	for <linux-hardening@archiver.kernel.org>; Tue, 23 May 2023 17:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbjEWRaQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 23 May 2023 13:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238331AbjEWRaG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 23 May 2023 13:30:06 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B67189
        for <linux-hardening@vger.kernel.org>; Tue, 23 May 2023 10:29:56 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d1e96c082so22415b3a.1
        for <linux-hardening@vger.kernel.org>; Tue, 23 May 2023 10:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684862996; x=1687454996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nhOVpdiqhCvs7GVV7f2dklwaVtM++uCHQCldPOpHCUk=;
        b=A24777sFuS5neXn2X580FSjNLT8hS3n/fA59VHL1HgoGN4qo+vI1L2wT8WPOK1StqC
         PcNMIz3+z2+2SnzxaOWHjZJNhIlO9GvPIxzUt2GsSAGSw2nIMjGbzqLCnn0lNvkM+zDe
         J17yTm15T4qXNbdDlwznS7hOhy4dWvxpnay5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862996; x=1687454996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhOVpdiqhCvs7GVV7f2dklwaVtM++uCHQCldPOpHCUk=;
        b=HJHntr0r+mamMikF9YYIBh7vbEhjdXjBLKQfLmOgEgCvHRxP9KlxSkk2u9FNatjR8y
         WuGBHbcH7N6YmGZs3isRjR1aHXeMNHyoNKiIP6cksLUie7tzRq9OO59TePBhbG0XrrmX
         fbW3vXT/+dgv4xj7mSuG9AlFl1X8zE+zeYgMCnG0mOl9rQTL1B5yEr9374QWCvCM3Iyp
         udnSks3YJUDys/v/Ez5DVBLIup6345x8W2xYQLXZSbbxao/JxLmEYNQfgyw3yShCcDyX
         w4kVB/zKJiBebiInzC8qZ//KnEMykqT9HdFnCX7W/XkG/4hFFWOfY4qFIISBI286ZjaX
         y5Xw==
X-Gm-Message-State: AC+VfDwNBH2Tr4PG5f5b1jFYwymER7CivHaweK8VYaLnIEOtsOXGVfMx
        xTeFH1V8d1HVDcw+RMicMuco5A==
X-Google-Smtp-Source: ACHHUZ4uuIdgumk1jumRCzlG+a3yry5AfnyGcbp0y8NXoHGyEspOACJ+nTy3VqiD9jcpG3NGGfSDSQ==
X-Received: by 2002:a05:6a20:5482:b0:10b:71c:20c5 with SMTP id i2-20020a056a20548200b0010b071c20c5mr11647062pzk.51.1684862995725;
        Tue, 23 May 2023 10:29:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bs5-20020a632805000000b0051eff0a70d7sm6210358pgb.94.2023.05.23.10.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:29:55 -0700 (PDT)
Date:   Tue, 23 May 2023 10:29:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2][next] vfio/ccw: Replace one-element array with
 flexible-array member
Message-ID: <202305231029.FC995C740F@keescook>
References: <cover.1684805398.git.gustavoars@kernel.org>
 <3c10549ebe1564eade68a2515bde233527376971.1684805398.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c10549ebe1564eade68a2515bde233527376971.1684805398.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 22, 2023 at 07:35:12PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct vfio_ccw_parent and refactor the the rest of the code
> accordingly.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/297
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
